Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具在 Thor 中进行正确注册。
If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' = Lower (lxParam1.Class)

	With lxParam1
		.Prompt		 =  [Thor 仓库的所有工具] 
		.Description =  [在Thor 仓库中注册的所有工具的菜单] 
		.Source		 = 'Thor'
		.FolderName	 = 'D:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 9\Thor\Tools\'
		.Version     = 'Thor - 1.42.13 - June 18, 2016'
		.Sort		 = 40
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
	Do 'D:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 9\Thor.APP' with 'Thor Repository'
EndProc
