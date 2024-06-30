DEFINE CLASS TaskDialogEventHandler AS session OLEPUBLIC

	IMPLEMENTS ITaskDialogEvents IN "VISTADIALOGS4COM.TASKDIALOG"

	PROCEDURE ITaskDialogEvents_TDClosing(Cancel AS LOGICAL, CustomButton AS STRING, StandardButton AS Number) AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ITaskDialogEvents_TDHelpInvoked() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ITaskDialogEvents_TDHyperlinkClick(LinkText AS STRING) AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ITaskDialogEvents_TDOpened() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ITaskDialogEvents_TDTick(Ticks AS Number) AS VOID
	* add user code here
	ENDPROC

ENDDEFINE

DEFINE CLASS TaskDialogRadioButtonEventHandler AS session OLEPUBLIC

	IMPLEMENTS ITaskDialogRadioButtonEvents IN "VISTADIALOGS4COM.TaskDialogRadioButton"

	PROCEDURE ITaskDialogRadioButtonEvents_TDClick() AS VOID
	* add user code here
	ENDPROC

ENDDEFINE

DEFINE CLASS TaskDialogCommandLinkEventHandler AS session OLEPUBLIC

	IMPLEMENTS ITaskDialogCommandLinkEvents IN "VISTADIALOGS4COM.TASKDIALOGCOMMANDLINK"

	PROCEDURE ITaskDialogCommandLinkEvents_TDClick() AS VOID
	* add user code here
	ENDPROC

ENDDEFINE

DEFINE CLASS TaskDialogButtonEventHandler AS session OLEPUBLIC

	IMPLEMENTS ITaskDialogButtonEvents IN "VISTADIALOGS4COM.TASKDIALOGBUTTON"

	PROCEDURE ITaskDialogButtonEvents_TDClick() AS VOID
	* add user code here
	ENDPROC

ENDDEFINE

DEFINE CLASS CommonSaveFileDialogEventHandler AS session OLEPUBLIC

	IMPLEMENTS ICommonSaveFileDialogEvents IN "VISTADIALOGS4COM.COMMONSAVEFILEDIALOG"

	PROCEDURE ICommonSaveFileDialogEvents_TDFileOk() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonSaveFileDialogEvents_TDFileTypeChanged() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonSaveFileDialogEvents_TDFolderChanged() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonSaveFileDialogEvents_TDFolderChanging(Cancel AS LOGICAL, Folder AS STRING) AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonSaveFileDialogEvents_TDOpening() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonSaveFileDialogEvents_TDSelectionChanged() AS VOID
	* add user code here
	ENDPROC

ENDDEFINE

DEFINE CLASS CommonOpenFileDialogEventHandler AS session OLEPUBLIC

	IMPLEMENTS ICommonOpenFileDialogEvents IN "VISTADIALOGS4COM.COMMONOPENFILEDIALOG"

	PROCEDURE ICommonOpenFileDialogEvents_TDFileOk(Cancel AS LOGICAL) AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonOpenFileDialogEvents_TDFileTypeChanged() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonOpenFileDialogEvents_TDFolderChanged() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonOpenFileDialogEvents_TDFolderChanging(Cancel AS LOGICAL, Folder AS STRING) AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonOpenFileDialogEvents_TDOpening() AS VOID
	* add user code here
	ENDPROC

	PROCEDURE ICommonOpenFileDialogEvents_TDSelectionChanged() AS VOID
	* add user code here
	ENDPROC

ENDDEFINE