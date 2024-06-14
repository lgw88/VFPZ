*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2007-2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the resource table
*-*
#INCLUDE gktdefines.h
FUNCTION GKTGetResource
LOCAL llNotOpen, lcUserMsg, loException, lcGKKResource, llError, lcBasePath
IF USED('gkkuser')
	llNotOpen = False
ELSE
	llError   = False
	llNotOpen = True

	lcBasePath = SPACE(255)
	IF SHGetSpecialFolderPath(0, @lcBasePath, CSIDL_APPDATA, 0) = 1
		lcBasePath = ALLTRIM(lcBasePath)
	ELSE
		lcBasePath = JUSTPATH(SYS(2005))
	ENDIF
	lcBasePath = ADDBS(lcBasePath) + "GKK Industries\GKKEditors"
	IF !GKTMakePath(lcBasePath)
		lcBasePath = JUSTPATH(SYS(2005))
	ENDIF
	lcGKKResource = ADDBS(lcBasePath) + "gkkuser.dbf"
	DO WHILE llNotOpen
		TRY
			USE (lcGKKResource) IN 0 AGAIN ALIAS gkkuser SHARED
			llNotOpen = False

		CATCH TO loException
			DO CASE
				CASE loException.ErrorNo = 1        && File does not exist
					TRY
						SELECT 0
						CREATE TABLE (lcGKKResource) FREE (TYPE C(12), id C(12), NAME M, readonly L, ckval N(6,0), data M, updated D)
						SELECT gkkuser
						INDEX ON TYPE TAG TYPE
						INDEX ON id   TAG id
						USE
						llNotOpen = True

					CATCH TO loException
						llError = True
						lcUserMsg = 'Unable to create GKKTools Resource Table.'
						GKTDisplayMsg(lcUserMsg)
					ENDTRY
					
				OTHERWISE
					llError = True
					lcUserMsg = 'Unable to open GKKTools Resource Table to retrieve settings.'
					GKTDisplayMsg(lcUserMsg)
			ENDCASE
		ENDTRY
		IF llError
			EXIT
		ENDIF
	ENDDO
ENDIF
RETURN !llNotOpen
ENDFUNC