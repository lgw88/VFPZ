*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for Getting the property type code from the description
*-*
FUNCTION GKKGetPropertyType
LPARAMETERS tcDesc
LOCAL lnPos, lcDope, lcPropTy
#INCLUDE GKKDefines.h
lnPos = RATC("***",tcDesc)
IF lnPos > 0
	lcDope = ALLTRIM(SUBSTR(tcDesc,lnPos+3))
	lcDope = UPPER(GETWORDNUM(lcDope,1," "))
	DO CASE
		CASE lcDope == "="
			lcPropTy = UGPT_FUNCTION
		CASE lcDope == "BOOLEAN"
			lcPropTy = UGPT_BOOL
		CASE lcDope == "CENUM"
			lcPropTy = UGPT_CENUM
		CASE lcDope == "COLOR"
			lcPropTy = UGPT_COLOR
		CASE lcDope == "DATE"
			lcPropTy = UGPT_DATE
		CASE lcDope == "DATETIME"
			lcPropTy = UGPT_DATETIME
		CASE lcDope == "EXPR"
			lcPropTy = UGPT_EXPR
		CASE lcDope == "FLOAT"
			lcPropTy = UGPT_FLOAT
		CASE lcDope == "FONTINFO"
			lcPropTy = UGPT_FONTINFO
		CASE lcDope == "FONTNAME"
			lcPropTy = UGPT_FONTNAME
		CASE lcDope == "GRAPHIC"
			lcPropTy = UGPT_GRAPHIC
		CASE lcDope == "INTEGER"
			lcPropTy = UGPT_INTEGER
		CASE lcDope == "NENUM"
			lcPropTy = UGPT_NENUM
		CASE lcDope == "LOV"
			lcPropTy = UGPT_USERLOV
		CASE lcDope == "SPINNER"
			lcPropTy = UGPT_SPINNER
		CASE LEFT(lcDope,1) == "<"
			lcPropTy = UGPT_TEXT
		CASE LEFT(lcDope,7) == "GETFILE"
			lcPropTy = UGPT_GETFILE
		OTHERWISE
			lcPropTy = UGPT_TEXT
	ENDCASE
ELSE
	lcPropTy = UGPT_TEXT
ENDIF
RETURN lcPropTy
ENDFUNC