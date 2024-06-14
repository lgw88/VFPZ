*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2007 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Checks name for invalid characters for file/directory names
*-*
FUNCTION GKPCheckValidName
LPARAMETERS tcName,tcMode
LOCAL llValid, lnNdx, lcName
#INCLUDE "GKPDefines.h"
llValid = True
DO CASE
	CASE tcMode = "FILE"                   && Check valid file name
		llValid = fCheckFileName(tcName)
	CASE tcMode = "FOLDER"                 && Check valid folder name and path
		llValid = fCheckFolderName(tcName)
	CASE tcMode = "PATH"                   && Check valid folder path and file name
		lnNdx = RATC("\",tcName,1)
		lcName = SUBSTR(tcName,lnNdx+1)
		llValid = fCheckFileName(lcName)
		IF llValid
			lcName = LEFT(tcName,lnNdx-1)
			llValid = fCheckFolderName(lcName)
		ENDIF
ENDCASE
RETURN llValid
ENDFUNC


*-***********************************************************************************************
*-*  Checks filename for invalid characters
*-*
FUNCTION fCheckFileName
LPARAMETERS tcFileName
LOCAL llOK, lnNdx
llOK = True
FOR lnNdx=1 TO LEN(tcFileName)
	IF SUBSTR(tcFileName,lnNdx,1) $ ":/\'*%@!`^%#$~<>?|=" .OR. SUBSTR(tcFileName,lnNdx,1) = '"'
		llOK = False
		EXIT
	ENDIF
ENDFOR
RETURN llOK	
ENDFUNC


*-***********************************************************************************************
*-*  Checks folder name for invalid characters
*-*
FUNCTION fCheckFolderName
LPARAMETERS tcFolderName
LOCAL llOK, lnNdx
llOK = True
FOR lnNdx=1 TO LEN(tcFolderName)
	IF SUBSTR(tcFolderName,lnNdx,1) $ "/'*%@!`^%#$~<>?|=" .OR. SUBSTR(tcFolderName,lnNdx,1) = '"'
		llOK = False
		EXIT
	ENDIF
ENDFOR
RETURN llOK	
ENDFUNC