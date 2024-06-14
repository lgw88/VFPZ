*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2013 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Gets the next sequential Id for the table
*-*
FUNCTION GetNextUniqueId
LPARAMETERS tcAlias, tlSetLocalId
LOCAL lcNextId, lcCurAlias, loException, lcDeleted
lcCurAlias = ALIAS()
lcDeleted  = SET("Deleted")
SET DELETED OFF
TRY
	SELECT &tcAlias
	SET ORDER TO TAG id
	GOTO BOTTOM
	IF EOF()
		lcNextId = "00001"
	ELSE
		lcNextId = INCSEQ(&tcAlias..id)
	ENDIF
	SET ORDER TO
	IF tlSetLocalId
		lcNextId = "L" + SUBSTR(lcNextId, 2)
	ELSE
		lcNextId = "0" + SUBSTR(lcNextId, 2)
	ENDIF
	IF !EMPTY(lcCurAlias)
		SELECT &lcCurAlias
	ENDIF

CATCH TO loException
	SET STEP ON
ENDTRY
SET DELETED &lcDeleted
RETURN lcNextId
ENDFUNC