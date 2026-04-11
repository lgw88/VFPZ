using System;
using System.IO;
using DiagnosticsProcess = System.Diagnostics.Process;
using DiagnosticsStartInfo = System.Diagnostics.ProcessStartInfo;

namespace Copperfin.VisualStudio;

internal static class CopperfinStudioHostBridge
{
    private const string RepoDevelopmentPath = @"E:\Project-Copperfin\build\Release\copperfin_studio_host.exe";

    public static string? ResolveStudioHostPath()
    {
        var configured = Environment.GetEnvironmentVariable("COPPERFIN_STUDIO_HOST_PATH");
        if (!string.IsNullOrWhiteSpace(configured) && File.Exists(configured))
        {
            return configured;
        }

        if (File.Exists(RepoDevelopmentPath))
        {
            return RepoDevelopmentPath;
        }

        return null;
    }

    public static string BuildArguments(string documentPath, bool readOnly = false)
    {
        return readOnly
            ? $"--from-vs --read-only --path {Quote(documentPath)}"
            : $"--from-vs --path {Quote(documentPath)}";
    }

    public static string BuildPropertyUpdateArguments(string documentPath, int recordIndex, string propertyName, string propertyValue)
    {
        return $"--from-vs --json --set-property --record {recordIndex} --property-name {Quote(propertyName)} --property-value {Quote(propertyValue)} --path {Quote(documentPath)}";
    }

    public static bool Launch(string studioHostPath, string documentPath, bool readOnly = false)
    {
        var startInfo = new DiagnosticsStartInfo
        {
            FileName = studioHostPath,
            Arguments = BuildArguments(documentPath, readOnly),
            UseShellExecute = false
        };

        return DiagnosticsProcess.Start(startInfo) is not null;
    }

    public static string DescribeAssetKind(string path)
    {
        switch (Path.GetExtension(path).ToLowerInvariant())
        {
            case ".pjx":
                return "Visual project";
            case ".scx":
                return "Visual form";
            case ".vcx":
                return "Visual class library";
            case ".frx":
                return "Visual report";
            case ".lbx":
                return "Visual label";
            case ".mnx":
                return "Visual menu";
            default:
                return "Copperfin asset";
        }
    }

    private static string Quote(string value)
    {
        return "\"" + value.Replace("\"", "\"\"") + "\"";
    }
}
