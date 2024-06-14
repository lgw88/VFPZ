*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for getting the relative file path to the base path
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKGetRelativePath
LPARAMETERS tcFileName, tcBasePath
*-*	LOCAL lcPath, lcFrom, lnFromAttrib, lcTo, lnToAttrib
*-*	lcPath       = SPACE(MAX_PATH)
*-*	lcFrom       = IIF(VARTYPE(tcFrom) = 'C', tcFrom, SYS(5) + CURDIR()) + CHR(0)
*-*	lnFromAttrib = IIF(DIRECTORY(lcFrom), FILE_ATTRIBUTE_DIRECTORY, FILE_ATTRIBUTE_NORMAL)

*-*	lcTo         = IIF(VARTYPE(tcTo) = 'C', tcTo, SYS(5) + CURDIR()) + CHR(0)
*-*	lnToAttrib   = IIF(DIRECTORY(lcTo), FILE_ATTRIBUTE_DIRECTORY, FILE_ATTRIBUTE_NORMAL)

*-*	apiPathRelativePathTo(@lcPath, @lcFrom, lnFromAttrib, @lcTo, lnToAttrib)
*-*	lcPath = ALLTRIM(STRTRAN(lcPath, CHR(0), ' '))
*-*	DO CASE
*-*	    CASE EMPTY(lcPath)
*-*	        lcPath = tcTo

*-*	    CASE lcPath = '.\'
*-*	        lcPath = SUBSTR(lcPath, 3)
*-*	ENDCASE
*-*	RETURN lcPath

LOCAL lcRelativePath, lcBasePath, lnCnt, lnNdx
IF RIGHT(tcBasePath,1) = "\"
	lcBasePath = LEFT(tcBasePath, LEN(tcBasePath)-1)
ELSE
	lcBasePath = tcBasePath
ENDIF
lcRelativePath = ALLTRIM(tcFileName)
IF UPPER(LEFT(lcRelativePath, 2)) = UPPER(LEFT(lcBasePath, 2))
	IF ATC(lcBasePath,lcRelativePath) = 1
		lcRelativePath = SUBSTR(lcRelativePath, LEN(lcBasePath)+2)
	ELSE
		lnCnt = 0
		lnNdx = RATC("\",lcBasePath)
		DO WHILE lnNdx > 0
			lnCnt = lnCnt + 1
			lcBasePath = LEFT(lcBasePath,lnNdx-1)
			IF ATC(lcBasePath,lcRelativePath) = 1 .AND. LEN(lcBasePath) > 3
				lcRelativePath = REPLICATE("..\", lnCnt) + SUBSTR(lcRelativePath, LEN(lcBasePath)+2)
				EXIT
			ENDIF
			lnNdx = RATC("\", lcBasePath)
		ENDDO
	ENDIF
ENDIF
RETURN lcRelativePath
ENDFUNC