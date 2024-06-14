*-***********************************************************************************************
*-*  Routine for getting the settings saved to the GKKUser resource file
*-*
FUNCTION GetStringLocal
LPARAMETERS tcSubkey, tcEntry
LOCAL lcReturn, lcAlias
lcAlias = ALIAS()
IF GetResource()
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