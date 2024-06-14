**
PROCEDURE GKCGetDBCDefn
LPARAMETERS tcDbcName, toRtnDBC
LOCAL loReturn, lnNumObjs, lnNdx, llDbcOpened, lcDBC, lcDbcDefn, lcSP, lcTblDefn, lcViewDefn, lcConnDefn
LOCAL llDbcOk, lcViewInfo, lnRI, lcRI, lcVerDefn, lcConnVers
LOCAL laDbcObjs[1], lcDbcProp, lcUserMsg, loException
laDbcObjs[1] = ""
loReturn = CREATEOBJECT("Empty")
ADDPROPERTY(loReturn, "Schema", "")
ADDPROPERTY(loReturn, "VersCtrl", "")
lcDBC = JUSTSTEM(tcDbcName)
IF DBC()=UPPER(tcDbcName)
	llDbcOpened = .F.
	llDbcOk = .T.
ELSE
	TRY
		OPEN Database (tcDbcName)
		llDbcOk = .T.

	CATCH TO loException
		lcUserMsg = 'Unable to open database to determine defintion.'
		GKCWMSGBOX(lcUserMsg, "GKC Project Manager", 16, "WARNING")
		llDbcOk = .F.
	ENDTRY
	llDbcOpened = .T.
ENDIF
IF llDbcOk
	lcDbcDefn = "******Schema Definition - " + JUSTFNAME(tcDbcName) + CHR(13) + CHR(10)
	lcDbcDefn = lcDbcDefn + "CREATE DATABASE '<<DBCName>>'" + CHR(13) + CHR(10)
	lcVerDefn = "******Database Definition - " + JUSTFNAME(tcDbcName) + CHR(13) + CHR(10)
	lcDbcProp = fStripLine(DBGETPROP(lcDBC, 'Database', 'Comment'))
	IF EMPTY(lcDbcProp)
		lcDbcProp = SPACE(1)
	ELSE
		lcDbcDefn = lcDbcDefn + "DBSETPROP('" + lcDBC + "', 'Database', 'Comment', " + '"' + lcDbcProp + '")' + CHR(13) + CHR(10)
	ENDIF
	lcVerDefn = lcVerDefn + "Comment|" + lcDbcProp + CHR(13) + CHR(10)
	lcDbcProp = TRANSFORM(DBGETPROP(lcDBC, 'Database', 'DBCEvents'))
	IF EMPTY(lcDbcProp)
		lcDbcProp = SPACE(1)
	ELSE
		lcDbcDefn = lcDbcDefn + "DBSETPROP('" + lcDBC + "', 'Database', 'DBCEvents'," + lcDbcProp + ")" + CHR(13) + CHR(10)
	ENDIF
	lcVerDefn = lcVerDefn + "DBCEvents|" + lcDbcProp + CHR(13) + CHR(10)
	lcDbcProp = DBGETPROP(lcDBC, 'Database', 'DBCEventFileName')
	IF EMPTY(lcDbcProp)
		lcDbcProp = SPACE(1)
	ELSE
		lcDbcDefn = lcDbcDefn + "DBSETPROP('" + lcDBC + "', 'Database', 'DBCEventFileName', '" + lcDbcProp + "')" + CHR(13) + CHR(10)
	ENDIF
	lcVerDefn = lcVerDefn + "DBCEventFileName|" + lcDbcProp + CHR(13) + CHR(10)
	USE SHARED (tcDbcName) AGAIN ALIAS GKCDBC IN 0
	SELECT gkcdbc
	LOCATE FOR objectname = 'StoredProceduresSource'
	IF FOUND()
		lcSP = fStripLine(ALLTRIM(gkcdbc.code))
		lcDbcDefn = lcDbcDefn + "****StoredProceduresSource|" + lcSP + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "USE '<<DBCName>>' AGAIN IN 0 ALIAS gkcdbc SHARED" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "SELECT gkcdbc" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "LOCATE FOR Objectname = 'StoredProceduresSource'" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "IF FOUND()" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "   REPLACE gkcdbc.code WITH lcSP" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "ENDIF" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + "USE" + CHR(13) + CHR(10)
	ELSE
		lcSP = " "
	ENDIF
	USE
	lcVerDefn = lcVerDefn + "StoredProceduresSource|" + lcSP + CHR(13) + CHR(10)
	lcTblDefn = ""
	lnNumObjs = ADBOBJECTS(laDbcObjs, "Table")
	lcVerDefn = lcVerDefn + "Database Tables|" + TRANSFORM(lnNumObjs) + CHR(13) + CHR(10)
	IF lnNumObjs>0
		ASORT(laDbcObjs)
		FOR lnNdx = 1 TO lnNumObjs
			loReturn.Schema   = ""
			loReturn.VersCtrl = ""
			lcTblInfo = GKCGETTABLEDEFN("", laDbcObjs[lnNdx], loReturn, .F.)
			IF  .NOT. EMPTY(loReturn.Schema) .AND.  .NOT. EMPTY(loReturn.VersCtrl)
				lcDbcDefn = lcDbcDefn + loReturn.Schema + CHR(13) + CHR(10)
				lcTblDefn = lcTblDefn + loReturn.VersCtrl + CHR(13) + CHR(10)
			ENDIF
			lcVerDefn = lcVerDefn  +  lcTblInfo  + CHR(13) + CHR(10)
		ENDFOR
	ENDIF
	lcViewDefn = ""
	lnNumObjs = ADBOBJECTS(laDbcObjs, "View")
	lcVerDefn = lcVerDefn + "Database Views|" + TRANSFORM(lnNumObjs) + CHR(13) + CHR(10)
	IF lnNumObjs>0
		ASORT(laDbcObjs)
		FOR lnNdx = 1 TO lnNumObjs
			loReturn.Schema   = ""
			loReturn.VersCtrl = ""
			lcViewInfo = GKCGETVIEWDEFN("", laDbcObjs[lnNdx], loReturn, .F.)
			IF  .NOT. EMPTY(loReturn.Schema) .AND.  .NOT. EMPTY(loReturn.VersCtrl)
				lcDbcDefn = lcDbcDefn + loReturn.Schema + CHR(13) + CHR(10)
				lcViewDefn = lcViewDefn + loReturn.VersCtrl + CHR(13) + CHR(10)
			ENDIF
			lcVerDefn = lcVerDefn + lcViewInfo + CHR(13) + CHR(10)
		ENDFOR
	ENDIF
	lcConnDefn = ""
	lnNumObjs = ADBOBJECTS(laDbcObjs, "Connection")
	lcVerDefn = lcVerDefn + "Database Connections|" + TRANSFORM(lnNumObjs) + CHR(13) + CHR(10)
	FOR lnNdx = 1 TO lnNumObjs
		loReturn.Schema = ""
		loReturn.VersCtrl = ""
		lcConnVers = GKCGETCONNECTIONDEFN("", laDbcObjs[lnNdx], loReturn, .F.)
		IF  .NOT. EMPTY(loReturn.Schema)
			lcDbcDefn = lcDbcDefn + loReturn.Schema + CHR(13) + CHR(10)
			lcConnDefn = lcConnDefn + loReturn.VersCtrl + CHR(13) + CHR(10)
		ENDIF
		lcVerDefn = lcVerDefn + laDbcObjs[lnNdx] + "|" + lcConnVers + CHR(13) + CHR(10)
	ENDFOR
	lnNumObjs = ADBOBJECTS(laDbcObjs, "Relation")
	IF lnNumObjs>0
		lcDbcDefn = lcDbcDefn + "******Relation Definitions" + CHR(13) + CHR(10)
		lcDbcDefn = lcDbcDefn + fGetRIDefn(tcDbcName)
	ENDIF
	lcVerDefn = lcVerDefn + "Database Relations|" + TRANSFORM(lnNumObjs) + CHR(13) + CHR(10)
	FOR lnNdx = 1 TO lnNumObjs
		lcRI = laDbcObjs[lnNdx, 1]
		FOR lnRI = 2 TO 5
			lcRI = lcRI + "|" + laDbcObjs[lnNdx, lnRI]
		ENDFOR
		lcVerDefn = lcVerDefn + lcRI + CHR(13) + CHR(10)
	ENDFOR
	toRtnDBC.Schema   = lcDbcDefn
	toRtnDBC.VersCtrl = lcVerDefn + CHR(13) + CHR(10) + lcTblDefn + lcViewDefn + CHR(13) + CHR(10) + lcConnDefn + CHR(13) + CHR(10)
	IF llDbcOpened
		CLOSE DATABASES
	ENDIF
ENDIF
ENDPROC


**


FUNCTION fGetRIDefn
LPARAMETERS tcDbcName
LOCAL lcRIDefn, lnParentId, lnStart, lcITag, lcTable, lcRTag, lcVerDefn, lnSize, lnKey
LOCAL ARRAY laTblName[1]
laTblName[1] = ""
TRY
	lcRIDefn  = ""
	lcVerDefn = ""
	USE SHARED (tcDbcName) AGAIN Alias GKCDBC IN 0
	LOCATE FOR objecttype = "Relation" .AND.  .NOT. DELETED()
	IF FOUND()
		lcRIDefn = lcRIDefn + "CLOSE DATABASE" + CHR(13) + CHR(10)
		lcRIDefn = lcRIDefn + "USE '<<DBCName>>' IN 0 ALIAS gkcdbc EXCLUSIVE" + CHR(13) + CHR(10)
		lcRIDefn = lcRIDefn + "SELECT gkcdbc" + CHR(13) + CHR(10)
		DO WHILE FOUND()
			lnParentId = gkcdbc.parentid
			SELECT objectname FROM (tcDbcName) WHERE objectid=lnParentId INTO ARRAY laTblName
			lnStart = 1
			lcITag  = ""
			lcTable = ""
			lcRTag  = ""
			DO WHILE lnStart <= LEN(gkcdbc.property)
				lnSize = ASC(SUBSTR(gkcdbc.property, lnStart, 1)) + (ASC(SUBSTR(gkcdbc.property, lnStart + 1, 1))*256) + (ASC(SUBSTR(gkcdbc.property, lnStart + 2, 1))*(65536^1)) + (ASC(SUBSTR(gkcdbc.property, lnStart + 3, 1))*(16777216^1))
				lnKey = ASC(SUBSTR(gkcdbc.property, lnStart + 6, 1))
				DO CASE
					CASE lnKey = 13
						lcITag = SUBSTR(gkcdbc.property, lnStart + 7, lnSize-8)

					CASE lnKey = 18
						lcTable = SUBSTR(gkcdbc.property, lnStart + 7, lnSize-8)

					CASE lnKey = 19
						lcRTag = SUBSTR(gkcdbc.property, lnStart + 7, lnSize-8)
				ENDCASE
				lnStart = lnStart + lnSize
			ENDDO
			lcRIDefn = lcRIDefn + "LOCATE FOR ObjectType = 'Table' AND ObjectName = '" + ALLTRIM(laTblName(1)) + "'" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "IF FOUND()" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "    lnObjectID = ObjectID" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "    LOCATE FOR ObjectType = 'Relation'  AND '" + lcITag + "' $ property AND '" + lcTable + "' $ property AND '" + lcRTag + "' $ property AND ParentID = lnObjectID" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "    IF FOUND()" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "	      REPLACE RiInfo WITH '" + GKCDBC.RIINFO + "'" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "    ENDIF" + CHR(13) + CHR(10)
			lcRIDefn = lcRIDefn + "ENDIF" + CHR(13) + CHR(10)
			CONTINUE
		ENDDO
		lcRIDefn = lcRIDefn + "USE" + CHR(13) + CHR(10)
	ENDIF
	USE

CATCH TO loException
	lcUserMsg = 'Unable to open selected file to add a version.'
	GKCWMSGBOX(lcUserMsg, "GKC Project Manager", 16, "WARNING")
	lcRIDefn = ""
ENDTRY
RETURN lcRIDefn
ENDFUNC


**

FUNCTION fStripLine
LPARAMETERS tcLine
LOCAL lcLine
lcLine = ALLTRIM(tcLine)
IF EMPTY(lcLine)
	lcLine = SPACE(1)
ELSE
	lcLine = STRTRAN(lcLine, '"', "'")
	lcLine = STRTRAN(lcLine, CHR(10))
	lcLine = STRTRAN(lcLine, CHR(13), "$$CRLF$$")
ENDIF
RETURN lcLine
ENDFUNC