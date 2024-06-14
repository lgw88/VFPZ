*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for getting the settings saved to the FoxUser resource file
*-*
FUNCTION GKKGetString_VFP
LPARAMETERS tcSubkey, tcEntry
LOCAL lcReturn, lcAlias
lcAlias = ALIAS()
IF GKKGetResource('gkkuser')
	SELECT gkkuser
	LOCATE FOR type='GKKSETTINGS' .AND. ALLTRIM(id)==UPPER(tcSubkey) .AND. ALLTRIM(name)==UPPER(tcEntry) .AND. !DELETED()
	IF FOUND()
		lcReturn = ALLTRIM(gkkuser.data)
	ELSE
		lcReturn = ""
	ENDIF
	IF !EMPTY(lcAlias)
		SELECT (lcAlias)
	ENDIF
	USE IN gkkuser
ELSE
	lcReturn = ""
ENDIF
RETURN lcReturn
ENDFUNC