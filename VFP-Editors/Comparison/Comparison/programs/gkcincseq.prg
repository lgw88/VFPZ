**
FUNCTION GKCINCSEQ
LPARAMETERS PCFIELDNAME, PCFIRSTCHAR
LOCAL LCORGALIAS, LCFIRST, LNDECPLACE, LCALIAS, LCFIELD, LNNDX, LNLEN, LCNEXTID, LCFIELDVALUE, LLNEXT
LOCAL LNCHR
LCORGALIAS = ALIAS()
PCFIELDNAME = ALLTRIM(PCFIELDNAME)
LCFIRST = "1"
LNDECPLACE = ATC(".", PCFIELDNAME)
PCFIELDNAME = ALLTRIM(PCFIELDNAME)
LNLEN = LEN(PCFIELDNAME)
LCNEXTID = ""
LLNEXT = .T.
DO WHILE LLNEXT
IF LNLEN>0
LNCHR = ASC(SUBSTR(PCFIELDNAME, LNLEN, 1))
IF LNCHR>=48 .AND. LNCHR<57
LNCHR = LNCHR+1
LLNEXT = .F.
ELSE
IF LNCHR=57
LNCHR = 65
LLNEXT = .F.
ELSE
IF LNCHR<90
LNCHR = LNCHR+1
LLNEXT = .F.
ELSE
LNCHR = 48
ENDIF
ENDIF
ENDIF
LCNEXTID = CHR(LNCHR)+LCNEXTID
LNLEN = LNLEN-1
ELSE
LCNEXTID = "1"+LCNEXTID
EXIT
ENDIF
ENDDO
IF LNLEN>0
LCNEXTID = LEFT(PCFIELDNAME, LNLEN)+LCNEXTID
ENDIF
RETURN ALLTRIM(LCNEXTID)
ENDFUNC
**