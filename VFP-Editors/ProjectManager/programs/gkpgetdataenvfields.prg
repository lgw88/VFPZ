*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-*  Routine for returning the table fields for cursors listed in dataenvironment
*-*
FUNCTION GKPGetDataEnvFields
LPARAMETERS tcBasePath
LOCAL lcTable, lnFldCnt, lnFld, loException, lcDBC, lnViewID, lcDBCTable, lcFieldList
LOCAL ARRAY laFields[1,5]
#INCLUDE gkpdefines.h
lcFieldList = ""
IF USED('c_editbuffer')
	SELECT c_editbuffer
	SCAN FOR objtype = OBJTYPE_CURS
		TRY
			lcDBC   = GKPGetPropertyValue("Database",c_editbuffer.properties,True)
			lcTable = GKPGetPropertyValue("CursorSource",c_editbuffer.properties,True)
			IF EMPTY(lcDBC)
				lcTable = GKPGetFileFullPath(lcTable,tcBasePath)
				USE (lcTable) IN 0 AGAIN ALIAS gkpdbffile SHARED
				SELECT gkpdbffile
				lnFldCnt = AFIELDS(laFields)
				USE IN gkpdbffile
				FOR lnFld=1 TO lnFldCnt
					lcFieldList = lcFieldList + "|" + JUSTSTEM(lcTable) + "." + laFields[lnFld,1]
				ENDFOR
			ELSE
				lcDBC = GKPGetFileFullPath(lcDBC,tcBasePath)
				USE (lcDBC) IN 0 AGAIN ALIAS gkpdbffile SHARED
				SELECT gkpdbffile
				LOCATE FOR UPPER(ALLTRIM(objectname))==UPPER(lcTable) .AND. UPPER(objecttype)="VIEW" .AND. !DELETED()
				IF FOUND()
					lnViewID = gkpdbffile.objectid
					SCAN FOR parentid=lnViewID .AND. objecttype="Field" .AND. !DELETED()
						lcFieldList = lcFieldList + "|" + lcTable + "." + ALLTRIM(gkpdbffile.objectname)
					ENDSCAN
					USE IN gkpdbffile
				ELSE
					USE IN gkpdbffile
					OPEN DATABASE (lcDBC) SHARED
					lcDBCTable = lcDBC + "!" + lcTable
					USE (lcDBCTable) IN 0 AGAIN ALIAS gkpdbffile SHARED
					SELECT gkpdbffile
					lnFldCnt = AFIELDS(laFields)
					USE IN gkpdbffile
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