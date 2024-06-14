*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2007-2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Opens FoxPro keyword table
*-*
FUNCTION GKLOpenFDKEYWRD
LOCAL lcFileName, llReturn
IF USED('fdkeywrd')
	llReturn = .T.
	SELECT fdkeywrd
ELSE
	lcFileName = "FDKEYWRD.DBF"
	TRY
		USE (lcFileName) ORDER token ALIAS fdkeywrd IN 0 SHARED
		SELECT fdkeywrd
		llReturn = .T.

	CATCH TO loException
		lcFileName = SYS(2004) + "FDKEYWRD.DBF"
		TRY
			USE (lcFileName) ORDER token ALIAS fdkeywrd IN 0 SHARED
			SELECT fdkeywrd
			llReturn = .T.

		CATCH TO loException
			lcFileName = SYS(2004) + "WIZARDS\FDKEYWRD.DBF"
			TRY
				USE (lcFileName) ORDER token ALIAS fdkeywrd IN 0 SHARED
				SELECT fdkeywrd
				llReturn = .T.

			CATCH TO loException
				llReturn = .F.
			ENDTRY
		ENDTRY
	ENDTRY
ENDIF
RETURN llReturn
ENDFUNC