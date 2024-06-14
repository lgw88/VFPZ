*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for the full path from a base path and relative path
*-*
FUNCTION GKKGetPathFromRelative
LPARAMETERS tcBasePath, tcRelativePath
LOCAL lnCnt, lcBasePath, lnNdx, lcRelativePath
IF EMPTY(tcRelativePath)
	lcFilePath = ADDBS(tcBasePath)
ELSE
	lcRelativePath = RTRIM(tcRelativePath, 1, "\")
	lnCnt = OCCURS("..", tcRelativePath)
	lcBasePath = RTRIM(tcBasePath, 1, "\")
	FOR lnNdx=1 TO lnCnt
		lcBasePath = LEFT(lcBasePath, RATC("\", lcBasePath)-1)
	ENDFOR
	lcRelativePath = SUBSTR(lcRelativePath, ATC("..", lcRelativePath, lnCnt)+2)
	lcFilePath = ADDBS(lcBasePath + lcRelativePath)
ENDIF
RETURN lcFilePath
ENDFUNC