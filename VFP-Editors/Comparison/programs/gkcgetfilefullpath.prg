*-***********************************************************************************************
*-*
*-* Copyright ©2005-2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for setting the full file path
*-*
FUNCTION GKCGetFileFullPath
LPARAMETERS tcFileName,tcBasePath
LOCAL lcFileName, lnCnt, lcBasePath
lcBasePath = ADDBS(tcBasePath)
lcFileName = ALLTRIM(tcFileName)
IF ASC(RIGHT(lcFileName,1)) = 0
	lcFileName = LEFT(lcFileName,LEN(lcFileName)-1)
ENDIF
lnCnt = 0
DO WHILE LEFT(lcFileName,2) = ".."
	lcFileName = SUBSTR(lcFileName,4)
	lnCnt = lnCnt + 1
ENDDO
IF lnCnt > 0
	lcFileName = LEFT(lcBasePath,RATC("\",lcBasePath,lnCnt+1)) + lcFileName
ELSE
	IF ATC(":",lcFileName) = 0
		lcFileName = lcBasePath + lcFileName
	ENDIF
ENDIF
RETURN lcFileName
ENDFUNC