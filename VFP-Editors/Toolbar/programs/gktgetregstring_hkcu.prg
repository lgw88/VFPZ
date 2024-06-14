FUNCTION GKTGetRegString_HKCU
LPARAMETERS tcSubkey, tcEntry
#DEFINE HKEY_CURRENT_USER   -2147483647  && (( HKEY ) 0x80000001 )
LOCAL lnRegHandle, lnResult, lnSize, lcDataBuffer, tnType
lnRegHandle = 0
lnResult    = RegOpenKey(HKEY_CURRENT_USER,tcSubKey,@lnRegHandle)
IF lnResult # 0
	RETURN ""
ENDIF   
lcDataBuffer = SPACE(2000)
lnSize       = LEN(lcDataBuffer)
lnType       = 0
lnResult     = RegQueryValueEx(lnRegHandle,tcEntry,0,@lnType,@lcDataBuffer,@lnSize)
=RegCloseKey(lnRegHandle)
IF lnResult # 0
	RETURN ""
ENDIF   
IF lnSize < 2
	RETURN ""
ENDIF
RETURN SUBSTR(lcDataBuffer,1,lnSize-1)
ENDFUNC