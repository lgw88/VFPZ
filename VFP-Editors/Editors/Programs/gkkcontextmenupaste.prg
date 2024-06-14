*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKContextMenuPaste
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