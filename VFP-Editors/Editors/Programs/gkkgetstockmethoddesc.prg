*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Gets the method/event description if stock
*-*
FUNCTION GKKGetStockMethodDesc
LPARAMETERS tcMethName
LOCAL lcMethDesc, loException
SET EXACT ON
TRY
	IF SEEK(UPPER(tcMethName),"gkkmethodlist","name")
		lcMethDesc = ALLTRIM(gkkmethodlist.descriptn)
	ELSE
		lcMethDesc = ""
	ENDIF
CATCH TO loException
	lcMethDesc = ""
ENDTRY
SET EXACT OFF
RETURN lcMethDesc
ENDFUNC