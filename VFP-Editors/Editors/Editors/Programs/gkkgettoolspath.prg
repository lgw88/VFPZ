*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for getting the file path for the passed filename
*-*
FUNCTION GKKGetToolsPath
LPARAMETERS tcKey, tcFileName
LOCAL lcPath
lcPath = GKKGetRegString_HKCU("Software\GKK Industries\GKK Tools", tcKey)
IF EMPTY(lcPath)
	DO FORM GKKLocFile WITH tcFileName TO lcPath
	IF ISNULL(lcPath) .OR. EMPTY(lcPath)
	ELSE
		=GKKSetRegString_HKCU("Software\GKK Industries\GKK Tools", tcKey, JUSTPATH(lcPath))
	ENDIF
ELSE
	lcPath = ADDBS(lcPath) + tcFileName
ENDIF
RETURN lcPath
ENDFUNC