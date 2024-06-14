**********************************************
***
***  Header constants for Popup Menu Class
***  Version 1.62.052
***
***  Last update: August 22, 2008
***
**********************************************


*	typedef struct _TRIVERTEX {
*	  LONG        x;
*	  Long        y;
*	  COLOR16     Red;
*	  COLOR16     Green;
*	  COLOR16     Blue;
*	  COLOR16     Alpha;
*	}TRIVERTEX, *PTRIVERTEX


*	typedef struct tagNONCLIENTMETRICS { 
*	  UINT    cbSize; 
*	  int     iBorderWidth; 
*	  int     iScrollWidth; 
*	  int     iScrollHeight; 
*	  int     iCaptionWidth; 
*	  int     iCaptionHeight; 
*	  LOGFONT lfCaptionFont; 
*	  int     iSmCaptionWidth; 
*	  int     iSmCaptionHeight; 
*	  LOGFONT lfSmCaptionFont; 
*	  int     iMenuWidth; 
*	  int     iMenuHeight; 
*	  LOGFONT lfMenuFont; 
*	  LOGFONT lfStatusFont; 
*	  LOGFONT lfMessageFont; 
*	} NONCLIENTMETRICS, *LPNONCLIENTMETRICS


*	typedef struct tagLOGFONT { 
*	  LONG lfHeight; 
*	  LONG lfWidth; 
*	  LONG lfEscapement; 
*	  LONG lfOrientation; 
*	  LONG lfWeight; 
*	  BYTE lfItalic; 
*	  BYTE lfUnderline; 
*	  BYTE lfStrikeOut; 
*	  BYTE lfCharSet; 
*	  BYTE lfOutPrecision; 
*	  BYTE lfClipPrecision; 
*	  BYTE lfQuality; 
*	  BYTE lfPitchAndFamily; 
*	  TCHAR lfFaceName[LF_FACESIZE]; 
*	} LOGFONT, *PLOGFONT


*	typedef struct MEASUREITEMSTRUCT {
*	    UINT CtlType;
*	    UINT CtlID;
*	    UINT itemID;
*	    UINT itemWidth;
*	    UINT itemHeight;
*	    ULONG_PTR itemData;
*	} MEASUREITEMSTRUCT


*	typedef struct tagDRAWITEMSTRUCT {
*	    UINT CtlType;
*	    UINT CtlID;
*	    UINT itemID;
*	    UINT itemAction;
*	    UINT itemState;
*	    HWND hwndItem;
*	    HDC hDC;
*	    RECT rcItem;
*	    ULONG_PTR itemData;
*	} DRAWITEMSTRUCT


*	typedef struct _RECT { 
*	  LONG left; 
*	  LONG top; 
*	  LONG right; 
*	  LONG bottom; 
*	} RECT, *PRECT


*	typedef struct tagMYPOPITEM
*	{
*		char		szItemText[MAX_TEXTLEN];
*		UINT		nLen;
*		HBITMAP	hBitmap;
*		DWORD		nFlags;
*		LPSTR		lpCommand;
*	} MYPOPITEM


*	typedef struct tagMENUINFO {
*	  DWORD   cbSize;
*	  DWORD   fMask;
*	  DWORD   dwStyle;
*	  UINT    cyMax;
*	  HBRUSH  hbrBack;
*	  DWORD   dwContextHelpID;
*	  ULONG_PTR  dwMenuData;
*	} MENUINFO, FAR *LPMENUINFO;
*	typedef MENUINFO CONST FAR *LPCMENUINFO


*	typedef struct tagMENUBARINFO {
*	  DWORD cbSize;
*	  RECT  rcBar;
*	  HMENU hMenu;
*	  HWND  hwndMenu;
*	  BOOL  fBarFocused:1;
*	  BOOL  fFocused:1;
*	} MENUBARINFO, *PMENUBARINFO


*	typedef struct tagMENUITEMINFO {
*	  UINT    cbSize; 
*	  UINT    fMask; 
*	  UINT    fType; 
*	  UINT    fState; 
*	  UINT    wID; 
*	  HMENU   hSubMenu; 
*	  HBITMAP hbmpChecked; 
*	  HBITMAP hbmpUnchecked; 
*	  ULONG_PTR dwItemData; 
*	  LPTSTR  dwTypeData; 
*	  UINT    cch; 
*	  HBITMAP hbmpItem;
*	} MENUITEMINFO, *LPMENUITEMINFO


*	typedef struct tagBITMAP {
*	  LONG   bmType; 
*	  LONG   bmWidth; 
*	  LONG   bmHeight; 
*	  LONG   bmWidthBytes; 
*	  WORD   bmPlanes; 
*	  WORD   bmBitsPixel; 
*	  LPVOID bmBits; 
*	} BITMAP, *PBITMAP
*** Define type


#Define c0		chr(0)
#Define c1		chr(1)
#Define CR		chr(13)
#Define LF		chr(10)
#Define _TAB	chr(9)
#Define w0	c0+c0
#Define dw0 w0+w0
#DEFINE False   .F.
#DEFINE True    .T.

#Define CRLF	CR + LF
#Define PNULL	0

#Define BYTE_Size		1
#Define WORD_Size		2
#Define DWORD_Size		4
#Define LF_FACESIZE		32
#Define MAX_TEXTLEN		64
#Define MAX_ITEMTEXT	MAX_TEXTLEN
#Define MAX_RGB			255

*** Structure size
#Define POINT_Size  8
	** (DWORD_Size * 2)

#Define RECT_Size  16
	** (DWORD_Size * 4)

#Define POPITEM_Size  80
	** (MAX_TEXTLEN + (DWORD_Size * 4))

#Define MENUITEMINFO_Size  48
	** (DWORD_Size * 12)

#Define LOGFONT_Size  60
	** ((DWORD_Size * 5) + (BYTE_Size * 8) + LF_FACESIZE)

#Define TRIVERTEX_Size  16
	**((DWORD_Size * 2) + (WORD_Size * 4))

#Define MENUINFO_Size  28
	** (DWORD_Size * 7)

#Define MENUBARINFO_Size  32
	** (DWORD_Size + RECT_Size + (DWORD_Size * 3))

#Define BITMAP_Size  24
	** ((DWORD_Size * 4) + (WORD_Size * 2) + DWORD_Size)

#Define NONCLIENTMETRICS_size  340
	** ((DWORD_Size * 6) + LOGFONT_Size + (DWORD_Size * 2) + ;
	**		LOGFONT_Size + (DWORD_Size * 2) + (LOGFONT_Size * 3))


** Menu Flags
#Define MF_BYCOMMAND		0x0000
#Define MF_BYPOSITION	0x0400

#Define MF_ENABLED		0x0000
#Define MF_GRAYED			0x0001
#Define MF_DISABLED		0x0002
#Define MF_STRING			0x0000
#Define MF_BITMAP			0x0004
#Define MF_POPUP			0x0010
#Define MF_OWNERDRAW		0x0100
#Define MF_SEPARATOR		0x0800
#Define MF_DEFAULT		0x1000
#Define MF_MOUSESELECT	0x8000


** Menu Flags State
#Define MFS_DISABLED		0x0003  && MF_GRAYED + MF_DISABLED
#Define MFS_DEFAULT		0x1000

** Menu Flags Type
#Define MFT_OWNERDRAW	MF_OWNERDRAW
#Define MFT_SEPARATOR	MF_SEPARATOR

#Define MIM_BACKGROUND	0x0002

#Define MIIM_STATE		0x0001
#Define MIIM_SUBMENU		0x0004
#Define MIIM_DATA			0x0020
#Define MIIM_STRING		0x0040
#Define MIIM_BITMAP		0x0080
#Define MIIM_FTYPE		0x0100


#Define TPM_LEFTALIGN		0x0000
#Define TPM_TOPALIGN			0x0000
#Define TPM_LEFTBUTTON		0x0000
#Define TPM_RIGHTBUTTON		0x0002
#Define TPM_NONOTIFY			0x0080
#Define TPM_RETURNCMD		0x0100


#Define DEFAULT_CHARSET			0x0001
#Define DEFAULT_QUALITY			0x0000
#Define DEFAULT_PITCH			0x0000
#Define CLIP_DEFAULT_PRECIS	0x0000
#Define OUT_TT_PRECIS			0x0004

#Define FW_NORMAL		400
#Define FW_MEDIUM		500
#Define FW_SEMIBOLD	600
#Define FW_BOLD		700
#Define FW_HEAVY		900


#Define GWL_WNDPROC		-4
#Define SM_CXMENUCHECK	71
#Define MSGF_MENU			2
#Define NULL_BRUSH		5
#Define PS_NULL			5
#Define HTMENU				5
#Define SC_KEYMENU      0xF100
#Define GW_CHILD			5


*** Virtual Key
#Define VK_ENTER		0x00D  && Enter key
#Define VK_ESCAPE		0x01B  && Escape key
#Define VK_LEFT		0x025  && LEFT ARROW key
#Define VK_UP			0x026  && UP ARROW key
#Define VK_RIGHT		0x027  && RIGHT ARROW key
#Define VK_DOWN		0x028  && DOWN ARROW key


*** Windows Message
#Define WM_CREATE				0x0001
#Define WM_ACTIVATE			0x0006
#Define WM_SETFOCUS			0x0007
#Define WM_KILLFOCUS			0x0008
#Define WM_SYSCOLORCHANGE	0x0015
#Define WM_ACTIVATEAPP		0x001C
#Define WM_DRAWITEM			0x002B
#Define WM_MEASUREITEM		0x002C
#Define WM_WINDOWPOSCHANGED	0x047
#Define WM_CONTEXTMENU		0x007B
#Define WM_NCHITTEST			0x0084
#Define WM_NCPAINT			0x0085
#Define WM_NCMOUSEMOVE		0x00A0
#Define WM_NCLBUTTONDOWN	0x00A1
#Define WM_NCLBUTTONUP		0x00A2
#Define WM_KEYDOWN			0x0100
#Define WM_COMMAND			0x0111
#Define WM_SYSCOMMAND		0x0112
#Define WM_TIMER				0x0113
#Define WM_INITMENU			0x0116
#Define WM_INITMENUPOPUP	0x0117
#Define WM_MENUSELECT		0x011F
#Define WM_MENUCHAR			0x0120
#Define WM_ENTERIDLE			0x0121
#Define WM_UNINITMENUPOPUP	0x0125
#Define WM_MOUSEMOVE			0x0200
#Define WM_LBUTTONDOWN		0x0201
#Define WM_LBUTTONUP			0x0202
#Define WM_THEMECHANGED		0x031A
#Define WM_USER				0x0400

#Define WA_INACTIVE	0x0
#Define WA_ACTIVE		0x1

#Define ODA_DRAWENTIRE	0x1
#Define ODA_SELECT		0x2

#Define ODS_SELECTED		0x1
#Define ODS_GRAYED		0x2
#Define ODS_DISABLED		0x4


#Define COLOR_ACTIVECAPTION				2
#Define COLOR_INACTIVECAPTION				3
#Define COLOR_MENU							4
#Define COLOR_WINDOW							5
#Define COLOR_MENUTEXT						7
#Define COLOR_HIGHLIGHT						13
#Define COLOR_HIGHLIGHTTEXT				14
#Define COLOR_BTNFACE						15
#Define COLOR_BTNSHADOW						16
#Define COLOR_BTNHIGHLIGHT					20
#Define COLOR_3DDKSHADOW					21
#Define COLOR_GRADIENTACTIVECAPTION		27
#Define COLOR_GRADIENTINACTIVECAPTION	28
#Define COLOR_MENUHILIGHT					29
#Define COLOR_MENUBAR						30


#Define GRADIENT_FILL_RECT_H	0x00000000
#Define GRADIENT_FILL_RECT_V	0x00000001


#Define DT_LEFT				0x000000
#Define DT_CENTER				0x000001
#Define DT_RIGHT				0x000002
#Define DT_VCENTER			0x000004
#Define DT_SINGLELINE		0x000020
#Define DT_EXPANDTABS		0x000040
#Define DT_NOCLIP				0x000100
#Define DT_CALCRECT			0x000400
#Define DT_END_ELLIPSIS		0x008000
#Define DT_WORD_ELLIPSIS	0x040000

#Define BDR_RAISEDOUTER	 0x01
#Define BDR_SUNKENOUTER	 0x02
#Define BDR_RAISEDINNER	 0x04
#Define BDR_SUNKENINNER	 0x08

#Define BF_LEFT		0x01
#Define BF_TOP			0x02
#Define BF_RIGHT		0x04
#Define BF_BOTTOM		0x08
#Define BF_RECT		0x0F  && BitOr( BF_LEFT, BF_TOP, BF_RIGHT, BF_BOTTOM )
#Define BF_SOFT		0x1000	&& For softer buttons
#Define EDGE_RAISED	0x05  && BitOr( BDR_RAISEDOUTER, BDR_RAISEDINNER )
#Define EDGE_SUNKEN	0x0A  && BitOr( BDR_SUNKENOUTER, BDR_SUNKENINNER )


#Define ETO_OPAQUE		0x0002
#Define TA_NOUPDATECP	0
#Define TA_UPDATECP		1

#Define TA_TOP			0
#Define TA_LEFT		0
#Define TA_RIGHT		2
#Define TA_CENTER		6
#Define TA_BOTTOM		8
#Define TA_BASELINE	24
#Define VTA_CENTER	TA_CENTER


#Define TRANSPARENT	1
#Define OPAQUE			2
#Define BS_SOLID		0
#Define PS_SOLID		0


#Define HWND_DESKTOP		0
#Define HWND_TOP			0
#Define LOGPIXELSX		88
#Define LOGPIXELSY		90
#Define OBJID_MENU		0x0FFFFFFFD
#Define MNC_IGNORE		0
#Define MNC_EXECUTE		2

#Define SRCCOPY	0xCC0020

#Define SPI_GETNONCLIENTMETRICS	0x0029
#Define SPI_GETANIMATION			0x0048
#Define SPI_GETMENUSHOWDELAY		0x006A
#Define SPI_GETMENUFADE				0x1012
#Define SPI_GETDROPSHADOW			0x1024


*** ShowWindow
#Define SW_HIDE			0
#Define SW_SHOWNORMAL	1
#Define SW_SHOW			5


*** SetWindowPos Flags
#Define SWP_NOSIZE				0x0001
#Define SWP_NOZORDER				0x0004
#Define SWP_NOACTIVATE			0x0010
#Define SWP_NOCOPYBITS			0x0100
#Define SWP_NOSENDCHANGING		0x0400


*** MessageBox Icon
#Define MB_ICONHAND          0x00000010
#Define MB_ICONQUESTION      0x00000020
#Define MB_ICONEXCLAMATION   0x00000030
#Define MB_ICONASTERISK      0x00000040
#Define MB_USERICON          0x00000080
#Define MB_ICONWARNING       MB_ICONEXCLAMATION
#Define MB_ICONERROR         MB_ICONHAND
#Define MB_ICONINFORMATION   MB_ICONASTERISK
#Define MB_ICONSTOP          MB_ICONHAND


#Define IMAGE_BITMAP		0
#Define LR_LOADFROMFILE	0x0010

*** Heap Memory Flags
#Define HEAP_NO_SERIALIZE				1
#Define HEAP_GENERATE_EXCEPTIONS		4
#Define HEAP_ZERO_MEMORY				8

#Define LPTR	0x40


*** System Cursor ID
#Define IDC_ARROW  32512
#Define IDC_HAND	 32649


*** My Constants
#Define WM_DOCOMMAND		WM_USER+5
#Define WM_OPENWEB		WM_USER+6

#Define IDT_ENTERIDLE	101
#Define IDT_NONCLIENT	102
#Define IDT_TOOLTIPS		103

#Define WIN_XP				((OS(3) == '5') and (val( OS(4) ) > 0))
#Define XP_OR_HIGHER		WIN_XP or (OS(3) > '5')


***  My OD Menu Highlight Style
#Define ODHS_ALL					0x00
#Define ODHS_BITMAPONLY			0x01
#Define ODHS_ROUNDED				0x10
#Define ODHS_ROUNDED_BITMAP	0x20

***  My OD Menu Hilite Color
#Define ODHC_Office2003  0xC2EEFF
	** Rgb( 255, 238, 194 ) - Thanks to Malcolm Greene

*** My OD Menu Flags
#Define myODF_WEBLINK   0x01
#Define myODF_HASALPHA  0x02  && PixelFormat Has Alpha
#Define myODF_FRAME     0x04  && Bottom popup frame border
#Define myODF_SKIPFOR   0x10


#Define OBJ_TOP     1
#Define OBJ_LEFT    2
#Define OBJ_WIDTH   3
#Define OBJ_HEIGHT  4

#Define VFP_START_IDE  0
#Define VFP_START_EXE  4
#Define VFP_SW_INSCREEN    0
#Define VFP_SW_ASTOPLEVEL  2

#Define FORM_MODAL		1
#Define FORM_MODELESS	2

#Define TBD_TOP	0
#Define TBD_LEFT	1

#Define IDM_RESTORE  '&Restore'
#Define IDM_MINIMIZE 'Mi&nimize'
#Define IDM_MAXIMIZE 'Ma&ximize'
#Define IDM_CLOSE    '&Close'
