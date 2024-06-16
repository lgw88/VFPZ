LOCAL  lcConnString ,lnCon

lcConnString="Driver={Microsoft Visual Foxpro Driver};SourceType=DBc;SourceDB=教学管理.dbc;NULL=NO;Collate=Machine;BACKGROUNDFETCH=NO;DELETED=NO;Exclusive=No"
lnCon=SQLSTRINGCONNECT(lcConnString)
IF lnCon <= 0
	MESSAGEBOX("连接失败",0+64,"提示")
	RETURN 
ENDIF

LOCAL myresult,myresult1,lcSQLStr,lckchao1

lcSQLStr="select * from 课程 where 课程号=?lckchao1"
lckchao1="aaa"

MESSAGEBOX("连接成功",0+64,"提示")

*myresult=SQLEXEC(lnCon,lcSQLStr,"mykc")
	LOCAL nresult1,nresult2,n1count,n1count2
*nresult2=SQLEXEC(lnCon,"select _TALLY as AffectedRows","status")
*BROWSE


	myresult=SQLEXEC(lnCon,lcSQLStr,"kccursor",kcarray1)
	MESSAGEBOX("产生了"+STR(myresult)+"个数据集,",0+48,"提示")


	MESSAGEBOX("这个数据集一个有"+STR(kcarray1(1,2))+"条记录",0+48,"提示")
	n1count=kcarray1(1,2)

	IF  n1count>=1
		thisform.grid1.RecordSourceType = 0
		thisform.grid1.RecordSource=myresult
	ELSE
		myinsertsql="insert into 课程 values(?lckchao,?lckechm,?lnxueshi,?lnxuefen)"
		lckchao=ALLTRIM(thisform.text1.Value )
		lckechm=ALLTRIM(thisform.text2.Value )
		lnxueshi=VAL(ALLTRIM(thisform.text3.Value))
		lnxuefen=VAL(ALLTRIM(thisform.text4.Value))
		myinsert=SQLEXEC(lnCon,myinsertsql,"mykc")
		myresult=SQLEXEC(lnCon,lcSQLStr,"kccursor",kcarray1)
		n2count=kcarray1(1,2)

		messagebox("插入了"+STR(n2count)+"个记录",0+48,"提示")
		thisform.grid1.RecordSourceType = 0
		thisform.grid1.RecordSource=myresult
	ENDIF
