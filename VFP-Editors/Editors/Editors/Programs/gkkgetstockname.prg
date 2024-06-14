*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Gets the stock property/method/event name capitalization
*-*
FUNCTION GKKGetStockName
LPARAMETERS tcName
LOCAL lcName, loException
SET EXACT ON
TRY
	DO CASE
		CASE SEEK(UPPER(tcName),"gkkmethodlist","name")
			lcName = ALLTRIM(gkkmethodlist.name)

		CASE SEEK(UPPER(tcName),"gkkpropertylist","name")
			lcName = ALLTRIM(gkkpropertylist.pname)

		OTHERWISE
			lcName = ""
	ENDCASE
CATCH TO loException
	lcName = ""
ENDTRY
SET EXACT OFF
RETURN lcName
ENDFUNC