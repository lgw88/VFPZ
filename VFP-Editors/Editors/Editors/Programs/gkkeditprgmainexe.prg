FUNCTION GKKEditPRGMainExe
LPARAMETERS tcFileName, tlCheckedOut, tnProjRecNo
LOCAL lcSystemApp, lcCurDirectory
#INCLUDE gkkdefines.h
IF PEMSTATUS(_SCREEN,"GKKTools",5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools,"LastDirectory",5)
	ADDPROPERTY(_SCREEN.GKKTools,"LastDirectory",ADDBS(SYS(5) + SYS(2003)))
ENDIF
IF VARTYPE(tcFileName)!="C" .OR. EMPTY(tcFileName)
	tcFileName = ""
ENDIF
DO CASE
	CASE PCOUNT() = 1
		tlCheckedOut = True
		tnProjRecNo  = -1

	CASE PCOUNT() = 2
		tnProjRecNo = -1

	CASE PCOUNT() = 3

	OTHERWISE
		tlCheckedOut = True
		tnProjRecNo  = -1
ENDCASE
lcCurDirectory = "E:\My Work\FoxPro\Projects\GKKTools\Editors\Exe"
SET DEFAULT TO (lcCurDirectory)
_FOXCODE = ADDBS(lcCurDirectory) + "FOXCODE2.DBF"
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
lcSystemApp = GKKGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)
	DO FORM GKKEditPrg WITH tcFileName, tlCheckedOut, tnProjRecNo
	READ EVENTS
ENDIF
ENDFUNC