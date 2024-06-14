*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2013
*-*
*-***********************************************************************************************
*-*  Routine for getting the settings table
*-*
#IFNDEF gkkmembership
#INCLUDE ..\..\common\includes\gkkdefines.h
#ENDIF
FUNCTION GetSettingsTable
LOCAL llOpened, loException, lcResource, llError
IF USED('gkksettings')
	llOpened = True
ELSE
	llError    = False
	llOpened   = False
	lcResource = ADDBS(_SCREEN.GKKTools.DataPath) + "gkksettings.dbf"
	DO WHILE !llOpened
		TRY
			USE (lcResource) IN 0 AGAIN ALIAS gkksettings SHARED
			llOpened = True

		CATCH TO loException
			DO CASE
				CASE loException.ErrorNo = 1        && File does not exist
					TRY
						SELECT 0
						CREATE TABLE (lcResource) FREE (entry C(100), data M, updated D)
						SELECT gkksettings
						INDEX ON entry TAG entry
						USE IN gkksettings
						llOpened = False

					CATCH TO loException
						llError = True
						DisplayMsg('Unable to create GKK Settings Table.')
					ENDTRY
					
				OTHERWISE
					llError = True
					DisplayMsg('Unable to open GKK Settings Table.')
			ENDCASE
		ENDTRY
		IF llError
			EXIT
		ENDIF
	ENDDO
ENDIF
RETURN llOpened
ENDFUNC