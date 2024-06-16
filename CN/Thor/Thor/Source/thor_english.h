#include ThorVersion.h

* Key captions.

#define ccSHIFT					'Shift-'
#define ccCTRL					'Ctrl-'
#define ccALT					'Alt-'

#IF Version(3) = [86]
	* 菜单类别。

	#define ccVFP_SYSTEM_MENU				'VFP 系统菜单'
	#define ccPOPUP_MENUS					'弹出式菜单(快捷键)'

	* 控件和表单标题

	#define ccTHOR_CAPTION					'Thor 配置'
	#define ccHOTKEY						'快捷键(\<H)'
	#define ccEDIT_TOOL						'编辑工具(\<E)'
	#define ccPRESS_HOTKEY					'按所需的快捷键 ...'
	#define ccCANCEL_HOTKEY					'或 [Esc] 退出'
	#define ccCLEAR							'清理'
	#define ccCANCEL						'取消'
	#define ccSave							'保存'
	#define ccCreate						'创建'
	#define ccCurrentFolder					'当前目录'
	#define ccDefaultFolder					'默认目录'
	#define ccTOOL_HOME_PAGE				'工具主页'
	#define ccTOOL_VIDEO					'视频'
	#define ccPROGRAM						'程序'
	#define ccFOLDERNAME					'目录'
	#define ccSOURCE						'源'
	#define ccDESCRIPTION					'描述'
	#define ccVERSION						'版本'
	#define ccAUTHOR						'作者'
	#define ccCAP_TOOL						'工具(\<T)'
	#define ccADD							'增加(\<A)'
	#define ccREMOVE						'移除(\<R)'
	#define ccREMOVETool					'从菜单移除工具(\<R)'
	#define cnCOL2WIDTH						80
	#define cnCOL3WIDTH						50
	#define ccSTARTUP						'启动'
	#define ccSTARTUPCAPTION				'当 Thor 启动时运行此工具'

	#define ccHotKeyColumHeading			'快捷键'
	#define ccSourceColumHeading			'源'
	#define ccDescriptColumHeading			'描述'
	#define cnHotKeyCOL1WIDTH	 		   120
	#define cnHotKeyCOL2WIDTH				80
	#define cnHotKeyCOL3WIDTH				200

	#define ccREMOVEMenu					'移除菜单(\<R)'
	#define ccPROMPT						'提示符(\<P)'
	#define ccSTATUS_BAR					'状态栏(\<S)'
	#define ccORDER							'顺序'
	#define ccCREATE_TOOL					'创建工具(\<C)'
	#define ccOPEN_TOOL_FOLDER				'打开 "My Tools" 目录(\<O)'
	#define ccADD_MENU						'增加菜单(\<A)'
	#define ccADD_SYSTEM_MENU_TOOLTIP		'增加新菜单项到 VFP 系统菜单'
	#define ccADD_POPUP_MENU_TOOLTIP		'创建新的弹出式菜单'
	#define ccADD_SUBMENU					'增加子菜单(\<M)'
	#define ccADD_TOOL						'增加工具(\<d)'
	#define ccADD_SEPARATOR					'增加分割符(\<e)'
	#define ccADD_AS_TOP_LEVEL				'增加作为顶层菜单(\<v)'
	#define ccADD_AS_POPUP					'增加作为弹出菜单(\<u)'
	#define ccMENU_DEFINITIONS				'菜单定义'
	#define ccHOTKEY_ASSIGNMENTS			'指定快捷键'
	#define ccTOOL_DEFINITIONS	   			'工具定义'
	#define ccOPTIONS						'选项'
	#define ccTT_ADD_MENU_VFP				'在 VFP 系统菜单栏增加一个菜单项'
	#define ccTT_ADD_MENU_POPUP				'增加一个弹出式菜单'
	#define ccTT_ADD_SUBMENU				'增加一个子菜单到 %1'
	#define ccTT_ADD_TOOL					'增加一个工具到 %1'
	#define ccTT_ADD_SEPARATOR				'增加一个分隔符到 %1'
	#define ccCOPY_MENU						'复制菜单'
	#define ccADD_COPIED_MENU				'增加已复制的菜单'
	#define ccOPTION						'选项'
	#define ccVALUE							'值'
	#define ccVERSION						'版本'
	#define ccTHOR_HOT_KEY					"Thor 专用快捷键"
	#define ccUPDATE_MESSAGE				'当快捷键和菜单更新后显示消息'
	#define ccFONT_SIZE						'字体大小：'
	#define ccSYSTEM_MENU_PADS				'其他程序管理系统菜单(VPM, e.g.)'
	#define ccYES							'是'
	#define ccNO							'否'
	#define ccFILTER						'工具过滤器'
	#define ccNoToolSelected				'<没有选择工具>'
	#define ccSelectFromTreeView			'<在下面的 TreeView 中选择工具>'

	* 错误消息。
	
	#define ccINVALID_HOT_KEY				"不是有效的快捷键。"
	#define ccHOTKEY_ALREADY_USED			'快捷键已被使用。'
	#define ccNO_TOOLS						'没有工具在 Thor 中注册。请参看 Thor 文档。'
	#define ccBLANK_PROMPT					'提示符不能为空。'
	#define ccCANT_FIND						'%1 无法找到。'
	#define ccALREADY_EXISTS				'%1 已存在。'
	#define ccTOOL_PREFIX_ERROR				'工具程序名必须以 "Thor_Tool_" 开头。'

	* 其他消息。

	#define ccREMOVE_ITEM					'移除此项？'
	#define ccREMOVE_MENU					'移除此菜单及所有子菜单？'
	#define ccRUN_THOR_DONE					'菜单和快捷键已被更新。'
	#define ccTOOLS_REFRESHED				'工具列表已刷新。'

	#define ccHELP_TOOLTIP          		'帮助'
	#define ccTHOR_TOOLTIP					'刷新菜单和快捷键'
	#define ccTOOL_TOOLTIP					'刷新工具列表'
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