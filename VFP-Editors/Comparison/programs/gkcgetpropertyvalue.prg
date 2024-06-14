*-***********************************************************************************************
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for returning the value of a property without the padding characters
*-*
FUNCTION GKCGetPropertyValue
LPARAMETERS tcPropName,tcProperties,tlStripQuotes
#INCLUDE gkcdefines.h
LOCAL lcPropValue
lcPropValue = ""
IF ATC(tcPropName+" = ",tcProperties) > 0
	lcPropValue = STREXTRACT(tcProperties,tcPropName+" = ",CRLF,1,3)
	lcPropValue = ALLTRIM(lcPropValue,1,PROP_PADDING_CHAR," ")
	IF tlStripQuotes
		lcPropValue = ALLTRIM(lcPropValue,1,'"')
	ENDIF
ENDIF
RETURN lcPropValue
ENDFUNC