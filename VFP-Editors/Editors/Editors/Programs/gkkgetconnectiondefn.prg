*-***********************************************************************************************
*-* Modified by:  Gregory A. Green
*-*               980 Windmill Parkway
*-*               Evans, GA  30809
*-*               (706) 651-1640
*-*
*-***********************************************************************************************
*-*  Routine for getting the connection definition for version control save; adapted from GENDBC.PRG
*-*
FUNCTION GKKGetConnectionDefn
LPARAMETERS pcDBCName,pcConnName,poReturn,plGeneric
LOCAL lcAsynchronous, lcBatchMode, lcComment, lcConnectString, lcConnectTimeOut, lcDataSource, lcDispLogin
LOCAL lcDispWarnings, lcIdleTimeOut, lcQueryTimeOut, lcTransactions, lcUserId, lcPassword, lcWaitTime
LOCAL lcDatabase, lcPacketSize, lcConnDefn, lcDBSetProp, lcConnName, llDbcOpened
#DEFINE CRLF  CHR(13)+CHR(10)

TRY
	llDbcOpened = .F.
	IF !EMPTY(pcDBCName)
		IF UPPER(DBC()) != UPPER(pcDBCName)
			OPEN DATABASE (pcDBCName) SHARED
			llDbcOpened = .T.
		ENDIF
	ENDIF

*-*	Get Connection Information
	lcAsynchronous   = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'Asynchronous'))
	lcBatchMode      = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'BatchMode'))
	lcComment        = ALLTRIM(DBGETPROP(pcConnName,   'Connection', 'Comment'))
	lcConnectString  = ALLTRIM(DBGETPROP(pcConnName,   'Connection', 'ConnectString'))
	lcConnectTimeOut = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'ConnectTimeOut'))
	lcDataSource     = ALLTRIM(DBGETPROP(pcConnName,   'Connection', 'DataSource'))
	lcDispLogin      = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'DispLogin'))
	lcDispWarnings   = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'DispWarnings'))
	lcIdleTimeOut    = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'IdleTimeOut'))
	lcQueryTimeOut   = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'QueryTimeOut'))
	lcTransactions   = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'Transactions'))
	lcUserId         = ALLTRIM(DBGETPROP(pcConnName,   'Connection', 'UserId'))
	lcPassword       = ALLTRIM(DBGETPROP(pcConnName,   'Connection', 'Password'))
	lcWaitTime       = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'WaitTime'))
	lcDatabase       = ALLTRIM(DBGETPROP(pcConnName,   'Connection', 'Database'))
	lcPacketSize     = TRANSFORM(DBGETPROP(pcConnName, 'Connection', 'PacketSize'))

*-*	Generate CREATE Connection command
	lcConnDefn = "******Build Definition - " + pcConnName + CRLF
	IF plGeneric
		lcConnName = "<<CONNNAME>>"
	ELSE
		lcConnName = pcConnName
	ENDIF
	lcConnDefn = lcConnDefn + 'CREATE CONNECTION "' + lcConnName + '" ; ' + CRLF
	
	IF EMPTY(lcConnectString)         && If ConnectString not specified
		lcConnDefn = lcConnDefn + '   DATASOURCE "' + lcDataSource + '" ; ' + CRLF
		lcConnDefn = lcConnDefn + '   USERID "'     + lcUserId     + '" ; ' + CRLF
		lcConnDefn = lcConnDefn + '   PASSWORD "'   + lcPassword   + '"'    + CRLF
	ELSE
		lcConnDefn = lcConnDefn + '   CONNSTRING "' + ALLTRIM(lcConnectString) + '"' + CRLF
	ENDIF
	
*-*	GENERATE code to Set Connection Level Properties
	lcDBSetProp = "DBSETPROP('" + lcConnName + "', 'Connection', "
	
	lcConnDefn = lcConnDefn + lcDBSetProp + "'Asynchronous', "   + lcAsynchronous   + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'BatchMode', "      + lcBatchMode      + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'Comment', '"       + lcComment        + "')" + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'DispLogin', "      + lcDispLogin      + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'ConnectTimeOut', " + lcConnectTimeOut + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'DispWarnings', "   + lcDispWarnings   + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'IdleTimeOut', "    + lcIdleTimeOut    + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'QueryTimeOut', "   + lcQueryTimeOut   + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'Transactions', "   + lcTransactions   + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'Database', '"      + lcDatabase       + "')" + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'PacketSize', "     + lcPacketSize     + ")"  + CRLF
	lcConnDefn = lcConnDefn + lcDBSetProp + "'WaitTime', "       + lcWaitTime       + ")"  + CRLF
	poReturn.Schema = lcConnDefn

*-*	Save info for version comparison
	lcConnDefn =              "Asynchronous|"   + lcAsynchronous   + CRLF
	lcConnDefn = lcConnDefn + "BatchMode|"      + lcBatchMode      + CRLF
	lcConnDefn = lcConnDefn + "Comment|"        + lcComment        + CRLF
	lcConnDefn = lcConnDefn + "ConnectTimeOut|" + lcConnectTimeOut + CRLF
	lcConnDefn = lcConnDefn + "Database|"       + lcDatabase       + CRLF
	lcConnDefn = lcConnDefn + "DispLogin|"      + lcDispLogin      + CRLF
	lcConnDefn = lcConnDefn + "DispWarnings|"   + lcDispWarnings   + CRLF
	lcConnDefn = lcConnDefn + "IdleTimeOut|"    + lcIdleTimeOut    + CRLF
	lcConnDefn = lcConnDefn + "QueryTimeOut|"   + lcQueryTimeOut   + CRLF
	lcConnDefn = lcConnDefn + "Transactions|"   + lcTransactions   + CRLF
	lcConnDefn = lcConnDefn + "PacketSize|"     + lcPacketSize     + CRLF
	lcConnDefn = lcConnDefn + "WaitTime|"       + lcWaitTime
	poReturn.VersCtrl = lcConnDefn
	IF !EMPTY(pcDBCName) .OR. llDbcOpened
		CLOSE DATABASE
	ENDIF
	lcConnDefn = lcDatabase + "|" + lcDataSource + "|" + lcComment

CATCH TO loException
	lcUserMsg = 'Unable to open selected file: ' + pcDBCName
	=GKKWMSGBOX(lcUserMsg,"GKK Project Manager",16,"WARNING")
ENDTRY
RETURN lcConnDefn
ENDFUNC