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
FUNCTION GKPContextMenuComment
LPARAMETERS poCodeMax
LOCAL loRange, lcComment, lnLine, loPosition
#INCLUDE GKPDefines.h
lcComment  = GKPGetCommentStyle() + CHR(9)
loPosition = CREATEOBJECT("CodeMax.Position.4")
WITH poCodeMax
	loRange = .GetSel(.T.)
	IF loRange.EndColNo = 0
		loRange.EndLineNo = loRange.EndLineNo - 1
	ENDIF
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .F.
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)
	FOR lnLine=loRange.StartLineNo TO loRange.EndLineNo
		loPosition.ColNo  = 0
		loPosition.LineNo = lnLine
		.InsertText(lcComment,loPosition)
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .T.
	ENDIF
*-*	Set the change control column indicator and modified indicator
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo+1)
	.SetModified()
	.KeyDnLineCnt = -1
ENDWITH
ENDFUNC