*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for Getting the VFP Error message for a given error code
*-*
FUNCTION GKKGetErrorMessage
LPARAMETERS tnErrorCode
LOCAL loException
IF !USED('gkkerrormsg')
	TRY
		USE gkkerrormsg.dbf IN 0 AGAIN ALIAS gkkerrormsg SHARED
	CATCH TO loException
	ENDTRY
ENDIF
IF USED('gkkerrormsg')
	SELECT gkkerrormsg
	LOCATE FOR code = tnErrorCode
	IF FOUND()
		RETURN ALLTRIM(gkkerrormsg.text)
	ELSE
		RETURN "Unknown error: " + TRANSFORM(tnErrorCode)
	ENDIF
ELSE
	RETURN "Unknown error: " + TRANSFORM(tnErrorCode)
ENDIF
ENDFUNC