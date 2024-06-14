FUNCTION GKPGetRegString_HKCU
LPARAMETERS tcSubkey, tcEntry
#DEFINE HKEY_CURRENT_USER   -2147483647  && (( HKEY ) 0x80000001 )
LOCAL lnRegHandle, lnResult, lnSize, lcDataBuffer, tnType
lnRegHandle = 0
lnResult    = apiRegOpenKey(HKEY_CURRENT_USER, tcSubKey, @lnRegHandle)
IF lnResult # 0
	RETURN ""
ENDIF   
lcDataBuffer = SPACE(2000)
lnSize       = LEN(lcDataBuffer)
lnType       = 0
lnResult     = apiRegQueryValueEx(lnRegHandle, tcEntry, 0, @lnType, @lcDataBuffer, @lnSize)
=apiRegCloseKey(lnRegHandle)
IF lnResult # 0
	RETURN ""
ENDIF   
IF lnSize < 2
	RETURN ""
ENDIF
RETURN SUBSTR(lcDataBuffer, 1, lnSize-1)
ENDFUNC