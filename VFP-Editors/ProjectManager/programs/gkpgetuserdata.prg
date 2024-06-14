*-***********************************************************************************************
*-* Modified by:  Gregory A. Green
*-*               980 Windmill Parkway
*-*               Evans, GA  30809
*-*               (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for extracting a user setting
*-*
FUNCTION GKPGetUserData
LPARAMETERS pcUserData,pcMemo
LOCAL lnLine, lcLineText, lcValue
LOCAL ARRAY lcSettings[1]
lcValue = ""
=ALINES(lcSettings,pcMemo,.T.)
FOR lnLine=1 TO ALEN(lcSettings,1)
	lcLineText = GETWORDNUM(lcSettings[lnLine],1,"=")
	IF lcLineText = pcUserData
		lcValue = GETWORDNUM(lcSettings[lnLine],2,"=")
		EXIT
	ENDIF
ENDFOR
RETURN ALLTRIM(lcValue)