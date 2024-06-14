*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2007-2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the file path for the System.app (GDI+)
*-*
FUNCTION GKLGetSystemAPP
LOCAL lcPath
lcPath = GKLGetRegString_HKCU("Software\GKK Industries\GKK Tools","SystemAPP")
IF EMPTY(lcPath)
	DO FORM GKLLocFile WITH "System.app" TO lcPath
	IF ISNULL(lcPath) .OR. EMPTY(lcPath)
	ELSE
		=GKLSetRegString_HKCU("Software\GKK Industries\GKK Tools","SystemAPP",JUSTPATH(lcPath))
	ENDIF
ELSE
	lcPath = ADDBS(lcPath) + "System.app"
ENDIF
RETURN lcPath
ENDFUNC