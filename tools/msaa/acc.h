#define     OBJID_WINDOW        	0x00000000
#define     OBJID_SYSMENU       	0xFFFFFFFF
#define     OBJID_TITLEBAR      	0xFFFFFFFE
#define     OBJID_MENU          	0xFFFFFFFD
#define     OBJID_CLIENT        	0xFFFFFFFC
#define     OBJID_VSCROLL       	0xFFFFFFFB
#define     OBJID_HSCROLL       	0xFFFFFFFA
#define     OBJID_SIZEGRIP      	0xFFFFFFF9
#define     OBJID_CARET         	0xFFFFFFF8
#define     OBJID_CURSOR        	0xFFFFFFF7
#define     OBJID_ALERT         	0xFFFFFFF6
#define     OBJID_SOUND         	0xFFFFFFF5
#define     OBJID_QUERYCLASSNAMEIDX 0xFFFFFFF4
#define     OBJID_NATIVEOM      	0xFFFFFFF0

#define		IAccGuid			"618736E0-3C3D-11CF-810C-00AA00389B71"

#define     CHILDID_SELF        0

#if .f.
#define		SELFLAG_NONE            0
#define		SELFLAG_TAKEFOCUS       1
#define		SELFLAG_TAKESELECTION   2
#define		SELFLAG_EXTENDSELECTION 4
#define		SELFLAG_ADDSELECTION    8
#define		SELFLAG_REMOVESELECTION 16
#endif
*!*	If IAccessible::accSelect is called with the SELFLAG_TAKEFOCUS flag on a child object that has an HWND, the flag will take effect only if the object's parent has the focus.
*!*	To simulate a click 
*!*	·	SELFLAG_TAKEFOCUS | SELFLAG_TAKESELECTION 
*!*	To select a target item by simulating CTRL + click 
*!*	·	SELFLAG_TAKEFOCUS | SELFLAG_ADDSELECTION
*!*	To cancel selection of a target item by simulating CTRL + click 
*!*	·	SELFLAG_TAKEFOCUS | SELFLAG_REMOVESELECTION
*!*	To simulate SHIFT + click
*!*	·	SELFLAG_TAKEFOCUS | SELFLAG_EXTENDSELECTION
*!*	To select a range of objects and put focus on the last object
*!*	1.	Specify SELFLAG_TAKEFOCUS on the starting object to set the selection anchor.
*!*		2.	Call IAccessible::accSelect again and specify SELFLAG_EXTENDSELECTION | SELFLAG_TAKEFOCUS on the last object. 
*!*	To deselect all objects
*!*	1.	Specify SELFLAG_TAKESELECTION on any object. This flag deselects all selected objects except the one just selected. 
*!*		2.	Call IAccessible::accSelect again and specify SELFLAG_REMOVESELECTION on the same object.


#define	NAVDIR_MIN	0
#define	NAVDIR_UP	0x1
#define	NAVDIR_DOWN	0x2
#define	NAVDIR_LEFT	0x3
#define	NAVDIR_RIGHT	0x4
#define	NAVDIR_NEXT		0x5
#define	NAVDIR_PREVIOUS	0x6
#define	NAVDIR_FIRSTCHILD	0x7
#define	NAVDIR_LASTCHILD	0x8
#define	NAVDIR_MAX	0x9

*// Output from DISPID_ACC_ROLE
#define ROLE_SYSTEM_TITLEBAR            0x00000001
#define ROLE_SYSTEM_MENUBAR             0x00000002
#define ROLE_SYSTEM_SCROLLBAR           0x00000003
#define ROLE_SYSTEM_GRIP                0x00000004
#define ROLE_SYSTEM_SOUND               0x00000005
#define ROLE_SYSTEM_CURSOR              0x00000006
#define ROLE_SYSTEM_CARET               0x00000007
#define ROLE_SYSTEM_ALERT               0x00000008
#define ROLE_SYSTEM_WINDOW              0x00000009
#define ROLE_SYSTEM_CLIENT              0x0000000A
#define ROLE_SYSTEM_MENUPOPUP           0x0000000B
#define ROLE_SYSTEM_MENUITEM            0x0000000C
#define ROLE_SYSTEM_TOOLTIP             0x0000000D
#define ROLE_SYSTEM_APPLICATION         0x0000000E
#define ROLE_SYSTEM_DOCUMENT            0x0000000F
#define ROLE_SYSTEM_PANE                0x00000010
#define ROLE_SYSTEM_CHART               0x00000011
#define ROLE_SYSTEM_DIALOG              0x00000012
#define ROLE_SYSTEM_BORDER              0x00000013
#define ROLE_SYSTEM_GROUPING            0x00000014
#define ROLE_SYSTEM_SEPARATOR           0x00000015
#define ROLE_SYSTEM_TOOLBAR             0x00000016
#define ROLE_SYSTEM_STATUSBAR           0x00000017
#define ROLE_SYSTEM_TABLE               0x00000018
#define ROLE_SYSTEM_COLUMNHEADER        0x00000019
#define ROLE_SYSTEM_ROWHEADER           0x0000001A
#define ROLE_SYSTEM_COLUMN              0x0000001B
#define ROLE_SYSTEM_ROW                 0x0000001C
#define ROLE_SYSTEM_CELL                0x0000001D
#define ROLE_SYSTEM_LINK                0x0000001E
#define ROLE_SYSTEM_HELPBALLOON         0x0000001F
#define ROLE_SYSTEM_CHARACTER           0x00000020
#define ROLE_SYSTEM_LIST                0x00000021
#define ROLE_SYSTEM_LISTITEM            0x00000022
#define ROLE_SYSTEM_OUTLINE             0x00000023
#define ROLE_SYSTEM_OUTLINEITEM         0x00000024
#define ROLE_SYSTEM_PAGETAB             0x00000025
#define ROLE_SYSTEM_PROPERTYPAGE        0x00000026
#define ROLE_SYSTEM_INDICATOR           0x00000027
#define ROLE_SYSTEM_GRAPHIC             0x00000028
#define ROLE_SYSTEM_STATICTEXT          0x00000029
#define ROLE_SYSTEM_TEXT                0x0000002A  
#define ROLE_SYSTEM_PUSHBUTTON          0x0000002B
#define ROLE_SYSTEM_CHECKBUTTON         0x0000002C
#define ROLE_SYSTEM_RADIOBUTTON         0x0000002D
#define ROLE_SYSTEM_COMBOBOX            0x0000002E
#define ROLE_SYSTEM_DROPLIST            0x0000002F
#define ROLE_SYSTEM_PROGRESSBAR         0x00000030
#define ROLE_SYSTEM_DIAL                0x00000031
#define ROLE_SYSTEM_HOTKEYFIELD         0x00000032
#define ROLE_SYSTEM_SLIDER              0x00000033
#define ROLE_SYSTEM_SPINBUTTON          0x00000034
#define ROLE_SYSTEM_DIAGRAM             0x00000035
#define ROLE_SYSTEM_ANIMATION           0x00000036
#define ROLE_SYSTEM_EQUATION            0x00000037
#define ROLE_SYSTEM_BUTTONDROPDOWN      0x00000038
#define ROLE_SYSTEM_BUTTONMENU          0x00000039
#define ROLE_SYSTEM_BUTTONDROPDOWNGRID  0x0000003A
#define ROLE_SYSTEM_WHITESPACE          0x0000003B
#define ROLE_SYSTEM_PAGETABLIST         0x0000003C
#define ROLE_SYSTEM_CLOCK               0x0000003D

#define SELFLAG_NONE                    0x00000000
#define SELFLAG_TAKEFOCUS               0x00000001
#define SELFLAG_TAKESELECTION           0x00000002
#define SELFLAG_EXTENDSELECTION         0x00000004
#define SELFLAG_ADDSELECTION            0x00000008
#define SELFLAG_REMOVESELECTION         0x00000010
#define SELFLAG_VALID                   0x0000001F

#define INPUT_MOUSE     0
#define INPUT_KEYBOARD  1
#define INPUT_HARDWARE  2


#define KEYEVENTF_EXTENDEDKEY 0x0001
#define KEYEVENTF_KEYUP       0x0002

*#if(_WIN32_WINNT >= 0x0500)
#define KEYEVENTF_UNICODE     0x0004
#define KEYEVENTF_SCANCODE    0x0008
*#endif /* _WIN32_WINNT >= 0x0500 */


#define VK_SHIFT          0x10
#define VK_CONTROL        0x11
#define VK_LSHIFT         0xA0
#define VK_RSHIFT         0xA1
#define VK_LCONTROL       0xA2
#define VK_RCONTROL       0xA3
#define VK_LMENU          0xA4
#define VK_RMENU          0xA5

#define MOUSEEVENTF_MOVE        0x0001 
#define MOUSEEVENTF_LEFTDOWN    0x0002 
#define MOUSEEVENTF_LEFTUP      0x0004 
#define MOUSEEVENTF_RIGHTDOWN   0x0008 
#define MOUSEEVENTF_RIGHTUP     0x0010 
#define MOUSEEVENTF_MIDDLEDOWN  0x0020 
#define MOUSEEVENTF_MIDDLEUP    0x0040 
#define MOUSEEVENTF_WHEEL       0x0800 
#define MOUSEEVENTF_ABSOLUTE    0x8000 
