*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for getting the settings saved to the FoxUser resource file
*-*
FUNCTION GKPGetString_VFP
LPARAMETERS tcSubkey, tcEntry
LOCAL lcReturn, lcAlias
lcAlias = ALIAS()
IF GKPGetResource()
	SELECT gkkuser
	LOCATE FOR type='GKKSETTINGS' .AND. ALLTRIM(id)==UPPER(tcSubkey) .AND. ALLTRIM(name)==UPPER(tcEntry) .AND. !DELETED()
	IF FOUND()
		lcReturn = ALLTRIM(gkkuser.data)
	ELSE
		lcReturn = ""
	ENDIF
	USE IN gkkuser
	IF !EMPTY(lcAlias)
		SELECT (lcAlias)
	ENDIF
ELSE
	lcReturn = ""
ENDIF
RETURN lcReturn
ENDFUNC