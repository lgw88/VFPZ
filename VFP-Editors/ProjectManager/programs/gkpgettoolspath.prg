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
FUNCTION GKPGetToolsPath
LPARAMETERS tcKey,tcFileName
LOCAL lcPath
lcPath = GKPGetRegString_HKCU("Software\GKK Industries\GKK Tools",tcKey)
IF EMPTY(lcPath)
	DO FORM GKPLocFile WITH tcFileName TO lcPath
	IF ISNULL(lcPath) .OR. EMPTY(lcPath)
	ELSE
		=GKPSetRegString_HKCU("Software\GKK Industries\GKK Tools",tcKey,JUSTPATH(lcPath))
	ENDIF
ELSE
	lcPath = ADDBS(lcPath) + tcFileName
ENDIF
RETURN lcPath
ENDFUNC