Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(CommonFileDialogFilter.InterfaceId)> _
Public Interface ICommonFileDialogFilter
    Property DisplayName() As String
    ReadOnly Property Extensions() As System.Object
    Property ShowExtensions() As Boolean
    Sub AddExtension(ByVal extension As String)
End Interface

<ComVisible(True)> _
<Guid(CommonFileDialogFilter.ClassId)> _
<ComDefaultInterface(GetType(ICommonFileDialogFilter))> _
Public Class CommonFileDialogFilter
    Inherits VistaBridge.Library.CommonFileDialogFilter
    Implements ICommonFileDialogFilter

#Region "COM GUIDs"
    ' These  GUIDs provide the COM identity for this class 
    ' and its COM interfaces.     
    Public Const ClassId As String = "3E48C054-60BF-44CA-A0B5-0A92B219D837"
    Public Const InterfaceId As String = "07E74D85-E482-42E8-8D2F-5133D324524F"
    Public Const EventsId As String = "F94CAED4-74B7-42B1-87E6-3F0655018EDC"
#End Region

    Public Sub New()
        MyBase.New()
    End Sub

    Public Shadows Property DisplayName() As String Implements ICommonFileDialogFilter.DisplayName
        Get
            Return MyBase.DisplayName
        End Get
        Set(ByVal Value As String)
            MyBase.DisplayName = Value
        End Set
    End Property

    Public Shadows ReadOnly Property Extensions() As System.Object Implements ICommonFileDialogFilter.Extensions
        Get
            Return MyBase.Extensions
        End Get
    End Property

    Public Shadows Property ShowExtensions() As Boolean Implements ICommonFileDialogFilter.ShowExtensions
        Get
            Return MyBase.ShowExtensions
        End Get
        Set(ByVal Value As Boolean)
            MyBase.ShowExtensions = Value
        End Set
    End Property

    Public Sub AddExtension(ByVal extension As String) Implements ICommonFileDialogFilter.AddExtension
        MyBase.Extensions.Add(extension)
    End Sub

End Class
