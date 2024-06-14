**
FUNCTION GKCGetConnectionDefn
LPARAMETERS tcDbcName, tcConnName, toReturn, tlGeneric
LOCAL lcAsynchronous, lcBatchMode, lcComment, lcConnectString, lcConnectTimeOut, lcDataSource, lcDispLogin
LOCAL lcDispWarnings, lcIdleTimeOut, lcQueryTimeOut, lcTransActions, lcUserId, lcPassword, lcWaitTime
LOCAL lcDatabase, lcPacketSize, lcConnDefn, lcDbSetProp, lcConnName, llDbcOpened, lcUserMsg, loException
TRY
	llDbcOpened = .F.
	IF  !EMPTY(tcDbcName)
		IF UPPER(DBC())<>UPPER(tcDbcName)
			OPEN Database (tcDbcName) SHARED
			llDbcOpened = .T.
		ENDIF
	ENDIF
	lcAsynchronous   = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'Asynchronous'))
	lcBatchMode      = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'BatchMode'))
	lcComment        = ALLTRIM(DBGETPROP(tcConnName, 'Connection', 'Comment'))
	lcConnectString  = ALLTRIM(DBGETPROP(tcConnName, 'Connection', 'ConnectString'))
	lcConnectTimeOut = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'ConnectTimeOut'))
	lcDataSource     = ALLTRIM(DBGETPROP(tcConnName, 'Connection', 'DataSource'))
	lcDispLogin      = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'DispLogin'))
	lcDispWarnings   = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'DispWarnings'))
	lcIdleTimeOut    = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'IdleTimeOut'))
	lcQueryTimeOut   = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'QueryTimeOut'))
	lcTransActions   = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'Transactions'))
	lcUserId         = ALLTRIM(DBGETPROP(tcConnName, 'Connection', 'UserId'))
	lcPassword       = ALLTRIM(DBGETPROP(tcConnName, 'Connection', 'Password'))
	lcWaitTime       = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'WaitTime'))
	lcDatabase       = ALLTRIM(DBGETPROP(tcConnName, 'Connection', 'Database'))
	lcPacketSize     = TRANSFORM(DBGETPROP(tcConnName, 'Connection', 'PacketSize'))
	lcConnDefn       = "******Build Definition - " + tcConnName + CHR(13) + CHR(10)
	IF tlGeneric
		lcConnName = "<<CONNNAME>>"
	ELSE
		lcConnName = tcConnName
	ENDIF
	lcConnDefn = lcConnDefn + 'CREATE CONNECTION "' + lcConnName + '" ; ' + CHR(13) + CHR(10)
	IF EMPTY(lcConnectString)
		lcConnDefn = lcConnDefn + '   DATASOURCE "' + lcDataSource + '" ; ' + CHR(13) + CHR(10)
		lcConnDefn = lcConnDefn + '   USERID "' + lcUserId + '" ; ' + CHR(13) + CHR(10)
		lcConnDefn = lcConnDefn + '   PASSWORD "' + lcPassword + '"' + CHR(13) + CHR(10)
	ELSE
		lcConnDefn = lcConnDefn + '   CONNSTRING "' + ALLTRIM(lcConnectString) + '"' + CHR(13) + CHR(10)
	ENDIF
	lcDbSetProp = "DBSETPROP('" + lcConnName + "', 'Connection', "
	lcConnDefn = lcConnDefn + lcDbSetProp + "'Asynchronous', " + lcAsynchronous + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'BatchMode', " + lcBatchMode + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'Comment', '" + lcComment + "')" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'DispLogin', " + lcDispLogin + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'ConnectTimeOut', " + lcConnectTimeOut + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'DispWarnings', " + lcDispWarnings + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'IdleTimeOut', " + lcIdleTimeOut + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'QueryTimeOut', " + lcQueryTimeOut + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'Transactions', " + lcTransActions + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'Database', '" + lcDatabase + "')" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'PacketSize', " + lcPacketSize + ")" + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + lcDbSetProp + "'WaitTime', " + lcWaitTime + ")" + CHR(13) + CHR(10)
	toReturn.Schema = lcConnDefn

	lcConnDefn = "Asynchronous|" + lcAsynchronous + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "BatchMode|" + lcBatchMode + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "Comment|" + lcComment + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "ConnectTimeOut|" + lcConnectTimeOut + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "Database|" + lcDatabase + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "DispLogin|" + lcDispLogin + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "DispWarnings|" + lcDispWarnings + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "IdleTimeOut|" + lcIdleTimeOut + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "QueryTimeOut|" + lcQueryTimeOut + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "Transactions|" + lcTransActions + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "PacketSize|" + lcPacketSize + CHR(13) + CHR(10)
	lcConnDefn = lcConnDefn + "WaitTime|" + lcWaitTime
	toReturn.VersCtrl = lcConnDefn

	IF  !EMPTY(tcDbcName) .OR. llDbcOpened
		CLOSE DATABASES
	ENDIF
	lcConnDefn = lcDatabase + "|" + lcDataSource + "|" + lcComment

CATCH TO loException
	lcUserMsg = 'Unable to open selected file: ' + tcDbcName
	GKCWMSGBOX(lcUserMsg, "GKC Project Manager", 16, "WARNING")
ENDTRY
RETURN lcConnDefn
ENDFUNC
**