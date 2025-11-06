LOCAL lcF,lcP,lcT,loE

lcF = HOME()+"APP\XinJieAI\AI.APP"
IF !FILE(lcF)
	lcF = FULLPATH("\VFP\ai\AI.APP",SYS(16))
	IF !FILE(lcF)
		Messagebox("本电脑没有安装AI.APP")
		RETURN
	ENDIF
ENDIF

lcP = SET("Default") + CURDIR()
TRY
	lcT = JUSTPATH(lcF)
	SET DEFAULT TO "&lcT"
	* AI()
	DO (lcF)
	WAIT WINDOW "Start XinJieAI OK" TIMEOUT 5
CATCH TO loE
	Messagebox("执行AI错误："+loE.Message,16)
ENDTRY
SET DEFAULT TO (lcP)
