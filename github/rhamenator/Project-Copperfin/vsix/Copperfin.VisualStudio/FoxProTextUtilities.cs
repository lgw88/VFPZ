using System;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Editor;

namespace Copperfin.VisualStudio;

internal readonly struct FoxProInvocationContext
{
    public FoxProInvocationContext(string invocationName, Span invocationSpan, int parameterIndex)
    {
        InvocationName = invocationName;
        InvocationSpan = invocationSpan;
        ParameterIndex = parameterIndex;
    }

    public string InvocationName { get; }
    public Span InvocationSpan { get; }
    public int ParameterIndex { get; }
}

internal static class FoxProTextUtilities
{
    public static Span FindTokenSpan(ITextSnapshot snapshot, int position)
    {
        if (snapshot.Length == 0)
        {
            return new Span(0, 0);
        }

        var adjustedPosition = Math.Max(0, Math.Min(position, snapshot.Length - 1));
        if (!IsTokenCharacter(snapshot[adjustedPosition]) && adjustedPosition > 0 && IsTokenCharacter(snapshot[adjustedPosition - 1]))
        {
            adjustedPosition--;
        }

        if (!IsTokenCharacter(snapshot[adjustedPosition]))
        {
            return new Span(position, 0);
        }

        var start = adjustedPosition;
        while (start > 0 && IsTokenCharacter(snapshot[start - 1]))
        {
            start--;
        }

        var end = adjustedPosition;
        while (end < snapshot.Length && IsTokenCharacter(snapshot[end]))
        {
            end++;
        }

        return Span.FromBounds(start, end);
    }

    public static string? TryGetTokenAtCaret(ITextView textView, out Span span)
    {
        var snapshot = textView.TextSnapshot;
        var caretPosition = textView.Caret.Position.BufferPosition.Position;
        span = FindTokenSpan(snapshot, caretPosition);
        if (span.Length == 0)
        {
            return null;
        }

        var token = snapshot.GetText(span);
        return string.IsNullOrWhiteSpace(token) ? null : token;
    }

    public static bool TryFindInvocationContext(ITextSnapshot snapshot, int position, out FoxProInvocationContext context)
    {
        context = default;
        if (snapshot.Length == 0)
        {
            return false;
        }

        var scanPosition = Math.Max(0, Math.Min(position, snapshot.Length));
        var depth = 0;
        var openParen = -1;
        for (var index = scanPosition - 1; index >= 0; index--)
        {
            var value = snapshot[index];
            if (value == ')')
            {
                depth++;
                continue;
            }

            if (value == '(')
            {
                if (depth == 0)
                {
                    openParen = index;
                    break;
                }

                depth--;
            }
        }

        if (openParen < 1)
        {
            return false;
        }

        var end = openParen;
        while (end > 0 && char.IsWhiteSpace(snapshot[end - 1]))
        {
            end--;
        }

        var start = end;
        while (start > 0 && IsTokenCharacter(snapshot[start - 1]))
        {
            start--;
        }

        if (start == end)
        {
            return false;
        }

        var rawName = snapshot.GetText(Span.FromBounds(start, end));
        if (string.IsNullOrWhiteSpace(rawName))
        {
            return false;
        }

        var parameterIndex = CountParameters(snapshot, openParen + 1, scanPosition);
        context = new FoxProInvocationContext(rawName, Span.FromBounds(start, end), parameterIndex);
        return true;
    }

    public static bool IsTokenCharacter(char value)
    {
        return char.IsLetterOrDigit(value) || value == '_' || value == '.' || value == '#';
    }

    private static int CountParameters(ITextSnapshot snapshot, int start, int end)
    {
        var parameterIndex = 0;
        var depth = 0;
        for (var index = start; index < end && index < snapshot.Length; index++)
        {
            var value = snapshot[index];
            if (value == '(')
            {
                depth++;
                continue;
            }

            if (value == ')')
            {
                if (depth > 0)
                {
                    depth--;
                }

                continue;
            }

            if (value == ',' && depth == 0)
            {
                parameterIndex++;
            }
        }

        return parameterIndex;
    }
}
