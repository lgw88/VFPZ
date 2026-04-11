using System;
using System.Linq;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio;
using Microsoft.VisualStudio.Editor;
using Microsoft.VisualStudio.Language.Intellisense;
using Microsoft.VisualStudio.OLE.Interop;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Shell.Interop;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Editor;
using Microsoft.VisualStudio.TextManager.Interop;

namespace Copperfin.VisualStudio;

internal sealed class FoxProCompletionCommandHandler : IOleCommandTarget
{
    private readonly IVsTextView textViewAdapter;
    private readonly ITextView textView;
    private readonly ICompletionBroker completionBroker;
    private readonly ISignatureHelpBroker signatureHelpBroker;
    private readonly ITextDocumentFactoryService textDocumentFactoryService;
    private IOleCommandTarget? nextCommandTarget;
    private ICompletionSession? completionSession;
    private ISignatureHelpSession? signatureHelpSession;

    public FoxProCompletionCommandHandler(
        IVsTextView textViewAdapter,
        ITextView textView,
        ICompletionBroker completionBroker,
        ISignatureHelpBroker signatureHelpBroker,
        ITextDocumentFactoryService textDocumentFactoryService)
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        this.textViewAdapter = textViewAdapter;
        this.textView = textView;
        this.completionBroker = completionBroker;
        this.signatureHelpBroker = signatureHelpBroker;
        this.textDocumentFactoryService = textDocumentFactoryService;
        ErrorHandler.ThrowOnFailure(textViewAdapter.AddCommandFilter(this, out nextCommandTarget));
    }

    public int QueryStatus(ref Guid pguidCmdGroup, uint cCmds, OLECMD[] prgCmds, IntPtr pCmdText)
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        return nextCommandTarget?.QueryStatus(ref pguidCmdGroup, cCmds, prgCmds, pCmdText) ?? VSConstants.S_OK;
    }

    public int Exec(ref Guid pguidCmdGroup, uint nCmdID, uint nCmdexecopt, IntPtr pvaIn, IntPtr pvaOut)
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        if (pguidCmdGroup == VSConstants.GUID_VSStandardCommandSet97 &&
            (VSConstants.VSStd97CmdID)nCmdID == VSConstants.VSStd97CmdID.GotoDefn &&
            TryGoToDefinition())
        {
            return VSConstants.S_OK;
        }

        if (pguidCmdGroup == VSConstants.VSStd2K)
        {
            switch ((VSConstants.VSStd2KCmdID)nCmdID)
            {
                case VSConstants.VSStd2KCmdID.AUTOCOMPLETE:
                case VSConstants.VSStd2KCmdID.COMPLETEWORD:
                    TriggerCompletion();
                    return VSConstants.S_OK;

                case VSConstants.VSStd2KCmdID.RETURN:
                case VSConstants.VSStd2KCmdID.TAB:
                    if (completionSession is not null && !completionSession.IsDismissed)
                    {
                        completionSession.Commit();
                        return VSConstants.S_OK;
                    }
                    break;

                case VSConstants.VSStd2KCmdID.CANCEL:
                    if (completionSession is not null && !completionSession.IsDismissed)
                    {
                        completionSession.Dismiss();
                        completionSession = null;
                    }

                    DismissSignatureHelp();
                    return VSConstants.S_OK;

                case VSConstants.VSStd2KCmdID.TYPECHAR:
                    var typedChar = (char)(ushort)Marshal.GetObjectForNativeVariant(pvaIn);
                    var result = nextCommandTarget?.Exec(ref pguidCmdGroup, nCmdID, nCmdexecopt, pvaIn, pvaOut) ?? VSConstants.S_OK;

                    if (typedChar == '(')
                    {
                        TriggerSignatureHelp();
                    }
                    else if (typedChar == ',')
                    {
                        RecalculateSignatureHelp();
                    }
                    else if (typedChar == ')')
                    {
                        DismissSignatureHelp();
                    }
                    else if (signatureHelpSession is not null && !signatureHelpSession.IsDismissed)
                    {
                        RecalculateSignatureHelp();
                    }

                    if (char.IsLetterOrDigit(typedChar) || typedChar == '_' || typedChar == '.' || typedChar == '#')
                    {
                        if (completionSession is null || completionSession.IsDismissed)
                        {
                            TriggerCompletion();
                        }
                        else
                        {
                            completionSession.Filter();
                        }
                    }
                    else if (completionSession is not null && !completionSession.IsDismissed)
                    {
                        completionSession.Filter();
                    }

                    return result;
            }
        }

        return nextCommandTarget?.Exec(ref pguidCmdGroup, nCmdID, nCmdexecopt, pvaIn, pvaOut) ?? VSConstants.S_OK;
    }

    private void TriggerCompletion()
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        if (completionSession is not null && !completionSession.IsDismissed)
        {
            completionSession.Filter();
            return;
        }

        completionSession = completionBroker.TriggerCompletion(textView);
        if (completionSession is null)
        {
            return;
        }

        completionSession.Dismissed += (_, _) => completionSession = null;
    }

    private void TriggerSignatureHelp()
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        if (signatureHelpBroker.IsSignatureHelpActive(textView))
        {
            signatureHelpSession = signatureHelpBroker.GetSessions(textView).FirstOrDefault();
            signatureHelpSession?.Recalculate();
            return;
        }

        signatureHelpSession = signatureHelpBroker.TriggerSignatureHelp(textView);
        if (signatureHelpSession is null)
        {
            return;
        }

        signatureHelpSession.Dismissed += (_, _) => signatureHelpSession = null;
    }

    private void RecalculateSignatureHelp()
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        if (signatureHelpSession is null || signatureHelpSession.IsDismissed)
        {
            if (signatureHelpBroker.IsSignatureHelpActive(textView))
            {
                signatureHelpSession = signatureHelpBroker.GetSessions(textView).FirstOrDefault();
            }
        }

        signatureHelpSession?.Recalculate();
    }

    private void DismissSignatureHelp()
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        if (signatureHelpSession is not null && !signatureHelpSession.IsDismissed)
        {
            signatureHelpSession.Dismiss();
        }

        signatureHelpBroker.DismissAllSessions(textView);
        signatureHelpSession = null;
    }

    private bool TryGoToDefinition()
    {
        ThreadHelper.ThrowIfNotOnUIThread();
        if (!textDocumentFactoryService.TryGetTextDocument(textView.TextBuffer, out var document))
        {
            return false;
        }

        var token = FoxProTextUtilities.TryGetTokenAtCaret(textView, out _);
        if (token is null ||
            string.IsNullOrWhiteSpace(token) ||
            !FoxProIntelliSenseCatalog.TryResolveDefinition(document.FilePath, token, out var definition))
        {
            return false;
        }

        VsShellUtilities.OpenDocument(
            ServiceProvider.GlobalProvider,
            definition.FilePath,
            Guid.Empty,
            out IVsUIHierarchy _,
            out uint _,
            out IVsWindowFrame windowFrame,
            out IVsTextView targetTextView);

        targetTextView ??= VsShellUtilities.GetTextView(windowFrame);
        if (targetTextView is null)
        {
            return true;
        }

        ErrorHandler.ThrowOnFailure(targetTextView.SetCaretPos(Math.Max(0, definition.LineNumber - 1), Math.Max(0, definition.ColumnNumber - 1)));
        ErrorHandler.ThrowOnFailure(targetTextView.CenterLines(Math.Max(0, definition.LineNumber - 1), 1));
        return true;
    }
}
