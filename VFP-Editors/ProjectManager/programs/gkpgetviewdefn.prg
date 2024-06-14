*-***********************************************************************************************
*-* Modified by:  Gregory A. Green
*-*               980 Windmill Parkway
*-*               Evans, GA  30809
*-*               (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for getting the view definition for version control save; adapted from GENDBC.PRG
*-*
FUNCTION GKPGetViewDefn
LPARAMETERS pcDBCName,pcViewName,poReturn,plGeneric
LOCAL lnSourceType, lcConnectName, lcSQL, lcUpdateType, lcWhereType, lcFetchMemo, lcShareConnection, lcSendUpdates
LOCAL lcUseMemoSize, lcFetchSize, lcMaxRecords, lcTables, lcPrepared, lcCompareMemo, lcFetchAsNeeded, lcParams
LOCAL llOffline, lcAllowSimulFetch, lcRuleExpr, lcRuleText, lcComment, lcBatchUpdateCount, lcViewSchema
LOCAL lcDBSetProp, loException, lcUserMsg, llOffline, lcBatchUpdCount, lnObjectId, lcFldDefn, lnFld
LOCAL lcFieldAlias, lcKeyField, lcUpdatable, lcUpdateName, lcDelimiter, lcProperty, lcViewName, llDbcOpened
LOCAL lcRtnDefn, lcDBCName, lcViewType
LOCAL ARRAY lcViewFlds[1]
#DEFINE CRLF  CHR(13)+CHR(10)
lcRtnDefn = pcViewName
TRY
	llDbcOpened = .F.
	IF !EMPTY(pcDBCName)
		IF UPPER(DBC()) != UPPER(pcDBCName)
			OPEN DATABASE (pcDBCName) SHARED
			llDbcOpened = .T.
		ENDIF
	ENDIF

	lnSourceType      = DBGETPROP(pcViewName, 'View', 'SourceType')
	llOffline         = DBGETPROP(pcViewName, 'View', 'Offline')
	lcComment         = fStripLine(DBGETPROP(pcViewName, 'View', 'Comment'))
	lcRuleText        = fStripLine(DBGETPROP(pcViewName, "View", "RuleText"))
	lcRuleExpr        = fStripLine(DBGETPROP(pcViewName, "View", "RuleExpression"))
	lcSQL             = fStripLine(ALLTRIM(DBGETPROP(pcViewName, 'View', 'SQL')))
	lcConnectName     = fStripLine(ALLTRIM(DBGETPROP(pcViewName, 'View', 'ConnectName')))
	lcTables          = fStripLine(ALLTRIM(DBGETPROP(pcViewName, 'View', 'Tables')))
	lcParams          = fStripLine(ALLTRIM(DBGETPROP(pcViewName, 'View', 'ParameterList')))
	lcUpdateType      = TRANSFORM(DBGETPROP(pcViewName, 'View', 'UpdateType'))
	lcWhereType       = TRANSFORM(DBGETPROP(pcViewName, 'View', 'WhereType'))
	lcFetchMemo       = TRANSFORM(DBGETPROP(pcViewName, 'View', 'Fetchmemo'))
	lcShareConnection = TRANSFORM(DBGETPROP(pcViewName, 'View', 'ShareConnection'))
	lcSendUpdates     = TRANSFORM(DBGETPROP(pcViewName, 'View', 'SendUpdates'))
	lcUseMemoSize     = TRANSFORM(DBGETPROP(pcViewName, 'View', 'UseMemoSize'))
	lcFetchSize       = TRANSFORM(DBGETPROP(pcViewName, 'View', 'FetchSize'))
	lcMaxRecords      = TRANSFORM(DBGETPROP(pcViewName, 'View', 'MaxRecords'))
	lcBatchUpdCount   = TRANSFORM(DBGETPROP(pcViewName, 'View', 'BatchUpdateCount'))
	lcAllowSimulFetch = IIF(EMPTY(DBGETPROP(pcViewName, 'View', 'AllowSimultaneousFetch')), '.T.', '.F.')
	lcPrepared        = IIF(EMPTY(DBGETPROP(pcViewName, 'View', 'Prepared')), '.F.', '.T.')
	lcCompareMemo     = IIF(EMPTY(DBGETPROP(pcViewName, 'View', 'CompareMemo')), '.F.', '.T.')
	lcFetchAsNeeded   = IIF(EMPTY(DBGETPROP(pcViewName, 'View', 'FetchAsNeeded')), '.F.', '.T.')

*-*	Generate CREATE VIEW command
	lcViewSchema = "******Schema Definition - " + pcViewName + CRLF
	IF plGeneric
		lcViewName = "<<ViewName>>"
	ELSE
		lcViewName = pcViewName
	ENDIF
	lcViewSchema = lcViewSchema + "CREATE SQL VIEW '" + pcViewName + "'"
	IF lnSourceType = 1
		lcViewType = "Local"
	ELSE
		lcViewType = "Remote"
		lcViewSchema = lcViewSchema + " REMOTE"
		IF !EMPTY(lcConnectName)
			lcViewSchema = lcViewSchema + " CONNECT '" + lcConnectName + "'"
		ENDIF
	ENDIF
	lcViewSchema = lcViewSchema + " AS " + lcSQL + CRLF

*-*	GENERATE code to Set View Level Properties
	lcDBSetProp = "DBSETPROP('" + lcViewName + "', 'View', "
	
	lcViewSchema = lcViewSchema + lcDBSetProp + "'UpdateType', "             + lcUpdateType      + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'WhereType', "              + lcWhereType       + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'FetchMemo', "              + lcFetchMemo       + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'SendUpdates', "            + lcSendUpdates     + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'UseMemoSize', "            + lcUseMemoSize     + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'FetchSize', "              + lcFetchSize       + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'MaxRecords', "             + lcMaxRecords      + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'Tables', '"                + lcTables          + "')" + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'Prepared', "               + lcPrepared        + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'CompareMemo', "            + lcCompareMemo     + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'FetchAsNeeded', "          + lcFetchAsNeeded   + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'Comment', '"               + lcComment         + "')" + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'BatchUpdateCount', "       + lcBatchUpdCount   + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'ShareConnection', "        + lcShareConnection + ")"  + CRLF
	lcViewSchema = lcViewSchema + lcDBSetProp + "'AllowSimultaneousFetch', " + lcAllowSimulFetch + ")"  + CRLF
	IF !EMPTY(lcParams)
		lcViewSchema = lcViewSchema + lcDBSetProp + "'ParameterList', '" + lcParams + "')" + CRLF
	ENDIF
	IF !EMPTY(lcRuleExpr)
		lcViewSchema = lcViewSchema + lcDBSetProp + "'RuleExpression', '" + lcRuleExpr + "')" + CRLF
		lcViewSchema = lcViewSchema + lcDBSetProp + "'RuleText', '"       + lcRuleText + "')" + CRLF
	ENDIF
	IF llOffline
		lcViewSchema = lcViewSchema + "CREATEOFFLINE('" + pcViewName + "')" + CRLF
	ENDIF

*-*	GENERATE code to Set Field Level Properties
	lcDBCName = DBC()
	USE (lcDBCName) AGAIN IN 0 ALIAS gkpdbc SHARED
	SELECT gkpdbc
	LOCATE FOR ALLTRIM(UPPER(ObjectName)) == pcViewName .AND. ObjectType = 'View'
	lnObjectId = gkpdbc.ObjectId
	SELECT ObjectName FROM gkpdbc WHERE ParentId = lnObjectId INTO ARRAY lcViewFlds
	USE IN gkpdbc
	IF _TALLY = 0
		lnFldCnt = 0
		lcFldDefn = "FieldCount|" + TRANSFORM(lnFldCnt) + CRLF
	ELSE
		lnFldCnt  = ALEN(lcViewFlds,1)
		lcFldDefn = "FieldCount|" + TRANSFORM(lnFldCnt) + CRLF
		FOR lnFld=1 TO lnFldCnt
			lcFieldAlias = pcViewName + "." + ALLTRIM(lcViewFlds[lnFld,1])
			lcKeyField   = IIF(DBGETPROP(lcFieldAlias, 'Field', 'KeyField'),'.T.','.F.')
			lcUpdatable  = IIF(DBGETPROP(lcFieldAlias, 'Field', 'Updatable'),'.T.','.F.')
			lcUpdateName = fStripLine(DBGETPROP(lcFieldAlias, 'Field', 'UpdateName'))
			lcDBSetProp  = "DBSETPROP('" + lcViewName + "." + ALLTRIM(lcViewFlds[lnFld,1]) + "', 'Field', "
			
			lcDelimiter = IIF("'" $ lcUpdateName, '"', "'")
			lcViewSchema  = lcViewSchema + lcDBSetProp + "'KeyField', "   + lcKeyField  + ")" + CRLF
			lcViewSchema  = lcViewSchema + lcDBSetProp + "'Updatable', "  + lcUpdatable + ")" + CRLF
			lcViewSchema  = lcViewSchema + lcDBSetProp + "'UpdateName', " + lcDelimiter + lcUpdateName + lcDelimiter + ")" + CRLF

			lcFldDefn = lcFldDefn + "FieldName|"  + ALLTRIM(lcViewFlds[lnFld,1]) + CRLF
			lcFldDefn = lcFldDefn + "KeyField|"   + lcKeyField   + CRLF
			lcFldDefn = lcFldDefn + "Updatable|"  + lcUpdatable  + CRLF
			lcFldDefn = lcFldDefn + "UpdateName|" + lcUpdateName + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "RuleExpression"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'RuleExpression', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "RuleExpression|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "RuleText"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'RuleText', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "RuleText|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "Caption"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'Caption', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "Caption|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "Comment"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'Comment', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "Comment|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "InputMask"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'InputMask', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "InputMask|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "Format"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'Format', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "Format|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "DisplayClass"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'DisplayClass', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "DisplayClass|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "DisplayClassLibrary"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'DisplayClassLibrary', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "DisplayClassLibrary|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "DataType"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'DataType', '" + lcProperty + "')" + CRLF
			ENDIF
			lcFldDefn = lcFldDefn + "DataType|" + lcProperty + CRLF

			lcProperty = fStripLine(DBGETPROP(lcFieldAlias, "Field", "DefaultValue"))
			IF EMPTY(lcProperty)
				lcViewSchema = lcViewSchema + lcDBSetProp + "'DefaultValue', '" + lcProperty + "')"
			ENDIF
			lcFldDefn = lcFldDefn + "DefaultValue|" + lcProperty + CRLF
		ENDFOR
	ENDIF
	poReturn.Schema = lcViewSchema

*-*	Save info for version comparison
	lcViewSchema = "******View Definition - " + pcViewName + CRLF
	lcViewSchema = lcViewSchema + "Comment|"                + lcComment         + CRLF
	lcViewSchema = lcViewSchema + "ConnectName|"            + lcConnectName     + CRLF
	lcViewSchema = lcViewSchema + "SQL|"                    + lcSQL             + CRLF
	lcViewSchema = lcViewSchema + "UpdateType|"             + lcUpdateType      + CRLF
	lcViewSchema = lcViewSchema + "WhereType|"              + lcWhereType       + CRLF
	lcViewSchema = lcViewSchema + "Fetchmemo|"              + lcFetchMemo       + CRLF
	lcViewSchema = lcViewSchema + "ShareConnection|"        + lcShareConnection + CRLF
	lcViewSchema = lcViewSchema + "SendUpdates|"            + lcSendUpdates     + CRLF
	lcViewSchema = lcViewSchema + "UseMemoSize|"            + lcUseMemoSize     + CRLF
	lcViewSchema = lcViewSchema + "FetchSize|"              + lcFetchSize       + CRLF
	lcViewSchema = lcViewSchema + "MaxRecords|"             + lcMaxRecords      + CRLF
	lcViewSchema = lcViewSchema + "Tables|"                 + lcTables          + CRLF
	lcViewSchema = lcViewSchema + "Prepared|"               + lcPrepared        + CRLF
	lcViewSchema = lcViewSchema + "CompareMemo|"            + lcCompareMemo     + CRLF
	lcViewSchema = lcViewSchema + "FetchAsNeeded|"          + lcFetchAsNeeded   + CRLF
	lcViewSchema = lcViewSchema + "ParameterList|"          + lcParams          + CRLF
	lcViewSchema = lcViewSchema + "AllowSimultaneousFetch|" + lcAllowSimulFetch + CRLF
	lcViewSchema = lcViewSchema + "BatchUpdateCount|"       + lcBatchUpdCount   + CRLF
	lcViewSchema = lcViewSchema + "RuleExpression|"         + lcRuleExpr        + CRLF
	lcViewSchema = lcViewSchema + "RuleText|"               + lcRuleText        + CRLF
	lcViewSchema = lcViewSchema + "Offline|"                + TRANSFORM(llOffline)    + CRLF
	lcViewSchema = lcViewSchema + "SourceType|"             + TRANSFORM(lnSourceType) + CRLF

	poReturn.VersCtrl = lcViewSchema + "******Field Properties******" + CRLF + lcFldDefn
	lcRtnDefn = pcViewName + "|" + lcViewType + "|" + IIF(EMPTY(lcTables)," ",lcTables) + "|" + IIF(EMPTY(lcComment)," ",lcComment) + "|" + TRANSFORM(lnFldCnt)

	IF llDbcOpened
		CLOSE DATABASES
	ENDIF

CATCH TO loException
	lcUserMsg = 'Unable to open selected file to add a version.'
	=GKPWMSGBOX(lcUserMsg,"GKP Project Manager",16,"WARNING")

ENDTRY
RETURN lcRtnDefn
ENDFUNC

*-***************************************************

FUNCTION fStripLine
LPARAMETERS pcLine
LOCAL lcLine
lcLine = ALLTRIM(pcLine)
IF EMPTY(lcLine)
	lcLine = SPACE(1)
ELSE
	lcLine = STRTRAN(lcLine,'"',"'")
	lcLine = STRTRAN(lcLine,CHR(10)) 
	lcLine = STRTRAN(lcLine,CHR(13)," + $$CRLF$$ + ")
ENDIF
IF LEFT(lcLine,3) = " + "
	lcLine = SUBSTR(lcLine,4)
ENDIF
RETURN lcLine
ENDFUNC