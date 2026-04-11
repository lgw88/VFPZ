using System;
using System.IO;
using EnvDTE;
using Microsoft.VisualStudio.Shell;

namespace Copperfin.VisualStudio;

internal static class CopperfinStudioLauncher
{
    public static string? ResolveTargetPath(DTE dte)
    {
        ThreadHelper.ThrowIfNotOnUIThread();

        var activeDocumentPath = dte.ActiveDocument?.FullName;
        if (!string.IsNullOrWhiteSpace(activeDocumentPath) && File.Exists(activeDocumentPath))
        {
            return activeDocumentPath;
        }

        var selectedItems = dte.SelectedItems;
        if (selectedItems is null || selectedItems.Count <= 0)
        {
            return null;
        }

        for (var index = 1; index <= selectedItems.Count; ++index)
        {
            var selectedItem = selectedItems.Item(index);
            if (selectedItem?.ProjectItem is ProjectItem projectItem)
            {
                try
                {
                    for (short fileIndex = 1; fileIndex <= projectItem.FileCount; ++fileIndex)
                    {
                        var candidate = projectItem.FileNames[fileIndex];
                        if (!string.IsNullOrWhiteSpace(candidate) && File.Exists(candidate))
                        {
                            return candidate;
                        }
                    }
                }
                catch (ArgumentException)
                {
                    // Some project systems expose non-file nodes. Skip them.
                }
            }

            var projectPath = selectedItem?.Project?.FullName;
            if (!string.IsNullOrWhiteSpace(projectPath) && File.Exists(projectPath))
            {
                return projectPath;
            }
        }

        return null;
    }
}
