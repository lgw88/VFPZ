#INCLUDE foxtxn.h

DEFINE CLASS cust AS session OLEPUBLIC

PROTECTED nMinAmout
nMinAmount = 5000

PROCEDURE CheckCust(cCustID, nOrdAmount, nBalance)
	* Checks to see if valid customer
	LOCAL aCustAmt,nErrCode,oMTX,oContext,lDataNotOpened 
	DIMENSION aCustAmt[1]
	nErrCode = S_OK
	oMTX = CREATEOBJECT(MTX_CLASS)
	oContext = oMTX.GetObjectContext()
	IF ISNULL(oContext)
		RETURN -99
	ENDIF

	lDataNotOpened = EMPTY(DBC()) OR DBC()#DBCFILE
	IF m.lDataNotOpened
		OPEN DATABASE DBCFILE SHARED
	ENDIF
	cCustID = ALLTRIM(m.cCustID)

	* Check for valid customer
	SELECT MaxOrdAmt ;
	  FROM customer ;
	  WHERE UPPER(cust_id) == UPPER(m.cCustID) ;
	  INTO ARRAY aCustAmt

	DO CASE
	CASE _TALLY = 0
		nErrCode = CUST_NOT_FOUND
	CASE aCustAmt < THIS.nMinAmount
		nErrCode = LIMIT_EXCEEDED
	CASE (aCustAmt-nOrdAmount) < THIS.nMinAmount
		nErrCode = LIMIT_EXCEEDED
	OTHERWISE
		UPDATE customer ;
		  SET MaxOrdAmt = MaxOrdAmt - m.nOrdAmount ;
		  WHERE cust_id == m.cCustID
		IF _TALLY = 0
			nErrCode = CUST_NOT_FOUND
		ELSE
			nBalance = aCustAmt - nOrdAmount
		ENDIF
	ENDCASE

	IF m.nErrCode =  S_OK
		oContext.SetComplete()
	ELSE
		oContext.SetAbort()	
	ENDIF

	IF m.lDataNotOpened
		CLOSE DATABASES
	ENDIF
	oContext = null
	oMTX = null

	RETURN m.nErrCode

ENDPROC

PROCEDURE Error(nError, cMethod, nLine)
	STRTOFILE("Error in Cust: "+TRANS(nError)+","+TRANS(nLine)+CRLF,ERRLOGFILE,.T.)
	STRTOFILE("  "+MESSAGE()+CRLF,ERRLOGFILE,.T.)
	RETURN CONTEXT_E_ABORTED
ENDPROC

ENDDEFINE


PROCEDURE aprodarr
PROCEDURE aprods
