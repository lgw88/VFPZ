*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
FUNCTION GKPContextMenuCut
LPARAMETERS poCodeMax
#INCLUDE GKPDefines.h
WITH poCodeMax
	IF PEMSTATUS(poCodeMax,"KeyDnLineCnt",5)
		.KeyDnLineCnt = .LineCount
	ENDIF
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .F.
		.ExecuteCmd(cmCmdCut)
		.DocViewHighlightEnabled = .T.
	ELSE
		.ExecuteCmd(cmCmdCut)
	ENDIF
	.Change()
	.SetFocus()
ENDWITH
ENDFUNC