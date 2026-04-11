using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Copperfin.VisualStudio;

internal sealed class CopperfinDesignSurfaceControl : Control
{
    private sealed class SurfaceObject
    {
        public CopperfinStudioSnapshotObject Source { get; set; } = null!;
        public RectangleF Bounds { get; set; }
        public Rectangle PixelBounds { get; set; }
        public string Caption { get; set; } = string.Empty;
    }

    private sealed class ReportSectionVisual
    {
        public string Title { get; set; } = string.Empty;
        public string BandKind { get; set; } = string.Empty;
        public int Top { get; set; }
        public int Height { get; set; }
        public Rectangle PixelBounds { get; set; }
        public Rectangle HeaderBounds { get; set; }
        public List<SurfaceObject> Objects { get; } = new();
    }

    private readonly List<SurfaceObject> objects = new();
    private readonly List<ReportSectionVisual> reportSections = new();
    private string assetFamily = string.Empty;
    private int? selectedRecordIndex;
    private int? dragRecordIndex;
    private Point lastMousePoint;
    private CopperfinStudioReportLayout? reportLayout;

    public event Action<int>? SelectedRecordChanged;
    public event Action<int, int, int>? ObjectMoved;

    public CopperfinDesignSurfaceControl()
    {
        DoubleBuffered = true;
        BackColor = Color.White;
        MinimumSize = new Size(400, 260);
    }

    public void LoadObjects(string assetFamily, IReadOnlyList<CopperfinStudioSnapshotObject> snapshotObjects)
    {
        this.assetFamily = assetFamily ?? string.Empty;
        reportLayout = null;
        reportSections.Clear();
        objects.Clear();
        foreach (var snapshotObject in snapshotObjects)
        {
            if (!TryBuildBounds(this.assetFamily, snapshotObject, out var bounds))
            {
                continue;
            }

            objects.Add(new SurfaceObject
            {
                Source = snapshotObject,
                Bounds = bounds,
                PixelBounds = Rectangle.Empty,
                Caption = ExtractCaption(this.assetFamily, snapshotObject)
            });
        }

        Invalidate();
    }

    public void LoadReportLayout(CopperfinStudioReportLayout layout, IReadOnlyList<CopperfinStudioSnapshotObject> snapshotObjects)
    {
        assetFamily = layout.IsLabel ? "label" : "report";
        reportLayout = layout;
        reportSections.Clear();
        objects.Clear();

        var lookup = snapshotObjects.ToDictionary(item => item.RecordIndex);
        foreach (var section in layout.Sections)
        {
            var visual = new ReportSectionVisual
            {
                Title = section.Title,
                BandKind = section.BandKind,
                Top = section.Top,
                Height = Math.Max(400, section.Height)
            };

            foreach (var layoutObject in section.Objects)
            {
                if (!lookup.TryGetValue(layoutObject.RecordIndex, out var snapshotObject))
                {
                    continue;
                }

                var bounds = new RectangleF(
                    layoutObject.Left,
                    layoutObject.Top,
                    Math.Max(120, layoutObject.Width),
                    Math.Max(120, layoutObject.Height));

                var surfaceObject = new SurfaceObject
                {
                    Source = snapshotObject,
                    Bounds = bounds,
                    PixelBounds = Rectangle.Empty,
                    Caption = string.IsNullOrWhiteSpace(layoutObject.Title)
                        ? ExtractCaption(assetFamily, snapshotObject)
                        : layoutObject.Title
                };

                visual.Objects.Add(surfaceObject);
                objects.Add(surfaceObject);
            }

            reportSections.Add(visual);
        }

        Invalidate();
    }

    public void SelectRecord(int? recordIndex)
    {
        selectedRecordIndex = recordIndex;
        Invalidate();
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        base.OnPaint(e);

        e.Graphics.Clear(BackColor);
        e.Graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;

        if (reportLayout is not null && reportSections.Count > 0)
        {
            PaintReportLayout(e);
            return;
        }

        PaintGenericLayout(e);
    }

    protected override void OnMouseDown(MouseEventArgs e)
    {
        base.OnMouseDown(e);

        var hit = objects.LastOrDefault(item => item.PixelBounds.Contains(e.Location));
        if (hit is null)
        {
            return;
        }

        selectedRecordIndex = hit.Source.RecordIndex;
        dragRecordIndex = hit.Source.RecordIndex;
        lastMousePoint = e.Location;
        SelectedRecordChanged?.Invoke(hit.Source.RecordIndex);
        Invalidate();
    }

    protected override void OnMouseMove(MouseEventArgs e)
    {
        base.OnMouseMove(e);

        if (dragRecordIndex is null || e.Button != MouseButtons.Left)
        {
            return;
        }

        Cursor = Cursors.SizeAll;
    }

    protected override void OnMouseUp(MouseEventArgs e)
    {
        base.OnMouseUp(e);

        if (dragRecordIndex is null)
        {
            return;
        }

        Cursor = Cursors.Default;

        var moved = objects.FirstOrDefault(item => item.Source.RecordIndex == dragRecordIndex.Value);
        if (moved is null)
        {
            dragRecordIndex = null;
            return;
        }

        var scale = reportLayout is not null
            ? CalculateReportScale()
            : CalculateGenericScale();

        var deltaX = e.Location.X - lastMousePoint.X;
        var deltaY = e.Location.Y - lastMousePoint.Y;
        if (Math.Abs(deltaX) > 0 || Math.Abs(deltaY) > 0)
        {
            var (horizontalName, verticalName) = GetCoordinatePropertyNames(assetFamily);
            var left = ExtractNumericProperty(moved.Source, horizontalName);
            var top = ExtractNumericProperty(moved.Source, verticalName);
            if (left.HasValue && top.HasValue)
            {
                var newLeft = Math.Max(0, (int)Math.Round(left.Value + (deltaX / Math.Max(0.2F, scale))));
                var newTop = Math.Max(0, (int)Math.Round(top.Value + (deltaY / Math.Max(0.2F, scale))));
                ObjectMoved?.Invoke(moved.Source.RecordIndex, newLeft, newTop);
            }
        }

        dragRecordIndex = null;
    }

    private void PaintGenericLayout(PaintEventArgs e)
    {
        if (objects.Count == 0)
        {
            using var brush = new SolidBrush(Color.FromArgb(96, 102, 118));
            e.Graphics.DrawString(
                "No visual objects with layout coordinates are available yet.",
                Font,
                brush,
                new RectangleF(24, 24, Width - 48, Height - 48));
            return;
        }

        var logicalBounds = CalculateLogicalBounds();
        const float padding = 24.0F;
        var availableWidth = Math.Max(80.0F, Width - (padding * 2.0F));
        var availableHeight = Math.Max(80.0F, Height - (padding * 2.0F));
        var scaleX = availableWidth / Math.Max(1.0F, logicalBounds.Width);
        var scaleY = availableHeight / Math.Max(1.0F, logicalBounds.Height);
        var scale = Math.Max(0.2F, Math.Min(scaleX, scaleY));

        using var gridPen = new Pen(Color.FromArgb(236, 239, 244));
        for (var x = padding; x < Width - padding; x += 24)
        {
            e.Graphics.DrawLine(gridPen, x, padding, x, Height - padding);
        }
        for (var y = padding; y < Height - padding; y += 24)
        {
            e.Graphics.DrawLine(gridPen, padding, y, Width - padding, y);
        }

        for (var index = 0; index < objects.Count; ++index)
        {
            var item = objects[index];
            var pixelBounds = new Rectangle(
                (int)Math.Round(padding + ((item.Bounds.Left - logicalBounds.Left) * scale)),
                (int)Math.Round(padding + ((item.Bounds.Top - logicalBounds.Top) * scale)),
                Math.Max(24, (int)Math.Round(item.Bounds.Width * scale)),
                Math.Max(18, (int)Math.Round(item.Bounds.Height * scale)));

            item.PixelBounds = pixelBounds;
            objects[index] = item;
            DrawSurfaceObject(e.Graphics, item, selectedRecordIndex == item.Source.RecordIndex, assetFamily);
        }
    }

    private void PaintReportLayout(PaintEventArgs e)
    {
        using var pageFill = new SolidBrush(Color.FromArgb(248, 249, 252));
        using var pageBorder = new Pen(Color.FromArgb(210, 214, 222));
        using var textBrush = new SolidBrush(Color.FromArgb(53, 58, 68));
        using var sectionFill = new SolidBrush(Color.FromArgb(255, 255, 255));
        using var sectionBorder = new Pen(Color.FromArgb(212, 218, 228));
        using var sectionHeaderFill = new SolidBrush(Color.FromArgb(233, 238, 247));
        using var sectionHeaderText = new SolidBrush(Color.FromArgb(44, 52, 64));

        const int outerPadding = 24;
        const int headerHeight = 28;
        const int sectionSpacing = 12;
        const int sectionInnerPadding = 12;
        const int leftGutter = 32;

        var maxRight = reportSections
            .SelectMany(section => section.Objects)
            .Select(item => item.Bounds.Right)
            .DefaultIfEmpty(40000.0F)
            .Max();
        var totalSectionHeight = reportSections.Sum(section => Math.Max(400, section.Height)) +
                                 (reportSections.Count * (headerHeight + sectionSpacing + sectionInnerPadding * 2));

        var availableWidth = Math.Max(400, Width - (outerPadding * 2) - leftGutter);
        var availableHeight = Math.Max(200, Height - (outerPadding * 2));
        var scaleX = availableWidth / Math.Max(1.0F, maxRight);
        var scaleY = availableHeight / Math.Max(1.0F, totalSectionHeight);
        var scale = Math.Max(0.12F, Math.Min(scaleX, scaleY));

        var pageBounds = new Rectangle(
            outerPadding,
            outerPadding,
            Width - (outerPadding * 2),
            Height - (outerPadding * 2));
        e.Graphics.FillRectangle(pageFill, pageBounds);
        e.Graphics.DrawRectangle(pageBorder, pageBounds);

        var currentY = outerPadding + 12;
        for (var sectionIndex = 0; sectionIndex < reportSections.Count; ++sectionIndex)
        {
            var section = reportSections[sectionIndex];
            var scaledHeight = Math.Max(72, (int)Math.Round(Math.Max(400, section.Height) * scale));
            var sectionBounds = new Rectangle(
                outerPadding + leftGutter,
                currentY,
                Math.Max(180, (int)Math.Round(maxRight * scale)),
                headerHeight + (sectionInnerPadding * 2) + scaledHeight);
            var headerBounds = new Rectangle(sectionBounds.X, sectionBounds.Y, sectionBounds.Width, headerHeight);

            section.PixelBounds = sectionBounds;
            section.HeaderBounds = headerBounds;

            e.Graphics.FillRectangle(sectionFill, sectionBounds);
            e.Graphics.DrawRectangle(sectionBorder, sectionBounds);
            e.Graphics.FillRectangle(sectionHeaderFill, headerBounds);
            e.Graphics.DrawRectangle(sectionBorder, headerBounds);

            e.Graphics.DrawString(section.Title, Font, sectionHeaderText, headerBounds.X + 10, headerBounds.Y + 6);
            using (var smallFont = new Font(Font.FontFamily, Math.Max(8.0F, Font.Size - 1.0F), FontStyle.Regular))
            {
                e.Graphics.DrawString(
                    section.BandKind.Replace('_', ' '),
                    smallFont,
                    textBrush,
                    headerBounds.Right - 140,
                    headerBounds.Y + 7);
            }

            var bodyTop = headerBounds.Bottom + sectionInnerPadding;
            foreach (var item in section.Objects)
            {
                var relativeTop = Math.Max(0, item.Bounds.Top - section.Top);
                item.PixelBounds = new Rectangle(
                    sectionBounds.X + 12 + (int)Math.Round(item.Bounds.Left * scale),
                    bodyTop + (int)Math.Round(relativeTop * scale),
                    Math.Max(30, (int)Math.Round(item.Bounds.Width * scale)),
                    Math.Max(18, (int)Math.Round(item.Bounds.Height * scale)));
                DrawSurfaceObject(e.Graphics, item, selectedRecordIndex == item.Source.RecordIndex, assetFamily);
            }

            using var gutterBrush = new SolidBrush(Color.FromArgb(118, 128, 142));
            e.Graphics.DrawString($"{sectionIndex + 1}", Font, gutterBrush, outerPadding + 6, currentY + 6);
            currentY += sectionBounds.Height + sectionSpacing;
        }
    }

    private static void DrawSurfaceObject(Graphics graphics, SurfaceObject item, bool selected, string assetFamily)
    {
        var fillColor = assetFamily switch
        {
            "report" => selected ? Color.FromArgb(254, 220, 188) : Color.FromArgb(214, 230, 250),
            "label" => selected ? Color.FromArgb(255, 230, 192) : Color.FromArgb(224, 239, 214),
            _ => selected ? Color.FromArgb(255, 211, 171) : Color.FromArgb(205, 223, 247)
        };
        var borderColor = assetFamily switch
        {
            "report" => selected ? Color.FromArgb(174, 86, 24) : Color.FromArgb(52, 97, 164),
            "label" => selected ? Color.FromArgb(152, 86, 12) : Color.FromArgb(64, 122, 70),
            _ => selected ? Color.FromArgb(201, 96, 36) : Color.FromArgb(68, 114, 196)
        };

        using var fill = new SolidBrush(fillColor);
        using var border = new Pen(borderColor, selected ? 2.2F : 1.4F);
        using var textBrush = new SolidBrush(Color.FromArgb(28, 32, 39));
        graphics.FillRectangle(fill, item.PixelBounds);
        graphics.DrawRectangle(border, item.PixelBounds);

        var captionBounds = new RectangleF(
            item.PixelBounds.X + 4,
            item.PixelBounds.Y + 3,
            item.PixelBounds.Width - 8,
            item.PixelBounds.Height - 6);
        graphics.DrawString(item.Caption, SystemFonts.MessageBoxFont, textBrush, captionBounds);
    }

    private float CalculateGenericScale()
    {
        if (objects.Count == 0)
        {
            return 1.0F;
        }

        var logicalBounds = CalculateLogicalBounds();
        const float padding = 24.0F;
        var availableWidth = Math.Max(80.0F, Width - (padding * 2.0F));
        var availableHeight = Math.Max(80.0F, Height - (padding * 2.0F));
        var scaleX = availableWidth / Math.Max(1.0F, logicalBounds.Width);
        var scaleY = availableHeight / Math.Max(1.0F, logicalBounds.Height);
        return Math.Max(0.2F, Math.Min(scaleX, scaleY));
    }

    private float CalculateReportScale()
    {
        if (reportSections.Count == 0)
        {
            return 1.0F;
        }

        const int outerPadding = 24;
        const int leftGutter = 32;
        const int headerHeight = 28;
        const int sectionSpacing = 12;
        const int sectionInnerPadding = 12;

        var maxRight = reportSections
            .SelectMany(section => section.Objects)
            .Select(item => item.Bounds.Right)
            .DefaultIfEmpty(40000.0F)
            .Max();
        var totalSectionHeight = reportSections.Sum(section => Math.Max(400, section.Height)) +
                                 (reportSections.Count * (headerHeight + sectionSpacing + sectionInnerPadding * 2));
        var availableWidth = Math.Max(400, Width - (outerPadding * 2) - leftGutter);
        var availableHeight = Math.Max(200, Height - (outerPadding * 2));
        var scaleX = availableWidth / Math.Max(1.0F, maxRight);
        var scaleY = availableHeight / Math.Max(1.0F, totalSectionHeight);
        return Math.Max(0.12F, Math.Min(scaleX, scaleY));
    }

    private RectangleF CalculateLogicalBounds()
    {
        var minLeft = objects.Min(item => item.Bounds.Left);
        var minTop = objects.Min(item => item.Bounds.Top);
        var maxRight = objects.Max(item => item.Bounds.Right);
        var maxBottom = objects.Max(item => item.Bounds.Bottom);

        return RectangleF.FromLTRB(minLeft, minTop, maxRight, maxBottom);
    }

    private static bool TryBuildBounds(string assetFamily, CopperfinStudioSnapshotObject snapshotObject, out RectangleF bounds)
    {
        bounds = RectangleF.Empty;
        var (horizontalName, verticalName) = GetCoordinatePropertyNames(assetFamily);
        var (widthName, heightName) = GetSizePropertyNames(assetFamily);
        var left = ExtractNumericProperty(snapshotObject, horizontalName);
        var top = ExtractNumericProperty(snapshotObject, verticalName);
        var width = ExtractNumericProperty(snapshotObject, widthName);
        var height = ExtractNumericProperty(snapshotObject, heightName);
        if (!left.HasValue || !top.HasValue || !width.HasValue || !height.HasValue)
        {
            return false;
        }

        bounds = new RectangleF(left.Value, top.Value, Math.Max(8, width.Value), Math.Max(8, height.Value));
        return true;
    }

    private static (string Horizontal, string Vertical) GetCoordinatePropertyNames(string assetFamily)
    {
        return assetFamily is "report" or "label"
            ? ("HPOS", "VPOS")
            : ("Left", "Top");
    }

    private static (string Width, string Height) GetSizePropertyNames(string assetFamily)
    {
        return assetFamily is "report" or "label"
            ? ("WIDTH", "HEIGHT")
            : ("Width", "Height");
    }

    private static int? ExtractNumericProperty(CopperfinStudioSnapshotObject snapshotObject, string propertyName)
    {
        var property = snapshotObject.Properties.FirstOrDefault(item => item.Name == propertyName);
        if (property is null)
        {
            return null;
        }

        if (double.TryParse(property.Value, out var floating))
        {
            return (int)Math.Round(floating);
        }
        return null;
    }

    private static string ExtractCaption(string assetFamily, CopperfinStudioSnapshotObject snapshotObject)
    {
        string[] candidateNames = assetFamily switch
        {
            "report" or "label" => new[] { "EXPR", "NAME" },
            "menu" => new[] { "PROMPT", "NAME" },
            _ => new[] { "Caption", "OBJNAME", "NAME" }
        };

        foreach (var candidate in candidateNames)
        {
            var caption = snapshotObject.Properties.FirstOrDefault(item => item.Name == candidate)?.Value ?? string.Empty;
            if (!string.IsNullOrWhiteSpace(caption) && caption != "<memo block 0>")
            {
                return caption.Trim('"');
            }
        }

        return string.IsNullOrWhiteSpace(snapshotObject.Title) ? $"Record {snapshotObject.RecordIndex}" : snapshotObject.Title;
    }
}
