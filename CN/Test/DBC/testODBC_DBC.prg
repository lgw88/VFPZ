LOCAL  lcConnString ,lnCon

lcConnString="Driver={Microsoft Visual Foxpro Driver};SourceType=DBc;SourceDB=��ѧ����.dbc;NULL=NO;Collate=Machine;BACKGROUNDFETCH=NO;DELETED=NO;Exclusive=No"
lnCon=SQLSTRINGCONNECT(lcConnString)
IF lnCon <= 0
	MESSAGEBOX("����ʧ��",0+64,"��ʾ")
	RETURN 
ENDIF

LOCAL myresult,myresult1,lcSQLStr,lckchao1

lcSQLStr="select * from �γ� where �γ̺�=?lckchao1"
lckchao1="aaa"

MESSAGEBOX("���ӳɹ�",0+64,"��ʾ")

*myresult=SQLEXEC(lnCon,lcSQLStr,"mykc")
	LOCAL nresult1,nresult2,n1count,n1count2
*nresult2=SQLEXEC(lnCon,"select _TALLY as AffectedRows","status")
*BROWSE


	myresult=SQLEXEC(lnCon,lcSQLStr,"kccursor",kcarray1)
	MESSAGEBOX("������"+STR(myresult)+"�����ݼ�,",0+48,"��ʾ")


	MESSAGEBOX("������ݼ�һ����"+STR(kcarray1(1,2))+"����¼",0+48,"��ʾ")
	n1count=kcarray1(1,2)

	IF  n1count>=1
		thisform.grid1.RecordSourceType = 0
		thisform.grid1.RecordSource=myresult
	ELSE
		myinsertsql="insert into �γ� values(?lckchao,?lckechm,?lnxueshi,?lnxuefen)"
		lckchao=ALLTRIM(thisform.text1.Value )
		lckechm=ALLTRIM(thisform.text2.Value )
		lnxueshi=VAL(ALLTRIM(thisform.text3.Value))
		lnxuefen=VAL(ALLTRIM(thisform.text4.Value))
		myinsert=SQLEXEC(lnCon,myinsertsql,"mykc")
		myresult=SQLEXEC(lnCon,lcSQLStr,"kccursor",kcarray1)
		n2count=kcarray1(1,2)

		messagebox("������"+STR(n2count)+"����¼",0+48,"��ʾ")
		thisform.grid1.RecordSourceType = 0
		thisform.grid1.RecordSource=myresult
	ENDIF
