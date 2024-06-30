*	typedef struct tagPAINTSTRUCT { // ps  
*    HDC  hdc;
*    BOOL fErase;
*    RECT rcPaint;
*    BOOL fRestore;
*    BOOL fIncUpdate;
*    BYTE rgbReserved[32];
*} PAINTSTRUCT;

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
*　		UINT CtlType; 		// 控件类型；
*　		UINT CtlID; 		// 组合框、列表框等控件的ID标识号；
*　		UINT itemID; 		// 菜单项的ID标识号或列表框、组合框中某一项的索引值；
*　		UINT itemAction; 	// 控件行为；
*　		UINT itemState; 	// 控件状态；
*　		HWND hwndItem; 		// 父窗口句柄或菜单句柄
*　		HDC hDC; 			// 控件对应的绘图设备句柄
*　		RECT rcItem; 		// 控件所占据的矩形区域
*　		DWORD itemData; 	// 列表框或组合框中某一项的值
*	} DRAWITEMSTRUCT


*	typedef struct _RECT { 
*	  LONG left; 
*	  LONG top; 
*	  LONG right; 
*	  LONG bottom; 
*	} RECT, *PRECT


*	typedef struct tagMYPOPITEM
*	{
*		char		szItemText[64];
*		UINT		nLen;
*		HBITMAP	hBitmap;
*	} MYPOPITEM


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

*!*	typedef struct tagBITMAPINFOHEADER{ // bmih  
*!*	   DWORD  biSize;
*!*	   LONG   biWidth;
*!*	   LONG   biHeight;
*!*	   WORD   biPlanes;
*!*	   WORD   biBitCount
*!*	   DWORD  biCompression;
*!*	   DWORD  biSizeImage;
*!*	   LONG   biXPelsPerMeter;
*!*	   LONG   biYPelsPerMeter;
*!*	   DWORD  biClrUsed;
*!*	   DWORD  biClrImportant;
*!*	} BITMAPINFOHEADER;

*!*	typedef struct tagBITMAPFILEHEADER { // bmfh  
*!*	        WORD    bfType;
*!*	        DWORD   bfSize;
*!*	        WORD    bfReserved1;
*!*	        WORD    bfReserved2;
*!*	        DWORD   bfOffBits;
*!*	} BITMAPFILEHEADER;