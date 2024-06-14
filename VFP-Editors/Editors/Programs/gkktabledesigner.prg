*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-***********************************************************************************************
*-* Main entry point for application
*-*
#INCLUDE gkkdefines.h
FUNCTION GKKTableDesigner
LPARAMETERS tcTableName, tcDbcName, tnProjRecNo, tcProjectName, tlCreateTable
LOCAL lcSystemApp
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
IF VARTYPE(tcTableName) != "C"
	tcTableName = .NULL.
ENDIF
IF VARTYPE(tcDbcName) != "C"
	tcDbcName = .NULL.
ENDIF
DO CASE
	CASE PCOUNT() = 1
		tcDbcName     = .NULL.
		tnProjRecNo   = 0
		tcProjectName = .NULL.
		tlCreateTable = False

	CASE PCOUNT() = 2
		tnProjRecNo   = 0
		tcProjectName = .NULL.
		tlCreateTable = False

	CASE PCOUNT() = 3
		tcProjectName = .NULL.
		tlCreateTable = False

	CASE PCOUNT() = 4
		tlCreateTable = False

	CASE PCOUNT() = 5

	OTHERWISE
		tcDbcName     = .NULL.
		tcTableName   = .NULL.
		tnProjRecNo   = 0
		tcProjectName = .NULL.
		tlCreateTable = False
ENDCASE
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
lcSystemApp = GKKGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)
	DO FORM GKKTableDesigner WITH tcTableName, tcDbcName, tnProjRecNo, tcProjectName, tlCreateTable
ENDIF
ENDFUNC