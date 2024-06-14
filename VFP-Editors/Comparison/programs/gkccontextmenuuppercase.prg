*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuUppercase
LPARAMETERS toCodeMax
LOCAL loRange
WITH toCodeMax
	loRange = .GetSel(True)
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	IF loRange.IsEmpty
		.ExecuteCmd(cmCmdWordUppercase)
	ELSE
		.ExecuteCmd(cmCmdUppercaseSelection)
	ENDIF
	IF .DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
	.KeyDnLineCnt = -1
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.SetModified()
ENDWITH
ENDFUNC