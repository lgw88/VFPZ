Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(TaskDialogButton.InterfaceId)> _
Public Interface ITaskDialogButton
    Property Name() As String
    Property ShowElevationIcon() As Boolean
    Property [Default]() As Boolean
    Property Enabled() As Boolean
    Property [Text]() As Boolean
    Function ToString() As String

End Interface

<ComVisible(True)> _
<Guid(TaskDialogButton.EventsId), _
InterfaceType(ComInterfaceType.InterfaceIsIDispatch)> _
Public Interface ITaskDialogButtonEvents
    <DispId(1)> Sub TDClick()

End Interface

<ComVisible(True)> _
<Guid(TaskDialogButton.ClassId)> _
<ComDefaultInterface(GetType(ITaskDialogButton))> _
<ComSourceInterfaces(GetType(ITaskDialogButtonEvents))> _
Public Class TaskDialogButton
    Inherits VistaBridge.Library.TaskDialogButton
    Implements ITaskDialogButton

#Region "COM GUIDs"
    Public Const ClassId As String = "F36B000E-3B6E-4C8E-BB54-99A953890EBD"
    Public Const InterfaceId As String = "C4A40759-2388-4C38-A8AD-BEA904657632"
    Public Const EventsId As String = "3A4528DD-E23E-44EB-9020-2B4DCEFC02FD"
#End Region

    Public Sub New()
        MyBase.New()
    End Sub

    Public Shadows Property Name() As String Implements ITaskDialogButton.Name
        Get
            Return MyBase.Name
        End Get
        Set(ByVal Value As String)
            MyBase.Name = Value
        End Set
    End Property

    Public Shadows Property ShowElevationIcon() As Boolean Implements ITaskDialogButton.ShowElevationIcon
        Get
            Return MyBase.ShowElevationIcon
        End Get
        Set(ByVal Value As Boolean)
            MyBase.ShowElevationIcon = Value
        End Set
    End Property

    Public Shadows Property [Default]() As Boolean Implements ITaskDialogButton.[Default]
        Get
            Return MyBase.[Default]
        End Get
        Set(ByVal Value As Boolean)
            MyBase.[Default] = Value
        End Set
    End Property

    Public Shadows Property Enabled() As Boolean Implements ITaskDialogButton.Enabled
        Get
            Return MyBase.Enabled
        End Get
        Set(ByVal Value As Boolean)
            MyBase.Enabled = Value
        End Set
    End Property

    Public Shadows Property [Text]() As Boolean Implements ITaskDialogButton.[Text]
        Get
            Return MyBase.[Text]
        End Get
        Set(ByVal Value As Boolean)
            MyBase.[Text] = Value
        End Set
    End Property

    Public Shadows Function ToString() As String Implements ITaskDialogButton.ToString
        Dim result As String
        result = MyBase.ToString()
        Return result
    End Function

    Public Delegate Sub ClickEventHandler()
    Public Event TDClick As ClickEventHandler

    Public Sub TaskDialog_Click(ByVal sender As Object, ByVal e As EventArgs) _
    Handles MyBase.Click
        RaiseEvent TDClick()
    End Sub

End Class
