*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Opens FoxPro keyword table
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKOpenFDKEYWRD
LOCAL lcFileName, llReturn
IF USED('fdkeywrd')
	llReturn = True
	SELECT fdkeywrd
ELSE
	lcFileName = "FDKEYWRD.DBF"
	TRY
		USE (lcFileName) ORDER token ALIAS fdkeywrd IN 0 SHARED
		SELECT fdkeywrd
		llReturn = True

	CATCH TO loException
		lcFileName = SYS(2004) + "FDKEYWRD.DBF"
		TRY
			USE (lcFileName) ORDER token ALIAS fdkeywrd IN 0 SHARED
			SELECT fdkeywrd
			llReturn = True

		CATCH TO loException
			lcFileName = SYS(2004) + "WIZARDS\FDKEYWRD.DBF"
			TRY
				USE (lcFileName) ORDER token ALIAS fdkeywrd IN 0 SHARED
				SELECT fdkeywrd
				llReturn = True

			CATCH TO loException
				llReturn = False
			ENDTRY
		ENDTRY
	ENDTRY
ENDIF
RETURN llReturn
ENDFUNC