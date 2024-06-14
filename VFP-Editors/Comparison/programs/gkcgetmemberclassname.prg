*-***********************************************************************************************
*-*
*-* Copyright ©2005-2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for Getting the member list for a FoxPro object
*-*
#INCLUDE gkcdefines.h
FUNCTION GKCGetMemberClassName
LPARAMETERS tcClass, tcClassLoc
LOCAL lcAlias, lcClassLoc, lcMbrClass
lcMbrClass = ""
lcAlias    = SYS(2015)
lcClassLoc = GKCOpenAsTable(tcClassLoc, lcAlias, .NULL.)
IF USED(lcAlias)
	SELECT (lcAlias)
	LOCATE FOR UPPER(ALLTRIM(objname)) == UPPER(tcClass) .AND. !DELETED()
	IF FOUND()
		lcMbrClass = GKCGetPropertyValue("MemberClass",&lcAlias..properties,True)
	ENDIF
	USE IN (lcAlias)
ENDIF
RETURN lcMbrClass
ENDFUNC