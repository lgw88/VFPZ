*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2015 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Main program
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION GKKLibrarian
SET PROCEDURE TO DeclareWinAPI.prg ADDITIVE
IF PEMSTATUS(_SCREEN, "GKKTools", 5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "LastDirectory", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "LastDirectory", "")
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "ConfigPath", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "ConfigPath", "")                                  && Path for local configuration
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "DataPath", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "DataPath", "")                                    && Path for shared data
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "GridEvenRows", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "GridEvenRows", RGB(255,255,255))                  && Grid background highlight color
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "GridOddRows", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "GridOddRows", RGB(214,223,247))                   && Grid background highlight color
ENDIF
IF !PEMSTATUS(_SCREEN.GKKTools, "LibraryForm", 5)
	ADDPROPERTY(_SCREEN.GKKTools, "LibraryForm", .NULL.)                             && Handle to the main top level form
ENDIF
IF fGetLocalConfigPath() .AND. fGetDataPathPath()
	lcLastDirectory = GetStringLocal("Setup", "LastDirectory")
	_SCREEN.GKKTools.LastDirectory = IIF(EMPTY(lcLastDirectory), GetDesktopPath(), lcLastDirectory)

	lcSystemApp = _SCREEN.GKKTools.ConfigPath + "Program\System.app"
	DO (lcSystemApp)
	DO FORM GKLLibraryMain NAME loForm
	_SCREEN.GKKTools.LibraryForm = loForm
ENDIF
ENDFUNC


*-************************************************************************************************
*-*  Procedure to get the local configuration path
*-*
FUNCTION fGetLocalConfigPath
_SCREEN.GKKTools.ConfigPath = ADDBS(GetConfigPath())
IF IsLocalConfigDefined(_SCREEN.GKKTools.ConfigPath)
	RETURN True
ELSE
	IF GKKMakePath(_SCREEN.GKKTools.ConfigPath)
		RETURN True
	ELSE
		=WMSGBOX("Unable to create the local configuration file", "System Message", 16, "ERROR")
		RETURN False
	ENDIF
ENDIF
ENDFUNC


*-************************************************************************************************
*-*  Procedure to get the local data path; if not setup, create local data path
*-*
FUNCTION fGetDataPathPath
LOCAL llPathOk
llPathOk = True
_SCREEN.GKKTools.DataPath = _SCREEN.GKKTools.ConfigPath + "Database\"
*_SCREEN.GKKTools.DataPath = "E:\My Work\FoxPro\Projects\GKKLibrarian\Tables\"
IF CheckDatabaseNotExist(_SCREEN.GKKTools.DataPath)
	IF GKKMakePath(_SCREEN.GKKTools.DataPath) .AND. BuildDatabase(_SCREEN.GKKTools.DataPath)
*		AddTableRecords(ADDBS(SYS(5) + SYS(2004))+"Resource", _SCREEN.GKKTools.DataPath)
	ELSE
		llPathOk = False
		WMSGBOX("Unable to create the local database", "System Message", 16, "ERROR")
	ENDIF
	CLOSE DATABASES
ENDIF
RETURN llPathOk
ENDFUNC