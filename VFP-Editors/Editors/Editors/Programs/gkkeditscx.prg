*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Main entry point for application
*-*
FUNCTION GKKEditSCX
LPARAMETERS tcFileName, tlCheckedOut, tnProjRecNo, tcProjectName
LOCAL lcSystemApp
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
IF VARTYPE(tcFileName)!="C" .OR. EMPTY(tcFileName) .OR. !FILE(tcFileName)
	tcFileName = .NULL.
ENDIF
DO CASE
	CASE PCOUNT() = 1
		tlCheckedOut  = True
		tnProjRecNo   = -1
		tcProjectName = .NULL.

	CASE PCOUNT() = 2
		tnProjRecNo   = -1
		tcProjectName = .NULL.

	CASE PCOUNT() = 3
		tcProjectName = .NULL.

	CASE PCOUNT() = 4

	OTHERWISE
		tcFileName    = .NULL.
		tlCheckedOut  = True
		tnProjRecNo   = -1
		tcProjectName = .NULL.
ENDCASE
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
lcSystemApp = GKKGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)
	DO FORM GKKEditScx WITH tcFileName, tlCheckedOut, tnProjRecNo, tcProjectName
ENDIF
ENDFUNC