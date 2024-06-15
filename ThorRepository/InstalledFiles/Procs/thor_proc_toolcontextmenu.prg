Lparameters lcToolName

#Define CR               	Chr(13)
#Define LF               	Chr(10)
#Define CRLF             	Chr(13)+Chr(10)
#Define Tab				    Chr(9)

Local laHotKey[1], lcFileName, lcKeyWord, lcToolFolder, lcType, llResult, lnSelect, loCloseTemps
Local loThorUtils, loTool

lnSelect = Select()

loThorUtils  = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Utils')

loCloseTemps = m.loThorUtils.CloseTempFiles() && will close any tables opened after
m.loThorUtils.OpenThorTables()

lcToolName	 = Juststem(m.lcToolName)
loTool		 = Execscript (_Screen.cThorDispatcher, 'ToolInfo=', m.lcToolName)
lcToolFolder = Upper(_Screen.cThorFolder + 'Tools')
lcFileName	 = Execscript(_Screen.cThorDispatcher, 'Full Path=' + m.lcToolName)

Do Case
	Case Not File(Addbs(m.lcToolFolder) + Forceext(m.lcToolName, 'prg'))
		lcType = 'Private'
	Case m.lcToolFolder == Upper(Justpath(m.lcFileName))
		lcType = 'Published'
	Otherwise
		lcType = 'Custom'
Endcase
m.loTool.AddProperty('PublishType', m.lcType)

lcKeyWord = RunContextMenu(Forceext(m.lcToolName, 'prg'), m.loTool)
Do Case
	Case Empty(m.lcKeyWord) && we got nothing to do

	Case m.lcKeyWord = 'Run'
		loCloseTemps = Null && close all our tables first
		RunTool(m.lcToolName)
		llResult = .F.
	Otherwise
		llResult = ProcessKeyword(m.lcKeyWord, m.lcToolName, m.loTool, m.loThorUtils)
Endcase

Return Execscript(_Screen.cThorDispatcher, 'Result=', m.llResult)

Endproc


* ================================================================================
* ================================================================================
Procedure RunContextMenu(lcToolName, loTool)

	Local laHotKey[1], lcHotKey, lcKeyWord, lcTool, loContextMenu

	loContextMenu = Execscript (_Screen.cThorDispatcher, 'class= Contextmenu')
	lcTool		  = [tool '] + Alltrim(m.loTool.Prompt) + [']

	With m.loContextMenu

		* ================================================================================

		.AddMenuItem('\<Help', , 'Show documentation for ' + m.lcTool + ' (web page if available)', , 'URL')

		If File(_Screen.cThorFolder + 'Tools\' + Forceext(m.lcToolName, 'prg'))
			.AddMenuItem('\<Bug Reports / Suggestions', , 'Go to issues page (in GitHub) to report bugs or suggestions' + m.lcTool, , 'Issues')
		Endif

		If Not Empty(m.loTool.VideoLink)
			.AddMenuItem('\<Video', , 'Start video for ' + m.lcTool, , 'Video')
		Endif

		If Not Empty(Evl(m.loTool.OptionTool, '') + Evl(m.loTool.PlugIns, ''))

			.AddMenuItem()
			If Not Empty(m.loTool.OptionTool)
				.AddMenuItem('\<Options', , 'Open options page in Thor Configuration form for ' + m.lcTool, , 'Options')
			Endif

			If Not Empty(m.loTool.PlugIns)
				.AddMenuItem('\<Plug-Ins', , 'Modify Plug-ins for ' + m.lcTool, , 'Plug-Ins')
			Endif
		Endif

		.AddMenuItem()
		Select  Descript																;
			From ToolHotKeyAssignments													;
				Join HotKeyDefinitions													;
					On     ToolHotKeyAssignments.HotKeyID = HotKeyDefinitions.Id		;
			Where Upper(PRGName) = Upper(m.lcToolName)									;
				And HotKeyID # 0														;
			Into Array laHotKey

		If Empty(m.laHotKey)
			.AddMenuItem('\<Assign hot key', , , , 'SetHotKey')
		Else
			lcHotKey = Chrtran(Alltrim(m.laHotKey), '-', '+')
			.AddMenuItem('\<Re-assign hot key (is ' + m.lcHotKey + ')', , , , 'SetHotKey')
			.AddMenuItem('\<Clear hot key (is ' + m.lcHotKey + ')', , , , 'ClearHotKey')
		Endif

		.AddMenuItem()

		.AddMenuItem('\<Favorite', , 'Mark ' + m.lcTool + ' as a favorite?  These show as bold in Thor menus.', , 'Favorite', , GetStatus('Favorites', 'StartUp', m.lcToolName))

		.AddMenuItem('Start \<Up', , 'Run ' + m.lcTool + ' when Thor starts? (appropriate for few tools)', , 'Start Up', , GetStatus('StartupTools', 'StartUp', m.lcToolName))

		.AddMenuItem('\<Toolbar', , 'Modify Thor toolbar for ' + m.lcTool, , 'ToolBar', , GetStatus('ToolBarTools', 'Enabled', m.lcToolName))

		.AddMenuItem()

		Do Case
			Case m.loTool.PublishType = 'Custom'
				.AddMenuItem('Edit Custom Version', , , , 'Edit')
				.AddMenuItem('Open \<Installation Folder', , 'Open Installation Folder for this tool', , 'FolderName')
				.AddMenuItem('Delete Custom Version', , , , 'DeleteTool')
				.AddMenuItem('View Published Version (Read-Only)', , , , 'Original')
				.AddMenuItem('Compare Versions', , , , 'CompareTools')

			Case m.loTool.PublishType = 'Private'
				.AddMenuItem('Edit Private Version', , , , 'Edit')
				.AddMenuItem('Open \<Installation Folder', , 'Open Installation Folder for this tool', , 'FolderName')
				.AddMenuItem('Delete Private Version', , , , 'DeleteTool')

			Case Type('GoVars.UserNumber') = 'N' And GoVars.UserNumber = 63 && back door for Jim
				.AddMenuItem('Edit Published Version', , , , 'Edit')
				.AddMenuItem('Create Custom Version', , , , 'CreateCustom')

			Otherwise
				.AddMenuItem('View Published Version (Read-Only)', , , , 'Original')
				.AddMenuItem('Create Custom Version', , , , 'CreateCustom')

		Endcase

		.AddMenuItem()
		.AddMenuItem('\<Run', , , , 'Run')

		* ================================================================================

		If .Activate()
			lcKeyWord = .KeyWord
		Else
			lcKeyWord =  .F.
		Endif

	Endwith && m.loContextMenu

	Return m.lcKeyWord

Endproc


* ================================================================================
* ================================================================================
Procedure ProcessKeyword(lcKeyWord, lcToolName, loTool, loThorUtils)
	Local llNewValue, llRefreshThor

	Do Case

		Case m.lcKeyWord == 'URL'
			Execscript(_Screen.cThorDispatcher, 'Thor_proc_showtoolhelp', m.lcToolName)

		Case m.lcKeyWord == 'Issues'
			GoToIssuesPage(lcToolName)

		Case m.lcKeyWord == 'FolderName'
			ExecScript(_Screen.cThorDispatcher, 'Thor_Proc_OpenFolder', JustPath(ThorFileName(m.lcToolName)))

		Case m.lcKeyWord == 'Video'
			m.loThorUtils.GoURL(m.loTool.VideoLink)

		Case m.lcKeyWord == 'Options'
			EditOptions(m.loTool)

		Case m.lcKeyWord == 'Plug-Ins'
			ManagePlugIns(m.loTool)

		Case m.lcKeyWord == 'SetHotKey'
			SetHotKey(m.lcToolName, 'Set')
			llRefreshThor = .T.

		Case m.lcKeyWord == 'ClearHotKey'
			ClearHotKey(m.lcToolName)
			llRefreshThor = .T.

		Case m.lcKeyWord == 'ToolBar'
			EditToolBar(m.lcToolName, m.loTool)
			llRefreshThor = .T.

		Case m.lcKeyWord == 'Favorite'
			llNewValue	  = ToggleStatus('Favorites', 'StartUp', m.lcToolName)
			llRefreshThor = .T.

		Case m.lcKeyWord == 'Start Up'
			llNewValue = ToggleStatus('StartupTools', 'StartUp', m.lcToolName)
			Return .T. && changed, but no need to refresh

		Case m.lcKeyWord == 'Edit'
			EditTool(m.lcToolName, m.loThorUtils)

		Case m.lcKeyWord == 'CompareTools'
			CompareTools(m.lcToolName, m.loThorUtils)

		Case m.lcKeyWord == 'Original'
			EditOriginalTool(m.lcToolName, m.loThorUtils)

		Case m.lcKeyWord == 'DeleteTool'
			DeleteTool(m.lcToolName, m.loThorUtils, m.loTool)

		Case m.lcKeyWord == 'CreateCustom'
			CreateCustomTool(m.lcToolName, m.loThorUtils)

	Endcase

	If m.llRefreshThor
		m.loThorUtils.WaitWindow('Refreshing Thor hotkeys and menus')
		RefreshThor()
		Wait Clear
		Return .T.
	Else 
		Return .F.
	Endif

Endproc



* ================================================================================
* ================================================================================
Procedure GoToIssuesPage(lcToolName)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_GoToIssuesPage', lcToolName)
Endproc


* ================================================================================
* ================================================================================
Procedure RunTool(lcToolName)
	Execscript(_Screen.cThorDispatcher, m.lcToolName) 
Endproc


* ================================================================================
* ================================================================================
Procedure EditTool(lcToolName, loThorUtils)
	Local lcFullFileName

	lcFullFileName = ThorFileName(m.lcToolName)
	Modify Command (m.lcFullFileName) Nowait
	MoveWindow(m.lcFullFileName)
	AddMRU(m.lcFullFileName)
Endproc


* ================================================================================
* ================================================================================
Procedure DeleteTool(lcToolName, loThorUtils, loTool)
	Local lcFileName, lcFullFileName, lcParent, lcRelative, llCustom

	lcFullFileName = ThorFileName(m.lcToolName)
	lcRelative	   = ParentFolder(m.lcFullFileName)
	If Messagebox('Delete tool "' + Trim(m.loTool.Prompt) + '"' + CR + 'from folder "' + m.lcRelative + '"?', 3 + 32) = 6
		Erase(m.lcFullFileName)
	Endif
Endproc


* ================================================================================
* ================================================================================
Procedure CompareTools(lcToolName, loThorUtils)
	Local lcCustomFileName, lcPublFileName

	lcCustomFileName = ThorFileName(m.lcToolName)
	lcPublFileName	 = _Screen.cThorFolder + 'Tools\' + ForceExt(Trim(m.lcToolName), 'prg')
	Execscript(_Screen.cThorDispatcher, 'Thor_Proc_CompareFiles', m.lcCustomFileName, m.lcPublFileName)
Endproc


* ================================================================================
* ================================================================================
Procedure CreateCustomTool(lcToolName, loThorUtils)
	Local lcClipText, lcFullFileName, lcFullFilePath, lcPrivateFile, lcToolFolder, loEditorWin, loTools

	loTools		   = Execscript (_Screen.cThorDispatcher, 'class= tools from pemeditor')
	lcFullFileName = ThorFileName(m.lcToolName)
	lcFullFilePath = Upper (Addbs (Justpath (m.lcFullFileName)))
	lcToolFolder   = Execscript (_Screen.cThorDispatcher, 'Tool Folder=')

	lcPrivateFile = Forcepath (m.lcFullFileName, m.lcToolFolder + 'My Tools\')
	Modify Command (m.lcPrivateFile) Nowait

	lcClipText = Filetostr (m.lcFullFileName)
	* editorwin home page = http://vfpx.codeplex.com/wikipage?title=thor%20editorwindow%20object
	loEditorWin = Execscript(_Screen.cThorDispatcher, 'Thor_Proc_EditorWin')
	m.loEditorWin.Paste (m.lcClipText)
	m.loEditorWin.SetInsertionPoint(0)

	MoveWindow(m.lcPrivateFile)
	AddMRU(m.lcPrivateFile)

Endproc


* ================================================================================
* ================================================================================
Procedure EditOriginalTool(lcToolName, loThorUtils)
	Local lcFullFileName

	lcFullFileName = _Screen.cThorFolder + 'Tools\' + Trim(m.lcToolName)
	Modify Command (m.lcFullFileName) Nowait Noedit
	MoveWindow(m.lcFullFileName)
	AddMRU(m.lcFullFileName)
Endproc


* ================================================================================
* ================================================================================
Procedure MoveWindow(lcFileName)
	Execscript (_Screen.cThorDispatcher, 'PEMEditor_StartIDETools')
	_oPEMEditor.oUtils.oIDEx.MoveWindow()
Endproc


* ================================================================================
* ================================================================================
Procedure AddMRU(lcFile, lcClass)

	Local loTools
	loTools = Execscript (_Screen.cThorDispatcher, 'class= tools from pemeditor')
	m.loTools.AddMRUFile(m.lcFile)
	If Pcount() > 1
		m.loTools.AddMRUFile(m.lcFile, m.lcClass)
	Endif

Endproc


* ================================================================================
* ================================================================================
Procedure GetStatus(lcTable, lcField, lcPRGName)
	Local laStatus[1]

	Select  &lcField														;
		From &lcTable														;
		Where Upper(PRGName) =  Upper(Forceext(m.lcPRGName, 'PRG'))			;
		Into Array laStatus
	Return m.laStatus
	Return
Endproc


* ================================================================================
* ================================================================================
Procedure EditOptions(loTool)
	Execscript(_Screen.cThorDispatcher, 'Thor_Proc_OpenOptionsPage', Trim(m.loTool.OptionTool))
Endproc


* ================================================================================
* ================================================================================
Procedure ManagePlugIns(loTool)
	Local lcFileName

	lcFileName = ThorFileName('Thor_Tool_ThorInternalManagePlugIns.SCX')
	Do Form  (m.lcFileName) With m.loTool.PlugIns
Endproc


* ================================================================================
* ================================================================================
Procedure ToggleStatus(lcTable, lcField, lcPRGName)

	Local llNewValue

	lcPRGName = Upper(Forceext(m.lcPRGName, 'prg'))
	Select &lcTable
	Locate For Upper(PRGName) = m.lcPRGName
	If Found()
		llNewValue = Not &lcField
		Replace &lcField With m.llNewValue
	Else
		llNewValue = .T.
		Insert Into &lcTable (PRGName, &lcField) Values (m.lcPRGName, m.llNewValue)
	Endif
	Return m.llNewValue
Endproc


* ================================================================================
* ================================================================================
Procedure EditToolBar(lcToolName, loTool)
	Local lcAlias, llContinue, lnSelect
	Local poToolBarTools

	lcAlias = 'ToolBarTools'

	Select (m.lcAlias)
	Locate For Upper(PRGName) = Upper(m.lcToolName)
	If Found()
		llContinue = .T.
	Else
		llContinue = Messagebox('Create toolbar entry for this tool?', 3 + 32 + 256) = 6
		If m.llContinue
			Insert Into (m.lcAlias)							;
				(PRGName, Caption, ToolTip, Enabled)		;
				Values										;
				(m.lcToolName, m.loTool.Prompt, m.loTool.Description, .T.)
		Endif
	Endif

	If m.llContinue
		poToolBarTools = EditToolBarItem()
		If Not Isnull(m.poToolBarTools)
			Select (m.lcAlias)
			Gather Name m.poToolBarTools Fields Except Id
		Endif
	Endif

Endproc


* ================================================================================
* ================================================================================
Procedure EditMenuCaption(loThisTable)
	Local lcAlias, lnMenuID, lnSelect
	Local poMenuTools
	lnSelect = Select()
	lnMenuID = Id

	lcAlias = 'MenuTools'

	Select (m.lcAlias)
	Locate For Id = m.lnMenuID

	If Found()

		poMenuTools = EditMenuItem()
		If Not Isnull(m.poMenuTools)
			Select (m.lcAlias)
			Gather Name m.poMenuTools Memo Fields Except Id
			Select (m.lnSelect)
			Replace	ToolName	 With  m.poMenuTools.Prompt,		;
					Description	 With  m.poMenuTools.StatusBar
		Endif
	Else
		Messagebox('Internal error -- menu item not found')
	Endif
	Select (m.lnSelect)
Endproc



* ================================================================================
* ================================================================================
Procedure SetHotKey(tcToolName, lcAction)

	Local loForm As 'SetHotKeyForm' Of 'Thor_UI.vcx'
	Local lcAlias, lcHotKey, lcThorAPP, lcToolName

	lcAlias	   = 'ToolHotKeyAssignments'
	lcToolName = Forceext(m.tcToolName, 'prg')

	Select (m.lcAlias)
	Locate For Upper(PRGName) = Upper(m.lcToolName)

	If Not Found()
		Insert Into (m.lcAlias) (PRGName) Values (m.lcToolName)
	Endif

	lcThorAPP	 = _Screen.cThorFolder + '..\Thor.app'
	loForm		 = Newobject ('SetHotKeyForm',	'Thor_UI.vcx', 	m.lcThorAPP)
	loForm.oThor = Newobject ('Thor_Engine',	'Thor.vcx', 	m.lcThorAPP, _Screen.cThorFolder)

	m.loForm.ExecuteCommand (m.lcAlias, m.lcAction)
	lcHotKey = m.loForm.HotKeyControls1.txtHotKey.Value
	m.loForm.Release()
	loForm = .Null.

Endproc


* ================================================================================
* ================================================================================
Procedure ClearHotKey(lcToolName)

	Replace	PRGName	  With	''			;
			HotKeyID  With	0			;
		In ToolHotKeyAssignments		;
		For Upper(PRGName) = Upper(m.lcToolName)

Endproc


* ================================================================================
* ================================================================================
Procedure RefreshThor
	Local loThor As 'clsRunThor'

	loThor = Newobject('clsRunThor')
	m.loThor.Run()
Endproc


* ================================================================================
* ================================================================================
Procedure ThorFileName(lcFileName)
	Return Execscript(_Screen.cThorDispatcher, 'Full Path=' + Alltrim(m.lcFileName))
Endproc


* ================================================================================
* ================================================================================
Procedure ParentFolder(lcFileName)
	Return Juststem(Justpath(m.lcFileName))
Endproc


* ================================================================================
* ================================================================================

Procedure EditToolBarItem
	Private poToolBarTools

	Local loForm, loResult
	Scatter Name m.poToolBarTools

	loForm	= Execscript(_Screen.cThorDispatcher, 'Class= DynamicForm')

	With m.loForm
		.Caption	 = 'Edit Toolbar Item'
		.MinWidth	 = 700
		.MinButton	 = .F.
		.MaxButton	 = .F.
		.MaxHeight	 = 180
		.MinHeight	 = 180
		.BorderStyle = 3
		.Height		 = 150
	Endwith

	Text To m.loForm.cBodyMarkup Noshow Textmerge
	poToolBarTools.Caption	
				.class 				= 'TextBox'
				.caption 		    = 'Caption'
				.Left				= 100
				.Width				= 200
	|
	poToolBarTools.Tooltip	
				.class 				= 'TextBox'
				.caption 		    = 'ToolTip'
				.Left				= 100
				.Width				= 700
				.Anchor 			= 10
	|
	poToolBarTools.Enabled	
				.class 				= 'CheckBox'
				.caption 		    = 'Enabled'
				.Left				= 100
				.Width				= 400
	Endtext

	If ShowDynamicForm(m.loForm)
		loResult =  m.poToolBarTools
	Else
		loResult =  Null
	Endif

	loForm = Null
	Return m.loResult

Endproc


* ================================================================================
* ================================================================================

Procedure EditMenuItem
	Private poMenuTools

	Local loForm, loResult
	Scatter Name m.poMenuTools Memo
	loForm	= Execscript(_Screen.cThorDispatcher, 'Class= DynamicForm')

	With m.loForm
		.Caption	 = 'Edit Menu Item'
		.MinWidth	 = 700
		.MinButton	 = .F.
		.MaxButton	 = .F.
		.MaxHeight	 = 180
		.MinHeight	 = 180
		.BorderStyle = 3
		.Height		 = 150
	Endwith

	Text To m.loForm.cBodyMarkup Noshow Textmerge
	poMenuTools.Prompt	
				.class 				= 'TextBox'
				.caption 		    = 'Menu Caption'
				.Left				= 100
				.Width				= 600
	|
	poMenuTools.Statusbar	
				.class 				= 'TextBox'
				.caption 		    = 'Status bar tip'
				.Left				= 100
				.Width				= 600
				.Anchor 			= 10

	Endtext

	If ShowDynamicForm(m.loForm)
		loResult =  m.poMenuTools
	Else
		loResult =  Null
	Endif

	loForm = Null
	Return m.loResult

Endproc


* ================================================================================
* ================================================================================

Procedure ShowDynamicForm(loDynamicForm)

	m.loDynamicForm.Render()

	m.loDynamicForm.Show(1) &&, _Screen.ActiveForm)

	If 'O' = Vartype(m.loDynamicForm) And m.loDynamicForm.lSaveClicked
		m.loDynamicForm.Release()
		Return .T.
	Else
		Return .F.
	Endif

Endproc


* ================================================================================
* ================================================================================
Define Class clsRunThor As Session

	Procedure Run
		Local loRunThor As 'Thor_Run' Of 'thor_run.vcx'
		Local lcApp, lcFolder, lcThorFolder

		lcThorFolder  = _Screen.cThorFolder + '..\'

		lcApp	  = m.lcThorFolder + 'Thor.App'
		lcFolder  = m.lcThorFolder + 'Thor\'
		loRunThor = Newobject ('Thor_Run', 'thor_run.vcx', m.lcApp, m.lcApp, m.lcFolder)
		m.loRunThor.AddProperty('cApplication', m.lcApp)
		m.loRunThor.Run(.T.) && but no startups
	Endproc

	Procedure Destroy
		Close Tables
	Endproc

Enddefine
