using System;
using System.ComponentModel.Design;
using System.Threading.Tasks;
using EnvDTE;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Shell.Interop;

namespace Copperfin.VisualStudio;

internal sealed class CopperfinProjectCommands
{
    private const int BuildCommandId = 0x0200;
    private const int RunCommandId = 0x0201;
    private const int DebugCommandId = 0x0202;
    private static readonly Guid CommandSet = new(PackageGuids.CommandSetString);

    private readonly AsyncPackage package;

    private CopperfinProjectCommands(AsyncPackage package, OleMenuCommandService commandService)
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        this.package = package;

        AddCommand(commandService, BuildCommandId, "Build Copperfin Project", CopperfinProjectOperation.Build);
        AddCommand(commandService, RunCommandId, "Run Copperfin Project", CopperfinProjectOperation.Run);
        AddCommand(commandService, DebugCommandId, "Debug Copperfin Project", CopperfinProjectOperation.Debug);
    }

    public static async Task InitializeAsync(AsyncPackage package)
    {
        await ThreadHelper.JoinableTaskFactory.SwitchToMainThreadAsync();

        var commandService = await package.GetServiceAsync(typeof(IMenuCommandService)) as OleMenuCommandService;
        if (commandService is null)
        {
            throw new InvalidOperationException("Unable to get menu command service.");
        }

        _ = new CopperfinProjectCommands(package, commandService);
    }

    private void AddCommand(OleMenuCommandService commandService, int commandId, string label, CopperfinProjectOperation operation)
    {
        var menuCommand = new OleMenuCommand((_, _) => { _ = package.JoinableTaskFactory.RunAsync(() => ExecuteAsync(operation)); }, new CommandID(CommandSet, commandId));
        menuCommand.Text = label;
        menuCommand.BeforeQueryStatus += (_, _) => UpdateQueryStatus(menuCommand);
        commandService.AddCommand(menuCommand);
    }

    private void UpdateQueryStatus(OleMenuCommand menuCommand)
    {
        ThreadHelper.ThrowIfNotOnUIThread();

        var dte = ((IServiceProvider)package).GetService(typeof(DTE)) as DTE;
        var projectPath = CopperfinProjectSelection.ResolveProjectPath(dte);
        var enabled = CopperfinProjectWorkflow.IsCopperfinProjectPath(projectPath);
        menuCommand.Visible = true;
        menuCommand.Enabled = enabled;
    }

    private async Task ExecuteAsync(CopperfinProjectOperation operation)
    {
        await ThreadHelper.JoinableTaskFactory.SwitchToMainThreadAsync();

        var dte = await package.GetServiceAsync(typeof(DTE)) as DTE;
        var projectPath = CopperfinProjectSelection.ResolveProjectPath(dte);
        if (!CopperfinProjectWorkflow.IsCopperfinProjectPath(projectPath))
        {
            ShowMessage(
                "Open or select a Copperfin `PJX` project first, then run the command again.",
                OLEMSGICON.OLEMSGICON_INFO);
            return;
        }

        var result = await CopperfinProjectWorkflow.ExecuteAsync(projectPath!, operation);
        if (!result.Success)
        {
            ShowMessage(result.Message, OLEMSGICON.OLEMSGICON_WARNING);
            return;
        }

        ShowMessage(result.Message + "\n\nLauncher: " + result.LauncherPath, OLEMSGICON.OLEMSGICON_INFO);
    }

    private void ShowMessage(string message, OLEMSGICON icon)
    {
        VsShellUtilities.ShowMessageBox(
            package,
            message,
            "Copperfin",
            icon,
            OLEMSGBUTTON.OLEMSGBUTTON_OK,
            OLEMSGDEFBUTTON.OLEMSGDEFBUTTON_FIRST);
    }
}
