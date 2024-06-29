#INCLUDE foxtxn.h
#INCLUDE msmq.h

DEFINE CLASS msmqmsg AS session OLEPUBLIC

nTimeout = 0

PROCEDURE SendMsg(cCustID, nTotal, aProds)
LOCAL oQueueInfo,oMsg,oSendQueue,lcStr,i

oMTX = CREATEOBJECT(MTX_CLASS)
oContext = oMTX.GetObjectContext()

IF ISNULL(oContext)
	RETURN -99
ENDIF

* Open the queue
oQueueInfo = CreateObject("msmq.msmqqueueinfo")
IF VARTYPE(oQueueInfo) = "O"
	oQueueInfo.Formatname = "DIRECT=OS:.\PRIVATE$\" + MSMQ_QUEUE
	oSendQueue = oQueueInfo.Open(MQ_SEND_ACCESS, MQ_DENY_NONE)
	IF !EMPTY(oSendQueue.IsOpen)
		* Create new message
		oMsg  = create("msmq.msmqmessage")
		oMsg.Label = "Viper message: "+TRANS(DATETIME())
		lcStr = "Order detail: Customer - " + cCustID + ", Amount - "+TRANS(nTotal) + CRLF
		lcStr = lcStr + "Products:" + CRLF
		FOR i = 1 TO ALEN(aProds,1)
			lcStr = lcStr + "  ID - " + ALLTRIM(aProds[m.i,1]) + ", Amount - "+TRANS(aProds[m.i,2]) + CRLF
		ENDFOR
		oMsg.Body = lcStr
		IF THIS.nTimeout > 0
			oMsg.Journal = MQMSG_DEADLETTER
			oMsg.MaxTimeToReceive = 10
		ENDIF

		oMsg.Send(oSendQueue, MQ_MTS_TRANSACTION)
		oSendQueue.Close
	ENDIF
ENDIF
oContext.SetComplete()
ENDPROC

PROCEDURE Error(nError, cMethod, nLine)
	STRTOFILE("Error in MSMQ: "+TRANS(nError)+","+TRANS(nLine)+CRLF,ERRLOGFILE,.T.)
	STRTOFILE("  "+MESSAGE()+CRLF,ERRLOGFILE,.T.)
	RETURN CONTEXT_E_ABORTED
ENDPROC

ENDDEFINE
