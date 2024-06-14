*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuCut
LPARAMETERS toCodeMax
WITH toCodeMax
	IF PEMSTATUS(toCodeMax,"KeyDnLineCnt",5)
		.KeyDnLineCnt = .LineCount
	ENDIF
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
		.ExecuteCmd(cmCmdCut)
		.DocViewHighlightEnabled = True
	ELSE
		.ExecuteCmd(cmCmdCut)
	ENDIF
	.Change()
	.SetFocus()
ENDWITH
ENDFUNC