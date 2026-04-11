using System;
using System.ComponentModel.Design;
using System.IO;
using System.Threading.Tasks;
using EnvDTE;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Shell.Interop;

namespace Copperfin.VisualStudio;

internal sealed class OpenInCopperfinStudioCommand
{
    private const int CommandId = 0x0100;
    private static readonly Guid CommandSet = new(PackageGuids.CommandSetString);

    private readonly AsyncPackage package;

    private OpenInCopperfinStudioCommand(AsyncPackage package, OleMenuCommandService commandService)
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        this.package = package;

        var menuCommandId = new CommandID(CommandSet, CommandId);
        var menuItem = new MenuCommand((_, _) => { _ = package.JoinableTaskFactory.RunAsync(ExecuteAsync); }, menuCommandId);
        commandService.AddCommand(menuItem);
    }

    public static async Task InitializeAsync(AsyncPackage package)
    {
        await ThreadHelper.JoinableTaskFactory.SwitchToMainThreadAsync();

        var commandService = await package.GetServiceAsync(typeof(IMenuCommandService)) as OleMenuCommandService;
        if (commandService is null)
        {
            throw new InvalidOperationException("Unable to get menu command service.");
        }

        _ = new OpenInCopperfinStudioCommand(package, commandService);
    }

    private async Task ExecuteAsync()
    {
        await ThreadHelper.JoinableTaskFactory.SwitchToMainThreadAsync();

        var dte = await package.GetServiceAsync(typeof(DTE)) as DTE;
        var documentPath = dte is null ? null : CopperfinStudioLauncher.ResolveTargetPath(dte);
        if (string.IsNullOrWhiteSpace(documentPath) || !File.Exists(documentPath))
        {
            VsShellUtilities.ShowMessageBox(
                package,
                "Open or select a Copperfin-supported asset first, then run the command again.",
                "Copperfin",
                OLEMSGICON.OLEMSGICON_INFO,
                OLEMSGBUTTON.OLEMSGBUTTON_OK,
                OLEMSGDEFBUTTON.OLEMSGDEFBUTTON_FIRST);
            return;
        }

        var studioHostPath = CopperfinStudioHostBridge.ResolveStudioHostPath();
        if (studioHostPath is null)
        {
            VsShellUtilities.ShowMessageBox(
                package,
                "Copperfin Studio host was not found. Set COPPERFIN_STUDIO_HOST_PATH or build E:\\Project-Copperfin\\build\\Release\\copperfin_studio_host.exe.",
                "Copperfin",
                OLEMSGICON.OLEMSGICON_WARNING,
                OLEMSGBUTTON.OLEMSGBUTTON_OK,
                OLEMSGDEFBUTTON.OLEMSGDEFBUTTON_FIRST);
            return;
        }

        if (!CopperfinStudioHostBridge.Launch(studioHostPath, documentPath!))
        {
            VsShellUtilities.ShowMessageBox(
                package,
                "Copperfin Studio did not start successfully.",
                "Copperfin",
                OLEMSGICON.OLEMSGICON_WARNING,
                OLEMSGBUTTON.OLEMSGBUTTON_OK,
                OLEMSGDEFBUTTON.OLEMSGDEFBUTTON_FIRST);
        }
    }
}
