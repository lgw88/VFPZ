**
FUNCTION GKCSetString_VFP
LPARAMETERS PCSUBKEY, PCENTRY, PCSTRVALUE
LOCAL LCALIAS, LCSTRBUFFER, LNINTVALUE, LNDECVALUE, LLRETURN
LCALIAS = ALIAS()
IF GKCGETRESOURCE()
DO CASE
CASE VARTYPE(PCSTRVALUE)="C"
LCSTRBUFFER = ALLTRIM(PCSTRVALUE)
CASE VARTYPE(PCSTRVALUE)="N"
LNINTVALUE = INT(PCSTRVALUE)
LNDECVALUE = (PCSTRVALUE-LNINTVALUE)*10000
LCSTRBUFFER = TRANSFORM(LNINTVALUE)+"."+TRANSFORM(LNDECVALUE)
CASE VARTYPE(PCSTRVALUE)="D"
LCSTRBUFFER = DTOC(PCSTRVALUE)
CASE VARTYPE(PCSTRVALUE)="T"
LCSTRBUFFER = TTOC(PCSTRVALUE)
CASE VARTYPE(PCSTRVALUE)="L"
IF PCSTRVALUE
LCSTRBUFFER = ".T."
ELSE
LCSTRBUFFER = ".F."
ENDIF
CASE VARTYPE(PCSTRVALUE)="Y"
LCSTRBUFFER = TRANSFORM(PCSTRVALUE)
OTHERWISE
LCSTRBUFFER = PCSTRVALUE
ENDCASE
LNCKVAL = VAL(ALLTRIM(SYS(2007, SUBSTR(LCSTRBUFFER, 3))))
SELECT GKKUSER
LOCATE FOR TYPE='GKCSETTINGS' .AND. ALLTRIM(ID)==UPPER(PCSUBKEY) .AND. ALLTRIM(NAME)==UPPER(PCENTRY) .AND.  .NOT. DELETED()
IF FOUND()
REPLACE GKKUSER.DATA WITH LCSTRBUFFER
REPLACE GKKUSER.CKVAL WITH LNCKVAL
REPLACE GKKUSER.UPDATED WITH DATE()
ELSE
INSERT INTO GKKUSER (TYPE, ID, NAME, DATA, CKVAL, UPDATED) VALUES ('GKCSETTINGS', UPPER(PCSUBKEY), UPPER(PCENTRY), LCSTRBUFFER, LNCKVAL, DATE())
ENDIF
LLRETURN = .T.
IF  .NOT. EMPTY(LCALIAS)
SELECT (LCALIAS)
ENDIF
ELSE
LLRETURN = .F.
ENDIF
RETURN LLRETURN
ENDFUNC
**
