#Define ccCR  Chr[13]

Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具告诉Thor自己。

If Pcount() = 1								;
		And 'O' = Vartype (lxParam1)		;
		And 'thorinfo' == Lower (lxParam1.Class)

	With lxParam1

		* Required				CN: 必需的
		.Prompt		   =  [Thor 推文]  && used in menus

		* Optional				CN: 可选的
		.Description   =  [Thor 推文主页] 
		.StatusBarText = ''

		* These are used to group and sort tools when they are displayed in menus or the Thor form
		* CN: 当它们显示在菜单或Thor表单中时，它们用于对工具进行分组和排序
		.Category      = 'Thor' && creates categorization of tools; defaults to .Source if empty			CN: 创建工具的分类; 如果为空，则默认为.Source

		* For public tools, such as PEM Editor, etc.
		* CN: 用于公共工具，如PEM编辑器等
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
* CN: 这个工具的正常处理从这里开始。
Procedure ToolCode
	Lparameters lxParam1

	If Not Execscript (_Screen.cThorDispatcher, 'Thor_Proc_CheckInternetConnection')
		If 'L' = Vartype (lxParam1)
			Messagebox ( [没有找到互联网连接！] , 16,  [没有互联网连接] , 0)
			Return .F.
		Endif
	Endif

	If Version(3) = [86]
		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Shell', 'https://github.com/vfp9/Thor_CN/blob/master/Docs/TWEeTs.md')
	Else 
		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Shell', 'https://github.com/VFPX/Thor/blob/master/Docs/TWEeTs.md')
	EndIf 
Endproc
