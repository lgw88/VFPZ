*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-***********************************************************************************************
*-* Main entry point for application
*-*
#INCLUDE gkkdefines.h
FUNCTION GKKTableBrowser
LPARAMETERS tcTableName, tcFormName, tcNode
LOCAL lcSystemApp
IF PEMSTATUS(_SCREEN, "GKKTools", 5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "LastDirectory", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "LastDirectory", ADDBS(SYS(5) + SYS(2003)))
ENDIF
IF VARTYPE(tcTableName) != "C" .AND. VARTYPE(tcTableName) != "O"
	tcTableName = .NULL.
ENDIF
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
lcSystemApp = GKKGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)
	DO FORM GKKTableBrowser WITH tcTableName
ENDIF
ENDFUNC