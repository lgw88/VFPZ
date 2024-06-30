Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(CommonSaveFileDialog.InterfaceId)> _
Public Interface ICommonSaveFileDialog
    Property AddExtension() As Boolean
    Property AddToMruList() As Boolean
    Property AllowPropertyEditing() As Boolean
    Property CheckFileExists() As Boolean
    Property CheckPathExists() As Boolean
    Property CheckReadOnly() As Boolean
    Property CheckValidNames() As Boolean
    Property Controls() As System.Object
    Property DefaultExtension() As String
    Property DereferenceLinks() As Boolean
    ReadOnly Property FileName() As String
    Property RestoreDirectory() As Boolean
    Property ShowHiddenItems() As Boolean
    Property ShowPlacesList() As Boolean
    Property Title() As String
    Property CreatePrompt() As Boolean
    Property EnableMiniMode() As Boolean
    Property OverwritePrompt() As Boolean
    Property StrictExtensions() As Boolean
    Function ShowDialog() As Boolean
    Sub AddControl(ByVal myCtrl As Object)
End Interface

<ComVisible(True)> _
<Guid(CommonSaveFileDialog.EventsId), _
InterfaceType(ComInterfaceType.InterfaceIsIDispatch)> _
Public Interface ICommonSaveFileDialogEvents
    <DispId(1)> Sub TDFileOk()
    <DispId(2)> Sub TDFileTypeChanged()
    <DispId(3)> Sub TDFolderChanged()
    <DispId(4)> Sub TDFolderChanging(ByRef cancel As Boolean, ByVal folder As String)
    <DispId(5)> Sub TDOpening()
    <DispId(6)> Sub TDSelectionChanged()

End Interface

<ComVisible(True)> _
<Guid(CommonSaveFileDialog.ClassId)> _
<ComDefaultInterface(GetType(ICommonSaveFileDialog))> _
<ComSourceInterfaces(GetType(ICommonSaveFileDialogEvents))> _
Public Class CommonSaveFileDialog
    Implements ICommonSaveFileDialog

#Region "COM GUIDs"
    ' These  GUIDs provide the COM identity for this class 
    ' and its COM interfaces.     
    Public Const ClassId As String = "2DA6E97A-16E9-4772-85DB-C4B44D50B3FF"
    Public Const InterfaceId As String = "C70A26A0-8A05-483B-A967-EB4F33C35264"
    Public Const EventsId As String = "427CEE6E-A32F-46A9-B2B2-694197E36E7C"
#End Region

    Public WithEvents SaveFileDialog As VistaBridge.Library.CommonSaveFileDialog = New VistaBridge.Library.CommonSaveFileDialog

    Public Sub New()

    End Sub

    Public Shadows Property AddExtension() As Boolean Implements ICommonSaveFileDialog.AddExtension
        Get
            Return Me.SaveFileDialog.AddExtension
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.AddExtension = Value
        End Set
    End Property

    Public Shadows Property AddToMruList() As Boolean Implements ICommonSaveFileDialog.AddToMruList
        Get
            Return Me.SaveFileDialog.AddToMruList
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.AddToMruList = Value
        End Set
    End Property

    Public Shadows Property AllowPropertyEditing() As Boolean Implements ICommonSaveFileDialog.AllowPropertyEditing
        Get
            Return Me.SaveFileDialog.AllowPropertyEditing
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.AllowPropertyEditing = Value
        End Set
    End Property

    Public Shadows Property CheckFileExists() As Boolean Implements ICommonSaveFileDialog.CheckFileExists
        Get
            Return Me.SaveFileDialog.CheckFileExists
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.CheckFileExists = Value
        End Set
    End Property

    Public Shadows Property CheckPathExists() As Boolean Implements ICommonSaveFileDialog.CheckPathExists
        Get
            Return Me.SaveFileDialog.CheckPathExists
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.CheckPathExists = Value
        End Set
    End Property

    Public Shadows Property CheckReadOnly() As Boolean Implements ICommonSaveFileDialog.CheckReadOnly
        Get
            Return Me.SaveFileDialog.CheckReadOnly
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.CheckReadOnly = Value
        End Set
    End Property

    Public Shadows Property CheckValidNames() As Boolean Implements ICommonSaveFileDialog.CheckValidNames
        Get
            Return Me.SaveFileDialog.CheckValidNames
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.CheckValidNames = Value
        End Set
    End Property

    Public Shadows Property Controls() As System.Object Implements ICommonSaveFileDialog.Controls
        Get
            Return Me.SaveFileDialog.Controls
        End Get
        Set(ByVal Value As System.Object)
            Me.SaveFileDialog.Controls = Value
        End Set
    End Property

    Public Shadows Property DefaultExtension() As String Implements ICommonSaveFileDialog.DefaultExtension
        Get
            Return Me.SaveFileDialog.DefaultExtension
        End Get
        Set(ByVal Value As String)
            Me.SaveFileDialog.DefaultExtension = Value
        End Set
    End Property

    Public Shadows Property DereferenceLinks() As Boolean Implements ICommonSaveFileDialog.DereferenceLinks
        Get
            Return Me.SaveFileDialog.DereferenceLinks
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.DereferenceLinks = Value
        End Set
    End Property

    Public Shadows ReadOnly Property FileName() As String Implements ICommonSaveFileDialog.FileName
        Get
            Return Me.SaveFileDialog.FileName
        End Get
    End Property

    Public Shadows Property RestoreDirectory() As Boolean Implements ICommonSaveFileDialog.RestoreDirectory
        Get
            Return Me.SaveFileDialog.RestoreDirectory
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.RestoreDirectory = Value
        End Set
    End Property

    Public Shadows Property ShowHiddenItems() As Boolean Implements ICommonSaveFileDialog.ShowHiddenItems
        Get
            Return Me.SaveFileDialog.ShowHiddenItems
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.ShowHiddenItems = Value
        End Set
    End Property

    Public Shadows Property ShowPlacesList() As Boolean Implements ICommonSaveFileDialog.ShowPlacesList
        Get
            Return Me.SaveFileDialog.ShowPlacesList
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.ShowPlacesList = Value
        End Set
    End Property

    Public Shadows Property Title() As String Implements ICommonSaveFileDialog.Title
        Get
            Return Me.SaveFileDialog.Title
        End Get
        Set(ByVal Value As String)
            Me.SaveFileDialog.Title = Value
        End Set
    End Property

    Public Shadows Property CreatePrompt() As Boolean Implements ICommonSaveFileDialog.CreatePrompt
        Get
            Return Me.SaveFileDialog.CreatePrompt
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.CreatePrompt = Value
        End Set
    End Property

    Public Shadows Property EnableMiniMode() As Boolean Implements ICommonSaveFileDialog.EnableMiniMode
        Get
            Return Me.SaveFileDialog.EnableMiniMode
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.EnableMiniMode = Value
        End Set
    End Property

    Public Shadows Property OverwritePrompt() As Boolean Implements ICommonSaveFileDialog.OverwritePrompt
        Get
            Return Me.SaveFileDialog.OverwritePrompt
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.OverwritePrompt = Value
        End Set
    End Property

    Public Shadows Property StrictExtensions() As Boolean Implements ICommonSaveFileDialog.StrictExtensions
        Get
            Return Me.SaveFileDialog.StrictExtensions
        End Get
        Set(ByVal Value As Boolean)
            Me.SaveFileDialog.StrictExtensions = Value
        End Set
    End Property

    Public Shadows Function ShowDialog() As Boolean Implements ICommonSaveFileDialog.ShowDialog
        Dim result As VistaBridge.Library.CommonFileDialogResult
        result = Me.SaveFileDialog.ShowDialog()
        Return result.Canceled
    End Function

    Public Sub AddControl(ByVal myCtrl As Object) Implements ICommonSaveFileDialog.AddControl
        Me.SaveFileDialog.Controls.Add(CType(myCtrl, VistaBridge.Library.CommonFileDialogControl))
    End Sub

    Public Delegate Sub FileOkEventHandler()
    Public Event TDFileOk As FileOkEventHandler

    Public Sub TaskDialog_FileOk(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) _
    Handles SaveFileDialog.FileOk
        RaiseEvent TDFileOk()
    End Sub

    Public Delegate Sub FileTypeChangedEventHandler()
    Public Event TDFileTypeChanged As FileTypeChangedEventHandler

    Public Sub TaskDialog_FileTypeChanged(ByVal sender As Object, ByVal e As EventArgs) _
    Handles SaveFileDialog.FileTypeChanged
        RaiseEvent TDFileTypeChanged()
    End Sub

    Public Delegate Sub FolderChangedEventHandler()
    Public Event TDFolderChanged As FolderChangedEventHandler

    Public Sub TaskDialog_FolderChanged(ByVal sender As Object, ByVal e As EventArgs) _
    Handles SaveFileDialog.FolderChanged
        RaiseEvent TDFolderChanged()
    End Sub

    Public Delegate Sub FolderChangingEventHandler(ByRef cancel As Boolean, ByVal folder As String)
    Public Event TDFolderChanging As FolderChangingEventHandler

    Public Sub TaskDialog_FolderChanging(ByVal sender As Object, ByVal e As VistaBridge.Library.CommonFileDialogFolderChangeEventArgs) _
    Handles SaveFileDialog.FolderChanging
        RaiseEvent TDFolderChanging(e.Cancel, e.Folder)
    End Sub

    Public Delegate Sub OpeningEventHandler()
    Public Event TDOpening As OpeningEventHandler

    Public Sub TaskDialog_Opening(ByVal sender As Object, ByVal e As EventArgs) _
    Handles SaveFileDialog.Opening
        RaiseEvent TDOpening()
    End Sub

    Public Delegate Sub SelectionChangedEventHandler()
    Public Event TDSelectionChanged As SelectionChangedEventHandler

    Public Sub TaskDialog_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs) _
    Handles SaveFileDialog.SelectionChanged
        RaiseEvent TDSelectionChanged()
    End Sub

End Class
