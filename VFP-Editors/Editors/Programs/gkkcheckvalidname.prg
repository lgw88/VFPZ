*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Checks name for invalid characters for file/directory names
*-*
FUNCTION GKKCheckValidName
LPARAMETERS pcName,pcMode
LOCAL llValid, lnNdx, lcName
llValid = .T.
DO CASE
	CASE pcMode = "FILE"                   && Check valid file name
		llValid = fCheckFileName(pcName)
	CASE pcMode = "FOLDER"                 && Check valid folder name and path
		llValid = fCheckFolderName(pcName)
	CASE pcMode = "PATH"                   && Check valid folder path and file name
		lnNdx = RATC("\",pcName,1)
		lcName = SUBSTR(pcName,lnNdx+1)
		llValid = fCheckFileName(lcName)
		IF llValid
			lcName = LEFT(pcName,lnNdx-1)
			llValid = fCheckFolderName(lcName)
		ENDIF
ENDCASE
RETURN llValid
ENDFUNC


*-***********************************************************************************************
*-*  Checks filename for invalid characters
*-*
FUNCTION fCheckFileName
LPARAMETERS pcFileName
LOCAL llOK, lnNdx
llOK = .T.
FOR lnNdx=1 TO LEN(pcFileName)
	IF SUBSTR(pcFileName,lnNdx,1) $ ":/\'*%@!`^%#$~<>?|=" .OR. SUBSTR(pcFileName,lnNdx,1) = '"'
		llOK = .F.
		EXIT
	ENDIF
ENDFOR
RETURN llOK	
ENDFUNC


*-***********************************************************************************************
*-*  Checks folder name for invalid characters
*-*
FUNCTION fCheckFolderName
LPARAMETERS pcFolderName
LOCAL llOK, lnNdx
llOK = .T.
FOR lnNdx=1 TO LEN(pcFolderName)
	IF SUBSTR(pcFolderName,lnNdx,1) $ "/'*%@!`^%#$~<>?|=" .OR. SUBSTR(pcFolderName,lnNdx,1) = '"'
		llOK = .F.
		EXIT
	ENDIF
ENDFOR
RETURN llOK	
ENDFUNC