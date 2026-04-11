using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Windows.Forms;

namespace Copperfin.VisualStudio;

internal static class Program
{
    private static int failures;

    [STAThread]
    private static int Main()
    {
        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);

        SmokeDesignSurfaceWithSyntheticReportLayout();
        SmokeAssetEditorWithRealAsset(
            @"C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Reports\invoice.frx",
            expectSection: "Detail");
        SmokeAssetEditorWithRealAsset(
            @"C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Reports\cust.lbx",
            expectSection: "Detail");
        SmokeProjectEditorWithRealAsset(
            @"C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\solution.pjx",
            expectGroup: "Forms");
        SmokeProjectDebuggerWithRealAsset(
            @"C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\solution.pjx");
        SmokeStandaloneStudioWithMultipleAssets(
            @"C:\Program Files (x86)\Microsoft Visual FoxPro 9\Wizards\Template\Books\Forms\books.scx",
            @"C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Reports\invoice.frx");

        if (failures != 0)
        {
            Console.Error.WriteLine($"{failures} UI smoke test(s) failed.");
            return 1;
        }

        Console.WriteLine("All UI smoke tests passed.");
        return 0;
    }

    private static void SmokeDesignSurfaceWithSyntheticReportLayout()
    {
        using var surface = new CopperfinDesignSurfaceControl
        {
            Size = new Size(900, 700)
        };

        var objects = new List<CopperfinStudioSnapshotObject>
        {
            new CopperfinStudioSnapshotObject
            {
                RecordIndex = 6,
                Title = "customer.company",
                Properties = new List<CopperfinStudioSnapshotProperty>
                {
                    new() { Name = "HPOS", Value = "1200" },
                    new() { Name = "VPOS", Value = "2600" },
                    new() { Name = "WIDTH", Value = "4000" },
                    new() { Name = "HEIGHT", Value = "500" },
                    new() { Name = "EXPR", Value = "customer.company" }
                }
            }
        };

        var layout = new CopperfinStudioReportLayout
        {
            Sections = new List<CopperfinStudioReportSection>
            {
                new()
                {
                    Id = "detail_1",
                    Title = "Detail",
                    BandKind = "detail",
                    RecordIndex = 1,
                    Top = 2000,
                    Height = 5000,
                    Objects = new List<CopperfinStudioReportLayoutObject>
                    {
                        new()
                        {
                            RecordIndex = 6,
                            ObjectKind = "field",
                            Title = "customer.company",
                            Expression = "customer.company",
                            Left = 1200,
                            Top = 2600,
                            Width = 4000,
                            Height = 500
                        }
                    }
                }
            }
        };

        surface.LoadReportLayout(layout, objects);
        using var bitmap = new Bitmap(surface.Width, surface.Height);
        surface.DrawToBitmap(bitmap, new Rectangle(0, 0, bitmap.Width, bitmap.Height));
        Expect(CountNonWhitePixels(bitmap) > 5000, "synthetic report layout should render visible UI content");
    }

    private static void SmokeAssetEditorWithRealAsset(string path, string expectSection)
    {
        if (!File.Exists(path))
        {
            Console.WriteLine($"SKIP: {path} not found.");
            return;
        }

        using var hostForm = new Form
        {
            Width = 1400,
            Height = 1000,
            ShowInTaskbar = false,
            StartPosition = FormStartPosition.Manual,
            Location = new Point(-32000, -32000)
        };

        using var control = new CopperfinAssetEditorControl
        {
            Dock = DockStyle.Fill
        };

        hostForm.Controls.Add(control);
        hostForm.Show();
        Application.DoEvents();
        control.LoadDocument(path);

        var loaded = WaitUntil(
            TimeSpan.FromSeconds(8),
            () => FindListViews(control).Any(list => list.Items.Count > 0));
        Expect(loaded, $"editor should load snapshot data for {path}");

        var sectionFound = FindListViews(control)
            .SelectMany(list => list.Items.Cast<ListViewItem>())
            .Any(item => string.Equals(item.Text, expectSection, StringComparison.OrdinalIgnoreCase) ||
                         item.Text.IndexOf(expectSection, StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(sectionFound, $"editor should surface section '{expectSection}' for {path}");

        var designSurface = FindDesignSurface(control);
        Expect(designSurface is not null, $"design surface should exist for {path}");
        if (designSurface is not null)
        {
            using var bitmap = new Bitmap(Math.Max(1, designSurface.Width), Math.Max(1, designSurface.Height));
            designSurface.DrawToBitmap(bitmap, new Rectangle(0, 0, bitmap.Width, bitmap.Height));
            Expect(CountNonWhitePixels(bitmap) > 5000, $"design surface should render visible content for {path}");
        }

        TearDownForm(hostForm);
    }

    private static void SmokeProjectEditorWithRealAsset(string path, string expectGroup)
    {
        if (!File.Exists(path))
        {
            Console.WriteLine($"SKIP: {path} not found.");
            return;
        }

        using var hostForm = new Form
        {
            Width = 1400,
            Height = 1000,
            ShowInTaskbar = false,
            StartPosition = FormStartPosition.Manual,
            Location = new Point(-32000, -32000)
        };

        using var control = new CopperfinAssetEditorControl
        {
            Dock = DockStyle.Fill
        };

        hostForm.Controls.Add(control);
        hostForm.Show();
        Application.DoEvents();
        control.LoadDocument(path);

        var loaded = WaitUntil(
            TimeSpan.FromSeconds(8),
            () => FindListViews(control).Any(list => list.Items.Count > 0) &&
                  FindRichTextBoxes(control).Any(box => !string.IsNullOrWhiteSpace(box.Text)));
        Expect(loaded, $"project editor should load grouped workspace data for {path}");

        var groupFound = FindListViews(control)
            .SelectMany(list => list.Items.Cast<ListViewItem>())
            .Any(item => string.Equals(item.Text, expectGroup, StringComparison.OrdinalIgnoreCase));
        Expect(groupFound, $"project editor should surface group '{expectGroup}' for {path}");

        var projectButtons = FindButtons(control).Select(button => button.Text).ToList();
        Expect(projectButtons.Contains("Build Copperfin Project"), $"project editor should expose a build command for {path}");
        Expect(projectButtons.Contains("Run Copperfin Project"), $"project editor should expose a run command for {path}");
        Expect(projectButtons.Contains("Debug Copperfin Project"), $"project editor should expose a debug command for {path}");

        var summary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Project Workspace", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(summary is not null, $"project editor should surface a workspace summary for {path}");
        if (summary is not null)
        {
            Expect(summary.Text.IndexOf("Planned Output:", StringComparison.OrdinalIgnoreCase) >= 0,
                $"project workspace summary should include a build output for {path}");
            Expect(summary.Text.IndexOf("Startup Item:", StringComparison.OrdinalIgnoreCase) >= 0,
                $"project workspace summary should include a startup item for {path}");
            Expect(summary.Text.IndexOf("Native Security:", StringComparison.OrdinalIgnoreCase) >= 0,
                $"project workspace summary should include native security for {path}");
            Expect(summary.Text.IndexOf(".NET And Extensibility:", StringComparison.OrdinalIgnoreCase) >= 0,
                $"project workspace summary should include .NET/extensibility guidance for {path}");
        }

        var taskListSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Task List", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(taskListSummary is not null, $"project editor should surface a task-list pane for {path}");

        var codeReferenceSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Code References", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(codeReferenceSummary is not null, $"project editor should surface a code-references pane for {path}");

        var dataExplorerSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Data Explorer", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(dataExplorerSummary is not null, $"project editor should surface a data-explorer pane for {path}");

        var objectBrowserSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Object Browser", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(objectBrowserSummary is not null, $"project editor should surface an object-browser pane for {path}");

        var toolboxSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Toolbox And Add-ins", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(toolboxSummary is not null, $"project editor should surface a toolbox pane for {path}");

        var buildersSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Builders", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(buildersSummary is not null, $"project editor should surface a builders pane for {path}");

        var coverageSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Coverage", StringComparison.OrdinalIgnoreCase) >= 0 ||
                                   box.Text.IndexOf("runtime coverage signals", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(coverageSummary is not null, $"project editor should surface a coverage pane for {path}");

        var databaseSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Database Federation", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(databaseSummary is not null, $"project editor should surface a database pane for {path}");

        TearDownForm(hostForm);
    }

    private static void SmokeProjectDebuggerWithRealAsset(string path)
    {
        if (!File.Exists(path))
        {
            Console.WriteLine($"SKIP: {path} not found.");
            return;
        }

        using var hostForm = new Form
        {
            Width = 1400,
            Height = 1000,
            ShowInTaskbar = false,
            StartPosition = FormStartPosition.Manual,
            Location = new Point(-32000, -32000)
        };

        using var control = new CopperfinAssetEditorControl
        {
            Dock = DockStyle.Fill
        };

        hostForm.Controls.Add(control);
        hostForm.Show();
        Application.DoEvents();
        control.LoadDocument(path);

        var loaded = WaitUntil(
            TimeSpan.FromSeconds(8),
            () => FindButtons(control).Any(button => button.Text == "Debug Copperfin Project"));
        Expect(loaded, $"project debugger command should load for {path}");

        var debugButton = FindButtons(control).FirstOrDefault(button => button.Text == "Debug Copperfin Project");
        if (debugButton is null)
        {
            TearDownForm(hostForm);
            return;
        }

        debugButton.PerformClick();
        var debugLoaded = WaitUntil(
            TimeSpan.FromSeconds(30),
            () => FindRichTextBoxes(control)
                .Any(box => box.Text.IndexOf("Copperfin Debug Session", StringComparison.OrdinalIgnoreCase) >= 0 &&
                            box.Text.IndexOf("Pause Reason:", StringComparison.OrdinalIgnoreCase) >= 0));
        Expect(debugLoaded, $"project debugger should surface a runtime pause state for {path}");

        var debuggerSummary = FindRichTextBoxes(control)
            .FirstOrDefault(box => box.Text.IndexOf("Copperfin Debug Session", StringComparison.OrdinalIgnoreCase) >= 0);
        Expect(debuggerSummary is not null, $"project debugger should surface a debug summary for {path}");
        if (debuggerSummary is not null)
        {
            Expect(debuggerSummary.Text.IndexOf("Call Stack:", StringComparison.OrdinalIgnoreCase) >= 0,
                $"project debugger should include a call stack for {path}");
            Expect(debuggerSummary.Text.IndexOf("Runtime Events:", StringComparison.OrdinalIgnoreCase) >= 0,
                $"project debugger should include runtime events for {path}");
        }

        TearDownForm(hostForm);
    }

    private static void SmokeStandaloneStudioWithMultipleAssets(string firstPath, string secondPath)
    {
        if (!File.Exists(firstPath) || !File.Exists(secondPath))
        {
            Console.WriteLine($"SKIP: {firstPath} or {secondPath} not found.");
            return;
        }

        using var form = new StudioMainForm
        {
            Width = 1500,
            Height = 1000,
            ShowInTaskbar = false,
            StartPosition = FormStartPosition.Manual,
            Location = new Point(-32000, -32000)
        };

        form.Show();
        Application.DoEvents();
        form.OpenDocument(firstPath);
        form.OpenDocument(secondPath);

        var loaded = WaitUntil(
            TimeSpan.FromSeconds(10),
            () => FindTabControls(form).Any(tab => tab.TabPages.Count >= 2) &&
                  FindTabControls(form).SelectMany(tab => tab.TabPages.Cast<TabPage>())
                      .Any(page => page.Text.Equals(Path.GetFileName(firstPath), StringComparison.OrdinalIgnoreCase)) &&
                  FindTabControls(form).SelectMany(tab => tab.TabPages.Cast<TabPage>())
                      .Any(page => page.Text.Equals(Path.GetFileName(secondPath), StringComparison.OrdinalIgnoreCase)));
        Expect(loaded, "standalone Studio should open multiple assets as separate tabs");

        var tabControl = FindTabControls(form).FirstOrDefault();
        Expect(tabControl is not null, "standalone Studio should surface a document tab control");
        if (tabControl is not null)
        {
            var beforeDuplicateOpen = tabControl.TabPages.Count;
            form.OpenDocument(firstPath);
            Application.DoEvents();
            Expect(tabControl.TabPages.Count == beforeDuplicateOpen, "opening an already open asset should not duplicate tabs");
            Expect(tabControl.SelectedTab is not null, "standalone Studio should keep a selected tab");
            Expect(tabControl.SelectedTab?.Text == Path.GetFileName(firstPath) || tabControl.SelectedTab?.Text == Path.GetFileName(secondPath),
                "standalone Studio should keep a valid selected asset tab");
        }

        TearDownForm(form);
    }

    private static void TearDownForm(Form form)
    {
        if (form.IsDisposed)
        {
            return;
        }

        form.Hide();
        Application.DoEvents();
        Thread.Sleep(150);
        Application.DoEvents();
        form.Close();
        Application.DoEvents();
    }

    private static bool WaitUntil(TimeSpan timeout, Func<bool> condition)
    {
        var deadline = DateTime.UtcNow + timeout;
        while (DateTime.UtcNow < deadline)
        {
            Application.DoEvents();
            if (condition())
            {
                return true;
            }

            Thread.Sleep(50);
        }

        Application.DoEvents();
        return condition();
    }

    private static IEnumerable<ListView> FindListViews(Control root)
    {
        foreach (Control child in root.Controls)
        {
            if (child is ListView listView)
            {
                yield return listView;
            }

            foreach (var nested in FindListViews(child))
            {
                yield return nested;
            }
        }
    }

    private static CopperfinDesignSurfaceControl? FindDesignSurface(Control root)
    {
        foreach (Control child in root.Controls)
        {
            if (child is CopperfinDesignSurfaceControl surface)
            {
                return surface;
            }

            var nested = FindDesignSurface(child);
            if (nested is not null)
            {
                return nested;
            }
        }

        return null;
    }

    private static IEnumerable<RichTextBox> FindRichTextBoxes(Control root)
    {
        foreach (Control child in root.Controls)
        {
            if (child is RichTextBox textBox)
            {
                yield return textBox;
            }

            foreach (var nested in FindRichTextBoxes(child))
            {
                yield return nested;
            }
        }
    }

    private static IEnumerable<TabControl> FindTabControls(Control root)
    {
        foreach (Control child in root.Controls)
        {
            if (child is TabControl tabControl)
            {
                yield return tabControl;
            }

            foreach (var nested in FindTabControls(child))
            {
                yield return nested;
            }
        }
    }

    private static int CountNonWhitePixels(Bitmap bitmap)
    {
        var count = 0;
        for (var y = 0; y < bitmap.Height; y += 2)
        {
            for (var x = 0; x < bitmap.Width; x += 2)
            {
                if (bitmap.GetPixel(x, y).ToArgb() != Color.White.ToArgb())
                {
                    count++;
                }
            }
        }

        return count;
    }

    private static IEnumerable<Button> FindButtons(Control root)
    {
        foreach (Control child in root.Controls)
        {
            if (child is Button button)
            {
                yield return button;
            }

            foreach (var nested in FindButtons(child))
            {
                yield return nested;
            }
        }
    }

    private static void Expect(bool condition, string message)
    {
        if (condition)
        {
            Console.WriteLine("PASS: " + message);
            return;
        }

        Console.Error.WriteLine("FAIL: " + message);
        failures++;
    }
}
