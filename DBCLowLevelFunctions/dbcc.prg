LPARAM lcDBC
LOCAL lcPath,lcAlias
PRIVATE loDBC

CLEAR
#INCLUDE "dbc.h"


lcPath=SYS(16)
lcPath=IIF(RAT("\",m.lcPath)>0,LEFT(m.lcPath,RAT("\",m.lcPath)),m.lcPath)
SET PROCEDURE TO (m.lcPath+"dbc.prg")

lcAlias=SYS(2015)
lcDBC=IIF(EMPTY(m.lcDBC),HOME(2)+"\Tastrade\Data\tastrade.dbc",m.lcDBC)

loDBC=CREATEOBJECT("_DBC_Check")

IF m.loDBC.OpenTable(m.lcDBC,m.lcAlias,"")#_DBC_ErrOK
   WAIT WIND "Can not open DBC file."
   RETURN
ENDIF

=m.loDBC.Check(m.lcAlias)


=m.loDBC.CloseTable(m.lcAlias)


