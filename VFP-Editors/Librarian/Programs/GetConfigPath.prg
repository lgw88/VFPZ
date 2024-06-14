*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the resource table
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION GetConfigPath
LOCAL lcPath
lcPath = SPACE(255)
IF apiSHGetSpecialFolderPath(0, @lcPath, CSIDL_APPDATA, 0) = 1
	lcPath = ADDBS(ALLTRIM(lcPath)) + "GKK Industries\GKKLibrarian"
ELSE
	RETURN ""
ENDIF
IF GKKMakePath(lcPath)
	RETURN ADDBS(lcPath)
ELSE
	RETURN ""
ENDIF
ENDFUNC