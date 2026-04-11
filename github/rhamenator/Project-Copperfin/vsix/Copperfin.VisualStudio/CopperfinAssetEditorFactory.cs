using System;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Shell.Interop;
using OleServiceProvider = Microsoft.VisualStudio.OLE.Interop.IServiceProvider;

namespace Copperfin.VisualStudio;

[ComVisible(true)]
[Guid(PackageGuids.EditorFactoryString)]
internal sealed class CopperfinAssetEditorFactory : IVsEditorFactory, IDisposable
{
    private ServiceProvider? serviceProvider;

    public CopperfinAssetEditorFactory(AsyncPackage package)
    {
        Package = package;
    }

    private AsyncPackage Package { get; }

    public void Dispose()
    {
        serviceProvider?.Dispose();
        serviceProvider = null;
    }

    public int Close()
    {
        Dispose();
        return VSConstants.S_OK;
    }

    public int CreateEditorInstance(
        uint grfCreateDoc,
        string pszMkDocument,
        string pszPhysicalView,
        IVsHierarchy pvHier,
        uint itemid,
        IntPtr punkDocDataExisting,
        out IntPtr ppunkDocView,
        out IntPtr ppunkDocData,
        out string pbstrEditorCaption,
        out Guid pguidCmdUI,
        out int pgrfCDW)
    {
        ThreadHelper.ThrowIfNotOnUIThread();

        ppunkDocView = IntPtr.Zero;
        ppunkDocData = IntPtr.Zero;
        pbstrEditorCaption = string.Empty;
        pguidCmdUI = new Guid(PackageGuids.EditorFactoryString);
        pgrfCDW = 0;

        if (punkDocDataExisting != IntPtr.Zero)
        {
            return VSConstants.VS_E_INCOMPATIBLEDOCDATA;
        }

        var editorPane = new CopperfinAssetEditorPane(Package, pszMkDocument);
        ppunkDocView = Marshal.GetIUnknownForObject(editorPane);
        ppunkDocData = Marshal.GetIUnknownForObject(editorPane);
        pbstrEditorCaption = string.Empty;

        return VSConstants.S_OK;
    }

    public int MapLogicalView(ref Guid rguidLogicalView, out string pbstrPhysicalView)
    {
        if (rguidLogicalView == VSConstants.LOGVIEWID_Primary ||
            rguidLogicalView == VSConstants.LOGVIEWID_Designer ||
            rguidLogicalView == VSConstants.LOGVIEWID_TextView)
        {
            pbstrPhysicalView = null!;
            return VSConstants.S_OK;
        }

        pbstrPhysicalView = null!;
        return VSConstants.E_NOTIMPL;
    }

    public int SetSite(OleServiceProvider psp)
    {
        serviceProvider?.Dispose();
        serviceProvider = new ServiceProvider(psp);
        return VSConstants.S_OK;
    }
}
