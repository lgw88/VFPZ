*-***********************************************************************************************
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuBuildExpression
LPARAMETERS toCodeMax
LOCAL loRange, lcExpression, loPosition
GETEXPR "Insert Expression" TO lcExpression
IF !EMPTY(lcExpression)
	WITH toCodeMax
		IF .DocViewNavigation
			.DocViewHighlightEnabled = False
		ENDIF
		.ExecuteCmd(cmCmdBeginUndo)
		loRange = .GetSel(True)
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
			.DocViewHighlightEnabled = True
		ENDIF
*-*		Set the change control column indicator and modified indicator
		.SetChangeControl(loRange.StartLineNo,loRange.StartLineNo)
		.SetModified()
		.SetSel(loRange,True)
		.KeyDnLineCnt = -1
	ENDWITH
ENDIF
ENDFUNC