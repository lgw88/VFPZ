#Define ccCR  Chr[13]

Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: ����Thor���ߵı�׼ǰ׺������������߸���Thor�Լ���

If Pcount() = 1								;
		And 'O' = Vartype (lxParam1)		;
		And 'thorinfo' == Lower (lxParam1.Class)

	With lxParam1

		* Required				CN: �����
		.Prompt		   =  [Thor ����]  && used in menus

		* Optional				CN: ��ѡ��
		.Description   =  [Thor ������ҳ] 
		.StatusBarText = ''

		* These are used to group and sort tools when they are displayed in menus or the Thor form
		* CN: ��������ʾ�ڲ˵���Thor������ʱ���������ڶԹ��߽��з��������
		.Category      = 'Thor' && creates categorization of tools; defaults to .Source if empty			CN: �������ߵķ���; ���Ϊ�գ���Ĭ��Ϊ.Source

		* For public tools, such as PEM Editor, etc.
		* CN: ���ڹ������ߣ���PEM�༭����
		.Author		   = 'Jim Nelson'

	Endwith

	Return lxParam1
Endif

If Pcount() = 0
	Do ToolCode
Else
	Do ToolCode With lxParam1
Endif

Return



****************************************************************
****************************************************************
* Normal processing for this tool begins here.                  
* CN: ������ߵ��������������￪ʼ��
Procedure ToolCode
	Lparameters lxParam1

	If Not Execscript (_Screen.cThorDispatcher, 'Thor_Proc_CheckInternetConnection')
		If 'L' = Vartype (lxParam1)
			Messagebox ( [û���ҵ����������ӣ�] , 16,  [û�л���������] , 0)
			Return .F.
		Endif
	Endif

	If Version(3) = [86]
		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Shell', 'https://github.com/vfp9/Thor_CN/blob/master/Docs/TWEeTs.md')
	Else 
		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Shell', 'https://github.com/VFPX/Thor/blob/master/Docs/TWEeTs.md')
	EndIf 
Endproc