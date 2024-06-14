*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Adds line numbers to RTF text
*-*
FUNCTION GKPRTFAddLineNumbers
LPARAMETERS pcRTFText,pnBegLine,pnEndLine
LOCAL lnPos, lnNdx, lnLast, lnBeg, lnEnd, lcPrevCF
lnPos = ATC(";}}",pcRTFText)
IF lnPos > 0
*-*	Add the first line number at end of command string
	DO WHILE SUBSTR(pcRTFText,lnPos,1) != " "
		lnPos = lnPos + 1
	ENDDO
	pcRTFText = STUFF(pcRTFText,lnPos,0,"\cf0 "+TRANSFORM(pnBegLine)+"\tab")
	lnLast = lnPos
*-*	Add the remaining line numbers
	pnBegLine = pnBegLine + 1
	lnNdx = 1
	lnPos = ATC("\par",pcRTFText,lnNdx)
	DO WHILE lnPos > 0
*-*		Get the last color assignment
		lnBeg = lnPos
		DO WHILE .T.
			lnBeg = lnBeg - 1
			IF SUBSTR(pcRTFText,lnBeg,3) = "\cf"
				lnEnd = lnBeg + 3
				DO WHILE .T.
					lnEnd = lnEnd + 1
					IF INLIST(SUBSTR(pcRTFText,lnEnd,1)," ","\")
						lcPrevCF = SUBSTR(pcRTFText,lnBeg,lnEnd-lnBeg)
						EXIT
					ENDIF
					IF lnEnd = LEN(pcRTFText)
						lcPrevCF = ""
						EXIT
					ENDIF
				ENDDO
				EXIT
			ENDIF
			IF lnBeg = lnLast
				lcPrevCF = ""
				EXIT
			ENDIF
		ENDDO
*-*		Set the line number
		pcRTFText = STUFF(pcRTFText,lnPos+4,0,"\cf0 "+TRANSFORM(pnBegLine)+"\tab"+lcPrevCF)
*-*		Get the next line
		lnNdx = lnNdx + 1
		pnBegLine = pnBegLine + 1
		lnPos = ATC("\par",pcRTFText,lnNdx)
	ENDDO
ENDIF
RETURN pcRTFText
ENDFUNC 