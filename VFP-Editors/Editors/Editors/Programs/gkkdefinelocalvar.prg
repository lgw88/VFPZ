*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine to get variable at cursor and define as a local
*-*
FUNCTION GKKDefineLocalVar
LPARAMETERS poCodeMax
LOCAL loRange, lnBeg, lnEnd, lcVarName, lnLine, llFound, loPosition, lnChgLine
LOCAL ARRAY lcCommand[1], lcFunction[1]
loRange = poCodeMax.GetSel(.T.)
lnLine  = 0
IF loRange.StartLineNo = loRange.EndLineNo
	=ALANGUAGE(lcCommand,1)
	=ALANGUAGE(lcFunction,2)
	lcDelimiters = "!@#$%&*()-+=\[]:;<>?/,. " + CHR(9)
	lcCodeLine = poCodeMax.GetLine(loRange.StartLineNo)
*-*	Get the starting position of the variable
	lnBeg = loRange.StartColNo + 1
	DO WHILE lnBeg > 0 .AND. SUBSTR(lcCodeLine,lnBeg,1)!=" " .AND. !(SUBSTR(lcCodeLine,lnBeg,1) $ lcDelimiters)
		lnBeg = lnBeg - 1
	ENDDO
	lnBeg = lnBeg + 1
*-*	Get the ending position of the variable
	lnEnd = loRange.EndColNo
	DO WHILE lnEnd <= LEN(lcCodeLine) .AND. !(SUBSTR(lcCodeLine,lnEnd,1) $ lcDelimiters)
		lnEnd = lnEnd + 1
	ENDDO
*-*	Get the variable to declare as LOCAL
	lcVarName = ALLTRIM(SUBSTR(lcCodeLine,lnBeg,lnEnd-lnBeg))
	DO CASE
*-*		Check if a command or function name is selected
		CASE ASCAN(lcCommand,lcVarName,1,ALEN(lcCommand,1),1,15)>0 .OR. ASCAN(lcFunction,lcVarName,1,ALEN(lcFunction,1),1,15)>0
			IF PEMSTATUS(poCodeMax.parent,"MsgText",5)
				poCodeMax.parent.MsgText.Caption = "Not a variable name"
			ENDIF
			lnLine = 0
*-*		Check if a property/method name is selected
		CASE SUBSTR(lcCodeLine,lnEnd,1) $ "![(." .OR. SUBSTR(lcCodeLine,lnBeg-1,1) = "."
			IF PEMSTATUS(poCodeMax.parent,"MsgText",5)
				poCodeMax.parent.MsgText.Caption = "Not a variable name"
			ENDIF
			lnLine = 0
		OTHERWISE
*-*			Check if already defined in a LOCAL statement
			IF !CheckLocalStatements(poCodeMax,loRange.StartLineNo,lcVarName)
*-*				Determine where the LOCAL statement is defined
				llFound = .F.
				FOR lnLine=loRange.StartLineNo TO 0 STEP -1
					lcCodeLine = UPPER(ALLTRIM(CHRTRAN(poCodeMax.GetLine(lnLine),CHR(9)," ")))
				    DO CASE
				        CASE LEFT(lcCodeLine,6) == "LOCAL " .AND. GETWORDNUM(lcCodeLine,2) != "ARRAY"
			                llFound = .T.
			                EXIT
				        CASE INLIST(LEFT(lcCodeLine,4),"LPAR","PARA","FUNC","PROC")
				            EXIT
				        CASE LEFT(lcCodeLine, 10) == "PROTECTED "
				            IF INLIST(GETWORDNUM(lcCodeLine,2),"FUNCTION","PROCEDURE")
				                EXIT
				            ENDIF
				    ENDCASE
				ENDFOR
				IF llFound
*-*					Add to existing LOCAL statement
					IF LEN(lcCodeLine) <= 100
						loPosition = CREATEOBJECT("CodeMax.Position.4")
						loPosition.LineNo = lnLine
						loPosition.ColNo  = poCodeMax.GetLineLength(lnLine)
						poCodeMax.InsertText(", "+lcVarName,loPosition)
						lnChgLine = lnLine
						lnLine = -1
					ELSE
						lnLine = lnLine + 1
						poCodeMax.InsertLine(lnLine,"LOCAL "+lcVarName)
						loRange.StartLineNo = loRange.StartLineNo + 1
						loRange.EndLineNo   = loRange.StartLineNo
						poCodeMax.SetSel(loRange,.T.)
						lnChgLine = lnLine
					ENDIF
				ELSE
*-*					Add to new LOCAL statement
					lnBeg = 0
					FOR lnLine=loRange.StartLineNo-1 TO 0 STEP -1
						lcCodeLine = UPPER(ALLTRIM(CHRTRAN(poCodeMax.GetLine(lnLine),CHR(9)," ")))
					    DO CASE
					        CASE INLIST(LEFT(lcCodeLine,4),"LPAR","PARA","FUNC","PROC")
					        	DO WHILE RIGHT(ALLTRIM(poCodeMax.GetLine(lnLine)),1) = ";"
					        		lnLine = lnLine + 1
					        	ENDDO
					        	lnBeg = lnLine + 1
					            EXIT
					        CASE LEFT(lcCodeLine, 10) == "PROTECTED "
					            IF INLIST(GETWORDNUM(lcCodeLine,2),"FUNCTION","PROCEDURE")
						        	lnBeg = lnLine
					                EXIT
					            ENDIF
					    ENDCASE
					ENDFOR
					FOR lnLine=lnBeg TO loRange.StartLineNo-1
						lcCodeLine = UPPER(ALLTRIM(CHRTRAN(poCodeMax.GetLine(lnLine),CHR(9)," ")))
						IF LEFT(lcCodeLine,1) != "*" .AND. LEFT(lcCodeLine,2) != CHR(38)+CHR(38)
							EXIT
						ENDIF
					ENDFOR
					poCodeMax.InsertLine(lnLine,"LOCAL "+lcVarName)
					loRange.StartLineNo = loRange.StartLineNo + 1
					loRange.EndLineNo   = loRange.StartLineNo
					lnChgLine = lnLine
					poCodeMax.SetSel(loRange,.T.)
				ENDIF
				IF PEMSTATUS(poCodeMax.parent,"MsgText",5)
					poCodeMax.parent.MsgText.Caption   = "Local Declaration Inserted"
				ENDIF
*-*				Set the change control column indicator
				poCodeMax.ChgLineCount = poCodeMax.LineCount
				poCodeMax.SetChangeControl(lnChgLine,lnChgLine)
				poCodeMax.SetModified()
*-*				Increment DocView lines to account for any inserted lines if this is the PRG Editor
				IF poCodeMax.DocViewNavigation .AND. lnLine > -1
					WITH poCodeMax.Parent
						WITH .CodeMaxTabs.DocView(.CodeMaxTabs.CurrentTab)
							IF !EMPTY(.DocViewList[1,1])
								FOR lnNdx=1 TO ALEN(.DocViewList,1)
									IF .DocViewList[lnNdx,2] >= lnLine
										.DocViewList[lnNdx,2] = .DocViewList[lnNdx,2] + 1
									ENDIF
								ENDFOR
							ENDIF
						ENDWITH
					ENDWITH
				ENDIF
			ENDIF
	ENDCASE
ENDIF
RETURN lnLine
ENDFUNC


*-*********************************************************************
*-*  Function to check the LOCAL statements and to determine if variable is declared
*-*
FUNCTION CheckLocalStatements
LPARAMETERS poCodeMax, pnLine, pcVarName
LOCAL llDeclared, lnLine, lcCodeLine, lnOffset
llDeclared = .F.
FOR lnLine=pnLine TO 0 STEP -1
	lcCodeLine = UPPER(ALLTRIM(CHRTRAN(poCodeMax.GetLine(lnLine),CHR(9)," ")))
    DO CASE
        CASE LEFT(lcCodeLine,6) = "LOCAL "
			lnOffset = 0
			DO WHILE RIGHT(lcCodeLine,1) = ";"
				lnOffset = lnOffset + 1
				lcCodeLine = LEFT(lcCodeLine,LEN(lcCodeLine)-1) + UPPER(ALLTRIM(CHRTRAN(poCodeMax.GetLine(lnLine+lnOffset),CHR(9)," ")))
			ENDDO
			llDeclared = CheckIfDeclared(lcCodeLine,pcVarName)
			IF llDeclared
				IF PEMSTATUS(poCodeMax.parent,"MsgText",5)
					poCodeMax.parent.MsgText.Caption = pcVarName + " Already Declared"
				ENDIF
				EXIT
			ENDIF
        CASE INLIST(LEFT(lcCodeLine,4),"LPAR","PARA","FUNC","PROC")
            EXIT
        CASE LEFT(lcCodeLine,10) == "PROTECTED "
            IF INLIST(GETWORDNUM(lcCodeLine,2),"FUNCTION","PROCEDURE")
                EXIT
            ENDIF
    ENDCASE
ENDFOR
RETURN llDeclared
ENDFUNC


*-*********************************************************************
*-*  Function to determine if variable is already declared in LOCAL statement
*-*
FUNCTION CheckIfDeclared
LPARAMETERS pcCodeLine,pcVarName
LOCAL llDeclared
DO CASE
	CASE ATC(" " + pcVarName + ",", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC(" " + pcVarName + " ", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC("," + pcVarName + ",", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC("," + pcVarName + " ", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC("," + pcVarName + "(", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC("," + pcVarName + "[", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC(" " + pcVarName + "(", pcCodeLine) > 0
		llDeclared = .T.
	CASE ATC(" " + pcVarName + "[", pcCodeLine) > 0
		llDeclared = .T.
	CASE UPPER(RIGHT(pcCodeLine,LEN(pcVarName))) = UPPER(pcVarName)
		llDeclared = .T.
	OTHERWISE
		llDeclared = .F.
ENDCASE
RETURN llDeclared
ENDFUNC