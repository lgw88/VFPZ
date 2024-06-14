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
FUNCTION GKPContextMenuLowercase
LPARAMETERS poCodeMax
LOCAL loRange
#INCLUDE GKPDefines.h
WITH poCodeMax
	loRange = .GetSel(.T.)
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .F.
	ENDIF
	IF loRange.IsEmpty
		.ExecuteCmd(cmCmdWordLowerCase)
	ELSE
		.ExecuteCmd(cmCmdLowercaseSelection)
	ENDIF
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .T.
	ENDIF
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.SetModified()
ENDWITH
ENDFUNC