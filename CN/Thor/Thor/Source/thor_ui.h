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
	#Define ccCaption																			[�������]
	#Define ccPicture 																			[ѡ��ͼƬ]
	#Define ccDefault 																			[Ĭ��(Thor ͼ��)]

	#Define ccTool 																				[Thor]
	#Define ccKey 																				[Thor ������·��]

	* Add by JingChun Niu  2018.04.09

	#Define _Thor_Main_Install1Desc_loc															[��ʹ�� Thor ��̳����������⣬����� - ]
	#Define _Thor_Main_Install2Desc_loc															[        ���� Thor �˵�ѡ�� ����->Thor]
	#Define _Thor_Main_InstallMsgTitle_loc														[Thor ����������]
	#Define _Thor_Main_Installed_loc															[ �Ѱ�װ]
	#Define _Thor_Main_InstallationComplete_loc													[��װ���]

	#Define _Thor_Main_Menu_File_loc															[�ļ�]
	#Define _Thor_Main_Menu_Edit_loc															[�༭]
	#Define _Thor_Main_Menu_View_loc															[��ͼ]
	#Define _Thor_Main_Menu_Tools_loc															[����]
	#Define _Thor_Main_Menu_Program_loc															[����]
	#Define _Thor_Main_Menu_Window_loc															[����]
	#Define _Thor_Main_Menu_Help_loc															[����]
	#Define _Thor_Main_Menu_ThorTools_loc														[Tho\<r ����]
	#Define _Thor_Main_Menu_More_loc															[��������]
	#Define _Thor_Main_Menu_Thor_StatusBar_loc													[����Thor�����ʰ���ҳ�棬Thor ��ܺ� Thor ������; ���м�����]
	#Define _Thor_Main_Menu_ThorTools_StatusBar_loc												[�������� Thor ����]

	#Define _Thor_Main_PopupMenu_Launcher_loc													[������]
	#Define _Thor_Main_PopupMenu_Launcher_Status_loc											[���Һ����й��ߣ����������]
	#Define _Thor_Main_PopupMenu_Configure_loc													[����]
	#Define _Thor_Main_PopupMenu_Configure_Status_loc											[ָ����ݼ��������˵����Ӳ˵��ȡ�]
	#Define _Thor_Main_PopupMenu_CheckForUpdates_loc											[������]
	#Define _Thor_Main_PopupMenu_CheckForUpdates_Status_loc										[��鲢��װ�κ�δ��ɵĸ���]
	#Define _Thor_Main_PopupMenu_ThorNews_loc													[Thor ����]
	#Define _Thor_Main_PopupMenu_ThorNews_Status_loc											[���й��� Thor �� Thor ���ߵ�������õ����š�]
	#Define _Thor_Main_PopupMenu_ThorTWEeTs_loc													[Thor ����]
	#Define _Thor_Main_PopupMenu_ThorTWEeTs_Status_loc											[���� Thor ���ĵ���ʷ(���ܵ����㹤��]
	#Define _Thor_Main_PopupMenu_Forums_loc														[����]
	#Define _Thor_Main_PopupMenu_Blogs_loc														[����]
	#Define _Thor_Main_PopupMenu_VFPxHomePage_loc												[VFPX ��Ŀ��ҳ]
	#Define _Thor_Main_PopupMenu_VFPxHomePage_Status_loc										[Thor ����]
	#Define _Thor_Main_PopupMenu_ThorVideos_loc													[Thor ��Ƶ]
	#Define _Thor_Main_PopupMenu_ManagePlugIns_loc												[������]
	#Define _Thor_Main_PopupMenu_ManagePlugIns_Status_loc										[ͨ��ʹ��һЩ���߹��� PRGs ���]
	#Define _Thor_Main_PopupMenu_OpenFolder_loc													[���ļ���]
	#Define _Thor_Main_PopupMenu_OpenFolder_Status_loc											[�򿪸��� Thor �ļ���]
	#Define _Thor_Main_PopupMenu_UsageSummary_loc												[Thor ʹ��ժҪ]
	#Define _Thor_Main_PopupMenu_UsageSummary_Status_loc										[Thor ���ߵ�ʹ��ժҪ]
	#Define _Thor_Main_PopupMenu_ThorFrameWork_loc												[Thor ���]
	#Define _Thor_Main_PopupMenu_ThorFrameWork_Status_loc										[�����������ߵĹ��߿��]
	#Define _Thor_Main_PopupMenu_DebugMode_loc													[����ģʽ]
	#Define _Thor_Main_PopupMenu_DebugMode_Status_loc											[�� Thor �� IDE ��������ʱ�л�������ģʽ]
	#Define _Thor_Main_PopupMenu_ChangeLogs_loc													[Thor ������ʷ]
	#Define _Thor_Main_PopupMenu_ThorERs_loc													[Thor �����ύ]

	#Define _Thor_Main_Remove_SourceFiles_loc													[Դ�ļ�]
	#Define _Thor_Main_Remove_SourceFiles_Status_loc											[���� APPs ��Դ�ļ�]
	#Define _Thor_Main_Remove_RunTool_loc														[���й���]
	#Define _Thor_Main_Remove_RunTool_Status_loc												[�������� Thor ע��Ĺ���]
	#Define _Thor_Main_Remove_ModifyTool_loc													[�༭����]
	#Define _Thor_Main_Remove_ModifyTool_Status_loc												[ʹ�� Modify Command �򿪹���]
	#Define _Thor_Main_Remove_PlugIns_loc														[������]
	#Define _Thor_Main_Remove_PlugIns_Status_loc												[ͨ��ʹ��һЩ���߹��� PRGs ���]
	#Define _Thor_Main_Remove_Community_loc														[����/����]
	#Define _Thor_Main_Remove_Community_Status_loc												[����Thor��Thor �ֿ����������������]
	#Define _Thor_Main_Remove_OpenFolder_loc													[���ļ���]
	#Define _Thor_Main_Remove_OpenFolder_Status_loc												[�򿪸��� Thor �ļ���]
	#Define _Thor_Main_Remove_FrameWork_loc														[Thor ���]
	#Define _Thor_Main_Remove_FrameWork_Status_loc												[�����������ߵĹ��߿��]
	#Define _Thor_Main_Remove_Debug_loc															[����ģʽ]
	#Define _Thor_Main_Remove_Debug_Status_loc													[�� Thor �� IDE ��������ʱ�л�������ģʽ]
	#Define _Thor_Main_Removre_RepositoyHomePage_loc											[�ֿ���ҳ]
	#Define _Thor_Main_Remove_RepositoyHomePage_Status_loc										[Thor �ֿ���ҳ]
	#Define _Thor_Main_Remove_ToolHomePage_loc													[Tool ��ҳ]
	#Define _Thor_Main_Remove_ToolHomePage_Status_loc											[���ֹ��ߵ���ҳ��������ڣ�]

	#Define _Thor_Main_ThorInternalAllTools_Prompt_loc											[���� Thor ����]
	#Define _Thor_Main_ThorInternalAllTools_Description_loc										[������ Thor ע��Ĺ��ߵĲ˵�]

	#Define _Thor_Main_ThorInternalEdit_Prompt_loc												[�༭ Thor]
	#Define _Thor_Main_ThorInternalEdit_Summary_loc												[Thor ��]
	#Define _Thor_Main_ThorInternalEdit_Description_loc											[����Thor����Ϊ����ָ����ݼ������������˵���Ϊ��ָ����ݼ����޸�VFPϵͳ�˵��ȡ�]
	#Define _Thor_Main_ThorInternalFrameWork_Prompt_loc											[���]
	#Define _Thor_Main_ThorInternalFrameWork_Description_loc									[�����������ߵĹ��߿��]
	#Define _Thor_Main_ThorInternalFrameWork_Display_loc										[ *   Thor �����ҳ ]
	#Define _Thor_Main_ThorInternalFrameWork_Display2_loc										[ �ⲿ APPs ]
	#Define _Thor_Main_ThorInternalFrameWork_Display3_loc										[ ��ҳ = ]
	#Define _Thor_Main_ThorInternalFrameWork_Display4_loc										[* �ڲ� *]

	#Define _Thor_Main_ThorInternalFrameworkHelp_Prompt_loc										[Thor ��ܰ���]
	#Define _Thor_Main_ThorInternalFrameworkHelp_Description_loc								[���ӵ� Thor ��ҳ]

	#Define _Thor_Main_ThorInternalManagePlugIns_Prompt_loc										[���� PRGs ���]

	#Define _Thor_Main_ThorInternalManagePlugIns_ToolCode_Msg_loc								[Thor û�м���˹�����Ҫ Thor ������]
	#Define _Thor_Main_ThorInternalManagePlugIns_ToolCode_MsgTitle_loc							[Thor û�м���]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_PlugIn_loc			[�����װǰ]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_Description_loc		[�ڼ������ڼ䰲װ���֮ǰ����Thor \ Tools \ Components�����ļ����У����á�]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsBeforeComponentInstall_Tools_loc			[������]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_PlugIn_loc			[�����װ��]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_Description_loc		[�ڼ������ڼ䰲װ�������Thor \ Tools \ Components�����ļ����У����á�]
	#Define _Thor_Main_ThorInternalManagePlugIns_clsAfterComponentInstall_Tools_loc				[������]

	#Define _Thor_Main_ThorInternalModifyTool_Prompt_loc										[�༭����]
	#Define _Thor_Main_ThorInternalModifyTool_Description_loc									[ʹ�� Modify Command �򿪹���]

	#Define _Thor_Main_ThorInternalRepository_Prompt_loc										[Thor �ֿ�����й���]
	#Define _Thor_Main_ThorInternalRepository_Description_loc									[��Thor �ֿ���ע������й��ߵĲ˵�]

	#Define _Thor_Main_ThorInternalRepositoryHomePage_Prompt_loc								[���ӵ� Thor �ֿ�]
	#Define _Thor_Main_ThorInternalRepositoryHomePage_Description_loc							[���ӵ� Thor �ֿ���ҳ]

	#Define _Thor_Main_ThorInternalRunTool_Prompt_loc											[����������]
	#Define _Thor_Main_ThorInternalRunTool_Description_loc										[���Һ����й��ߣ��������������ѡ���]

	#Define _Thor_Main_thorinternalthornews_Prompt_loc											[Thor ����]
	#Define _Thor_Main_thorinternalthornews_Description_loc										[���� Thor ������ͷ��]
	#Define _Thor_Main_thorinternalthornews_GetForumNames_Forums_loc							[��̬��]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs1_loc					[PEM �༭��]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs2_loc					[Thor �ֿ�]
	#Define _Thor_Main_thorinternalthornews_GetChangeLogNames_ChangeLogs3_loc					[VFPX ��Ŀ]
	#Define _Thor_Main_thorinternalthornews_ToolCode_Msg_loc									[û���ҵ����������ӣ�]
	#Define _Thor_Main_thorinternalthornews_ToolCode_MsgTitle_loc								[û�л���������]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_Label1_Caption_loc						[��� Thor ���ŵĸ��£�]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_CheckBox1_Caption_loc					[�����м�����֮��]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_CheckBox2_Caption_loc					[������ RunThor ֮��]
	#Define _Thor_Main_thorinternalthornews_clsThorNews_Label2_Caption_loc						[�������������]

	#Define _Thor_Main_ThorInternalToolLink_Prompt_loc											[������ҳ]
	#Define _Thor_Main_ThorInternalToolLink_Description_loc										[������ҳ�˵����ڷ������⹤�ߵ���ҳ������]

	#Define _Thor_Main_THORINTERNALTWEETS_Prompt_loc											[Thor ����]
	#Define _Thor_Main_THORINTERNALTWEETS_Description_loc										[Thor ������ҳ]

	#Define _Thor_Main_THORINTERNALUSAGESUMMARY_Prompt_loc										[Thor ʹ��ժҪ]
	#Define _Thor_Main_THORINTERNALUSAGESUMMARY_Description_loc									[Thor ���ߵ�ʹ��ժҪ]

	#Define _Thor_Main_ThorCommunity_Prompt_loc													[����/����]
	#Define _Thor_Main_ThorCommunity_Description_loc											[���ӵ����۹��� Thor ���ݵ���ҳ]

	#Define _Thor_Main_CheckInternetConnection_Pass_loc											[���������Ӳ���ͨ����]
	#Define _Thor_Main_CheckInternetConnection_Failed_loc										[���������Ӳ���ʧ�ܣ�]

	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_Begin_loc								[��ʼ CFU - ]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_CheckForUpdate_loc						[��� Thor ����]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXP_loc							[����ɾ�� FXP �ļ�...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXPFromThor_loc					[���ڴ� Thor Procs �ļ���ɾ�� Thor FXP �ļ�...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ErasFXPFromMY_loc						[���ڴ� Thor MyTools �ļ���ɾ�� Thor FXP �ļ�...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_Processing_loc							[���ڴ��� (]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_ThorUpdaePro_loc						[) Thor ���³���...]
	#Define _Thor_Main_ProcCheckForUpdates_WritetoCFULog_CheckForAllOtherApp_loc				[����������� APPs ����]

	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_GetListOfUpdate_loc				[���ڻ�ȡ�����б�]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Abort_loc						[������ֹ...�Ҳ��������б�]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Exit_loc							[�����˳�...δѡ�����]
	#Define _Thor_Main_DownloadAndInstallUpdates_Msg_loc										[�������]
	#Define _Thor_Main_DownloadAndInstallUpdates_MsgTitle_loc									[Thor ����...]
	#Define _Thor_Main_DownloadAndInstallUpdates_GetVersionInfo_loc								[��ȡ���õİ汾��Ϣ ]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo1_loc									[׼����װ ]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo2_loc									[ ����(s):]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo3_loc									[Ҫִ�и��£�CLEAR ALL �� CLOSE ALL ����������С�]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo4_loc									[��ϣ��������]
	#Define _Thor_Main_DownloadAndInstallUpdates_ReadToGo5_loc									[���� CLEAR ALL �ȣ�]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status1_loc									[���ø���]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status2_loc									[����Ŀ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status3_loc									[��ǰ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status4_loc									[�������]
	#Define _Thor_Main_DownloadAndInstallUpdates_Status5_loc									[û�а�װ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Downloading_loc					[�������غͰ�װ��ѡ����]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_AttemptDown_loc					[�������� ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_DownloadFailed_loc				[����ʧ��; ���Ա������� ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_CopyZIP_loc						[����ѹ���ļ� ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Download_loc						[���� ]
	#Define _Thor_Main_DownloadAndInstallUpdates_WritetoCFULog_Install_loc						[��װ ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_Updated_loc							[ ... �Ѹ���]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_Failed_loc								[********** ʧ�ܣ� ]
	#Define _Thor_Main_DownloadAndInstallUpdates_Writeto_See_loc								[********** �ο� ]

	#Define _Thor_Main_Error_loc																[���� ]
	#Define _Thor_Main_Message_loc																[��Ϣ�� ]
	#Define _Thor_Main_Proc_loc																	[���̣� ]
	#Define _Thor_Main_Line_loc																	[�У� ]
	#Define _Thor_Main_Code_loc																	[���룺 ]
	#Define _Thor_Main_ErrorTitle_loc															[����]

	#Define _Thor_Main_DownloadFileFromURL_Contacting_loc										[�������ӷ�����.... ��ȴ���]
	#Define _Thor_Main_DownloadFileFromURL_ExpandingBitlyLink_loc								[չ�� bitly ���� ��]
	#Define _Thor_Main_DownloadFileFromURL_URLIsEmpty_loc										[������� URL ��һ�����ַ�����]
	#Define _Thor_Main_DownloadFileFromURL_SessionCanNot_loc									[�������Ự�޷�����]
	#Define _Thor_Main_DownloadFileFromURL_RequestFile_loc										[���������ļ� ]
	#Define _Thor_Main_DownloadFileFromURL_FromServer_loc										[ �ӷ�����]
	#Define _Thor_Main_DownloadFileFromURL_URLCanNot_loc										[URL ���ܴ�]
	#Define _Thor_Main_DownloadFileFromURL_Download_loc											[��������...]
	#Define _Thor_Main_DownloadFileFromURL_DownloadComplete_loc									[������ɡ�]
	#Define _Thor_Main_DownloadFileFromURL_ErrorSave_loc										[�����ػ򱣴�����г��ִ���]

	#Define _Thor_Main_ExtractFiles_CopyAndInstall_loc											[���ڸ����ļ�����װ�ļ���...]
	#Define _Thor_Main_ExtractFiles_Error_loc													"��������ʰ�װ�ļ���ʱ���ִ��� ["
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIP_loc											[��ѹ���ļ�ʱ���ִ���]
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIPOrPath_loc										[��ZIP�ļ���·��ʱ���� ��]
	#Define _Thor_Main_ExtractFiles_ToCopyFrom_loc												[�� ����]
	#Define _Thor_Main_ExtractFiles_ErrorExtract_loc											[չ���ļ�ʱ���ִ��� ��]
	#Define _Thor_Main_ExtractFiles_ErrorExtract2_loc											[ɾ���ļ�ʱ���ִ���]
	#Define _Thor_Main_ExtractFiles_CopyFrom_loc												[�����ļ��� ��]
	#Define _Thor_Main_ExtractFiles_To_loc														[�� �� ��]

	#Define _Thor_Main_ExtractFilesFromZip_Extract_loc											[������ȡ ��]
	#Define _Thor_Main_ExtractFilesFromZip_ErrorInLibrary_loc									[���� VFP ѹ����ʱ����VFPCompression.fll��]

	#Define _Thor_Main_ExtractToPath_Extracting_loc												[������ȡ....���Ժ�]
	#Define _Thor_Main_ExtractToPath_Installing_loc												[���ڰ�װ....���Ժ�]
	#Define _Thor_Main_ExtractToPath_Complete_loc												[������ɣ�]
	#Define _Thor_Main_ExtractToPath_ErrorUpdating_loc											[����ʱ���ִ��� ]
	#Define _Thor_Main_ExtractToPath_Failure_loc												[ʧ�ܣ�]

	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Executing_loc						[�����صİ汾�ļ�ִ�д���...]
	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Error_loc							[�����صİ汾�ļ�ִ�д���ʱ���ִ���]
	#Define _Thor_Main_GetAvailableVersionInfo_InvalidFormat_loc								[�汾�ļ��еĸ�ʽ��Ч ]
	#Define _Thor_Main_GetAvailableVersionInfo_WritetoCFULog_Error2_loc							[�ӷ�������ȡ�汾��Ϣʱ����]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_MessageBox_loc						[��Ϣ�� ]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_Cancel_loc							[����ȡ�� ... ]
	#Define _Thor_Main_GetAvailableVersionInfo_ErrorMessage_SelfCorrect_loc						[����ٴ����С������¡����˴�����ܻ����и�����]

	#Define _Thor_Main_GetUpdateList_VersionIsEmpty_loc											[����һ������İ汾�ļ�����Ϊ�ա�]

	***VCX AND FORM

	#Define _Tror_ContextMenu_Activate_Msg_loc													[����˵��ǿյ�; �Ҳ����˵��]
	#Define _Tror_ContextMenu_Activate_MsgTitle_loc												[�˵��ǿյ�]

	#Define _Thor_ui_edittoolbutton_caption_loc													[�༭����]

	#Define _thor_ui_header_HotKey_Caption_loc													[��ݼ�]
	#Define _thor_ui_header_Source_Caption_loc													[Դ]
	#Define _thor_ui_header_Desciption_Caption_loc												[����]

	#Define	_Thor_ui_cmd_ToClipboard_caption_loc												[���Ƶ�������]

	#Define	_Thor_ui_HotkeyList_LoadList_Descript1_loc											[ (˽��)]
	#Define	_Thor_ui_HotkeyList_LoadList_Descript2_loc											[ (˽�У�����Ĭ��ֵ)]
	#Define	_Thor_ui_HotkeyList_LoadList_Descript3_loc											[ (û�з���)]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_SetDesc_loc									[���ÿ�ݼ�]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_Set_loc										[����]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_ClearDesc_loc								[�����ݼ�]
	#Define	_Thor_ui_HotKeyList_GridKeys_RightClick_Clear_loc									[���]

	#Define _Thor_frm_CreatTool_TextChanged_loc													[����ƥ�䣺]
	#Define _Thor_frm_frmthor_LoadTree_NoSource_loc												[(û����Դ)]
	#Define _Thor_frm_frmthor_LoadTree_NoMatches_loc											[�Ҳ���ƥ����]

	#Define _Thor_ui_SelectTool_LoadTree_NoSource_loc											[(û����Դ)]
	#Define _Thor_ui_SelectTool_LoadTree_NoMetches_loc											[û��ƥ�� ]
	#Define _Thor_ui_SelectTool_LoadTree_ShowAll_loc											[ ���֡�����ʾ���й��ߡ�]
	#Define _Thor_ui_SelectTool_BaseLabel1_Caption_loc											[����]
	#Define _Thor_ui_SelectTool_lblPrompt1_Caption_loc											[��ʾ]
	#Define _Thor_ui_SelectTool_cmdApply_Caption_loc											[Ӧ��]
	#Define _Thor_ui_SelectTool_cmdClear_Caption_loc											[����]

	#Define _Thor_ui_FormRunTool_LoadTree_NoSource_loc											[(û����Դ)]
	#Define _Thor_ui_FormRunTool_LoadTree_NoMatches_loc											[û��ƥ��]
	#Define _Thor_ui_FormRunTool_cmdoRigiht_Init_TolTpTet_loc									[չ���������Ҳ���ʾ���еĿؼ�]
	#Define _Thor_ui_FormRunTool_cmdLefti_Ineit_ToolTpText_loc									[�������������Ҳ�����пؼ�]

	#Define _Thor_ui_Menus_AddMenu_NewMenu_loc													[�µĲ˵�]

	#Define _Thor_ui_SelectToolForLauncher_BaseLabel1_Caption_loc								[����]
	#Define _Thor_ui_StartUpTools_LoadList_NotFound_loc											[ > û�з���]

	#Define _Thor_ui_Header1_Caption_loc														[����]
	#Define _Thor_ui_Header2_Caption_loc														[����]
	#Define _Thor_ui_Header3_Caption_loc														[����]

	#Define _Thor_ui_Options_lblValue_Caption_loc												[���ñ������С��]
	#Define _Thor_ui_Options_chkValue_Caption_loc												[����ݼ��Ͳ˵�����ʱ��ʾ��Ϣ]
	#Define _Thor_ui_Options_BaseLabel2_Caption_loc												[Thor ר�ÿ�ݼ�]
	#Define _Thor_ui_Options_BaseLabel3_Caption_loc												[�����������С��]
	#Define _Thor_ui_Options_BaseCheck1_Caption_loc												[�� FoxPro ϵͳ�˵�����ʾ "Thor Tools"]
	#Define _Thor_ui_Options_BaseCheck2_Caption_loc												[�� FoxPro ������ͣ�� Thor ������]
	#Define _Thor_ui_Options_BaseCheck3_Caption_loc												[���ڱ�����ʹ�� Home(7)]

	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Value1_loc									[���� <]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Value2_loc									[> û�з���]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_Options_Caption_loc							[ѡ��]
	#Define _Thor_ui_ToolInfo_edtToolInfo_Refresh_PlugIns_Caption_loc							[���]

	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Caption_loc										[���⣺]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg1_loc										[�Ƴ����� (]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg1Title_loc									[�Ƴ����й��ߣ�]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg2_loc										[�������Ƴ���]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg2Title_loc									[���Ƴ�]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg3_loc										[�����Ƴ�����]
	#Define _Thor_ui_ToolKeysBase_MenuToToolbar_Msg3Title_loc									[ʧ��]

	#Define _Thor_frm_CreatTool_BaseLabel3_Caption_loc											[����ģ��]
	#Define _Thor_frm_CreatTool_Caption_loc														[��������]
	#Define _Thor_ui_FormRunTool_Frame_Init1_loc												[ϵͳ�б�]
	#Define _Thor_ui_FormRunTool_Frame_Init2_loc												[�Զ����б�]
	#Define _Thor_ui_FormRunTool_Frame_Init3_loc												[�ղؼ�]
	#Define _Thor_ui_FormRunTool_Frame_Init4_loc												[��������������]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init1_loc											[�ղؼ�]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init2_loc											[������]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init3_loc											[Thor����ʱ����]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init4_loc											[���й���]
	#Define _Thor_ui_FormRunTool_cntToolInfo_Init5_loc											[�Ƴ�����]
	#Define _Thor_ui_FormRunTool_BaseCheck_Caption_loc											[�����й��ߺ����´򿪱�]
	#Define _Thor_frm_ToolLauncher_Caption_loc													[����������]
	#Define _Thor_frm_ToolLauncher_lblLink_Caption_loc											[Thor ��Ƶ]
	#Define _Thor_ui_menus_BaseCheck_Caption_loc												[������������ʾ]
	#Define _Thor_ui_Menus_BaseLabel1_Caption_loc												[״̬��]
	#Define _Thor_ui_Menus_lblStatus_Caption_loc												[���]
	
	#Define _Thor_Main_Updatingcomplete_loc														[�������]
	#Define _Thor_ui_frm_page2_Caption_loc														[���߶���]
	#Define _Thor_ui_frm_page3_Caption_loc														[ѡ��]
	#Define _Thor_ui_frm_page4_Caption_loc														[ָ����ݼ�]
	#Define _Thor_ui_frm_page5_Caption_loc														[��������]
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
	#Define _Thor_Main_DownloadFileFromURL_ExpandingBitlyLink_loc								"Expanding bitly link ��"
	#Define _Thor_Main_DownloadFileFromURL_URLIsEmpty_loc										[Requested URL is an empty string.]
	#Define _Thor_Main_DownloadFileFromURL_SessionCanNot_loc									[Internet session cannot be established]
	#Define _Thor_Main_DownloadFileFromURL_RequestFile_loc										[Requesting file ]
	#Define _Thor_Main_DownloadFileFromURL_FromServer_loc										[ from server.]
	#Define _Thor_Main_DownloadFileFromURL_URLCanNot_loc										[URL cannot be opened]
	#Define _Thor_Main_DownloadFileFromURL_Download_loc											[Downloading...]
	#Define _Thor_Main_DownloadFileFromURL_DownloadComplete_loc									[Download complete.]
	#Define _Thor_Main_DownloadFileFromURL_ErrorSave_loc										[Error downloading or saving file.]

	#Define _Thor_Main_ExtractFiles_CopyAndInstall_loc											[Copying files to install folder...]
	#Define _Thor_Main_ExtractFiles_Error_loc													"Error creating or accessing install folder ��"
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIP_loc											[Error opening ZIP file.]
	#Define _Thor_Main_ExtractFiles_ErrorOpenZIPOrPath_loc										"Error opening ZIP file or path ��"
	#Define _Thor_Main_ExtractFiles_ToCopyFrom_loc												"�� to copy from."
	#Define _Thor_Main_ExtractFiles_ErrorExtract_loc											"Error extracting files from ��"
	#Define _Thor_Main_ExtractFiles_ErrorExtract2_loc											[Error extracting files.]
	#Define _Thor_Main_ExtractFiles_CopyFrom_loc												"Copied files from ��"
	#Define _Thor_Main_ExtractFiles_To_loc														"�� to ��"

	#Define _Thor_Main_ExtractFilesFromZip_Extract_loc											"Extracting from ��"
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