************************************************************************************************
*-* Copyright �2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
************************************************************************************************
* Function to create the directory location
*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKMakePath
LPARAMETERS tcDirectory
LOCAL llSuccess, lcPath, lnLen, lnNdx, loException, lnSlash, lnSlashCnt
llSuccess = True
IF !DIRECTORY(tcDirectory,1)                                         && Check for directory already existing
	lnSlashCnt = OCCURS("\",tcDirectory)
	IF LEFT(tcDirectory,2) = "\\"                                    && Check for server/share name passed
		lnSlash = 4
	ELSE
		IF SUBSTR(tcDirectory,2,1) = ":"                             && Check for drive letter included
			lnSlash = 2
		ELSE
			llSuccess = False
		ENDIF
	ENDIF
	lcPath = LEFT(tcDirectory,ATC("\",tcDirectory,lnSlash)-1)
	DO WHILE lnSlash <= lnSlashCnt
		TRY
			IF !DIRECTORY(lcPath,1)
				MKDIR (lcPath)                                       && Create the subdirectories
			ENDIF
		CATCH TO loException
			llSuccess = False
		ENDTRY
		IF !llSuccess
			EXIT
		ENDIF
		lnSlash = lnSlash + 1
		lcPath = LEFT(tcDirectory,ATC("\",tcDirectory,lnSlash)-1)
	ENDDO
	IF llSuccess
		TRY
			MKDIR (tcDirectory)                                      && Make the final directory
		CATCH TO loException
			llSuccess = False
		ENDTRY
	ENDIF
ENDIF
RETURN llSuccess
ENDFUNC