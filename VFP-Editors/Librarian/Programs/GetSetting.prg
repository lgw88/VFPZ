*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for getting the settings saved to the FoxUser resource file
*-*
FUNCTION GetSetting
LPARAMETERS tcEntry
LOCAL lcReturn, lcAlias, loException
TRY
	lcAlias = ALIAS()
	IF GetSettingsTable()
		SELECT gkksettings
		LOCATE FOR ALLTRIM(entry)==UPPER(tcEntry) .AND. !DELETED()
		IF FOUND()
			lcReturn = ALLTRIM(gkksettings.data)
		ELSE
			lcReturn = ""
		ENDIF
		USE IN gkksettings
		IF !EMPTY(lcAlias) .AND. LOWER(lcAlias) != "gkksettings"
			SELECT (lcAlias)
		ENDIF
	ELSE
		lcReturn = ""
	ENDIF

CATCH TO loException
	lcReturn = ""
	SET STEP ON
ENDTRY
RETURN lcReturn
ENDFUNC