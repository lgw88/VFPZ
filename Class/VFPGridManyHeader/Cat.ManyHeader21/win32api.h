*--
*-- 自用常量
*--
#Define CR			Chr(13)
#Define LF			Chr(10)
#Define CRLF		CR + LF
#Define TRUE		.T. 
#Define FALSE		.F. 
*--
*-- data types 
*--
#Define WORD_SIZE			2
#Define DWORD_SIZE			4

*--
*-- 常用结构的大小
*--
#Define POINT_SIZE				DWORD_SIZE * 2
#Define RECT_SIZE				DWORD_SIZE * 4
#Define BITMAP_SIZE				DWORD_SIZE * 4 + WORD_SIZE * 2 + DWORD_SIZE
#Define DRAWITEMSTRUCT_SIZE		64
#Define MEASUREITEMSTRUCT_SIZE	DWORD_SIZE * 6
#Define ICONINFO_SIZE			DWORD_SIZE * 5

***
*** 未整理
***
#Define BI_RGB 				0x00 
#Define DIB_RGB_COLORS 		0 

#Define TS_MIN  		0 
#Define TS_TRUE 		1 
#Define TS_DRAW 		2 


*--
*-- 	Window messages
*--
#Define WM_NULL					0x00		&& ??
#Define WM_CREATE        		0x01		&& 创建一个窗口
#Define WM_DESTROY				0x02		&& 窗口被销毁
#Define WM_MOVE					0x03		&& 移动窗口时
#Define WM_SIZE					0x05		&& 改变一个窗口的大小
#Define WM_ACTIVATE				0x06		&& 激活一个窗口
#Define WM_SETFOCUS				0x07		&& 窗口得到焦点时
#Define WM_KILLFOCUS			0x08		&& 失去焦点时
#Define WM_ENABLE				0x0A		&& 改变enable状态 
#Define WM_SETREDRAW			0x0B		&& 设置窗口是否能重画 
#Define WM_SETTEXT				0x0C		&& 应用程序发送此消息来设置一个窗口的文本
#Define WM_GETTEXT				0x0D
#Define WM_GETTEXTLENGTH 		0x0E
#Define WM_PAINT				0x0F		&& 要求重画自己
#Define WM_CLOSE				0x10		&& 当一个窗口或应用程序要关闭时发送一个信号 
#Define WM_QUERYENDSESSION		0x11
#Define WM_QUIT					0x12
#Define WM_QUERYOPEN			0x13
#Define WM_ERASEBKGND 			0x14
#Define WM_SYSCOLORCHANGE		0x15		&& 当系统颜色改变时，发送此消息给所有顶级窗口
#Define WM_ENDSESSION			0x16
#Define WM_SHOWWINDOW			0x18
#Define WM_WININICHANGE			0x1A		&& Win.ini 文件被改变，系统以广播形式通知每个窗口
#Define WM_DEVMODECHANGE		0x1B
#Define WM_ACTIVATEAPP			0x1C
#Define WM_FONTCHANGE			0x1D
#Define WM_TIMECHANGE			0x1E
#Define WM_CANCELMODE			0x1F
#Define WM_SETCURSOR			0x20		&& 鼠标的形状改变时
#Define WM_MOUSEACTIVATE		0x21
#Define WM_CHILDACTIVATE		0x22
#Define WM_QUEUESYNC			0x23
#Define WM_GETMINMAXINFO		0x24
#Define WM_PAINTICON 			0x26
#Define WM_ICONERASEBKGND		0x27
#Define WM_NEXTDLGCTL			0x28
#Define WM_SPOOLERSTATUS		0x2A
#Define WM_DRAWITEM				0x2B		&& 绘制菜单项
#Define WM_MEASUREITEM			0x2C 		&& 测量菜单高度和宽度 
#Define WM_DELETEITEM			0x2D
#Define WM_VKEYTOITEM			0x2E
#Define WM_CHARTOITEM			0x2F
#Define WM_SETFONT				0x30
#Define WM_GETFONT				0x31
#Define WM_SETHOTKEY			0x32
#Define WM_GETHOTKEY			0x33
#Define WM_QUERYDRAGICON 		0x37
#Define WM_COMPAREITEM			0x39		&& 发送此消息来判定 combobox 或 listbox 新增加的项的相对位置
#Define WM_GETOBJECT			0x3D
#Define WM_COMPACTING			0x41		&& 显示内存已经很少了
#Define WM_OTHERWINDOWCREATED	0x42
#Define WM_OTHERWINDOWDESTROYED	0x43
#Define WM_COMMNOTIFY 			0x44
#Define WM_WINDOWPOSCHANGING	0x46		&& 窗口的大小和位置将要被改变时
#Define WM_WINDOWPOSCHANGED		0x47		&& 发送此消息给那个窗口的大小和位置已经被改变
#Define WM_POWER				0x48		&& (适用于16位的windows） 当系统将要进入暂停状态时发送此消息 
#Define WM_HELP 				0x53
#Define WM_COPYDATA 			0x4A		&& 当一个应用程序传递数据给另一个应用程序时发送此消息
#Define WM_CANCELJOURNAL 		0x4B		&& 当某个用户取消程序日志激活状态，提交此消息给程序 
#Define WM_NOTIFY 				0x4E 		&& 当某个控件的某个事件已经发生或这个控件需要得到一些信息时，发送此消息给它的父窗口
#Define WM_CONTEXTMENU			0x7B		&& 当用户某个窗口中点击了一下右键就发送此消息给这个窗口
#Define WM_STYLECHANGED			0x7D		&& 当调用SETWINDOWLONG函数一个或多个窗口的风格后发送此消息给那个窗口
#Define WM_SETICON 				0x80		&& 应用程序发送此消息让一个新的大图标或小图标与窗口关联
#Define WM_NCCREATE				0x81
#Define WM_NCDESTROY			0x82
#Define WM_NCCALCSIZE			0x83
#Define WM_NCHITTEST			0x84		&& 在整个窗口内移动鼠标
#Define WM_NCPAINT				0x85		&& 当窗口的框架必须被绘制时(大小改变或者风格改变?)
#Define WM_NCACTIVATE			0x86 		&& 窗口非客户区需要被改变来显示是激活还是非激活状态
#Define WM_GETDLGCODE			0x87
#Define WM_SYNCPAINT 			0x88
#Define WM_NCMOUSEMOVE			0xA0		&& 鼠标在窗口非客户区内移动，非客户区指:窗体的标题栏及窗的边框体
#Define WM_NCLBUTTONDOWN		0xA1		&& 鼠标在窗口非客户区内按下鼠标左键时
#Define WM_NCLBUTTONUP			0xA2		&& 鼠标在窗口非客户区内抬起鼠标左键时
#Define WM_NCLBUTTONDBLCLK		0xA3		&& 鼠标在窗口非客户区内双击鼠标左键时
#Define WM_NCRBUTTONDOWN		0xA4		&& 鼠标在窗口非客户区内按下鼠标右键时
#Define WM_NCRBUTTONUP			0xA5		&& 鼠标在窗口非客户区内抬起鼠标右键时
#Define WM_NCRBUTTONDBLCLK		0xA6		&& 鼠标在窗口非客户区内双击鼠标右键时
#Define WM_NCMBUTTONDOWN		0xA7
#Define WM_NCMBUTTONUP 			0xA8
#Define WM_NCMBUTTONDBLCLK		0xA9
#Define WM_KEYFIRST 			0x0100
#Define WM_KEYDOWN				0x0100		&& 按下一个键时
#Define WM_KEYUP				0x0101		&& 抬起一个键
#Define WM_CHAR					0x0102		&& 按下了某键，并已发出 WM_KEYDOWN 与 WM_KEYUP 消息
#Define WM_DEADCHAR				0x0103		&& 当用 translatemessage 函数翻译 WM_KEYUP 消息时发送此消息给拥有焦点的窗口
#Define WM_SYSKEYDOWN			0x0104		&& 当用户按住 ALT 键同时按下其它键时提交此消息给拥有焦点的窗口
#Define WM_SYSKEYUP				0x0105		&& 当用户释放一个键同时 ALT 键还按着时提交此消息给拥有焦点的窗口
#Define WM_SYSCHAR				0x0106		&& 当 WM_SYSKEYDOWN 消息被 TRANSLATEMESSAGE 函数翻译后提交此消息给拥有焦点的窗口
#Define WM_SYSDEADCHAR			0x0107		&& 当 WM_SYSKEYDOWN 消息被 TRANSLATEMESSAGE 函数翻译后发送此消息给拥有焦点的窗口
#Define WM_KEYLAST				0x0108
#Define WM_INITDIALOG			0x0110		&& 在一个对话框程序被显示前发送此消息给它,常用此消息初始化控件和执行其它任务
#Define WM_COMMAND				0x0111		&& 选择菜单项
#Define WM_SYSCOMMAND			0x0112		&& 窗口菜单的一条命令或当用户选择最大化或最小化时那个窗口时
#Define WM_TIMER				0x0113
#Define WM_INITMENU				0x0116		&& 当一个菜单将要被激活时发送此消息，它发生在用户菜单条中的某项或按下某个菜单键
#Define WM_INITMENUPOPUP		0x0117		&& 当一个下拉菜单或子菜单将要被激活时发送此消息
#Define WM_MENUSELECT			0x011F		&& 选择菜单项
#Define WM_MENUCHAR				0x0120		&& 当菜单已被激活用户按下了某个键（不同于访问键），发送此消息给菜单的所有者
#Define WM_ENTERIDLE			0x0121		&& 当一个模态对话框或菜单进入空载状态时发送此消息给它的所有者
#Define WM_MENURBUTTONUP		0x0122
#Define WM_MENUDRAG				0x0123
#Define WM_MENUGETOBJECT		0x0124
#Define WM_UNINITMENUPOPUP		0x0125
#Define WM_CTLCOLORMSGBOX		0x0132
#Define WM_CTLCOLOREDIT			0x0133
#Define WM_CTLCOLORLISTBOX		0x0134
#Define WM_CTLCOLORBTN 			0x0135
#Define WM_CTLCOLORDLG			0x0136
#Define WM_CTLCOLORSCROLLBAR	0x0137
#Define WM_CTLCOLORSTATIC		0x0138
#Define WM_MOUSEFIRST 			0x0200
#Define WM_MOUSEMOVE 			0x0200
#Define WM_LBUTTONDOWN			0x0201		&& 在窗口客户区内按下鼠标左键
#Define WM_LBUTTONUP			0x0202		&& 在窗口客户区内抬起鼠标左键
#Define WM_LBUTTONDBLCLK		0x0203		&& 在窗口客户区内双击鼠标左键
#Define WM_RBUTTONDOWN			0x0204		&& 在窗口客户区内按下鼠标右键
#Define WM_RBUTTONUP			0x0205		&& 在窗口客户区内抬起鼠标右键
#Define WM_RBUTTONDBLCLK		0x0206		&& 在窗口客户区内双击鼠标右键
#Define WM_MBUTTONDOWN			0x0204		&& 在窗口客户区内按下鼠标中键
#Define WM_MBUTTONUP			0x0205		&& 在窗口客户区内抬起鼠标中键
#Define WM_MBUTTONDBLCLK		0x0206		&& 在窗口客户区内双击鼠标中键
#Define WM_MBUTTONDOWN			0x0207
#Define WM_MBUTTONUP			0x0208
#Define WM_MBUTTONDBLCLK		0x0209
#Define WM_MOUSELAST			0x0209
#Define WM_PARENTNOTIFY			0x0210
#Define WM_ENTERMENULOOP 		0x0211
#Define WM_EXITMENULOOP 		0x0212		&& 退出菜单消息循环
#Define WM_NEXTMENU				0x0213
#Define WM_SIZING 				0x0214
#Define WM_CAPTURECHANGED		0x0215
#Define WM_MDICREATE			0x0220
#Define WM_MDIDESTROY			0x0221
#Define WM_MDIACTIVATE			0x0222
#Define WM_MDIRESTORE			0x0223
#Define WM_MDINEXT				0x0224
#Define WM_MDIMAXIMIZE			0x0225
#Define WM_MDITILE				0x0226
#Define WM_MDICASCADE			0x0227
#Define WM_MDIICONARRANGE		0x0228
#Define WM_MDIGETACTIVE			0x0229
#Define WM_MDISETMENU			0x0230
#Define WM_DROPFILES			0x0233
#Define WM_MDIREFRESHMENU 		0x0234
#Define WM_IME_SETCONTEXT 		0x0281
#Define WM_CUT 					0x0300
#Define WM_COPY					0x0301
#Define WM_PASTE				0x0302
#Define WM_CLEAR				0x0303
#Define WM_UNDO					0x0304
#Define WM_RENDERFORMAT			0x0305
#Define WM_RENDERALLFORMATS 	0x0306
#Define WM_DESTROYCLIPBOARD 	0x0307
#Define WM_DRAWCLIPBOARD		0x0308
#Define WM_PAINTCLIPBOARD		0x0309
#Define WM_VSCROLLCLIPBOARD		0x030A
#Define WM_SIZECLIPBOARD		0x030B
#Define WM_ASKCBFORMATNAME 		0x030C
#Define WM_CHANGECBCHAIN		0x030D
#Define WM_HSCROLLCLIPBOARD		0x030E
#Define WM_QUERYNEWPALETTE		0x030F
#Define WM_PALETTEISCHANGING	0x0310
#Define WM_PALETTECHANGED		0x0311
#Define WM_HOTKEY				0x0312
#Define WM_THEMECHANGED 		0x031A		&& 当系统主题改变时(xp)
#Define WM_PENWINFIRST			0x0380
#Define WM_PENWINLAST			0x038F
#Define WM_USER					0x0400		&& 最低用户可用自定义消息
#Define WM_SETTINGCHANGE		WM_WININICHANGE
*--
*-- 	Message SYSCOMMAND by wPara
*--
#Define SC_SIZE							0xF000
#Define SC_MOVE							0xF010
#Define SC_MINIMIZE						0xF020
#Define SC_MAXIMIZE 					0xF030
#Define SC_NEXTWINDOW					0xF040
#Define SC_PREVWINDOW					0xF050
#Define SC_CLOSE						0xF060
#Define SC_VSCROLL						0xF070
#Define SC_HSCROLL						0xF080
#Define SC_MOUSEMENU					0xF090
#Define SC_KEYMENU						0xF100
#Define SC_ARRANGE						0xF110
#Define SC_RESTORE						0xF120
#Define SC_TASKLIST						0xF130
#Define SC_SCREENSAVE					0xF140
#Define SC_HOTKEY 						0xF150
#Define SC_ICON							SC_MINIMIZE
#Define SC_ZOOM							SC_MAXIMIZE
#Define SC_MANAGER_CONNECT  			0x01
#Define SC_MANAGER_CREATE_SERVICE 		0x02
#Define SC_MANAGER_ENUMERATE_SERVICE 	0x04
#Define SC_MANAGER_LOCK					0x08
#Define SC_MANAGER_QUERY_LOCK_STATUS  	0x10
#Define SC_MANAGER_MODIFY_BOOT_CONFIG  	0x20
#Define SC_MANAGER_ALL_ACCESS  			STANDARD_RIGHTS_REQUIRED ;
										+ SC_MANAGER_CONNECT ;
										+ SC_MANAGER_CREATE_SERVICE ;
										+ SC_MANAGER_ENUMERATE_SERVICE ;
										+ SC_MANAGER_LOCK ;
										+ SC_MANAGER_QUERY_LOCK_ST
#Define SC_FLAGS 						0x0400
#Define SC_FLAGS_STR 					"/sc"
#Define SC_GROUP_IDENTIFIER  			"+"
#Define SC_GROUP_IDENTIFIERA 			"+"
#Define SC_GROUP_IDENTIFIERW 			"+"
      
#Define MSGF_DIALOGBOX 		0
#Define MSGF_MESSAGEBOX 	1
#Define MSGF_MENU 			2
#Define MSGF_MOVE 			3
#Define MSGF_SIZE 			4
#Define MSGF_SCROLLBAR 		5
#Define MSGF_NEXTWINDOW 	6
#Define MSGF_MAINLOOP 		8
#Define MSGF_MAX 			8
#Define MSGF_USER 			0x1000
#Define MSGF_DDEMGR  		0x8001

*--
*--  ??? To WM_MENUCHAR
*--

#Define MNC_CLOSE		1
#Define MNC_EXECUTE		2
#Define MNC_IGNORE 		0
#Define MNC_SELECT		3

#Define MND_CONTINUE 	0
#Define MND_ENDMENU 	1
      
*--
*--  dwStyle To CreateWindow
*--
#Define WS_MAXIMIZEBOX 		0x010000 		&& 有最大化按钮
#Define WS_MINIMIZEBOX 		0x020000		&& 有最小化按钮
#Define WS_THICKFRAME 		0x040000		&& 有可调边框(与 WS_SIZEBOX 样式相同)
#Define WS_SYSMENU 			0x080000		&& 标题框上带有窗口菜单(须指定 WS_CAPTION 样式)
#Define WS_HSCROLL 			0x100000		&& 有水平滚动条
#Define WS_VSCROLL 			0x200000		&& 有垂直滚动条
#Define WS_DLGFRAME 		0x400000		&& 带对话框边框样式,不带标题框
#Define WS_BORDER 			0x800000		&& 有单边框
#Define WS_CAPTION 			0xC00000		&& 有标题框和边框(和WS_TILED样式相同)
#Define WS_MAXIMIZE 		0x01000000		&& 具有最大化按钮,须指定WS_SYSTEM样式
#Define WS_CLIPCHILDREN 	0x02000000		&& 当在父窗口内绘图时,排除子窗口区域
#Define WS_CLIPSIBLINGS 	0x04000000		&& 使窗口排除子窗口之间的相对区域
#Define WS_DISABLED 		0x08000000		&& 不可用状态
#Define WS_VISIBLE 			0x10000000		&& 可见状态
#Define WS_MINIMIZE 		0x20000000		&& 最小化状态
#Define WS_CHILD 			0x40000000		&& 
#Define WS_POPUP 			0x80000000 		&& 弹出式窗口(不能与WS_CHILDWINDOW样式同时使用)
#Define WS_SIZEBOX  		WS_THICKFRAME	&& 可调整大小的边框
#Define WS_CHILDWINDOW 		WS_CHILD		&& 子窗口(不能与WS_POPUP合用)
*
#Define WS_TABSTOP 			0x010000		&& 可接受 TAB 键焦点
#Define WS_GROUP 			0x020000		&& 组样式,每个组的第一个控件具有 WS_TABSTOP 样式
#Define WS_OVERLAPPEDWINDOW (WS_OVERLAPPED + WS_CAPTION + WS_SYSMENU + WS_THICKFRAME + WS_MINIMIZEBOX + WS_MAXIMIZEBOX) 
											&& 具有层叠,标题框,系统菜单,可调边框,系统按钮
#Define WS_POPUPWINDOW 		(WS_POPUP + WS_BORDER + WS_SYSMENU)
											&& 具有单边框,弹出式,系统菜单样式
*--
*-- 	dwExStyle To CreateWindowEx
*--
#Define WS_EX_DLGMODALFRAME 	0x01		&& 带双层边框
#Define WS_EX_NOPARENTNOTIFY 	0x04		&& 创建/销毁时不通知父窗口
#Define WS_EX_TOPMOST 			0x08		&& 窗口置顶(停留在所有非最高层窗口的上面)
#Define WS_EX_ACCEPTFILES 		0x10		&& 可接受文件拖放
#Define WS_EX_TRANSPARENT 		0x20		&& 透明样式,在同属窗口已重画时该窗口才可重画
#Define WS_EX_MDICHILD 			0x40		&& MDI子窗口样式
#Define WS_EX_TOOLWINDOW 		0x80		&& 工具条窗口样式
#Define WS_EX_WINDOWEDGE 		0x0100		&& 带凸起边缘的边框
#Define WS_EX_CLIENTEDGE 		0x0200		&& 带阴影的边缘
#Define WS_EX_CONTEXTHELP 		0x0400		&& 有上下文帮助样式,标题栏包含一个问号标志
#Define WS_EX_RIGHT 			0x1000		&& 右对齐
#Define WS_EX_RTLREADING 		0x2000		&& 窗口文本从右到左显示
#Define WS_EX_LEFTSCROLLBAR 	0x4000		&& 垂直滚动条在窗口左边界
#Define WS_EX_CONTROLPARENT 	0x010000	&& 允许用户使用TAB键在窗口的子窗口间搜索
#Define WS_EX_STATICEDGE 		0x020000	&& 当窗口为不可用状态时创建一个三维边缘
#Define WS_EX_APPWINDOW 		0x040000	&& 当窗口可见时将一个顶层窗口放置在任务栏上
#Define WS_EX_OVERLAPPEDWINDOW 	(WS_EX_WINDOWEDGE + WS_EX_CLIENTEDGE)
											&& 带凸起边缘的边框,边缘有阴影
#Define WS_EX_PALETTEWINDOW 	(WS_EX_WINDOWEDGE + WS_EX_TOOLWINDOW + WS_EX_TOPMOST)
											&& 带立体边框,有工具条窗口样式,窗口在顶层
#Define WS_EX_LAYERED 			0x080000	&& 分层或透明窗口,该样式可使用混合特效
#Define WS_EX_NOINHERITLAYOUT 	0x100000	&& 子控件不继承窗体或控件的布局
#Define WS_EX_LAYOUTRTL 		0x400000	&& 窗体或控件将具有从右向左的布局(因而会被镜像)
#Define WS_EX_NOACTIVATE 		0x08000000	&& 处于顶层但不激活
* WS_EX_COMPOSITED 					&& 用双缓冲从下到上绘制窗口的所有子孙(WinXP以上)

*--
*--		 ??? to CreateWindowEx
*-- 
#Define CW_USEDEFAULT			0x80000000 

*--
*--		 TOOLINFO
*-- 
#Define TTS_ALWAYSTIP			0x01		&& 即使窗口没有获得焦点，也显示提示
#Define TTS_NOPREFIX			0x02
#Define TTS_NOANIMATE			0x10
#Define TTS_NOFADE				0x20
#Define TTS_BALLOON				0x40		&& 汽球提示，反之矩形
#Define TTS_CLOSE				0x80
#Define TTS_USEVISUALSTYLE		0x0100		&& VISTA

#Define TTI_NONE 				0x00		&& 无图标
#Define TTI_INFO				0x01		&& 信息
#Define TTI_WARNING				0x02		&& 警告
#Define TTI_ERROR 				0x03		&& 错误

#Define TTDT_AUTOMATIC 			0x00
#Define TTDT_RESHOW 			0x01
#Define TTDT_AUTOPOP 			0x02
#Define TTDT_INITIAL			0x03

#Define TTF_IDISHWND 			0x01
#Define TTF_CENTERTIP 			0x02		&& 工具提示总显示在焦点域总的中下方
#Define TTF_RTLREADING 			0x04		&& 文本以从右至左的顺序显示（仅对阿拉伯或希伯来语，其他系统无效）
#Define TTF_SUBCLASS 			0x10		&& 工具提示控件将子类化"工具"所在窗口以便截取发送给它的的鼠标消息
#Define TTF_TRACK				0x20
#Define TTF_ABSOLUTE			0x80		&& 绝对位置，就算屏幕无法显示，也不会改变显示位置
#Define TTF_TRANSPARENT			0x0100
#Define TTF_PARSELINKS			0x1000
#Define TTF_DI_SETITEM			0x8000
#Define TTF_BITMAP				0x10000		&& VISTA

#Define TTM_ACTIVATE			WM_USER + 01
#Define TTM_SETDELAYTIME 		WM_USER + 03	&& 设置 Tooltip 时间
#Define TTM_ADDTOOL				WM_USER + 04	&& 添加 Tooltip
#Define TTM_ADDTOOLA			WM_USER + 04	&& （不清楚与 TTM_ADDTOOLA 有什么不同）
#Define TTM_DELTOOLA 			WM_USER + 05
#Define TTM_NEWTOOLRECTA		WM_USER + 06
#Define TTM_RELAYEVENT			WM_USER + 07
#Define TTM_GETTOOLINFOA		WM_USER + 08
#Define TTM_SETTOOLINFOA		WM_USER + 09
#Define TTM_HITTESTA			WM_USER + 10
#Define TTM_GETTEXTA			WM_USER + 11
#Define TTM_UPDATETIPTEXTA		WM_USER + 12
#Define TTM_GETTOOLCOUNT		WM_USER + 13
#Define TTM_ENUMTOOLSA			WM_USER + 14
#Define TTM_GETCURRENTTOOLA		WM_USER + 15
#Define TTM_WINDOWFROMPOINT		WM_USER + 16
#Define TTM_TRACKACTIVATE		WM_USER + 17
#Define TTM_TRACKPOSITION		WM_USER + 18
#Define TTM_SETTIPBKCOLOR		WM_USER + 19	&& 设置背景颜色
#Define TTM_SETTIPTEXTCOLOR		WM_USER + 20	&& 设置文本颜色
#Define TTM_GETDELAYTIME		WM_USER + 21
#Define TTM_GETTIPBKCOLOR		WM_USER + 22
#Define TTM_GETTIPTEXTCOLOR		WM_USER + 23
#Define TTM_SETMAXTIPWIDTH		WM_USER + 24	&& 设置最大宽度
#Define TTM_GETMAXTIPWIDTH		WM_USER + 25
#Define TTM_SETMARGIN			WM_USER + 26
#Define TTM_GETMARGIN			WM_USER + 27
#Define TTM_POP					WM_USER + 28
#Define TTM_UPDATE				WM_USER + 29
#Define TTM_GETBUBBLESIZE		WM_USER + 30
#Define TTM_ADJUSTRECT			WM_USER + 31
#Define TTM_SETTITLEA 			WM_USER + 32	&& 设置标题
#Define TTM_SETTITLEW			WM_USER + 33
#Define TTM_POPUP				WM_USER + 34
#Define TTM_ADDTOOLW			WM_USER + 50
#Define TTM_DELTOOLW			WM_USER + 51
#Define TTM_NEWTOOLRECTW		WM_USER + 52
#Define TTM_GETTOOLINFOW		WM_USER + 53
#Define TTM_SETTOOLINFOW		WM_USER + 54
#Define TTM_HITTESTW			WM_USER + 55
#Define TTM_GETTEXTW			WM_USER + 56
#Define TTM_UPDATETIPTEXTW		WM_USER + 57
#Define TTM_ENUMTOOLSW			WM_USER + 58
#Define TTM_GETCURRENTTOOLW		WM_USER + 59
* #Define TTM_SETWINDOWTHEME = CCM_SETWINDOWTHEME

#Define LPSTR_TEXTCALLBACKA 	-1
#Define LPSTR_TEXTCALLBACKW 	-1

#Define TTN_FIRST 			-520
#Define TTN_LAST 			-549
#Define TTN_GETDISPINFOA	TTN_FIRST - 0
#Define TTN_GETDISPINFOW 	TTN_FIRST - 10
#Define TTN_LINKCLICK		TTN_FIRST - 3
* #Define TTN_NEEDTEXT 		TTN_GETDISPINFO
#Define TTN_NEEDTEXTA		TTN_GETDISPINFOA
#Define TTN_NEEDTEXTW		TTN_GETDISPINFOW
#Define TTN_POP				TTN_FIRST - 2
#Define TTN_SHOW 			TTN_FIRST - 1
*--
*-- 控件样式参考
*--
#Define LVS_ICON 				0			&& 大图标
#Define LVS_REPORT 				0x01		&& 详细资料
#Define LVS_SMALLICON 			0x02		&& 小图标
#Define LVS_LIST 				0x03		&& 列表
#Define LVS_SINGLESEL 			0x04		&& 只能单选
#Define LVS_SHOWSELALWAYS 		0x08		&& 始终显示所选中项(包括失去焦点时)
#Define LVS_SORTASCENDING 		0x10		&& 按升序排序
#Define LVS_SORTDESCENDING 		0x20		&& 按降序排序
#Define LVS_SHAREIMAGELISTS 	0x40		&& 共享图像列表(当控件销毁时图像列表仍可用)
#Define LVS_NOLABELWRAP 		0x80		&& 文字不换行
#Define LVS_AUTOARRANGE 		0x0100		&& 自动排列
#Define LVS_EDITLABELS 			0x0200		&& 允许编辑标签(类似资源管理器的文件更名)
#Define LVS_OWNERDATA 			0x1000		&& 指定一个虚拟的ListView, 由用户自己管理Item数据
#Define LVS_NOSCROLL 			0x2000		&& 禁止滚动条(对LVS_LIST和LVS_REPORT样式不适用)
#Define LVS_ALIGNTOP 			0			&& 顶端对齐
#Define LVS_ALIGNLEFT 			0x0800		&& 左对齐
#Define LVS_OWNERDRAWFIXED 		0x0400		&& 允许自画(仅详细资料模式)
#Define LVS_NOCOLUMNHEADER 		0x4000		&& 详细资料模式时不显示列头
#Define LVS_NOSORTHEADER 		0x8000		&& 列头显示为平面,不响应鼠标点击(详细资料模式)
* 			扩展控件样式参考列表
#Define LVS_EX_GRIDLINES 		0x01		&& 显示表格线(仅详细资料模式)
#Define LVS_EX_SUBITEMIMAGES 	0x02		&& 允许子项目显示图像(仅详细资料模式)
#Define LVS_EX_CHECKBOXES 		0x04		&& 在各项目前面显示复选框
#Define LVS_EX_TRACKSELECT 		0x08		&& 允许热点选择
#Define LVS_EX_HEADERDRAGDROP 	0x10		&& 允许通过拖放列头来重新安排各列(详细资料模式)
#Define LVS_EX_FULLROWSELECT 	0x20		&& 允许选择整行(仅详细资料模式)
#Define LVS_EX_ONECLICKACTIVATE 0x40		&& 单击项目激活
#Define LVS_EX_TWOCLICKACTIVATE 0x80		&& 双击项目激活
#Define LVS_EX_FLATSB 			0x0100		&& 平面滚动条
#Define LVS_EX_REGIONAL	 		0x0200		&& 项目范围只包括图标不透明区域和文字区域(大图标模式)
#Define LVS_EX_INFOTIP 			0x0400		&& 将提示信息窗口的消息通知父窗口
#Define LVS_EX_UNDERLINEHOT 	0x0800		&& 带热点的项目文字带下划线
#Define LVS_EX_UNDERLINECOLD 	0x1000		&& 非热点的项目文字带下划线
#Define LVS_EX_MULTIWORKAREAS 	0x2000		&& 多个工作区(需在没有添加项目前设置)
#Define LVS_EX_LABELTIP 		0x4000		&& 如果没有提示信息文本就展开隐藏的标签
#Define LVS_EX_BORDERSELECT 	0x8000		&& 用选择边框的样式代替高亮
#Define LVS_EX_DOUBLEBUFFER 	0x010000 	&& 双缓冲(WinXP以上)
#Define LVS_EX_HIDELABELS		0x020000 	&& 隐藏标签(WinXP以上)
#Define LVS_EX_SINGLEROW 		0x040000 	&& 显示单行(WinXP以上)
#Define LVS_EX_SNAPTOGRID 		0x080000	&& 图标自动对齐到表格(WinXP以上)
* LVS_EX_SIMPLESELECT 	&& (WinXP以上)


*--
*--		idTimer to SetTimer
*-- 
#Define IDT_TIMER		101


*--
*--		nIndex to SetWindowLong and GetWindowLong 
*-- 
#Define GWL_WNDPROC 	-4		&& 窗口过程
#Define GWL_HINSTANCE 	-6
#Define GWL_HWNDPARENT 	-8
#Define GWL_ID 			-12
#Define GWL_STYLE 		-16		&& 窗口的样式
#Define GWL_EXSTYLE 	-20		&& 窗口扩展样式
#Define GWL_USERDATA 	-21
* The following values are also available when the hwnd parameter identifies a dialog box:
#Define DWL_MSGRESULT 	0
#Define DWL_DLGPROC 	4
#Define DWL_USER 		8


*--
*-- 	fuLoad to LoadImage
*--
#Define LR_DEFAULTCOLOR			0x00	&& 以常规方式载入图象
#Define LR_MONOCHROME			0x01	&& 将图象转换成单色
#Define LR_COLOR				0x02
#Define LR_COPYRETURNORG 		0x04
#Define LR_COPYDELETEORG 		0x08
#Define LR_LOADFROMFILE			0x10	&& 如果你要从外部文件中调入图象
#Define LR_LOADTRANSPARENT		0x20	&& 与图象中第一个像素相符的所有像素都由系统替换
#Define LR_DEFAULTSIZE			0x40	&& 如果 n1 和 n2 为零，就使用由系统定义的图象默认大小
#Define LR_VGACOLOR 			0x80	&& 使用 VGA 真彩色
#Define LR_LOADMAP3DCOLORS		0x1000	&& 将图象中的深灰、灰、以及浅灰像素都替换成COLOR_3DSHADOW,COLOR_3DFACE,COLOR_3DLIGHT的当前设置
#Define LR_CREATEDIBSECTION 	0x2000	&& 如果uType是IMAGE_BITMAP，函数返回一个不依赖于显示设备的位图
#Define LR_COPYFROMRESOURCE 	0x4000	
#Define LR_SHARED				0x8000	&& 将图象作为一个共享资源载入。在NT 4.0中装载固有资源时要用到这个设置
* LR_LOADREALSIZE 		&& 不对图象进行缩放处理。忽略n1和n2的设置 

*--
*-- 	uType to LoadImage
*--
#Define IMAGE_BITMAP	0
#Define IMAGE_ICON		1
#Define IMAGE_CURSOR	2

*--
*-- 	DwRop to BitBlt and StretchBlt
*--
#Define BLACKNESS		0x42
#Define DSTINVERT		0x550009	
#Define MERGECOPY		0xC000CA
#Define MERGEPAINT		0xBB0226		
#Define NOTSRCCOPY		0x330008
#Define NOTSRCERASE		0x1100A6
#Define PATCOPY			0xF00021
#Define PATINVERT		0x5A0049
#Define PATPAINT		0xFB0A09
#Define SRCAND			0x8800C6
#Define SRCCOPY			0xCC0020
#Define SRCERASE		0x440328
#Define SRCINVERT		0x660046
#Define SRCPAINT		0xEE0086
#Define WHITENESS		0xFF0062


*--
*-- 	CtlType to DRAWITEMSTRUCT
*-- 
#Define ODT_BUTTON		4
#Define ODT_COMBOBOX	3
#Define ODT_LISTBOX		2
#Define ODT_LISTVIEW	102
#Define ODT_MENU		1
#Define ODT_STATIC		5
#Define ODT_TAB			101

*--
*-- 	itemAction to DRAWITEMSTRUCT
*-- 
#Define ODA_DRAWENTIRE		1
#Define ODA_SELECT			2
#Define ODA_FOCUS			4

*--
*-- 	itemState to DRAWITEMSTRUCT
*-- 
#Define ODS_SELECTED		0x01	&& 菜单己被选择
#Define ODS_GRAYED			0x02	&& 菜单是灰色的(只用于菜单)
#Define ODS_DISABLED		0x04	&& 禁用
#Define ODS_CHECKED			0x08	&& 菜单己被选中
#Define ODS_FOCUS			0x10	&& 表示控件需要输入焦点
#Define ODS_DEFAULT			0x20	&& 当前控件处于默认状态
#Define ODS_HOTLIGHT		0x40	&& 表示鼠标指针位于控件之上时控件会显示高亮颜色（支持Windows 98/Me, Windows 2000/XP）；
#Define ODS_INACTIVE		0x80		
#Define ODS_NOACCEL			0x100	
#Define ODS_NOFOCUSRECT		0x200	
#Define ODS_COMBOBOXEDIT	0x1000	&& 在自绘组合框控件中只绘制选择区域

*--
*-- 	iBkMode to SetBkMode
*--
#Define TRANSPARENT			1	&& 透明处理, 即不作上述填充
#Define OPAQUE				2	&& 用当前的背景色填充虚线画笔、阴影刷子以及字符的空隙
#Define NEWTRANSPARENT 		3	&& 在有颜色的菜单上画透明文字

*--
*-- 	uFlags to LocalAlloc
*--
#Define LMEM_FIXED			0x00
#Define LMEM_MOVEABLE		0x02
#Define LMEM_NOCOMPACT		0x10
#Define LMEM_NODISCARD		0x20
#Define LMEM_ZEROINIT		0x40
#Define LMEM_MODIFY			0x80
#Define LMEM_DISCARDABLE	0x0F00
#Define LMEM_VALID_FLAGS	0x0F72
#Define LMEM_INVALID_HANDLE	0x8000
#Define NONZEROLHND			LMEM_MOVEABLE
#Define NONZEROLPTR			LMEM_FIXED
#Define LHND  				LMEM_MOVEABLE + LMEM_ZEROINIT
#Define LPTR				LMEM_FIXED + LMEM_ZEROINIT

*--
*-- 	diFlags to DrawIconEx
*--
#Define DI_MASK 		0x01	&& 绘图时使用图标的MASK部分 (如单独使用, 可获得图标的掩模)
#Define DI_IMAGE		0x02	&& 绘图时使用图标的XOR部分 (即图标没有透明区域)
#Define DI_COMPAT		0x04	&& 系统采用缺省图像而不是用户定义的图像绘制图标和光标
#Define DI_DEFAULTSIZE	0x08 	&& 如果CXWidth和CyWidth参数被设为零，采用系统指定的图标和光标的的公制宽度和高 度绘制图标和光标；如果标记未被指定且cxWidth和cyWith参数设为零标，函数使用资源实际大小
#Define DI_NORMAL 		DI_MASK + DI_IMAGE       && 用常规方式绘图 (合并 DI_IMAGE 和 DI_MASK)

*--
*--		uFlags to AppendMenu
*--
#Define MF_BITMAP			0x04		&& 菜单条目是一幅位图. 一旦设入菜单, 这幅位图就绝对不能删除
#Define MF_CHECKED			0x08		&& 检查指定的菜单条目
#Define MF_DISABLED			0x02		&& 禁止指定的菜单条目
#Define MF_ENABLED			0x00		&& 允许指定的菜单条目
#Define MF_GRAYED			0x01		&& 禁止指定的菜单条目, 并用浅灰色描述它
#Define MF_MENUBARBREAK		0x20		&& 在弹出式菜单中, 将指定的条目放置于一个新列, 并用一条垂直线分隔不同的列
#Define MF_MENUBREAK		0x40		&& 在弹出式菜单中, 将指定的条目放置于一个新列. 在顶级菜单中, 将条目放置到一个新行
#Define MF_OWNERDRAW		0x0100		&& 创建一个物主绘图菜单, 由程序负责绘制菜单
#Define MF_POPUP			0x0010		&& 将一个弹出式菜单置于指定的条目, 可用于创建子菜单及弹出式菜单
#Define MF_SEPARATOR		0x0800		&& 在指定的条目处显示一条分隔线
#Define MF_STRING			0x00		&& 在指定的条目处放置一个字串
#Define MF_UNCHECKED		0x08		&& 检查指定的条目

#Define MF_BYCOMMAND		0x0000		&& 由菜单的命令ID指定
#Define MF_BYPOSITION		0x0400		&& 由条目在菜单中的位置决定 (零代表菜单中的第一个条目)
#Define MF_DEFAULT 			0x1000
#Define MF_RIGHTJUSTIFY 	0x4000
#Define MF_HELP 			0x4000
#Define MF_HILITE 			0x80
#Define MF_UNHILITE			0x00
#Define MF_USECHECKBITMAPS	0x0200
*** 下列标记不能一起使用
*** MF_DISABLED, MF_ENABLED, and MF_GRAYED 
*** MF_BITMAP, MF_STRING, and MF_OWNERDRAW 
*** MF_MENUBARBREAK and MF_MENUBREAK 
*** MF_CHECKED and MF_UNCHECKED 

*--
*-- 	fMask To InsertMenuItem			MENUITEMINFO 中哪些成员有效
*--
#Define MIIM_STATE		0x01
#Define MIIM_ID			0x02
#Define MIIM_SUBMENU	0x04
#Define MIIM_CHECKMARKS	0x08
#Define MIIM_TYPE		0x10
#Define MIIM_DATA		0x20
#Define MIIM_STRING		0x40
#Define MIIM_BITMAP		0x80
#Define MIIM_FTYPE		0x0100

*--
*-- 	fType To InsertMenuItem 		MENUITEMINFO 中菜单项类型
*--
#Define MFT_STRING			0x00
#Define MFT_BITMAP			0x04
#Define MFT_MENUBARBREAK	0x20
#Define MFT_MENUBREAK		0x40
#Define MFT_OWNERDRAW		0x0100
#Define MFT_SEPARATOR		0x0800

*--
*-- 	fState to InsertMenuItem		MENUITEMINFO 中菜单项状态
*--
#Define MFS_ENABLED			0x00
#Define MFS_UNCHECKED		0x00
#Define MFS_UNHILITE		0x00
#Define MFS_GRAYED			0x01
#Define MFS_DISABLED		0x02
#Define MFS_CHECKED			0x08
#Define MFS_HILITE			0x80

*--
*-- 	nFormat to DrawText
*--
#Define DT_TOP 				0x00		&& 垂直顶对齐 (仅单行时有效)
#Define DT_LEFT				0x00		&& 水平左对齐
#Define DT_CENTER			0x01		&& 水平居中对齐
#Define DT_RIGHT			0x02		&& 水平右对齐
#Define DT_VCENTER			0x04		&& 垂直居中对齐 (仅单行时有效)
#Define DT_BOTTOM			0x08		&& 垂直下对齐 (仅单行时有效)
#Define DT_WORDBREAK		0x10		&& 进行自动换行. 如用SetTextAlign函数设置了TA_UPDATECP标志, 这里的设置则无效.
#Define DT_SINGLELINE		0x20		&& 单行
#Define DT_EXPANDTABS 		0x40		&& 描绘文字的时候, 对制表站进行扩展. 默认的制表站间距是8个字符. 但是, 可用DT_TABSTOP标志改变这项设定.
#Define DT_TABSTOP			0x80		&& 指定新的制表站间距, 采用这个整数的高 8 位
#Define DT_NOCLIP			0x0100		&& 描绘文字时不剪切到指定的矩形
#Define DT_EXTERNALLEADING 	0x0200		&& 计算文本行高度的时候, 使用当前字体的外部间距属性
#Define DT_CALCRECT			0x0400		&& 多行绘图时矩形的底边根据需要进行延展, 以便容下所有文字; 单行绘图时, 延展矩形的右侧, 不描绘文字, 由lpRect参数指定的矩形会载入计算出来的值
#Define DT_NOPREFIX 		0x0800		&& 禁止 & 为访问键
#Define DT_INTERNAL			0x1000		


*--
*--		uFlags to TrackPopupMenu and TrackPopupMenuEx
*--
#Define TPM_LEFTALIGN		0x00	
#Define TPM_CENTERALIGN		0x04	
#Define TPM_RIGHTALIGN		0x08	&& Positions the pop-up menu so that its right side is aligned with the coordinate specified by the x parameter
*		New flags for the "TrackPopupMenuEx" version
#Define TPM_TOPALIGN		0x00
#Define TPM_BOTTOMALIGN		0x20
#Define TPM_HORIZONTAL		0x00
#Define TPM_HORNEGANIMATION 0x0800
#Define TPM_HORPOSANIMATION 0x0400
#Define TPM_NOANIMATION 	0x4000
#Define TPM_NONOTIFY 		0x80
#Define TPM_RECURSE			0x01
#Define TPM_VCENTERALIGN 	0x10
#Define TPM_VERNEGANIMATION 0x2000
#Define TPM_VERPOSANIMATION 0x1000
#Define TPM_VERTICAL 		0x40

*		Value				Meaning
#Define TPM_LEFTBUTTON		0x00
#Define TPM_RIGHTBUTTON		0x02
#Define TPM_RETURNCMD		0x0100

*--
*--  	nIndex to GetSysColor
*--
#Define COLOR_SCROLLBAR 				0	&& 滚动条
#Define COLOR_BACKGROUND 				1	&& Windows 桌面
#Define COLOR_ACTIVECAPTION 			2	&& 活动窗口的标题
#Define COLOR_INACTIVECAPTION 			3	&& 不活动窗口的标题
#Define COLOR_MENU						4	&& 菜单
#Define COLOR_WINDOW					5	&& 窗口背景
#Define COLOR_WINDOWFRAME  				6	&& 窗框
#Define COLOR_MENUTEXT					7	&& 菜单文字
#Define COLOR_WINDOWTEXT 				8	&& 窗口文字
#Define COLOR_CAPTIONTEXT 				9	&& 窗口标题中的文字
#Define COLOR_ACTIVEBORDER 				10	&& 活动窗口的边框
#Define COLOR_INACTIVEBORDER 			11	&& 不活动窗口的边框
#Define COLOR_APPWORKSPACE 				12	&& MDI桌面的背景
#Define COLOR_HIGHLIGHT					13	&& 选定的项背景
#Define COLOR_HIGHLIGHTTEXT				14	&& 选定的项文字
#Define COLOR_BTNFACE 					15	&& 按钮
#Define COLOR_BTNSHADOW					16	&& 按钮的3D阴影
#Define COLOR_GRAYTEXT 					17	&& 灰色文字; 如使用了抖动技术则为零
#Define COLOR_BTNTEXT 					18	&& 按钮文字
#Define COLOR_INACTIVECAPTIONTEXT 		19	&& 不活动窗口的文字
#Define COLOR_BTNHIGHLIGHT				20	&& 按钮的3D加亮区
#Define COLOR_3DDKSHADOW				21
#Define COLOR_GRADIENTACTIVECAPTION		27
#Define COLOR_GRADIENTINACTIVECAPTION	28
#Define COLOR_MENUHILIGHT				29
#Define COLOR_MENUBAR					30

*--
*-- 	fuFlags to DrawState
*--
*		type 
#Define DST_COMPLEX		0x00	&& 绘图在由 lpDrawStateProc 参数指定的回调函数期间执行, lParam 和 wParam 会传递给回调事件.
#Define DST_TEXT		0x01	&& lParam代表文字的地址(可使用一个字串别名), wParam 代表字串的长度.
#Define DST_PREFIXTEXT	0x02	&& 与 DST_TEXT 类似, 只是 & 字符指出为下各字符加上下划线
#Define DST_ICON		0x03	&& lParam 包括图标的句柄
#Define DST_BITMAP		0x04	&& lParam 包括位图的句柄
*		state
#Define DSS_NORMAL		0x00	&& 普通图像
#Define DSS_UNION		0x10	&& 图像进行抖动处理
#Define DSS_DISABLED	0x20	&& 图象具有浮雕效果
#Define DSS_MONO		0x80	&& 用 hBrush 描绘图像
#Define DSS_RIGHT		0x8000	&& 无任何作用

*--
*-- 	edge to DrawEdge
*--
#Define BDR_RAISEDOUTER  	0x01	&& 外层凸
#DEfine BDR_SUNKENOUTER  	0x02	&& 外层凹
#Define BDR_RAISEDINNER  	0x04	&& 内层凸
#Define BDR_SUNKENINNER  	0x08	&& 内层凹
#Define BDR_OUTER 			0x03
#Define BDR_RAISED			0x05
#Define BDR_SUNKEN 			0x0A
#Define BDR_INNER 			0x0C
#Define EDGE_BUMP  			BitOr(BDR_RAISEDOUTER, BDR_SUNKENINNER) 
#Define EDGE_ETCHED  		BitOr(BDR_SUNKENOUTER, BDR_RAISEDINNER)
#Define EDGE_RAISED  		BitOr(BDR_RAISEDOUTER, BDR_RAISEDINNER)
#Define EDGE_SUNKEN			BitOr(BDR_SUNKENOUTER, BDR_SUNKENINNER)

*--
*-- 	grfFlags to DrawEdge
*--
#Define BF_LEFT				0x01	&& 左边缘
#Define BF_TOP				0x02	&& 上边缘
#Define BF_RIGHT			0x04	&& 右边缘
#Define BF_BOTTOM			0x08	&& 下边缘
#Define BF_DIAGONAL 		0x10 	&& 对角线
#Define BF_MIDDLE			0x800	&& 填充矩形内部
#Define BF_SOFT				0x1000	&& MSDN: Soft buttons instead of tiles.
#Define BF_ADJUST			0x2000	&& 调整矩形, 预留客户区
#Define BF_FLAT				0x4000 	&& 平面边缘
#Define BF_MONO  			0x8000	&& 一维边缘
#Define BF_TOPLEFT 			BitOr(BF_TOP, BF_LEFT)
#Define BF_TOPRIGHT 		BitOr(BF_TOP, BF_RIGHT)
#Define BF_BOTTOMLEFT 		BitOr(BF_BOTTOM, BF_LEFT)
#Define BF_BOTTOMRIGHT		BitOr(BF_BOTTOM, BF_RIGHT)
#Define BF_RECT 			BitOr(BF_LEFT, BitOr(BF_TOP, BitOr(BF_RIGHT, BF_BOTTOM)))
#Define BF_DIAGONAL_ENDTOPRIGHT 	BitOr(BF_DIAGONAL, BitOr(BF_TOP, BF_RIGHT))
#Define BF_DIAGONAL_ENDTOPLEFT 		BitOr(BF_DIAGONAL, BitOr(BF_TOP, BF_LEFT))
#Define BF_DIAGONAL_ENDBOTTOMLEFT 	BitOr(BF_DIAGONAL, BitOr(BF_BOTTOM, BF_LEFT))
#Define BF_DIAGONAL_ENDBOTTOMRIGHT 	BitOr((BF_DIAGONAL, BitOr(BF_BOTTOM, BF_RIGHT))


*--
*-- 	fnPenStyle to CreatePen
*--
#Define PS_SOLID 		0	&& 实线                         _______
#Define PS_DASH 		1 	&& 虚线 (nWidth必须是1)         -------
#Define PS_DOT 			2 	&& 点线 (nWidth必须是1)         .......
#Define PS_DASHDOT 		3 	&& 点划线 (nWidth必须是1)       _._._._
#Define PS_DASHDOTDOT 	4	&& 点-点-划线 (nWidth必须是1)   _.._.._
#Define PS_NULL			5	&& 隐形
#Define PS_INSIDEFRAME  6	&& 包围矩形(nWidth必须是1)


*--
*-- 	nIndex to GetSystemMetrics
*--
#Define SM_CXSCREEN 			0			&& 屏幕宽度
#Define SM_CYSCREEN 			1			&& 屏幕高度
#Define SM_CXVSCROLL 			2			&& 垂直滚动条中的箭头按钮的大小
#Define SM_CYHSCROLL 			3			&& 水平滚动条上的箭头大小
#Define SM_CYCAPTION 			4			&& 窗口标题的高度
#Define SM_CXBORDER 			5			&& 尺寸不可变边框的宽度
#Define SM_CYBORDER 			6			&& 尺寸不可变边框的高度
#Define SM_CXDLGFRAME 			7			&& 对话框边框的宽度
#Define SM_CYDLGFRAME 			8			&& 对话框边框的高度
#Define SM_CYVTHUMB 			9			&& 垂直滚动条上滚动块的高度
#Define SM_CXHTHUMB 			10			&& 水平滚动条上滚动块的大小
#Define SM_CXICON 				11			&& 标准图标的宽度
#Define SM_CYICON 				12			&& 标准图标的高度
#Define SM_CXCURSOR 			13			&& 标准鼠标指针宽度
#Define SM_CYCURSOR 			14			&& 标准鼠标指针高度
#Define SM_CYMENU 				15			&& 菜单高度
#Define SM_CXFULLSCREEN 		16			&& 最大化窗口客户区的宽度
#Define SM_CYFULLSCREEN 		17			&& 最大化窗口客户区的高度
#Define SM_CYKANJIWINDOW 		18			&& Kanji窗口的大小（Height Of Kanji window）
#Define SM_MOUSEPRESENT 		19			&& 是否安装了鼠标
#Define SM_CYVSCROLL 			20			&& 垂直滚动条中的箭头按钮的大小
#Define SM_CXHSCROLL 			21			&& 水平滚动条中的箭头按钮的大小
#Define SM_DEBUG 				22			&& 如 windows 的调试版正在运行，则为 .T.
#Define SM_SWAPBUTTON 			23			&& 是否交换了鼠标左右键
#Define SM_RESERVED1 			24
#Define SM_RESERVED2 			25
#Define SM_RESERVED3 			26
#Define SM_RESERVED4 			27
#Define SM_CXMIN 				28			&& 窗口最小宽度
#Define SM_CYMIN 				29			&& 窗口最小高度
#Define SM_CXSIZE 				30			&& 标题栏位图的宽度
#Define SM_CYSIZE 				31			&& 标题栏位图的高度
#Define SM_CXFRAME 				32			&& 尺寸可变边框的宽度
#Define SM_CYFRAME 				33			&& 尺寸可变边框的高度
#Define SM_CXMINTRACK 			34			&& 窗口的最小轨迹宽度 
#Define SM_CYMINTRACK 			35			&& 窗口的最小轨迹高度 
#Define SM_CXDOUBLECLK 			36			&& 双击区域的 X 位移
#Define SM_CYDOUBLECLK 			37			&& 双击区域的 Y 位移
#Define SM_CXICONSPACING 		38			&& 桌面图标之间的间隔宽度
#Define SM_CYICONSPACING 		39			&& 桌面图标之间的间隔高度
#Define SM_MENUDROPALIGNMENT 	40			&& 如弹出式菜单对齐菜单栏项目的左侧，则为 0
#Define SM_PENWINDOWS 			41			&& 如装载了支持笔窗口的DLL，则表示笔窗口的句柄
#Define SM_DBCSENABLED 			42			&& 是否支持双字节
#Define SM_CMOUSEBUTTONS 		43
#Define SM_CMETRICS 			44
#Define SM_CXEDGE  				45
#Define SM_CYEDGE  				46
#Define SM_CXMINSPACING  		47
#Define SM_CYMINSPACING  		48
#Define SM_CXSMICON  			49			&& 小图标宽度？
#Define SM_CYSMICON  			50			&& 小图标高度？
#Define SM_CYSMCAPTION  		51
#Define SM_CXSMSIZE  			52			&& 小标题按钮的宽度
#Define SM_CYSMSIZE  			53			&& 小标题按钮的高度
#Define SM_CXMENUSIZE  			54
#Define SM_CYMENUSIZE  			55
#Define SM_ARRANGE  			56			&& windows 如何排列最小化窗口的一个标志。参考api32.txt中的 ARW 常数 
#Define SM_CXMINIMIZED  		57
#Define SM_CYMINIMIZED  		58
#Define SM_CXMAXTRACK  			59
#Define SM_CYMAXTRACK  			60
#Define SM_CXMAXIMIZED  		61
#Define SM_CYMAXIMIZED  		62
#Define SM_NETWORK  			63
* #Define  
* #Define  
* #Define  
#Define SM_CLEANBOOT  			67		&& 启动方式: 0 正常启动 1 安全模式启动 2 网络安全模式启动
#Define SM_CXDRAG  				68		&& 拖动时 X 轴偏移
#Define SM_CYDRAG  				69		&& 拖动时 Y 轴偏移
#Define SM_SHOWSOUNDS  			70
#Define SM_CXMENUCHECK  		71		&& 以像素为单位计算的菜单选中标记位图的 X 尺寸
#Define SM_CYMENUCHECK  		72 		&& 以像素为单位计算的菜单选中标记位图的 Y 尺寸
#Define SM_SLOWMACHINE  		73
#Define SM_MIDEASTENABLED  		74
#Define SM_MOUSEWHEELPRESENT  	75
#Define SM_XVIRTUALSCREEN  		76
#Define SM_YVIRTUALSCREEN  		77
#Define SM_CXVIRTUALSCREEN  	78
#Define SM_CYVIRTUALSCREEN  	79
#Define SM_CMONITORS  			80
#Define SM_SAMEDISPLAYFORMAT  	81
#Define SM_IMMENABLED  			82
#Define SM_REMOTESESSION  		0x1000
#Define SM_CXSIZEFRAME 			SM_CXFRAME
#Define SM_CYSIZEFRAME 			SM_CYFRAME
#Define SM_CXFIXEDFRAME 		SM_CXDLGFRAME
#Define SM_CYFIXEDFRAME 		SM_CYDLGFRAME
#Define SM_GETCURFOCUSA  		WM_USER + 1003
#Define SM_GETCURFOCUSW  		WM_USER + 1004
#Define SM_GETOPTIONS  			WM_USER + 1005
#Define SM_GETSELCOUNT  		WM_USER + 1000
#Define SM_GETSERVERSELA  		WM_USER + 1001
#Define SM_GETSERVERSELW  		WM_USER + 1002
* SM_SECURE 		是否安装了安全（保密）机制
* SM_SHOWSOUNDS 	强制视觉提示播放声音
* SM_SLOWMACHINE 	系统速度太慢，但仍在运行中



*--
*-- 	uiAction to SystemParametersInfo
*--
#Define SPI_GETBEEP					1
#Define SPI_SETBEEP					2
#Define SPI_GETMOUSE				3
#Define SPI_SETMOUSE				4
#Define SPI_GETBORDER				5
#Define SPI_SETBORDER				6
#Define SPI_GETKEYBOARDSPEED		10
#Define SPI_SETKEYBOARDSPEED		11
#Define SPI_LANGDRIVER				12
#Define SPI_ICONHORIZONTALSPACING	13
#Define SPI_GETSCREENSAVETIMEOUT	14
#Define SPI_SETSCREENSAVETIMEOUT	15
#Define SPI_GETSCREENSAVEACTIVE		16
#Define SPI_SETSCREENSAVEACTIVE		17
#Define SPI_GETGRIDGRANULARITY		18
#Define SPI_SETGRIDGRANULARITY		19
#Define SPI_SETDESKWALLPAPER		20
#Define SPI_SETDESKPATTERN			21
#Define SPI_GETKEYBOARDDELAY		22
#Define SPI_SETKEYBOARDDELAY		23
#Define SPI_ICONVERTICALSPACING		24
#Define SPI_GETICONTITLEWRAP		25
#Define SPI_SETICONTITLEWRAP		26
#Define SPI_GETMENUDROPALIGNMENT	27
#Define SPI_SETMENUDROPALIGNMENT	28
#Define SPI_SETDOUBLECLKWIDTH		29
#Define SPI_SETDOUBLECLKHEIGHT		30
#Define SPI_GETICONTITLELOGFONT		31
#Define SPI_SETDOUBLECLICKTIME		32
#Define SPI_SETMOUSEBUTTONSWAP		33
#Define SPI_SETICONTITLELOGFONT		34
#Define SPI_GETFASTTASKSWITCH		5
#Define SPI_SETFASTTASKSWITCH		36
#Define SPI_SETDRAGFULLWINDOWS		37
#Define SPI_GETDRAGFULLWINDOWS		38
#Define SPI_GETNONCLIENTMETRICS		41
#Define SPI_SETNONCLIENTMETRICS		42
#Define SPI_GETMINIMIZEDMETRICS		43
#Define SPI_SETMINIMIZEDMETRICS		44
#Define SPI_GETICONMETRICS			45
#Define SPI_SETICONMETRICS			46
#Define SPI_SETWORKAREA				47
#Define SPI_GETWORKAREA				48
#Define SPI_SETPENWINDOWS			49
#Define SPI_GETFILTERKEYS			50
#Define SPI_SETFILTERKEYS			51
#Define SPI_GETTOGGLEKEYS			52
#Define SPI_SETTOGGLEKEYS			53
#Define SPI_GETMOUSEKEYS			54
#Define SPI_SETMOUSEKEYS			55
#Define SPI_GETSHOWSOUNDS			56
#Define SPI_SETSHOWSOUNDS			57
#Define SPI_GETSTICKYKEYS			58
#Define SPI_SETSTICKYKEYS			59
#Define SPI_GETACCESSTIMEOUT		60
#Define SPI_SETACCESSTIMEOUT		61
#Define SPI_GETSERIALKEYS			62
#Define SPI_SETSERIALKEYS			63
#Define SPI_GETSOUNDSENTRY			64
#Define SPI_SETSOUNDSENTRY			65
#Define SPI_GETHIGHCONTRAST			66
#Define SPI_SETHIGHCONTRAST			67
#Define SPI_GETKEYBOARDPREF			68
#Define SPI_SETKEYBOARDPREF			69
#Define SPI_GETSCREENREADER			70
#Define SPI_SETSCREENREADER			71
#Define SPI_GETANIMATION			72
#Define SPI_SETANIMATION			73
#Define SPI_GETFONTSMOOTHING		74
#Define SPI_SETFONTSMOOTHING		75
#Define SPI_SETDRAGWIDTH			76
#Define SPI_SETDRAGHEIGHT			77
#Define SPI_SETHANDHELD				78
#Define SPI_GETLOWPOWERTIMEOUT		79
#Define SPI_GETPOWEROFFTIMEOUT		80
#Define SPI_SETLOWPOWERTIMEOUT		81
#Define SPI_SETPOWEROFFTIMEOUT		82
#Define SPI_GETLOWPOWERACTIVE		83
#Define SPI_GETPOWEROFFACTIVE		84
#Define SPI_SETLOWPOWERACTIVE		85
#Define SPI_SETPOWEROFFACTIVE		86
#Define SPI_SETCURSORS				87
#Define SPI_SETICONS				88
#Define SPI_GETDEFAULTINPUTLANG		89
#Define SPI_SETDEFAULTINPUTLANG		90
#Define SPI_SETLANGTOGGLE			91
#Define SPI_GETWINDOWSEXTENSION		92
#Define SPI_SETMOUSETRAILS			93
#Define SPI_GETMOUSETRAILS			94
#Define SPI_SCREENSAVERRUNNING		97
#Define SPI_GETMENUSHOWDELAY		106
#Define SPI_GETMENUFADE				0x1012
#Define SPI_GETDROPSHADOW			0x1024

*--
*-- 	fMode to SetTextAlign 
*--
#Define TA_NOUPDATECP	0
#Define TA_UPDATECP		1
#Define TA_TOP			0			&& The reference point will be on the top edge of the bounding rectangle.
#Define TA_LEFT			0			&& The reference point will be on the left edge of the bounding rectangle.
#Define TA_RIGHT		2			&& The reference point will be on the right edge of the bounding rectangle.
#Define TA_CENTER		6			&& The reference point will be aligned horizontally with the center of the bounding rectangle.
#Define TA_BOTTOM		8			&& The reference point will be on the bottom edge of the bounding rectangle.
#Define TA_BASELINE		24			&& The reference point will be on the base line of the text.
#Define VTA_BASELINE	TA_BASELINE && The reference point will be on the base line of the text.
#Define VTA_RIGHT		TA_TOP
#Define VTA_LEFT 		TA_BOTTOM
#Define VTA_CENTER		TA_CENTER	&& The reference point will be aligned vertically with the center of the bounding rectangle.
#Define VTA_BOTTOM  	TA_RIGHT
#Define VTA_TOP 		TA_LEFT
*** The default values are TA_LEFT, TA_TOP, and TA_NOUPDATECP. 


*--
*--		nIndex to GetDeviceCaps
*--
#Define DRIVERVERSION 	0 	&& The device driver version.
#Define TECHNOLOGY 		2	&& Device technology. It can be any one of the
		#Define DT_PLOTTER		0 	&& Vector plotter
		#Define DT_RASDISPLAY	1	&& Raster display
		#Define DT_RASPRINTER	2	&& Raster printer
		#Define DT_RASCAMERA	3	&& Raster camera
		#Define DT_CHARSTREAM	4	&& Character stream
		#Define DT_METAFILE		5	&& Metafile
		#Define DT_DISPFILE		6	&& Display file
#Define HORZSIZE 		4	&& 物理屏幕宽度，毫米单位
#Define VERTSIZE		6 	&& 物理屏幕高度，毫米单位
#Define HORZRES 		8	&& Width, in pixels, of the screen.
#Define VERTRES 		10	&& Height, in raster lines, of the screen.
#Define LOGPIXELSX		88	&& 每逻辑英寸对应的水平像素点数
#Define LOGPIXELSY		90 	&& 每逻辑英寸对应的垂直像素点数
#Define BITSPIXEL 		12	&& Number of adjacent color bits for each pixel.
#Define PLANES 			14	&& Number of color planes.
#Define NUMBRUSHES 		16	&& Number of device-specific brushes
#Define NUMPENS 		18	&& Number of device-specific pens
#Define NUMFONTS 		22	&& Number of device-specific fonts.
#Define NUMCOLORS 		24	&& Number of entries in the device's color table.
#Define ASPECTX 		40	&& Relative width of a device pixel used for line drawing.
#Define ASPECTY 		42	&& Relative height of a device pixel used for line drawing.
#Define ASPECTXY 		44	&& Diagonal width of the device pixel used for line drawing.
#Define PDEVICESIZE		26 	&& Reserved
#Define CLIPCAPS 		36
#Define SIZEPALETTE 	104	
#Define NUMRESERVED 	106	
#Define COLORRES 		108	
#Define PHYSICALWIDTH 	110	&& For printing devices: the physical width, in device units.
#Define PHYSICALHEIGHT 	111	&& For printing devices: the physical height, in device units.
#Define PHYSICALOFFSETX 112	&& For printing devices: the physical printable area horizontal margin.
#Define PHYSICALOFFSETY 113	&& For printing devices: the physical printable area vertical margin. 
#Define SCALINGFACTORX 	114	&& For printing devices: the scaling factor along the horizontal axis.
#Define SCALINGFACTORY 	115	&& For printing devices: the scaling factor along the vertical axis.
* VREFRESH			Windows NT only
* DESKTOPHORZRES	Windows NT only
* DESKTOPVERTRES	Windows NT only
* BLTALIGNMENT		Windows NT only
#Define RASTERCAPS 		38	&& Value that indicates the raster capabilities of the device, as shown in the following table
		* 		Capability	Meaning
		#Define RC_BANDING		2 		&& Requires banding support.
		#Define RC_BITBLT		1		&& Capable of transferring bitmaps.
		#Define RC_BITMAP64		8		&& Capable of supporting bitmaps larger than 64K.
		#Define RC_DI_BITMAP	0x80	&& Capable of supporting the SetDIBits and GetDIBits functions.
		#Define RC_DIBTODEV		0x0200	&& Capable of supporting the SetDIBitsToDevice function.
		#Define RC_FLOODFILL	0x1000	&& Capable of performing flood fills.
		#Define RC_GDI20_OUTPUT	0x10	&& Capable of supporting features of Windows 2.0.
		#Define RC_PALETTE		0x0100	&& Specifies a palette-based device.
		#Define RC_SCALING		0x04	&& Capable of scaling.
		#Define RC_STRETCHBLT	0x0800	&& Capable of performing the StretchBlt function.
		#Define RC_STRETCHDIB	0x2000 	&& Capable of performing the StretchDIBits function.
#Define CURVECAPS 		28	&& Value that indicates the curve capabilities of the device, as shown in the following table:
		* 		Value		Meaning
		#Define CC_NONE			0	&& Device does not support curves.
		#Define CC_CIRCLES		1	&& Device can draw circles.
		#Define CC_PIE			2	&& Device can draw pie wedges.
		#Define CC_CHORD		4	&& Device can draw chord arcs.
		#Define CC_ELLIPSES		8	&& Device can draw ellipses.
		#Define CC_WIDE			16 	&& Device can draw wide borders.
		#Define CC_STYLED		32	&& Device can draw styled borders.
		#Define CC_WIDESTYLED 	64 	&& Device can draw borders that are wide and styled.
		#Define CC_INTERIORS 	128	&& Device can draw interiors.
		#Define CC_ROUNDRECT	256	&& Device can draw rounded rectangles.
#Define LINECAPS 		30	&& Value that indicates the line capabilities of the device, as shown in the following table:
		* 		Value		Meaning
		#Define LC_NONE			0	&& Device does not support lines.
		#Define LC_POLYLINE		2	&& Device can draw a polyline.
		#Define LC_MARKER		4	&& Device can draw a marker.
		#Define LC_POLYMARKER	8	&& Device can draw multiple markers.
		#Define LC_WIDE			16	&& Device can draw wide lines.
		#Define LC_STYLED		32	&& Device can draw styled lines.
		#Define LC_WIDESTYLED	64	&& Device can draw lines that are wide and styled.
		#Define LC_INTERIORS	128	&& Device can draw interiors.
#Define POLYGONALCAPS 	32	&& Value that indicates the polygon capabilities of the device, as shown in the following table:
		*		Value		Meaning
		#Define PC_NONE			0	&& Device does not support polygons.
		#Define PC_POLYGON		1	&& Device can draw alternate-fill polygons.
		#Define PC_RECTANGLE	2	&& Device can draw rectangles.
		#Define PC_WINDPOLYGON	4	&& Device can draw winding-fill polygons.
		#Define PC_SCANLINE		8	&& Device can draw a single scanline.
		#Define PC_WIDE			16	&& Device can draw wide borders.
		#Define PC_STYLED		32	&& Device can draw styled borders.
		#Define PC_WIDESTYLED	64	&& Device can draw borders that are wide and styled.
		#Define PC_INTERIORS	128	&& Device can draw interiors.
#Define TEXTCAPS 		34	&& Value that indicates the text capabilities of the device, as shown in the following table:
		* 		Bit					Meaning
		#Define TC_OP_CHARACTER		0x01 	&& Device is capable of character output precision.
		#Define TC_OP_STROKE		0x02 	&& Device is capable of stroke output precision.
		#Define TC_CP_STROKE		0x04 	&& Device is capable of stroke clip precision.
		#Define TC_CR_90			0x08 	&& Device is capable of 90-degree character rotation.
		#Define TC_CR_ANY			0x10 	&& Device is capable of any character rotation.
		#Define TC_SF_X_YINDEP		0x20	&& Device can scale independently in the x- and y-directions.
		#Define TC_SA_DOUBLE		0x40	&& Device is capable of doubled character for scaling.
		#Define TC_SA_INTEGER		0x80	&& Device uses integer multiples only for character scaling.
		#Define TC_SA_CONTIN		0x0100	&& Device uses any multiples for exact character scaling.
		#Define TC_EA_DOUBLE		0x0200	&& Device can draw double-weight characters.
		#Define TC_IA_ABLE			0x0400	&& Device can italicize.
		#Define TC_UA_ABLE			0x0800	&& Device can underline.
		#Define TC_SO_ABLE			0x1000	&& Device can draw strikeouts.
		#Define TC_RA_ABLE			0x2000	&& Device can draw raster fonts.
		#Define TC_VA_ABLE			0x4000	&& Device can draw vector fonts.
		#Define TC_RESERVED			0x8000	&& Reserved; must be zero.
		#Define TC_SCROLLBLT		0x010000


*--
*-- 	fnWeight to CreateFont 
*--
#Define FW_DONTCARE		0
#Define FW_THIN			100
#Define FW_EXTRALIGHT	200
#Define FW_LIGHT		300
#Define FW_NORMAL		400
#Define FW_MEDIUM		500
#Define FW_SEMIBOLD		600
#Define FW_BOLD			700
#Define FW_EXTRABOLD	800
#Define FW_HEAVY		900
*--
*-- 	fdwQuality to CreateFont 
*--
#Define DEFAULT_QUALITY		0
#Define DRAFT_QUALITY		1
#Define PROOF_QUALITY		2
*--
*-- 	fdwCharSet to CreateFont 
*--
#Define ANSI_CHARSET		0
#Define DEFAULT_CHARSET		1
#Define SYMBOL_CHARSET		2
#Define SHIFTJIS_CHARSET	128
#Define HANGEUL_CHARSET		129
#Define CHINESEBIG5_CHARSET 136
#Define OEM_CHARSET			255
#Define JOHAB_CHARSET		130
#Define HEBREW_CHARSET		177
#Define ARABIC_CHARSET		178
#Define GREEK_CHARSET		161
#Define TURKISH_CHARSET		162
#Define THAI_CHARSET		222
#Define EASTEUROPE_CHARSET	238
#Define RUSSIAN_CHARSET		204
#Define MAC_CHARSET			77
#Define BALTIC_CHARSET		186
*--
*-- 	fdwOutputPrecision to CreateFont 
*--
#Define OUT_DEFAULT_PRECIS 		0
#Define OUT_STRING_PRECIS 		1
#Define OUT_CHARACTER_PRECIS 	2
#Define OUT_STROKE_PRECIS 		3
#Define OUT_TT_PRECIS 			4
#Define OUT_DEVICE_PRECIS		5
#Define OUT_RASTER_PRECIS		6
#Define OUT_TT_ONLY_PRECIS		7
#Define OUT_OUTLINE_PRECIS		8
*--
*-- 	fdwClipPrecision to CreateFont 
*--
#Define CLIP_DEFAULT_PRECIS 	0
#Define CLIP_CHARACTER_PRECIS 	1
#Define CLIP_STROKE_PRECIS 	 	2
#Define CLIP_MASK  				15
#Define CLIP_LH_ANGLES			16
#Define CLIP_TT_ALWAYS			32
#Define CLIP_EMBEDDED			128
*--
*-- 	fdwPitchAndFamily to CreateFont 
*--
#Define DEFAULT_PITCH		0
#Define FIXED_PITCH			1
#Define VARIABLE_PITCH		2
