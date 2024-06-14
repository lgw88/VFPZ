*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKKDefines.h
FUNCTION GKKContextMenuLowercase
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