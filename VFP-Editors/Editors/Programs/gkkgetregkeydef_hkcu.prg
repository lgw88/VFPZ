LPARAMETERS tcSubKey, tnIndex, tnType
LOCAL lcSubKey, lcReturn, lnResult, lcDataBuffer
#DEFINE HKEY_CURRENT_USER   -2147483647  && (( HKEY ) 0x80000001 )
#DEFINE MAX_INI_BUFFERSIZE   256
#DEFINE ERROR_SUCCESS          0

tnType      = IIF(TYPE("tnType")="N",tnType,0)
lnRegHandle = 0
lnResult    = apiRegOpenKey(HKEY_CURRENT_USER,tcSubKey,@lnRegHandle)
IF lnResult#ERROR_SUCCESS
	RETURN .null.
ENDIF   
tcSubkey  = SPACE(MAX_INI_BUFFERSIZE)
tcValue   = SPACE(MAX_INI_BUFFERSIZE)
lnSize    = MAX_INI_BUFFERSIZE
lnValSize = MAX_INI_BUFFERSIZE
lnReturn  = apiRegEnumValue(lnRegHandle, tnIndex, @tcSubkey,@lnValSize, 0, @tnType, @tcValue, @lnSize)
=apiRegCloseKey(lnRegHandle)
IF lnResult#ERROR_SUCCESS
	RETURN .null.
ENDIF   
RETURN LEFT(tcValue,ATC(CHR(0),tcValue)-1)