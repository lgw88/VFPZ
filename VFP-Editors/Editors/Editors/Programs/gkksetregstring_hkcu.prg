*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for saving a registry value
*-*
FUNCTION GKKSetRegString_HKCU
LPARAMETERS tcSubkey, tcEntry, tcStrValue
#DEFINE HKEY_CURRENT_USER   -2147483647  && (( HKEY ) 0x80000001 )
LOCAL lnRegHandle, lnResult, lnSize, lcDataBuffer, tnType, lcStrBuffer, lnIntValue, lnDecValue
DO CASE                                           && Determine data type to write
	CASE VARTYPE(tcStrValue) = "C"                && User string is of char type
		lcStrBuffer = ALLTRIM(tcStrValue)
	CASE VARTYPE(tcStrValue) = "N"                && User string is numeric
		lnIntValue = INT(tcStrValue)
		lnDecValue = (tcStrValue - lnIntValue) * 10000
		lcStrBuffer = TRANSFORM(lnIntValue) + "." + TRANSFORM(lnDecValue)
	CASE VARTYPE(tcStrValue) = "D"                && User string is date
		lcStrBuffer = DTOC(tcStrValue)
	CASE VARTYPE(tcStrValue) = "T"                && User string is date-time
		lcStrBuffer = TTOC(tcStrValue)
	CASE VARTYPE(tcStrValue) = "L"                && User string is logical
		IF tcStrValue
			lcStrBuffer = ".T."
		ELSE
			lcStrBuffer = ".F."
		ENDIF
	CASE VARTYPE(tcStrValue) = "Y"                && User string is currency
		lcStrBuffer = TRANSFORM(tcStrValue)
	OTHERWISE
		lcStrBuffer = tcStrValue
ENDCASE
lnRegHandle = 0
lnResult    = apiRegOpenKey(HKEY_CURRENT_USER,tcSubKey,@lnRegHandle)
IF lnResult # 0
	lnResult = apiRegCreateKey(HKEY_CURRENT_USER,tcSubKey,@lnRegHandle)
	IF lnResult # 0
		RETURN .NULL.
	ENDIF
ENDIF   
IF !ISNULL(lcStrBuffer)
	lnSize   = LEN(lcStrBuffer)
	lnResult = apiRegSetValueEx(lnRegHandle,tcEntry,0,1,lcStrBuffer,lnSize)
ELSE
	lnResult = apiRegDeleteValue(lnRegHandle,tcEntry)
ENDIF                         
=apiRegCloseKey(lnRegHandle)
IF lnResult # 0
	RETURN .NULL.
ENDIF   
RETURN .T.
ENDFUNC