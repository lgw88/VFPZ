using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;

namespace Copperfin.VisualStudio;

internal sealed class StudioMainForm : Form
{
    private readonly TabControl documentTabs;
    private readonly ToolStripStatusLabel statusLabel;
    private readonly Dictionary<string, TabPage> openDocuments = new(StringComparer.OrdinalIgnoreCase);

    public StudioMainForm()
    {
        Text = "Copperfin Studio";
        Width = 1480;
        Height = 980;
        StartPosition = FormStartPosition.CenterScreen;

        var menuStrip = new MenuStrip();
        var fileMenu = new ToolStripMenuItem("&File");
        var openItem = new ToolStripMenuItem("&Open...", null, (_, _) => OpenFromPicker());
        var exitItem = new ToolStripMenuItem("E&xit", null, (_, _) => Close());
        fileMenu.DropDownItems.Add(openItem);
        fileMenu.DropDownItems.Add(new ToolStripSeparator());
        fileMenu.DropDownItems.Add(exitItem);
        menuStrip.Items.Add(fileMenu);
        MainMenuStrip = menuStrip;

        documentTabs = new TabControl
        {
            Dock = DockStyle.Fill,
            Alignment = TabAlignment.Top,
            Multiline = true
        };
        documentTabs.SelectedIndexChanged += (_, _) =>
        {
            if (documentTabs.SelectedTab is null)
            {
                UpdateStatus("Open one or more VFP assets to inspect and edit them in Copperfin Studio.");
                return;
            }

            UpdateStatus(documentTabs.SelectedTab.ToolTipText ?? documentTabs.SelectedTab.Text);
        };

        var statusStrip = new StatusStrip();
        statusLabel = new ToolStripStatusLabel
        {
            Text = "Open a VFP asset to inspect and edit it in Copperfin Studio."
        };
        statusStrip.Items.Add(statusLabel);

        Controls.Add(documentTabs);
        Controls.Add(statusStrip);
        Controls.Add(menuStrip);

        UpdateStatus("Open one or more VFP assets to inspect and edit them in Copperfin Studio.");
    }

    public void OpenDocument(string path)
    {
        if (!File.Exists(path))
        {
            MessageBox.Show(this, "The selected asset does not exist.", "Copperfin Studio", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            return;
        }

        var normalizedPath = Path.GetFullPath(path);
        if (openDocuments.TryGetValue(normalizedPath, out var existingPage))
        {
            documentTabs.SelectedTab = existingPage;
            UpdateStatus(existingPage.Text);
            return;
        }

        var editorControl = new CopperfinAssetEditorControl
        {
            Dock = DockStyle.Fill,
            EmbeddedStudioShell = true
        };

        var page = new TabPage(Path.GetFileName(normalizedPath))
        {
            ToolTipText = normalizedPath
        };
        page.Controls.Add(editorControl);
        documentTabs.TabPages.Add(page);
        documentTabs.SelectedTab = page;
        openDocuments[normalizedPath] = page;
        editorControl.LoadDocument(normalizedPath);

        Text = $"Copperfin Studio - {CopperfinStudioHostBridge.DescribeAssetKind(normalizedPath)}";
        UpdateStatus($"{normalizedPath}   |   {CopperfinStudioHostBridge.DescribeAssetKind(normalizedPath)}   |   Open tabs: {documentTabs.TabPages.Count}");
    }

    private void OpenFromPicker()
    {
        using var dialog = new OpenFileDialog
        {
            Title = "Open Copperfin Asset",
            Filter = "Copperfin/VFP assets|*.pjx;*.scx;*.vcx;*.frx;*.lbx;*.mnx|All files|*.*",
            Multiselect = false,
            RestoreDirectory = true
        };

        if (dialog.ShowDialog(this) == DialogResult.OK)
        {
            OpenDocument(dialog.FileName);
        }
    }

    private void UpdateStatus(string text)
    {
        statusLabel.Text = text;
    }
}
