Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(CommonOpenFileDialog.InterfaceId)> _
Public Interface ICommonOpenFileDialog
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
    ReadOnly Property FileNames() As String()
    Property MultiSelect() As Boolean
    Function ShowDialog() As Boolean
    Sub AddControl(ByVal myCtrl As Object)
    Sub AddFileName(ByVal fileName As String)
End Interface

<ComVisible(True)> _
<Guid(CommonOpenFileDialog.EventsId), _
InterfaceType(ComInterfaceType.InterfaceIsIDispatch)> _
Public Interface ICommonOpenFileDialogEvents
    <DispId(1)> Sub TDFileOk(ByVal cancel As Boolean)
    <DispId(2)> Sub TDFileTypeChanged()
    <DispId(3)> Sub TDFolderChanged()
    <DispId(4)> Sub TDFolderChanging(ByRef cancel As Boolean, ByVal folder As String)
    <DispId(5)> Sub TDOpening()
    <DispId(6)> Sub TDSelectionChanged()

End Interface

<ComVisible(True)> _
<Guid(CommonOpenFileDialog.ClassId)> _
<ComDefaultInterface(GetType(ICommonOpenFileDialog))> _
<ComSourceInterfaces(GetType(ICommonOpenFileDialogEvents))> _
Public Class CommonOpenFileDialog
    Implements ICommonOpenFileDialog

#Region "COM GUIDs"
    ' These  GUIDs provide the COM identity for this class 
    ' and its COM interfaces.     
    Public Const ClassId As String = "7247C61D-D39A-443c-88C2-8DF80E1F356D"
    Public Const InterfaceId As String = "B6574BE9-812D-4f07-8DCF-9B8B452B6FBA"
    Public Const EventsId As String = "E18EFF22-6089-489f-AA2F-A0805FB7518D"
#End Region

    Public WithEvents OpenFileDialog As VistaBridge.Library.CommonOpenFileDialog = New VistaBridge.Library.CommonOpenFileDialog

    Public Sub New()

    End Sub

    Public Shadows Property AddExtension() As Boolean Implements ICommonOpenFileDialog.AddExtension
        Get
            Return Me.OpenFileDialog.AddExtension
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.AddExtension = Value
        End Set
    End Property

    Public Shadows Property AddToMruList() As Boolean Implements ICommonOpenFileDialog.AddToMruList
        Get
            Return Me.OpenFileDialog.AddToMruList
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.AddToMruList = Value
        End Set
    End Property

    Public Shadows Property AllowPropertyEditing() As Boolean Implements ICommonOpenFileDialog.AllowPropertyEditing
        Get
            Return Me.OpenFileDialog.AllowPropertyEditing
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.AllowPropertyEditing = Value
        End Set
    End Property

    Public Shadows Property CheckFileExists() As Boolean Implements ICommonOpenFileDialog.CheckFileExists
        Get
            Return Me.OpenFileDialog.CheckFileExists
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.CheckFileExists = Value
        End Set
    End Property

    Public Shadows Property CheckPathExists() As Boolean Implements ICommonOpenFileDialog.CheckPathExists
        Get
            Return Me.OpenFileDialog.CheckPathExists
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.CheckPathExists = Value
        End Set
    End Property

    Public Shadows Property CheckReadOnly() As Boolean Implements ICommonOpenFileDialog.CheckReadOnly
        Get
            Return Me.OpenFileDialog.CheckReadOnly
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.CheckReadOnly = Value
        End Set
    End Property

    Public Shadows Property CheckValidNames() As Boolean Implements ICommonOpenFileDialog.CheckValidNames
        Get
            Return Me.OpenFileDialog.CheckValidNames
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.CheckValidNames = Value
        End Set
    End Property

    Public Shadows Property Controls() As Object Implements ICommonOpenFileDialog.Controls
        Get
            Return Me.OpenFileDialog.Controls
        End Get
        Set(ByVal Value As Object)
            Me.OpenFileDialog.Controls = Value
        End Set
    End Property

    Public Shadows Property DefaultExtension() As String Implements ICommonOpenFileDialog.DefaultExtension
        Get
            Return Me.OpenFileDialog.DefaultExtension
        End Get
        Set(ByVal Value As String)
            Me.OpenFileDialog.DefaultExtension = Value
        End Set
    End Property

    Public Shadows Property DereferenceLinks() As Boolean Implements ICommonOpenFileDialog.DereferenceLinks
        Get
            Return Me.OpenFileDialog.DereferenceLinks
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.DereferenceLinks = Value
        End Set
    End Property

    Public Shadows ReadOnly Property FileName() As String Implements ICommonOpenFileDialog.FileName
        Get
            Return Me.OpenFileDialog.FileName
        End Get
    End Property

    Public Shadows Property RestoreDirectory() As Boolean Implements ICommonOpenFileDialog.RestoreDirectory
        Get
            Return Me.OpenFileDialog.RestoreDirectory
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.RestoreDirectory = Value
        End Set
    End Property

    Public Shadows Property ShowHiddenItems() As Boolean Implements ICommonOpenFileDialog.ShowHiddenItems
        Get
            Return Me.OpenFileDialog.ShowHiddenItems
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.ShowHiddenItems = Value
        End Set
    End Property

    Public Shadows Property ShowPlacesList() As Boolean Implements ICommonOpenFileDialog.ShowPlacesList
        Get
            Return Me.OpenFileDialog.ShowPlacesList
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.ShowPlacesList = Value
        End Set
    End Property

    Public Shadows Property Title() As String Implements ICommonOpenFileDialog.Title
        Get
            Return Me.OpenFileDialog.Title
        End Get
        Set(ByVal Value As String)
            Me.OpenFileDialog.Title = Value
        End Set
    End Property

    Public Shadows ReadOnly Property FileNames() As String() Implements ICommonOpenFileDialog.FileNames
        Get
            Dim FileNameArray(Me.OpenFileDialog.FileNames.Count) As String
            Me.OpenFileDialog.FileNames.CopyTo(FileNameArray, 0)
            Return FileNameArray
        End Get
    End Property


    Public Shadows Property MultiSelect() As Boolean Implements ICommonOpenFileDialog.MultiSelect
        Get
            Return Me.OpenFileDialog.Multiselect
        End Get
        Set(ByVal Value As Boolean)
            Me.OpenFileDialog.Multiselect = Value
        End Set
    End Property

    Public Shadows Function ShowDialog() As Boolean Implements ICommonOpenFileDialog.ShowDialog
        Dim result As VistaBridge.Library.CommonFileDialogResult
        result = Me.OpenFileDialog.ShowDialog()
        Return result.Canceled
    End Function

    Public Sub AddControl(ByVal myCtrl As Object) Implements ICommonOpenFileDialog.AddControl
        Me.OpenFileDialog.Controls.Add(CType(myCtrl, VistaBridge.Library.CommonFileDialogControl))
    End Sub

    Public Sub AddFileName(ByVal fileName As String) Implements ICommonOpenFileDialog.AddFileName
        Me.OpenFileDialog.FileNames.Add(fileName)
    End Sub

    Public Delegate Sub FileOkEventHandler(ByVal cancel As Boolean)
    Public Event TDFileOk As FileOkEventHandler

    Public Sub TaskDialog_FileOk(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) _
    Handles OpenFileDialog.FileOk
        RaiseEvent TDFileOk(e.Cancel)
    End Sub

    Public Delegate Sub FileTypeChangedEventHandler()
    Public Event TDFileTypeChanged As FileTypeChangedEventHandler

    Public Sub TaskDialog_FileTypeChanged(ByVal sender As Object, ByVal e As EventArgs) _
    Handles OpenFileDialog.FileTypeChanged
        RaiseEvent TDFileTypeChanged()
    End Sub

    Public Delegate Sub FolderChangedEventHandler()
    Public Event TDFolderChanged As FolderChangedEventHandler

    Public Sub TaskDialog_FolderChanged(ByVal sender As Object, ByVal e As EventArgs) _
    Handles OpenFileDialog.FolderChanged
        RaiseEvent TDFolderChanged()
    End Sub

    Public Delegate Sub FolderChangingEventHandler(ByRef cancel As Boolean, ByVal folder As String)
    Public Event TDFolderChanging As FolderChangingEventHandler

    Public Sub TaskDialog_FolderChanging(ByVal sender As Object, ByVal e As VistaBridge.Library.CommonFileDialogFolderChangeEventArgs) _
    Handles OpenFileDialog.FolderChanging
        RaiseEvent TDFolderChanging(e.Cancel, e.Folder)
    End Sub

    Public Delegate Sub OpeningEventHandler()
    Public Event TDOpening As OpeningEventHandler

    Public Sub TaskDialog_Opening(ByVal sender As Object, ByVal e As EventArgs) _
    Handles OpenFileDialog.Opening
        RaiseEvent TDOpening()
    End Sub

    Public Delegate Sub SelectionChangedEventHandler()
    Public Event TDSelectionChanged As SelectionChangedEventHandler

    Public Sub TaskDialog_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs) _
    Handles OpenFileDialog.SelectionChanged
        RaiseEvent TDSelectionChanged()
    End Sub

End Class
