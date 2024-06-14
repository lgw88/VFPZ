*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2007-2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the file path for the System.app (GDI+)
*-*
FUNCTION GKPGetSystemAPP
LOCAL lcPath
lcPath = GKPGetRegString_HKCU("Software\GKK Industries\GKK Tools", "SystemAPP")
IF EMPTY(lcPath)
	DO FORM GKPLocFile WITH "System.app" TO lcPath
	IF ISNULL(lcPath) .OR. EMPTY(lcPath)
	ELSE
		=GKPSetRegString_HKCU("Software\GKK Industries\GKK Tools", "SystemAPP", JUSTPATH(lcPath))
	ENDIF
ELSE
	lcPath = ADDBS(lcPath) + "System.app"
ENDIF
RETURN lcPath
ENDFUNC