#INCLUDE foxtxn.h


DEFINE CLASS prod AS session OLEPUBLIC

oMTX = .F.
oContext = .F.

PROCEDURE CheckStock(cPID,nOrdAmount)
	* Checks to see if enough of product in stock
	LOCAL aProdStock,nErrCode,oMtx,oContext,lDataNotOpened

	DIMENSION aProdStock[1]
	nErrCode = S_OK

	lDataNotOpened = EMPTY(DBC()) OR DBC()#DBCFILE
	IF m.lDataNotOpened
		OPEN DATABASE DBCFILE SHARED
	ENDIF

	oMtx = CREATEOBJECT(MTX_CLASS)
	oContext = oMtx.GetObjectContext()	
	IF ISNULL(oContext)
		RETURN -99
	ENDIF

	SELECT in_stock ;
	  FROM products ;
	  WHERE ALLTRIM(UPPER(product_id)) == ALLTRIM(UPPER(m.cPID));
	  INTO ARRAY aProdStock

	DO CASE
	CASE _TALLY = 0
		nErrCode = ITEM_NOT_FOUND
	CASE m.nOrdAmount > aProdStock
		nErrCode = ITEM_EXCEEDED
	OTHERWISE
		UPDATE products ;
		  SET in_stock = in_stock - m.nOrdAmount;
		  WHERE ALLTRIM(UPPER(product_id)) == ALLTRIM(UPPER(m.cPID))
		IF _TALLY = 0
			nErrCode = ITEM_NOT_FOUND
		ENDIF
	ENDCASE

	IF m.nErrCode = S_OK
		oContext.SetComplete()
	ELSE
		oContext.SetAbort()
	ENDIF
	oContext = null
	oMtx = null
	IF m.lDataNotOpened
		CLOSE DATABASES
	ENDIF
	RETURN m.nErrCode

ENDPROC

PROCEDURE Error(nError, cMethod, nLine)
	STRTOFILE("Error in Prod: "+TRANS(nError)+","+TRANS(nLine)+CRLF,ERRLOGFILE,.T.)
	STRTOFILE("  "+MESSAGE()+CRLF,ERRLOGFILE,.T.)
	RETURN CONTEXT_E_ABORTED
ENDPROC

ENDDEFINE