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
FUNCTION GKKContextMenuComment
LPARAMETERS toCodeMax
LOCAL loRange, lcComment, lnLine, loPosition
lcComment  = GKKGetCommentStyle() + CHR(9)
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