Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(TaskDialogMarquee.InterfaceId)> _
Public Interface ITaskDialogMarquee
    Property Name() As String
    Property State() As Integer
End Interface

<ComVisible(True)> _
<Guid(TaskDialogMarquee.ClassId)> _
<ComDefaultInterface(GetType(ITaskDialogMarquee))> _
Public Class TaskDialogMarquee
    Inherits VistaBridge.Library.TaskDialogMarquee
    Implements ITaskDialogMarquee

#Region "COM GUIDs"
    Public Const ClassId As String = "2E71FD9F-F5ED-4844-B46A-1BE33DC95A67"
    Public Const InterfaceId As String = "17EBB9AC-B8B7-4EED-98B2-46F57237BF24"
    Public Const EventsId As String = "C4A62C9C-A7D0-44FA-B08C-3B507169A724"
#End Region

    Public Sub New()
        MyBase.New()
    End Sub
    Public Shadows Property Name() As String Implements ITaskDialogMarquee.Name
        Get
            Return MyBase.Name
        End Get
        Set(ByVal Value As String)
            MyBase.Name = Value
        End Set
    End Property

    Public Shadows Property State() As Integer Implements ITaskDialogMarquee.State
        Get
            Return MyBase.State
        End Get
        Set(ByVal Value As Integer)
            MyBase.State = Value
        End Set
    End Property
End Class
