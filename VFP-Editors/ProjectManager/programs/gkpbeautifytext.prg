*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2008-2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Formats selected text for indentation, comment alignment, type of indent, and character case
*-*
FUNCTION GKPBeautifyText
LPARAMETERS tcCodeText,toBeautify,tnTabSize
LOCAL lnNumLines, lnLine, lcCodeText, lnTab, lcCodeBeautify, lnTabInc, llDoCase, lnPos, lnAdj, lnSpace
LOCAL lnChr, lcContinue
LOCAL ARRAY lcCodeLines[1]
#INCLUDE "GKPDefines.h"
lcContinue = ""
lnNumLines = ALINES(lcCodeLines,tcCodeText,True)
lnTab = 0
FOR lnLine=1 TO lnNumLines
	lcCodeText = ALLTRIM(lcCodeLines[lnLine],1,TAB," ")
	DO CASE
		CASE LEFT(lcCodeText,1) = "*"
			IF toBeautify.CommentIndent
				lnTabInc = 0
			ELSE
				lcCodeLines[lnLine] = lcCodeText
				LOOP
			ENDIF
		CASE EMPTY(lcCodeText)
			lcCodeLines[lnLine] = lcCodeText
			LOOP
		CASE UPPER(LEFT(lcCodeText,12)) = "DEFINE CLASS" .OR. UPPER(LEFT(lcCodeText,9)) = "DEF CLASS"
			IF toBeautify.IndentDefine
				lnTabInc = 1
			ELSE
				lnTabInc = 0
			ENDIF
		CASE INLIST(UPPER(LEFT(lcCodeText,14)),"PROTECTED FUNC","PROTECTED PROC") .OR. INLIST(UPPER(LEFT(lcCodeText,9)),"PROT FUNC","PROT PROC")
			IF toBeautify.IndentProc
				lnTabInc = 1
			ELSE
				lnTabInc = 0
			ENDIF
		CASE INLIST(UPPER(LEFT(lcCodeText,8)),"FUNCTION","PROCEDUR") .OR. INLIST(UPPER(LEFT(lcCodeText,5)),"FUNC ","PROC ")
			IF toBeautify.IndentProc
				lnTabInc = 1
			ELSE
				lnTabInc = 0
			ENDIF
		CASE INLIST(UPPER(LEFT(lcCodeText,3)),"IF ","TRY")
			lnTabInc = 1
		CASE INLIST(UPPER(LEFT(lcCodeText,4)),"FOR ","SCAN","TEXT")
			lnTabInc = 1
		CASE UPPER(LEFT(lcCodeText,5)) = "WITH "
			lnTabInc = 1
		CASE INLIST(UPPER(LEFT(lcCodeText,7)),"DO WHIL","PRINTJO")
			IF toBeautify.IndentCase
				lnTabInc = 1
			ELSE
				lnTabInc = 0
			ENDIF
		CASE UPPER(LEFT(lcCodeText,4)) = "ELSE"
			lnTabInc = 1
			lnTab = lnTab - 1
		CASE UPPER(LEFT(lcCodeText,5)) = "CATCH"
			lnTabInc = 1
			lnTab = lnTab - 1
		CASE UPPER(LEFT(lcCodeText,7)) = "FINALLY"
			lnTabInc = 1
			lnTab = lnTab - 1
		CASE UPPER(LEFT(lcCodeText,7)) = "DO CASE"
			IF toBeautify.IndentCase
				lnTabInc = 1
			ELSE
				lnTabInc = 0
			ENDIF
			llDoCase = False
		CASE UPPER(LEFT(lcCodeText,4)) = "CASE"
			lnTabInc = 1
			IF llDoCase
				lnTab = lnTab - 1
			ENDIF
			llDoCase = True
		CASE UPPER(LEFT(lcCodeText,9)) = "OTHERWISE"
			lnTabInc = 1
			lnTab = lnTab - 1
		CASE UPPER(LEFT(lcCodeText,4)) = "NEXT"
			lnTabInc = 0
			lnTab = lnTab - 1
		CASE INLIST(UPPER(LEFT(lcCodeText,5)),"ENDDO","ENDIF")
			lnTabInc = 0
			lnTab = lnTab - 1
		CASE UPPER(LEFT(lcCodeText,11)) = "ENDPRINTJOB"
			lnTabInc = 0
			lnTab = lnTab - 1
		CASE INLIST(UPPER(LEFT(lcCodeText,6)),"ENDTRY","ENDFOR","ENDDEF")
			lnTabInc = 0
			lnTab = lnTab - 1
		CASE UPPER(LEFT(lcCodeText,7)) = "ENDCASE"
			lnTabInc = 0
			IF toBeautify.IndentCase
				lnTab = lnTab - 2
			ELSE
				lnTab = lnTab - 1
			ENDIF
		CASE INLIST(UPPER(LEFT(lcCodeText,7)),"ENDTEXT","ENDSCAN","ENDWITH")
			lnTabInc = 0
			lnTab = lnTab - 1
		CASE INLIST(UPPER(LEFT(lcCodeText,7)),"ENDFUNC","ENDPROC")
			lnTabInc = 0
			IF toBeautify.IndentProc
				lnTab = lnTab - 1
			ENDIF
		OTHERWISE
			lnTabInc = 0
	ENDCASE
	IF lnTab < 0
		lnTab = 0
	ENDIF
	lcCodeLines[lnLine] = REPLICATE(TAB,lnTab) + lcContinue + lcCodeText
	lnTab = lnTab + lnTabInc
	IF RIGHT(lcCodeText,1) = ";"
		lcContinue = TAB
	ELSE
		lcContinue = ""
	ENDIF
ENDFOR
*-*	Check to align comments to user defined column
IF toBeautify.AlignComment
	FOR lnLine=1 TO lnNumLines
*-*		Check each line for in-line comment
		lnPos = ATC("&"+"&",lcCodeLines[lnLine])
		IF lnPos > 0
*-*			Adjust character position to account for tabs
			lnTab = 0
			lnChr = 1
			DO WHILE True
				IF SUBSTR(lcCodeLines[lnLine],lnChr,1) = TAB
					lnTab = lnTab + 1
				ENDIF
				lnChr = lnChr + 1
				IF lnChr > LEN(lcCodeLines[lnLine]) .OR. lnChr = toBeautify.AlignCommentCol
					EXIT
				ENDIF
			ENDDO
*-*			Adjust the position of the in-line comment
			lnAdj = toBeautify.AlignCommentCol - (lnPos + lnTab * (toBeautify.TabSize - 1))
			DO CASE
				CASE lnAdj < 0
					lnAdj   = ABS(lnAdj)
					lnSpace = 0
					FOR lnChr=lnPos-1 TO 1 STEP -1
						IF SUBSTR(lcCodeLines[lnLine],lnChr,1) = SPACE(1)
							lnSpace = lnSpace + 1
						ELSE
							EXIT
						ENDIF
					ENDFOR
					IF lnSpace > 3
						IF lnSpace > lnAdj+3
							lcCodeLines[lnLine] = STUFF(lcCodeLines[lnLine],lnPos-lnAdj,lnAdj,"")
						ELSE
							lnSpace = lnSpace - 3
							lcCodeLines[lnLine] = STUFF(lcCodeLines[lnLine],lnPos-lnSpace,lnSpace,"")
						ENDIF
					ENDIF
				CASE lnAdj > 0
					lcCodeLines[lnLine] = STUFF(lcCodeLines[lnLine],lnPos-1,0,REPLICATE(" ",lnAdj))
			ENDCASE
		ENDIF
	ENDFOR
ENDIF
*-*	Check if user wants spaces instead of tabs for indentation
IF toBeautify.TabChr = 2
	FOR lnLine=1 TO lnNumLines
		lcCodeLines[lnLine] = STRTRAN(lcCodeLines[lnLine],TAB,REPLICATE(" ",toBeautify.TabSize))
	ENDFOR
ENDIF
IF .NOT. GKPOpenFDKEYWRD()
*-*	Check to set the case of keywords
	IF toBeautify.Keywords != 5                                 && No Change
		FOR lnLine=1 TO lnNumLines
			lcCodeLines[lnLine]= fSetCase(lcCodeLines[lnLine],toBeautify.Keywords,"KEYWORDS")
		ENDFOR
	ENDIF
*-*	Check to set the case of symbols
	IF toBeautify.Symbols != 5                                  && No Change
		FOR lnLine=1 TO lnNumLines
			lcCodeLines[lnLine]= fSetCase(lcCodeLines[lnLine],toBeautify.Symbols,"SYMBOLS")
		ENDFOR
	ENDIF
	USE IN fdkeywrd
ENDIF
*-*	Set the return text
lcCodeBeautify = ""
FOR lnLine=1 TO lnNumLines-1
	lcCodeBeautify = lcCodeBeautify + lcCodeLines[lnLine] + CRLF
ENDFOR
lcCodeBeautify = lcCodeBeautify + lcCodeLines[lnNumLines]
RETURN lcCodeBeautify
ENDFUNC


*-***********************************************************************************************
*-* Sets the case for the Keyword/Symbol
*-*
FUNCTION fSetCase
LPARAMETERS tcCodeLine,tnBeautify,tcMode
LOCAL lnBeg, lnEnd, lcToken, lcBegDelimiter, lcEndDelimiter
#DEFINE TAB  CHR(9)
lcBegDelimiter = "!@#$%&*(-+={<,>.?/"  + SPACE(1) + TAB
lcEndDelimiter = "!@#$%&*)-+=}<,>.?/;" + SPACE(1) + TAB
lnBeg = 1
lnEnd = 1
IF ALLTRIM(tcCodeLine,1,TAB," ") != "*"
	DO WHILE lnBeg < LEN(tcCodeLine)
*-*		Do not change text in comment
		IF SUBSTR(tcCodeLine,lnBeg,2) = "&"+"&"
			EXIT
		ENDIF
*-*		Skip quoted strings
		IF INLIST(SUBSTR(tcCodeLine,lnBeg,1),'"',"'","[")
			DO WHILE lnBeg < LEN(tcCodeLine)
				lnBeg = lnBeg + 1
				IF INLIST(SUBSTR(tcCodeLine,lnBeg,1),'"',"'","]")
					lnBeg = lnBeg + 1
					EXIT
				ENDIF
			ENDDO
		ENDIF
*-*		Process next token
		IF !(SUBSTR(tcCodeLine,lnBeg,1) $ lcBegDelimiter)
			lnEnd = lnBeg + 1
			DO WHILE lnEnd <= LEN(tcCodeLine)
				IF SUBSTR(tcCodeLine,lnEnd,1) $ lcEndDelimiter
					EXIT
				ENDIF
				lnEnd = lnEnd + 1
			ENDDO
			lcToken = SUBSTR(tcCodeLine,lnBeg,lnEnd-lnBeg)
			DO CASE
				CASE tcMode = "KEYWORDS"
					LOCATE FOR ALLTRIM(UPPER(fdkeywrd.token)) == ALLTRIM(UPPER(lcToken)) .AND. !INLIST(fdkeywrd.code,"M","P")
				CASE tcMode = "SYMBOLS"
					LOCATE FOR ALLTRIM(UPPER(fdkeywrd.token)) == ALLTRIM(UPPER(lcToken)) .AND. INLIST(fdkeywrd.code,"M","P")
			ENDCASE
			IF FOUND()
				DO CASE
					CASE tnBeautify = 1        && UPPERCASE
						lcToken = UPPER(lcToken)
					CASE tnBeautify = 2        && lowercase
						lcToken = LOWER(lcToken)
					CASE tnBeautify = 3        && Mixed Case
						lcToken = ALLTRIM(fdkeywrd.token)
					CASE tnBeautify = 4        && Proper Case
						lcToken = PROPER(lcToken)
				ENDCASE
				tcCodeLine = STUFF(tcCodeLine,lnBeg,lnEnd-lnBeg,lcToken)
			ENDIF
			lnBeg = lnEnd + 1
		ELSE
			lnBeg = lnBeg + 1
		ENDIF
	ENDDO
ENDIF
RETURN tcCodeLine
ENDFUNC