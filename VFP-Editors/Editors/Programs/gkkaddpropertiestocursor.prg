*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Adds the properties to the property cursor for the current object
*-*
#IFNDEF GKKDEFINES
#INCLUDE GKKDefines.h
#ENDIF
FUNCTION GKKAddPropertiesToCursor
LPARAMETERS tcWBS, tcClassName, tcProperties
LOCAL lnNumProp, lnProp, lcPropName, lcPropValue, lcClassName, llQuotes, lcUserMsg, lcRtnName, llInherit, llReturn, lcPropType, llPropList
LOCAL ARRAY laProperties[1]
SELECT c_property
LOCATE FOR ALLTRIM(wbs) == tcWBS
IF FOUND()
	llReturn = False
ELSE
	llReturn  = True
	lnNumProp = ALINES(laProperties,tcProperties,True)
	FOR lnProp=1 TO lnNumProp
		lcPropName = UPPER(ALLTRIM(GETWORDNUM(laProperties[lnProp],1,"=")))
		IF EMPTY(lcPropName)
			LOOP
		ENDIF
		IF LEFT(lcPropName,1) = "~"
			llInherit = True
			lcPropName = SUBSTR(lcPropName,2)
		ELSE
			llInherit = False
		ENDIF
		IF !INLIST(lcPropName, "MACDESKTOP", "SIZEBOX", "ZOOMBOX", "FONTCONDENSE", "FONTEXTEND")
			lcRtnName = GKKGetStockName(lcPropName)
			IF EMPTY(lcRtnName)
				lcPropName = PROPER(lcPropName)
			ELSE
				lcPropName = lcRtnName
			ENDIF
			SELECT gkkpropertylist
			LOCATE FOR UPPER(ALLTRIM(pname)) == UPPER(lcPropName)
			IF FOUND()
				llPropList = True
				lcPropType = gkkpropertylist.vartype
			ELSE
				llPropList = False
				lcPropType = ""
			ENDIF
			lcPropValue = SUBSTR(laProperties[lnProp], ATC("=", laProperties[lnProp])+1)
			lcPropValue = ALLTRIM(lcPropValue, 1, PROP_PADDING_CHAR, " ")
			IF LEFT(lcPropValue, 1) = '"'
				lcPropValue = SUBSTR(lcPropValue, 2)
				IF RIGHT(lcPropValue, 1) = '"'
					lcPropValue = LEFT(lcPropValue, LEN(lcPropValue)-1)
				ENDIF
				llQuotes = True
			ELSE
				IF llPropList
					llQuotes = gkkpropertylist.quotes
				ELSE
					llQuotes = False
				ENDIF
			ENDIF
			IF LEFT(lcPropValue, 1) = '(' .AND. RIGHT(lcPropValue, 1) = ')'
				lcPropValue = "=" + SUBSTR(lcPropValue, 2, LEN(lcPropValue)-2)
			ENDIF
			SELECT gkkfoxcode
			LOCATE FOR type="E" .AND. UPPER(ALLTRIM(abbrev)) == UPPER(lcPropName) .AND. !DELETED()
			IF FOUND()
				lnFavorites = IIF(ATC('favorites="True"', gkkfoxcode.tip)>0, UG_GBL_FAVORITE, UG_NOT_FAVORITE)
			ELSE
				lnFavorites = UG_NOT_FAVORITE
			ENDIF
			INSERT INTO c_property (classname, wbs, pname, pdisplay, pvalue, parray, favorites, override, access, assign, pcustom, memberdata, quotes, inherit, proptype);
				VALUES (tcClassName, tcWBS, LOWER(lcPropName), lcPropName, lcPropValue, False, lnFavorites, False, False, False, False, False, llQuotes, llInherit, lcPropType)
		ENDIF
	ENDFOR
ENDIF
RETURN llReturn
ENDFUNC