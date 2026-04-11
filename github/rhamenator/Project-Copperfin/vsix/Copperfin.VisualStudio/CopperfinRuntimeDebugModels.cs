using System.Collections.Generic;

namespace Copperfin.VisualStudio;

internal sealed class CopperfinRuntimeDebugSession
{
    public bool Success { get; set; }
    public string Error { get; set; } = string.Empty;
    public string DebugManifestPath { get; set; } = string.Empty;
    public List<string> Commands { get; set; } = new();
    public CopperfinRuntimePauseState State { get; set; } = new();
}

internal sealed class CopperfinRuntimePauseState
{
    public string Reason { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public string Statement { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public int StackDepth { get; set; }
    public int ExecutedStatements { get; set; }
    public List<CopperfinRuntimeStackFrame> Frames { get; set; } = new();
    public List<CopperfinRuntimeNamedValue> Globals { get; set; } = new();
    public List<CopperfinRuntimeEvent> Events { get; set; } = new();
}

internal sealed class CopperfinRuntimeStackFrame
{
    public string RoutineName { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public List<CopperfinRuntimeNamedValue> Locals { get; set; } = new();
}

internal sealed class CopperfinRuntimeNamedValue
{
    public string Name { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
}

internal sealed class CopperfinRuntimeEvent
{
    public string Category { get; set; } = string.Empty;
    public string Detail { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
}
