*-***********************************************************************************************
*-*
*-* Copyright ©2005-2008 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for performing Code Expansion in the CodeMax editor
*-*
FUNCTION GKCCodeExpansion
LPARAMETERS toCodeMax
LOCAL loPosition, lcToken, lcPrefix, lcReplText, lnNumLines, lcScript, lnLine, loRange, llExpanded
LOCAL lcLine, lnNdx, lcChar
LOCAL ARRAY lcCode[1]
#INCLUDE GKCDefines.h
WITH toCodeMax
	llExpanded = False
	loRange = .GetSel(True)
*-*	Get the current line
	lcLine = .GetLine(loRange.StartLineNo)
*-*	Check if current line is commented out (first character is an asterick)
	FOR lnNdx=1 TO LEN(lcLine)
		lcChar = SUBSTR(lcLine,lnNdx,1)
		DO CASE
			CASE INLIST(lcChar," ",TAB)
			CASE lcChar = "*"
				RETURN False
			OTHERWISE
				EXIT
		ENDCASE
	ENDFOR
*-*	Check if position is after in-line comment (&&)
	lnNdx = ATC(CHR(38)+CHR(38),lcLine)
	IF lnNdx > 0 .AND. lnNdx < loRange.StartColNo
		RETURN False
	ENDIF
*-*	Check if position is within delimited text string
	IF fCheckForDelimitedText(lcLine,loRange.StartColNo)
		RETURN False
	ENDIF
*-*	Get the token to possibly expand
	loPosition = CREATEOBJECT("CodeMax.Position.4")
	WITH loPosition
		.ColNo  = loRange.StartColNo - 1
		.LineNo = loRange.StartLineNo
	ENDWITH
	lcToken = .GetWord(loPosition)
	IF !EMPTY(lcToken)
		DO CASE
*-*			Expand any C++ operator notation
			CASE INLIST(lcToken,"++","--","+=","-=","*=","/=","^=","%=")
				lcLine = CHRTRAN(lcLine,TAB," ") 
				lcLine = ALLTRIM(lcLine,1," ",TAB)
				lcLine = ALLTRIM(LEFT(lcLine,LEN(lcLine)-2))
				IF ATC(" ",lcLine) = 0 .AND. !EMPTY(lcLine)
					DO CASE
						CASE INLIST(lcToken,"++","--")
							lcReplText = " = " + lcLine + " " + LEFT(lcToken,1) + " 1"
						OTHERWISE
							lcReplText = " = " + lcLine + " " + LEFT(lcToken,1) + " "
					ENDCASE
					WITH loRange
						.EndColNo   = loPosition.ColNo + 1
						.StartColNo = loPosition.ColNo - 1
					ENDWITH
					.ReplaceText(lcReplText,loRange)
					llExpanded = True
				ENDIF

			OTHERWISE
				SELECT gkcfoxcode
				LOCATE FOR type="U" .AND. ALLTRIM(abbrev)==UPPER(lcToken)
				IF FOUND()
					DO CASE
*-*						Expand code abbreviations (single line)
						CASE !EMPTY(gkcfoxcode.expanded)
							lcReplText = ALLTRIM(gkcfoxcode.expanded)
							DO CASE
								CASE gkcfoxcode.case = "U"
									lcReplText = UPPER(lcReplText)
								CASE gkcfoxcode.case = "L"
									lcReplText = LOWER(lcReplText)
								CASE gkcfoxcode.case = "P"
									lcReplText = PROPER(lcReplText)
								CASE gkcfoxcode.case = "X"
									RETURN
							ENDCASE
							lcReplText = lcReplText + " "
							WITH loRange
								.EndColNo   = loRange.StartColNo
								.StartColNo = loRange.StartColNo - LEN(lcToken) - 1
							ENDWITH
							.ReplaceText(lcReplText,loRange)
							llExpanded = True

*-*						Expand any code block abbreviations
						CASE ALLTRIM(gkcfoxcode.cmd) = "{stmthandler}"
							lcReplText = ALLTRIM(gkcfoxcode.data)
							=fInsertText(lcReplText,toCodeMax,loRange,lcToken)
							llExpanded = True

*-*						Expand any code block abbreviations
						CASE ALLTRIM(gkcfoxcode.cmd) = "{}"
							lnNumLines = ALINES(lcCode,gkcfoxcode.data,True)
							lcScript   = ""
							lnLine = 2
							DO WHILE lnLine <= lnNumLines
								IF !EMPTY(lcCode[lnLine])
									DO CASE
										CASE ATC("FoxCode.Location",lcCode[lnLine]) > 0
											DO WHILE ATC("ENDIF",lcCode[lnLine]) = 0
												lnLine = lnLine + 1
											ENDDO

										CASE ATC("FoxCode.valuetype",lcCode[lnLine]) > 0

										OTHERWISE
											lcScript = lcScript + lcCode[lnLine] + CRLF
									ENDCASE
								ENDIF
								lnLine = lnLine + 1
							ENDDO
							IF !EMPTY(lcScript)
								lcReplText = EXECSCRIPT(lcScript)
								=fInsertText(lcReplText,toCodeMax,loRange,lcToken)
								llExpanded = True
							ENDIF
					ENDCASE
				ENDIF
		ENDCASE
	ENDIF
ENDWITH
RETURN llExpanded
ENDFUNC

*-***********************************************************************************************
*-*  Routine for expanding the foxcode block; returns number of lines inserted
*-*
PROCEDURE fInsertText
LPARAMETERS tcReplText,toCodeMax,toRange,tcToken
LOCAL lcReplText, lnNumLines, lnLinePos, lnColPos, lnTabCnt, lnLine
LOCAL ARRAY lcCode[1]
#INCLUDE GKCDefines.h
WITH toCodeMax
	DO CASE
		CASE gkcfoxcode.case = "U"
			lcReplText = UPPER(tcReplText)
		CASE gkcfoxcode.case = "L"
			lcReplText = LOWER(tcReplText)
		CASE gkcfoxcode.case = "P"
			lcReplText = PROPER(tcReplText)
		CASE gkcfoxcode.case = "X"
			RETURN
		OTHERWISE
			lcReplText = tcReplText
	ENDCASE
	lnNumLines = ALINES(lcCode,lcReplText,True)
	lnLinePos  = 0
*-*	Check for cursor position after expansion
	lnColPos = ATC("~",lcCode[1])
	IF lnColPos > 0
	    lcCode[1] = CHRTRAN(lcCode[1],"~","")
	    lnLinePos = 0
	ENDIF
*-*	Strip any Text merge code from code block (enclosed in <<>>)
	lcCode[1] = fStripTextMerge(lcCode[1])
*-*	Set replacement range for first line of code insert
	WITH toRange
		.EndColNo   = toRange.StartColNo
		.StartColNo = toRange.StartColNo - LEN(tcToken)
	ENDWITH
*-*	Replace the first line (replaces abbreviation)
	IF toCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = False
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)
	.ReplaceText(lcCode[1],toRange)
	lnTabCnt = OCCURS(TAB,.GetLine(toRange.StartLineNo))
	FOR lnLine=2 TO lnNumLines
*-*		Check for cursor position after expansion
		IF lnColPos = 0
			lnColPos = ATC("~",lcCode[lnLine])
			IF lnColPos > 0
			    lcCode[lnLine] = CHRTRAN(lcCode[lnLine],"~","")
			    lnLinePos = lnLine - 1
			ENDIF
		ENDIF
*-*		Strip any Text merge code from code block (enclosed in <<>>)
		lcCode[lnLine] = fStripTextMerge(lcCode[lnLine])
*-*		Add tabs for indentation
		lcCode[lnLine] = REPLICATE(TAB,lnTabCnt) + lcCode[lnLine]
*-*		Insert code block line
		.InsertLine(toRange.StartLineNo+lnLine-1,lcCode[lnLine])
*-*		Set Deleted Line style
		.SetLineStyle(toRange.StartLineNo+lnLine-1,cmNotifyDel)
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)
	IF toCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = True
	ENDIF
*-*	Position the cursor
	WITH toRange
		.StartColNo  = lnTabCnt + lnColPos
		.StartLineNo = .StartLineNo + lnLinePos
		.EndColNo    = .StartColNo
		.EndLineNo   = .StartLineNo
	ENDWITH
	.SetSel(toRange,True)
ENDWITH
ENDPROC

*-***********************************************************************************************
*-*  Routine for expanding the foxcode block; returns number of lines inserted
*-*
PROCEDURE fStripTextMerge
LPARAMETERS tcCode
LOCAL lnEnd, lnBeg
lnBeg = ATC("<<",tcCode)
DO WHILE lnBeg > 0
	lnEnd = ATC(">>",tcCode)
	tcCode = STUFF(tcCode,lnBeg,lnEnd-lnBeg+2,"")
	lnBeg = ATC("<<",tcCode)
ENDDO
RETURN tcCode
ENDPROC

*-***********************************************************************************************
*-*  Routine for determining if position is inside a delimited string
*-*
FUNCTION fCheckForDelimitedText
LPARAMETERS tcLine,tnCol
LOCAL llDelimited, lnNdx, lnPos
llDelimited = False
*-*	Check if position is within text string delimited by ""
lnNdx = 1
lnPos = ATC('"',tcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < tnCol
	lnNdx = lnNdx + 1
	lnPos = ATC('"',tcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < tnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = True
	ENDIF
	lnPos = ATC('"',tcLine,lnNdx)
ENDDO
*-*	Check if position is within text string delimited by ''
lnNdx = 1
lnPos = ATC("'",tcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < tnCol
	lnNdx = lnNdx + 1
	lnPos = ATC("'",tcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < tnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = True
	ENDIF
	lnPos = ATC("'",tcLine,lnNdx)
ENDDO
*-*	Check if position is within text string delimited by []
lnNdx = 1
lnPos = ATC("[",tcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < tnCol
	lnNdx = lnNdx + 1
	lnPos = ATC("]",tcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < tnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = True
	ENDIF
	lnPos = ATC("[",tcLine,lnNdx)
ENDDO
RETURN llDelimited
ENDFUNC