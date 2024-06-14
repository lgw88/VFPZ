*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Returns the property value according to type
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKGetPropertyValueFromType
LPARAMETERS tcPropValue, tcPropType, tcBasePath
LOCAL lxPropValue, lnRColor, lnGColor, lnBColor
DO CASE
	CASE tcPropType = UGPT_ANCHOR
		lxPropValue = VAL(tcPropValue)

	CASE tcPropType = UGPT_BOOL
		lxPropValue = IIF(tcPropValue=".T.", True, False)

	CASE tcPropType = UGPT_COLOR
		lnRColor = VAL(ALLTRIM(GETWORDNUM(tcPropValue,1,",")))
		lnGColor = VAL(ALLTRIM(GETWORDNUM(tcPropValue,2,",")))
		lnBColor = VAL(ALLTRIM(GETWORDNUM(tcPropValue,3,",")))
		lxPropValue = RGB(lnRColor,lnGColor,lnBColor)

	CASE tcPropType = UGPT_DATE
		lxPropValue = CTOD(tcPropValue)

	CASE tcPropType = UGPT_DATETIME
		lxPropValue = CTOT(tcPropValue)

	CASE tcPropType = UGPT_EXPR
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_FLOAT
		lxPropValue = VAL(tcPropValue)

	CASE tcPropType = UGPT_FONTINFO
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_FONTNAME
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_FUNCTION
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_GETFILE
		lxPropValue = GKKGetFileFullPath(tcPropValue, tcBasePath)

	CASE tcPropType = UGPT_GRAPHIC
		lxPropValue = GKKGetFileFullPath(tcPropValue, tcBasePath)

	CASE tcPropType = UGPT_INTEGER
		lxPropValue = INT(VAL(tcPropValue))

	CASE tcPropType = UGPT_LOV
		lxPropValue = INT(VAL(tcPropValue))

	CASE tcPropType = UGPT_USERLOV
		lxPropValue = INT(VAL(tcPropValue))

	CASE tcPropType = UGPT_MEMBER
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_NAME
		lxPropValue = tcPropValue

	CASE INLIST(tcPropType,UGPT_NENUM,UGPT_CENUM)
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_NOEDIT
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_SPINNER
		lxPropValue = VAL(tcPropValue)

	CASE tcPropType = UGPT_TEXT
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_ALIAS
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_FILTER
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_ORDER
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_INITALIAS
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_GRIDPROP
		lxPropValue = tcPropValue

	CASE tcPropType = UGPT_CURRCTRL
		lxPropValue = tcPropValue
		
	CASE tcPropType = UGPT_COLUMNORDER
		lxPropValue = tcPropValue
	
	CASE tcPropType = UGPT_TABINDEX
		lxPropValue = INT(VAL(tcPropValue))

	CASE tcPropType = UGPT_CTRLSRC
		lxPropValue = tcPropValue

	OTHERWISE
		DO CASE
			CASE tcPropValue = ".T."
				tcPropValue = True
			CASE tcPropValue = ".F."
				tcPropValue = False
			CASE ISDIGIT(tcPropValue)
				lxPropValue = VAL(tcPropValue)
			OTHERWISE
				lxPropValue = tcPropValue
		ENDCASE

ENDCASE
RETURN lxPropValue
ENDFUNC
