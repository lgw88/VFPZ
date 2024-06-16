LOCAL lcPath,loADO,loRS
LOCAL ARRAY laObj(5)
lcPath=SYS(16)
lcPath=IIF(RAT("\",lcPath)>0,LEFT(lcPath,RAT("\",lcPath)),lcPath)

SET PATH TO (lcPath)
SET DEFA TO (lcPath)

OPEN DATA XXD000
USE XXT000 IN 0
USE XXV000 IN 0
USE XXV001 IN 0


loADO=CREATEOBJECT("ADODB.Connection")
loADO.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source="+lcPath+"xxd000.mdb")

loRS=CREATEOBJECT("ADODB.Recordset")
loRS.ActiveConnection = loADO
loRS.CursorType= 3  && adOpenStatic 
loRS.CursorLocation = 3  && adUseClient 
loRS.LockType= 3  && adLockOptimistic

** CursorAdapter
loCAx=CREATEOBJECT("cursoradapter")

loCAx.FetchSize=100
loCAx.FetchMemo=.T.
loCAx.CompareMemo=.F.
loCAx.UseMemoSize=255
loCAx.FetchAsNeeded=.F.

loCAx.UpdateNameList=;
     "XX000 XXT000.XX000, XX001 XXT000.XX001"

loCAx.UpdatableFieldList=;
       "XX000, XX001" && updatování

loCAx.KeyFieldList="XX000" && primární klíè
loCAx.Tables="XXT000" && tabulka

loCAx.WhereType=3

loCAx.BatchUpdateCount=1
loCAx.SendUpdates=.T.

loCAx.UpdateType=1
loCAx.Prepared=.F.

loCAx.CursorSchema=""
loCAx.SelectCmd="SELECT XX000, XX001 FROM XXT000"

loCAx.DataSourceType="ADO"
loCAx.DataSource=loRS
loCAx.Alias="XXV002"
loCAx.MaxRecords=-1
lll=loCAx.CursorFill()


SET CLASSLIB TO ..\proper.vcx

laObj(1)=CREATEOBJECT("_prop_cursor")
laObj(2)=CREATEOBJECT("_prop_cursor")
laObj(3)=CREATEOBJECT("_prop_cursor")
laObj(4)=CREATEOBJECT("_prop_cursor")
laObj(5)=CREATEOBJECT("_prop_cursor")


laObj(1).Set(0)
laObj(2).Set("XXT000")
laObj(3).Set("XXV000")
laObj(4).Set("XXV001")
laObj(5).Set("XXV002")

susp

CLOSE ALL
CLEAR ALL