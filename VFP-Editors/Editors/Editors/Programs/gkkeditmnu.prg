*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2005-2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine launchng the GKK Menu Editor
*-*
FUNCTION GKKEditMnu
LPARAMETERS tcFileName, tnCmdType, taDetail, toProjectDock, tlCheckedOut, tnProjRecNo
LOCAL ARRAY lcDir[1]
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
IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF
IF PCOUNT() < 5
	tlCheckedOut = True
ENDIF
IF VARTYPE(tnCmdType) != "N"
	tnCmdType = 4
ENDIF
lcSystemApp = GKKGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)
	DO CASE
		CASE tnCmdType = 1          && New menu
			DO FORM GKKEditMNU WITH "", MNU_TYPE_STANDARD, toProjectDock, tlCheckedOut, tnProjRecNo

		CASE tnCmdType = 2          && New shortcut menu
			DO FORM GKKEditMNU WITH "", MNU_TYPE_SHORTCUT, toProjectDock, tlCheckedOut, tnProjRecNo

		CASE tnCmdType = 3          && Edit existing menu
			IF ADIR(lcDir,tcFileName) > 0
				DO FORM GKKEditMNU WITH tcFileName, MNU_TYPE_UNDEFINED, toProjectDock, tlCheckedOut, tnProjRecNo
			ENDIF

		CASE tnCmdType = 4          && Allow open of menu
			DO FORM GKKEditMNU WITH .NULL., MNU_TYPE_STANDARD, toProjectDock, tlCheckedOut, tnProjRecNo
	ENDCASE
ENDIF
ENDFUNC