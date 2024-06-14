*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for setting the full file path
*-*
FUNCTION GKKGetFileFullPath
LPARAMETERS tcFileName, tcBasePath
LOCAL lcFileName, lnCnt, lcBasePath
lcBasePath = ADDBS(tcBasePath)
lcFileName = ALLTRIM(tcFileName)
IF ASC(RIGHT(lcFileName, 1)) = 0
	lcFileName = LEFT(lcFileName, LEN(lcFileName)-1)
ENDIF
lnCnt = 0
DO WHILE LEFT(lcFileName, 2) = ".."
	lcFileName = SUBSTR(lcFileName, 4)
	lnCnt = lnCnt + 1
ENDDO
IF lnCnt > 0
	lcFileName = LEFT(lcBasePath, RATC("\", lcBasePath, lnCnt+1)) + lcFileName
ELSE
	IF ATC(":", lcFileName) = 0
		lcFileName = lcBasePath + lcFileName
	ENDIF
ENDIF
RETURN lcFileName
ENDFUNC