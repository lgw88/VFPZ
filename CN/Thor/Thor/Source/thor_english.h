#include ThorVersion.h

* Key captions.

#define ccSHIFT					'Shift-'
#define ccCTRL					'Ctrl-'
#define ccALT					'Alt-'

#IF Version(3) = [86]
	* �˵����

	#define ccVFP_SYSTEM_MENU				'VFP ϵͳ�˵�'
	#define ccPOPUP_MENUS					'����ʽ�˵�(��ݼ�)'

	* �ؼ��ͱ�����

	#define ccTHOR_CAPTION					'Thor ����'
	#define ccHOTKEY						'��ݼ�(\<H)'
	#define ccEDIT_TOOL						'�༭����(\<E)'
	#define ccPRESS_HOTKEY					'������Ŀ�ݼ� ...'
	#define ccCANCEL_HOTKEY					'�� [Esc] �˳�'
	#define ccCLEAR							'����'
	#define ccCANCEL						'ȡ��'
	#define ccSave							'����'
	#define ccCreate						'����'
	#define ccCurrentFolder					'��ǰĿ¼'
	#define ccDefaultFolder					'Ĭ��Ŀ¼'
	#define ccTOOL_HOME_PAGE				'������ҳ'
	#define ccTOOL_VIDEO					'��Ƶ'
	#define ccPROGRAM						'����'
	#define ccFOLDERNAME					'Ŀ¼'
	#define ccSOURCE						'Դ'
	#define ccDESCRIPTION					'����'
	#define ccVERSION						'�汾'
	#define ccAUTHOR						'����'
	#define ccCAP_TOOL						'����(\<T)'
	#define ccADD							'����(\<A)'
	#define ccREMOVE						'�Ƴ�(\<R)'
	#define ccREMOVETool					'�Ӳ˵��Ƴ�����(\<R)'
	#define cnCOL2WIDTH						80
	#define cnCOL3WIDTH						50
	#define ccSTARTUP						'����'
	#define ccSTARTUPCAPTION				'�� Thor ����ʱ���д˹���'

	#define ccHotKeyColumHeading			'��ݼ�'
	#define ccSourceColumHeading			'Դ'
	#define ccDescriptColumHeading			'����'
	#define cnHotKeyCOL1WIDTH	 		   120
	#define cnHotKeyCOL2WIDTH				80
	#define cnHotKeyCOL3WIDTH				200

	#define ccREMOVEMenu					'�Ƴ��˵�(\<R)'
	#define ccPROMPT						'��ʾ��(\<P)'
	#define ccSTATUS_BAR					'״̬��(\<S)'
	#define ccORDER							'˳��'
	#define ccCREATE_TOOL					'��������(\<C)'
	#define ccOPEN_TOOL_FOLDER				'�� "My Tools" Ŀ¼(\<O)'
	#define ccADD_MENU						'���Ӳ˵�(\<A)'
	#define ccADD_SYSTEM_MENU_TOOLTIP		'�����²˵�� VFP ϵͳ�˵�'
	#define ccADD_POPUP_MENU_TOOLTIP		'�����µĵ���ʽ�˵�'
	#define ccADD_SUBMENU					'�����Ӳ˵�(\<M)'
	#define ccADD_TOOL						'���ӹ���(\<d)'
	#define ccADD_SEPARATOR					'���ӷָ��(\<e)'
	#define ccADD_AS_TOP_LEVEL				'������Ϊ����˵�(\<v)'
	#define ccADD_AS_POPUP					'������Ϊ�����˵�(\<u)'
	#define ccMENU_DEFINITIONS				'�˵�����'
	#define ccHOTKEY_ASSIGNMENTS			'ָ����ݼ�'
	#define ccTOOL_DEFINITIONS	   			'���߶���'
	#define ccOPTIONS						'ѡ��'
	#define ccTT_ADD_MENU_VFP				'�� VFP ϵͳ�˵�������һ���˵���'
	#define ccTT_ADD_MENU_POPUP				'����һ������ʽ�˵�'
	#define ccTT_ADD_SUBMENU				'����һ���Ӳ˵��� %1'
	#define ccTT_ADD_TOOL					'����һ�����ߵ� %1'
	#define ccTT_ADD_SEPARATOR				'����һ���ָ����� %1'
	#define ccCOPY_MENU						'���Ʋ˵�'
	#define ccADD_COPIED_MENU				'�����Ѹ��ƵĲ˵�'
	#define ccOPTION						'ѡ��'
	#define ccVALUE							'ֵ'
	#define ccVERSION						'�汾'
	#define ccTHOR_HOT_KEY					"Thor ר�ÿ�ݼ�"
	#define ccUPDATE_MESSAGE				'����ݼ��Ͳ˵����º���ʾ��Ϣ'
	#define ccFONT_SIZE						'�����С��'
	#define ccSYSTEM_MENU_PADS				'�����������ϵͳ�˵�(VPM, e.g.)'
	#define ccYES							'��'
	#define ccNO							'��'
	#define ccFILTER						'���߹�����'
	#define ccNoToolSelected				'<û��ѡ�񹤾�>'
	#define ccSelectFromTreeView			'<������� TreeView ��ѡ�񹤾�>'

	* ������Ϣ��
	
	#define ccINVALID_HOT_KEY				"������Ч�Ŀ�ݼ���"
	#define ccHOTKEY_ALREADY_USED			'��ݼ��ѱ�ʹ�á�'
	#define ccNO_TOOLS						'û�й����� Thor ��ע�ᡣ��ο� Thor �ĵ���'
	#define ccBLANK_PROMPT					'��ʾ������Ϊ�ա�'
	#define ccCANT_FIND						'%1 �޷��ҵ���'
	#define ccALREADY_EXISTS				'%1 �Ѵ��ڡ�'
	#define ccTOOL_PREFIX_ERROR				'���߳����������� "Thor_Tool_" ��ͷ��'

	* ������Ϣ��

	#define ccREMOVE_ITEM					'�Ƴ����'
	#define ccREMOVE_MENU					'�Ƴ��˲˵��������Ӳ˵���'
	#define ccRUN_THOR_DONE					'�˵��Ϳ�ݼ��ѱ����¡�'
	#define ccTOOLS_REFRESHED				'�����б���ˢ�¡�'

	#define ccHELP_TOOLTIP          		'����'
	#define ccTHOR_TOOLTIP					'ˢ�²˵��Ϳ�ݼ�'
	#define ccTOOL_TOOLTIP					'ˢ�¹����б�'
#ELSE
	* Menu categories.
	
	#define ccVFP_SYSTEM_MENU				'VFP System Menu'
	#define ccPOPUP_MENUS					'Popup Menus (Key Chords)'

	* Control and form captions.

	#define ccTHOR_CAPTION					'Thor Configuration'
	#define ccHOTKEY						'\<Hot key'
	#define ccEDIT_TOOL						'\<Edit Tool'
	#define ccPRESS_HOTKEY					'Press the desired hotkey ...'
	#define ccCANCEL_HOTKEY					'or [Esc] to cancel'
	#define ccCLEAR							'Clear'
	#define ccCANCEL						'Cancel'
	#define ccSave							'Save'
	#define ccCreate						'Create'
	#define ccCurrentFolder					'Current Folder'
	#define ccDefaultFolder					'Default Folder'
	#define ccTOOL_HOME_PAGE				'Tool home page'
	#define ccTOOL_VIDEO					'Video'
	#define ccPROGRAM						'Program'
	#define ccFOLDERNAME					'Folder'
	#define ccSOURCE						'Source'
	#define ccDESCRIPTION					'Description'
	#define ccVERSION						'Version'
	#define ccAUTHOR						'Author'
	#define ccCAP_TOOL						'\<Tool'
	#define ccADD							'\<Add'
	#define ccREMOVE						'\<Remove'
	#define ccREMOVETool					'\<Remove Tool from Menu'
	#define cnCOL2WIDTH						80
	#define cnCOL3WIDTH						50
	#define ccSTARTUP						'StartUp'
	#define ccSTARTUPCAPTION				'Run this tool when Thor starts'

	#define ccHotKeyColumHeading			'Hot Key'
	#define ccSourceColumHeading			'Source'
	#define ccDescriptColumHeading			'Description'
	#define cnHotKeyCOL1WIDTH	 		   120
	#define cnHotKeyCOL2WIDTH				80
	#define cnHotKeyCOL3WIDTH				200

	#define ccREMOVEMenu					'\<Remove Menu'
	#define ccPROMPT						'\<Prompt'
	#define ccSTATUS_BAR					'\<Status bar'
	#define ccORDER							'Order'
	#define ccCREATE_TOOL					'\<Create Tool'
	#define ccOPEN_TOOL_FOLDER				'\<Open "My Tools"'
	#define ccADD_MENU						'\<Add Menu'
	#define ccADD_SYSTEM_MENU_TOOLTIP		'Add a new menu pad to the VFP system menu'
	#define ccADD_POPUP_MENU_TOOLTIP		'Create a new popup menu'
	#define ccADD_SUBMENU					'Add Sub\<Menu'
	#define ccADD_TOOL						'A\<dd Tool'
	#define ccADD_SEPARATOR					'Add S\<eparator'
	#define ccADD_AS_TOP_LEVEL				'Add as Top Le\<vel'
	#define ccADD_AS_POPUP					'Add as Pop\<up'
	#define ccMENU_DEFINITIONS				'Menu Definitions'
	#define ccHOTKEY_ASSIGNMENTS			'Hot Key Assignments'
	#define ccTOOL_DEFINITIONS	  			'Tool Definitions'
	#define ccOPTIONS						'Options'
	#define ccTT_ADD_MENU_VFP				'Adds a menu to the VFP system menu bar'
	#define ccTT_ADD_MENU_POPUP				'Adds a popup menu'
	#define ccTT_ADD_SUBMENU				'Adds a submenu to %1'
	#define ccTT_ADD_TOOL					'Adds a tool to %1'
	#define ccTT_ADD_SEPARATOR				'Adds a separator to %1'
	#define ccCOPY_MENU						'Copy menu'
	#define ccADD_COPIED_MENU				'Add Copied Menu'
	#define ccOPTION						'Option'
	#define ccVALUE							'Value'
	#define ccVERSION						'Version'
	#define ccTHOR_HOT_KEY					"Dedicated hotkey for Thor's use"
	#define ccUPDATE_MESSAGE				'Display message when hotkeys and menus are updated'
	#define ccFONT_SIZE						'Font Size:'
	#define ccSYSTEM_MENU_PADS				'Other programs (VPM, e.g.) manage system menu pads'
	#define ccYES							'Yes'
	#define ccNO							'No'
	#define ccFILTER						'Tool filter'
	#define ccNoToolSelected				'<No Tool Selected>'
	#define ccSelectFromTreeView			'<Select tool from the TreeView below>'

	* Error messages.

	#define ccINVALID_HOT_KEY				"That isn't a valid hot key."
	#define ccHOTKEY_ALREADY_USED			'That hotkey is already in use.'
	#define ccNO_TOOLS						'No tools have been registered with Thor. Please see the Thor documentation.'
	#define ccBLANK_PROMPT					'You cannot have a blank prompt.'
	#define ccCANT_FIND						'%1 cannot be found.'
	#define ccALREADY_EXISTS				'%1 already exists.'
	#define ccTOOL_PREFIX_ERROR				'A tool program name must start with "Thor_Tool_".'

	* Other messages.

	#define ccREMOVE_ITEM					'Remove this item?'
	#define ccREMOVE_MENU					'Remove this menu and all submenus and items?'
	#define ccRUN_THOR_DONE					'Menus and hotkeys have been updated.'
	#define ccTOOLS_REFRESHED				'Tool lists have been refreshed.'

	#define ccHELP_TOOLTIP      		    'Help'
	#define ccTHOR_TOOLTIP					'Refresh menus and hotkeys'
	#define ccTOOL_TOOLTIP					'Refresh tool lists'
#ENDIF