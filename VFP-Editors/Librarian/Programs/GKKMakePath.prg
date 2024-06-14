************************************************************************************************
* Written by:  Gregory A. Green
*
* Copyright ©2011-2014 Gregory A. Green
*
* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*
************************************************************************************************
* Function to create the directory location
*
FUNCTION GKKMakePath
LPARAMETERS tcDirectory
LOCAL llSuccess, lcPath, lnLen, lnNdx, loException, lnSlash, lnSlashCnt, lcDirectory
llSuccess   = .T.
lcDirectory = RTRIM(tcDirectory, "\")
TRY
	IF !DIRECTORY(lcDirectory, 1)                                        && Check for directory already existing
		lnSlashCnt = OCCURS("\", lcDirectory)
		IF LEFT(lcDirectory, 2) = "\\"                                   && Check for server/share name passed
			lnSlash = 4
		ELSE
			IF SUBSTR(lcDirectory, 2, 1) = ":"                           && Check for drive letter included
				lnSlash = 2
			ELSE
				llSuccess = .F.
				lnSlash = 0
			ENDIF
		ENDIF

		lcPath = LEFT(lcDirectory, ATC("\", lcDirectory, lnSlash)-1)
		DO WHILE llSuccess .AND. lnSlash <= lnSlashCnt
			TRY
				IF !DIRECTORY(lcPath, 1)
					MKDIR (lcPath)                                       && Create the subdirectories
				ENDIF
	
			CATCH TO loException
				llSuccess = .F.
			ENDTRY
			lnSlash = lnSlash + 1
			lcPath  = LEFT(lcDirectory, ATC("\", lcDirectory, lnSlash)-1)
		ENDDO
		IF llSuccess
			TRY
				MKDIR (lcDirectory)                                      && Make the final directory
			CATCH TO loException
				llSuccess = .F.
			ENDTRY
		ENDIF
	ENDIF

CATCH TO loException
	STRTOFILE("MAKEPATH() "+TRANSFORM(DATETIME())+CRLF, "debug.txt")
	STRTOFILE(lcDirectory+CRLF, "debug.txt", 1)
	STRTOFILE(loException.Message+CRLF, "debug.txt", 1)
	STRTOFILE(loException.Details+CRLF, "debug.txt", 1)
	STRTOFILE(loException.LineContents+CRLF, "debug.txt", 1)
	STRTOFILE(TRANSFORM(loException.LineNo), "debug.txt", 1)
	llSuccess = .F.
ENDTRY
RETURN llSuccess
ENDFUNC