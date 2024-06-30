Imports System.Runtime.InteropServices
Imports Microsoft.SDK.Samples

#Region "Interfaces"
<ComVisible(True)> _
<Guid(TaskDialog.InterfaceId)> _
Public Interface ITaskDialog
    Property Content() As String
    Property Instruction() As String
    Property Caption() As String
    Property MainIcon() As Integer
    Property StandardButtons() As Integer
    Property HyperlinksEnabled() As Boolean
    Property Cancelable() As Boolean
    Property CheckBoxChecked() As Boolean
    Property CheckBoxText() As String
    Property Expanded() As Boolean
    Property ExpansionMode() As Integer
    Property ExpandedText() As String
    Property ExpandedControlText() As String
    Property CollapsedControlText() As String
    Property FooterText() As String
    Property FooterIcon() As Integer
    Property StartupLocation() As Integer
    Function Show() As VistaBridge.Library.TaskDialogResult
    Sub AddControl(ByVal myCtrl As Object)
End Interface

<ComVisible(True)> _
<Guid(TaskDialog.EventsId), _
InterfaceType(ComInterfaceType.InterfaceIsIDispatch)> _
Public Interface ITaskDialogEvents
    <DispId(1)> _
    Sub TDClosing(ByRef cancel As Boolean, ByVal customButton As String, ByVal standardButton As Integer)
    <DispId(2)> _
    Sub TDHelpInvoked()
    <DispId(3)> _
    Sub TDHyperlinkClick(ByVal linkText As String)
    <DispId(4)> _
    Sub TDOpened()
    <DispId(5)> _
    Sub TDTick(ByVal ticks As Integer)
End Interface
#End Region

<ComVisible(True)> _
<Guid(TaskDialog.ClassId)> _
<ComDefaultInterface(GetType(ITaskDialog))> _
<ComSourceInterfaces(GetType(ITaskDialogEvents))> _
<ProgId("VistaDialogs4COM.TaskDialog")> _
Public Class TaskDialog
    Inherits VistaBridge.Library.TaskDialog
    Implements ITaskDialog

#Region "COM GUIDs"
    Public Const ClassId As String = "04EBF795-8CDD-44ac-8E8B-318F82D61C75"
    Public Const InterfaceId As String = "E6F3578E-8ACB-4a8a-9DB5-D61EED0FBE4E"
    Public Const EventsId As String = "1602636C-AB6D-460f-BDF4-190698C8C180"
#End Region

#Region "TaskDialog Properties"

    Public Shadows Property Content() As String Implements ITaskDialog.Content
        Get
            Return MyBase.Content
        End Get
        Set(ByVal Value As String)
            MyBase.Content = Value
        End Set
    End Property

    Public Shadows Property Instruction() As String Implements ITaskDialog.Instruction
        Get
            Return MyBase.Instruction
        End Get
        Set(ByVal Value As String)
            MyBase.Instruction = Value
        End Set
    End Property

    Public Shadows Property Caption() As String Implements ITaskDialog.Caption
        Get
            Return MyBase.Caption
        End Get
        Set(ByVal Value As String)
            MyBase.Caption = Value
        End Set
    End Property

    Public Shadows Property MainIcon() As Integer Implements ITaskDialog.MainIcon
        Get
            Return MyBase.MainIcon
        End Get
        Set(ByVal Value As Integer)
            MyBase.MainIcon = CType(Value, VistaBridge.Library.TaskDialogStandardIcon)
        End Set
    End Property

    Public Shadows Property StandardButtons() As Integer Implements ITaskDialog.StandardButtons
        Get
            Return MyBase.StandardButtons
        End Get
        Set(ByVal Value As Integer)
            MyBase.StandardButtons = CType(Value, VistaBridge.Library.TaskDialogStandardButtons)
        End Set
    End Property

    Public Shadows Property HyperlinksEnabled() As Boolean Implements ITaskDialog.HyperlinksEnabled
        Get
            Return MyBase.HyperlinksEnabled
        End Get
        Set(ByVal Value As Boolean)
            MyBase.HyperlinksEnabled = Value
        End Set
    End Property

    Public Shadows Property Cancelable() As Boolean Implements ITaskDialog.Cancelable
        Get
            Return MyBase.Cancelable
        End Get
        Set(ByVal Value As Boolean)
            MyBase.Cancelable = Value
        End Set
    End Property

    Public Shadows Property CheckBoxChecked() As Boolean Implements ITaskDialog.CheckBoxChecked
        Get
            Return MyBase.CheckBoxChecked
        End Get
        Set(ByVal Value As Boolean)
            MyBase.CheckBoxChecked = Value
        End Set
    End Property

    Public Shadows Property CheckBoxText() As String Implements ITaskDialog.CheckBoxText
        Get
            Return MyBase.CheckBoxText
        End Get
        Set(ByVal Value As String)
            MyBase.CheckBoxText = Value
        End Set
    End Property

    Public Shadows Property Expanded() As Boolean Implements ITaskDialog.Expanded
        Get
            Return MyBase.Expanded
        End Get
        Set(ByVal Value As Boolean)
            MyBase.Expanded = Value
        End Set
    End Property

    Public Shadows Property ExpansionMode() As Integer Implements ITaskDialog.ExpansionMode
        Get
            Return MyBase.ExpansionMode
        End Get
        Set(ByVal Value As Integer)
            MyBase.ExpansionMode = CType(Value, VistaBridge.Library.TaskDialogExpandedInformationLocation)
        End Set
    End Property

    Public Shadows Property ExpandedText() As String Implements ITaskDialog.ExpandedText
        Get
            Return MyBase.ExpandedText
        End Get
        Set(ByVal Value As String)
            MyBase.ExpandedText = Value
        End Set
    End Property

    Public Shadows Property ExpandedControlText() As String Implements ITaskDialog.ExpandedControlText
        Get
            Return MyBase.ExpandedControlText
        End Get
        Set(ByVal Value As String)
            MyBase.ExpandedControlText = Value
        End Set
    End Property

    Public Shadows Property CollapsedControlText() As String Implements ITaskDialog.CollapsedControlText
        Get
            Return MyBase.CollapsedControlText
        End Get
        Set(ByVal Value As String)
            MyBase.CollapsedControlText = Value
        End Set
    End Property

    Public Shadows Property FooterText() As String Implements ITaskDialog.FooterText
        Get
            Return MyBase.FooterText
        End Get
        Set(ByVal Value As String)
            MyBase.FooterText = Value
        End Set
    End Property

    Public Shadows Property FooterIcon() As Integer Implements ITaskDialog.FooterIcon
        Get
            Return MyBase.FooterIcon
        End Get
        Set(ByVal Value As Integer)
            MyBase.FooterIcon = CType(Value, VistaBridge.Library.TaskDialogStandardIcon)
        End Set
    End Property

    Public Shadows Property StartupLocation() As Integer Implements ITaskDialog.StartupLocation
        Get
            Return MyBase.StartupLocation
        End Get
        Set(ByVal Value As Integer)
            MyBase.StartupLocation = CType(Value, VistaBridge.Library.TaskDialogStartupLocation)
        End Set
    End Property

#End Region

#Region "Functions"
    Public Sub New()
        MyBase.New()
    End Sub

    Public Shadows Function Show() As VistaBridge.Library.TaskDialogResult Implements ITaskDialog.Show
        Dim result As VistaBridge.Library.TaskDialogResult
        result = MyBase.Show()
        Return result
    End Function

    Public Sub AddControl(ByVal myCtrl As Object) Implements ITaskDialog.AddControl
        Me.Controls.Add(CType(myCtrl, VistaBridge.Library.TaskDialogControl))
    End Sub

#End Region

#Region "TaskDialog Events"
    Public Delegate Sub ClosingEventHandler(ByRef cancel As Boolean, ByVal customButton As String, ByVal standardButton As Integer)
    Public Event TDClosing As ClosingEventHandler

    Public Sub TaskDialog_Closing(ByVal sender As Object, ByVal e As VistaBridge.Library.TaskDialogClosingEventArgs) _
    Handles Me.Closing
        RaiseEvent TDClosing(e.Cancel, e.CustomButton, CType(e.StandardButton, Integer))
    End Sub

    Public Delegate Sub HelpInvokedEventHandler()
    Public Event TDHelpInvoked As HelpInvokedEventHandler

    Public Sub TaskDialog_HelpInvoked(ByVal sender As Object, ByVal e As System.EventArgs) _
      Handles Me.HelpInvoked
        RaiseEvent TDHelpInvoked()
    End Sub

    Public Delegate Sub HyperlinkClickEventHandler(ByVal linkText As String)
    Public Event TDHyperlinkClick As HyperlinkClickEventHandler

    Public Sub TaskDialog_HyperlinkClick(ByVal sender As Object, ByVal e As Microsoft.SDK.Samples.VistaBridge.Library.TaskDialogHyperlinkClickedEventArgs) _
     Handles Me.HyperlinkClick
        RaiseEvent TDHyperlinkClick(e.LinkText)
    End Sub

    Public Delegate Sub OpenedEventHandler()
    Public Event TDOpened As OpenedEventHandler

    Public Sub TaskDialog_Opened(ByVal sender As Object, ByVal e As System.EventArgs) _
     Handles Me.Opened
        RaiseEvent TDOpened()
    End Sub

    Public Delegate Sub TickEventHandler(ByVal ticks As Integer)
    Public Event TDTick As TickEventHandler

    Public Sub TaskDialog_Tick(ByVal sender As Object, ByVal e As Microsoft.SDK.Samples.VistaBridge.Library.TaskDialogTickEventArgs) _
     Handles Me.Tick
        RaiseEvent TDTick(e.Ticks)
    End Sub
#End Region

End Class