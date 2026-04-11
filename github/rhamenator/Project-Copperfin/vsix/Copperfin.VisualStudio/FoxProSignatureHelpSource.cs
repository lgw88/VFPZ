using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.Composition;
using System.Linq;
using Microsoft.VisualStudio.Language.Intellisense;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Utilities;

namespace Copperfin.VisualStudio;

[Export(typeof(ISignatureHelpSourceProvider))]
[Name("Copperfin FoxPro Signature Help")]
[ContentType(FoxProContentTypeDefinitions.ContentTypeName)]
internal sealed class FoxProSignatureHelpSourceProvider : ISignatureHelpSourceProvider
{
    [Import]
    internal ITextDocumentFactoryService TextDocumentFactoryService = null!;

    public ISignatureHelpSource TryCreateSignatureHelpSource(ITextBuffer textBuffer)
    {
        return new FoxProSignatureHelpSource(textBuffer, TextDocumentFactoryService);
    }
}

internal sealed class FoxProSignatureHelpSource : ISignatureHelpSource
{
    private readonly ITextBuffer textBuffer;
    private readonly ITextDocumentFactoryService textDocumentFactoryService;
    private bool disposed;

    public FoxProSignatureHelpSource(ITextBuffer textBuffer, ITextDocumentFactoryService textDocumentFactoryService)
    {
        this.textBuffer = textBuffer;
        this.textDocumentFactoryService = textDocumentFactoryService;
    }

    public void AugmentSignatureHelpSession(ISignatureHelpSession session, IList<ISignature> signatures)
    {
        if (disposed)
        {
            return;
        }

        var triggerPoint = session.GetTriggerPoint(textBuffer.CurrentSnapshot);
        if (triggerPoint is null)
        {
            return;
        }

        var snapshot = triggerPoint.Value.Snapshot;
        if (!FoxProTextUtilities.TryFindInvocationContext(snapshot, triggerPoint.Value.Position, out var invocation))
        {
            return;
        }

        var signatureEntries = FoxProIntelliSenseCatalog.GetSignatures(TryGetFilePath(), invocation.InvocationName);
        if (signatureEntries.Count == 0)
        {
            return;
        }

        var applicableTo = snapshot.CreateTrackingSpan(invocation.InvocationSpan, SpanTrackingMode.EdgeInclusive);
        foreach (var entry in signatureEntries)
        {
            var signature = new FoxProSignature(applicableTo, entry);
            signature.SetCurrentParameter(invocation.ParameterIndex);
            signatures.Add(signature);
        }
    }

    public ISignature? GetBestMatch(ISignatureHelpSession session)
    {
        if (disposed)
        {
            return null;
        }

        var triggerPoint = session.GetTriggerPoint(textBuffer.CurrentSnapshot);
        if (triggerPoint is null)
        {
            return null;
        }

        if (!FoxProTextUtilities.TryFindInvocationContext(triggerPoint.Value.Snapshot, triggerPoint.Value.Position, out var invocation))
        {
            return session.Signatures.FirstOrDefault();
        }

        foreach (var signature in session.Signatures.OfType<FoxProSignature>())
        {
            signature.SetCurrentParameter(invocation.ParameterIndex);
        }

        return session.Signatures.OfType<FoxProSignature>().FirstOrDefault();
    }

    public void Dispose()
    {
        disposed = true;
    }

    private string? TryGetFilePath()
    {
        return textDocumentFactoryService.TryGetTextDocument(textBuffer, out var document)
            ? document.FilePath
            : null;
    }
}

internal sealed class FoxProSignature : ISignature
{
    private readonly ReadOnlyCollection<IParameter> parameters;
    private IParameter? currentParameter;

    public FoxProSignature(ITrackingSpan applicableToSpan, FoxProSignatureEntry entry)
    {
        ApplicableToSpan = applicableToSpan;
        Content = entry.Content;
        PrettyPrintedContent = entry.Content;
        Documentation = entry.Documentation;

        var builtParameters = new List<IParameter>();
        foreach (var parameter in entry.Parameters)
        {
            builtParameters.Add(new FoxProParameter(this, entry.Content, parameter));
        }

        parameters = new ReadOnlyCollection<IParameter>(builtParameters);
        currentParameter = parameters.FirstOrDefault();
    }

    public event EventHandler<CurrentParameterChangedEventArgs>? CurrentParameterChanged;

    public ITrackingSpan ApplicableToSpan { get; }

    public string Content { get; }

    public string PrettyPrintedContent { get; }

    public string Documentation { get; }

    public ReadOnlyCollection<IParameter> Parameters => parameters;

    public IParameter? CurrentParameter => currentParameter;

    public void SetCurrentParameter(int parameterIndex)
    {
        if (parameters.Count == 0)
        {
            return;
        }

        var boundedIndex = Math.Max(0, Math.Min(parameterIndex, parameters.Count - 1));
        var nextParameter = parameters[boundedIndex];
        if (ReferenceEquals(currentParameter, nextParameter))
        {
            return;
        }

        var previousParameter = currentParameter;
        currentParameter = nextParameter;
        CurrentParameterChanged?.Invoke(this, new CurrentParameterChangedEventArgs(previousParameter, nextParameter));
    }
}

internal sealed class FoxProParameter : IParameter
{
    public FoxProParameter(ISignature signature, string content, FoxProParameterEntry entry)
    {
        Signature = signature;
        Name = entry.Name;
        Documentation = entry.Documentation;

        var locusStart = content.IndexOf(entry.Name, StringComparison.OrdinalIgnoreCase);
        if (locusStart < 0)
        {
            locusStart = 0;
        }

        Locus = new Span(locusStart, Math.Min(entry.Name.Length, Math.Max(0, content.Length - locusStart)));
        PrettyPrintedLocus = Locus;
    }

    public ISignature Signature { get; }

    public string Name { get; }

    public string Documentation { get; }

    public Span Locus { get; }

    public Span PrettyPrintedLocus { get; }
}
