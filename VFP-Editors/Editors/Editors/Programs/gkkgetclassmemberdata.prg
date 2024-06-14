*-************************************************************************************************
*-* Copyright ©2010 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-************************************************************************************************
*-*
*-*  Routine for getting a cursor containing the class memberdata values
*-*
FUNCTION GKKGetClassMemberData
LPARAMETERS tcClassLoc, tcClass, tcProperties, tcBasePath
LOCAL lcMemberData, lcClassLoc, lcVcxClassLoc, lcVcxClass, lcVcxClassProp
lcMemberData = STREXTRACT(tcProperties, "<VFPData>", "</VFPData>", 1, 4)
IF !EMPTY(lcMemberData)
	XMLTOCURSOR(lcMemberData, "gkkmbrdata")
ENDIF
IF USED('gkkmbrdata')
	SELECT c_memberdata
	APPEND FROM DBF('gkkmbrdata')
	USE IN gkkmbrdata
ENDIF
IF !EMPTY(tcClassLoc)
	lcClassLoc = GKKGetFileFullPath(ALLTRIM(tcClassLoc), tcBasePath)
	lcClassLoc = GKKOpenAsTable(lcClassLoc, "gkk_vcx", .NULL.)
	IF USED("gkk_vcx")
		SELECT gkk_vcx
		LOCATE FOR LOWER(ALLTRIM(objname)) == LOWER(ALLTRIM(tcClass)) .AND. reserved1 = "Class"
		IF FOUND()
			lcVcxClassLoc  = ALLTRIM(gkk_vcx.classloc)
			lcVcxClass     = ALLTRIM(gkk_vcx.class)
			lcVcxClassProp = gkk_vcx.properties
			USE IN gkk_vcx
			GKKGetClassMemberData(lcVcxClassLoc, lcVcxClass, lcVcxClassProp, tcBasePath)
		ENDIF
	ENDIF
ENDIF
ENDFUNC