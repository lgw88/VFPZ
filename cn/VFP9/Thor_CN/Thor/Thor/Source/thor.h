#include FOXPRO.H

* Virtual key codes.

#define VK_SHIFT				0x10
#define VK_CONTROL				0x11
#define VK_MENU					0x12

* Modifier key values.

#define cnNO_MODIFIER			0
#define cnSHIFT					1
#define cnCTRL					2
#define cnALT					4

#define     ccCR			    chr(13)
#define     ccLF			    chr(10)
#define     ccCRLF			    chr(13) + chr(10)
#define     ccTAB			    chr(9)

#Define     ccTOOLNAMEPREFIX		'Thor_Tool_'

#define     ccINTERNALEDITPRG		ccTOOLNAMEPREFIX + 'ThorInternalEdit.PRG'
#define     ccINTERNALHELPPRG		ccTOOLNAMEPREFIX + 'ThorInternalHelp.PRG'
#define     ccINTERNALALLTOOLSPRG	ccTOOLNAMEPREFIX + 'ThorInternalAllTools.PRG'
#define     ccINTERNALFRAMEWORK   	ccTOOLNAMEPREFIX + 'ThorInternalFrameWork.PRG'
#define     ccCHECKFORUPDATES   	ccTOOLNAMEPREFIX + 'Thor_CheckForUpdates.PRG'
#define     ccCOMMUNITY   	        ccTOOLNAMEPREFIX + 'Thor_Community.PRG'
#define     ccThorNews   	        ccTOOLNAMEPREFIX + 'ThorInternalThorNews.PRG'
#define     ccThorTWEeTs 	        ccTOOLNAMEPREFIX + 'ThorInternalTWEeTs.PRG'
#define     ccINTERNALRepostitory	ccTOOLNAMEPREFIX + 'ThorInternalRepositoryHomePage.PRG'
#define     ccINTERNALMODIFY   		ccTOOLNAMEPREFIX + 'ThorInternalModifyTool.PRG'
#define     ccINTERNALTOOLLINK   	ccTOOLNAMEPREFIX + 'ThorInternalToolLink.PRG'
#define     ccOPENFOLDERS		   	ccTOOLNAMEPREFIX + 'ThorInternalOpenFolders.PRG'
#define     ccSOURCEFILES		   	ccTOOLNAMEPREFIX + 'ThorInternalSourceFiles.PRG'
#define     ccUSAGESUMMARY		   	ccTOOLNAMEPREFIX + 'ThorInternalUsageSummary.PRG'
#define     ccDEBUGMODE  		   	ccTOOLNAMEPREFIX + 'ThorInternalDebugMode.PRG'
#Define     ccMANAGEPLUGINS  		ccTOOLNAMEPREFIX + 'ThorInternalManagePlugIns.PRG'

#IF Version(3) = [86]
	#Define     ccTOGGLEDEBUGMODE       'Toggle Debug Mode'
#ELSE
	#Define     ccTOGGLEDEBUGMODE       '�л�������ģʽ'
#ENDIF

#define     ccMyTools				'My Tools'
#define     ccProcs	   			    'Procs'
#define     ccUpdates	   			'Updates'
#define     ccApps	   			    'Apps'
#define     ccComponents		    'Components'
#define     ccMySettings			ccMyTools + '\Settings'
#define     ccMyTemplates			ccMyTools + '\Templates'
#define     ccMyStartThorUI			ccMyTools + '\StartThorUI'

#Define     ccThorDefaultTemplate   'Thor Default'

#Define     ccTemplatePrefix    'Thor_Tool_Template_'

#Define     ccOnKeyLabelPrefix  'ExecScript(_Screen.cThorDispatcher, "'

#Define     ccOnKeyLabelSuffix  '")'

#Define     ccPEMEditor              'IDE Tools'

*!* Add by JingChun Niu     2018.04.12
#IF Version(3) = [86]
	#Define		_Thor_Thor_othor_ExecteThorProc_Debug_loc					[���ԣ�     ]

	#Define		_Thor_utils_FindEXE_Find_Msg_loc							[' û���ҵ����Ƿ�������]
	#Define		_Thor_utils_FindEXE_Find_Msg2_loc							[û�з��֣����� ]

	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Prompt_loc			[������ʾ]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Description_loc		[��������]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_AppName_loc			[��ִ���ļ���]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_StatusBarText_loc	[�˵����״̬���ı�]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Summary_loc			[���ߵ���������]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Classes_loc			[��APP�а���������б�]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Source_loc			[��������]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Version_loc			[�汾��]

	#Define		_Thor_utils_ThorInfo_Register_Prompt_loc					[�����߳����ڲ˵���ʱʹ��]
	#Define		_Thor_utils_ThorInfo_Register_PRGName_loc					[�ù��ߵ�Ψһ����; ע�������ǰ׺]
	#Define		_Thor_utils_ThorInfo_Register_Summary_loc					[���Ϊ�գ���ʹ��.Description�ĵ�һ��]
	#Define		_Thor_utils_ThorInfo_Register_AppName_loc					[������·������������չ��; ���磺GoFish4.App]
	#Define		_Thor_utils_ThorInfo_Register_FullAppName_loc				[APP ������·��])
	#Define		_Thor_utils_ThorInfo_Register_FolderName_loc				[APP �����ļ�����])
	#Define		_Thor_utils_ThorInfo_Register_Classes_loc					[�ö��ŷָ�������'thorinfo of thor_utils']
	#Define		_Thor_utils_ThorInfo_Register_SubCategory_loc				[���Ƽ�ʹ��; ʹ�� .Category ����'|' ��Ϊ�ָ���]
	#Define		_Thor_utils_ThorInfo_Register_Source_loc					[���Ƽ�ʹ��; ���� .Category]
	#Define		_Thor_utils_ThorInfo_Register_Version_loc					[����'2011��5��18�� �汾7']
	#Define		_Thor_utils_ThorInfo_Register_Sort_loc						[������ͬ .Source ��������Ŀ������˳��]
	#Define		_Thor_utils_ThorInfo_Register_Registered_loc				[*��Thorע�᣺ ]
#Else
	#Define		_Thor_Thor_othor_ExecteThorProc_Debug_loc					[Debug:     ]

	#Define		_Thor_utils_FindEXE_Find_Msg_loc							[' not found.  Search for it?]
	#Define		_Thor_utils_FindEXE_Find_Msg2_loc							[Not found: searching for ]

	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Prompt_loc			[Prompt for the tool]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Description_loc		[Description for the tool]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_AppName_loc			[The name of the executable]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_StatusBarText_loc	[Status bar text for the menu item]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Summary_loc			[One-line summary for the tool]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Classes_loc			[List of classes to be published for this APP]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Source_loc			[Name of the tool]
	#Define		_Thor_utils_ThorInfo_GetSampleToolCode_Version_loc			[Version number]

	#Define		_Thor_utils_ThorInfo_Register_Prompt_loc					[used when tool appears in a menu]
	#Define		_Thor_utils_ThorInfo_Register_PRGName_loc					[a unique name for the tool; note the required prefix]
	#Define		_Thor_utils_ThorInfo_Register_Summary_loc					[if empty, first line of .Description is used]
	#Define		_Thor_utils_ThorInfo_Register_AppName_loc					[no path, but include the extension; thus GoFish4.App]
	#Define		_Thor_utils_ThorInfo_Register_FullAppName_loc				[full path to APP])
	#Define		_Thor_utils_ThorInfo_Register_FolderName_loc				[folder name for APP])
	#Define		_Thor_utils_ThorInfo_Register_Classes_loc					[separated by commas.  e.g.,  'thorinfo of thor_utils']
	#Define		_Thor_utils_ThorInfo_Register_SubCategory_loc				[Deprecated; use .Category instead with '|' as delimiter]
	#Define		_Thor_utils_ThorInfo_Register_Source_loc					[Deprecated; use .Category instead]
	#Define		_Thor_utils_ThorInfo_Register_Version_loc					[e.g., 'Version 7, May 18, 2011']
	#Define		_Thor_utils_ThorInfo_Register_Sort_loc						[the sort order for all items from the same .Source]
	#Define		_Thor_utils_ThorInfo_Register_Registered_loc				[* Registered with Thor: ]
#EndIf