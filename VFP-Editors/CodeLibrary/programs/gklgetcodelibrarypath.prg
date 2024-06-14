*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the code snippet table
*-*
#IFNDEF GKLDEFINES
#INCLUDE gkldefines.h
#ENDIF
FUNCTION GKLGetCodeLibraryPath
LOCAL lcBasePath
lcBasePath = SPACE(255)
IF apiSHGetSpecialFolderPath(0, @lcBasePath, CSIDL_APPDATA, 0) = 1
	lcBasePath = ALLTRIM(lcBasePath)
ELSE
	lcBasePath = JUSTPATH(SYS(2005))
ENDIF
lcBasePath = ADDBS(lcBasePath) + "GKK Industries\GKKCodeLibrary"
IF !GKLMakePath(lcBasePath)
	lcBasePath = JUSTPATH(SYS(2005))
ENDIF
RETURN ADDBS(lcBasePath)
ENDFUNC