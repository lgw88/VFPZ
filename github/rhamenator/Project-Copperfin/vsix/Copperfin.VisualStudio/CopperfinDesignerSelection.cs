using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;

namespace Copperfin.VisualStudio;

internal sealed class CopperfinDesignerSelection : ICustomTypeDescriptor
{
    private sealed class SelectionField
    {
        public string Name { get; set; } = string.Empty;
        public string DisplayName { get; set; } = string.Empty;
        public Type ValueType { get; set; } = typeof(string);
        public bool IsReadOnly { get; set; }
        public string CurrentValue { get; set; } = string.Empty;
        public Func<string, object?> Deserialize { get; set; } = static value => value;
        public Func<object?, string> Serialize { get; set; } = static value => value?.ToString() ?? string.Empty;
        public Func<object?, string> Store { get; set; } = static value => value?.ToString() ?? string.Empty;
    }

    private sealed class SelectionPropertyDescriptor : PropertyDescriptor
    {
        private readonly SelectionField field;

        public SelectionPropertyDescriptor(SelectionField field)
            : base(field.Name, Array.Empty<Attribute>())
        {
            this.field = field;
        }

        public override Type ComponentType => typeof(CopperfinDesignerSelection);

        public override bool IsReadOnly => this.field.IsReadOnly;

        public override Type PropertyType => this.field.ValueType;

        public override bool CanResetValue(object component) => false;

        public override object? GetValue(object component) {
            return ((CopperfinDesignerSelection)component).GetValue(field.Name);
        }

        public override void ResetValue(object component) {
        }

        public override void SetValue(object component, object? value) {
            ((CopperfinDesignerSelection)component).SetValue(field.Name, value);
            OnValueChanged(component, EventArgs.Empty);
        }

        public override bool ShouldSerializeValue(object component) => false;

        public override string DisplayName => this.field.DisplayName;
    }

    private readonly List<SelectionField> fields = new();
    private readonly Dictionary<string, SelectionField> fieldMap = new(StringComparer.OrdinalIgnoreCase);

    public int RecordIndex { get; private set; }

    public static CopperfinDesignerSelection? FromSnapshot(string assetFamily, CopperfinStudioSnapshotObject snapshotObject)
    {
        var selection = new CopperfinDesignerSelection
        {
            RecordIndex = snapshotObject.RecordIndex
        };

        switch (assetFamily)
        {
            case "form":
            case "class_library":
                selection.AddReadOnlyString("OBJNAME", "Object Name", selection.Read(snapshotObject, "OBJNAME", fallback: snapshotObject.Title));
                selection.AddReadOnlyString("BASECLASS", "Base Class", selection.Read(snapshotObject, "BASECLASS", "CLASS", fallback: snapshotObject.Subtitle));
                selection.AddReadOnlyString("PARENT", "Parent", selection.Read(snapshotObject, "PARENT"));
                selection.AddEditableInt("Left", "Left", selection.Read(snapshotObject, "Left"));
                selection.AddEditableInt("Top", "Top", selection.Read(snapshotObject, "Top"));
                selection.AddEditableInt("Width", "Width", selection.Read(snapshotObject, "Width"));
                selection.AddEditableInt("Height", "Height", selection.Read(snapshotObject, "Height"));
                selection.AddEditableString("Caption", "Caption", selection.Read(snapshotObject, "Caption"), requiresFoxStringLiteral: true);
                break;

            case "report":
            case "label":
                selection.AddReadOnlyInt("OBJTYPE", "Object Type", selection.Read(snapshotObject, "OBJTYPE"));
                selection.AddReadOnlyInt("OBJCODE", "Object Code", selection.Read(snapshotObject, "OBJCODE"));
                selection.AddEditableString("EXPR", "Expression", selection.Read(snapshotObject, "EXPR"));
                selection.AddEditableInt("HPOS", "Left", selection.Read(snapshotObject, "HPOS"));
                selection.AddEditableInt("VPOS", "Top", selection.Read(snapshotObject, "VPOS"));
                selection.AddEditableInt("WIDTH", "Width", selection.Read(snapshotObject, "WIDTH"));
                selection.AddEditableInt("HEIGHT", "Height", selection.Read(snapshotObject, "HEIGHT"));
                selection.AddEditableString("FONTFACE", "Font Face", selection.Read(snapshotObject, "FONTFACE"));
                selection.AddEditableInt("FONTSTYLE", "Font Style", selection.Read(snapshotObject, "FONTSTYLE"));
                selection.AddEditableInt("FONTSIZE", "Font Size", selection.Read(snapshotObject, "FONTSIZE"));
                break;

            case "menu":
                selection.AddReadOnlyInt("OBJTYPE", "Object Type", selection.Read(snapshotObject, "OBJTYPE"));
                selection.AddReadOnlyInt("OBJCODE", "Object Code", selection.Read(snapshotObject, "OBJCODE"));
                selection.AddEditableString("NAME", "Name", selection.Read(snapshotObject, "NAME", fallback: snapshotObject.Title));
                selection.AddEditableString("PROMPT", "Prompt", selection.Read(snapshotObject, "PROMPT"));
                selection.AddEditableString("COMMAND", "Command", selection.Read(snapshotObject, "COMMAND"));
                selection.AddEditableString("PROCEDURE", "Procedure", selection.Read(snapshotObject, "PROCEDURE"));
                selection.AddEditableString("MESSAGE", "Message", selection.Read(snapshotObject, "MESSAGE"));
                selection.AddEditableString("KEYLABEL", "Key Label", selection.Read(snapshotObject, "KEYLABEL"));
                selection.AddReadOnlyString("LEVELNAME", "Level", selection.Read(snapshotObject, "LEVELNAME", fallback: snapshotObject.Subtitle));
                selection.AddReadOnlyString("ITEMNUM", "Item Number", selection.Read(snapshotObject, "ITEMNUM"));
                break;

            case "project":
                selection.AddReadOnlyString("NAME", "Project Item", selection.Read(snapshotObject, "NAME", fallback: snapshotObject.Title));
                selection.AddReadOnlyString("TYPE", "Type", selection.Read(snapshotObject, "TYPE", fallback: snapshotObject.Subtitle));
                selection.AddReadOnlyString("KEY", "Key", selection.Read(snapshotObject, "KEY"));
                selection.AddEditableString("COMMENTS", "Comments", selection.Read(snapshotObject, "COMMENTS"));
                selection.AddEditableBool("EXCLUDE", "Exclude", selection.Read(snapshotObject, "EXCLUDE"));
                selection.AddEditableBool("MAINPROG", "Main Program", selection.Read(snapshotObject, "MAINPROG"));
                selection.AddEditableBool("DEBUG", "Debug", selection.Read(snapshotObject, "DEBUG"));
                break;

            default:
                selection.AddReadOnlyString("NAME", "Name", snapshotObject.Title);
                selection.AddReadOnlyString("TYPE", "Type", snapshotObject.Subtitle);
                break;
        }

        return selection;
    }

    public bool TryGetUpdate(string propertyName, out string targetName, out string serializedValue)
    {
        targetName = string.Empty;
        serializedValue = string.Empty;

        if (!fieldMap.TryGetValue(propertyName, out var field) || field.IsReadOnly)
        {
            return false;
        }

        targetName = field.Name;
        serializedValue = field.Serialize(field.Deserialize(field.CurrentValue));
        return true;
    }

    private string Read(CopperfinStudioSnapshotObject snapshotObject, string propertyName, string? alternateName = null, string? fallback = null)
    {
        var value = snapshotObject.Properties.FirstOrDefault(item => item.Name == propertyName)?.Value;
        if (string.IsNullOrWhiteSpace(value) && !string.IsNullOrWhiteSpace(alternateName))
        {
            value = snapshotObject.Properties.FirstOrDefault(item => item.Name == alternateName)?.Value;
        }

        if (string.IsNullOrWhiteSpace(value) || value == "<memo block 0>")
        {
            return fallback ?? string.Empty;
        }

        return (value ?? string.Empty).Trim().Trim('"');
    }

    private void AddReadOnlyString(string name, string displayName, string value)
    {
        AddField(new SelectionField
        {
            Name = name,
            DisplayName = displayName,
            ValueType = typeof(string),
            IsReadOnly = true,
            CurrentValue = value
        });
    }

    private void AddEditableString(string name, string displayName, string value, bool requiresFoxStringLiteral = false)
    {
        AddField(new SelectionField
        {
            Name = name,
            DisplayName = displayName,
            ValueType = typeof(string),
            IsReadOnly = false,
            CurrentValue = value,
            Deserialize = static text => text,
            Serialize = requiresFoxStringLiteral
                ? static value => SerializeFoxString(value?.ToString() ?? string.Empty)
                : static value => value?.ToString() ?? string.Empty
        });
    }

    private void AddReadOnlyInt(string name, string displayName, string value)
    {
        AddField(new SelectionField
        {
            Name = name,
            DisplayName = displayName,
            ValueType = typeof(int),
            IsReadOnly = true,
            CurrentValue = NormalizeInt(value),
            Deserialize = static text => ParseInt(text)
        });
    }

    private void AddEditableInt(string name, string displayName, string value)
    {
        AddField(new SelectionField
        {
            Name = name,
            DisplayName = displayName,
            ValueType = typeof(int),
            IsReadOnly = false,
            CurrentValue = NormalizeInt(value),
            Deserialize = static text => ParseInt(text),
            Serialize = static input => Convert.ToInt32(input ?? 0, CultureInfo.InvariantCulture).ToString(CultureInfo.InvariantCulture),
            Store = static input => Convert.ToInt32(input ?? 0, CultureInfo.InvariantCulture).ToString(CultureInfo.InvariantCulture)
        });
    }

    private void AddEditableBool(string name, string displayName, string value)
    {
        AddField(new SelectionField
        {
            Name = name,
            DisplayName = displayName,
            ValueType = typeof(bool),
            IsReadOnly = false,
            CurrentValue = NormalizeBool(value),
            Deserialize = static text => ParseBool(text),
            Serialize = static input => Convert.ToBoolean(input ?? false, CultureInfo.InvariantCulture) ? "true" : "false",
            Store = static input => Convert.ToBoolean(input ?? false, CultureInfo.InvariantCulture) ? "true" : "false"
        });
    }

    private void AddField(SelectionField field)
    {
        fields.Add(field);
        fieldMap[field.Name] = field;
    }

    private object? GetValue(string propertyName)
    {
        return fieldMap.TryGetValue(propertyName, out var field)
            ? field.Deserialize(field.CurrentValue)
            : null;
    }

    private void SetValue(string propertyName, object? value)
    {
        if (!fieldMap.TryGetValue(propertyName, out var field) || field.IsReadOnly)
        {
            return;
        }

        field.CurrentValue = field.Store(value);
    }

    private static int ParseInt(string value)
    {
        return int.TryParse(value, NumberStyles.Integer, CultureInfo.InvariantCulture, out var parsed)
            ? parsed
            : 0;
    }

    private static bool ParseBool(string value)
    {
        return string.Equals(value, "true", StringComparison.OrdinalIgnoreCase) ||
               string.Equals(value, "t", StringComparison.OrdinalIgnoreCase) ||
               string.Equals(value, ".t.", StringComparison.OrdinalIgnoreCase) ||
               string.Equals(value, "y", StringComparison.OrdinalIgnoreCase) ||
               string.Equals(value, "yes", StringComparison.OrdinalIgnoreCase);
    }

    private static string NormalizeInt(string value)
    {
        return int.TryParse(value, NumberStyles.Any, CultureInfo.InvariantCulture, out var parsed)
            ? parsed.ToString(CultureInfo.InvariantCulture)
            : "0";
    }

    private static string NormalizeBool(string value)
    {
        return ParseBool(value) ? "true" : "false";
    }

    private static string SerializeFoxString(string value)
    {
        return "\"" + value.Replace("\"", "\"\"") + "\"";
    }

    public AttributeCollection GetAttributes() => AttributeCollection.Empty;

    public string? GetClassName() => nameof(CopperfinDesignerSelection);

    public string? GetComponentName() => nameof(CopperfinDesignerSelection);

    public TypeConverter? GetConverter() => null;

    public EventDescriptor? GetDefaultEvent() => null;

    public PropertyDescriptor? GetDefaultProperty() => null;

    public object? GetEditor(Type editorBaseType) => null;

    public EventDescriptorCollection GetEvents(Attribute[]? attributes) => EventDescriptorCollection.Empty;

    public EventDescriptorCollection GetEvents() => EventDescriptorCollection.Empty;

    public PropertyDescriptorCollection GetProperties(Attribute[]? attributes) => GetProperties();

    public PropertyDescriptorCollection GetProperties()
    {
        return new PropertyDescriptorCollection(fields.Select(field => new SelectionPropertyDescriptor(field)).ToArray(), true);
    }

    public object GetPropertyOwner(PropertyDescriptor? pd) => this;
}
