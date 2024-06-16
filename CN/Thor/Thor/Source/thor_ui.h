#include Thor.H
#include Thor_English.H

* Windows event handling constants.

#define WM_KEYUP				0x0101
#define WM_SYSKEYUP				0x0105

* TreeView constants.

#define cnROOT_NODE				0
#define cnCHILD_NODE			4

* Menu constants.

#define ccKEY_ROOT_SYSTEM_MENU	'VFP'
#define ccKEY_ROOT_POPUP_MENU	'POPUP'

* Other constants.

#define ccSEPARATOR_PROMPT		'----------------------'
#define ccKEY_MENU				'M'
#define ccKEY_TOOL				'T'
#define ccKEY_SEPARATOR			'\'
#define ccIMAGE_MENU			'Menu'
#define ccIMAGE_TOOL			'Tool'
#define ccIMAGE_POPUP			'Popup'

#IF Version(3) = [86]
	#Define ThorHelpURL 			'https://github.com/vfp9/Thor_CN/blob/master/Docs/Thor_help.md'
	#Define ThorFrameworkURL 		'https://github.com/vfp9/Thor_CN/blob/master/Docs/Thor_repository.md'
#ELSE
	#Define ThorHelpURL 			'https://github.com/VFPX/Thor/blob/master/Docs/Thor_help.md'
	#Define ThorFrameworkURL 		'https://github.com/VFPX/Thor/blob/master/Docs/Thor_repository.md'
#ENDIF 

#Define 	ccRunAllTools		'Thor_Run_Tools'

#Define     cnDefaultMissingBackColor RGB(255,0,0)
#Define     cnDefaultMissingForeColor RGB(255,255,255)

#Define     cnDefaultPrivateBackColor RGB(255,255,0)
#Define     cnDefaultPrivateForeColor RGB(255,0,0)

#Define     cnDefaultPersonalBackColor RGB(255,255,0)
#Define     cnDefaultPersonalForeColor RGB(0,0,0)

#Define ccThorIcon 'Thor16.png'

#IF Version(3) = [86]
	#Define ccCaption																			[输入标题]
	#Define ccPicture 																			[选择图片]
	#Define ccDefault 																			[默认(Thor 图标)]

	#Define ccTool 																				[Thor]
	#Define ccKey 																				[Thor 工具栏路径]

	* Add by JingChun Niu  2018.04.09

	#Define _Thor_Main_Install1Desc_loc															[请使用 Thor 论坛提出您的问题，意见等 - ]
	#Define _Thor_Main_Install2Desc_loc															[        从主 Thor 菜单选择 社区->Thor]
	#Define _Thor_Main_InstallMsgTitle_loc														[Thor 帮助和社区]
	#Define _Thor_Main_Installed_loc															[ 已安装]
	#Define _Thor_Main_InstallationComplete_loc													[安装完成]

	#Define _Thor_Main_Menu_File_loc															[文件]
	#Define _Thor_Main_Menu_Edit_loc															[编辑]
	#Define _Thor_Main_Menu_View_loc															[视图]
	#Define _Thor_Main_Menu_Tools_loc															[工具]
	#Define _Thor_Main_Menu_Program_loc															[程序]
	#Define _Thor_Main_Menu_Window_loc															[窗口]
	#Define _Thor_Main_Menu_Help_loc															[帮助]
	#Define _Thor_Main_Menu_ThorTools_loc														[Tho\<r 工具]
	#Define _Thor_Main_Menu_More_loc															[更多内容]
	#Define _Thor_Main_Menu_Thor_StatusBar_loc													[配置Thor，访问帮助页面，Thor 框架和 Thor 讨论组; 运行检查更新]
	#Define _Thor_Main_Menu_ThorTools_StatusBar_loc												[运行所有 Thor 工具]

	#Define _Thor_Main_PopupMenu_Launcher_loc													[启动器]
	#Define _Thor_Main_PopupMenu_Launcher_Status_loc											[查找和运行工具，浏览描述等]
	#Define _Thor_Main_PopupMenu_Configure_loc													[配置]
	#Define _Thor_Main_PopupMenu_Configure_Status_loc											[指定快捷键，创建菜单和子菜单等。]
	#Define _Thor_Main_PopupMenu_CheckForUpdates_loc											[检查更新]
	#Define _Thor_Main_PopupMenu_CheckForUpdates_Status_loc										[检查并安装任何未完成的更新]
	#Define _Thor_Main_PopupMenu_ThorNews_loc													[Thor 新闻]
	#Define _Thor_Main_PopupMenu_ThorNews_Status_loc											[所有关于 Thor 和 Thor 工具的最新最好的新闻。]
	#Define _Thor_Main_PopupMenu_ThorTWEeTs_loc													[Thor 推文]
	#Define _Thor_Main_PopupMenu_ThorTWEeTs_Status_loc											[所有 Thor 推文的历史(本周的优秀工具]
	#Define _Thor_Main_PopupMenu_Forums_loc														[社区]
	#Define _Thor_Main_PopupMenu_Blogs_loc														[博客]
	#Define _Thor_Main_PopupMenu_VFPxHomePage_loc												[VFPX 项目主页]
	#Define _Thor_Main_PopupMenu_VFPxHomePage_Status_loc										[Thor 帮助]
	#Define _Thor_Main_PopupMenu_ThorVideos_loc													[Thor 视频]
	#Define _Thor_Main_PopupMenu_ManagePlugIns_loc												[管理插件]
	#Define _Thor_Main_PopupMenu_ManagePlugIns_Status_loc										[通过使用一些工具管理 PRGs 插件]
	#Define _Thor_Main_PopupMenu_OpenFolder_loc													[打开文件夹]
	#Define _Thor_Main_PopupMenu_OpenFolder_Status_loc											[打开各种 Thor 文件夹]
	#Define _Thor_Main_PopupMenu_UsageSummary_loc												[Thor 使用摘要]
	#Define _Thor_Main_PopupMenu_UsageSummary_Status_loc										[Thor 工具的使用摘要]
	#Define _Thor_Main_PopupMenu_ThorFrameWork_loc												[Thor 框架]
	#Define _Thor_Main_PopupMenu_ThorFrameWork_Status_loc										[帮助创建工具的工具框架]
	#Define _Thor_Main_PopupMenu_DebugMode_loc													[调试模式]
	#Define _Thor_Main_PopupMenu_DebugMode_Status_loc											[在 Thor 和 IDE 工具运行时切换到调试模式]
	#Define _Thor_Main_PopupMenu_ChangeLogs_loc													[Thor 更新历史]
	#Define _Thor_Main_PopupMenu_ThorERs_loc													[Thor 错误提交]

	#Define _Thor_Main_Remove_SourceFiles_loc													[源文件]
	#Define _Thor_Main_Remove_SourceFiles_Status_loc											[下载 APPs 的源文件]
	#Define _Thor_Main_Remove_RunTool_loc														[运行工具]
	#Define _Thor_Main_Remove_RunTool_Status_loc												[所有已在 Thor 注册的工具]
	#Define _Thor_Main_Remove_ModifyTool_loc													[编辑工具]
	#Define _Thor_Main_Remove_ModifyTool_Status_loc												[使用 Modify Command 打开工具]
	#Define _Thor_Main_Remove_PlugIns_loc														[管理插件]
	#Define _Thor_Main_Remove_PlugIns_Status_loc												[通过使用一些工具管理 PRGs 插件]
	#Define _Thor_Main_Remove_Community_loc														[社区/讨论]
	#Define _Thor_Main_Remove_Community_Status_loc												[讨论Thor，Thor 仓库和相关主题的社区。]
	#Define _Thor_Main_Remove_OpenFolder_loc													[打开文件夹]
	#Define _Thor_Main_Remove_OpenFolder_Status_loc												[打开各种 Thor 文件夹]
	#Define _Thor_Main_Remove_FrameWork_loc														[Thor 框架]
	#Define _Thor_Main_Remove_FrameWork_Status_loc												[帮助创建工具的工具框架]
	#Define _Thor_Main_Remove_Debug_loc															[调试模式]
	#Define _Thor_Main_Remove_Debug_Status_loc													[在 Thor 和 IDE 工具运行时切换到调试模式]
	#Define _Thor_Main_Removre_RepositoyHomePage_loc											[仓库主页]
	#Define _Thor_Main_Remove_RepositoyHomePage_Status_loc										[Thor 仓库主页]
	#Define _Thor_Main_Remove_ToolHomePage_loc													[Tool 主页]
	#Define _Thor_Main_Remove_ToolHomePage_Status_loc											[各种工具的主页（如果存在）]

	#Define _Thor_Main_ThorInternalAllTools_Prompt_loc											[所有 Thor 工具]
	#Define _Thor_Main_ThorInternalAllTools_Description_loc										[所有在 Thor 注册的工具的菜单]

	#Define _Thor_Main_ThorInternalEdit_Prompt_loc												[编辑 Thor]
	#Define _Thor_Main_ThorInternalEdit_Summary_loc												[Thor 表单]
	#Define _Thor_Main_ThorInternalEdit_Description_loc											[打开主Thor表单：为工具指定快捷键，创建弹出菜单并为其指定快捷键，修改VFP系统菜单等。]
	#Define _Thor_Main_ThorInternalFrameWork_Prompt_loc											[框架]
	#Define _Thor_Main_ThorInternalFrameWork_Description_loc									[帮助创建工具的工具框架]
	#Define _Thor_Main_ThorInternalFrameWork_Display_loc										[ *   Thor 框架主页 ]
	#Define _Thor_Main_ThorInternalFrameWork_Display2_loc										[ 外部 APPs ]
	#Define _Thor_Main_ThorInternalFrameWork_Display3_loc										[ 主页 = ]
	#Define _Thor_Main_ThorInternalFrameWork_Display4_loc										[* 内部 *]

	#Define _Thor_Main_ThorInternalFrameworkHelp_Prompt_loc										[Thor 框架帮助]
	#Define _Thor_Main_ThorInternalFrameworkHelp_Description_loc								[链接到 Thor 主页]

	#Define _Thor_Main_ThorInternalManagePlugIns_Prompt_loc										[管理 PRGs 插件]

	#Define _Thor_Main_ThorInternalManagePlugIns_ToolCode_Msg_loc								[Thor 没有激活；此工具需要 Thor 先启动]
	#Define _Thor_Main_ThorInternalManagePlugIns_ToolCode_MsgTitle_loc							[Thor 没有激活]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_PlugIn_loc			[组件安装前]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_Description_loc		[在检查更新期间安装组件之前（在Thor \ Tools \ Components的子文件夹中）调用。]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_Tools_loc			[检查更新]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_PlugIn_loc			[组件安装后]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_Description_loc		[在检查更新期间安装组件后（在Thor \ Tools \ Components的子文件夹中）调用。]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_Tools_loc				[检查更新]

	#Define _Thor_Main_ThorInternalModifyTool_Prompt_loc										[编辑工具]
	#Define _Thor_Main_ThorInternalModifyTool_Description_loc									[使用 Modify Command 打开工具]

	#Define _Thor_Main_ThorInternalRepository_Prompt_loc										[Thor 仓库的所有工具]
	#Define _Thor_Main_ThorInternalRepository_Description_loc									[在Thor 仓库中注册的所有工具的菜单]

	#Define _Thor_Main_ThorInternalRepositoryHomePage_Prompt_loc								[链接到 Thor 仓库]
	#Define _Thor_Main_ThorInternalRepositoryHomePage_Description_loc							[链接到 Thor 仓库主页]

	#Define _Thor_Main_ThorInternalRunTool_Prompt_loc											[工具启动器]
	#Define _Thor_Main_ThorInternalRunTool_Description_loc										[查找和运行工具，浏览描述，设置选项等]

	#Define _Thor_Main_thorinternalthornews_Prompt_loc											[Thor 新闻]
	#Define _Thor_Main_thorinternalthornews_Description_loc										[关于 Thor 的新闻头条]
	#Define _Thor_Main_thorinternalthornews_GetForumNames_Forums_loc							[动态表单]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs1_loc					[PEM 编辑器]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs2_loc					[Thor 仓库]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs3_loc					[VFPX 项目]
	#Define _Thor_Main_thorinternalthornews_ToolCode_Msg_loc									[没有找到互联网连接！]
	#Define _Thor_Main_thorinternalthornews_ToolCode_MsgTitle_loc								[没有互联网连接]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_Label1_Caption_loc						[检查 Thor 新闻的更新：]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_CheckBox1_Caption_loc					[在运行检查更新之后]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_CheckBox2_Caption_loc					[在运行 RunThor 之后]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_Label2_Caption_loc						[检查间隔的天数：]

	#Define _Thor_Main_ThorInternalToolLink_Prompt_loc											[工具主页]
	#Define _Thor_Main_ThorInternalToolLink_Description_loc										[工具主页菜单用于访问任意工具的主页或描述]

	#Define _Thor_Main_THORINTERNALTWEETS_Prompt_loc											[Thor 推文]
	#Define _Thor_Main_THORINTERNALTWEETS_Description_loc										[Thor 推文主页]

	#Define _Thor_Main_THORINTERNALUSAGESUMMARY_Prompt_loc										[Thor 使用摘要]
	#Define _Thor_Main_THORINTERNALUSAGESUMMARY_Description_loc									[Thor 工具的使用摘要]

	#Define _Thor_Main_ThorCommunity_Prompt_loc													[社区/讨论]
	#Define _Thor_Main_ThorCommunity_Description_loc											[链接到讨论关于 Thor 内容的主页]

	#Define _Thor_Main_CheckInternetConnection_Pass_loc											[互联网连接测试通过。]
	#Define _Thor_Main_CheckInternetConnection_Failed_loc										[互联网连接测试失败！]

	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_Begin_loc								[开始 CFU - ]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_CheckForUpdate_loc						[检查 Thor 更新]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXP_loc							[正在删除 FXP 文件...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXPFromThor_loc					[正在从 Thor Procs 文件夹删除 Thor FXP 文件...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXPFromMY_loc						[正在从 Thor MyTools 文件夹删除 Thor FXP 文件...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_Processing_loc							[正在处理 (]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ThorUpdaePro_loc						[) Thor 更新程序...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_CheckForAllOtherApp_loc				[检查所有其他 APPs 更新]

	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_GetListOfUpdate_loc				[正在获取更新列表]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Abort_loc						[正在中止...找不到更新列表]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Exit_loc							[正在退出...未选择更新]
	#Define _Thor_Main_DownloadAndInstallUpdates_Msg_loc										[更新完成]
	#Define _Thor_Main_DownloadAndInstallUpdates_MsgTitle_loc									[Thor 更新...]
	#Define _Thor_Main_DownloadAndInstallUpdates_GetVersionInfo_loc								[获取可用的版本信息 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo1_loc									[准备安装 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo2_loc									[ 更新(s):]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo3_loc									[要执行更新，CLEAR ALL 和 CLOSE ALL 命令必须运行。]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo4_loc									[你希望继续？]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo5_loc									[允许 CLEAR ALL 等？]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status1_loc									[可用更新]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status2_loc									[新项目]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status3_loc									[当前]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status4_loc									[最近更新]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status5_loc									[没有安装]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Downloading_loc					[正在下载和安装所选更新]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_AttemptDown_loc					[尝试下载 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_DownloadFailed_loc				[下载失败; 尝试备用下载 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_CopyZIP_loc						[复制压缩文件 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Download_loc						[下载 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Install_loc						[安装 ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_Updated_loc							[ ... 已更新]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_Failed_loc								[********** 失败： ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_See_loc								[********** 参看 ]

	#Define _Thor_Main_Error_loc																[错误： ]
	#Define _Thor_Main_Message_loc																[信息： ]
	#Define _Thor_Main_Proc_loc																	[过程： ]
	#Define _Thor_Main_Line_loc																	[行： ]
	#Define _Thor_Main_Code_loc																	[代码： ]
	#Define _Thor_Main_ErrorTitle_loc															[错误]

	#Define _Thor_Main_DownloadFileFromURL_Contacting_loc										[正在连接服务器.... 请等待。]
	#Define _Thor_Main_DownloadFileFromURL_ExpandingBitlyLink_loc								[展开 bitly 链接 【]
	#Define _Thor_Main_DownloadFileFromURL_URLIsEmpty_loc										[所请求的 URL 是一个空字符串。]
	#Define _Thor_Main_DownloadFileFromURL_SessionCanNot_loc									[互联网会话无法建立]
	#Define _Thor_Main_DownloadFileFromURL_RequestFile_loc										[正在请求文件 ]
	#Define _Thor_Main_DownloadFileFromURL_FromServer_loc										[ 从服务器]
	#Define _Thor_Main_DownloadFileFromURL_URLCanNot_loc										[URL 不能打开]
	#Define _Thor_Main_DownloadFileFromURL_Download_loc											[正在下载...]
	#Define _Thor_Main_DownloadFileFromURL_DownloadComplete_loc									[下载完成。]
	#Define _Thor_Main_DownloadFileFromURL_ErrorSave_loc										[在下载或保存过程中出现错误。]

	#Define _Thor_Main_ExtractFiles_CopyAndInstall_loc											[正在复制文件到安装文件夹...]
	#Define _Thor_Main_ExtractFiles_Error_loc													"创建或访问安装文件夹时出现错误 ["
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIP_loc											[打开压缩文件时出现错误。]
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIPOrPath_loc										[打开ZIP文件或路径时出错 【]
	#Define _Thor_Main_ExtractFiles_ToCopyFrom_loc												[】 复制]
	#Define _Thor_Main_ExtractFiles_ErrorExtract_loc											[展开文件时出现错误 【]
	#Define _Thor_Main_ExtractFiles_ErrorExtract2_loc											[删除文件时出现错误。]
	#Define _Thor_Main_ExtractFiles_CopyFrom_loc												[复制文件从 【]
	#Define _Thor_Main_ExtractFiles_To_loc														[】 到 【]

	#Define _Thor_Main_ExtractFilesFromZip_Extract_loc											[正在提取 【]
	#Define _Thor_Main_ExtractFilesFromZip_ErrorInLibrary_loc									[加载 VFP 压缩库时出错【VFPCompression.fll】]

	#Define _Thor_Main_ExtractToPath_Extracting_loc												[正在提取....请稍候。]
	#Define _Thor_Main_ExtractToPath_Installing_loc												[正在安装....请稍候。]
	#Define _Thor_Main_ExtractToPath_Complete_loc												[更新完成！]
	#Define _Thor_Main_ExtractToPath_ErrorUpdating_loc											[更新时出现错误 ]
	#Define _Thor_Main_ExtractToPath_Failure_loc												[失败！]

	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Executing_loc						[从下载的版本文件执行代码...]
	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Error_loc							[从下载的版本文件执行代码时出现错误！]
	#Define _Thor_Main_GetAvailableVersionInfo_InvalidFormat_loc								[版本文件中的格式无效 ]
	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Error2_loc							[从服务器获取版本信息时出错。]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_MessageBox_loc						[消息： ]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_Cancel_loc							[正在取消 ... ]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_SelfCorrect_loc						[如果再次运行“检查更新”，此错误可能会自行更正。]

	#Define _Thor_Main_GetUpdateList_VersionIsEmpty_loc											[其中一个必需的版本文件属性为空。]

	***VCX AND FORM

	#Define _Tror_ContextMenu_Activate_Msg_loc													[这个菜单是空的; 找不到菜单项！]
	#Define _Tror_ContextMenu_Activate_MsgTitle_loc												[菜单是空的]

	#Define _Thor_ui_edittoolbutton_caption_loc													[编辑工具]

	#Define _thor_ui_header_HotKey_Caption_loc													[快捷键]
	#Define _thor_ui_header_Source_Caption_loc													[源]
	#Define _thor_ui_header_Desciption_Caption_loc												[描述]

	#Define	_Thor_ui_cmd_ToClipboard_caption_loc												[复制到剪贴板]

	#Define	_Thor_ui_HotkeyList_LoadList_Descript1_loc											[ (私有)]
	#Define	_Thor_ui_HotkeyList_LoadList_Descript2_loc											[ (私有，覆盖默认值)]
	#Define	_Thor_ui_HotkeyList_LoadList_Descript3_loc											[ (没有发现)]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_SetDesc_loc									[设置快捷键]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_Set_loc										[设置]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_ClearDesc_loc								[清除快捷键]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_Clear_loc									[清除]

	#Define _Thor_frm_CreatTool_TextChanged_loc													[名称匹配：]
	#Define _Thor_frm_frmthor_LoadTree_NoSource_loc												[(没有来源)]
	#Define _Thor_frm_frmthor_LoadTree_NoMatches_loc											[找不到匹配项]

	#Define _Thor_ui_SelectTool_LoadTree_NoSource_loc											[(没有来源)]
	#Define _Thor_ui_SelectTool_LoadTree_NoMetches_loc											[没有匹配 ]
	#Define _Thor_ui_SelectTool_LoadTree_ShowAll_loc											[ 发现。将显示所有工具。]
	#Define _Thor_ui_SelectTool_BaseLabel1_Caption_loc											[过滤]
	#Define _Thor_ui_SelectTool_lblPrompt1_Caption_loc											[提示]
	#Define _Thor_ui_SelectTool_cmdApply_Caption_loc											[应用]
	#Define _Thor_ui_SelectTool_cmdClear_Caption_loc											[清理]

	#Define _Thor_ui_FormRunTool_LoadTree_NoSource_loc											[(没有来源)]
	#Define _Thor_ui_FormRunTool_LoadTree_NoMatches_loc											[没有匹配]
	#Define _Thor_ui_FormRunTool_cmdoRigiht_Init_TolTpTet_loc									[展开表单，在右侧显示所有的控件]
	#Define _Thor_ui_FormRunTool_cmdLefti_Ineit_ToolTpText_loc									[收缩表单，隐藏右侧的所有控件]

	#Define _Thor_ui_Menus_AddMenu_NewMenu_loc													[新的菜单]

	#Define _Thor_ui_SelectToolForLauncher_BaseLabel1_Caption_loc								[过滤]
	#Define _Thor_ui_StartUpTools_LoadList_NotFound_loc											[ > 没有发现]

	#Define _Thor_ui_Header1_Caption_loc														[描述]
	#Define _Thor_ui_Header2_Caption_loc														[工具]
	#Define _Thor_ui_Header3_Caption_loc														[启动]

	#Define _Thor_ui_Options_lblValue_Caption_loc												[配置表单字体大小：]
	#Define _Thor_ui_Options_chkValue_Caption_loc												[当快捷键和菜单更新时显示消息]
	#Define _Thor_ui_Options_BaseLabel2_Caption_loc												[Thor 专用快捷键]
	#Define _Thor_ui_Options_BaseLabel3_Caption_loc												[启动器字体大小：]
	#Define _Thor_ui_Options_BaseCheck1_Caption_loc												[在 FoxPro 系统菜单中显示 "Thor Tools"]
	#Define _Thor_ui_Options_BaseCheck2_Caption_loc												[在 FoxPro 工具栏停靠 Thor 工具栏]
	#Define _Thor_ui_Options_BaseCheck3_Caption_loc												[对于表单设置使用 Home(7)]

	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Value1_loc									[工具 <]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Value2_loc									[> 没有发现]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Options_Caption_loc							[选项]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_PlugIns_Caption_loc							[插件]

	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Caption_loc										[标题：]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg1_loc										[移除工具 (]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg1Title_loc									[移除所有工具？]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg2_loc										[工具已移除？]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg2Title_loc									[已移除]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg3_loc										[不能移除工具]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg3Title_loc									[失败]

	#Define _Thor_frm_CreatTool_BaseLabel3_Caption_loc											[工具模板]
	#Define _Thor_frm_CreatTool_Caption_loc														[创建工具]
	#Define _Thor_ui_FormRunTool_Frame_Init1_loc												[系统列表]
	#Define _Thor_ui_FormRunTool_Frame_Init2_loc												[自定义列表]
	#Define _Thor_ui_FormRunTool_Frame_Init3_loc												[收藏夹]
	#Define _Thor_ui_FormRunTool_Frame_Init4_loc												[仅搜索工具名称]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init1_loc											[收藏夹]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init2_loc											[工具栏]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init3_loc											[Thor启动时运行]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init4_loc											[运行工具]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init5_loc											[移除工具]
	#Define _Thor_ui_FormRunTool_BaseCheck_Caption_loc											[在运行工具后重新打开表单]
	#Define _Thor_frm_ToolLauncher_Caption_loc													[工具启动器]
	#Define _Thor_frm_ToolLauncher_lblLink_Caption_loc											[Thor 视频]
	#Define _Thor_ui_menus_BaseCheck_Caption_loc												[在启动器中显示]
	#Define _Thor_ui_Menus_BaseLabel1_Caption_loc												[状态栏]
	#Define _Thor_ui_Menus_lblStatus_Caption_loc												[简介]
	
	#Define _Thor_Main_Updatingcomplete_loc														[更新完成]
	#Define _Thor_ui_frm_page2_Caption_loc														[工具定义]
	#Define _Thor_ui_frm_page3_Caption_loc														[选项]
	#Define _Thor_ui_frm_page4_Caption_loc														[指定快捷键]
	#Define _Thor_ui_frm_page5_Caption_loc														[启动工具]
#ELSE
	#Define ccCaption																			'Enter caption'
	#Define ccPicture 																			'Select picture'
	#Define ccDefault 																			'Default (Thor icon)'

	#Define ccTool 																				'Thor'
	#Define ccKey 																				'Thor ToolBar Path'

	* Add by JingChun Niu  2018.04.09

	#Define _Thor_Main_Install1Desc_loc															[Please use the Thor Forum for your questions, comments, etc. --]
	#Define _Thor_Main_Install2Desc_loc															[        Choose Forums->Thor from the main Thor menu.]
	#Define _Thor_Main_InstallMsgTitle_loc														[Thor Help and the Thor Community]
	#Define _Thor_Main_Installed_loc															[ installed]
	#Define _Thor_Main_InstallationComplete_loc													[Installation complete]

	#Define _Thor_Main_Menu_File_loc															[File]
	#Define _Thor_Main_Menu_Edit_loc															[Edit]
	#Define _Thor_Main_Menu_View_loc															[View]
	#Define _Thor_Main_Menu_Tools_loc															[Tools]
	#Define _Thor_Main_Menu_Program_loc															[Program]
	#Define _Thor_Main_Menu_Window_loc															[Window]
	#Define _Thor_Main_Menu_Help_loc															[Help]
	#Define _Thor_Main_Menu_ThorTools_loc														[Tho\<r Tools]
	#Define _Thor_Main_Menu_More_loc															[More]
	#Define _Thor_Main_Menu_Thor_StatusBar_loc													[Configures Thor, gives access to help pages, the Thor framework, and the Thor discussion group; runs Check For Updates]
	#Define _Thor_Main_Menu_ThorTools_StatusBar_loc												[Runs all Thor Tools]

	#Define _Thor_Main_PopupMenu_Launcher_loc													[Launcher]
	#Define _Thor_Main_PopupMenu_Launcher_Status_loc											[Find and run tools, explore descriptions, etc]
	#Define _Thor_Main_PopupMenu_Configure_loc													[Configure]
	#Define _Thor_Main_PopupMenu_Configure_Status_loc											[Assign hot keys, create menus and sub-menus, etc.]
	#Define _Thor_Main_PopupMenu_CheckForUpdates_loc											[Check for Updates]
	#Define _Thor_Main_PopupMenu_CheckForUpdates_Status_loc										[Check for and install any outstanding updates]
	#Define _Thor_Main_PopupMenu_ThorNews_loc													[Thor News]
	#Define _Thor_Main_PopupMenu_ThorNews_Status_loc											[All the latest and greatest news about Thor and Thor tools.]
	#Define _Thor_Main_PopupMenu_ThorTWEeTs_loc													[Thor TWEeTs]
	#Define _Thor_Main_PopupMenu_ThorTWEeTs_Status_loc											[History of all Thor TWEeTs (This Weeks Exceptional Tools]
	#Define _Thor_Main_PopupMenu_Forums_loc														[Forums]
	#Define _Thor_Main_PopupMenu_Blogs_loc														[Blogs]
	#Define _Thor_Main_PopupMenu_VFPxHomePage_loc												[Home Pages for VFPX Projects]
	#Define _Thor_Main_PopupMenu_VFPxHomePage_Status_loc										[Help for Thor]
	#Define _Thor_Main_PopupMenu_ThorVideos_loc													[Thor videos]
	#Define _Thor_Main_PopupMenu_ManagePlugIns_loc												[Manage Plug-Ins]
	#Define _Thor_Main_PopupMenu_ManagePlugIns_Status_loc										[Manages plug-in PRGS used by some tools]
	#Define _Thor_Main_PopupMenu_OpenFolder_loc													[Open Folder]
	#Define _Thor_Main_PopupMenu_OpenFolder_Status_loc											[Opens various Thor folders]
	#Define _Thor_Main_PopupMenu_UsageSummary_loc												[Thor Usage Summary]
	#Define _Thor_Main_PopupMenu_UsageSummary_Status_loc										[Summary of usage of Thor tools]
	#Define _Thor_Main_PopupMenu_ThorFrameWork_loc												[Thor Framework]
	#Define _Thor_Main_PopupMenu_ThorFrameWork_Status_loc										[Framework of tools to assist in creating tools]
	#Define _Thor_Main_PopupMenu_DebugMode_loc													[Debug Mode]
	#Define _Thor_Main_PopupMenu_DebugMode_Status_loc											[Toggles debug mode for working on Thor and IDE Tools]
	#Define _Thor_Main_PopupMenu_ChangeLogs_loc													[Thor-ChangeLogs]
	#Define _Thor_Main_PopupMenu_ThorERs_loc													[Thor ERs]

	#Define _Thor_Main_Remove_SourceFiles_loc													[Source Files]
	#Define _Thor_Main_Remove_SourceFiles_Status_loc											[Downloads source files for APPs]
	#Define _Thor_Main_Remove_RunTool_loc														[Run Tool]
	#Define _Thor_Main_Remove_RunTool_Status_loc												[All tools registered with Thor]
	#Define _Thor_Main_Remove_ModifyTool_loc													[Modify Tool]
	#Define _Thor_Main_Remove_ModifyTool_Status_loc												[Open tool with Modify Command]
	#Define _Thor_Main_Remove_PlugIns_loc														[Manage Plug-Ins]
	#Define _Thor_Main_Remove_PlugIns_Status_loc												[Manages plug-in PRGS used by some tools]
	#Define _Thor_Main_Remove_Community_loc														[Community / Discussions]
	#Define _Thor_Main_Remove_Community_Status_loc												[Community for discussing Thor, Thor Repository, and related topics.]
	#Define _Thor_Main_Remove_OpenFolder_loc													[Open Folder]
	#Define _Thor_Main_Remove_OpenFolder_Status_loc												[Opens various Thor folders]
	#Define _Thor_Main_Remove_FrameWork_loc														[Thor Framework]
	#Define _Thor_Main_Remove_FrameWork_Status_loc												[Framework of tools to assist in creating tools]
	#Define _Thor_Main_Remove_Debug_loc															[Debug Mode]
	#Define _Thor_Main_Remove_Debug_Status_loc													[Toggles debug mode for working on Thor and IDE Tools]
	#Define _Thor_Main_Removre_RepositoyHomePage_loc											[ Repository Home Page]
	#Define _Thor_Main_Remove_RepositoyHomePage_Status_loc										[Home page for Thor Repository]
	#Define _Thor_Main_Remove_ToolHomePage_loc													[Tool Home Pages]
	#Define _Thor_Main_Remove_ToolHomePage_Status_loc											[ Home page for each tool (if any)]

	#Define _Thor_Main_ThorInternalAllTools_Prompt_loc											[All Thor Tools]
	#Define _Thor_Main_ThorInternalAllTools_Description_loc										[Menu of all tools registered with Thor]

	#Define _Thor_Main_ThorInternalEdit_Prompt_loc												[Edit Thor]
	#Define _Thor_Main_ThorInternalEdit_Summary_loc												[Form for Thor]
	#Define _Thor_Main_ThorInternalEdit_Description_loc											[Opens main Thor form: assign hot keys to tools, create popup menus and assign hot keys to them,modify VFP system menus, etc.]
	#Define _Thor_Main_ThorInternalFrameWork_Prompt_loc											[Framework]
	#Define _Thor_Main_ThorInternalFrameWork_Description_loc									[Framework of tools to assist in creating tools]
	#Define _Thor_Main_ThorInternalFrameWork_Display_loc										[ *   Thor Framework home page ]
	#Define _Thor_Main_ThorInternalFrameWork_Display2_loc										[ External APPs ]
	#Define _Thor_Main_ThorInternalFrameWork_Display3_loc										[ home page = ]
	#Define _Thor_Main_ThorInternalFrameWork_Display4_loc										[* Internal *]

	#Define _Thor_Main_ThorInternalFrameworkHelp_Prompt_loc										[Help for Thor Framework]
	#Define _Thor_Main_ThorInternalFrameworkHelp_Description_loc								[Follows link to Thor Home Page]

	#Define _Thor_Main_ThorInternalManagePlugIns_Prompt_loc										[Manage Plug-In PRGs]

	#Define _Thor_Main_ThorInternalManagePlugIns_ToolCode_Msg_loc								[Thor is not active; this tool requires Thor]
	#Define _Thor_Main_ThorInternalManagePlugIns_ToolCode_MsgTitle_loc							[Thor is not active]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_PlugIn_loc			[BeforeComponentInstall]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_Description_loc		[Called during Check For Updates before a component is installed (in a sub-folder of Thor\Tools\Components).]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_Tools_loc			[Check For Updates]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_PlugIn_loc			[AfterComponentInstall]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_Description_loc		[Called during "Check For Updates" after a component is installed (in a sub-folder of Thor\Tools\Components).]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_Tools_loc				[Check For Updates]

	#Define _Thor_Main_ThorInternalModifyTool_Prompt_loc										[Modify Tool]
	#Define _Thor_Main_ThorInternalModifyTool_Description_loc									[Menu to open Thor tools for modification with Modify Command]

	#Define _Thor_Main_ThorInternalRepository_Prompt_loc										[All Thor Repository Tools]
	#Define _Thor_Main_ThorInternalRepository_Description_loc									[Menu of all tools registered in the Thor Repository]

	#Define _Thor_Main_ThorInternalRepositoryHomePage_Prompt_loc								[Link to Thor Repository]
	#Define _Thor_Main_ThorInternalRepositoryHomePage_Description_loc							[Link to Home Page for Thor Repository]

	#Define _Thor_Main_ThorInternalRunTool_Prompt_loc											[Tool Launcher]
	#Define _Thor_Main_ThorInternalRunTool_Description_loc										[Find and run tools, browse descriptions, set options, ...]

	#Define _Thor_Main_thorinternalthornews_Prompt_loc											[Thor News]
	#Define _Thor_Main_thorinternalthornews_Description_loc										[News headlines about Thor]
	#Define _Thor_Main_thorinternalthornews_GetForumNames_Forums_loc							[Dynamic Forms]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs1_loc					[PEM Editor]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs2_loc					[Thor Repository]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs3_loc					[VFPX Projects]
	#Define _Thor_Main_thorinternalthornews_ToolCode_Msg_loc									[No Internet Connection Found!]
	#Define _Thor_Main_thorinternalthornews_ToolCode_MsgTitle_loc								[No Internet Connection]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_Label1_Caption_loc						[Check for updates to Thor News:]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_CheckBox1_Caption_loc					[After running Check For Updates]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_CheckBox2_Caption_loc					[After running RunThor]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_Label2_Caption_loc						[Number of days between checking:]

	#Define _Thor_Main_ThorInternalToolLink_Prompt_loc											[Tool Home Page]
	#Define _Thor_Main_ThorInternalToolLink_Description_loc										[Tool Home Page''Menu to access home page (or description) for any tool]

	#Define _Thor_Main_THORINTERNALTWEETS_Prompt_loc											[Thor TWEeTs]
	#Define _Thor_Main_THORINTERNALTWEETS_Description_loc										[Home page for Thor TWEeTs]

	#Define _Thor_Main_THORINTERNALUSAGESUMMARY_Prompt_loc										[Thor usage summary]
	#Define _Thor_Main_THORINTERNALUSAGESUMMARY_Description_loc									[Summary of usage of Thor tools]

	#Define _Thor_Main_ThorCommunity_Prompt_loc													[Community / Discussions]
	#Define _Thor_Main_ThorCommunity_Description_loc											[Link to home page for discussions about Thor]

	#Define _Thor_Main_CheckInternetConnection_Pass_loc											[Internet connection test passed.]
	#Define _Thor_Main_CheckInternetConnection_Failed_loc										[Internet connection test FAILED!!!]

	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_Begin_loc								[Begin CFU - ]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_CheckForUpdate_loc						[Checking for updates to Thor]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXP_loc							[Erasing Thor FXP files...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXPFromThor_loc					[Erasing Thor FXP files from Thor Procs folder...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXPFromMY_loc						[Erasing Thor FXP files from Thor MyTools folder...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_Processing_loc							[Processing (]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ThorUpdaePro_loc						[) Thor updater programs...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_CheckForAllOtherApp_loc				[Checking for updates to all other apps]

	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_GetListOfUpdate_loc				[Getting list of Updaters]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Abort_loc						[Aborting ... no update list found]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Exit_loc							[Exiting ... no updates selected]
	#Define _Thor_Main_DownloadAndInstallUpdates_Msg_loc										[Updating completed]
	#Define _Thor_Main_DownloadAndInstallUpdates_MsgTitle_loc									[Thor Updates...]
	#Define _Thor_Main_DownloadAndInstallUpdates_GetVersionInfo_loc								[Getting available version info for ]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo1_loc									[Ready to install ]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo2_loc									[ update(s):]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo3_loc									[CLEAR ALL and CLOSE ALL statements must be run in order to update.]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo4_loc									[Do you wish to continue?]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo5_loc									[Allow CLEAR ALL, etc.?]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status1_loc									[Update available]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status2_loc									[New Project]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status3_loc									[Current]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status4_loc									[Recently Updated]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status5_loc									[Not Installed]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Downloading_loc					[Downloading and installing selected updates]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_AttemptDown_loc					[Attempting download of ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_DownloadFailed_loc				[Download failed; attempting alternate download of ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_CopyZIP_loc						[Copy Zip ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Download_loc						[Download ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Install_loc						[Install ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_Updated_loc							[ ... Updated]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_Failed_loc								[********** Failed: ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_See_loc								[********** See ]

	#Define _Thor_Main_Error_loc																[Error: ]
	#Define _Thor_Main_Message_loc																[Message: ]
	#Define _Thor_Main_Proc_loc																	[Procedure: ]
	#Define _Thor_Main_Line_loc																	[Line: ]
	#Define _Thor_Main_Code_loc																	[Code: ]
	#Define _Thor_Main_ErrorTitle_loc															[Error]

	#Define _Thor_Main_DownloadFileFromURL_Contacting_loc										[Contacting server.... Please wait.]
	#Define _Thor_Main_DownloadFileFromURL_ExpandingBitlyLink_loc								"Expanding bitly link 【"
	#Define _Thor_Main_DownloadFileFromURL_URLIsEmpty_loc										[Requested URL is an empty string.]
	#Define _Thor_Main_DownloadFileFromURL_SessionCanNot_loc									[Internet session cannot be established]
	#Define _Thor_Main_DownloadFileFromURL_RequestFile_loc										[Requesting file ]
	#Define _Thor_Main_DownloadFileFromURL_FromServer_loc										[ from server.]
	#Define _Thor_Main_DownloadFileFromURL_URLCanNot_loc										[URL cannot be opened]
	#Define _Thor_Main_DownloadFileFromURL_Download_loc											[Downloading...]
	#Define _Thor_Main_DownloadFileFromURL_DownloadComplete_loc									[Download complete.]
	#Define _Thor_Main_DownloadFileFromURL_ErrorSave_loc										[Error downloading or saving file.]

	#Define _Thor_Main_ExtractFiles_CopyAndInstall_loc											[Copying files to install folder...]
	#Define _Thor_Main_ExtractFiles_Error_loc													"Error creating or accessing install folder 【"
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIP_loc											[Error opening ZIP file.]
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIPOrPath_loc										"Error opening ZIP file or path 【"
	#Define _Thor_Main_ExtractFiles_ToCopyFrom_loc												"】 to copy from."
	#Define _Thor_Main_ExtractFiles_ErrorExtract_loc											"Error extracting files from 【"
	#Define _Thor_Main_ExtractFiles_ErrorExtract2_loc											[Error extracting files.]
	#Define _Thor_Main_ExtractFiles_CopyFrom_loc												"Copied files from 【"
	#Define _Thor_Main_ExtractFiles_To_loc														"】 to 【"

	#Define _Thor_Main_ExtractFilesFromZip_Extract_loc											"Extracting from 【"
	#Define _Thor_Main_ExtractFilesFromZip_ErrorInLibrary_loc									"Error loading VFP Compression library [VFPCompression.fll]"

	#Define _Thor_Main_ExtractToPath_Extracting_loc												[Extracting.... Please wait.]
	#Define _Thor_Main_ExtractToPath_Installing_loc												[Installing.... Please wait.]
	#Define _Thor_Main_ExtractToPath_Complete_loc												[Update complete!]
	#Define _Thor_Main_ExtractToPath_ErrorUpdating_loc											[Error updating ]
	#Define _Thor_Main_ExtractToPath_Failure_loc												[Failure!]

	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Executing_loc						[Executing code from downloaded version file...]
	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Error_loc							[ERROR while executing code from downloaded version file!]
	#Define _Thor_Main_GetAvailableVersionInfo_InvalidFormat_loc								[Invalid format in version file for ]
	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Error2_loc							[Error getting available version information from server.]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_MessageBox_loc						[MessageBox: ]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_Cancel_loc							[Cancelling ... ]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_SelfCorrect_loc						[This error may self-correct if "Check For Updates" is run again.]

	#Define _Thor_Main_GetUpdateList_VersionIsEmpty_loc											[One of the required version files properties is empty.]

	***VCX AND FORM

	#Define _Tror_ContextMenu_Activate_Msg_loc													[This menu is empty; no menu items found!]
	#Define _Tror_ContextMenu_Activate_MsgTitle_loc												[Menu is empty]

	#Define _Thor_ui_edittoolbutton_caption_loc													[Edit Tool]

	#Define _thor_ui_header_HotKey_Caption_loc													[Hot Key]
	#Define _thor_ui_header_Source_Caption_loc													[Source]
	#Define _thor_ui_header_Desciption_Caption_loc												[Description]

	#Define	_Thor_ui_cmd_ToClipboard_caption_loc												[To Clipboard]

	#Define	_Thor_ui_HotkeyList_LoadList_Descript1_loc											' (private)'
	#Define	_Thor_ui_HotkeyList_LoadList_Descript2_loc											' (private, over-rides default)'
	#Define	_Thor_ui_HotkeyList_LoadList_Descript3_loc											' (not found)'
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_SetDesc_loc									'Set hot key'
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_Set_loc										'Set'
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_ClearDesc_loc								'Clear hot key'
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_Clear_loc									'Clear'

	#Define _Thor_frm_CreatTool_TextChanged_loc													[Name matches:]
	#Define _Thor_frm_frmthor_LoadTree_NoSource_loc												[(No Source)]
	#Define _Thor_frm_frmthor_LoadTree_NoMatches_loc											[No matches found]

	#Define _Thor_ui_SelectTool_LoadTree_NoSource_loc											[(No Source)]
	#Define _Thor_ui_SelectTool_LoadTree_NoMetches_loc											[No matches to ]
	#Define _Thor_ui_SelectTool_LoadTree_ShowAll_loc											[ found.  Showing all tools.]
	#Define _Thor_ui_SelectTool_BaseLabel1_Caption_loc											[Filter]
	#Define _Thor_ui_SelectTool_lblPrompt1_Caption_loc											[Prompt]
	#Define _Thor_ui_SelectTool_cmdApply_Caption_loc											[Apply]
	#Define _Thor_ui_SelectTool_cmdClear_Caption_loc											[Clear]

	#Define _Thor_ui_FormRunTool_LoadTree_NoSource_loc											[(No Source)]
	#Define _Thor_ui_FormRunTool_LoadTree_NoMatches_loc											[No matches found]
	#Define _Thor_ui_FormRunTool_cmdoRigiht_Init_TolTpTet_loc									[Expand form, revealing all the controls on the right]
	#Define _Thor_ui_FormRunTool_cmdLefti_Ineit_ToolTpText_loc									[Shrink form, hiding all the controls on the right]

	#Define _Thor_ui_Menus_AddMenu_NewMenu_loc													[New Menu]

	#Define _Thor_ui_SelectToolForLauncher_BaseLabel1_Caption_loc								[Filter]
	#Define _Thor_ui_StartUpTools_LoadList_NotFound_loc											[ > not found]

	#Define _Thor_ui_Header1_Caption_loc														[Description]
	#Define _Thor_ui_Header2_Caption_loc														[Tool]
	#Define _Thor_ui_Header3_Caption_loc														[Startup?]

	#Define _Thor_ui_Options_lblValue_Caption_loc												[Configuration form Font Size:]
	#Define _Thor_ui_Options_chkValue_Caption_loc												[Display message when hotkeys and menus are updated]
	#Define _Thor_ui_Options_BaseLabel2_Caption_loc												[Dedicated hotkey for Thor's use]
	#Define _Thor_ui_Options_BaseLabel3_Caption_loc												[Launcher Font Size:]
	#Define _Thor_ui_Options_BaseCheck1_Caption_loc												[Show "Thor Tools" in FoxPro System Menu]
	#Define _Thor_ui_Options_BaseCheck2_Caption_loc												[Dock Thor Toolbar with FoxPro Toolbars]
	#Define _Thor_ui_Options_BaseCheck3_Caption_loc												[Use Home(7) for form settings]

	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Value1_loc									[Tool <]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Value2_loc									[> not found]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Options_Caption_loc							[Options]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_PlugIns_Caption_loc							[Plug-Ins]

	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Caption_loc										[Caption:]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg1_loc										'Remove this tool ('
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg1Title_loc									'Remove this tool?'
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg2_loc										'Tool removed?'
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg2Title_loc									'Removed'
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg3_loc										'Unable to remove tool'
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg3Title_loc									'Failure'

	#Define _Thor_frm_CreatTool_BaseLabel3_Caption_loc											[Tool Template]
	#Define _Thor_frm_CreatTool_Caption_loc														[Create Tool]
	#Define _Thor_ui_FormRunTool_Frame_Init1_loc												[System List]
	#Define _Thor_ui_FormRunTool_Frame_Init2_loc												[Custom List]
	#Define _Thor_ui_FormRunTool_Frame_Init3_loc												[Favorites]
	#Define _Thor_ui_FormRunTool_Frame_Init4_loc												[Search tool names only]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init1_loc											[Favorite?]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init2_loc											[ToolBar?]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init3_loc											[Run at startup?]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init4_loc											[Run Tool]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init5_loc											[Remove Tool]
	#Define _Thor_ui_FormRunTool_BaseCheck_Caption_loc											[Re-open form after executing tool]
	#Define _Thor_frm_ToolLauncher_Caption_loc													[Tool Launcher]
	#Define _Thor_frm_ToolLauncher_lblLink_Caption_loc											[Thor Videos]
	#Define _Thor_ui_menus_BaseCheck_Caption_loc												[Show in Launcher]
	#Define _Thor_ui_Menus_BaseLabel1_Caption_loc												[Status bar]
	#Define _Thor_ui_Menus_lblStatus_Caption_loc												[Summary]
	#Define _Thor_Main_Updatingcomplete_loc														[updateing completed]
	#Define _Thor_ui_frm_page2_Caption_loc														[Tool Definitions]
	#Define _Thor_ui_frm_page3_Caption_loc														[Options]
	#Define _Thor_ui_frm_page4_Caption_loc														[Hot Key Assignments]
	#Define _Thor_ui_frm_page5_Caption_loc														[Startup Tools]
#ENDIF