Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具在 Thor 中进行正确注册。

If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' = Lower (lxParam1.Class)

	With lxParam1
		.Prompt		 =  [编辑 Thor] 
		.Summary     =  [Thor 表单] 
		.Description =  [打开主Thor表单：为工具指定快捷键，创建弹出菜单并为其指定快捷键，修改VFP系统菜单等。] 
		.FolderName	 = 'D:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 9\'
		.Source		 = 'Thor'
		.Version     = 'Thor - 1.42.13 - June 18, 2016'
		.Sort		 = 10
	Endwith

	Return lxParam1
Endif

Do ToolCode

Return

****************************************************************
****************************************************************
* Normal processing for this tool begins here.
* CN: 这个工具的正常处理从这里开始。
Procedure ToolCode
	Do 'D:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 9\Thor.APP' with 'Edit'
EndProc
