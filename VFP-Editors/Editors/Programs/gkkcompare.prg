*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2005-2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Routine launchng the GKK Comparison Utilities
*-*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKCompare
LPARAMETERS tcLeftFile,tcRightFile,tcFileType
LOCAL llVerCompare, loException, lcUserMsg
IF PEMSTATUS(_SCREEN,"GKKTools",5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF !PEMSTATUS(_SCREEN,"GKKCompareExe",5)
	_SCREEN.AddProperty("GKKCompareExe",.F.)
ENDIF
IF UPPER(RIGHT(SYS(16),3)) = "EXE"
	_SCREEN.GKKCompareExe = .T.
ELSE
	_SCREEN.GKKCompareExe = .F.
ENDIF
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
IF GKKCheckDebugOpen()
	lcUserMsg = "The Visual FoxPro Debugger must be closed before using this tool"
	=MESSAGEBOX(lcUserMsg,16,"GKK Tools",10000)
	RETURN .F.
ENDIF
DO CASE
	CASE PCOUNT() = 0
		DO FORM GKKCompareType TO tcFileType
		tcLeftFile  = ""
		tcRightFile = ""
	CASE PCOUNT() = 1
		DO FORM GKKCompareType TO tcFileType
		tcLeftFile  = ""
		tcRightFile = ""
	CASE PCOUNT() = 2
		DO CASE
			CASE UPPER(JUSTEXT(tcLeftFile)) = "PRG" .AND. UPPER(JUSTEXT(tcRightFile)) = "PRG"
				tcFileType = PRJTYPE_PROGRAM
			CASE UPPER(JUSTEXT(tcLeftFile)) = "SCX" .AND. UPPER(JUSTEXT(tcRightFile)) = "SCX"
				tcFileType = PRJTYPE_FORM
			CASE UPPER(JUSTEXT(tcLeftFile)) = "VCX" .AND. UPPER(JUSTEXT(tcRightFile)) = "VCX"
				tcFileType = PRJTYPE_VCX
			CASE UPPER(JUSTEXT(tcLeftFile)) = "DBF" .AND. UPPER(JUSTEXT(tcRightFile)) = "DBF"
				tcFileType = PRJTYPE_TABLE
			CASE UPPER(JUSTEXT(tcLeftFile)) = "DBC" .AND. UPPER(JUSTEXT(tcRightFile)) = "DBC"
				tcFileType = PRJTYPE_DBC
			OTHERWISE
				lcUserMsg = "Invalid call to program, unmatching file types, or unsupported file types.  Call" + CHR(13) + CHR(13) + "GKKCompare <LeftFile>,<RightFile>" + CHR(13) + CHR(13) + "where <LeftFile>,<RightFile> is a full path to a file of type PRG, VCX, SCX, DBC, or DBF"
				=GKKWMSGBOX(lcUserMsg,"GKK Compare",16,"ERROR")
				RETURN
		ENDCASE
	CASE PCOUNT() = 3
		IF !VARTYPE(tcFileType) = "C"
			DO FORM GKKCompareType TO tcFileType
		ENDIF
ENDCASE
IF !EMPTY(tcFileType)
	IF _SCREEN.GKKCompareExe
		_SCREEN.Visible = .F.
	ENDIF
	DO CASE
		CASE tcFileType = PRJTYPE_PROGRAM
			DO FORM GKKComparePrg WITH tcLeftFile,tcRightFile
		CASE tcFileType = PRJTYPE_FORM
			DO FORM GKKCompareScx WITH tcLeftFile,tcRightFile
		CASE tcFileType = PRJTYPE_VCX
			DO FORM GKKCompareVcx WITH tcLeftFile,tcRightFile
		CASE tcFileType = PRJTYPE_TABLE
			DO FORM GKKCompareTbl WITH tcLeftFile,tcRightFile
		CASE tcFileType = PRJTYPE_DBC
			DO FORM GKKCompareDbc WITH tcLeftFile,tcRightFile
	ENDCASE
	IF _SCREEN.GKKCompareExe
		TRY
			READ EVENTS
		CATCH TO loException
			lcUserMsg = "System Error Occurred"
			=GKKWMSGBOX(lcUserMsg,"System Message",16,"ERROR")
			CLEAR EVENTS
		ENDTRY
	ENDIF
ENDIF
ENDFUNC