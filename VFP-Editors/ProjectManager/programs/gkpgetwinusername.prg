*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Returns the current Windows logon user name
*-*
FUNCTION GKPGetWinUserName
LOCAL lnSize, lcBuffer
lnSize = 25
lcBuffer = REPLICATE(CHR(0), lnSize)
IF apiGetUserName(@lcBuffer, @lnSize) > 0
	lcBuffer = STRTRAN(ALLTRIM(SUBSTR(lcBuffer, 1, lnSize)), CHR(0), "")
ELSE
	lcBuffer = ""
ENDIF
RETURN ALLTRIM(lcBuffer)
ENDFUNC