using System.ComponentModel.Composition;
using Microsoft.VisualStudio.Utilities;

namespace Copperfin.VisualStudio;

internal static class FoxProContentTypeDefinitions
{
    public const string ContentTypeName = "copperfinFoxPro";

    [Export(typeof(ContentTypeDefinition))]
    [Name(ContentTypeName)]
    [BaseDefinition("code")]
    internal static ContentTypeDefinition FoxProContentType = null!;

    [Export(typeof(FileExtensionToContentTypeDefinition))]
    [ContentType(ContentTypeName)]
    [FileExtension(".prg")]
    internal static FileExtensionToContentTypeDefinition PrgFile = null!;

    [Export(typeof(FileExtensionToContentTypeDefinition))]
    [ContentType(ContentTypeName)]
    [FileExtension(".h")]
    internal static FileExtensionToContentTypeDefinition HeaderFile = null!;

    [Export(typeof(FileExtensionToContentTypeDefinition))]
    [ContentType(ContentTypeName)]
    [FileExtension(".qpr")]
    internal static FileExtensionToContentTypeDefinition QueryProgramFile = null!;

    [Export(typeof(FileExtensionToContentTypeDefinition))]
    [ContentType(ContentTypeName)]
    [FileExtension(".mpr")]
    internal static FileExtensionToContentTypeDefinition MenuProgramFile = null!;

    [Export(typeof(FileExtensionToContentTypeDefinition))]
    [ContentType(ContentTypeName)]
    [FileExtension(".spr")]
    internal static FileExtensionToContentTypeDefinition ScreenProgramFile = null!;
}
