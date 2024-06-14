************************************************************************************************
* Written by:  Gregory A. Green
*
* Copyright ©2013 Gregory A. Green
*
* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*
************************************************************************************************
*
*  Routine for setting the database directory location for the form
*
FUNCTION SetDBCPath
LPARAMETERS toFormDE, tcDBCPath, tcDBCName
LOCAL lcDBCName, lcFilePath, lnNumCursors, lnNdx
lcDBCName  = FORCEEXT(tcDBCName, "DBC")
lcFilePath = ADDBS(tcDBCPath) + lcDBCName
lnNumCursors = AMEMBERS(lcProperties, toFormDE, 2)
FOR lnNdx=1 TO lnNumCursors
	IF UPPER(LEFT(lcProperties[lnNdx], 6)) = "CURSOR"
		IF ATC(lcDBCName, toFormDE.&lcProperties[lnNdx]..Database) > 0
			toFormDE.&lcProperties[lnNdx]..Database = lcFilePath
		ENDIF
	ENDIF
ENDFOR
ENDFUNC