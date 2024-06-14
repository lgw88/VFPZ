*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuComment
LPARAMETERS toCodeMax
LOCAL loRange, lcComment, lnLine, loPosition
lcComment  = GKCGetCommentStyle() + CHR(9)
loPosition = CREATEOBJECT("CodeMax.Position.4")
WITH toCodeMax
	loRange = .GetSel(True)
	IF loRange.EndColNo = 0
		loRange.EndLineNo = loRange.EndLineNo - 1
	ENDIF
	IF toCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)
	FOR lnLine=loRange.StartLineNo TO loRange.EndLineNo
		loPosition.ColNo  = 0
		loPosition.LineNo = lnLine
		.InsertText(lcComment,loPosition)
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)
	IF toCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
*-*	Set the change control column indicator and modified indicator
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo+1)
	.SetModified()
	.KeyDnLineCnt = -1
ENDWITH
ENDFUNC