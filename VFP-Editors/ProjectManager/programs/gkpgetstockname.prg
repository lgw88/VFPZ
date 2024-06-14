*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2007-2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Gets the stock property/method/event name capitalization
*-*
FUNCTION GKPGetStockName
LPARAMETERS tcName
LOCAL lcName, loException
SET EXACT ON
TRY
	IF SEEK(UPPER(tcName),"gkpmethodlist","name")
		lcName = ALLTRIM(gkpmethodlist.name)
	ELSE
		lcName = ""
	ENDIF
CATCH TO loException
	lcName = ""
ENDTRY
SET EXACT OFF
RETURN lcName
ENDFUNC