*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2006-2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Main entry point for application
*-*
FUNCTION GKKEditVCX
LPARAMETERS tcFileName, tcClassName, tlCheckedOut, tnProjRecNo, tcProjectName
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
		tcClassName   = .NULL.
		tlCheckedOut  = True
		tnProjRecNo   = -1
		tcProjectName = .NULL.

	CASE PCOUNT() = 2
		tlCheckedOut  = True
		tnProjRecNo   = -1
		tcProjectName = .NULL.

	CASE PCOUNT() = 3
		tnProjRecNo   = -1
		tcProjectName = .NULL.

	CASE PCOUNT() = 4
		tcProjectName = .NULL.

	CASE PCOUNT() = 5

	OTHERWISE
		tcFileName    = .NULL.
		tcClassName   = .NULL.
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
	DO FORM GKKEditVcx WITH tcFileName, tcClassName, tlCheckedOut, tnProjRecNo, tcProjectName
ENDIF
ENDFUNC