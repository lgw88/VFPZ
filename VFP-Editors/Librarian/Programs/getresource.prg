*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-* Copyright ©2013-2015
*-*
*-***********************************************************************************************
*-*  Routine for getting the resource table
*-*
#IFNDEF GKKLibrarian
#INCLUDE GKKLibrarian.h
#ENDIF
FUNCTION GetResource
LOCAL llNotOpen, lcUserMsg, loException, lcResource, llError
IF USED('gkkuser')
	llNotOpen = False
ELSE
	llError   = False
	llNotOpen = True
	lcResource = _SCREEN.GKKTools.ConfigPath + "gkkuser.dbf"
	DO WHILE llNotOpen
		TRY
			USE (lcResource) IN 0 AGAIN ALIAS gkkuser SHARED
			llNotOpen = False

		CATCH TO loException
			DO CASE
				CASE loException.ErrorNo = 1        && File does not exist
					TRY
						SELECT 0
						CREATE TABLE (lcResource) FREE (TYPE C(12), id C(12), NAME M, readonly L, ckval N(6,0), data M, updated D)
						SELECT gkkuser
						INDEX ON TYPE TAG TYPE
						INDEX ON id   TAG id
						USE
						llNotOpen = True

					CATCH TO loException
						llError = True
						lcUserMsg = 'Unable to create GKK Resource Table.'
						DisplayMsg(lcUserMsg)
					ENDTRY
					
				OTHERWISE
					llError = True
					lcUserMsg = 'Unable to open GKK Resource Table to retrieve settings.'
					DisplayMsg(lcUserMsg)
			ENDCASE
		ENDTRY
		IF llError
			EXIT
		ENDIF
	ENDDO
ENDIF
RETURN !llNotOpen
ENDFUNC