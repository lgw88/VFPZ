*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for returning the value of a property without the padding characters
*-*
FUNCTION GKKGetPropertyValue
LPARAMETERS tcPropName, tcProperties, tlStripQuotes
#INCLUDE gkkdefines.h
LOCAL lcPropValue
lcPropValue = ""
IF ATC(tcPropName+" = ", tcProperties) > 0
	lcPropValue = STREXTRACT(tcProperties, tcPropName+" = ", CRLF, 1, 3)
	lcPropValue = ALLTRIM(lcPropValue, 1, PROP_PADDING_CHAR, " ")
	IF tlStripQuotes
		lcPropValue = ALLTRIM(lcPropValue, 1, '"')
	ENDIF
ENDIF
RETURN lcPropValue
ENDFUNC