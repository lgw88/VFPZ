*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2012 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the desktop path
*-*
#IFNDEF GKKMemberShip
#INCLUDE ..\..\common\includes\gkkdefines.h
#ENDIF
FUNCTION GetDesktopPath
LOCAL lcPath
lcPath = SPACE(255)
IF apiSHGetSpecialFolderPath(0, @lcPath, CSIDL_DESKTOPDIRECTORY, 0) = 1
	lcPath = ADDBS(ALLTRIM(lcPath, 1, " ", CHR(0)))
ELSE
	lcPath = ADDBS(SYS(5) + SYS(2003))
ENDIF
RETURN lcPath
ENDFUNC