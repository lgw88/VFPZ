using System;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Shell.Interop;

namespace Copperfin.VisualStudio;

[ComVisible(true)]
internal sealed class CopperfinAssetEditorPane : WindowPane, IVsPersistDocData
{
    private readonly CopperfinAssetEditorControl control;
    private string documentPath;
    private uint docCookie;

    public CopperfinAssetEditorPane(IServiceProvider serviceProvider, string documentPath)
        : base(serviceProvider)
    {
        control = new CopperfinAssetEditorControl();
        this.documentPath = documentPath;
        control.LoadDocument(documentPath);
    }

    public override object Content => control;

    public int Close()
    {
        Dispose();
        return VSConstants.S_OK;
    }

    public int GetGuidEditorType(out Guid pClassID)
    {
        pClassID = new Guid(PackageGuids.EditorFactoryString);
        return VSConstants.S_OK;
    }

    public int IsDocDataDirty(out int pfDirty)
    {
        pfDirty = 0;
        return VSConstants.S_OK;
    }

    public int IsDocDataReloadable(out int pfReloadable)
    {
        pfReloadable = 1;
        return VSConstants.S_OK;
    }

    public int LoadDocData(string pszMkDocument)
    {
        documentPath = pszMkDocument;
        control.LoadDocument(documentPath);
        return VSConstants.S_OK;
    }

    public int OnRegisterDocData(uint docCookie, IVsHierarchy pHierNew, uint itemidNew)
    {
        this.docCookie = docCookie;
        return VSConstants.S_OK;
    }

    public int ReloadDocData(uint grfFlags)
    {
        if (!string.IsNullOrWhiteSpace(documentPath))
        {
            control.LoadDocument(documentPath);
        }

        return VSConstants.S_OK;
    }

    public int RenameDocData(
        uint grfAttribs,
        IVsHierarchy pHierNew,
        uint itemidNew,
        string pszMkDocumentNew)
    {
        documentPath = pszMkDocumentNew;
        control.LoadDocument(documentPath);
        return VSConstants.S_OK;
    }

    public int SaveDocData(VSSAVEFLAGS dwSave, out string pbstrMkDocumentNew, out int pfSaveCanceled)
    {
        pbstrMkDocumentNew = documentPath;
        pfSaveCanceled = 0;
        return VSConstants.S_OK;
    }

    public int SetUntitledDocPath(string pszDocDataPath)
    {
        documentPath = pszDocDataPath;
        control.LoadDocument(documentPath);
        return VSConstants.S_OK;
    }

    protected override void Dispose(bool disposing)
    {
        if (disposing && docCookie != 0)
        {
            docCookie = 0;
        }

        base.Dispose(disposing);
    }
}
