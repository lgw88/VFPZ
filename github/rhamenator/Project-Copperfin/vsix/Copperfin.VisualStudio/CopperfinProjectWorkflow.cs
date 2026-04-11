using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Copperfin.VisualStudio;

internal enum CopperfinProjectOperation
{
    Build,
    Run,
    Debug
}

internal sealed class CopperfinProjectExecutionResult
{
    public bool Success { get; set; }
    public string Message { get; set; } = string.Empty;
    public string ProjectPath { get; set; } = string.Empty;
    public string OutputDirectory { get; set; } = string.Empty;
    public string LauncherPath { get; set; } = string.Empty;
    public string DebugManifestPath { get; set; } = string.Empty;
    public int ExitCode { get; set; }
    public string StandardOutput { get; set; } = string.Empty;
    public string StandardError { get; set; } = string.Empty;
}

internal sealed class CopperfinProcessExecutionResult
{
    public int ExitCode { get; set; }
    public string StandardOutput { get; set; } = string.Empty;
    public string StandardError { get; set; } = string.Empty;
    public Dictionary<string, string> Values { get; } = new(StringComparer.OrdinalIgnoreCase);
}

internal static class CopperfinProjectWorkflow
{
    private const string RepoBuildHostPath = @"E:\Project-Copperfin\build\Release\copperfin_build_host.exe";
    private const string RepoRuntimeHostPath = @"E:\Project-Copperfin\build\Release\copperfin_runtime_host.exe";

    public static bool IsCopperfinProjectPath(string? path)
    {
        return !string.IsNullOrWhiteSpace(path) &&
               string.Equals(Path.GetExtension(path), ".pjx", StringComparison.OrdinalIgnoreCase);
    }

    public static string? ResolveBuildHostPath()
    {
        var configured = Environment.GetEnvironmentVariable("COPPERFIN_BUILD_HOST_PATH");
        if (!string.IsNullOrWhiteSpace(configured) && File.Exists(configured))
        {
            return configured;
        }

        if (File.Exists(RepoBuildHostPath))
        {
            return RepoBuildHostPath;
        }

        return null;
    }

    public static string? ResolveRuntimeHostPath()
    {
        var configured = Environment.GetEnvironmentVariable("COPPERFIN_RUNTIME_HOST_PATH");
        if (!string.IsNullOrWhiteSpace(configured) && File.Exists(configured))
        {
            return configured;
        }

        if (File.Exists(RepoRuntimeHostPath))
        {
            return RepoRuntimeHostPath;
        }

        return null;
    }

    public static Task<CopperfinProjectExecutionResult> ExecuteAsync(string projectPath, CopperfinProjectOperation operation)
    {
        return Task.Run(() => ExecuteCore(projectPath, operation));
    }

    private static CopperfinProjectExecutionResult ExecuteCore(string projectPath, CopperfinProjectOperation operation)
    {
        var buildHostPath = ResolveBuildHostPath();
        if (buildHostPath is null)
        {
            return Failure(projectPath, "Copperfin build host was not found. Set COPPERFIN_BUILD_HOST_PATH or build E:\\Project-Copperfin\\build\\Release\\copperfin_build_host.exe.");
        }

        var runtimeHostPath = ResolveRuntimeHostPath();
        if (runtimeHostPath is null)
        {
            return Failure(projectPath, "Copperfin runtime host was not found. Set COPPERFIN_RUNTIME_HOST_PATH or build E:\\Project-Copperfin\\build\\Release\\copperfin_runtime_host.exe.");
        }

        var outputDirectory = CreateOutputDirectory(projectPath);
        var buildArguments = new List<string>
        {
            "build",
            "--project", Quote(projectPath),
            "--output-dir", Quote(outputDirectory),
            "--configuration", "debug",
            "--enable-security",
            "--emit-dotnet-launcher",
            "--runtime-host", Quote(runtimeHostPath)
        };

        var buildResult = RunProcess(buildHostPath, buildArguments);
        if (buildResult.ExitCode != 0 || !string.Equals(GetValueOrDefault(buildResult.Values, "status"), "ok", StringComparison.OrdinalIgnoreCase))
        {
            return Failure(projectPath, "Copperfin build failed.", outputDirectory, string.Empty, buildResult.ExitCode, buildResult.StandardOutput, buildResult.StandardError);
        }

        var launcherPath = buildResult.Values.TryGetValue("launcher.output", out var parsedLauncher)
            ? parsedLauncher
            : InferLauncherPath(buildResult.Values, projectPath, outputDirectory);

        if (string.IsNullOrWhiteSpace(launcherPath) || !File.Exists(launcherPath))
        {
            return Failure(projectPath, "Copperfin build completed, but the launcher executable was not found.", outputDirectory, launcherPath ?? string.Empty, buildResult.ExitCode, buildResult.StandardOutput, buildResult.StandardError);
        }

        if (operation == CopperfinProjectOperation.Build)
        {
            return new CopperfinProjectExecutionResult
            {
                Success = true,
                Message = "Copperfin build completed successfully.",
                ProjectPath = projectPath,
                OutputDirectory = outputDirectory,
                LauncherPath = launcherPath,
                DebugManifestPath = GetValueOrDefault(buildResult.Values, "debug.manifest.path"),
                ExitCode = buildResult.ExitCode,
                StandardOutput = buildResult.StandardOutput,
                StandardError = buildResult.StandardError
            };
        }

        var launchArguments = operation == CopperfinProjectOperation.Debug ? new[] { "--debug" } : Array.Empty<string>();
        var launchResult = StartProcess(launcherPath, launchArguments);
        if (!launchResult.Success)
        {
            return Failure(projectPath, launchResult.Message, outputDirectory, launcherPath, buildResult.ExitCode, buildResult.StandardOutput, buildResult.StandardError);
        }

        return new CopperfinProjectExecutionResult
        {
            Success = true,
            Message = operation == CopperfinProjectOperation.Debug
                ? "Copperfin project launched in debug mode."
                : "Copperfin project launched successfully.",
            ProjectPath = projectPath,
            OutputDirectory = outputDirectory,
            LauncherPath = launcherPath,
            DebugManifestPath = GetValueOrDefault(buildResult.Values, "debug.manifest.path"),
            ExitCode = buildResult.ExitCode,
            StandardOutput = buildResult.StandardOutput,
            StandardError = buildResult.StandardError
        };
    }

    private static CopperfinProjectExecutionResult Failure(
        string projectPath,
        string message,
        string outputDirectory = "",
        string launcherPath = "",
        int exitCode = -1,
        string stdout = "",
        string stderr = "")
    {
        return new CopperfinProjectExecutionResult
        {
            Success = false,
            Message = message,
            ProjectPath = projectPath,
            OutputDirectory = outputDirectory,
            LauncherPath = launcherPath,
            ExitCode = exitCode,
            StandardOutput = stdout,
            StandardError = stderr
        };
    }

    private static CopperfinProcessExecutionResult RunProcess(string fileName, IEnumerable<string> arguments)
    {
        var startInfo = new ProcessStartInfo
        {
            FileName = fileName,
            Arguments = string.Join(" ", arguments),
            UseShellExecute = false,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            CreateNoWindow = true
        };

        using var process = new System.Diagnostics.Process { StartInfo = startInfo };
        if (!process.Start())
        {
            return new CopperfinProcessExecutionResult
            {
                ExitCode = -1,
                StandardError = "Copperfin process could not be started."
            };
        }

        var stdout = process.StandardOutput.ReadToEnd();
        var stderr = process.StandardError.ReadToEnd();
        process.WaitForExit();

        var result = new CopperfinProcessExecutionResult
        {
            ExitCode = process.ExitCode,
            StandardOutput = stdout.Trim(),
            StandardError = stderr.Trim()
        };

        foreach (var kvp in ParseKeyValueLines(stdout))
        {
            result.Values[kvp.Key] = kvp.Value;
        }

        result.Values["stdout"] = result.StandardOutput;
        result.Values["stderr"] = result.StandardError;
        result.Values["exit_code"] = result.ExitCode.ToString();
        return result;
    }

    private static CopperfinProjectExecutionResult StartProcess(string fileName, IEnumerable<string> arguments)
    {
        var startInfo = new ProcessStartInfo
        {
            FileName = fileName,
            Arguments = string.Join(" ", arguments),
            UseShellExecute = false,
            CreateNoWindow = true
        };

        try
        {
            if (System.Diagnostics.Process.Start(startInfo) is null)
            {
                return Failure(fileName, "Copperfin launcher could not be started.");
            }
        }
        catch (Exception ex)
        {
            return Failure(fileName, "Copperfin launcher could not be started: " + ex.Message);
        }

        return new CopperfinProjectExecutionResult
        {
            Success = true,
            Message = "Copperfin launcher started.",
            ProjectPath = fileName
        };
    }

    private static string CreateOutputDirectory(string projectPath)
    {
        var projectName = Path.GetFileNameWithoutExtension(projectPath);
        var safeProjectName = string.IsNullOrWhiteSpace(projectName) ? "CopperfinProject" : projectName;
        var outputDirectory = Path.Combine(
            Path.GetTempPath(),
            "Copperfin",
            "VisualStudio",
            safeProjectName,
            DateTime.UtcNow.ToString("yyyyMMdd_HHmmss"));
        Directory.CreateDirectory(outputDirectory);
        return outputDirectory;
    }

    private static Dictionary<string, string> ParseKeyValueLines(string text)
    {
        var values = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        using var reader = new StringReader(text);
        string? line;
        while ((line = reader.ReadLine()) is not null)
        {
            var separator = line.IndexOf(": ", StringComparison.Ordinal);
            if (separator <= 0)
            {
                continue;
            }

            var key = line.Substring(0, separator).Trim();
            var value = line.Substring(separator + 2).Trim();
            if (!string.IsNullOrWhiteSpace(key))
            {
                values[key] = value;
            }
        }

        return values;
    }

    private static string GetValueOrDefault(IReadOnlyDictionary<string, string> values, string key)
    {
        return values.TryGetValue(key, out var value) ? value : string.Empty;
    }

    private static string InferLauncherPath(IReadOnlyDictionary<string, string> values, string projectPath, string outputDirectory)
    {
        if (values.TryGetValue("project.title", out var projectTitle) && !string.IsNullOrWhiteSpace(projectTitle))
        {
            var launcherFolder = Path.Combine(outputDirectory, projectTitle.Trim());
            var launcher = Path.Combine(launcherFolder, projectTitle.Trim() + ".exe");
            if (File.Exists(launcher))
            {
                return launcher;
            }
        }

        var fallbackName = Path.GetFileNameWithoutExtension(projectPath).ToUpperInvariant();
        var fallbackLauncher = Path.Combine(outputDirectory, fallbackName, fallbackName + ".exe");
        return File.Exists(fallbackLauncher) ? fallbackLauncher : string.Empty;
    }

    private static string Quote(string value)
    {
        return "\"" + value.Replace("\"", "\"\"") + "\"";
    }
}
