*-***********************************************************************************************
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuPropercase
LPARAMETERS toCodeMax
LOCAL loRange, loPosition, lcWord, lcCode, lnNdx, lnCnt
WITH toCodeMax
	loRange    = .GetSel(True)
	loPosition = CREATEOBJECT("CodeMax.Position.4")
	WITH loPosition
		.ColNo  = loRange.StartColNo
		.LineNo = loRange.StartLineNo
	ENDWITH
	lcCode = .GetLine(loRange.StartLineNo)
	lcWord = .GetWord(loPosition)
	lnNdx = RATC(lcWord,lcCode)
	lnCnt = 1
	DO WHILE lnNdx>loRange.StartColNo+1
		lnCnt = lnCnt + 1
		lnNdx = RATC(lcWord,lcCode,lnCnt)
		IF lnNdx = 0
			lnNdx = RATC(lcWord,lcCode,lnCnt-1)
			EXIT
		ENDIF
	ENDDO
	WITH loRange
		.StartColNo = lnNdx - 1
		.EndLineNo  = .StartLineNo
		.EndColNo   = .StartColNo + LEN(lcWord)
	ENDWITH
	.ReplaceText(PROPER(lcWord),loRange)
	.KeyDnLineCnt = -1
	.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
	.SetModified()
ENDWITH
ENDFUNC