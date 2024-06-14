*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*             980 Windmill Parkway
*-*             Evans, GA  30809
*-*             (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for getting the relative file path to the base path
*-*
FUNCTION GKPGetRelativePath
LPARAMETERS tcFileName,tcBasePath
LOCAL lcRelativePath, lcBasePath, lnCnt, lnNdx
IF RIGHT(tcBasePath,1) = "\"
	lcBasePath = LEFT(tcBasePath,LEN(tcBasePath)-1)
ELSE
	lcBasePath = tcBasePath
ENDIF
lcRelativePath = ALLTRIM(tcFileName)
IF UPPER(LEFT(lcRelativePath,2)) = UPPER(LEFT(lcBasePath,2))
	IF ATC(lcBasePath,lcRelativePath) = 1
		lcRelativePath = SUBSTR(lcRelativePath,LEN(lcBasePath)+2)
	ELSE
		lnCnt = 0
		lnNdx = RATC("\",lcBasePath)
		DO WHILE lnNdx > 0
			lnCnt = lnCnt + 1
			lcBasePath = LEFT(lcBasePath,lnNdx-1)
			IF ATC(lcBasePath,lcRelativePath) = 1 .AND. LEN(lcBasePath) > 3
				lcRelativePath = REPLICATE("..\",lnCnt) + SUBSTR(lcRelativePath,LEN(lcBasePath)+2)
				EXIT
			ENDIF
			lnNdx = RATC("\",lcBasePath)
		ENDDO
	ENDIF
ENDIF
RETURN lcRelativePath
ENDFUNC