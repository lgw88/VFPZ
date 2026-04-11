using System;
using System.IO;
using EnvDTE;
using Microsoft.VisualStudio.Shell;

namespace Copperfin.VisualStudio;

internal static class CopperfinProjectSelection
{
    public static string? ResolveProjectPath(DTE? dte)
    {
        ThreadHelper.ThrowIfNotOnUIThread();

        var activeDocumentPath = dte?.ActiveDocument?.FullName;
        if (CopperfinProjectWorkflow.IsCopperfinProjectPath(activeDocumentPath) && File.Exists(activeDocumentPath))
        {
            return activeDocumentPath;
        }

        var selectedItems = dte?.SelectedItems;
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
                        if (CopperfinProjectWorkflow.IsCopperfinProjectPath(candidate) && File.Exists(candidate))
                        {
                            return candidate;
                        }
                    }
                }
                catch (ArgumentException)
                {
                }
            }

            var projectPath = selectedItem?.Project?.FullName;
            if (CopperfinProjectWorkflow.IsCopperfinProjectPath(projectPath) && File.Exists(projectPath))
            {
                return projectPath;
            }
        }

        return null;
    }
}
