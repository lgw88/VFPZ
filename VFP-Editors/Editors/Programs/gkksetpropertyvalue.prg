*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for saving a property value
*-*
FUNCTION GKKSetPropertyValue
LPARAMETERS tcValue
#DEFINE MAX_MEMBER_DATA_SIZE   8192   && Maximum size of member data
#DEFINE PROP_PADDING_CHAR    CHR(1)   && Padding char used for properties with values > 255 characters
#DEFINE PROP_PADDING_SIZE       517   && Size of the padding area for properties with values > 255 characters
#DEFINE PROP_LEN_SIZE             8   && Size of the length structure for properties with values > 255 characters
#DEFINE CRLF        CHR(13)+CHR(10)
LOCAL lcValue
lcValue = ALLTRIM(tcValue)
IF LEFT(lcValue,1) = "="
	lcValue = "(" + SUBSTR(lcValue,2) + ")"
ENDIF
IF LEN(lcValue) > 255
	IF LEN(lcValue) <= MAX_MEMBER_DATA_SIZE
		lcValue = REPLICATE(PROP_PADDING_CHAR,PROP_PADDING_SIZE) + PADL(LEN(lcValue)+2,PROP_LEN_SIZE," ") + lcValue + CRLF
	ELSE
		lcValue = ""
	ENDIF
ENDIF
RETURN lcValue
ENDFUNC