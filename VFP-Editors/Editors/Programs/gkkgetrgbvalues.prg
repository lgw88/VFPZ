************************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
************************************************************************************************
*
*  Routine for returning the individual RBG values from a color value
*
FUNCTION GKKGetRGBValues
LPARAMETERS tnRGBValue
LOCAL lcRGBString
lcRGBString = GetRValue(tnRGBValue) + "," + GetBValue(tnRGBValue) + "," + GetGValue(tnRGBValue)
RETURN lcRGBString
ENDFUNC


PROCEDURE GetRValue
	LPARAMETER tnRGBColorValue
	LOCAL lnRValue, lnNdx
	lnRValue = tnRGBColorValue
	FOR lnNdx=8 TO 31
		lnRValue = BITCLEAR(lnRValue,lnNdx)
	ENDFOR
	RETURN TRANSFORM(INT(lnRValue))
ENDPROC


PROCEDURE GetGValue
	LPARAMETER tnRGBColorValue
	LOCAL lnBValue, lnNdx
	lnBValue = BITRSHIFT(tnRGBColorValue,16)
	FOR lnNdx=8 TO 31
		lnBValue = BITCLEAR(lnBValue,lnNdx)
	ENDFOR
	RETURN TRANSFORM(INT(lnBValue))
ENDPROC


PROCEDURE GetBValue
	LPARAMETER tnRGBColorValue
	LOCAL lnGValue, lnNdx
	lnGValue = BITRSHIFT(tnRGBColorValue,8)
	FOR lnNdx=8 TO 31
		lnGValue = BITCLEAR(lnGValue,lnNdx)
	ENDFOR
	RETURN TRANSFORM(INT(lnGValue))
ENDPROC
