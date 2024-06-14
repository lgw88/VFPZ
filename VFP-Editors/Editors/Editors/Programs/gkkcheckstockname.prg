*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Checks the property/method/event name is stock or not
*-*
FUNCTION GKKCheckStockName
LPARAMETERS tcName
LOCAL llReturn, loException
SET EXACT ON
TRY
	IF SEEK(UPPER(tcName),"gkkmethodlist","name")
		llReturn = .T.
	ELSE
		IF SEEK(UPPER(tcName),"gkkpropertylist","name")
			llReturn = .T.
		ELSE
			llReturn = .F.
		ENDIF
	ENDIF
CATCH TO loException
	llReturn = .F.
ENDTRY
SET EXACT OFF
RETURN llReturn
ENDFUNC