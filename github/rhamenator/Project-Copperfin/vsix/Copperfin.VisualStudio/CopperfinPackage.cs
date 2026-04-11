using System;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.VisualStudio.Shell;

namespace Copperfin.VisualStudio;

[PackageRegistration(UseManagedResourcesOnly = true, AllowsBackgroundLoading = true)]
[InstalledProductRegistration(
    "Copperfin for Visual Studio",
    "Launches Copperfin Studio for Visual FoxPro-style assets and prepares the path toward native asset designers.",
    "0.1.0")]
[ProvideMenuResource("Menus.ctmenu", 1)]
[ProvideEditorFactory(typeof(CopperfinAssetEditorFactory), 200)]
[ProvideEditorExtension(typeof(CopperfinAssetEditorFactory), ".pjx", 50, NameResourceID = 200, DefaultName = "Copperfin Visual Designer")]
[ProvideEditorExtension(typeof(CopperfinAssetEditorFactory), ".scx", 50, NameResourceID = 200, DefaultName = "Copperfin Visual Designer")]
[ProvideEditorExtension(typeof(CopperfinAssetEditorFactory), ".vcx", 50, NameResourceID = 200, DefaultName = "Copperfin Visual Designer")]
[ProvideEditorExtension(typeof(CopperfinAssetEditorFactory), ".frx", 50, NameResourceID = 200, DefaultName = "Copperfin Visual Designer")]
[ProvideEditorExtension(typeof(CopperfinAssetEditorFactory), ".lbx", 50, NameResourceID = 200, DefaultName = "Copperfin Visual Designer")]
[ProvideEditorExtension(typeof(CopperfinAssetEditorFactory), ".mnx", 50, NameResourceID = 200, DefaultName = "Copperfin Visual Designer")]
[Guid(PackageGuids.PackageString)]
public sealed class CopperfinPackage : AsyncPackage
{
    protected override async Task InitializeAsync(CancellationToken cancellationToken, IProgress<ServiceProgressData> progress)
    {
        await JoinableTaskFactory.SwitchToMainThreadAsync(cancellationToken);
        RegisterEditorFactory(new CopperfinAssetEditorFactory(this));
        await OpenInCopperfinStudioCommand.InitializeAsync(this);
        await CopperfinProjectCommands.InitializeAsync(this);
    }
}
