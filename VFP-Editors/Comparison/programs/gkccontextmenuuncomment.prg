*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuUncomment
LPARAMETERS toCodeMax
LOCAL loRange, lcComment, lnLine, lcLineText, lnComLen, lnStartLineNo, lnEndLineNo
lcComment = GKCGetCommentStyle()
lnComLen  = LEN(lcComment)
WITH toCodeMax
	loRange = .GetSel(True)
	lnStartLineNo = loRange.StartLineNo 
	lnEndLineNo   = loRange.EndLineNo
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)
	FOR lnLine=lnStartLineNo TO lnEndLineNo
		lcLineText = .GetLine(lnLine)
		loRange.StartLineNo = lnLine
		loRange.EndLineNo   = lnLine
		loRange.StartColNo  = 0
		loRange.EndColNo    = .GetLineLength(lnLine)
		DO CASE
			CASE LEFT(lcLineText,lnComLen+1) = lcComment+CHR(9)
				lcLineText = SUBSTR(lcLineText,lnComLen+2)
				.ReplaceText(lcLineText,loRange)
			CASE LEFT(lcLineText,lnComLen) = lcComment
				lcLineText = SUBSTR(lcLineText,lnComLen+1)
				.ReplaceText(lcLineText,loRange)
			CASE LEFT(lcLineText,4) = "*!*" + CHR(9)
				lcLineText = SUBSTR(lcLineText,5)
				.ReplaceText(lcLineText,loRange)
			CASE LEFT(lcLineText,1) = "*" 
				lcLineText = SUBSTR(lcLineText,2)
				.ReplaceText(lcLineText,loRange)
			CASE LEFT(lcLineText,2) = CHR(38)+CHR(38)
				lcLineText = SUBSTR(lcLineText,3)
				.ReplaceText(lcLineText,loRange)
		ENDCASE
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)
	IF .DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
	.SetChangeControl(lnStartLineNo,lnEndLineNo)
	.KeyDnLineCnt = -1
	.SetModified()
ENDWITH
ENDFUNC