FUNCTION GKCCompare
LPARAMETERS tcLeftFile, tcRightFile, tcFileType
LOCAL loException, lcUserMsg, lcLibPath
#DEFINE False   .F.
#DEFINE True    .T.
IF PEMSTATUS(_SCREEN, "GKKTools", 5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.ADDPROPERTY("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF  .NOT. PEMSTATUS(_SCREEN, "GKCCompareExe", 5)
	_SCREEN.ADDPROPERTY("GKCCompareExe", False)
ENDIF
IF !('GKCDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKCDeclareAPI ADDITIVE
ENDIF
IF UPPER(RIGHT(SYS(16), 3)) = "EXE"
	_SCREEN.GKCCompareExe = True
ELSE
	_SCREEN.GKCCompareExe = False
ENDIF
IF ATC("GKKCOMPARE", SET("LIBRARY")) = 0
	lcLibPath = LEFT(SYS(16), RATC("\", SYS(16)))
	lcLibPath = SUBSTR(lcLibPath,ATC(" ",lcLibPath,2)) + "GKKCOMPARE.FLL"
	SET LIBRARY TO (lcLibPath) ADDITIVE
ENDIF
IF  .NOT. ('GKCCmpDeclareAPI' $ SET('Procedure'))
	SET PROCEDURE TO GKCCmpDeclareAPI ADDITIVE
ENDIF
IF GKCCheckDebugOpen()
	lcUserMsg = "The Visual FoxPro Debugger must be closed before using this tool"
	= MESSAGEBOX(lcUserMsg, 16, "GKC Tools", 10000)
	RETURN False
ENDIF
DO CASE
	CASE PCOUNT() = 0
		DO FORM GKCCompareType TO tcFileType
		tcLeftFile = ""
		tcRightFile = ""

	CASE PCOUNT() = 1
		DO FORM GKCCompareType TO tcFileType
		tcLeftFile = ""
		tcRightFile = ""

	CASE PCOUNT() = 2
		DO CASE
			CASE UPPER(JUSTEXT(tcLeftFile))="PRG" .AND. UPPER(JUSTEXT(tcRightFile))="PRG"
				tcFileType = "P"

			CASE UPPER(JUSTEXT(tcLeftFile))="SCX" .AND. UPPER(JUSTEXT(tcRightFile))="SCX"
				tcFileType = "K"

			CASE UPPER(JUSTEXT(tcLeftFile))="VCX" .AND. UPPER(JUSTEXT(tcRightFile))="VCX"
				tcFileType = "V"

			CASE UPPER(JUSTEXT(tcLeftFile))="DBF" .AND. UPPER(JUSTEXT(tcRightFile))="DBF"
				tcFileType = "D"

			CASE UPPER(JUSTEXT(tcLeftFile))="DBC" .AND. UPPER(JUSTEXT(tcRightFile))="DBC"
				tcFileType = "d"

			OTHERWISE
				lcUserMsg = "Invalid call to program, unmatching file types, or unsupported file types.  Call"+CHR(13)+CHR(13)+"GKCCompare <LeftFile>,<RightFile>"+CHR(13)+CHR(13)+"where <LeftFile>,<RightFile> is a full path to a file of type PRG, VCX, SCX, DBC, or DBF"
				= GKCWMSGBOX(lcUserMsg, "GKC Compare", 16, "ERROR")
				RETURN
		ENDCASE

	CASE PCOUNT() = 3
		IF  .NOT. VARTYPE(tcFileType)="C"
			DO FORM GKCCompareType TO tcFileType
		ENDIF
ENDCASE
IF  .NOT. EMPTY(tcFileType)
	IF _SCREEN.GKCCompareExe
		_SCREEN.VISIBLE = False
	ENDIF
	DO CASE
		CASE tcFileType = "P"
			DO FORM GKCComparePrg WITH tcLeftFile, tcRightFile

		CASE tcFileType = "K"
			DO FORM GKCCompareScx WITH tcLeftFile, tcRightFile

		CASE tcFileType = "V"
			DO FORM GKCCompareVcx WITH tcLeftFile, tcRightFile

		CASE tcFileType = "D"
			DO FORM GKCCompareTbl WITH tcLeftFile, tcRightFile

		CASE tcFileType = "d"
			DO FORM GKCCompareDbc WITH tcLeftFile, tcRightFile
	ENDCASE
	IF _SCREEN.GKCCompareExe
		TRY
			READ EVENTS
		CATCH TO loException
			lcUserMsg = "System Error Occurred"
			GKCWMSGBOX(lcUserMsg, "System Message", 16, "ERROR")
			CLEAR EVENTS
		ENDTRY
	ENDIF
ENDIF
ENDFUNC