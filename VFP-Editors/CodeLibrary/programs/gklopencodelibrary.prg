*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the code snippet table
*-*
#IFNDEF GKLDEFINES
#INCLUDE gkldefines.h
#ENDIF
FUNCTION GKLOpenCodeLibrary
LOCAL llNotOpen, loException, lcGKKSnippet, llError, lcBasePath
IF USED('gkksnippet')
	llNotOpen = False
ELSE
	llError    = False
	llNotOpen  = True
	lcBasePath = GKLGetCodeLibraryPath()
	lcGKKSnippet = lcBasePath + "gkksnipcode.dbf"
	DO WHILE llNotOpen
		TRY
			USE (lcGKKSnippet) IN 0 AGAIN ALIAS gkksnipcode SHARED
			llNotOpen = False

		CATCH TO loException
			DO CASE
				CASE loException.ErrorNo = 1        && File does not exist
					TRY
						SELECT 0
						CREATE TABLE (lcGKKSnippet) FREE (nodeid C(10), sniptype I, snipdesc M, snipcode M, sniprtf M, snippdf M, timestamp T)
						SELECT gkksnipcode
						INDEX ON nodeid TAG nodeid
						INDEX ON LEFT(snipdesc,200) TAG snipdesc
						USE
						llNotOpen = True

					CATCH TO loException
						llError = True
						GKLDisplayMsg('Unable to create GKKTools Code Library Tables.')
					ENDTRY
					
				OTHERWISE
					llError = True
					GKLDisplayMsg('Unable to open GKKTools Code Library Tables.')
			ENDCASE
		ENDTRY
		IF llError
			EXIT
		ENDIF
	ENDDO
	IF !llError
		llNotOpen = True
		lcGKKSnippet = lcBasePath + "gkksniptree.dbf"
		DO WHILE llNotOpen
			TRY
				USE (lcGKKSnippet) IN 0 AGAIN ALIAS gkksniptree SHARED
				llNotOpen = False

			CATCH TO loException
				DO CASE
					CASE loException.ErrorNo = 1        && File does not exist
						TRY
							SELECT 0
							CREATE TABLE (lcGKKSnippet) FREE (nodeid C(10), parentid C(10), nodename C(200))
							SELECT gkksniptree
							INDEX ON nodeid   TAG nodeid
							INDEX ON parentid TAG parentid
							INDEX ON nodename TAG nodename
							USE
							llNotOpen = True

						CATCH TO loException
							llError = True
							GKLDisplayMsg('Unable to create GKKTools Code Library Tables.')
						ENDTRY
						
					OTHERWISE
						llError = True
						GKLDisplayMsg('Unable to open GKKTools Code Library Tables.')
				ENDCASE
			ENDTRY
			IF llError
				EXIT
			ENDIF
		ENDDO
		IF llError
			USE IN gkksnipcode
		ENDIF
	ENDIF
ENDIF
RETURN !llNotOpen
ENDFUNC