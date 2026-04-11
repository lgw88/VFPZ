using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace Copperfin.VisualStudio;

internal sealed class FoxProCompletionEntry
{
    public string DisplayText { get; set; } = string.Empty;
    public string InsertionText { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Kind { get; set; } = string.Empty;
}

internal sealed class FoxProParameterEntry
{
    public string Name { get; set; } = string.Empty;
    public string Documentation { get; set; } = string.Empty;
}

internal sealed class FoxProSignatureEntry
{
    public string Name { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string Documentation { get; set; } = string.Empty;
    public IReadOnlyList<FoxProParameterEntry> Parameters { get; set; } = Array.Empty<FoxProParameterEntry>();
}

internal sealed class FoxProDefinitionLocation
{
    public string Name { get; set; } = string.Empty;
    public string Kind { get; set; } = string.Empty;
    public string FilePath { get; set; } = string.Empty;
    public int LineNumber { get; set; }
    public int ColumnNumber { get; set; }
    public string Description { get; set; } = string.Empty;
}

internal static class FoxProIntelliSenseCatalog
{
    private static readonly string[] TextExtensions = { ".prg", ".h", ".hpp", ".ch", ".qpr", ".mpr", ".spr" };
    private static readonly string[] FormExtensions = { ".scx" };
    private static readonly string[] ReportExtensions = { ".frx" };
    private static readonly string[] LabelExtensions = { ".lbx" };
    private static readonly string[] MenuExtensions = { ".mnx" };
    private static readonly string[] TableExtensions = { ".dbf", ".dbc" };
    private static readonly string[] IgnoredDirectories = { ".git", ".vs", "bin", "obj", "build", "packages", "node_modules" };

    private static readonly Regex ProcedureRegex = new(@"^\s*PROCEDURE\s+([A-Za-z0-9_\.]+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex FunctionRegex = new(@"^\s*FUNCTION\s+([A-Za-z0-9_\.]+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex DefineClassRegex = new(@"^\s*DEFINE\s+CLASS\s+([A-Za-z0-9_\.]+)\s+AS\s+([A-Za-z0-9_\.]+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex DefineRegex = new(@"^\s*#DEFINE\s+([A-Za-z0-9_\.]+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex UseAliasRegex = new(@"^\s*USE\s+.+?\s+ALIAS\s+([A-Za-z0-9_\.]+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex MemberAccessRegex = new(@"([A-Za-z_][A-Za-z0-9_]*)\.$", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private static readonly (string Name, string Description)[] Keywords =
    {
        ("SELECT", "Command: selects a work area or evaluates a SELECT() call depending on context."),
        ("USE", "Command: opens a table, free table, cursor, or closes one with USE IN."),
        ("IN", "Keyword: targets a work area or alias in commands like USE IN and GO ... IN."),
        ("ALIAS", "Keyword: assigns or references a work-area alias."),
        ("DO", "Command: runs a procedure, program, or form."),
        ("DO FORM", "Command: runs a form and enters its event lifecycle."),
        ("REPORT FORM", "Command: runs a report, often with PREVIEW."),
        ("LABEL FORM", "Command: runs a label layout."),
        ("SET", "Command: updates runtime state such as SAFETY, DELETED, EXCLUSIVE, and TALK."),
        ("SET DATASESSION TO", "Command: switches into a specific data session."),
        ("READ EVENTS", "Command: enters the event loop."),
        ("CLEAR EVENTS", "Command: exits the event loop."),
        ("PUBLIC", "Command: declares global variables."),
        ("LOCAL", "Command: declares local variables."),
        ("RETURN", "Command: returns from a procedure or function."),
        ("DEFINE CLASS", "Command: defines a class in source."),
        ("ENDDEFINE", "Command: ends a class definition."),
        ("IF", "Keyword: starts a conditional block."),
        ("ELSE", "Keyword: alternate branch within IF."),
        ("ENDIF", "Keyword: ends a conditional block."),
        ("FOR", "Keyword: starts a numeric loop."),
        ("ENDFOR", "Keyword: ends a numeric loop."),
        ("ON ERROR", "Command: installs an error handler."),
        ("CREATEOBJECT", "Function-style activation of a COM or Copperfin automation object."),
        ("GETOBJECT", "Function-style bind to an existing COM or moniker-based automation object."),
        ("SQLCONNECT", "Function: opens a SQL pass-through connection."),
        ("SQLSTRINGCONNECT", "Function: opens SQL pass-through with a raw connection string."),
        ("SQLEXEC", "Function: executes SQL pass-through and optionally materializes a cursor alias."),
        ("SQLDISCONNECT", "Function: closes a SQL pass-through connection.")
    };

    private static readonly (string Name, string Description)[] Functions =
    {
        ("ALIAS()", "Returns the current alias, or a named work area's alias when passed an argument."),
        ("SELECT()", "Returns the current work area, or resolves/selects a requested work area."),
        ("RECCOUNT()", "Returns the number of records in the current or named work area."),
        ("RECNO()", "Returns the current record number in the current or named work area."),
        ("EOF()", "Returns .T. when positioned after the last record."),
        ("BOF()", "Returns .T. when positioned before the first record."),
        ("ALLTRIM()", "Trims leading and trailing spaces."),
        ("JUSTPATH()", "Returns the directory portion of a path."),
        ("MESSAGE()", "Returns the current error message text."),
        ("MESSAGEBOX()", "Displays a dialog and returns the button choice."),
        ("SYS()", "Accesses VFP system services and metadata."),
        ("STR()", "Converts a number to a string."),
        ("DATE()", "Returns the current date."),
        ("DAY()", "Returns the day part of a date."),
        ("MONTH()", "Returns the month part of a date."),
        ("YEAR()", "Returns the year part of a date."),
        ("CMONTH()", "Returns the month name for a date."),
        ("IIF()", "Evaluates one of two expressions based on a condition."),
        ("FILE()", "Checks whether a file exists."),
        ("CURSORGETPROP()", "Returns metadata for an open cursor or remote cursor adapter."),
        ("CREATEOBJECT()", "Creates a COM or Copperfin automation object."),
        ("GETOBJECT()", "Binds to a running automation object or moniker.")
    };

    private static readonly (string Name, string Description)[] SetKeywords =
    {
        ("DELETED", "SET option controlling deleted-record visibility."),
        ("SAFETY", "SET option controlling overwrite prompts."),
        ("EXCLUSIVE", "SET option controlling shared/exclusive opens."),
        ("TALK", "SET option controlling command chatter."),
        ("EXACT", "SET option controlling exact string matching."),
        ("MULTILOCKS", "SET option controlling optimistic locking behavior."),
        ("PATH", "SET option controlling search paths."),
        ("DEFAULT TO", "SET subcommand for the default directory."),
        ("DATASESSION TO", "SET subcommand for the current data session.")
    };

    private static readonly (string Name, string Description)[] GenericObjectMembers =
    {
        ("Visible", "Common automation property controlling object visibility."),
        ("Caption", "Common automation property for title text."),
        ("Value", "Common automation property for current value."),
        ("Count", "Common automation property for collection size."),
        ("Item()", "Common automation method for retrieving a child item."),
        ("Add()", "Common automation method for creating or appending a child object."),
        ("Open()", "Common automation method for opening a child object or document."),
        ("Close()", "Common automation method for closing an object or document."),
        ("Execute()", "Common automation method for command-style invocation."),
        ("Refresh()", "Common automation method for refreshing state."),
        ("Quit()", "Common automation method for shutting down an automation server."),
        ("Workbooks", "Common Excel automation collection."),
        ("ActiveWorkbook", "Common Excel automation property."),
        ("Documents", "Common Office automation collection.")
    };

    private static readonly FoxProSignatureEntry[] SignatureEntries =
    {
        CreateSignature("ALIAS", "ALIAS([nWorkArea | cAlias])", "Returns the alias for the current or specified work area.", ("nWorkArea | cAlias", "Optional work area number or alias to resolve.")),
        CreateSignature("SELECT", "SELECT([nWorkArea | cAlias])", "Returns or resolves a work area by number or alias.", ("nWorkArea | cAlias", "Optional work area number or alias.")),
        CreateSignature("RECCOUNT", "RECCOUNT([cAlias])", "Returns the number of records in the current or named work area.", ("cAlias", "Optional alias to inspect.")),
        CreateSignature("RECNO", "RECNO([cAlias])", "Returns the current record number in the current or named work area.", ("cAlias", "Optional alias to inspect.")),
        CreateSignature("EOF", "EOF([cAlias])", "Returns .T. when positioned after the last record.", ("cAlias", "Optional alias to inspect.")),
        CreateSignature("BOF", "BOF([cAlias])", "Returns .T. when positioned before the first record.", ("cAlias", "Optional alias to inspect.")),
        CreateSignature("CREATEOBJECT", "CREATEOBJECT(cClass [, eInitParameter1 [, eInitParameterN]])", "Creates a COM or Copperfin automation object.", ("cClass", "ProgID or class name to instantiate."), ("eInitParameter1", "Optional constructor-style argument."), ("eInitParameterN", "Additional optional constructor-style arguments.")),
        CreateSignature("GETOBJECT", "GETOBJECT([cFileName] [, cClass])", "Binds to an existing automation object or document moniker.", ("cFileName", "Optional document path or moniker."), ("cClass", "Optional class or ProgID filter.")),
        CreateSignature("SQLCONNECT", "SQLCONNECT(cDataSourceName [, cUserId [, cPassword [, lShared]]])", "Opens an ODBC or connection-manager session for SQL pass-through.", ("cDataSourceName", "DSN or connection identifier."), ("cUserId", "Optional user name."), ("cPassword", "Optional password."), ("lShared", "Optional shared-connection flag.")),
        CreateSignature("SQLSTRINGCONNECT", "SQLSTRINGCONNECT(cConnectString [, lShared])", "Opens SQL pass-through with a raw connection string.", ("cConnectString", "Raw ODBC-style connection string."), ("lShared", "Optional shared-connection flag.")),
        CreateSignature("SQLEXEC", "SQLEXEC(nConnectionHandle, cCommand [, cCursorName])", "Executes SQL pass-through and optionally materializes a result cursor.", ("nConnectionHandle", "Connection handle returned by SQLCONNECT or SQLSTRINGCONNECT."), ("cCommand", "SQL text to execute."), ("cCursorName", "Optional target cursor alias.")),
        CreateSignature("SQLDISCONNECT", "SQLDISCONNECT([nConnectionHandle])", "Closes one SQL pass-through connection or all of them.", ("nConnectionHandle", "Optional connection handle to close.")),
        CreateSignature("CURSORGETPROP", "CURSORGETPROP(cProperty [, cCursorName])", "Returns metadata for a cursor or remote view.", ("cProperty", "Property name to query."), ("cCursorName", "Optional cursor alias.")),
        CreateSignature("MESSAGEBOX", "MESSAGEBOX(cMessage [, nDialogBoxType [, cTitleBarText]])", "Displays a modal dialog and returns the pressed button.", ("cMessage", "Message text to display."), ("nDialogBoxType", "Optional button/icon/style flags."), ("cTitleBarText", "Optional dialog title.")),
        CreateSignature("SYS", "SYS(nFunction [, eExpression1 [, eExpressionN]])", "Calls a Visual FoxPro system service by numeric identifier.", ("nFunction", "System function number."), ("eExpression1", "Optional first argument."), ("eExpressionN", "Additional optional arguments.")),
        CreateSignature("IIF", "IIF(lExpression, eTrueValue, eFalseValue)", "Returns one of two expressions based on a condition.", ("lExpression", "Condition to evaluate."), ("eTrueValue", "Value when the condition is true."), ("eFalseValue", "Value when the condition is false."))
    };

    private static readonly Dictionary<string, IReadOnlyList<FoxProSignatureEntry>> SignatureLookup =
        SignatureEntries.GroupBy(entry => NormalizeLookupToken(entry.Name), StringComparer.OrdinalIgnoreCase)
            .ToDictionary(group => group.Key, group => (IReadOnlyList<FoxProSignatureEntry>)group.ToList(), StringComparer.OrdinalIgnoreCase);

    private static readonly ConcurrentDictionary<string, ProjectSymbolIndex> Cache = new(StringComparer.OrdinalIgnoreCase);

    public static IReadOnlyList<FoxProCompletionEntry> BuildEntries(string? filePath, string linePrefix, string tokenPrefix)
    {
        var prefix = tokenPrefix ?? string.Empty;
        var completions = new Dictionary<string, FoxProCompletionEntry>(StringComparer.OrdinalIgnoreCase);
        AddEntries(completions, Keywords, "keyword");
        AddEntries(completions, Functions, "function");

        if (LooksLikeSetContext(linePrefix))
        {
            AddEntries(completions, SetKeywords, "set");
        }

        if (LooksLikeMemberAccess(linePrefix))
        {
            AddEntries(completions, GenericObjectMembers, "member");
        }

        if (!string.IsNullOrWhiteSpace(filePath))
        {
            var index = GetProjectIndex(filePath!);
            AddContextualProjectEntries(completions, index, linePrefix);
            AddSymbolEntries(completions, index);
        }

        return completions.Values
            .Where(entry => string.IsNullOrWhiteSpace(prefix) || entry.DisplayText.StartsWith(prefix, StringComparison.OrdinalIgnoreCase))
            .OrderBy(entry => RankKind(entry.Kind))
            .ThenBy(entry => entry.DisplayText, StringComparer.OrdinalIgnoreCase)
            .ToList();
    }

    public static string DescribeToken(string token)
    {
        return DescribeToken(null, token);
    }

    public static string DescribeToken(string? filePath, string token)
    {
        if (string.IsNullOrWhiteSpace(token))
        {
            return string.Empty;
        }

        var key = NormalizeLookupToken(token);
        foreach (var item in Keywords)
        {
            if (TokenMatches(item.Name, key))
            {
                return item.Description;
            }
        }

        foreach (var item in Functions)
        {
            if (TokenMatches(item.Name, key))
            {
                return item.Description;
            }
        }

        foreach (var item in SetKeywords)
        {
            if (TokenMatches(item.Name, key))
            {
                return item.Description;
            }
        }

        foreach (var item in GenericObjectMembers)
        {
            if (TokenMatches(item.Name, key))
            {
                return item.Description;
            }
        }

        if (!string.IsNullOrWhiteSpace(filePath))
        {
            var index = GetProjectIndex(filePath!);
            if (index.Procedures.Contains(key))
            {
                return "Project procedure or function symbol.";
            }

            if (index.Classes.Contains(key))
            {
                return "Project class symbol.";
            }

            if (index.Defines.Contains(key))
            {
                return "Project preprocessor symbol.";
            }

            if (index.Aliases.Contains(key))
            {
                return "Known work-area alias discovered in project source.";
            }

            if (index.Tables.Contains(key))
            {
                return "Project table or database asset.";
            }

            if (index.Forms.Contains(key))
            {
                return "Project form asset.";
            }

            if (index.Reports.Contains(key))
            {
                return "Project report asset.";
            }

            if (index.Labels.Contains(key))
            {
                return "Project label asset.";
            }

            if (index.Menus.Contains(key))
            {
                return "Project menu asset.";
            }
        }

        return string.Empty;
    }

    public static IReadOnlyList<FoxProSignatureEntry> GetSignatures(string? filePath, string invocationName)
    {
        var key = NormalizeLookupToken(invocationName);
        if (SignatureLookup.TryGetValue(key, out var signatures))
        {
            return signatures;
        }

        if (invocationName.Contains('.'))
        {
            var memberName = invocationName.Split('.').Last();
            if (SignatureLookup.TryGetValue(NormalizeLookupToken(memberName), out signatures))
            {
                return signatures;
            }
        }

        if (!string.IsNullOrWhiteSpace(filePath))
        {
            var index = GetProjectIndex(filePath!);
            if (index.Classes.Contains(key) || index.Procedures.Contains(key))
            {
                return Array.Empty<FoxProSignatureEntry>();
            }
        }

        return Array.Empty<FoxProSignatureEntry>();
    }

    public static bool TryResolveDefinition(string? filePath, string token, out FoxProDefinitionLocation definition)
    {
        definition = new FoxProDefinitionLocation();
        if (string.IsNullOrWhiteSpace(filePath) || string.IsNullOrWhiteSpace(token))
        {
            return false;
        }

        var index = GetProjectIndex(filePath!);
        if (TryResolveDefinition(index, NormalizeLookupToken(token), out definition))
        {
            return true;
        }

        if (token.Contains('.'))
        {
            var memberName = token.Split('.').Last();
            return TryResolveDefinition(index, NormalizeLookupToken(memberName), out definition);
        }

        return false;
    }

    private static void AddContextualProjectEntries(
        IDictionary<string, FoxProCompletionEntry> completions,
        ProjectSymbolIndex index,
        string linePrefix)
    {
        var upper = linePrefix.TrimStart().ToUpperInvariant();
        if (upper.StartsWith("DO FORM ", StringComparison.Ordinal))
        {
            AddEntries(completions, index.Forms.Select(name => (name, "Project form asset.")), "asset");
            return;
        }

        if (upper.StartsWith("REPORT FORM ", StringComparison.Ordinal))
        {
            AddEntries(completions, index.Reports.Select(name => (name, "Project report asset.")), "asset");
            return;
        }

        if (upper.StartsWith("LABEL FORM ", StringComparison.Ordinal))
        {
            AddEntries(completions, index.Labels.Select(name => (name, "Project label asset.")), "asset");
            return;
        }

        if (upper.StartsWith("USE ", StringComparison.Ordinal))
        {
            AddEntries(completions, index.Tables.Select(name => (name, "Project table or database asset.")), "asset");
            AddEntries(completions, index.Aliases.Select(name => (name, "Known alias from project source.")), "alias");
            return;
        }

        if (upper.StartsWith("SELECT ", StringComparison.Ordinal))
        {
            AddEntries(completions, index.Aliases.Select(name => (name, "Known work-area alias from project source.")), "alias");
            AddEntries(completions, index.Tables.Select(name => (name, "Project table or database asset.")), "asset");
            return;
        }

        if (upper.StartsWith("DO ", StringComparison.Ordinal) && !upper.StartsWith("DO FORM ", StringComparison.Ordinal))
        {
            AddEntries(completions, index.Procedures.Select(name => (name, "Procedure/function/program symbol in the active project.")), "symbol");
            AddEntries(completions, index.Menus.Select(name => (name, "Project menu asset.")), "asset");
        }
    }

    private static void AddSymbolEntries(IDictionary<string, FoxProCompletionEntry> completions, ProjectSymbolIndex index)
    {
        AddEntries(completions, index.Procedures.Select(name => (name, "Procedure/function symbol in the active project.")), "symbol");
        AddEntries(completions, index.Classes.Select(name => (name, "Class symbol in the active project.")), "class");
        AddEntries(completions, index.Defines.Select(name => (name, "Preprocessor symbol in the active project.")), "define");
        AddEntries(completions, index.Aliases.Select(name => (name, "Known alias from USE ... ALIAS statements.")), "alias");
    }

    private static bool LooksLikeSetContext(string linePrefix)
    {
        return linePrefix.TrimStart().StartsWith("SET ", StringComparison.OrdinalIgnoreCase);
    }

    private static bool LooksLikeMemberAccess(string linePrefix)
    {
        return MemberAccessRegex.IsMatch(linePrefix);
    }

    private static void AddEntries(
        IDictionary<string, FoxProCompletionEntry> completions,
        IEnumerable<(string Name, string Description)> source,
        string kind)
    {
        foreach (var item in source)
        {
            if (string.IsNullOrWhiteSpace(item.Name))
            {
                continue;
            }

            completions[item.Name] = new FoxProCompletionEntry
            {
                DisplayText = item.Name,
                InsertionText = item.Name,
                Description = item.Description,
                Kind = kind
            };
        }
    }

    private static ProjectSymbolIndex GetProjectIndex(string filePath)
    {
        var root = ResolveProjectRoot(filePath);
        return Cache.AddOrUpdate(
            root,
            _ => BuildProjectIndex(root),
            (_, existing) => existing.ShouldRefresh ? BuildProjectIndex(root) : existing);
    }

    private static ProjectSymbolIndex BuildProjectIndex(string root)
    {
        var index = new ProjectSymbolIndex
        {
            Root = root,
            BuiltAtUtc = DateTime.UtcNow
        };

        foreach (var file in EnumerateProjectFiles(root))
        {
            var extension = Path.GetExtension(file);
            if (FormExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
            {
                AddAsset(index.Forms, index, Path.GetFileNameWithoutExtension(file), "form asset", file, "Project form asset.");
                continue;
            }
            if (ReportExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
            {
                AddAsset(index.Reports, index, Path.GetFileNameWithoutExtension(file), "report asset", file, "Project report asset.");
                continue;
            }
            if (LabelExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
            {
                AddAsset(index.Labels, index, Path.GetFileNameWithoutExtension(file), "label asset", file, "Project label asset.");
                continue;
            }
            if (MenuExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
            {
                AddAsset(index.Menus, index, Path.GetFileNameWithoutExtension(file), "menu asset", file, "Project menu asset.");
                continue;
            }
            if (TableExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
            {
                AddAsset(index.Tables, index, Path.GetFileNameWithoutExtension(file), "table asset", file, "Project table or database asset.");
                continue;
            }
            if (!TextExtensions.Contains(extension, StringComparer.OrdinalIgnoreCase))
            {
                continue;
            }

            ScanTextFile(file, index);
        }

        return index;
    }

    private static void ScanTextFile(string path, ProjectSymbolIndex index)
    {
        string[] lines;
        try
        {
            lines = File.ReadAllLines(path);
        }
        catch
        {
            return;
        }

        for (var lineIndex = 0; lineIndex < lines.Length; lineIndex++)
        {
            var line = lines[lineIndex];
            AddMatch(index.Procedures, index.Definitions, ProcedureRegex, line, path, lineIndex + 1, "procedure", "Project procedure symbol.");
            AddMatch(index.Procedures, index.Definitions, FunctionRegex, line, path, lineIndex + 1, "function", "Project function symbol.");
            AddMatch(index.Defines, index.Definitions, DefineRegex, line, path, lineIndex + 1, "define", "Project preprocessor symbol.");
            AddMatch(index.Aliases, index.Definitions, UseAliasRegex, line, path, lineIndex + 1, "alias", "Known work-area alias discovered in project source.");

            var classMatch = DefineClassRegex.Match(line);
            if (classMatch.Success)
            {
                index.Classes.Add(classMatch.Groups[1].Value);
                TryAddDefinition(index.Definitions, classMatch.Groups[1].Value, "class", path, lineIndex + 1, classMatch.Groups[1].Index + 1, $"Project class symbol deriving from {classMatch.Groups[2].Value}.");
            }
        }
    }

    private static void AddMatch(
        ISet<string> bucket,
        IDictionary<string, FoxProDefinitionLocation> definitions,
        Regex regex,
        string line,
        string path,
        int lineNumber,
        string kind,
        string description)
    {
        var match = regex.Match(line);
        if (match.Success)
        {
            var name = match.Groups[1].Value;
            bucket.Add(name);
            TryAddDefinition(definitions, name, kind, path, lineNumber, match.Groups[1].Index + 1, description);
        }
    }

    private static IEnumerable<string> EnumerateProjectFiles(string root)
    {
        var pending = new Stack<string>();
        pending.Push(root);
        var count = 0;
        while (pending.Count > 0 && count < 2000)
        {
            var current = pending.Pop();
            IEnumerable<string> directories;
            try
            {
                directories = Directory.EnumerateDirectories(current);
            }
            catch
            {
                continue;
            }

            foreach (var directory in directories)
            {
                var name = Path.GetFileName(directory);
                if (IgnoredDirectories.Contains(name, StringComparer.OrdinalIgnoreCase))
                {
                    continue;
                }
                pending.Push(directory);
            }

            IEnumerable<string> files;
            try
            {
                files = Directory.EnumerateFiles(current);
            }
            catch
            {
                continue;
            }

            foreach (var file in files)
            {
                ++count;
                yield return file;
                if (count >= 2000)
                {
                    yield break;
                }
            }
        }
    }

    private static string ResolveProjectRoot(string filePath)
    {
        var directory = Path.GetDirectoryName(filePath);
        if (string.IsNullOrWhiteSpace(directory))
        {
            return Path.GetDirectoryName(filePath) ?? string.Empty;
        }

        var current = new DirectoryInfo(directory);
        for (var depth = 0; current is not null && depth < 8; depth++, current = current.Parent)
        {
            if (current.EnumerateFiles("*.pjx").Any() || current.EnumerateFiles("*.sln").Any())
            {
                return current.FullName;
            }
        }

        return directory;
    }

    private static int RankKind(string kind)
    {
        return kind switch
        {
            "symbol" => 0,
            "class" => 1,
            "alias" => 2,
            "asset" => 3,
            "function" => 4,
            "keyword" => 5,
            "set" => 6,
            "define" => 7,
            "member" => 8,
            _ => 9
        };
    }

    private static string NormalizeLookupToken(string token)
    {
        var normalized = token.Trim().TrimEnd('(', ')');
        return normalized.StartsWith("#", StringComparison.Ordinal) ? normalized : normalized.TrimStart('&');
    }

    private static bool TokenMatches(string candidate, string key)
    {
        if (string.Equals(candidate, key, StringComparison.OrdinalIgnoreCase))
        {
            return true;
        }

        var normalizedCandidate = NormalizeLookupToken(candidate);
        return string.Equals(normalizedCandidate, key, StringComparison.OrdinalIgnoreCase);
    }

    private static bool TryResolveDefinition(ProjectSymbolIndex index, string key, out FoxProDefinitionLocation definition)
    {
        if (index.Definitions.TryGetValue(key, out definition!))
        {
            return true;
        }

        definition = new FoxProDefinitionLocation();
        return false;
    }

    private static void AddAsset(
        ISet<string> bucket,
        ProjectSymbolIndex index,
        string name,
        string kind,
        string path,
        string description)
    {
        bucket.Add(name);
        TryAddDefinition(index.Definitions, name, kind, path, 1, 1, description);
    }

    private static void TryAddDefinition(
        IDictionary<string, FoxProDefinitionLocation> definitions,
        string name,
        string kind,
        string path,
        int lineNumber,
        int columnNumber,
        string description)
    {
        if (string.IsNullOrWhiteSpace(name) || definitions.ContainsKey(name))
        {
            return;
        }

        definitions[name] = new FoxProDefinitionLocation
        {
            Name = name,
            Kind = kind,
            FilePath = path,
            LineNumber = lineNumber,
            ColumnNumber = Math.Max(1, columnNumber),
            Description = description
        };
    }

    private static FoxProSignatureEntry CreateSignature(string name, string content, string documentation, params (string Name, string Documentation)[] parameters)
    {
        return new FoxProSignatureEntry
        {
            Name = name,
            Content = content,
            Documentation = documentation,
            Parameters = parameters.Select(parameter => new FoxProParameterEntry
            {
                Name = parameter.Name,
                Documentation = parameter.Documentation
            }).ToList()
        };
    }

    private sealed class ProjectSymbolIndex
    {
        public string Root { get; set; } = string.Empty;
        public DateTime BuiltAtUtc { get; set; }
        public HashSet<string> Procedures { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Classes { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Defines { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Aliases { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Tables { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Forms { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Reports { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Labels { get; } = new(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> Menus { get; } = new(StringComparer.OrdinalIgnoreCase);
        public Dictionary<string, FoxProDefinitionLocation> Definitions { get; } = new(StringComparer.OrdinalIgnoreCase);

        public bool ShouldRefresh => (DateTime.UtcNow - BuiltAtUtc) > TimeSpan.FromSeconds(15);
    }
}
