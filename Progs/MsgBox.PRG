* LGW 1788469@QQ.com
LPARAMETERS tcM,tnT,tcT
IF VARTYPE(tnT) # "N"
	tnT = 64
ENDIF
IF VARTYPE(tcT) # "C"
	tcT = _screen.Caption
ENDIF
RETURN MESSAGEBOX(tcM,tnT,tcT)