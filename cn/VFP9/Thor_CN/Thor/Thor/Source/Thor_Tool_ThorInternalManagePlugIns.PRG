Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具在 Thor 中进行正确注册。

If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' == Lower (lxParam1.Class)

	With lxParam1

		* Required					CN: 必需的
		.Prompt	 =  [管理 PRGs 插件] 
		.Summary =  [管理 PRGs 插件] 

		* Optional					CN: 可选的
		.Description =  [管理 PRGs 插件] 

		* These are used to group and sort tools when they are displayed in menus or the Thor form
		* CN: 当它们显示在菜单或Thor表单中时，它们用于对工具进行分组和排序
		.Category = 'Settings & Misc.' && allows categorization for tools with the same source				CN: 当它们显示在菜单或Thor表单中时，它们用于对工具进行分组和排序
		.Sort	  = 999 && the sort order for all items from the same Source, Category and Sub-Category		CN: 来自同一来源，类别和子类别的所有项目的排序顺序
		.PlugInClasses = 'clsBeforeComponentInstall, clsAfterComponentInstall'

		* For public tools, such as PEM Editor, etc.
		* CN: 用于公共工具，如PEM编辑器等
		.Author        = 'Jim Nelson'
		.CanRunAtStartup = .F.

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

	Local lcFileName
	If Type ('_Screen.cThorDispatcher') = 'C'
		Execscript (_Screen.cThorDispatcher, 'PEMEditor_StartIDETools')
		lcFileName    = Execscript (_Screen.cThorDispatcher, 'Full Path=Thor_Tool_ThorInternalManagePlugIns.SCX')
		Do Form  (lcFileName)
	Else
		Messagebox ( [Thor 没有激活；此工具需要 Thor 先启动] , 16,  [Thor 没有激活] , 0)
	Endif

Endproc


****************************************************************
****************************************************************

Define Class clsBeforeComponentInstall As Custom

	Source				= 'Thor'
	PlugIn				=  [组件安装前] 
	Description			=  [在检查更新期间安装组件之前（在Thor \ Tools \ Components的子文件夹中）调用。] 
	Tools				=  [检查更新] 
	FileNames			= 'Thor_Proc_BeforeComponentInstall.PRG'
	DefaultFileName		= '*Thor_Proc_BeforeComponentInstall.PRG'
	DefaultFileContents	= ''

	Procedure Init
		****************************************************************
		****************************************************************
		Text To This.DefaultFileContents Noshow
Lparameters tcApplicationName, tcInstallationFolder

		Endtext
		****************************************************************
		****************************************************************
	Endproc

Enddefine


****************************************************************
****************************************************************

Define Class clsAfterComponentInstall As Custom

	Source				= 'Thor'
	PlugIn				=  [组件安装后] 
	Description			=  [在检查更新期间安装组件后（在Thor \ Tools \ Components的子文件夹中）调用。] 
	Tools				=  [检查更新] 
	FileNames			= 'Thor_Proc_AfterComponentInstall.PRG'
	DefaultFileName		= '*Thor_Proc_AfterComponentInstall.PRG'
	DefaultFileContents	= ''

	Procedure Init
		****************************************************************
		****************************************************************
		Text To This.DefaultFileContents Noshow
Lparameters tcApplicationName, tcInstallationFolder

		Endtext
		****************************************************************
		****************************************************************
	Endproc

Enddefine

