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
FUNCTION GKPContextMenuUnindent
LPARAMETERS poCodeMax,plIsEmpty
LOCAL loRange, lnLine, lcCode, lnChr, loRepl
#INCLUDE GKPDefines.h
WITH poCodeMax
	loRepl  = .GetSel(.T.)
	loRange = .GetSel(.T.)
	IF plIsEmpty
		loRange.StartColNo = 0
		loRange.EndColNo   = 0
		.SetSel(loRange,.T.)
	ENDIF
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .F.
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
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .T.
	ENDIF
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.KeyDnLineCnt = -1
	.SetModified()
*-*	Restore the original selection lines
	.SetSel(loRange,.T.)
ENDWITH
ENDFUNC