Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具告诉Thor自己。

If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' = Lower (lxParam1.Class)

	With lxParam1
		.Prompt			=  [工具主页] 
		.Description	=  [工具主页菜单用于访问任意工具的主页或描述] 
		.Source			= 'Thor'
		.Version		= 'Thor - 1.42.13 - June 18, 2016'
		.Sort			= 30
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
	Do 'D:\PROGRAM FILES\MICROSOFT VISUAL FOXPRO 9\Thor.APP' with 'All Tools'
EndProc
