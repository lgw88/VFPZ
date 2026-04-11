using System;
using System.Diagnostics;
using System.IO;
using System.Web.Script.Serialization;

namespace Copperfin.VisualStudio;

internal static class CopperfinStudioSnapshotClient
{
    private static CopperfinStudioSnapshotResult RunSnapshotCommand(string studioHostPath, string arguments)
    {
        var startInfo = new ProcessStartInfo
        {
            FileName = studioHostPath,
            Arguments = arguments,
            UseShellExecute = false,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            CreateNoWindow = true
        };

        using var process = new Process { StartInfo = startInfo };
        if (!process.Start())
        {
            return new CopperfinStudioSnapshotResult
            {
                Success = false,
                Error = "Copperfin Studio host could not be started."
            };
        }

        var stdout = process.StandardOutput.ReadToEnd();
        var stderr = process.StandardError.ReadToEnd();
        process.WaitForExit(15000);

        if (!process.HasExited)
        {
            try
            {
                process.Kill();
            }
            catch (InvalidOperationException)
            {
            }

            return new CopperfinStudioSnapshotResult
            {
                Success = false,
                Error = "Timed out while waiting for Copperfin Studio host."
            };
        }

        if (process.ExitCode != 0)
        {
            return new CopperfinStudioSnapshotResult
            {
                Success = false,
                Error = string.IsNullOrWhiteSpace(stderr) ? stdout.Trim() : stderr.Trim()
            };
        }

        try
        {
            var serializer = new JavaScriptSerializer { MaxJsonLength = 1024 * 1024 * 8 };
            var envelope = serializer.Deserialize<CopperfinStudioSnapshotEnvelope>(stdout);
            if (envelope is null || envelope.Document is null)
            {
                return new CopperfinStudioSnapshotResult
                {
                    Success = false,
                    Error = "Copperfin Studio returned an empty snapshot."
                };
            }

            return new CopperfinStudioSnapshotResult
            {
                Success = true,
                Document = envelope.Document
            };
        }
        catch (InvalidOperationException ex)
        {
            return new CopperfinStudioSnapshotResult
            {
                Success = false,
                Error = "Could not parse Copperfin Studio snapshot: " + ex.Message
            };
        }
    }

    public static CopperfinStudioSnapshotResult TryLoad(string assetPath)
    {
        var studioHostPath = CopperfinStudioHostBridge.ResolveStudioHostPath();
        if (string.IsNullOrWhiteSpace(studioHostPath))
        {
            return new CopperfinStudioSnapshotResult
            {
                Success = false,
                Error = "Copperfin Studio host was not found."
            };
        }

        return RunSnapshotCommand(studioHostPath!, CopperfinStudioHostBridge.BuildArguments(assetPath, readOnly: true) + " --json");
    }

    public static CopperfinStudioSnapshotResult TryUpdateProperty(
        string assetPath,
        int recordIndex,
        string propertyName,
        string propertyValue)
    {
        var studioHostPath = CopperfinStudioHostBridge.ResolveStudioHostPath();
        if (string.IsNullOrWhiteSpace(studioHostPath))
        {
            return new CopperfinStudioSnapshotResult
            {
                Success = false,
                Error = "Copperfin Studio host was not found."
            };
        }

        return RunSnapshotCommand(
            studioHostPath!,
            CopperfinStudioHostBridge.BuildPropertyUpdateArguments(assetPath, recordIndex, propertyName, propertyValue));
    }
}
