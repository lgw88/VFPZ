Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(TaskDialogProgressBar.InterfaceId)> _
Public Interface ITaskDialogProgressBar
    Property Maximum() As Integer
    Property Minimum() As Integer
    Property Value() As Integer
    Property State() As Integer
End Interface

<ComVisible(True)> _
<Guid(TaskDialogProgressBar.ClassId)> _
<ComDefaultInterface(GetType(ITaskDialogProgressBar))> _
<ProgId("VistaDialogs4COM.TaskDialogProgressBar")> _
Public Class TaskDialogProgressBar
    Inherits VistaBridge.Library.TaskDialogProgressBar
    Implements ITaskDialogProgressBar

#Region "COM GUIDs"
    Public Const ClassId As String = "0DDAD12F-C348-405f-A181-8D208847ACD6"
    Public Const InterfaceId As String = "500A69D5-BB1D-43c3-A0AF-1CFBC560BB90"
    Public Const EventsId As String = "4A6DE245-0E3A-415b-97CA-D077E925C303"
#End Region

    ' Properties
    Public Shadows Property Maximum() As Integer Implements ITaskDialogProgressBar.Maximum
        Get
            Return MyBase.Maximum
        End Get
        Set(ByVal Value As Integer)
            MyBase.Maximum = Value
        End Set
    End Property

    Public Shadows Property Minimum() As Integer Implements ITaskDialogProgressBar.Minimum
        Get
            Return MyBase.Minimum
        End Get
        Set(ByVal Value As Integer)
            MyBase.Minimum = Value
        End Set
    End Property

    Public Shadows Property Value() As Integer Implements ITaskDialogProgressBar.Value
        Get
            Return MyBase.Value
        End Get
        Set(ByVal Value As Integer)
            MyBase.Value = Value
        End Set
    End Property

    Public Shadows Property State() As Integer Implements ITaskDialogProgressBar.State
        Get
            Return MyBase.State
        End Get
        Set(ByVal Value As Integer)
            MyBase.State = CType(Value, VistaBridge.Library.TaskDialogProgressBarState)
        End Set
    End Property

    ' Methods
    Public Sub New()
        MyBase.New()
    End Sub
End Class


