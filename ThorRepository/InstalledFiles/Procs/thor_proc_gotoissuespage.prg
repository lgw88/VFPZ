Lparameters lcToolName
Local lcLink, lcProjectName, lcSourceURL, lcURL, loThorUtils, loTool

lcSourceURL = 'https://github.com/VFPX/<<lcProjectName>>/issues'

loThorUtils	= Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Utils')
loTool		= Execscript (_Screen.cThorDispatcher, 'ToolInfo=', m.lcToolName)
lcLink		= m.loTool.Link

Do Case

		* No tool supplied, default to Thor Repo
	Case Isnull(m.loTool)
		lcProjectName = 'ThorRepository'

	Case 'github' $ Lower(m.lcLink) And Not Right(Lower(m.lcLink), 3) = '.md'
		lcSourceURL = m.lcLink + '/issues'

		* new style: tool has property 'AppID', which indicates project the tool is from
	Case Pemstatus(m.loTool, 'AppID', 5) And Not Empty(m.loTool.AppID)
		lcProjectName = Alltrim(m.loTool.AppID)

		* old style: .AppName = 'PEMEditor.App'
	Case Atc('pemeditor', m.loTool.AppName) # 0
		lcProjectName = 'PEMEditor'

		* old style: .AppName = 'Gofish5/app'
	Case Atc('gofish', m.loTool.AppName) # 0
		lcProjectName = 'GoFish'

		* default to Thor Repo
	Otherwise
		lcProjectName = 'ThorRepository'

Endcase

lcURL = Textmerge(m.lcSourceURL)

m.loThorUtils.GoURL(m.lcURL)
