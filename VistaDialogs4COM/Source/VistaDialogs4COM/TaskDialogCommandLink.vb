Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(TaskDialogCommandLink.InterfaceId)> _
Public Interface ITaskDialogCommandLink
    Property Name() As String
    Property Instruction() As String
    Property ShowElevationIcon() As Boolean
    Property [Default]() As Boolean
    Property Enabled() As Boolean
    Property [Text]() As Boolean
    Function ToString() As String
End Interface

<ComVisible(True)> _
<Guid(TaskDialogCommandLink.EventsId), _
InterfaceType(ComInterfaceType.InterfaceIsIDispatch)> _
Public Interface ITaskDialogCommandLinkEvents
    <DispId(1)> Sub TDClick()
End Interface

<ComVisible(True)> _
<Guid(TaskDialogCommandLink.ClassId)> _
<ComDefaultInterface(GetType(ITaskDialogCommandLink))> _
<ComSourceInterfaces(GetType(ITaskDialogCommandLinkEvents))> _
Public Class TaskDialogCommandLink
    Inherits VistaBridge.Library.TaskDialogCommandLink
    Implements ITaskDialogCommandLink

#Region "COM GUIDs"
    ' These  GUIDs provide the COM identity for this class 
    ' and its COM interfaces.     
    Public Const ClassId As String = "6FF06191-A73B-4EF1-B3B5-59567A289C5E"
    Public Const InterfaceId As String = "63824B7E-EEEE-44E6-80BE-4F6C03F73B60"
    Public Const EventsId As String = "BD6218F6-3425-41C1-9A09-07A7F0A629E6"
#End Region

    Public Sub New()
        MyBase.New()
    End Sub

    Public Shadows Property Name() As String Implements ITaskDialogCommandLink.Name
        Get
            Return MyBase.Name
        End Get
        Set(ByVal Value As String)
            MyBase.Name = Value
        End Set
    End Property

    Public Shadows Property Instruction() As String Implements ITaskDialogCommandLink.Instruction
        Get
            Return MyBase.Instruction
        End Get
        Set(ByVal Value As String)
            MyBase.Instruction = Value
        End Set
    End Property

    Public Shadows Property ShowElevationIcon() As Boolean Implements ITaskDialogCommandLink.ShowElevationIcon
        Get
            Return MyBase.ShowElevationIcon
        End Get
        Set(ByVal Value As Boolean)
            MyBase.ShowElevationIcon = Value
        End Set
    End Property

    Public Shadows Property [Default]() As Boolean Implements ITaskDialogCommandLink.[Default]
        Get
            Return MyBase.[Default]
        End Get
        Set(ByVal Value As Boolean)
            MyBase.[Default] = Value
        End Set
    End Property

    Public Shadows Property Enabled() As Boolean Implements ITaskDialogCommandLink.Enabled
        Get
            Return MyBase.Enabled
        End Get
        Set(ByVal Value As Boolean)
            MyBase.Enabled = Value
        End Set
    End Property

    Public Shadows Property [Text]() As Boolean Implements ITaskDialogCommandLink.[Text]
        Get
            Return MyBase.[Text]
        End Get
        Set(ByVal Value As Boolean)
            MyBase.[Text] = Value
        End Set
    End Property

    Public Shadows Function ToString() As String Implements ITaskDialogCommandLink.ToString
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
