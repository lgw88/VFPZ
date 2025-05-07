Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具告诉Thor自己。

If Pcount() = 1								;
		And 'O' = Vartype(lxParam1)			;
		And 'thorinfo' == Lower(lxParam1.Class)

	With lxParam1

		* Required					CN: 必需的
		.Prompt		   =  [Thor 使用摘要]  && used in menus				CN: 用于菜单

		* Optional					CN: 可选的
		.Description =  [Thor 工具的使用摘要] 

		* These are used to group and sort tools when they are displayed in menus or the Thor form
		* CN: 当它们显示在菜单或Thor表单中时，它们用于对工具进行分组和排序
		.Category      = 'Thor' && creates categorization of tools; defaults to .Source if empty			CN: 创建工具的分类; 如果为空，则默认为.Source

		* For public tools, such as PEM Editor, etc.
		* CN: 用于公共工具，如PEM编辑器等
		.Author        = 'Jim Nelson'

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

	Local loThor As Thor_Engine Of 'C:\VISUAL FOXPRO\PROGRAMS\9.0\COMMON\Thor\Source\Thor.vcx'
	Local lcKey, lcToolFolder, loTool, loTools

	* Main Thor Engine
	loThor        = Execscript(_Screen.cThorDispatcher, 'Thor Engine=')

	lcToolFolder  = Execscript(_Screen.cThorDispatcher, 'Tool Folder=')

	loTools = loThor.GetToolsCollection(Addbs(lcToolFolder))

	Select  *														;
			  From(lcToolFolder + '..\Tables\Thor_LogFile')			;
		Order By Count Desc											;
		Into Cursor Thor_Summary Readwrite
	Use In Thor_LogFile
	Scan
		lcKey = Upper(Forceext(Alltrim(prgname), 'prg'))
		If 0 # loTools.GetKey(lcKey)
			loTool = loTools.Item(lcKey)
			Replace prgname With loTool.Prompt
		Endif
	Endscan

	Goto Top
	Browse Normal Nowait

Endproc
