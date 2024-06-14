**
FUNCTION GKCGetTableDefn
LPARAMETERS tcDbcName, tcTableName, toReturn, tlGeneric
LOCAL lcTblDefn, lnNumFlds, lnFld, lcFldDefn, lcIndexDefn, lcAlias, lnTag, lcTagName, lcCollate, lnNdx
LOCAL llBinary, lcFldAlias, lcDbGetProp, lcVerDefn, loException, lcUserMsg, lnTagCnt, lcForExpr, lcDescend
LOCAL lcFldInfo, lcTblPath, lcTblName, lcTblComment, llDbcOpened, lcRtnDefn, lcError, lcKeyExpr
LOCAL ARRAY laFields[1, 18], laTags[1, 6]
lcRtnDefn    = tcTableName
lcTblDefn    = ""
lcTblComment = ""
llDbcOpened  = .F.
lnNumFlds    = 0
TRY
	lcAlias = JUSTSTEM(tcTableName)
	lcTblDefn = "******Schema Definition - " + JUSTFNAME(tcTableName) + CHR(13) + CHR(10)
	IF tlGeneric
		lcTblPath = "<<TablePath>>"
		lcTblName = "<<TableName>>"
	ELSE
		lcTblPath = tcTableName
		lcTblName = JUSTFNAME(tcTableName)
	ENDIF
*-*	Get the table schema
	lcTblDefn = lcTblDefn + "CREATE TABLE '" + lcTblPath + "' Name '" + lcTblName + "' ("
	lcVerDefn = "******Table Definition - " + JUSTFNAME(tcTableName) + CHR(13) + CHR(10)
	USE SHARED (tcTableName) AGAIN ALIAS gkcmakever IN 0
	SELECT gkcmakever
	lnNumFlds = AFIELDS(laFields)
	lcVerDefn = lcVerDefn + TRANSFORM(lnNumFlds) + CHR(13) + CHR(10)
	FOR lnFld = 1 TO lnNumFlds
		lcFldDefn = laFields[lnFld, 1] + " " + laFields[lnFld, 2]
		DO CASE
			CASE INLIST(laFields[lnFld, 2], "C", "V")
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(laFields[lnFld, 3]) + ")"
				IF laFields[lnFld, 6]
					lcFldDefn = lcFldDefn + " NOCPTRANS"
				ENDIF

			CASE laFields[lnFld, 2] = "Q"
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(laFields[lnFld, 3]) + ")"

			CASE laFields[lnFld, 2] = "M"
				IF laFields[lnFld, 6]
					lcFldDefn = lcFldDefn + " NOCPTRANS"
				ENDIF

			CASE INLIST(laFields[lnFld, 2], "N", "F")
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(laFields[lnFld, 3]) + ", " + TRANSFORM(laFields[lnFld, 4]) + ")"

			CASE laFields[lnFld, 2] = "B"
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(laFields[lnFld, 4]) + ")"
		ENDCASE
		IF laFields[lnFld, 5]
			lcFldDefn = lcFldDefn + " NULL"
		ELSE
			lcFldDefn = lcFldDefn + " NOT NULL"
		ENDIF
		IF laFields[lnFld, 18] != 0
			lcFldDefn = lcFldDefn + " AUTOINC NEXTVALUE " + TRANSFORM(laFields[lnFld, 17]) + " STEP " + TRANSFORM(laFields[lnFld, 18])
		ENDIF
		IF  !EMPTY(laFields[lnFld, 7])
			lcFldDefn = lcFldDefn + " CHECK " + laFields[lnFld, 7]
		ENDIF
		IF  !EMPTY(laFields[lnFld, 8])
			lcFldDefn = lcFldDefn + " ERROR " + laFields[lnFld, 8]
		ENDIF
		IF  !EMPTY(laFields[lnFld, 9])
			lcFldDefn = lcFldDefn + " DEFAULT " + laFields[lnFld, 9]
		ENDIF
		IF lnFld != lnNumFlds
			lcFldDefn = lcFldDefn + ", "
		ELSE
			lcFldDefn = lcFldDefn + ")" + CHR(13) + CHR(10)
		ENDIF
		lcTblDefn = lcTblDefn + lcFldDefn
		FOR lnNdx = 1 TO 9
			lcFldInfo = IIF(EMPTY(TRANSFORM(laFields[lnFld, lnNdx])), SPACE(1), TRANSFORM(laFields[lnFld, lnNdx]))
			lcVerDefn = lcVerDefn + lcFldInfo + "|"
		ENDFOR
		IF laFields[lnFld, 18] != 0
			lcVerDefn = lcVerDefn + TRANSFORM(laFields[lnFld, 17]) + "|" + TRANSFORM(laFields[lnFld, 18]) + CHR(13) + CHR(10)
		ELSE
			lcVerDefn = lcVerDefn + "0|0" + CHR(13) + CHR(10)
		ENDIF
	ENDFOR
	IF ISNULL(tcDbcName)
		lcTblComment = " "
	ELSE
		IF  !EMPTY(tcDbcName)
			IF UPPER(DBC()) != UPPER(tcDbcName)
				OPEN DATABASE (tcDbcName) SHARED
				llDbcOpened = .T.
			ENDIF
		ENDIF
		lcVerDefn = lcVerDefn + "******Table Properties******" + CHR(13) + CHR(10)
		lcDbGetProp = DBGETPROP(lcAlias, "Table", "Comment")
		lcVerDefn = lcVerDefn + "Comment|"
		IF EMPTY(lcDbGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			lcTblComment = " "
		ELSE
			lcDbGetProp  = STRTRAN(lcDbGetProp, '"', "'")
			lcDbGetProp  = STRTRAN(lcDbGetProp, CHR(10))
			lcDbGetProp  = STRTRAN(lcDbGetProp, CHR(13), '"  +  CHR(13)  +  "')
			lcTblDefn    = lcTblDefn + "DBSETPROP('" + lcTblName + "', 'Table', 'Comment', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
			lcVerDefn    = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			lcTblComment = lcDbGetProp
		ENDIF
		lcDbGetProp = DBGETPROP(lcAlias, "Table", "DeleteTrigger")
		lcVerDefn   = lcVerDefn + "DeleteTrigger|"
		IF EMPTY(lcDbGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
		ELSE
			lcTblDefn = lcTblDefn + "CREATE TRIGGER ON '" + lcTblName + "' FOR Delete AS " + lcDbGetProp + CHR(13) + CHR(10)
			lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
		ENDIF
		lcDbGetProp = DBGETPROP(lcAlias, "Table", "InsertTrigger")
		lcVerDefn   = lcVerDefn + "InsertTrigger|"
		IF EMPTY(lcDbGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
		ELSE
			lcTblDefn = lcTblDefn + "CREATE TRIGGER ON '" + lcTblName + "' FOR INSERT AS " + lcDbGetProp + CHR(13) + CHR(10)
			lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
		ENDIF
		lcDbGetProp = DBGETPROP(lcAlias, "Table", "UpdateTrigger")
		lcVerDefn = lcVerDefn + "UpdateTrigger|"
		IF EMPTY(lcDbGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
		ELSE
			lcTblDefn = lcTblDefn + "CREATE TRIGGER ON '" + lcTblName + "' FOR UPDATE AS " + lcDbGetProp + CHR(13) + CHR(10)
			lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
		ENDIF
		lcDbGetProp = DBGETPROP(lcAlias, "Table", "RuleExpression")
		lcVerDefn = lcVerDefn + "RuleExpression|"
		IF EMPTY(lcDbGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
		ELSE
			lcVerDefn = lcVerDefn + lcDbGetProp + "|ERROR|"
			lcError   = DBGETPROP(lcAlias, "Table", "RuleText")
			IF EMPTY(lcError)
				lcTblDefn = lcTblDefn + "ALTER TABLE '" + lcTblName + "' SET CHECK " + lcDbGetProp + CHR(13) + CHR(10)
			ELSE
				lcTblDefn = lcTblDefn + "ALTER TABLE '" + lcTblName + "' SET CHECK " + lcDbGetProp + " Error " + lcError + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcError
			ENDIF
		ENDIF
	ENDIF
*-*	Get the table index information
	lcVerDefn = lcVerDefn + "******Index Definitions******" + CHR(13) + CHR(10)
	ATAGINFO(laTags)
	lnTagCnt = TAGCOUNT()
	lcVerDefn = lcVerDefn + TRANSFORM(lnTagCnt) + CHR(13) + CHR(10)
	FOR lnTag = 1 TO lnTagCnt
		lcTagName = UPPER(ALLTRIM(Tag(lnTag)))
		lcCollate = IDXCOLLATE(lnTag)
		IF EMPTY(lcTagName)
			EXIT
		ELSE
			lnNdx     = ASCAN(laTags, lcTagName, -1, -1, 1, 15)
			llBinary  = IIF(lnNdx>0, UPPER(laTags(lnNdx, 2))="BINARY", .F.)
			lcForExpr = IIF(EMPTY(SYS(2021, lnTag)), " ", SYS(2021, lnTag))
			lcKeyExpr = IIF(EMPTY(SYS(14, lnTag)), " ", SYS(14, lnTag))
			lcVerDefn = lcVerDefn + lcTagName + "|" + lcForExpr + "|" + lcKeyExpr
			DO CASE
				CASE PRIMARY(lnTag)
					lcVerDefn = lcVerDefn + "|Primary|"
					IF EMPTY(lcForExpr)
						lcIndexDefn = "ALTER TABLE '" + lcTblName + "' ADD PRIMARY KEY " + lcKeyExpr + " Tag " + lcTagName + " COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "ALTER TABLE '" + lcTblName + "' ADD PRIMARY KEY " + lcKeyExpr + " FOR " + lcForExpr + " Tag " + lcTagName + " COLLATE '" + lcCollate + "'"
					ENDIF

				CASE CANDIDATE(lnTag)
					lcVerDefn = lcVerDefn + "|Candidate|"
					IF EMPTY(lcForExpr)
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " CANDIDATE COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " FOR " + lcForExpr + " CANDIDATE COLLATE '" + lcCollate + "'"
					ENDIF

				CASE UNIQUE(lnTag)
					lcVerDefn = lcVerDefn + "|Unique|"
					IF (EMPTY(lcForExpr))
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " UNIQUE COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " FOR " + lcForExpr + " UNIQUE COLLATE '" + lcCollate + "'"
					ENDIF

				CASE llBinary
					lcVerDefn = lcVerDefn + "|Binary|"
					lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " BINARY"

				OTHERWISE
					lcDescend = IIF(DESCENDING(lnTag), " DESCENDING ", "")
					lcVerDefn = lcVerDefn + "|Normal|"
					IF (EMPTY(lcForExpr))
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + lcDescend + " COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " FOR " + lcForExpr + lcDescend + " COLLATE '" + lcCollate + "'"
					ENDIF
			ENDCASE
			lcVerDefn = lcVerDefn + IIF(DESCENDING(lnTag), "Descending", "Ascending") + "|" + PROPER(lcCollate)
		ENDIF
		lcVerDefn = lcVerDefn + CHR(13) + CHR(10)
		lcTblDefn = lcTblDefn + lcIndexDefn + CHR(13) + CHR(10)
	ENDFOR
	USE IN gkcmakever
*-*	Get the field properties if table part of database	
	IF  !ISNULL(tcDbcName)
		lcVerDefn = lcVerDefn + "******Field Properties******" + CHR(13) + CHR(10)
		FOR lnFld = 1 TO lnNumFlds
			lcFldAlias = lcAlias + "." + laFields[lnFld, 1]
			lcDbGetProp = DBGETPROP(lcFldAlias, "Field", "Caption")
			lcVerDefn = lcVerDefn + laFields[lnFld, 1] + "|Caption|"
			IF EMPTY(lcDbGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			ELSE
				lcDbGetProp = STRTRAN(lcDbGetProp, '"', "'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + laFields[lnFld, 1] + "', 'Field', 'Caption', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			ENDIF
			lcDbGetProp = DBGETPROP(lcFldAlias, "Field", "Comment")
			lcVerDefn = lcVerDefn + laFields[lnFld, 1] + "|Comment|"
			IF EMPTY(lcDbGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			ELSE
				lcDbGetProp = STRTRAN(lcDbGetProp, '"', "'")
				lcDbGetProp = STRTRAN(lcDbGetProp, CHR(10))
				lcDbGetProp = STRTRAN(lcDbGetProp, CHR(13), '"  +  CHR(13)  +  "')
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + laFields[lnFld, 1] + "', 'Field', 'Comment', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			ENDIF
			lcDbGetProp = DBGETPROP(lcFldAlias, "Field", "InputMask")
			lcVerDefn = lcVerDefn + laFields[lnFld, 1] + "|InputMask|"
			IF EMPTY(lcDbGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			ELSE
				lcDbGetProp = STRTRAN(lcDbGetProp, '"', "'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + laFields[lnFld, 1] + "', 'Field', 'InputMask', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			ENDIF
			lcDbGetProp = DBGETPROP(lcFldAlias, "Field", "Format")
			lcVerDefn = lcVerDefn + laFields[lnFld, 1] + "|Format|"
			IF EMPTY(lcDbGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			ELSE
				lcDbGetProp = STRTRAN(lcDbGetProp, '"', "'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + laFields[lnFld, 1] + "', 'Field', 'Format', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			ENDIF
			lcDbGetProp = DBGETPROP(lcFldAlias, "Field", "DisplayClass")
			lcVerDefn = lcVerDefn + laFields[lnFld, 1] + "|DisplayClass|"
			IF EMPTY(lcDbGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			ELSE
				lcDbGetProp = STRTRAN(lcDbGetProp, '"', "'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + laFields[lnFld, 1] + "', 'Field', 'DisplayClass', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			ENDIF
			lcDbGetProp = DBGETPROP(lcFldAlias, "Field", "DisplayClassLibrary")
			lcVerDefn = lcVerDefn + laFields[lnFld, 1] + "|DisplayClassLibrary|"
			IF EMPTY(lcDbGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CHR(13) + CHR(10)
			ELSE
				lcDbGetProp = STRTRAN(lcDbGetProp, '"', "'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + laFields[lnFld, 1] + "', 'Field', 'DisplayClassLibrary', '" + lcDbGetProp + "')" + CHR(13) + CHR(10)
				lcVerDefn = lcVerDefn + lcDbGetProp + CHR(13) + CHR(10)
			ENDIF
		ENDFOR
	ENDIF
	IF llDbcOpened
		CLOSE DATABASES
	ENDIF
	toReturn.Schema   = lcTblDefn
	toReturn.VersCtrl = lcVerDefn
	lcRtnDefn = tcTableName + "|" + TRANSFORM(lnNumFlds) + "|" + IIF(EMPTY(lcTblComment), " ", lcTblComment)

CATCH TO loException
	lcUserMsg = 'Unable to open selected file to add a version.'
	GKCWMSGBOX(lcUserMsg, "GKC Project Manager", 16, "WARNING")
ENDTRY
RETURN lcRtnDefn
ENDFUNC
**