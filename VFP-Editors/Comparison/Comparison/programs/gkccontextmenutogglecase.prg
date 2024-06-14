*-***********************************************************************************************
*-*
*-* Copyright ©2007 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Context menu routine
*-*
#INCLUDE GKCDefines.h
FUNCTION GKCContextMenuTogglecase
LPARAMETERS toCodeMax
LOCAL loRange, lcCode, lcWord, lnNdx, lcToggle, loReplace, lnBeg
WITH toCodeMax
	loRange = .GetSel(True)
	IF loRange.IsEmpty
		lcCode = .GetLine(loRange.StartLineNo)
*-*		Get the beginning of the word (first white space)
		lnBeg = loRange.StartColNo
		DO WHILE ISALPHA(SUBSTR(lcCode,lnBeg,1)) .OR. ISDIGIT(SUBSTR(lcCode,lnBeg,1))
			lnBeg = lnBeg - 1
			IF lnBeg <= 1
				EXIT
			ENDIF
		ENDDO
*-*		Get the end of the word (first white space)
		lnEnd = loRange.StartColNo
		DO WHILE ISALPHA(SUBSTR(lcCode,lnEnd,1)) .OR. ISDIGIT(SUBSTR(lcCode,lnEnd,1))
			lnEnd = lnEnd + 1
			IF lnEnd = LEN(lcCode)
				EXIT
			ENDIF
		ENDDO
*-*		Change the case of the word
		lcWord = SUBSTR(lcCode,lnBeg,lnEnd-lnBeg)
		lcToggle = ""
		FOR lnNdx=1 TO LEN(lcWord)
			IF ISUPPER(SUBSTR(lcWord,lnNdx,1))
				lcToggle = lcToggle + LOWER(SUBSTR(lcWord,lnNdx,1))
			ELSE
				lcToggle = lcToggle + UPPER(SUBSTR(lcWord,lnNdx,1))
			ENDIF
		ENDFOR
*-*		Replace the word
		loRange.StartColNo = lnBeg - 1
		loRange.EndColNo   = lnEnd - 1
		.ReplaceText(lcToggle,loRange)
		
	ELSE
		IF loRange.EndColNo = 0
			loRange.EndLineNo = loRange.EndLineNo - 1
			lcCode = .GetLine(loRange.EndLineNo)
			loRange.EndColNo  = LEN(lcCode)
		ENDIF
		IF loRange.StartLineNo = loRange.EndLineNo
			lcCode = .GetLine(loRange.StartLineNo)
			lcWord = SUBSTR(lcCode,loRange.StartColNo+1,loRange.EndColNo-loRange.StartColNo)
			lcToggle = ""
			FOR lnNdx=1 TO LEN(lcWord)
				IF ISUPPER(SUBSTR(lcWord,lnNdx,1))
					lcToggle = lcToggle + LOWER(SUBSTR(lcWord,lnNdx,1))
				ELSE
					lcToggle = lcToggle + UPPER(SUBSTR(lcWord,lnNdx,1))
				ENDIF
			ENDFOR
			.ReplaceText(lcToggle,loRange)
		ELSE
			FOR lnLine=loRange.StartLineNo TO loRange.EndLineNo
				lcCode = .GetLine(lnLine)
				DO CASE
					CASE lnLine = loRange.StartLineNo .AND. loRange.StartColNo > 0
						lcToggle = LEFT(lcCode,loRange.StartColNo)
						FOR lnNdx=loRange.StartColNo+1 TO LEN(lcCode)
							IF ISUPPER(SUBSTR(lcCode,lnNdx,1))
								lcToggle = lcToggle + LOWER(SUBSTR(lcCode,lnNdx,1))
							ELSE
								lcToggle = lcToggle + UPPER(SUBSTR(lcCode,lnNdx,1))
							ENDIF
						ENDFOR

					CASE lnLine = loRange.EndLineNo
						lcToggle = ""
						FOR lnNdx=1 TO loRange.EndColNo
							IF ISUPPER(SUBSTR(lcCode,lnNdx,1))
								lcToggle = lcToggle + LOWER(SUBSTR(lcCode,lnNdx,1))
							ELSE
								lcToggle = lcToggle + UPPER(SUBSTR(lcCode,lnNdx,1))
							ENDIF
						ENDFOR
						lcToggle = lcToggle + SUBSTR(lcCode,loRange.EndColNo+1)

					OTHERWISE
						lcToggle = ""
						FOR lnNdx=1 TO LEN(lcCode)
							IF ISUPPER(SUBSTR(lcCode,lnNdx,1))
								lcToggle = lcToggle + LOWER(SUBSTR(lcCode,lnNdx,1))
							ELSE
								lcToggle = lcToggle + UPPER(SUBSTR(lcCode,lnNdx,1))
							ENDIF
						ENDFOR
				ENDCASE
				loReplace = .GetSel(True)
				WITH loReplace
					.StartLineNo = lnLine
					.StartColNo  = 0
					.EndLineNo   = lnLine
					.EndColNo    = LEN(lcCode)
				ENDWITH
				.ReplaceText(lcToggle,loReplace)
			ENDFOR
		ENDIF
		.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
		.SetModified()
	ENDIF
ENDWITH
ENDFUNC