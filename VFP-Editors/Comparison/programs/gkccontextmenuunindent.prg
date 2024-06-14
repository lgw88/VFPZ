*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuUnindent
LPARAMETERS toCodeMax,plIsEmpty
LOCAL loRange, lnLine, lcCode, lnChr, loRepl
WITH toCodeMax
	loRepl  = .GetSel(True)
	loRange = .GetSel(True)
	IF plIsEmpty
		loRange.StartColNo = 0
		loRange.EndColNo   = 0
		.SetSel(loRange,True)
	ENDIF
	IF .DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)
	.ExecuteCmd(cmCmdUnindentSelection)
	FOR lnLine=loRange.StartLineNo TO loRange.EndLineNo
		lcCode = .GetLine(lnLine)
		IF LEFT(lcCode,1) = "*"
			FOR lnChr=2 TO LEN(lcCode)
				IF SUBSTR(lcCode,lnChr,1) = TAB
					loRepl.StartLineNo = lnLine
					loRepl.StartColNo  = lnChr - 1
					loRepl.EndLineNo   = lnLine
					loRepl.EndColNo    = lnChr
					.ReplaceText("",loRepl)
					EXIT
				ENDIF
			ENDFOR
		ENDIF
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)
	IF .DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.KeyDnLineCnt = -1
	.SetModified()
*-*	Restore the original selection lines
	.SetSel(loRange,True)
ENDWITH
ENDFUNC