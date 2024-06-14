*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for getting the file path for the System.app (GDI+)
*-*
FUNCTION GKKGetSystemAPP
LOCAL lcPath
lcPath = GKKGetRegString_HKCU("Software\GKK Industries\GKK Tools","SystemAPP")
IF EMPTY(lcPath)
	DO FORM GKKLocFile WITH "System.app" TO lcPath
	IF ISNULL(lcPath) .OR. EMPTY(lcPath)
	ELSE
		=GKKSetRegString_HKCU("Software\GKK Industries\GKK Tools","SystemAPP",JUSTPATH(lcPath))
	ENDIF
ELSE
	lcPath = ADDBS(lcPath) + "System.app"
ENDIF
RETURN lcPath
ENDFUNC