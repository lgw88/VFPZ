*-************************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005-2008 Gregory A. Green
*-*
*-************************************************************************************************
*-* Routine for comparing to text objects and determining differences; algorithm based on 
*-* the Longest Common Sequence
*-*
FUNCTION GKKCompareCode
LPARAMETERS poLCodeMax,poRCodeMax,poCompareSettings
LOCAL llCompareResult, lnLLineCnt, lnRLineCnt, lnNdx, lcLText, lcRText, lnLine, lnTotLines, lnLNdx, lnRNdx, lnLCS, lnLLast, lnRLast
LOCAL lnLBlock, lnRBlock, lnOffset, lnBkMkCnt, lcUserMsg, loGKKDisplayMsg, llCmpCondWS, llCmpLeadWS, lnMaxLines
LOCAL ARRAY lcLCodeMax[1], lcRCodeMax[1], lcLCode[1], lcRCode[1], lcLCS[1,2], lnSeq[1,2], lnLineColor[1,2], llBkMkList[1]
#INCLUDE gkkdefines.h
IF poLCodeMax.text == poRCodeMax.text
	RETURN .T.
ELSE
	llCmpCondWS = poCompareSettings.CmpCondWS
	llCmpLeadWS = poCompareSettings.CmpLeadWS
	lnMaxLines  = poCompareSettings.CmpMaxLines
	llCompareResult = .F.
	IF poLCodeMax.LineCount > lnMaxLines .OR. poRCodeMax.LineCount > lnMaxLines
		lcUserMsg = "Number of lines in code exceeds " + TRANSFORM(lnMaxLines) + "; no comparison available (can be increased in configuration options)."
		=GKKWMSGBOX(lcUserMsg,"Code Comparison",16,"WARNING")
		RETURN .F.
	ELSE
		lnLLineCnt = ALINES(lcLCodeMax,poLCodeMax.text,0)
		lnRLineCnt = ALINES(lcRCodeMax,poRCodeMax.text,0)
	ENDIF
	IF lnLLineCnt > 0 .AND. lnRLineCnt > 0
		DO FORM GKKDisplayMsg WITH 0,"Please wait, comparing code..." NAME loGKKDisplayMsg
		=INKEY(0.1,'H')
		SET EXACT ON
*-*		Remove leading whitespace; make copy for comparison (original to reconstruct programs)
		DIMENSION lcLCode[lnLLineCnt], lcRCode[lnRLineCnt]
		FOR lnNdx=1 TO lnLLineCnt
			DO CASE
				CASE llCmpLeadWS .AND. llCmpCondWS
					lcLCode[lnNdx] = fStripLine(lcLCodeMax[lnNdx])
					lcLCode[lnNdx] = fCondLine(lcLCode[lnNdx])
				CASE llCmpLeadWS .AND. !llCmpCondWS
					lcLCode[lnNdx] = fStripLine(lcLCodeMax[lnNdx])
				CASE !llCmpLeadWS .AND. llCmpCondWS
					lcLCode[lnNdx] = fCondLine(lcLCodeMax[lnNdx])
				OTHERWISE
					lcLCode[lnNdx] = UPPER(lcLCodeMax[lnNdx])
			ENDCASE
		ENDFOR
		FOR lnNdx=1 TO lnRLineCnt
			DO CASE
				CASE llCmpLeadWS .AND. llCmpCondWS
					lcRCode[lnNdx] = fStripLine(lcRCodeMax[lnNdx])
					lcRCode[lnNdx] = fCondLine(lcRCode[lnNdx])
				CASE llCmpLeadWS .AND. !llCmpCondWS
					lcRCode[lnNdx] = fStripLine(lcRCodeMax[lnNdx])
				CASE !llCmpLeadWS .AND. llCmpCondWS
					lcRCode[lnNdx] = fCondLine(lcRCodeMax[lnNdx])
				OTHERWISE
					lcRCode[lnNdx] = UPPER(lcRCodeMax[lnNdx])
			ENDCASE
		ENDFOR
*-*		Initialize LCS matrix
		DIMENSION lcLCS[lnLLineCnt+1,lnRLineCnt+1]
		FOR lnLNdx=1 TO lnLLineCnt+1
			lcLCS[lnLNdx,lnRLineCnt+1] = 0
		ENDFOR
		FOR lnRNdx=1 TO lnRLineCnt+1
			lcLCS[lnLLineCnt+1,lnRNdx] = 0
		ENDFOR
*-*		Build the LCS Matrix
		FOR lnLNdx=lnLLineCnt TO 1 STEP -1                   && For each line in the first file...
			FOR lnRNdx=lnRLineCnt TO 1 STEP -1               && Find best match in second file
				IF lcLCode[lnLNdx] = lcRCode[lnRNdx]
					lcLCS[lnLNdx,lnRNdx] = 1 + lcLCS[lnLNdx+1,lnRNdx+1]
				ELSE
					lcLCS[lnLNdx,lnRNdx] = MAX(lcLCS[lnLNdx+1,lnRNdx],lcLCS[lnLNdx,lnRNdx+1])
				ENDIF
			ENDFOR
		ENDFOR
*-*		Determine the LCS path from the LCS matrix
		lnLNdx = 1
		lnRNdx = 1
		lnLCS  = 0
		DO WHILE lnLNdx <= lnLLineCnt .AND. lnRNdx <= lnRLineCnt
			IF lcLCode[lnLNdx] = lcRCode[lnRNdx]
				lnLCS = lnLCS + 1
				DIMENSION lnSeq[lnLCS,2]
				lnSeq[lnLCS,1] = lnLNdx
				lnSeq[lnLCS,2] = lnRNdx
				lnRNdx = lnRNdx + 1
				lnLNdx = lnLNdx + 1
			ELSE
				IF lcLCS[lnLNdx+1,lnRNdx] >= lcLCS[lnLNdx,lnRNdx+1]
					lnLNdx = lnLNdx + 1
				ELSE
					lnRNdx = lnRNdx + 1
				ENDIF
			ENDIF
		ENDDO
*-*		Assign the compared text and line colors to the codemax views	
		lcLText = ""
		lcRText = ""
		lnLLast = 0
		lnRLast = 0
		lnBkMkCnt  = 0
		lnTotLines = 0
		FOR lnLine=1 TO lnLCS
			lnLBlock = lnSeq[lnLine,1] - lnLLast
			lnRBlock = lnSeq[lnLine,2] - lnRLast
			DO CASE
				CASE lnLBlock = 1 .AND. lnRBlock > 1            && Different block on right
					lnBkMkCnt = lnBkMkCnt + 1
					DIMENSION llBkMkList[lnBkMkCnt]
					llBkMkList[lnBkMkCnt] = lnTotLines
					FOR lnNdx=lnRLast+1 TO lnSeq[lnLine,2]-1
						lnTotLines = lnTotLines + 1
						DIMENSION lnLineColor[lnTotLines,2]
						lnLineColor[lnTotLines,1] = LINEMISSING
						lnLineColor[lnTotLines,2] = LINEDIFFERENT
						lcLText = lcLText + CRLF
						lcRText = lcRText + CRLF + lcRCodeMax[lnNdx]
					ENDFOR

				CASE lnLBlock > 1 .AND. lnRBlock = 1            && Different block on left
					lnBkMkCnt = lnBkMkCnt + 1
					DIMENSION llBkMkList[lnBkMkCnt]
					llBkMkList[lnBkMkCnt] = lnTotLines
					FOR lnNdx=lnLLast+1 TO lnSeq[lnLine,1]-1
						lnTotLines = lnTotLines + 1
						DIMENSION lnLineColor[lnTotLines,2]
						lnLineColor[lnTotLines,1] = LINEDIFFERENT
						lnLineColor[lnTotLines,2] = LINEMISSING
						lcLText = lcLText + CRLF + lcLCodeMax[lnNdx]
						lcRText = lcRText + CRLF
					ENDFOR

				CASE lnLBlock > 1 .AND. lnRBlock > 1            && Different blocks on left and right
					IF lnLBlock = lnRBlock 
						lnBkMkCnt = lnBkMkCnt + 1
						DIMENSION llBkMkList[lnBkMkCnt]
						llBkMkList[lnBkMkCnt] = lnTotLines
						FOR lnNdx=lnLLast+1 TO lnSeq[lnLine,1]-1
							lcLText = lcLText + CRLF + lcLCodeMax[lnNdx]
						ENDFOR
						FOR lnNdx=lnRLast+1 TO lnSeq[lnLine,2]-1
							lcRText = lcRText + CRLF + lcRCodeMax[lnNdx]
						ENDFOR
						FOR lnNdx=1 TO lnRBlock-1
							lnTotLines = lnTotLines + 1
							DIMENSION lnLineColor[lnTotLines,2]
							lnLineColor[lnTotLines,1] = LINESIMILAR
							lnLineColor[lnTotLines,2] = LINESIMILAR
						ENDFOR
					ELSE
*-*						Process the block on the left
						lnBkMkCnt = lnBkMkCnt + 1
						DIMENSION llBkMkList[lnBkMkCnt]
						llBkMkList[lnBkMkCnt] = lnTotLines
						FOR lnNdx=lnLLast+1 TO lnSeq[lnLine,1]-1
							lnTotLines = lnTotLines + 1
							DIMENSION lnLineColor[lnTotLines,2]
							lnLineColor[lnTotLines,1] = LINEDIFFERENT
							lnLineColor[lnTotLines,2] = LINEMISSING
							lcLText = lcLText + CRLF + lcLCodeMax[lnNdx]
							lcRText = lcRText + CRLF
						ENDFOR
*-*						Process the block on the Right
						lnBkMkCnt = lnBkMkCnt + 1
						DIMENSION llBkMkList[lnBkMkCnt]
						llBkMkList[lnBkMkCnt] = lnTotLines
						FOR lnNdx=lnRLast+1 TO lnSeq[lnLine,2]-1
							lnTotLines = lnTotLines + 1
							DIMENSION lnLineColor[lnTotLines,2]
							lnLineColor[lnTotLines,1] = LINEMISSING
							lnLineColor[lnTotLines,2] = LINEDIFFERENT
							lcLText = lcLText + CRLF
							lcRText = lcRText + CRLF + lcRCodeMax[lnNdx]
						ENDFOR
					ENDIF
			ENDCASE
*-*			Add matched lines
			lnTotLines = lnTotLines + 1
			DIMENSION lnLineColor[lnTotLines,2]
			lnLineColor[lnTotLines,1] = LINEMATCH
			lnLineColor[lnTotLines,2] = LINEMATCH
			lcLText = lcLText + CRLF + lcLCodeMax[lnSeq[lnLine,1]]
			lcRText = lcRText + CRLF + lcRCodeMax[lnSeq[lnLine,2]]
*-*			Save reference to last set processed
			lnLLast = lnSeq[lnLine,1]
			lnRLast = lnSeq[lnLine,2]
		ENDFOR
*-*		Add any remaining code blocks at end of procedures
		IF lnSeq[lnLCS,1] < lnLLineCnt
			lnBkMkCnt = lnBkMkCnt + 1
			DIMENSION llBkMkList[lnBkMkCnt]
			llBkMkList[lnBkMkCnt] = lnTotLines
			FOR lnLine=lnSeq[lnLCS,1]+1 TO lnLLineCnt
				lcLText = lcLText + CRLF + lcLCodeMax[lnLine]
				lcRText = lcRText + CRLF
				lnTotLines = lnTotLines + 1
				DIMENSION lnLineColor[lnTotLines,2]
				lnLineColor[lnTotLines,1] = LINEDIFFERENT
				lnLineColor[lnTotLines,2] = LINEMISSING
			ENDFOR
		ENDIF
		IF lnSeq[lnLCS,2] < lnRLineCnt
			lnBkMkCnt = lnBkMkCnt + 1
			DIMENSION llBkMkList[lnBkMkCnt]
			llBkMkList[lnBkMkCnt] = lnTotLines
			FOR lnLine=lnSeq[lnLCS,2]+1 TO lnRLineCnt
				lcLText = lcLText + CRLF
				lcRText = lcRText + CRLF + lcRCodeMax[lnLine]
				lnTotLines = lnTotLines + 1
				DIMENSION lnLineColor[lnTotLines,2]
				lnLineColor[lnTotLines,1] = LINEMISSING
				lnLineColor[lnTotLines,2] = LINEDIFFERENT
			ENDFOR
		ENDIF
*-*		Assign compared text to CodeMax and set line background color
		poLCodeMax.text = SUBSTR(lcLText,3)
		poRCodeMax.text = SUBSTR(lcRText,3)
		FOR lnLine=1 TO lnTotLines
			poLCodeMax.SetLineColor(lnLine-1,lnLineColor[lnLine,1])
			poRCodeMax.SetLineColor(lnLine-1,lnLineColor[lnLine,2])
		ENDFOR
*-*		Set bookmarks at start of each difference
		FOR lnLine=1 TO lnBkMkCnt
			poLCodeMax.SetBookmark(llBkMkList[lnLine],.T.)
			poRCodeMax.SetBookmark(llBkMkList[lnLine],.T.)
		ENDFOR
		loGKKDisplayMsg.Release()
		SET EXACT OFF
	ELSE
	ENDIF
ENDIF
RETURN llCompareResult
ENDFUNC


*-************************************************************************************************
*-*  Routine for condensing embedded double-spaces and to uppercase for comparison
*-*
FUNCTION fCondLine
LPARAMETERS pcTextLine
DO WHILE ATC("  ",pcTextLine) > 0
	pcTextLine = STRTRAN(pcTextLine,"  "," ")
ENDDO
pcTextLine = UPPER(pcTextLine)
RETURN pcTextLine
ENDFUNC


*-************************************************************************************************
*-*  Routine for stripping leading tabs and spaces and to uppercase for comparison
*-*
FUNCTION fStripLine
LPARAMETERS pcTextLine
pcTextLine = CHRTRAN(pcTextLine,CHR(9)," ")
pcTextLine = UPPER(pcTextLine)
pcTextLine = ALLTRIM(pcTextLine)
RETURN pcTextLine
ENDFUNC