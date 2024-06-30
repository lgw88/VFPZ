*!*
*!*  This is a simple example that demonstrates use of VistaDialogs4COM
*!*  For a more detailed example, see VistaDialog4VFP project and DialogEventHandlers.prg
*!*
CLEAR
LOCAL loTaskDialog as VistaDialogs4COM.ITaskDialog
loTaskDialog = CREATEOBJECT("VistaDialogs4COM.TaskDialog")

WITH m.loTaskDialog
	.Caption = "Visual FoxPro Sedna Feb 2007 CTP"
	.Instruction = "Task Dialog Sample"
	.Content = "This sample demonstrates use of the task dialog"
	.Show()
ENDWITH

