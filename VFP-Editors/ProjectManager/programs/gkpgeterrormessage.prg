*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for Getting the VFP Error message for a given error code
*-*
FUNCTION GKPGetErrorMessage
LPARAMETERS tnErrorCode
LOCAL loException
IF !USED('gkperrormsg')
	TRY
		USE gkperrormsg.dbf IN 0 AGAIN ALIAS gkperrormsg SHARED
	CATCH TO loException
	ENDTRY
ENDIF
IF USED('gkperrormsg')
	SELECT gkperrormsg
	LOCATE FOR code = tnErrorCode
	IF FOUND()
		RETURN ALLTRIM(gkperrormsg.text)
	ELSE
		RETURN "Unknown error: " + TRANSFORM(tnErrorCode)
	ENDIF
ELSE
	RETURN "Unknown error: " + TRANSFORM(tnErrorCode)
ENDIF
ENDFUNC