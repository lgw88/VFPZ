*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuLowercase
LPARAMETERS toCodeMax
LOCAL loRange
WITH toCodeMax
	loRange = .GetSel(True)
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	IF loRange.IsEmpty
		.ExecuteCmd(cmCmdWordLowerCase)
	ELSE
		.ExecuteCmd(cmCmdLowercaseSelection)
	ENDIF
	IF .DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.SetModified()
ENDWITH
ENDFUNC