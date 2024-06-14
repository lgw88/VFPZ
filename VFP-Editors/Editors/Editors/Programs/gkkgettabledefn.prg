*-***********************************************************************************************
*-* Modified by:  Gregory A. Green
*-*               980 Windmill Parkway
*-*               Evans, GA  30809
*-*               (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for getting the table definition for version control save; adapted from GENDBC.PRG
*-*
FUNCTION GKKGetTableDefn
LPARAMETERS pcDBCName,pcTableName,poReturn,plGeneric
#DEFINE CRLF  CHR(13)+CHR(10)
LOCAL lcTblDefn, lnNumFlds, lnFld, lcFldDefn, lcIndexDefn, lcAlias, lnTag, lcTagName, lcCollate, lnNdx
LOCAL llBinary, lcFldAlias, lcDBGetProp, lcVerDefn, loException, lcUserMsg, lnTagCnt, lcFORExpr, lcDescend
LOCAL lcFldInfo, lcTblPath, lcTblName, lcTblComment, llDbcOpened
LOCAL ARRAY lcFields[1,18], lcTags[1,6]
lcRtnDefn    = pcTableName
lcTblDefn    = ""
lcTblComment = ""
llDbcOpened  = .F.
lnNumFlds    = 0
TRY
	lcAlias   = JUSTSTEM(pcTableName)
	lcTblDefn = "******Schema Definition - " + JUSTFNAME(pcTableName) + CRLF
	IF plGeneric
		lcTblPath = "<<TablePath>>"
		lcTblName = "<<TableName>>"
	ELSE
		lcTblPath = pcTableName
		lcTblName = JUSTFNAME(pcTableName)
	ENDIF
	lcTblDefn = lcTblDefn + "CREATE TABLE '" + lcTblPath + "' NAME '" + lcTblName + "' ("
	lcVerDefn = "******Table Definition - " + JUSTFNAME(pcTableName) + CRLF
*-*	Open table to save version of
	USE (pcTableName) IN 0 ALIAS gkkmakever SHARED AGAIN
	SELECT gkkmakever

*-*	Get the table field structure
	lnNumFlds = AFIELDS(lcFields)
	lcVerDefn = lcVerDefn + TRANSFORM(lnNumFlds) + CRLF
	FOR lnFld=1 TO lnNumFlds
		lcFldDefn = lcFields[lnFld,1] + " " + lcFields[lnFld,2]
		DO CASE
			CASE INLIST(lcFields[lnFld,2],"C","V")
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(lcFields[lnFld,3]) + ")"
				IF lcFields[lnFld,6]
					lcFldDefn = lcFldDefn + " NOCPTRANS"
				ENDIF
			CASE lcFields[lnFld,2] = "Q"
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(lcFields[lnFld,3]) + ")"
			CASE lcFields[lnFld,2] = "M"
				IF lcFields[lnFld,6]
					lcFldDefn = lcFldDefn + " NOCPTRANS"
				ENDIF
			CASE INLIST(lcFields[lnFld,2],"N","F")
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(lcFields[lnFld,3]) + ", " + TRANSFORM(lcFields[lnFld,4]) + ")"
			CASE lcFields[lnFld,2] = "B"
				lcFldDefn = lcFldDefn + "(" + TRANSFORM(lcFields[lnFld,4]) + ")"
		ENDCASE
		IF lcFields[lnFld,5]
			lcFldDefn = lcFldDefn + " NULL"
		ELSE
			lcFldDefn = lcFldDefn + " NOT NULL"
		ENDIF
		IF lcFields[lnFld,18] != 0
			lcFldDefn = lcFldDefn + " AUTOINC NEXTVALUE " + TRANSFORM(lcFields[lnFld,17]) + " STEP " + TRANSFORM(lcFields[lnFld,18])
		ENDIF
		IF !EMPTY(lcFields[lnFld,7])
			lcFldDefn = lcFldDefn + " CHECK " + lcFields[lnFld,7]
		ENDIF
		IF !EMPTY(lcFields[lnFld,8])
			lcFldDefn = lcFldDefn + " ERROR " + lcFields[lnFld,8]
		ENDIF
		IF !EMPTY(lcFields[lnFld,9])
			lcFldDefn = lcFldDefn + " DEFAULT " + lcFields[lnFld,9]
		ENDIF
		IF lnFld != lnNumFlds
			lcFldDefn = lcFldDefn + ", "
		ELSE
			lcFldDefn = lcFldDefn + ")" + CRLF
		ENDIF
		lcTblDefn = lcTblDefn + lcFldDefn
*-*		Set the field information for version comparison
		FOR lnNdx=1 TO 9
			lcFldInfo = IIF(EMPTY(TRANSFORM(lcFields[lnFld,lnNdx])),SPACE(1),TRANSFORM(lcFields[lnFld,lnNdx]))
			lcVerDefn = lcVerDefn + lcFldInfo + "|"
		ENDFOR
		IF lcFields[lnFld,18] != 0
			lcVerDefn = lcVerDefn + TRANSFORM(lcFields[lnFld,17]) + "|" + TRANSFORM(lcFields[lnFld,18]) + CRLF
		ELSE
			lcVerDefn = lcVerDefn + "0|0" + CRLF
		ENDIF
	ENDFOR

*-* Get table Properties if part of database
	IF ISNULL(pcDBCName)
		lcTblComment = " "
	ELSE
		IF !EMPTY(pcDBCName)
			IF UPPER(DBC()) != UPPER(pcDBCName)
				OPEN DATABASE (pcDBCName) SHARED
				llDbcOpened = .T.
			ENDIF
		ENDIF

		lcVerDefn   = lcVerDefn + "******Table Properties******" + CRLF
		lcDBGetProp = DBGETPROP(lcAlias,"Table","Comment")
		lcVerDefn   = lcVerDefn + "Comment|"
		IF EMPTY(lcDBGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			lcTblComment = " "
		ELSE
			lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
			lcDBGetProp = STRTRAN(lcDBGetProp, CHR(10))
			lcDBGetProp = STRTRAN(lcDBGetProp, CHR(13), '" + CHR(13) + "')
			lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "', 'Table', 'Comment', '" + lcDBGetProp + "')" + CRLF
			lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			lcTblComment = lcDBGetProp
		ENDIF
		lcDBGetProp = DBGETPROP(lcAlias,"Table","DeleteTrigger")
		lcVerDefn   = lcVerDefn + "DeleteTrigger|"
		IF EMPTY(lcDBGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CRLF
		ELSE
			lcTblDefn = lcTblDefn + "CREATE TRIGGER ON '" + lcTblName + "' FOR DELETE AS " + lcDBGetProp + CRLF
			lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
		ENDIF
		lcDBGetProp = DBGETPROP(lcAlias,"Table","InsertTrigger")
		lcVerDefn   = lcVerDefn + "InsertTrigger|"
		IF EMPTY(lcDBGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CRLF
		ELSE
			lcTblDefn = lcTblDefn + "CREATE TRIGGER ON '" + lcTblName + "' FOR INSERT AS " + lcDBGetProp + CRLF
			lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
		ENDIF
		lcDBGetProp = DBGETPROP(lcAlias,"Table","UpdateTrigger")
		lcVerDefn   = lcVerDefn + "UpdateTrigger|"
		IF EMPTY(lcDBGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CRLF
		ELSE
			lcTblDefn = lcTblDefn + "CREATE TRIGGER ON '" + lcTblName + "' FOR UPDATE AS " + lcDBGetProp + CRLF
			lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
		ENDIF
		lcDBGetProp = DBGETPROP(lcAlias,"Table","RuleExpression")
		lcVerDefn   = lcVerDefn + "RuleExpression|"
		IF EMPTY(lcDBGetProp)
			lcVerDefn = lcVerDefn + SPACE(1) + CRLF
		ELSE
			lcVerDefn = lcVerDefn + lcDBGetProp + "|ERROR|"
			lcError = DBGETPROP(lcAlias,"Table","RuleText")
			IF EMPTY(lcError)
				lcTblDefn = lcTblDefn + "ALTER TABLE '" + lcTblName + "' SET CHECK " + lcDBGetProp + CRLF
			ELSE
				lcTblDefn = lcTblDefn + "ALTER TABLE '" + lcTblName + "' SET CHECK " + lcDBGetProp + " ERROR " + lcError + CRLF
				lcVerDefn = lcVerDefn + lcError
			ENDIF
		ENDIF
	ENDIF

*-*	Get the index information for the table
	lcVerDefn = lcVerDefn + "******Index Definitions******" + CRLF
	=ATAGINFO(lcTags)
	lnTagCnt  = TAGCOUNT()
	lcVerDefn = lcVerDefn + TRANSFORM(lnTagCnt) + CRLF
	FOR lnTag=1 TO lnTagCnt
		lcTagName = UPPER(ALLTRIM(TAG(lnTag)))
		lcCollate = IDXCOLLATE(lnTag)
		IF EMPTY(lcTagName)
			EXIT
		ELSE
			lnNdx = ASCAN(lcTags, lcTagName, -1, -1, 1, 15)
			llBinary  = IIF(lnNdx>0, UPPER(lcTags[lnNdx,2])="BINARY", .F.)
			lcFORExpr = IIF(EMPTY(SYS(2021,lnTag))," ",SYS(2021,lnTag))
			lcKeyExpr = IIF(EMPTY(SYS(14,lnTag))," ",SYS(14,lnTag))
			lcVerDefn = lcVerDefn + lcTagName + "|" + lcFORExpr + "|" + lcKeyExpr
			DO CASE
				CASE PRIMARY(lnTag)
					lcVerDefn = lcVerDefn + "|Primary|"
					IF EMPTY(lcFORExpr)
						lcIndexDefn = "ALTER TABLE '" + lcTblName + "' ADD PRIMARY KEY " + lcKeyExpr + " TAG " + lcTagName + " COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "ALTER TABLE '" + lcTblName + "' ADD PRIMARY KEY " + lcKeyExpr + " FOR " + lcFORExpr + " TAG " + lcTagName + " COLLATE '" + lcCollate + "'"
					ENDIF
				CASE CANDIDATE(lnTag)
					lcVerDefn = lcVerDefn + "|Candidate|"
					IF EMPTY(lcFORExpr)
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " CANDIDATE COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " FOR " + lcFORExpr + " CANDIDATE COLLATE '" + lcCollate + "'"
					ENDIF
				CASE UNIQUE(lnTag)
					lcVerDefn = lcVerDefn + "|Unique|"
					IF(EMPTY(lcFORExpr))
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " UNIQUE COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " FOR " + lcFORExpr + " UNIQUE COLLATE '" + lcCollate + "'"
	                ENDIF
				CASE llBinary
					lcVerDefn = lcVerDefn + "|Binary|"
					lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " BINARY"
				OTHERWISE
					lcDescend = IIF(DESCENDING(lnTag), " DESCENDING ", "")
					lcVerDefn = lcVerDefn + "|Normal|"
					IF(EMPTY(lcFORExpr))
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + lcDescend + " COLLATE '" + lcCollate + "'"
					ELSE
						lcIndexDefn = "INDEX ON " + lcKeyExpr + " TAG " + lcTagName + " FOR " + lcFORExpr + lcDescend + " COLLATE '" + lcCollate + "'"
					ENDIF                    
			ENDCASE
			lcVerDefn = lcVerDefn + IIF(DESCENDING(lnTag), "Descending", "Ascending") + "|" + PROPER(lcCollate)
		ENDIF
		lcVerDefn = lcVerDefn + CRLF
		lcTblDefn = lcTblDefn + lcIndexDefn + CRLF
	ENDFOR
	SELECT gkkmakever
	USE

*-* Get Field Properties for table if part of database
	IF !ISNULL(pcDBCName)
		lcVerDefn = lcVerDefn + "******Field Properties******" + CRLF
		FOR lnFld=1 TO lnNumFlds
			lcFldAlias  = lcAlias + "." + lcFields[lnFld,1]
			lcDBGetProp = DBGETPROP(lcFldAlias,"Field","Caption")
			lcVerDefn   = lcVerDefn + lcFields[lnFld,1] + "|Caption|"
			IF EMPTY(lcDBGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			ELSE
				lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + lcFields[lnFld,1] + "', 'Field', 'Caption', '" + lcDBGetProp + "')" + CRLF
				lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			ENDIF
			lcDBGetProp = DBGETPROP(lcFldAlias,"Field","Comment")
			lcVerDefn   = lcVerDefn + lcFields[lnFld,1] + "|Comment|"
			IF EMPTY(lcDBGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			ELSE
				lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
				lcDBGetProp = STRTRAN(lcDBGetProp, CHR(10)) 
				lcDBGetProp = STRTRAN(lcDBGetProp, CHR(13), '" + CHR(13) + "')
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + lcFields[lnFld,1] + "', 'Field', 'Comment', '" + lcDBGetProp + "')" + CRLF
				lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			ENDIF
			lcDBGetProp = DBGETPROP(lcFldAlias,"Field","InputMask")
			lcVerDefn   = lcVerDefn + lcFields[lnFld,1] + "|InputMask|"
			IF EMPTY(lcDBGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			ELSE
				lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + lcFields[lnFld,1] + "', 'Field', 'InputMask', '" + lcDBGetProp + "')" + CRLF
				lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			ENDIF
			lcDBGetProp = DBGETPROP(lcFldAlias,"Field","Format")
			lcVerDefn   = lcVerDefn + lcFields[lnFld,1] + "|Format|"
			IF EMPTY(lcDBGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			ELSE
				lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + lcFields[lnFld,1] + "', 'Field', 'Format', '" + lcDBGetProp + "')" + CRLF
				lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			ENDIF
			lcDBGetProp = DBGETPROP(lcFldAlias,"Field","DisplayClass")
			lcVerDefn   = lcVerDefn + lcFields[lnFld,1] + "|DisplayClass|"
			IF EMPTY(lcDBGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			ELSE
				lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + lcFields[lnFld,1] + "', 'Field', 'DisplayClass', '" + lcDBGetProp + "')" + CRLF
				lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			ENDIF
			lcDBGetProp = DBGETPROP(lcFldAlias,"Field","DisplayClassLibrary")
			lcVerDefn   = lcVerDefn + lcFields[lnFld,1] + "|DisplayClassLibrary|"
			IF EMPTY(lcDBGetProp)
				lcVerDefn = lcVerDefn + SPACE(1) + CRLF
			ELSE
				lcDBGetProp = STRTRAN(lcDBGetProp,'"',"'")
				lcTblDefn = lcTblDefn + "DBSETPROP('" + lcTblName + "." + lcFields[lnFld,1] + "', 'Field', 'DisplayClassLibrary', '" + lcDBGetProp + "')" + CRLF
				lcVerDefn = lcVerDefn + lcDBGetProp + CRLF
			ENDIF
		ENDFOR
	ENDIF
	IF llDbcOpened
		CLOSE DATABASES
	ENDIF
	poReturn.Schema   = lcTblDefn
	poReturn.VersCtrl = lcVerDefn
	lcRtnDefn = pcTableName + "|" + TRANSFORM(lnNumFlds) + "|" + IIF(EMPTY(lcTblComment)," ",lcTblComment)

CATCH TO loException
	lcUserMsg = 'Unable to open selected file to add a version.'
	=GKKWMSGBOX(lcUserMsg,"GKK Project Manager",16,"WARNING")

ENDTRY
RETURN lcRtnDefn
ENDFUNC