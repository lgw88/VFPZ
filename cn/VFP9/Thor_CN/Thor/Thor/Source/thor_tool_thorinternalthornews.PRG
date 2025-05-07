#IF Version(3) = [86]		&& 简体中文			EN: Simplified Chinese
	#Define 	ccThorNewsURL 		'https://github.com/vfp9/Thor_CN/blob/master/Docs/Thor_news.md'
	#Define 	ccTool 				'Thor 新闻'
	#Define     ccCheckForCFU		'Thor 新闻/CFU'
	#Define     ccRunThor			'Thor 新闻/运行 Thor'
	#Define     ccRunThorInterval	'Thor 新闻/运行 Thor Interval'
	#Define     ccDateLastSeen   	'Thor 新闻/信息快报'
	#Define     ccLastVersionSeen	'Thor 新闻/最新版本'

#ELSE						&& 英文				EN: English
	#Define 	ccThorNewsURL 		'https://github.com/VFPX/Thor/blob/master/Docs/Thor_news.md'
	#Define 	ccTool 				'Thor News'
	#Define     ccCheckForCFU		'Thor News/CFU'
	#Define     ccRunThor			'Thor News/Run Thor'
	#Define     ccRunThorInterval	'Thor News/Run Thor Interval'
	#Define     ccDateLastSeen   	'Thor News/Last News - Date'
	#Define     ccLastVersionSeen	'Thor News/Last News Version'
#ENDIF

#Define     ccEditClassName 	'clsThorNews'
#Define ccCR  Chr[13]

Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: 所有Thor工具的标准前缀，允许这个工具在 Thor 中进行正确注册。

If Pcount() = 1								;
		And 'O' = Vartype (lxParam1)		;
		And 'thorinfo' == Lower (lxParam1.Class)

	With lxParam1

		* Required				CN; 必需的
		.Prompt		   =  [Thor 新闻]  && used in menus				CN: 用于菜单

		* Optional				CN: 可选的
		.Description   =  [关于 Thor 的新闻头条] 
		.StatusBarText = ''

		* These are used to group and sort tools when they are displayed in menus or the Thor form
		* CN: 当它们显示在菜单或Thor表单中时，它们用于对工具进行分组和排序
		.Category      = 'Thor' && creates categorization of tools; defaults to .Source if empty		CN: 创建工具的分类; 如果为空，则默认为.Source

		* For public tools, such as PEM Editor, etc.
		* CN: 用于公共工具，如PEM编辑器等
		.Author		   = 'Jim Nelson'
		.OptionClasses = 'clsCheckForUpdates, clsRunThor, clsRunThorInterval, clsLastNewsDate, clsLastNewsVersion'
		.OptionTool	   = [Thor] 

		.ForumName 		= GetForumNames()
		.ForumLink 		= GetForumLinks()
*!* * Removed 11/16/2012 / JRN

*!* 		.BlogName 		= '-Jim Nelson'
*!* 		.BlogLink 		= 'http://jimrnelson.blogspot.com/'

		.ChangeLogName 	= GetChangeLogNames()
		.ChangeLogLink 	= GetChangeLogLinks()

	Endwith

	Return lxParam1
Endif

If Pcount() = 0
	Do ToolCode
Else
	Do ToolCode With lxParam1
Endif

Return


Procedure GetForumNames
	Local lcForums
	lcForums = '-Thor' && - Causes this to appear first; remainder are alphabetical
	lcForums = lcForums + chr(13) + 'OFUG'
	lcForums = lcForums + chr(13) + 'GoFish'
	lcForums = lcForums + chr(13) +  [动态表单] 
	Return lcForums
Endproc

Procedure GetForumLinks
	Local lcForums
	lcForums = 'https://groups.google.com/forum/?fromgroups#!forum/FoxProThor'
	lcForums = lcForums + chr(13) + 'https://groups.google.com/forum/?fromgroups=#!forum/ofug'
	lcForums = lcForums + chr(13) + 'https://groups.google.com/forum/?fromgroups#!forum/FoxProGoFish'
	lcForums = lcForums + chr(13) + 'https://groups.google.com/forum/?fromgroups#!forum/FoxProDynamicForms'
	Return lcForums
Endproc

Procedure GetChangeLogNames
	Local lcChangeLogs
	lcChangeLogs = '-Thor'  && - Causes this to appear first; remainder are alphabetical
	lcChangeLogs = lcChangeLogs + chr(13) +  [PEM 编辑器] 
	lcChangeLogs = lcChangeLogs + chr(13) +  [Thor 仓库] 
	lcChangeLogs = lcChangeLogs + chr(13) + 'IntellisenseX'
	lcChangeLogs = lcChangeLogs + chr(13) +  [VFPX 项目] 
	Return lcChangeLogs
Endproc

Procedure GetChangeLogLinks
	Local lcChangeLogs
	lcChangeLogs = 'https://docs.google.com/document/d/1Fs4dwMq3Ckgr4vReP1_YxHc1wQnEyHX94tUfaFsZ4us/edit'
	lcChangeLogs = lcChangeLogs + chr(13) + 'https://docs.google.com/document/d/1WE_ItHG8JJMCF-YbMCeJCELd08Qjr4HYLzde55rk-oI/edit'
	lcChangeLogs = lcChangeLogs + chr(13) + 'https://docs.google.com/document/d/1ASU-huMjxQ3hl7rRw3OqoJOGeQ8bAvnxs_2mJINDPKY/edit'
	lcChangeLogs = lcChangeLogs + chr(13) + 'https://docs.google.com/document/d/1WRfYGzJAdcAWCcpcwbs_BOE8xpSOmK6T8zSPwZKKf54/edit'
	lcChangeLogs = lcChangeLogs + chr(13) + 'https://docs.google.com/document/d/1Tz5mZGZRu1Ynu4CX2qxaVba1JkaeETHSvMz--O4DzMc/edit'
	Return lcChangeLogs
Endproc

****************************************************************
****************************************************************
* Normal processing for this tool begins here.                  
* CN: 这个工具的正常处理从这里开始。
Procedure ToolCode
	Lparameters lxParam1

	Local loShell As 'wscript.shell'
	Local lcHTMLFileName, ldDataLastSeen, llCheckFirst, llFailed, llShowIt, lnDateInterval
	Local lnHTMLVersion
	If Not Execscript (_Screen.cThorDispatcher, 'Thor_Proc_CheckInternetConnection')
		If 'L' = Vartype (lxParam1)
			Messagebox ( [没有找到互联网连接！] , 16,  [没有互联网连接] , 0)
			Return .F.
		Endif
	Endif

	* Main Thor Engine ... needed to get / set options
	* CN: Thor 主引擎...需要 get/set 选项
	llShowIt	 = .T.
	llCheckFirst = .F.
	Do Case
		Case 'L' = Vartype (lxParam1)

		Case Upper (lxParam1) = Upper ('Check For Updates')
			llShowIt	 = ExecScript(_Screen.cThorDispatcher, "Get Option=", ccCheckForCFU, [Thor])
			llCheckFirst = .T.

		Case Upper (lxParam1) = Upper ('RunThor')
			ldDataLastSeen = ExecScript(_Screen.cThorDispatcher, "Get Option=", ccDateLastSeen, [Thor])
			lnDateInterval = ExecScript(_Screen.cThorDispatcher, "Get Option=", ccRunThorInterval, [Thor])
			llShowIt = ExecScript(_Screen.cThorDispatcher, "Get Option=", ccRunThor, [Thor]) And			;
				(ldDataLastSeen + lnDateInterval) <= Date()
			llCheckFirst = .T.
	Endcase

	If Not llShowIt
		Return
	Endif

	lcHTMLFileName = Addbs (Sys(2023)) + 'ThorNews' + Sys(2015) + '.html'
	Try
		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadFileFromURL', ccThorNewsURL, lcHTMLFileName)
		lnHTMLVersion = GetVersionFromHTML (Filetostr (lcHTMLFileName))
		llFailed	  = .F.
	Catch
		llFailed = .T.
	Endtry

	If llFailed
		Return
	Endif

	ExecScript(_Screen.cThorDispatcher, "Set Option=", ccDateLastSeen, [Thor], Date())

	If llCheckFirst And lnHTMLVersion = ExecScript(_Screen.cThorDispatcher, "Get Option=", ccLastVersionSeen, [Thor])
		Return
	Endif

	ExecScript(_Screen.cThorDispatcher, "Set Option=", ccLastVersionSeen, [Thor], lnHTMLVersion)

	loShell = Createobject ('wscript.shell')
	loShell.Run (ccThorNewsURL)

Endproc


Procedure GetVersionFromHTML (lcHTML)

	Local loRegExp As 'VBScript.RegExp'
	Local lnVersion, loMatches
	loRegExp = Createobject ('VBScript.RegExp')

	With loRegExp
		.IgnoreCase	= .T.
		.Global		= .T.
		.MultiLine	= .T.

		.Pattern  = '^.*<p>Last edited.*version.*</p>'
		loMatches = .Execute (lcHTML)
	Endwith

	If loMatches.Count # 0
		lnVersion = Val (Strextract (loMatches.Item[0].Value, 'version', '</p>', 1, 1))
	Else
		lnVersion = 0
	Endif

	Return lnVersion
Endproc

****************************************************************
****************************************************************

Define Class clsCheckForUpdates As Custom

	Tool		  = [Thor]
	Key			  = ccCheckForCFU
	Value		  = .T.
	EditClassName = ccEditClassName

Enddefine


Define Class clsRunThor As Custom

	Tool		  = [Thor]
	Key			  = ccRunThor
	Value		  = .T.
	EditClassName = ccEditClassName

Enddefine


Define Class clsRunThorInterval As Custom

	Tool		  = [Thor]
	Key			  = ccRunThorInterval
	Value		  = 7
	EditClassName = ccEditClassName

Enddefine


Define Class clsLastNewsDate As Custom

	Tool		  = [Thor]
	Key			  = ccDateLastSeen
	Value		  = {//}
	EditClassName = ccEditClassName

Enddefine


Define Class clsLastNewsVersion As Custom

	Tool		  = [Thor]
	Key			  = ccLastVersionSeen
	Value		  = 0
	EditClassName = ccEditClassName

Enddefine

* a leftover
Define Class clsLastNewsVersion As Custom

	Tool		  = [Thor]
	Key			  = 'Thor_Tool_Thor_CheckForUpdates'
	Value		  = 0
	EditClassName = ccEditClassName

Enddefine

****************************************************************
Define Class clsThorNews As Container

	Procedure Init
		loRenderEngine = Execscript(_Screen.cThorDispatcher, 'Class= OptionRenderEngine')

		TEXT To loRenderEngine.cBodyMarkup Noshow Textmerge
		
			.Class	   = 'Label'
			.Caption   =  [检查 Thor 新闻的更新：] 
			.FontBold  = .T.
			.Left      = 40
			.Autosize  = .T.
			|
			.Class	   = 'CheckBox'
			.Width	   = 300
			.Left	   = 25
			.ZWordWrap = .T.
			.Caption   =  [在运行检查更新之后] 
			.cTool	   = [Thor]
			.cKey	   = ccCheckForCFU
			|
			.Class	   = 'CheckBox'
			.Width	   = 300
			.Left	   = 25
			.ZWordWrap = .T.
			.Caption   =  [在运行 RunThor 之后] 
			.cTool	   = [Thor]
			.cKey	   = ccRunThor
			|
			.Class	   = 'Label'
			.Caption   =  [检查间隔的天数：] 
			.Autosize  = .T.
			.Left      = 40
			|
			.Class	   = 'Spinner'
			.Width     = 45
			.cTool	   = [Thor]
			.cKey	   = ccRunThorInterval
			.Row-Increment = 0
			.Top       = (.Top - 4)
			
		ENDTEXT

		loRenderEngine.Render(This, [Thor])

	Endproc

Enddefine

