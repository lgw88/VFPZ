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
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKContextMenuUppercase
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