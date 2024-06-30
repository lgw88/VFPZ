Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

<ComVisible(True)> _
<Guid(TaskDialogRadioButton.InterfaceId)> _
Public Interface ITaskDialogRadioButton
    Property Name() As String
    Property [Default]() As Boolean
    Property Enabled() As Boolean
    Property [Text]() As Boolean
    Function ToString() As String
End Interface

<ComVisible(True)> _
<Guid(TaskDialogRadioButton.EventsId), _
InterfaceType(ComInterfaceType.InterfaceIsIDispatch)> _
Public Interface ITaskDialogRadioButtonEvents
    <DispId(1)> Sub TDClick()

End Interface

<ComVisible(True)> _
<Guid(TaskDialogRadioButton.ClassId)> _
<ComDefaultInterface(GetType(ITaskDialogRadioButton))> _
<ComSourceInterfaces(GetType(ITaskDialogRadioButtonEvents))> _
Public Class TaskDialogRadioButton
    Inherits VistaBridge.Library.TaskDialogRadioButton
    Implements ITaskDialogRadioButton

#Region "COM GUIDs"
    ' These  GUIDs provide the COM identity for this class 
    ' and its COM interfaces.     
    Public Const ClassId As String = "8C6C1188-E005-415B-AF63-7C42B25B9007"
    Public Const InterfaceId As String = "1497EC7A-2259-42A9-9911-675C23B7D3F3"
    Public Const EventsId As String = "8A93F04B-D88C-4D75-9097-65EA2DDEAADB"
#End Region

    Public Sub New()
        MyBase.New()
    End Sub

    Public Shadows Property Name() As String Implements ITaskDialogRadioButton.Name
        Get
            Return MyBase.Name
        End Get
        Set(ByVal Value As String)
            MyBase.Name = Value
        End Set
    End Property

    Public Shadows Property [Default]() As Boolean Implements ITaskDialogRadioButton.[Default]
        Get
            Return MyBase.[Default]
        End Get
        Set(ByVal Value As Boolean)
            MyBase.[Default] = Value
        End Set
    End Property

    Public Shadows Property Enabled() As Boolean Implements ITaskDialogRadioButton.Enabled
        Get
            Return MyBase.Enabled
        End Get
        Set(ByVal Value As Boolean)
            MyBase.Enabled = Value
        End Set
    End Property

    Public Shadows Property [Text]() As Boolean Implements ITaskDialogRadioButton.[Text]
        Get
            Return MyBase.[Text]
        End Get
        Set(ByVal Value As Boolean)
            MyBase.[Text] = Value
        End Set
    End Property

    Public Shadows Function ToString() As String Implements ITaskDialogRadioButton.ToString
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
