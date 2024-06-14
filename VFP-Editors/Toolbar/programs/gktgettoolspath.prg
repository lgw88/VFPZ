*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2007-2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the file path for the passed filename
*-*
FUNCTION GKTGetToolsPath
LPARAMETERS tcKey, tcFileName
LOCAL lcPath
lcPath = GKTGetRegString_HKCU("Software\GKK Industries\GKK Tools",tcKey)
IF EMPTY(lcPath)
	DO FORM GKTLocFile WITH tcFileName TO lcPath
	IF ISNULL(lcPath) .OR. EMPTY(lcPath)
	ELSE
		=GKTSetRegString_HKCU("Software\GKK Industries\GKK Tools",tcKey,JUSTPATH(lcPath))
	ENDIF
ELSE
	lcPath = ADDBS(lcPath) + tcFileName
ENDIF
RETURN lcPath
ENDFUNC