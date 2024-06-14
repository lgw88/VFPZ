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
FUNCTION GKKContextMenuCut
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