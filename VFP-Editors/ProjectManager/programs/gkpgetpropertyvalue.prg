*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for returning the value of a property without the padding characters
*-*
FUNCTION GKPGetPropertyValue
LPARAMETERS tcPropName,tcProperties,tlStripQuotes
#INCLUDE gkpdefines.h
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