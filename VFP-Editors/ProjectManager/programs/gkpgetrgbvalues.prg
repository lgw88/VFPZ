************************************************************************************************
* Written by:  Gregory A. Green
************************************************************************************************
*
*  Routine for returning the individual RBG values from a color value
*
FUNCTION GKPGetRGBValues
LPARAMETERS pnRGBValue
LOCAL lcRGBString
lcRGBString = GetRValue(pnRGBValue) + "," + GetBValue(pnRGBValue) + "," + GetGValue(pnRGBValue)
RETURN lcRGBString
ENDFUNC


PROCEDURE GetRValue
	LPARAMETER pnRGBColorValue
	LOCAL lnRValue, lnNdx
	lnRValue = pnRGBColorValue
	FOR lnNdx=8 TO 31
		lnRValue = BITCLEAR(lnRValue,lnNdx)
	ENDFOR
	RETURN TRANSFORM(INT(lnRValue))
ENDPROC


PROCEDURE GetGValue
	LPARAMETER pnRGBColorValue
	LOCAL lnBValue, lnNdx
	lnBValue = BITRSHIFT(pnRGBColorValue,16)
	FOR lnNdx=8 TO 31
		lnBValue = BITCLEAR(lnBValue,lnNdx)
	ENDFOR
	RETURN TRANSFORM(INT(lnBValue))
ENDPROC


PROCEDURE GetBValue
	LPARAMETER pnRGBColorValue
	LOCAL lnGValue, lnNdx
	lnGValue = BITRSHIFT(pnRGBColorValue,8)
	FOR lnNdx=8 TO 31
		lnGValue = BITCLEAR(lnGValue,lnNdx)
	ENDFOR
	RETURN TRANSFORM(INT(lnGValue))
ENDPROC
