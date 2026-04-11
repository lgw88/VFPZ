using System.Collections.Generic;

namespace Copperfin.VisualStudio;

internal sealed class CopperfinProjectInsights
{
    public string ProjectRoot { get; set; } = string.Empty;
    public List<CopperfinProjectTaskItem> TaskItems { get; set; } = new();
    public List<CopperfinProjectCodeSymbol> DefinedSymbols { get; set; } = new();
    public List<CopperfinProjectCodeSymbol> RuntimeReferences { get; set; } = new();
    public List<CopperfinProjectDataAsset> DataAssets { get; set; } = new();
    public List<CopperfinProjectObjectNode> ObjectNodes { get; set; } = new();
    public List<string> Warnings { get; set; } = new();
}

internal sealed class CopperfinProjectTaskItem
{
    public string Category { get; set; } = string.Empty;
    public string FilePath { get; set; } = string.Empty;
    public int Line { get; set; }
    public string Message { get; set; } = string.Empty;
}

internal sealed class CopperfinProjectCodeSymbol
{
    public string Kind { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string FilePath { get; set; } = string.Empty;
    public int Line { get; set; }
    public string Detail { get; set; } = string.Empty;
}

internal sealed class CopperfinProjectDataAsset
{
    public string Kind { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string FilePath { get; set; } = string.Empty;
    public string GroupTitle { get; set; } = string.Empty;
    public bool Excluded { get; set; }
}

internal sealed class CopperfinProjectObjectNode
{
    public string Kind { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string FilePath { get; set; } = string.Empty;
    public string Detail { get; set; } = string.Empty;
}
