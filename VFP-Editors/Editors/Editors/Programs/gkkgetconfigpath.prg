*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for getting the resource table
*-*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKGetConfigPath
LOCAL lcBasePath
lcBasePath = SPACE(255)
IF apiSHGetSpecialFolderPath(0, @lcBasePath, CSIDL_APPDATA, 0) = 1
	lcBasePath = ALLTRIM(lcBasePath)
ELSE
	lcBasePath = JUSTPATH(SYS(2005))
ENDIF
lcBasePath = ADDBS(lcBasePath) + "GKK Industries\GKKEditors"
IF !GKKMakePath(lcBasePath)
	lcBasePath = JUSTPATH(SYS(2005))
ENDIF
RETURN ADDBS(lcBasePath)
ENDFUNC