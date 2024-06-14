*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuPaste
LPARAMETERS toCodeMax
WITH toCodeMax
	IF PEMSTATUS(toCodeMax,"KeyDnLineCnt",5)
		.KeyDnLineCnt = .LineCount
	ENDIF
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
		.ExecuteCmd(cmCmdPaste)
		.DocViewHighlightEnabled = True
	ELSE
		.ExecuteCmd(cmCmdPaste)
	ENDIF
	.Change()
	.SetFocus()
ENDWITH
ENDFUNC