#IF Version(3) = [00]
	#Define ThorFrameworkURL 		'https://github.com/VFPX/Thor/blob/master/Docs/Thor_repository.md'
#ELSE Version(3) = [86]
	#Define ThorFrameworkURL 		'https://github.com/vfp9/Thor_CN/blob/master/Docs/Thor_repository.md'
#ENDIF

Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具在 Thor 中进行正确注册。

If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' = Lower (lxParam1.Class)

	With lxParam1
		.Prompt		 =  [链接到 Thor 仓库] 
		.Description =  [链接到 Thor 仓库主页] 
		.Source		 = 'Thor'
		.Version     = 'Thor - 1.42.13 - June 18, 2016'
		.Sort		 = 20
		.Link        = 'https://github.com/vfp9/Thor_CN/blob/master/Docs/Thor_repository.md'
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
	Local loLink
	loLink = Newobject ('_ShellExecute', Home() + 'FFC\_Environ.vcx')
	loLink.ShellExecute ('https://github.com/vfp9/Thor_CN/blob/master/Docs/Thor_repository.md')
EndProc
