*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for getting the resource table
*-*
#IFNDEF GKKDEFINES
#INCLUDE gkkdefines.h
#ENDIF
FUNCTION GKKGetResource
LPARAMETERS tcAlias
LOCAL llOpened, loException, lcGKKResource, llError
IF PCOUNT() = 0 .OR. VARTYPE(tcAlias) != "C"
	tcAlias = 'gkkuser'
ENDIF
IF USED(tcAlias)
	llOpened = True
ELSE
	llError  = False
	llOpened = False
	lcGKKResource = GKKGetConfigPath() + tcAlias + ".dbf"
	DO WHILE !llOpened .AND. !llError
		TRY
			USE (lcGKKResource) IN 0 AGAIN ALIAS (tcAlias) SHARED
			llOpened = True

		CATCH TO loException
			DO CASE
				CASE loException.ErrorNo = 1        && File does not exist
					TRY
						SELECT 0
						DO CASE
							CASE LOWER(tcAlias) == 'gkkuser'
								CREATE TABLE (lcGKKResource) FREE (type C(12), id C(12), name M, readonly L, ckval N(6,0), data M, updated D)
								SELECT gkkuser
								INDEX ON type TAG type
								INDEX ON id   TAG id

							CASE LOWER(tcAlias) == 'gkkobjs'
								CREATE TABLE (lcGKKResource) FREE (otype C(12), id C(100), oname C(10), omethods M, oproperties M, oevents M, updated T)
								SELECT gkkobjs
								INDEX ON otype TAG otype
								INDEX ON id    TAG id

						ENDCASE
						USE
						llOpened = True

					CATCH TO loException
						llError = True
						GKKDisplayMsg(loException.Message)
					ENDTRY
					
				OTHERWISE
					llError = True
					GKKDisplayMsg(loException.Message)
			ENDCASE
		ENDTRY
		IF llError
			EXIT
		ENDIF
	ENDDO
ENDIF
RETURN llOpened
ENDFUNC