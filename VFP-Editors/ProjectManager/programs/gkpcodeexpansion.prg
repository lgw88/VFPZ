*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005-2008 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for performing Code Expansion in the CodeMax editor
*-*
FUNCTION GKPCodeExpansion
LPARAMETERS poCodeMax
LOCAL loPosition, lcToken, lcPrefix, lcReplText, lnNumLines, lcScript, lnLine, loRange, llExpanded
LOCAL lcLine, lnNdx, lcChar
LOCAL ARRAY lcCode[1]
#INCLUDE GKPDefines.h
WITH poCodeMax
	llExpanded = .F.
	loRange = .GetSel(.T.)
*-*	Get the current line
	lcLine = .GetLine(loRange.StartLineNo)
*-*	Check if current line is commented out (first character is an asterick)
	FOR lnNdx=1 TO LEN(lcLine)
		lcChar = SUBSTR(lcLine,lnNdx,1)
		DO CASE
			CASE INLIST(lcChar," ",TAB)
			CASE lcChar = "*"
				RETURN .F.
			OTHERWISE
				EXIT
		ENDCASE
	ENDFOR
*-*	Check if position is after in-line comment (&&)
	lnNdx = ATC(CHR(38)+CHR(38),lcLine)
	IF lnNdx > 0 .AND. lnNdx < loRange.StartColNo
		RETURN .F.
	ENDIF
*-*	Check if position is within delimited text string
	IF fCheckForDelimitedText(lcLine,loRange.StartColNo)
		RETURN .F.
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
					llExpanded = .T.
				ENDIF

			OTHERWISE
				SELECT gkpfoxcode
				LOCATE FOR type="U" .AND. ALLTRIM(abbrev)==UPPER(lcToken)
				IF FOUND()
					DO CASE
*-*						Expand code abbreviations (single line)
						CASE !EMPTY(gkpfoxcode.expanded)
							lcReplText = ALLTRIM(gkpfoxcode.expanded)
							DO CASE
								CASE gkpfoxcode.case = "U"
									lcReplText = UPPER(lcReplText)
								CASE gkpfoxcode.case = "L"
									lcReplText = LOWER(lcReplText)
								CASE gkpfoxcode.case = "P"
									lcReplText = PROPER(lcReplText)
								CASE gkpfoxcode.case = "X"
									RETURN
							ENDCASE
							lcReplText = lcReplText + " "
							WITH loRange
								.EndColNo   = loRange.StartColNo
								.StartColNo = loRange.StartColNo - LEN(lcToken) - 1
							ENDWITH
							.ReplaceText(lcReplText,loRange)
							llExpanded = .T.

*-*						Expand any code block abbreviations
						CASE ALLTRIM(gkpfoxcode.cmd) = "{stmthandler}"
							lcReplText = ALLTRIM(gkpfoxcode.data)
							=fInsertText(lcReplText,poCodeMax,loRange,lcToken)
							llExpanded = .T.

*-*						Expand any code block abbreviations
						CASE ALLTRIM(gkpfoxcode.cmd) = "{}"
							lnNumLines = ALINES(lcCode,gkpfoxcode.data,.T.)
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
								=fInsertText(lcReplText,poCodeMax,loRange,lcToken)
								llExpanded = .T.
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
LPARAMETERS pcReplText,poCodeMax,poRange,pcToken
LOCAL lcReplText, lnNumLines, lnLinePos, lnColPos, lnTabCnt, lnLine
LOCAL ARRAY lcCode[1]
#INCLUDE GKPDefines.h
WITH poCodeMax
	DO CASE
		CASE gkpfoxcode.case = "U"
			lcReplText = UPPER(pcReplText)
		CASE gkpfoxcode.case = "L"
			lcReplText = LOWER(pcReplText)
		CASE gkpfoxcode.case = "P"
			lcReplText = PROPER(pcReplText)
		CASE gkpfoxcode.case = "X"
			RETURN
		OTHERWISE
			lcReplText = pcReplText
	ENDCASE
	lnNumLines = ALINES(lcCode,lcReplText,.T.)
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
	WITH poRange
		.EndColNo   = poRange.StartColNo
		.StartColNo = poRange.StartColNo - LEN(pcToken)
	ENDWITH
*-*	Replace the first line (replaces abbreviation)
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .F.
	ENDIF
	.ExecuteCmd(cmCmdBeginUndo)
	.ReplaceText(lcCode[1],poRange)
	lnTabCnt = OCCURS(TAB,.GetLine(poRange.StartLineNo))
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
		.InsertLine(poRange.StartLineNo+lnLine-1,lcCode[lnLine])
*-*		Set Deleted Line style
		.SetLineStyle(poRange.StartLineNo+lnLine-1,cmNotifyDel)
	ENDFOR
	.ExecuteCmd(cmCmdEndUndo)
	IF poCodeMax.DocViewNavigation
		.DocViewHighlightEnabled = .T.
	ENDIF
*-*	Position the cursor
	WITH poRange
		.StartColNo  = lnTabCnt + lnColPos
		.StartLineNo = .StartLineNo + lnLinePos
		.EndColNo    = .StartColNo
		.EndLineNo   = .StartLineNo
	ENDWITH
	.SetSel(poRange,.T.)
ENDWITH
ENDPROC

*-***********************************************************************************************
*-*  Routine for expanding the foxcode block; returns number of lines inserted
*-*
PROCEDURE fStripTextMerge
LPARAMETERS pcCode
LOCAL lnEnd, lnBeg
lnBeg = ATC("<<",pcCode)
DO WHILE lnBeg > 0
	lnEnd = ATC(">>",pcCode)
	pcCode = STUFF(pcCode,lnBeg,lnEnd-lnBeg+2,"")
	lnBeg = ATC("<<",pcCode)
ENDDO
RETURN pcCode
ENDPROC

*-***********************************************************************************************
*-*  Routine for determining if position is inside a delimited string
*-*
FUNCTION fCheckForDelimitedText
LPARAMETERS pcLine,pnCol
LOCAL llDelimited, lnNdx, lnPos
llDelimited = .F.
*-*	Check if position is within text string delimited by ""
lnNdx = 1
lnPos = ATC('"',pcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < pnCol
	lnNdx = lnNdx + 1
	lnPos = ATC('"',pcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < pnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = .T.
	ENDIF
	lnPos = ATC('"',pcLine,lnNdx)
ENDDO
*-*	Check if position is within text string delimited by ''
lnNdx = 1
lnPos = ATC("'",pcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < pnCol
	lnNdx = lnNdx + 1
	lnPos = ATC("'",pcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < pnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = .T.
	ENDIF
	lnPos = ATC("'",pcLine,lnNdx)
ENDDO
*-*	Check if position is within text string delimited by []
lnNdx = 1
lnPos = ATC("[",pcLine,lnNdx)
DO WHILE lnPos > 0 .AND. lnPos < pnCol
	lnNdx = lnNdx + 1
	lnPos = ATC("]",pcLine,lnNdx)
	IF lnPos > 0 .AND. lnPos < pnCol
		lnNdx = lnNdx + 1
	ELSE
		llDelimited = .T.
	ENDIF
	lnPos = ATC("[",pcLine,lnNdx)
ENDDO
RETURN llDelimited
ENDFUNC