*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-*  Routine for returning the table fields for cursors listed in dataenvironment
*-*
FUNCTION GKKGetDataEnvFields
LPARAMETERS tcBasePath
LOCAL lcTable, lnFldCnt, lnFld, loException, lcDBC, lnViewID, lcDBCTable, lcFieldList
LOCAL ARRAY laFields[1,5]
#INCLUDE gkkdefines.h
lcFieldList = ""
IF USED('c_editbuffer')
	SELECT c_editbuffer
	SCAN FOR objtype = OBJTYPE_CURS
		TRY
			lcDBC   = GKKGetPropertyValue("Database",c_editbuffer.properties,True)
			lcTable = GKKGetPropertyValue("CursorSource",c_editbuffer.properties,True)
			IF EMPTY(lcDBC)
				lcTable = GKKGetFileFullPath(lcTable,tcBasePath)
				USE (lcTable) IN 0 AGAIN ALIAS gkkdbffile SHARED
				SELECT gkkdbffile
				lnFldCnt = AFIELDS(laFields)
				USE IN gkkdbffile
				FOR lnFld=1 TO lnFldCnt
					lcFieldList = lcFieldList + "|" + JUSTSTEM(lcTable) + "." + laFields[lnFld,1]
				ENDFOR
			ELSE
				lcDBC = GKKGetFileFullPath(lcDBC,tcBasePath)
				USE (lcDBC) IN 0 AGAIN ALIAS gkkdbffile SHARED
				SELECT gkkdbffile
				LOCATE FOR UPPER(ALLTRIM(objectname))==UPPER(lcTable) .AND. UPPER(objecttype)="VIEW" .AND. !DELETED()
				IF FOUND()
					lnViewID = gkkdbffile.objectid
					SCAN FOR parentid=lnViewID .AND. objecttype="Field" .AND. !DELETED()
						lcFieldList = lcFieldList + "|" + lcTable + "." + ALLTRIM(gkkdbffile.objectname)
					ENDSCAN
					USE IN gkkdbffile
				ELSE
					USE IN gkkdbffile
					OPEN DATABASE (lcDBC) SHARED
					lcDBCTable = lcDBC + "!" + lcTable
					USE (lcDBCTable) IN 0 AGAIN ALIAS gkkdbffile SHARED
					SELECT gkkdbffile
					lnFldCnt = AFIELDS(laFields)
					USE IN gkkdbffile
					CLOSE DATABASES
					FOR lnFld=1 TO lnFldCnt
						lcFieldList = lcFieldList + "|" + lcTable + "." + laFields[lnFld,1]
					ENDFOR
				ENDIF
			ENDIF
		CATCH TO loException
		ENDTRY
		SELECT c_editbuffer
	ENDSCAN
ENDIF
RETURN lcFieldList 
ENDFUNC