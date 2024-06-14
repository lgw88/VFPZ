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
FUNCTION GKPContextMenuIndent
LPARAMETERS toCodeMax,tlIsEmpty
LOCAL loRange, lnLine, loRepl, lcCode, lnChr
#INCLUDE GKPDefines.h
WITH toCodeMax
	loRepl  = .GetSel(True)
	loRange = .GetSel(True)
	IF tlIsEmpty
		loRange.StartColNo = 0
		loRange.EndColNo   = 0
		.SetSel(loRange,True)
	ENDIF
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)    && Begin the Undo marker
	.ExecuteCmd(cmCmdIndentSelection)
	FOR lnLine=loRange.StartLineNo TO loRange.EndLineNo
		lcCode = .GetLine(lnLine)
		IF LEFT(lcCode,2) = TAB+"*"
			loRepl.StartLineNo = lnLine
			loRepl.StartColNo  = 0
			loRepl.EndLineNo   = lnLine
			loRepl.EndColNo    = 1
			.ReplaceText("",loRepl)
			lcCode = SUBSTR(lcCode,2)
			FOR lnChr=2 TO LEN(lcCode)
				IF SUBSTR(lcCode,lnChr,1) = TAB
					loRepl.StartColNo = lnChr - 1
					loRepl.EndColNo   = lnChr
					.ReplaceText(TAB+TAB,loRepl)
					EXIT
				ENDIF
			ENDFOR
		ENDIF
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)    && End the Undo marker
	IF .DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
*-*	Set the change control column indicator and modified indicator
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.SetModified()
*-*	Restore the original selection lines
	.SetSel(loRange,True)
	.KeyDnLineCnt = -1
ENDWITH
ENDFUNC