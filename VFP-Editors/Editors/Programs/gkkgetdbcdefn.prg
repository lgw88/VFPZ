*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for getting the database definition for version control save; adapted from GENDBC.PRG
*-*
FUNCTION GKKGetDBCDefn
LPARAMETERS pcDBCName,poRtnDBC
LOCAL loReturn, lnNumObjs, lnNdx, llDBCOpened, lcDBC, lcDbcDefn, lcSP, lcTblDefn, lcViewDefn, lcConnDefn
LOCAL llDBCOk, lcViewInfo, lnRI, lcRI, lcVerDefn, lcConnVers
LOCAL ARRAY lcDbcObjs[1]
#DEFINE CRLF  CHR(13)+CHR(10)
lcDbcObjs[1] = ""
loReturn = CREATEOBJECT("Empty")
ADDPROPERTY(loReturn,"Schema","")
ADDPROPERTY(loReturn,"VersCtrl","")
*-*	Open database for processing
lcDBC = JUSTSTEM(pcDBCName)
IF DBC() = UPPER(pcDBCName)
	llDBCOpened = .F.
	llDBCOk = .T.
ELSE
	TRY
		OPEN DATABASE (pcDBCName)
		llDBCOk = .T.
	CATCH TO loException
		lcUserMsg = 'Unable to open database to determine defintion.'
		=GKKWMSGBOX(lcUserMsg,"GKK Project Manager",16,"WARNING")
		llDBCOk = .F.
	ENDTRY
	llDBCOpened = .T.
ENDIF
IF llDBCOk
	lcDbcDefn = "******Schema Definition - " + JUSTFNAME(pcDBCName) + CRLF
	lcDbcDefn = lcDbcDefn + "CREATE DATABASE '<<DBCName>>'" + CRLF
	lcVerDefn = "******Database Definition - " + JUSTFNAME(pcDBCName) + CRLF
	
*-*	Get database properties
	lcDBCProp = fStripLine(DBGETPROP(lcDBC, 'Database', 'Comment'))
	IF EMPTY(lcDBCProp)
		lcDBCProp = SPACE(1)
	ELSE
		lcDbcDefn = lcDbcDefn + "DBSETPROP('" + lcDBC + "', 'Database', 'Comment', " + '"' + lcDBCProp + '")' + CRLF
	ENDIF
	lcVerDefn = lcVerDefn + "Comment|" + lcDBCProp + CRLF
	lcDBCProp = TRANSFORM(DBGETPROP(lcDBC, 'Database', 'DBCEvents'))
	IF EMPTY(lcDBCProp)
		lcDBCProp = SPACE(1)
	ELSE
		lcDbcDefn = lcDbcDefn + "DBSETPROP('" + lcDBC + "', 'Database', 'DBCEvents'," + lcDBCProp + ")" + CRLF
	ENDIF
	lcVerDefn = lcVerDefn + "DBCEvents|" + lcDBCProp + CRLF
	lcDBCProp = DBGETPROP(lcDBC, 'Database', 'DBCEventFileName')
	IF EMPTY(lcDBCProp)
		lcDBCProp = SPACE(1)
	ELSE
		lcDbcDefn = lcDbcDefn + "DBSETPROP('" + lcDBC + "', 'Database', 'DBCEventFileName', '" + lcDBCProp + "')" + CRLF
	ENDIF
	lcVerDefn = lcVerDefn + "DBCEventFileName|" + lcDBCProp + CRLF
	
*-*	Get the stored procedures
	USE (pcDBCName) AGAIN IN 0 ALIAS gkkdbc SHARED
	SELECT gkkdbc
	LOCATE FOR Objectname = 'StoredProceduresSource'
	IF FOUND()
		lcSP = fStripLine(ALLTRIM(gkkdbc.code))
		lcDbcDefn = lcDbcDefn + "****StoredProceduresSource|" + lcSP + CRLF
		lcDbcDefn = lcDbcDefn + "USE '<<DBCName>>' AGAIN IN 0 ALIAS gkkdbc SHARED" + CRLF
		lcDbcDefn = lcDbcDefn + "SELECT gkkdbc" + CRLF
		lcDbcDefn = lcDbcDefn + "LOCATE FOR Objectname = 'StoredProceduresSource'" + CRLF
		lcDbcDefn = lcDbcDefn + "IF FOUND()" + CRLF
		lcDbcDefn = lcDbcDefn + "   REPLACE gkkdbc.code WITH lcSP" + CRLF
		lcDbcDefn = lcDbcDefn + "ENDIF" + CRLF
		lcDbcDefn = lcDbcDefn + "USE" + CRLF
	ELSE
		lcSP = " "
	ENDIF
	USE
	lcVerDefn = lcVerDefn + "StoredProceduresSource|" + lcSP + CRLF
	
*-*	Get tables contained in database
	lcTblDefn = ""
	lnNumObjs = ADBOBJECTS(lcDbcObjs, "Table")
	lcVerDefn = lcVerDefn + "Database Tables|" + TRANSFORM(lnNumObjs) + CRLF
	IF lnNumObjs > 0
		=ASORT(lcDbcObjs)
		FOR lnNdx=1 TO lnNumObjs
			loReturn.Schema   = ""
			loReturn.VersCtrl = ""
			lcTblInfo = GKKGetTableDefn("",lcDbcObjs[lnNdx],loReturn,.F.)
			IF !EMPTY(loReturn.Schema) .AND. !EMPTY(loReturn.VersCtrl)
				lcDbcDefn = lcDbcDefn + loReturn.Schema + CRLF
				lcTblDefn = lcTblDefn + loReturn.VersCtrl + CRLF
			ENDIF
			lcVerDefn = lcVerDefn + lcTblInfo + CRLF
		ENDFOR
	ENDIF
	
*-*	Get views contained in database
	lcViewDefn = ""
	lnNumObjs  = ADBOBJECTS(lcDbcObjs, "View")
	lcVerDefn  = lcVerDefn + "Database Views|" + TRANSFORM(lnNumObjs) + CRLF
	IF lnNumObjs > 0
		=ASORT(lcDbcObjs)
		FOR lnNdx=1 TO lnNumObjs
			loReturn.Schema   = ""
			loReturn.VersCtrl = ""
			lcViewInfo = GKKGetViewDefn("",lcDbcObjs[lnNdx],loReturn,.F.)
			IF !EMPTY(loReturn.Schema) .AND. !EMPTY(loReturn.VersCtrl)
				lcDbcDefn  = lcDbcDefn  + loReturn.Schema + CRLF
				lcViewDefn = lcViewDefn + loReturn.VersCtrl + CRLF
			ENDIF
			lcVerDefn = lcVerDefn + lcViewInfo + CRLF
		ENDFOR
	ENDIF
	
*-*	Get connections contained in database
	lcConnDefn = ""
	lnNumObjs  = ADBOBJECTS(lcDbcObjs, "Connection")
	lcVerDefn  = lcVerDefn + "Database Connections|" + TRANSFORM(lnNumObjs) + CRLF
	FOR lnNdx=1 TO lnNumObjs
		loReturn.Schema   = ""
		loReturn.VersCtrl = ""
		lcConnVers = GKKGetConnectionDefn("",lcDbcObjs[lnNdx],loReturn,.F.)
		IF !EMPTY(loReturn.Schema)
			lcDbcDefn  = lcDbcDefn  + loReturn.Schema   + CRLF
			lcConnDefn = lcConnDefn + loReturn.VersCtrl + CRLF
		ENDIF
		lcVerDefn = lcVerDefn + lcDbcObjs[lnNdx] + "|" + lcConnVers + CRLF
	ENDFOR
	
*-*	Get relations contained in database
	lnNumObjs = ADBOBJECTS(lcDbcObjs, "Relation")
	IF lnNumObjs > 0
		lcDbcDefn = lcDbcDefn + "******Relation Definitions" + CRLF
		lcDbcDefn = lcDbcDefn + fGetRIDefn(pcDBCName)
	ENDIF
	lcVerDefn = lcVerDefn + "Database Relations|" + TRANSFORM(lnNumObjs) + CRLF
	FOR lnNdx=1 TO lnNumObjs
		lcRI = lcDbcObjs[lnNdx,1]
		FOR lnRI=2 TO 5
			lcRI = lcRI + "|" + lcDbcObjs[lnNdx,lnRI]
		ENDFOR
		lcVerDefn = lcVerDefn + lcRI + CRLF
	ENDFOR
	
*-*	Save the definitions for return
	poRtnDBC.Schema   = lcDbcDefn
	poRtnDBC.VersCtrl = lcVerDefn + CRLF + lcTblDefn + lcViewDefn + CRLF + lcConnDefn + CRLF
	
*-*	Close the database if opened for processing
	IF llDBCOpened
		CLOSE DATABASES
	ENDIF
ENDIF
ENDFUNC



*-***********************************************************************************************
*-*  Routine for getting the relation definition for version control save; adapted from GENDBC.PRG
*-*
FUNCTION fGetRIDefn
LPARAMETERS pcDBCName
LOCAL lcRIDefn, lnParentID, lnStart, lcITag, lcTable, lcRTag, lcVerDefn
LOCAL ARRAY lcTblName[1]
lcTblName[1] = ""
#DEFINE CRLF  CHR(13)+CHR(10)
TRY
	lcRIDefn  = ""
	lcVerDefn = ""
	USE (pcDBCName) AGAIN IN 0 ALIAS gkkdbc SHARED
	LOCATE FOR ObjectType="Relation" .AND. !DELETED()
	IF FOUND()
		lcRIDefn = lcRIDefn + "CLOSE DATABASE" + CRLF
		lcRIDefn = lcRIDefn + "USE '<<DBCName>>' IN 0 ALIAS gkkdbc EXCLUSIVE" + CRLF
		lcRIDefn = lcRIDefn + "SELECT gkkdbc" + CRLF
		DO WHILE FOUND()
			lnParentID = gkkdbc.ParentID
			SELECT ObjectName FROM (pcDBCName) WHERE ObjectID = lnParentID INTO ARRAY lcTblName
			lnStart = 1
			lcITag  = ""
			lcTable = ""
			lcRTag  = ""
			DO WHILE lnStart <= LEN(gkkdbc.property)
				lnSize = ASC(SUBSTR(gkkdbc.property,lnStart,1)) + (ASC(SUBSTR(gkkdbc.property,lnStart+1,1)) * 256) + ;
						(ASC(SUBSTR(gkkdbc.property,lnStart+2,1)) * 256^2) + (ASC(SUBSTR(gkkdbc.property,lnStart+3,1)) * 256^3)
				lnKey = ASC(SUBSTR(gkkdbc.property,lnStart+6,1))
				DO CASE
					CASE lnKey = 13
						lcITag = SUBSTR(gkkdbc.property,lnStart+7,lnSize-8)
					CASE lnKey = 18
						lcTable = SUBSTR(gkkdbc.property,lnStart+7,lnSize-8)
					CASE lnKey = 19
						lcRTag = SUBSTR(gkkdbc.property,lnStart+7,lnSize-8)
				ENDCASE
				lnStart = lnStart + lnSize
			ENDDO
			lcRIDefn = lcRIDefn + "LOCATE FOR ObjectType = 'Table' AND ObjectName = '" + ALLTRIM(lcTblName(1)) + "'" + CRLF
			lcRIDefn = lcRIDefn + "IF FOUND()" + CRLF
			lcRIDefn = lcRIDefn + "    lnObjectID = ObjectID" + CRLF
			lcRIDefn = lcRIDefn + "    LOCATE FOR ObjectType = 'Relation'  AND '" + ;
			                                lcITag  + "' $ property AND '" + ;
			                                lcTable + "' $ property AND '" + ;
			                                lcRTag  + "' $ property AND ParentID = lnObjectID" + CRLF
			lcRIDefn = lcRIDefn + "    IF FOUND()" + CRLF
			lcRIDefn = lcRIDefn + "	      REPLACE RiInfo WITH '" + gkkdbc.RiInfo + "'" + CRLF
			lcRIDefn = lcRIDefn + "    ENDIF" + CRLF
			lcRIDefn = lcRIDefn + "ENDIF" + CRLF
			CONTINUE
		ENDDO
		lcRIDefn = lcRIDefn + "USE" + CRLF
	ENDIF
	USE

CATCH TO loException
	lcUserMsg = 'Unable to open selected file to add a version.'
	=GKKWMSGBOX(lcUserMsg,"GKK Project Manager",16,"WARNING")
	lcRIDefn = ""

ENDTRY
RETURN lcRIDefn
ENDFUNC



*-***********************************************************************************************
*-*  Routine for removing CRLF and double-quotes
*-*
FUNCTION fStripLine
LPARAMETERS pcLine
LOCAL lcLine
lcLine = ALLTRIM(pcLine)
IF EMPTY(lcLine)
	lcLine = SPACE(1)
ELSE
	lcLine = STRTRAN(lcLine,'"',"'")
	lcLine = STRTRAN(lcLine,CHR(10)) 
	lcLine = STRTRAN(lcLine,CHR(13),"$$CRLF$$")
ENDIF
RETURN lcLine
ENDFUNC