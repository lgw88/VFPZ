*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
FUNCTION GKPContextMenuBuildExpression
LPARAMETERS poCodeMax
LOCAL loRange, lcExpression, loPosition
#INCLUDE GKPDefines.h
GETEXPR "Insert Expression" TO lcExpression
IF !EMPTY(lcExpression)
	WITH poCodeMax
		IF .DocViewNavigation
			.DocViewHighlightEnabled = .F.
		ENDIF
		.ExecuteCmd(cmCmdBeginUndo)
		loRange = .GetSel(.T.)
		IF loRange.IsEmpty()
			loPosition = CREATEOBJECT("CodeMax.Position.4")
			loPosition.ColNo  = loRange.StartColNo
			loPosition.LineNo = loRange.StartLineNo
			.InsertText(lcExpression,loPosition)
		ELSE
			.ReplaceText(lcExpression,loRange)
		ENDIF
		loRange.EndColNo  = loRange.StartColNo + LEN(lcExpression)
		loRange.EndLineNo = loRange.StartLineNo
		.ExecuteCmd(cmCmdEndUndo)
		IF .DocViewNavigation
			.DocViewHighlightEnabled = .T.
		ENDIF
*-*		Set the change control column indicator and modified indicator
		.SetChangeControl(loRange.StartLineNo,loRange.StartLineNo)
		.SetModified()
		.SetSel(loRange,.T.)
		.KeyDnLineCnt = -1
	ENDWITH
ENDIF
ENDFUNC