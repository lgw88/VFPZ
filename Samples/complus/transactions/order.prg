#INCLUDE foxtxn.h

DEFINE CLASS order AS session OLEPUBLIC

oMTX = .F.
oContext = .F.

PROCEDURE CustOrderWeb(lcCustID, lcProd, lnQty)
	LOCAL nErr, lnTotal, cErr
	DIMENSION aProdArr[1,2]
	aProdArr[1] = lcProd
	aProdArr[2] = VAL(lnQty)
	lnTotal = 10*VAL(lnQty)
	nBalance = 0
	nTimeout = 0
	nErr=THIS.ProcessOrder(lcCustID, lnTotal, @nBalance, @aProdArr, nTimeout)
	CLOSE DATABASES ALL
	THIS.oContext = null
	THIS.oMTX = null
	DO CASE
	CASE m.nErr = S_OK
		cErr = TRANSGOOD_LOC
	CASE m.nErr = LIMIT_EXCEEDED
		cErr = TRANSFAIL1_LOC
	CASE m.nErr = ITEM_EXCEEDED
		cErr = TRANSFAIL2_LOC
	CASE m.nErr = CUST_NOT_FOUND
		cErr = TRANSFAIL4_LOC
	CASE m.nErr = ITEM_NOT_FOUND
		cErr = TRANSFAIL5_LOC
	OTHERWISE
		cErr = TRANSFAIL3_LOC
	ENDCASE
	RETURN "<h3>" + cErr + "</h3>"
ENDPROC

PROCEDURE CustOrder(cCustID, nTotal, nBalance, aProdArr, nTimeout)
	LOCAL nErr
	nErr=THIS.ProcessOrder(cCustID, nTotal, @nBalance, @aProdArr, nTimeout)
	CLOSE DATABASES ALL
	THIS.oContext = null
	THIS.oMTX = null
	RETURN nErr
ENDPROC


PROCEDURE ProcessOrder(cCustID, nTotal, nBalance, aProdArr, nTimeout)

	LOCAL oProd,oCust,i,nErrCode,lDataNotOpened,oMSMQ

	THIS.oMTX = CREATEOBJECT(MTX_CLASS)
	THIS.oContext = THIS.oMTX.GetObjectContext()

	lDataNotOpened = EMPTY(DBC()) OR DBC()#DBCFILE
	IF m.lDataNotOpened
		OPEN DATABASE DBCFILE SHARED
	ENDIF

	*** Transaction 1: Send MSMQ Message 
	oMSMQ = THIS.oContext.CreateInstance(MSMQ_CLASS)
	oMSMQ.nTimeout = nTimeout
	oMSMQ.SendMsg(cCustID, nTotal, @aProdArr)

	*** Transaction 2: Check for valid customer and account > 5000
	oCust = THIS.oContext.CreateInstance(CUST_CLASS)
	nErrCode = oCust.CheckCust(cCustID,nTotal,@nBalance)
	nErrCode = IIF(TYPE("m.nErrCode")#"N",CONTEXT_E_ABORTED,m.nErrCode)

	* Customer object aborted transaction
	IF m.nErrCode#S_OK
		THIS.oContext.SetAbort
		RETURN m.nErrCode
	ENDIF

	*** Transaction 3: Check for product and valid amount
	oProd = THIS.oContext.CreateInstance(PROD_CLASS)
	FOR i = 1 TO ALEN(aProdArr,1)
		nErrCode = oProd.checkstock(aProdArr[m.i,1],aProdArr[m.i,2])
		nErrCode = IIF(TYPE("m.nErrCode")#"N",CONTEXT_E_ABORTED,m.nErrCode)
		* Product object aborted transaction
		IF m.nErrCode # S_OK
			EXIT
		ENDIF
	ENDFOR

	IF m.nErrCode = S_OK
		THIS.oContext.SetComplete
	ELSE
		THIS.oContext.SetAbort
	ENDIF
	RETURN m.nErrCode
ENDPROC

PROCEDURE error(nError, cMethod, nLine)
	STRTOFILE("Error in Order: "+TRANS(nError)+","+TRANS(nLine)+CRLF,ERRLOGFILE,.T.)
	STRTOFILE("  "+MESSAGE()+CRLF,ERRLOGFILE,.T.)
	RETURN CONTEXT_E_ABORTED
ENDPROC

ENDDEFINE