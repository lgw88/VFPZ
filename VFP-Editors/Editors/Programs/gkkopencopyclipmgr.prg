*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Opens the GKK Copy Clip Manager
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKOpenCopyClipMgr
LOCAL lcAppName
IF PEMSTATUS(_SCREEN.GKKTools,"CopyClipMgr", 5)
	IF !VARTYPE(_SCREEN.GKKTools.CopyClipMgr) = "O"
		lcAppName = GKKGetToolsPath("GKKCopyClipMgr", "GKKCopyClipMgr.APP")
		IF !EMPTY(lcAppName)
			DO (lcAppName)
		ENDIF
	ENDIF
ELSE
	lcAppName = GKKGetToolsPath("GKKCopyClipMgr", "GKKCopyClipMgr.APP")
	IF !EMPTY(lcAppName)
		DO (lcAppName)
	ENDIF
ENDIF
RETURN IIF(VARTYPE(_SCREEN.GKKTools.CopyClipMgr)="O", True, False)
ENDFUNC