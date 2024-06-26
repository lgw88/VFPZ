********************************************************************************
*!* ctl32_api.prg
********************************************************************************
*!* |http://www.codeplex.com/VFPX/Thread/View.aspx?ThreadId=11535
*!* GDIPLUSX method of declaring and protecting api declares
*!* 200+ API declares and counting...
********************************************************************************
#Include ctl32.h
Set Procedure To Sys(16) Additive
Return

Function apiAppendMenu(hMenu, wFlags, uIDNewItem, lpNewItem)
	Declare Integer AppendMenu In win32api As apiAppendMenu ;
		Integer hMenu, ;
		Integer wFlags, ;
		Integer uIDNewItem, ;
		String  lpNewItem
	Return apiAppendMenu(m.hMenu, m.wFlags, m.uIDNewItem, m.lpNewItem)
Endfunc

Function apiAttachThreadInput(idAttach, idAttachTo, fAttach)
	Declare Integer AttachThreadInput In win32api As apiAttachThreadInput;
		Integer idAttach, ;
		Integer idAttachTo, ;
		Integer fAttach
	Return apiAttachThreadInput(m.idAttach, m.idAttachTo, m.fAttach)
Endfunc

Function apiBitBlt(hdcDest, nXDest, nYDest, nWidth, nHeight, hdcSrc, nXSrc, nYSrc, dwRop)
	Declare Integer BitBlt In win32api As apiBitBlt ;
		Integer hdcDest, ;
		Integer nXDest, ;
		Integer nYDest, ;
		Integer nWidth, ;
		Integer nHeight, ;
		Integer hdcSrc, ;
		Integer nXSrc, ;
		Integer nYSrc, ;
		Integer dwRop
	Return apiBitBlt(m.hdcDest, m.nXDest, m.nYDest, m.nWidth, m.nHeight, m.hdcSrc, m.nXSrc, m.nYSrc, m.dwRop)
Endfunc

Function apiCallWindowProc(lpPrevWndFunc, nhWnd, Msg, wParam, Lparam)
	Declare Integer CallWindowProc In win32api As apiCallWindowProc ;
		Integer lpPrevWndFunc, ;
		Integer nhWnd, ;
		Integer msg, ;
		Integer wParam, ;
		Integer Lparam
	Return apiCallWindowProc(m.lpPrevWndFunc, m.nhWnd, m.Msg, m.wParam, m.lParam)
Endfunc

Function apiCheckMenuItem(hMenu, uIDCheckItem, uCheck)
	Declare Integer CheckMenuItem In win32api As apiCheckMenuItem ;
		Integer hmenu, ;
		Integer uIDCheckItem, ;
		Integer uCheck
	Return apiCheckMenuItem(m.hMenu, m.uIDCheckItem, m.uCheck)
Endfunc

Function apiChildWindowFromPoint(nHwndParent, px, py)
	Declare Integer ChildWindowFromPoint In win32api As apiChildWindowFromPoint ;
		Integer nHwndParent,;
		Integer px,;
		Integer py
	Return apiChildWindowFromPoint(m.nHwndParent, m.px, m.py)
Endfunc

Function apiCheckMenuRadioItem(hMenu, idFirst, idLast, idCheck, uFlags)
	Declare Integer CheckMenuRadioItem In win32api As apiCheckMenuRadioItem ;
		Integer hmenu, ;
		Integer idFirst, ;
		Integer idLast, ;
		Integer idCheck, ;
		Integer uFlags
	Return apiCheckMenuRadioItem(m.hMenu, m.idFirst, m.idLast, m.idCheck, m.uFlags)
Endfunc

Function apiClientToScreen(nhWnd, lpPoint)
	Declare Integer ClientToScreen In win32api As apiClientToScreen ;
		Integer nhWnd, ;
		String  @lpPoint
	Return apiClientToScreen(m.nhWnd, @m.lpPoint)
Endfunc

Function apiCloseHandle(hObject)
	Declare Integer CloseHandle In win32api As apiCloseHandle ;
		Integer hObject
	Return apiCloseHandle(m.hObject)
Endfunc

Function apiClosePrinter(hPrinter)
	Declare Integer ClosePrinter In winspool.drv As apiClosePrinter ;
		Integer hPrinter
	Return apiClosePrinter(m.hPrinter)
Endfunc

Function apiCloseThemeData(hTheme)
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer CloseThemeData In uxtheme As apiCloseThemeData ;
			Integer hTheme
		Return apiCloseThemeData(m.hTheme)
	Else
		Return 0
	Endif
Endfunc

Function apiCoCreateGuid(pguid)
	Declare Integer CoCreateGuid In Ole32 As apiCoCreateGuid;
		String  @pguid
	Return apiCoCreateGuid(@m.pguid)
Endfunc

Function apiCreateCompatibleBitmap(hdc, nWidth, nHeight)
	Declare Integer CreateCompatibleBitmap In win32api As apiCreateCompatibleBitmap ;
		Integer hdc,;
		Integer nWidth,;
		Integer nHeight
	Return apiCreateCompatibleBitmap(m.hdc, m.nWidth, m.nHeight)
Endfunc

Function apiCreateCompatibleDC(hdc)
	Declare Integer CreateCompatibleDC In win32api As apiCreateCompatibleDC ;
		Integer hdc
	Return apiCreateCompatibleDC(m.hdc)
Endfunc

Function apiCreateFile(lpFileName, dwDesiredAccess, dwShareMode, lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile)
	Declare Integer CreateFile In win32api As apiCreateFile ;
		String  lpFileName, ;
		Integer dwDesiredAccess, ;
		Integer dwShareMode, ;
		Integer lpSecurityAttributes, ;
		Integer dwCreationDisposition, ;
		Integer dwFlagsAndAttributes, ;
		Integer hTemplateFile
	Return apiCreateFile(m.lpFileName, m.dwDesiredAccess, m.dwShareMode, m.lpSecurityAttributes, m.dwCreationDisposition, m.dwFlagsAndAttributes, m.hTemplateFile)
Endfunc

*!* lpszFace
*!* [in] Pointer to a null-terminated String that specifies the typeface
*!* name of the font. The length of this String must not exceed 32 characters,
*!* including the terminating null character.

Function apiCreateFont(nHeight, nWidth, nEscapement, nOrientation, fnWeight, fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision, fdwClipPrecision, fdwQuality, fdwPitchAndFamily, lpszFace)
	Declare Integer CreateFont In win32api As apiCreateFont ;
		Integer nHeight, ;
		Integer nWidth, ;
		Integer nEscapement, ;
		Integer nOrientation, ;
		Integer fnWeight, ;
		Integer fdwItalic, ;
		Integer fdwUnderline, ;
		Integer fdwStrikeOut, ;
		Integer fdwCharSet, ;
		Integer fdwOutputPrecision, ;
		Integer fdwClipPrecision, ;
		Integer fdwQuality, ;
		Integer fdwPitchAndFamily, ;
		String  lpszFace
	Return apiCreateFont(m.nHeight, m.nWidth, m.nEscapement, m.nOrientation, m.fnWeight, m.fdwItalic, m.fdwUnderline, m.fdwStrikeOut, m.fdwCharSet, m.fdwOutputPrecision, m.fdwClipPrecision, m.fdwQuality, m.fdwPitchAndFamily, m.lpszFace)
Endfunc

Function apiCreateFontIndirect(lpLogFont)
	Declare Integer CreateFontIndirect In win32api As apiCreateFontIndirect ;
		String  lpLogFont
	Return apiCreateFontIndirect(m.lpLogFont)
Endfunc

Function apiCreateMenu()
	Declare Integer CreateMenu In win32api As apiCreateMenu
	Return apiCreateMenu()
Endfunc

Function apiCreatePatternBrush(hBitmap)
	Declare Integer CreatePatternBrush In gdi32 As apiCreatePatternBrush ;
		Integer hBitmap
	Return apiCreatePatternBrush(m.hBitmap)
Endfunc

Function apiCreatePopupMenu()
	Declare Integer CreatePopupMenu In win32api As apiCreatePopupMenu
	Return apiCreatePopupMenu()
Endfunc

Function apiCreateRectRgn(x1, y1, x2, y2)
	Declare Integer CreateRectRgn In WIN32API As apiCreateRectRgn ;
		Integer x1, ;
		Integer y1, ;
		Integer x2, ;
		Integer y2
	Return apiCreateRectRgn(m.x1, m.y1, m.x2, m.y2)
Endfunc

Function apiCreateSolidBrush(crColor)
	Declare Integer CreateSolidBrush In win32api As apiCreateSolidBrush ;
		Integer crColor
	Return apiCreateSolidBrush(m.crColor)
Endfunc

Function apiCreateWindowEx(dwExStyle, lpClassName, lpWindowName, dwStyle, nx, ny, nWidth, nHeight, nHwndParent, hMenu, hInstance, lpParam)
	Declare Integer CreateWindowEx In win32api As apiCreateWindowEx ;
		Integer dwExStyle, ;
		String  lpClassName, ;
		String  lpWindowName, ;
		Integer dwStyle, ;
		Integer nx, ;
		Integer ny, ;
		Integer nWidth, ;
		Integer nHeight, ;
		Integer nHwndParent, ;
		Integer hMenu, ;
		Integer hInstance, ;
		Integer lpParam
	Return apiCreateWindowEx(m.dwExStyle, m.lpClassName, m.lpWindowName, m.dwStyle, m.nx, m.ny, m.nWidth, m.nHeight, m.nHwndParent, m.hMenu, m.hInstance, m.lpParam)
Endfunc

Function apiDeleteObject(hObject)
	Declare Integer DeleteObject In win32api As apiDeleteObject;
		Integer hObject
	Return apiDeleteObject(m.hObject)
Endfunc

Function apiDestroyMenu(hMenu)
	Declare Integer DestroyMenu In win32api As apiDestroyMenu;
		Integer hMenu
	Return apiDestroyMenu(m.hMenu)
Endfunc

Function apiDestroyWindow(nhWnd)
	Declare Integer DestroyWindow In win32api As apiDestroyWindow ;
		Integer nhWnd
	Return apiDestroyWindow(m.nhWnd)
Endfunc

Function apiDrawIconEx(hdc, xLeft, yTop, hIcon, cxWidth, cyWidth, istepIfAniCur, hbrFlickerFreeDraw, diFlags)
	Declare Integer DrawIconEx In win32api As apiDrawIconEx ;
		Integer hdc, ;
		Integer xLeft, ;
		Integer yTop, ;
		Integer hIcon, ;
		Integer cxWidth, ;
		Integer cyWidth, ;
		Integer istepIfAniCur, ;
		Integer hbrFlickerFreeDraw, ;
		Integer diFlags
	Return apiDrawIconEx(m.hdc, m.xLeft, m.yTop, m.hIcon, m.cxWidth, m.cyWidth, m.istepIfAniCur, m.hbrFlickerFreeDraw, m.diFlags)
Endfunc

Function apiDrawThemeBackground(hTheme, hdc, iPartId, iStateId, pRect, pClipRect)
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer DrawThemeBackground In uxtheme As apiDrawThemeBackground ;
			Integer hTheme, ;
			Integer hdc, ;
			Integer iPartId, ;
			Integer iStateId, ;
			String  pRect, ;
			String  pClipRect
		Return apiDrawThemeBackground(m.hTheme, m.hdc, m.iPartId, m.iStateId, m.pRect, m.pClipRect)
	Else
		Return 0
	Endif
Endfunc

Function apiEnableMenuItem(hMenu, uIDEnableItem, uEnable)
	Declare Integer EnableMenuItem In win32api As apiEnableMenuItem;
		Integer hMenu, ;
		Integer uIDEnableItem, ;
		Integer uEnable
	Return apiEnableMenuItem(m.hMenu, m.uIDEnableItem, m.uEnable)
Endfunc

Function apiEnableWindow(nhWnd, bEnable)
	Declare Integer EnableWindow In win32api As apiEnableWindow ;
		Integer nhWnd, ;
		Integer bEnable
	Return apiEnableWindow(m.nhWnd, m.bEnable)
Endfunc

Function apiFileTimeToSystemTime(lpFileTime, lpSystemTime)
	Declare Integer FileTimeToSystemTime In win32api As apiFileTimeToSystemTime ;
		String  lpFileTime, ;
		String  @lpSystemTime
	Return apiFileTimeToSystemTime(m.lpFileTime, @m.lpSystemTime)
Endfunc

Function apiFillRect(hdc, lprc, hbr)
	Declare Integer FillRect In WIN32API As apiFillRect ;
		Integer hDC, ;
		String lprc, ;
		Integer hbr
	Return apiFillRect(m.hdc, m.lprc, m.hbr)
Endfunc

Function apiEndDocPrinter(hPrinter)
	Declare Integer EndDocPrinter In winspool.drv As apiEndDocPrinter;
		Integer hPrinter
	Return apiEndDocPrinter(m.hPrinter)
Endfunc

Function apiFileTimeToLocalFileTime(lpFileTime, lpLocalFileTime)
	Declare Integer FileTimeToLocalFileTime In win32api As apiFileTimeToLocalFileTime ;
		String  lpFileTime, ;
		String  @lpLocalFileTime
	Return apiFileTimeToLocalFileTime(m.lpFileTime, @m.lpLocalFileTime)
Endfunc

Function apiFindFirstFile(lpFileName, lpFindFileData)
	Declare Integer FindFirstFile In WIN32API As apiFindFirstFile ;
		String  lpFileName, ;
		String  @lpFindFileData
	Return apiFindFirstFile(m.lpFileName, @m.lpFindFileData)
Endfunc

Function apiFindWindow(lpClassName, lpWindowName)
	Declare Integer FindWindow In win32api As apiFindWindow;
		String  lpClassName, ;
		String  lpWindowName
	Return apiFindWindow(m.lpClassName, m.lpWindowName)
Endfunc

Function apiFindWindowEx(hWnd1, hWnd2, lpsz1, lpsz2)
	Declare Integer FindWindowEx In win32api As apiFindWindowEx ;
		Integer hWnd1, ;
		Integer hWnd2, ;
		String  lpsz1, ;
		String  lpsz2
	Return apiFindWindowEx(m.hWnd1, m.hWnd2, m.lpsz1, m.lpsz2)
Endfunc

Function apiFormatMessage(dwFlags, lpSource, dwMessageId, dwLanguageId, lpBuffer, nSize, Arguments)
	Declare Integer FormatMessage In win32api As apiFormatMessage ;
		Integer dwFlags, ;
		Integer lpSource, ;
		Integer dwMessageId, ;
		Integer dwLanguageId, ;
		String  @lpBuffer, ;
		Integer nSize, ;
		Integer Arguments
	Return apiFormatMessage(m.dwFlags, m.lpSource, m.dwMessageId, m.dwLanguageId, @m.lpBuffer, m.nSize, m.Arguments)
Endfunc

Function apiFreeLibrary(hLibModule)
	Declare Integer FreeLibrary In win32api As apiFreeLibrary ;
		Integer hLibModule
	Return apiFreeLibrary(m.hLibModule)
Endfunc

Function apiFtpCommand(hConnect, fExpectResponse, dwFlags, lpszCommand, dwContext, phFtpCommand)
	Declare Integer FtpCommand In wininet As apiFtpCommand ;
		Integer hConnect, ;
		Integer fExpectResponse, ;
		Integer dwFlags, ;
		String  lpszCommand, ;
		Integer dwContext, ;
		Integer @phFtpCommand
	Return apiFtpCommand(m.hConnect, m.fExpectResponse, m.dwFlags, m.lpszCommand, m.dwContext, @m.phFtpCommand)
Endfunc

Function apiFtpCreateDirectory(hConnect, lpszDirectory)
	Declare Integer FtpCreateDirectory In wininet As apiFtpCreateDirectory ;
		Integer hConnect, ;
		String  lpszDirectory
	Return apiFtpCreateDirectory(m.hConnect, m.lpszDirectory)
Endfunc

Function apiFtpDeleteFile(hConnect, lpszFileName)
	Declare Integer FtpDeleteFile In wininet As apiFtpDeleteFile ;
		Integer hConnect, ;
		String  lpszFileName
	Return apiFtpDeleteFile(m.hConnect, m.lpszFileName)
Endfunc

Function apiFtpFindFirstFile(hConnect, lpszSearchFile, lpFindFileData, dwFlags, dwContext)
	Declare Integer FtpFindFirstFile In wininet As apiFtpFindFirstFile ;
		Integer hConnect, ;
		String  lpszSearchFile, ;
		String  @lpFindFileData, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiFtpFindFirstFile(m.hConnect, m.lpszSearchFile, @m.lpFindFileData, m.dwFlags, m.dwContext)
Endfunc

Function apiFtpGetCurrentDirectory(hConnect, lpszCurrentDirectory, lpdwCurrentDirectory)
	Declare Integer FtpGetCurrentDirectory In wininet As apiFtpGetCurrentDirectory ;
		Integer hConnect, ;
		String  @lpszCurrentDirectory, ;
		Integer @lpdwCurrentDirectory
	Return apiFtpGetCurrentDirectory(m.hConnect, @m.lpszCurrentDirectory, @m.lpdwCurrentDirectory)
Endfunc

Function apiFtpGetFile(hConnect, lpszRemoteFile, lpszNewFile, fFailIfExists, dwFlagsAndAttributes, dwFlags, dwContext)
	Declare Integer FtpGetFile In wininet As apiFtpGetFile ;
		Integer hConnect, ;
		String  lpszRemoteFile, ;
		String  lpszNewFile, ;
		Integer fFailIfExists, ;
		Integer dwFlagsAndAttributes, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiFtpGetFile(m.hConnect, m.lpszRemoteFile, m.lpszNewFile, m.fFailIfExists, m.dwFlagsAndAttributes, m.dwFlags, m.dwContext)
Endfunc

Function apiFtpGetFileSize(hFile, lpdwFileSizeHigh)
	Declare Integer FtpGetFileSize In wininet As apiFtpGetFileSize ;
		Integer hFile, ;
		Integer @lpdwFileSizeHigh
	Return apiFtpGetFileSize(m.hFile, @m.lpdwFileSizeHigh)
Endfunc

Function apiFtpOpenFile(hConnect, lpszFileName, dwAccess, dwFlags, dwContext)
	Declare Integer FtpOpenFile In wininet As apiFtpOpenFile ;
		Integer hConnect, ;
		String  lpszFileName, ;
		Integer dwAccess, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiFtpOpenFile(m.hConnect, m.lpszFileName, m.dwAccess, m.dwFlags, m.dwContext)
Endfunc

Function apiFtpPutFile(hConnect, lpszLocalFile, lpszNewRemoteFile, dwFlags, dwContext)
	Declare Integer FtpPutFile In wininet As apiFtpPutFile ;
		Integer hConnect, ;
		String  lpszLocalFile, ;
		String  lpszNewRemoteFile, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiFtpPutFile(m.hConnect, m.lpszLocalFile, m.lpszNewRemoteFile, m.dwFlags, m.dwContext)
Endfunc

Function apiFtpRemoveDirectory(hConnect, lpszDirectory)
	Declare Integer FtpRemoveDirectory In wininet As apiFtpRemoveDirectory ;
		Integer hConnect, ;
		String  lpszDirectory
	Return apiFtpRemoveDirectory(m.hConnect, m.lpszDirectory)
Endfunc

Function apiFtpRenameFile(hConnect, lpszExisting, lpszNew)
	Declare Integer FtpRenameFile In wininet As apiFtpRenameFile ;
		Integer hConnect, ;
		String  lpszExisting, ;
		String  lpszNew
	Return apiFtpRenameFile(m.hConnect, m.lpszExisting, m.lpszNew)
Endfunc

Function apiFtpSetCurrentDirectory(hConnect, lpszDirectory)
	Declare Integer FtpSetCurrentDirectory In wininet As apiFtpSetCurrentDirectory ;
		Integer hConnect, ;
		String  lpszDirectory
	Return apiFtpSetCurrentDirectory(m.hConnect, m.lpszDirectory)
Endfunc

Function apiGetCaretPos(lpPoint)
	Declare Integer GetCaretPos In win32api As apiGetCaretPos;
		String @lpPoint
	Return apiGetCaretPos(@m.lpPoint)
Endfunc

Function apiGetClassLong(m.nhWnd, m.nIndex)
	Declare Integer GetClassLong In win32api As apiGetClassLong;
		Integer nhWnd, ;
		Integer nIndex
	Return apiGetClassLong(m.nhWnd, m.nIndex)
Endfunc

Function apiGetClientRect(m.nhWnd, m.lcRect)
	Declare Integer GetClientRect In win32api As apiGetClientRect ;
		Integer nhWnd,;
		String  @lcRect
	Return apiGetClientRect(m.nhWnd, @m.lcRect)
Endfunc

Function apiGetCursorPos(m.lpPoint)
	Declare Integer GetCursorPos In win32api As apiGetCursorPos;
		String  @lpPoint
	Return apiGetCursorPos(@m.lpPoint)
Endfunc

Function apiGetDateFormat(m.Locale, m.dwFlags, m.lpDate, m.lpFormat, m.lpDateStr, m.cchDate)
	Declare Integer GetDateFormat In win32api As apiGetDateFormat ;
		Integer Locale, ;
		Integer dwFlags, ;
		String  lpDate, ;
		String  lpFormat, ;
		String  @lpDateStr, ;
		Integer cchDate
	Return apiGetDateFormat(m.Locale, m.dwFlags, m.lpDate, m.lpFormat, @m.lpDateStr, m.cchDate)
Endfunc

Function apiGetDC(m.nhWnd)
	Declare Integer GetDC In win32api As apiGetDC ;
		Integer nhWnd
	Return apiGetDC(m.nhWnd)
Endfunc

Function apiGetDesktopWindow()
	Declare Integer GetDesktopWindow In win32api As apiGetDesktopWindow
	Return apiGetDesktopWindow()
Endfunc

Function apiGetDeviceCaps(m.hdc, m.nIndex)
	Declare Integer GetDeviceCaps In win32api As apiGetDeviceCaps ;
		Integer hdc, ;
		Integer nIndex
	Return apiGetDeviceCaps(m.hdc, m.nIndex)
Endfunc

Function apiGetDoubleClickTime()
	Declare Integer GetDoubleClickTime In win32api As apiGetDoubleClickTime
	Return apiGetDoubleClickTime()
Endfunc

Function apiGetFileSizeEx(m.hFile, m.lpFileSize)
	Declare Integer GetFileSizeEx In win32api As apiGetFileSizeEx ;
		Integer hFile, ;
		String  @lpFileSize
	Return apiGetFileSizeEx(m.hFile, @m.lpFileSize)
Endfunc

Function apiGetForegroundWindow()
	Declare Integer GetForegroundWindow In win32api As apiGetForegroundWindow
	Return apiGetForegroundWindow()
Endfunc

Function apiGetIpAddrTable(m.pIpAddrTable, m.pdwSize, m.nbOrder)
	Declare Integer GetIpAddrTable In iphlpapi As apiGetIpAddrTable ;
		String  @pIpAddrTable, ;
		Integer @pdwSize, ;
		Integer  nbOrder
	Return apiGetIpAddrTable(@m.pIpAddrTable, @m.pdwSize, m.nbOrder)
Endfunc

Function apiGetKeyState(m.nVirtKey)
	Declare Integer GetKeyState In win32api As apiGetKeyState ;
		Integer nVirtKey
	Return apiGetKeyState(m.nVirtKey)
Endfunc

Function apiGetLastError()
	Declare Integer GetLastError In win32api As apiGetLastError
	Return apiGetLastError()
Endfunc

Function apiGetLocaleInfo(m.Locale, m.LCType, m.lpLCData, m.cchData)
	Declare Integer GetLocaleInfo In win32api As apiGetLocaleInfo;
		Integer Locale, ;
		Integer LCType, ;
		String  @lpLCData, ;
		Integer cchData
	Return apiGetLocaleInfo(m.Locale, m.LCType, @m.lpLCData, m.cchData)
Endfunc

Function apiGetMenu(m.nhWnd)
	Declare Integer GetMenu In win32api As apiGetMenu ;
		Integer nhWnd
	Return apiGetMenu(m.nhWnd)
Endfunc

Function apiGetMenuBarInfo(m.nhWnd, m.idObject, m.idItem, m.pmbi)
	Declare Integer GetMenuBarInfo In win32api As apiGetMenuBarInfo ;
		Integer nhWnd, ;
		Integer idObject, ;
		Integer idItem, ;
		String  @pmbi
	Return apiGetMenuBarInfo(m.nhWnd, m.idObject, m.idItem, m.pmbi)
Endfunc

*!* The GetMenuCheckMarkDimensions function is included only for compatibility
*!* with 16-bit versions of Microsoft Windows. Applications should use the
*!* GetSystemMetrics function with the CXMENUCHECK and CYMENUCHECK values to
*!* retrieve the bitmap dimensions.

Function apiGetMenuCheckMarkDimensions()
	Return apiGetSystemMetrics(SM_CXMENUCHECK) + apiGetSystemMetrics(SM_CYMENUCHECK) * 0x10000
Endfunc

Function apiGetMenuContextHelpId(m.hMenu)
	Declare Integer GetMenuContextHelpId In win32api As apiGetMenuContextHelpId ;
		Integer hMenu
	Return apiGetMenuContextHelpId(m.hMenu)
Endfunc

Function apiGetMenuDefaultItem(m.hMenu, m.fByPos, m.gmdiFlags)
	Declare Integer GetMenuDefaultItem In win32api As apiGetMenuDefaultItem ;
		Integer hMenu, ;
		Integer fByPos, ;
		Integer gmdiFlags
	Return apiGetMenuDefaultItem(m.hMenu, m.fByPos, m.gmdiFlags)
Endfunc

Function apiGetMenuInfo(m.hMenu, m.lpcmi)
	Declare Integer GetMenuInfo In win32api As apiGetMenuInfo ;
		Integer hmenu, ;
		String  @lpcmi
	Return apiGetMenuInfo(m.hMenu, m.lpcmi)
Endfunc

Function apiGetMenuItemCount(m.hMenu)
	Declare Integer GetMenuItemCount In win32api As apiGetMenuItemCount ;
		Integer hMenu
	Return apiGetMenuItemCount(m.hMenu)
Endfunc

Function apiGetMenuItemID(m.hMenu, m.nPos)
	Declare Integer GetMenuItemID In win32api As apiGetMenuItemID ;
		Integer hMenu, ;
		Integer nPos
	Return apiGetMenuItemID(m.hMenu, m.nPos)
Endfunc

Function apiGetMenuItemInfo(m.hMenu, m.uItem, m.fByPosition, m.lpmii)
	Declare Integer GetMenuItemInfo In win32api As apiGetMenuItemInfo ;
		Integer hMenu, ;
		Integer uItem, ;
		Integer fByPosition, ;
		String  @lpmii
	Return apiGetMenuItemInfo(m.hMenu, m.uItem, m.fByPosition, @m.lpmii)
Endfunc

Function apiGetMenuItemRect(m.nhWnd, m.hMenu, m.uItem, m.lprcItem)
	Declare Integer GetMenuItemRect In win32api As apiGetMenuItemRect ;
		Integer nhWnd, ;
		Integer hMenu, ;
		Integer uItem, ;
		String  @lprcItem
	Return apiGetMenuItemRect(m.nhWnd, m.hMenu, m.uItem, @m.lprcItem)
Endfunc

Function apiGetMenuState(m.hMenu, m.uID, m.uwFlags)
	Declare Integer GetMenuState In win32api As apiGetMenuState ;
		Integer hMenu, ;
		Integer uID, ;
		Integer uFlags
	Return apiGetMenuState(m.hMenu, m.uID, m.uwFlags)
Endfunc

Function apiGetMenuString(m.hMenu, m.uIDItem , m.lpString , m.nMaxCount , m.uFlag)
	Declare Integer GetMenuString In win32api As apiGetMenuString ;
		Integer hMenu, ;
		Integer uIDItem, ;
		String  @lpString, ;
		Integer nMaxCount, ;
		Integer uFlag
	Return apiGetMenuString(m.hMenu, m.uIDItem , @m.lpString , m.nMaxCount , m.uFlag)
Endfunc

Function apiGetModuleHandle(m.lpModule)
	Declare Integer GetModuleHandle In win32api As apiGetModuleHandle ;
		String  lpModule
	Return apiGetModuleHandle(m.lpModule)
Endfunc

Function apiGetMonitorInfo(m.hMonitor, m.lpmi)
	Declare Integer GetMonitorInfo In win32api As apiGetMonitorInfo ;
		Integer hMonitor, ;
		String  @lpmi
	Return apiGetMonitorInfo(m.hMonitor, @m.lpmi)
Endfunc

Function apiGetObject(m.hObject, m.nCount, m.lpObject)
*#beautify keyword_nochange
	Declare Integer GetObject In win32api as apiGetObject ;
		Integer hObject, ;
		Integer nCount, ;
		String  @lpObject
*#beautify
	Return apiGetObject(m.hObject, m.nCount, @m.lpObject)
Endfunc

Function apiGetParent(m.nhWnd)
	Declare Integer GetParent In win32api As apiGetParent;
		Integer nhWnd
	Return apiGetParent(m.nhWnd)
Endfunc

Function apiGetPrivateProfileString(m.lpAppName, m.lpKeyName, m.lpDefault, m.lpReturnedString, m.nSize, m.lpFileName)
	Declare Integer GetPrivateProfileString In WIN32API As apiGetPrivateProfileString ;
		String  lpAppName,;
		String  lpKeyName,;
		String  lpDefault,;
		String  @lpReturnedString,;
		Integer nSize,;
		String  lpFileName
	Return apiGetPrivateProfileString(m.lpAppName, m.lpKeyName, m.lpDefault, @m.lpReturnedString, m.nSize, m.lpFileName)
Endfunc

Function apiGetProcAddress(m.hModule, m.lpProcName)
	Declare Integer GetProcAddress In win32api As apiGetProcAddress;
		Integer hModule, ;
		String  lpProcName
	Return apiGetProcAddress(m.hModule, m.lpProcName)
Endfunc

Function apiGetProcessHeap()
	Declare Integer GetProcessHeap In win32api As apiGetProcessHeap
	Return apiGetProcessHeap()
Endfunc

Function apiGetProp(m.nhWnd, m.lpString)
	Declare Integer GetProp In win32api As apiGetProp ;
		Integer nhWnd, ;
		String  lpString
	Return apiGetProp(m.nhWnd, m.lpString)
Endfunc

Function apiGetStockObject(m.fnObject)
	Declare Integer GetStockObject In win32api As apiGetStockObject ;
		Integer fnObject
	Return apiGetStockObject(m.fnObject)
Endfunc

Function apiGetSubMenu(m.hMenu, m.nPos)
	Declare Integer GetSubMenu In win32api As apiGetSubMenu ;
		Integer hMenu, ;
		Integer nPos
	Return apiGetSubMenu(m.hMenu, m.nPos)
Endfunc

Function apiGetSysColor(m.nIndex)
	Declare Integer GetSysColor In win32api As apiGetSysColor ;
		Integer nIndex
	Return apiGetSysColor(m.nIndex)
Endfunc

Function apiGetTextExtentPoint32(m.hdc, m.lpsz, m.cbString, m.lpSize)
	Declare Integer GetTextExtentPoint32 In win32api As apiGetTextExtentPoint32 ;
		Integer hdc, ;
		String  lpsz, ;
		Integer cbString, ;
		String  @lpSize
	Return apiGetTextExtentPoint32(m.hdc, m.lpsz, m.cbString, @m.lpSize)
Endfunc

Function apiGetThemeBitmap(m.hTheme, m.iPartId, m.iStateId , m.iPropId, m.dwFlags, m.phBitmap)
	If ctlGetOsVersion() >= NTDDI_VISTA
		Declare Integer GetThemeBitmap In uxtheme As apiGetThemeBitmap ;
			Integer hTheme, ;
			Integer iPartId, ;
			Integer iStateId, ;
			Integer dwFlags, ;
			Integer @phBitmap
		Return apiGetThemeBitmap(m.hTheme, m.iPartId, m.iStateId , m.iPropId, m.dwFlags, m.phBitmap)
	Else
		Return 0
	Endif
Endfunc

Function apiGetThemeColor(m.hTheme, m.iPartId , m.iStateId , m.iPropId, m.pColor)
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer GetThemeColor In uxtheme As apiGetThemeColor ;
			Integer hTheme, ;
			Integer iPartId, ;
			Integer iStateId, ;
			Integer iPropId, ;
			Integer @pColor
		Return apiGetThemeColor(m.hTheme, m.iPartId , m.iStateId , m.iPropId , @m.pColor )
	Else
		Return ERROR_INVALID_FUNCTION
	Endif
Endfunc

Function apiGetThemePartSize(m.hTheme, m.hdc, m.iPartId, m.iStateId, m.prc, m.eSize, m.psz)
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer GetThemePartSize In uxtheme As apiGetThemePartSize ;
			Integer hTheme, ;
			Integer hdc, ;
			Integer iPartId, ;
			Integer iStateId, ;
			String  prc, ;
			Integer eSize, ;
			String  @psz
		Return apiGetThemePartSize(m.hTheme, m.hdc, m.iPartId, m.iStateId, m.prc, m.eSize, @m.psz)
	Else
		Return 0
	Endif
Endfunc

Function apiGetTickCount()
	Declare Integer GetTickCount In win32api As apiGetTickCount
	Return apiGetTickCount()
Endfunc

Function apiGetUserName(m.lpBuffer, m.nSize)
	Declare Integer GetUserName In advapi32 As apiGetUserName;
		String  @lpBuffer,;
		Integer @nSize
	Return apiGetUserName(@m.lpBuffer, @m.nSize)
Endfunc

Function apiGetScrollPos (m.nWnd, m.nBar)
	Declare Integer GetScrollPos In win32api As apiGetScrollPos ;
		Integer nhWnd, ;
		Integer nBar
	Return apiGetScrollPos(m.nWnd, m.nBar)
Endfunc

Function apiGetScrollRange(m.nhWnd, m.nBar, m.lpMinPos, m.lpMaxPos)
	Declare Integer GetScrollRange In win32api As apiGetScrollRange ;
		Integer nhWnd, ;
		Integer nBar, ;
		Integer @lpMinPos, ;
		Integer @lpMaxPos
	Return apiGetScrollRange(m.nhWnd, m.nBar, @m.lpMinPos, @m.lpMaxPos)
Endfunc

Function apiGetSystemMetrics(m.nIndex)
	Declare Integer GetSystemMetrics In win32api As apiGetSystemMetrics ;
		Integer nIndex
	Return apiGetSystemMetrics(m.nIndex)
Endfunc

Function apiGetWindow(m.nhWnd, m.wCmd)
	Declare Integer GetWindow In win32api As apiGetWindow;
		Integer nhWnd, ;
		Integer wCmd
	Return apiGetWindow(m.nhWnd, m.wCmd)
Endfunc

Function apiGetWindowLong(m.nhWnd, m.nIndex)
	Declare Integer GetWindowLong In win32api As apiGetWindowLong;
		Integer nhWnd, ;
		Integer nIndex
	Return apiGetWindowLong(m.nhWnd, m.nIndex)
Endfunc

Function apiGetWindowPlacement(m.nhWnd, m.lpwndpl)
	Declare Integer GetWindowPlacement In win32api As apiGetWindowPlacement ;
		Integer nhWnd, ;
		String  @lpwndpl
	Return apiGetWindowPlacement(m.nhWnd, @m.lpwndpl)
Endfunc

Function apiGetWindowRect(m.nhWnd, m.lcRect)
	Declare Integer GetWindowRect In win32api As apiGetWindowRect ;
		Integer nhWnd, ;
		String  @lcRect
	Return apiGetWindowRect(m.nhWnd, @m.lcRect)
Endfunc

Function apiGetWindowThreadProcessId(m.nhWnd, m.lpdwProcessId)
	Declare Integer GetWindowThreadProcessId In win32api As apiGetWindowThreadProcessId;
		Integer nhWnd, ;
		Integer lpdwProcessId
	Return apiGetWindowThreadProcessId(m.nhWnd, m.lpdwProcessId)
Endfunc

Function apiHeapAlloc(m.hHeap, m.dwFlags, m.dwBytes)
	Declare Integer HeapAlloc In win32api As apiHeapAlloc ;
		Integer hHeap, ;
		Integer dwFlags, ;
		Integer dwBytes
	Return apiHeapAlloc(m.hHeap, m.dwFlags, m.dwBytes)
Endfunc

Function apiHeapSize(m.hHeap, m.dwFlags, m.lpMem)
	Declare Integer HeapSize In win32api As apiHeapSize;
		Integer hHeap, ;
		Integer dwFlags, ;
		Integer lpMem
	Return apiHeapSize(m.hHeap, m.dwFlags, m.lpMem)
Endfunc

Function apiHeapFree(m.hHeap, m.dwFlags, m.lpMem)
	Declare Integer HeapFree In win32api As apiHeapFree;
		Integer hHeap, ;
		Integer dwFlags, ;
		Integer lpMem
	Return apiHeapFree(m.hHeap, m.dwFlags, m.lpMem)
Endfunc

Function apiInsertMenuItem(m.hMenu, m.uItem, m.fByPosition, lpmii)
	Declare Integer InsertMenuItem In win32api As apiInsertMenuItem ;
		Integer hMenu, ;
		Integer uItem, ;
		Integer fByPosition, ;
		String  @lpmii
	Return apiInsertMenuItem(m.hMenu, m.uItem, m.fByPosition, @lpmii)
Endfunc

Function apiInitCommonControlsEx(m.lpInitCtrls)
	Declare Integer InitCommonControlsEx In comctl32 As apiInitCommonControlsEx ;
		String  lpInitCtrls
	Return apiInitCommonControlsEx(m.lpInitCtrls)
Endfunc

Function apiInternetCloseHandle(m.hInternet)
	Declare Integer InternetCloseHandle In wininet As apiInternetCloseHandle ;
		Integer hInternet
	Return apiInternetCloseHandle(m.hInternet)
Endfunc

Function apiInternetConnect(m.hInternet, m.lpszServerName, m.nServerPort, m.lpszUserName, m.lpszPassword, m.dwService, m.dwFlags, m.dwContext)
	Declare Integer InternetConnect In wininet As apiInternetConnect ;
		Integer hInternet, ;
		String  lpszServerName, ;
		Integer nServerPort, ;
		String  lpszUserName, ;
		String  lpszPassword, ;
		Integer dwService, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiInternetConnect(m.hInternet, m.lpszServerName, m.nServerPort, m.lpszUserName, m.lpszPassword, m.dwService, m.dwFlags, m.dwContext)
Endfunc

Function apiInternetCrackUrl(m.lpszUrl, m.dwUrlLength, m.dwFlags, m.lpUrlComponents)
	Declare Integer InternetCrackUrl In wininet As apiInternetCrackUrl ;
		String  lpszUrl, ;
		Integer dwUrlLength, ;
		Integer dwFlags, ;
		String  @lpUrlComponents
	Return apiInternetCrackUrl(m.lpszUrl, m.dwUrlLength, m.dwFlags, @m.lpUrlComponents)
Endfunc

Function apiInternetErrorDlg(m.nhWnd, m.hRequest, m.dwError, m.dwFlags, m.lppvData)
	Declare Integer InternetErrorDlg In wininet As apiInternetErrorDlg ;
		Integer nhWnd, ;
		Integer hRequest, ;
		Integer dwError, ;
		Integer dwFlags, ;
		Integer lppvData
	Return apiInternetErrorDlg(m.nhWnd, m.hRequest, m.dwError, m.dwFlags, m.lppvData)
Endfunc

Function apiInternetFindNextFile(m.hFind, m.lpFindFileData)
	Declare Integer InternetFindNextFile In wininet As apiInternetFindNextFile ;
		Integer hFind, ;
		String  @lpFindFileData
	Return apiInternetFindNextFile(m.hFind, @m.lpFindFileData)
Endfunc

Function apiInternetGetLastResponseInfo(m.lpdwError, m.lpszBuffer, m.lpdwBufferLength)
	Declare Integer InternetGetLastResponseInfo In wininet As apiInternetGetLastResponseInfo ;
		Integer @lpdwError, ;
		String  @lpszBuffer, ;
		Integer @lpdwBufferLength
	Return apiInternetGetLastResponseInfo(@m.lpdwError, @m.lpszBuffer, @m.lpdwBufferLength)
Endfunc

Function apiInternetOpen(m.lpszAgent, m.dwAccessType, m.lpszProxy, m.lpszProxyBypass, m.dwFlags)
	Declare Integer InternetOpen In wininet As apiInternetOpen ;
		String  lpszAgent, ;
		Integer dwAccessType, ;
		String  lpszProxy, ;
		String  lpszProxyBypass, ;
		Integer dwFlags
	Return apiInternetOpen(m.lpszAgent, m.dwAccessType, m.lpszProxy, m.lpszProxyBypass, m.dwFlags)
Endfunc

Function apiInternetQueryDataAvailable(m.hFile, m.lpdwNumberOfBytesAvailable, m.dwFlags, m.dwContext)
	Declare Integer InternetQueryDataAvailable In wininet As apiInternetQueryDataAvailable ;
		Integer hFile, ;
		Integer @lpdwNumberOfBytesAvailable, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiInternetQueryDataAvailable(m.hFile, @m.lpdwNumberOfBytesAvailable, m.dwFlags, m.dwContext)
Endfunc

Function apiInternetQueryOption(m.hInternet, m.dwOption, m.lpBuffer, m.lpdwBufferLength)
	Declare Integer InternetQueryOption In wininet As apiInternetQueryOption ;
		Integer hInternet, ;
		Integer dwOption, ;
		String  @lpBuffer, ;
		Integer @lpdwBufferLength
	Return apiInternetQueryOption(m.hInternet, m.dwOption, @m.lpBuffer, @m.lpdwBufferLength)
Endfunc

Function apiInternetReadFile(m.hFile, m.lpBuffer, m.dwNumberOfBytesToRead, m.lpdwNumberOfBytesRead)
	Declare Integer InternetReadFile In wininet As apiInternetReadFile ;
		Integer hFile, ;
		String  @lpBuffer, ;
		Integer dwNumberOfBytesToRead, ;
		Integer @lpdwNumberOfBytesRead
	Return apiInternetReadFile(m.hFile, @m.lpBuffer, m.dwNumberOfBytesToRead, @m.lpdwNumberOfBytesRead)
Endfunc

Function apiInternetReadFileEx(m.hFile, m.lpBuffersOut, m.dwFlags, m.dwContext)
	Declare Integer InternetReadFileEx In wininet As apiInternetReadFileEx ;
		Integer hFile, ;
		String  @lpBuffersOut, ;
		Integer dwFlags, ;
		Integer dwContext
	Return apiInternetReadFileEx(m.hFile, m.lpBuffersOut, m.dwFlags, m.dwContext)
Endfunc

Function apiInternetSetFilePointer(m.hFile, m.lDistanceToMove, m.pReserved, m.dwMoveMethod, m.dwContext)
	Declare Integer InternetSetFilePointer In wininet As apiInternetSetFilePointer ;
		Integer hFile, ;
		Integer lDistanceToMove, ;
		String  pReserved, ;
		Integer dwMoveMethod, ;
		Integer dwContext
	Return apiInternetSetFilePointer(m.hFile, m.lDistanceToMove, m.pReserved, m.dwMoveMethod, m.dwContext)
Endfunc

Function apiInternetSetOption(m.hInternet, m.dwOption, m.lpBuffer, m.dwBufferLength)
	Declare Integer InternetSetOption In wininet As apiInternetSetOption ;
		Integer hInternet, ;
		Integer dwOption, ;
		String  lpBuffer, ;
		Integer dwBufferLength
	Return apiInternetSetOption(m.hInternet, m.dwOption, m.lpBuffer, m.dwBufferLength)
Endfunc

Function apiInternetWriteFile(m.hFile, m.lpBuffer, m.dwNumberOfBytesToWrite, m.lpdwNumberOfBytesWritten)
	Declare Integer InternetWriteFile In wininet As apiInternetWriteFile ;
		Integer hFile, ;
		String  lpBuffer, ;
		Integer dwNumberOfBytesToWrite, ;
		Integer @lpdwNumberOfBytesWritten
	Return apiInternetWriteFile(m.hFile, m.lpBuffer, m.dwNumberOfBytesToWrite, @m.lpdwNumberOfBytesWritten)
Endfunc

Function apiIsIconic(m.nhWnd)
	Declare Integer IsIconic In win32api As apiIsIconic;
		Integer nhWnd
	Return apiIsIconic(m.nhWnd)
Endfunc

Function apiIsThemeActive()
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer IsThemeActive In uxtheme As apiIsThemeActive
		Return apiIsThemeActive()
	Else
		Return 0
	Endif
Endfunc

Function apiIsWindow(m.nhWnd)
	Declare Integer IsWindow In win32api As apiIsWindow ;
		Integer nhWnd
	Return apiIsWindow(m.nhWnd)
Endfunc

Function apiKeybd_Event(m.bVk, m.bScan, m.dwFlags, m.dwExtraInfo)
	Declare Integer keybd_event In win32api As apiKeybd_Event ;
		Integer bVk, ;
		Integer bScan, ;
		Integer dwFlags, ;
		Integer dwExtraInfo
	Return apiKeybd_Event(m.bVk, m.bScan, m.dwFlags, m.dwExtraInfo)
Endfunc

Function apiKillTimer(m.nhWnd, m.nIDEvent)
	Declare Integer KillTimer In win32api As apiKillTimer ;
		Integer nhWnd, ;
		Integer nIDEvent
	Return apiKillTimer(m.nhWnd, m.nIDEvent)
Endfunc

Function apiLoadLibrary(m.lpLibFileName)
	Declare Integer LoadLibrary In win32api As apiLoadLibrary;
		String lpLibFileName
	Return apiLoadLibrary(m.lpLibFileName)
Endfunc

Function apiLoadMenu(m.hInstance, m.lpMenuName)
	Declare Integer LoadMenu In win32api As apiLoadMenu ;
		Integer hInstance, ;
		Integer lpMenuName
	Return apiLoadMenu(m.hInstance, m.lpMenuName)
Endfunc

Function apiMonitorFromRect(m.lprc, m.dwFlags)
	Declare Integer MonitorFromRect In win32api As apiMonitorFromRect ;
		String  @lprc, ;
		Integer dwFlags
	Return apiMonitorFromRect(@m.lprc, m.dwFlags)
Endfunc

Function apiMulDiv(m.nNumber, m.nNumerator, m.nDenominator)
	Declare Integer MulDiv In win32api As apiMulDiv ;
		Integer nNumber, ;
		Integer nNumerator, ;
		Integer nDenominator
	Return apiMulDiv(m.nNumber, m.nNumerator, m.nDenominator)
Endfunc

*!* Only use this function with 16-bit versions of Windows. For newer
*!* applications, use the CreateFile function.

Function apiOpenFile(m.lpFileName, m.lpReOpenBuff, m.wStyle)
	Declare Integer OpenFile In win32api As apiOpenFile ;
		String  lpFileName, ;
		String  @lpReOpenBuff, ;
		Integer wStyle
	Return apiOpenFile(m.lpFileName, @m.lpReOpenBuff, m.wStyle)
Endfunc

Function apiOpenPrinter(m.pPrinterName, m.phPrinter, m.pDefault)
	Declare Integer OpenPrinter In winspool.drv As apiOpenPrinter ;
		String  pPrinterName, ;
		Integer @phPrinter, ;
		Integer pDefault
	Return apiOpenPrinter(m.pPrinterName, @m.phPrinter, m.pDefault)
Endfunc

Function apiOpenThemeData(m.nhWnd, m.pszClassList)
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer OpenThemeData In uxtheme As apiOpenThemeData ;
			Integer nhWnd, ;
			String  pszClassList
		Return apiOpenThemeData(m.nhWnd, m.pszClassList)
	Else
		Return 0
	Endif
Endfunc

Function apiPrintDlg(m.lppd)
	Declare Integer PrintDlg In comdlg32 As apiPrintDlg;
		String  @lppd
	Return apiPrintDlg(@m.lppd)
Endfunc

Function apiPrintDlgEx(m.lppd)
	Declare Integer PrintDlgEx In comdlg32 As apiPrintDlgEx;
		String  @lppd
	Return apiPrintDlgEx(@m.lppd)
Endfunc

Function apiReadFile(m.hFile, m.lpBuffer, m.nNumberOfBytesToRead, m.lpNumberOfBytesRead, m.lpOverlapped)
	Declare Integer ReadFile In win32api As apiReadFile ;
		Integer hFile, ;
		String  @lpBuffer, ;
		Integer nNumberOfBytesToRead, ;
		Integer @lpNumberOfBytesRead, ;
		Integer lpOverlapped
	Return apiReadFile(m.hFile, @m.lpBuffer, m.nNumberOfBytesToRead, @m.lpNumberOfBytesRead, m.lpOverlapped)
Endfunc

Function apiRealGetWindowClass(m.nhWnd, m.pszType, m.cchType)
	Declare Integer RealGetWindowClass In win32api As apiRealGetWindowClass ;
		Integer nhWnd, ;
		String  @pszType, ;
		Integer cchType
	Return apiRealGetWindowClass(m.nhWnd, @m.pszType, m.cchType)
Endfunc

Function apiRedrawWindow(m.nhWnd, m.lprcUpdate, m.hrgnUpdate, m.uFlags)
	Declare Integer RedrawWindow In win32api As apiRedrawWindow ;
		Integer nhWnd, ;
		String  lprcUpdate, ;
		Integer hrgnUpdate, ;
		Integer uflags
	Return apiRedrawWindow(m.nhWnd, m.lprcUpdate, m.hrgnUpdate, m.uFlags)
Endfunc

Function apiRegCloseKey(m.hKeyHandle)
	Declare Integer RegCloseKey In Advapi32 As apiRegCloseKey;
		Integer hKeyHandle
	Return apiRegCloseKey(m.hKeyHandle)
Endfunc

Function apiRegCreateKeyEx(m.hKey, m.lpSubKey, m.Reserved, m.lpClass, m.dwOptions, m.samDesired, m.lpSecurityAttributes, m.phkResult, m.lpdwDisposition)
	Declare Integer RegCreateKeyEx In Advapi32 As apiRegCreateKeyEx ;
		Integer hKey, ;
		String  lpSubKey, ;
		Integer Reserved, ;
		String  lpClass, ;
		Integer dwOptions, ;
		Integer samDesired, ;
		Integer lpSecurityAttributes, ;
		Integer @phkResult, ;
		Integer @lpdwDisposition
	Return apiRegCreateKeyEx(m.hKey, m.lpSubKey, m.Reserved, m.lpClass, m.dwOptions, m.samDesired, m.lpSecurityAttributes, @m.phkResult, @m.lpdwDisposition)
Endfunc

Function apiRegDeleteKey(m.hKey, m.lpSubKey)
	Declare Integer RegDeleteKey In Advapi32 As apiRegDeleteKey ;
		Integer hKey, ;
		String  lpSubKey
	Return apiRegDeleteKey(m.hKey, m.lpSubKey)
Endfunc

Function apiRegDeleteValue(m.hKey, m.lpValueName)
	Declare Integer RegDeleteValue In advapi32 As apiRegDeleteValue ;
		Integer hKey, ;
		String  lpValueName
	Return apiRegDeleteValue(m.hKey, m.lpValueName)
Endfunc

Function apiRegOpenKeyEx(m.hKey, m.lpSubKey, m.ulOptions, m.samDesired, m.phkResult)
	Declare Integer RegOpenKeyEx In advapi32 As apiRegOpenKeyEx;
		Integer hKey, ;
		String  lpSubKey, ;
		Integer ulOptions, ;
		Integer samDesired, ;
		Integer @phkResult
	Return apiRegOpenKeyEx(m.hKey, m.lpSubKey, m.ulOptions, m.samDesired, @m.phkResult)
Endfunc

Function apiRegQueryValueEx(m.hKeyHandle, m.lpValueName, m.lpReserved, m.lpType, m.lpData, m.lpcbData)
	Declare Integer RegQueryValueEx In advapi32 As apiRegQueryValueEx ;
		Integer hKeyHandle, ;
		String  lpValueName, ;
		Integer lpReserved, ;
		Integer @lpType, ;
		String  @lpData, ;
		Integer @lpcbData
	Return apiRegQueryValueEx(m.hKeyHandle, m.lpValueName, m.lpReserved, @m.lpType, @m.lpData, @m.lpcbData)
Endfunc

Function apiRegSetValueEx(m.hKeyHandle, m.lpValueName, m.Reserved, m.dwType, m.lpData, m.cbData)
	Declare Integer RegSetValueEx In advapi32 As apiRegSetValueEx ;
		Integer hKeyHandle, ;
		String  lpValueName, ;
		Integer Reserved, ;
		Integer dwType, ;
		String  @lpData, ;
		Integer cbData
	Return apiRegSetValueEx(m.hKeyHandle, m.lpValueName, m.Reserved, m.dwType, @m.lpData, m.cbData)
Endfunc

Function apiReleaseDC(m.nhWnd, m.hdc)
	Declare Integer ReleaseDC In win32api As apiReleaseDC ;
		Integer nhWnd, ;
		Integer hdc
	Return apiReleaseDC(m.nhWnd, m.hdc)
Endfunc

Function apiScreenToClient(m.nhWnd, m.lpPoint)
	Declare Integer ScreenToClient In win32api As apiScreenToClient ;
		Integer nhWnd, ;
		String  @lpPoint
	Return apiScreenToClient(m.nhWnd, @m.lpPoint)
Endfunc

Function apiSelectObject(m.hdc, m.hObject)
	Declare Integer SelectObject In win32api As apiSelectObject ;
		Integer hdc, ;
		Integer hObject
	Return apiSelectObject(m.hdc, m.hObject)
Endfunc

*!* 2008-04-18 Changed to wrap apiSendMessage with a string lParam
*!* and apiSendMessage with an integer lParam
Function apiSendMessage(m.nhWnd, m.Msg, m.wParam, m.lParam)
	If Vartype(m.lParam) = T_CHARACTER Then
		Return apiSendMessageStrParam(m.nhWnd, m.Msg, m.wParam, @m.lParam)
	Else
		Return apiSendMessageIntParam(m.nhWnd, m.Msg, m.wParam, m.lParam)
	Endif
Endfunc

Function apiSendMessageStrParam(m.nhWnd, m.Msg, m.wParam, m.lParam)
	Declare Integer SendMessage In win32api As apiSendMessageStrParam ;
		Integer nhWnd, ;
		Integer Msg, ;
		Integer wParam, ;
		String  @Lparam
	Return apiSendMessageStrParam(m.nhWnd, m.Msg, m.wParam, @m.lParam)
Endfunc

Function apiSendMessageIntParam(m.nhWnd, m.Msg, m.wParam, m.lParam)
	Declare Integer SendMessage In win32api As apiSendMessageIntParam ;
		Integer nhWnd, ;
		Integer Msg, ;
		Integer wParam, ;
		Integer Lparam
	Return apiSendMessageIntParam(m.nhWnd, m.Msg, m.wParam, m.lParam)
Endfunc

Function apiSetClassLong(m.nhWnd, m.nIndex, m.dwNewLong)
	Declare Integer SetClassLong In win32api As apiSetClassLong ;
		Integer nhWnd, ;
		Integer nIndex, ;
		Integer dwNewLong
	Return apiSetClassLong(m.nhWnd, m.nIndex, m.dwNewLong)
Endfunc

Function apiSetFilePointerEx(m.hFile, m.iDistanceToMoveLow, m.iDistanceToMoveHigh, m.lpNewFilePointer, m.dwMoveMethod)
	Declare Integer SetFilePointerEx In win32api As apiSetFilePointerEx ;
		Integer hFile, ;
		Integer iDistanceToMoveLow, ;
		Integer iDistanceToMoveHigh, ;
		String  @lpNewFilePointer, ;
		Integer dwMoveMethod
	Return apiSetFilePointerEx(m.hFile, m.iDistanceToMoveLow, m.iDistanceToMoveHigh, @m.lpNewFilePointer, m.dwMoveMethod)
Endfunc

Function apiSetFocus(m.nhWnd)
	Declare Integer SetFocus In win32api As apiSetFocus ;
		Integer nhWnd
	Return apiSetFocus(m.nhWnd)
Endfunc

Function apiSetForegroundWindow(m.nhWnd)
	Declare Integer SetForegroundWindow In win32api As apiSetForegroundWindow ;
		Integer nhWnd
	Return apiSetForegroundWindow(m.nhWnd)
Endfunc

Function apiSetMenu(m.nhWnd, m.hMenu)
	Declare Integer SetMenu In win32api As apiSetMenu;
		Integer nhWnd, ;
		Integer hMenu
	Return apiSetMenu(m.nhWnd, m.hMenu)
Endfunc

Function apiSetMenuDefaultItem(m.hMenu, m.uItem, m.fByPos)
	Declare Integer SetMenuDefaultItem In win32api As apiSetMenuDefaultItem;
		Integer hMenu, ;
		Integer uItem, ;
		Integer fByPos
	Return apiSetMenuDefaultItem(m.hMenu, m.uItem, m.fByPos)
Endfunc

Function apiSetMenuInfo(m.hMenu, m.lpcmi)
	Declare Integer SetMenuInfo In win32api As apiSetMenuInfo;
		Integer hmenu, ;
		String  @lpcmi
	Return apiSetMenuInfo(m.hMenu, @m.lpcmi)
Endfunc

Function apiSetMenuItemBitmaps(m.hMenu, m.uPosition, m.uFlags, m.hBitmapUnchecked, m.hBitmapChecked)
	Declare Integer SetMenuItemBitmaps In win32api As apiSetMenuItemBitmaps ;
		Integer hMenu, ;
		Integer uPosition, ;
		Integer uFlags, ;
		Integer hBitmapUnchecked, ;
		Integer hBitmapChecked
	Return apiSetMenuItemBitmaps(m.hMenu, m.uPosition, m.uFlags, m.hBitmapUnchecked, m.hBitmapChecked)
Endfunc

Function apiSetMenuItemInfo(m.hMenu, m.uItem, m.fByPosition, m.lpmii)
	Declare Integer SetMenuItemInfo In win32api As apiSetMenuItemInfo;
		Integer hMenu, ;
		Integer uItem, ;
		Integer fByPosition, ;
		String  @lpmii
	Return apiSetMenuItemInfo(m.hMenu, m.uItem, m.fByPosition, @m.lpmii)
Endfunc

Function apiSetParent(m.nHwndChild, m.nHwndNewParent)
	Declare Integer SetParent In win32api As apiSetParent ;
		Integer nHwndChild, ;
		Integer nHwndNewParent
	Return apiSetParent(m.nHwndChild, m.nHwndNewParent)
Endfunc

Function apiSetProp(m.nhWnd, m.lpString, m.hData)
	Declare Integer SetProp In win32api As apiSetProp ;
		Integer nhWnd, ;
		String  lpString, ;
		Integer hData
	Return apiSetProp(m.nhWnd, m.lpString, m.hData)
Endfunc

Function apiSetScrollInfo(nhWnd, fnBar, lpsi, fRedraw)
	Declare Integer SetScrollInfo In win32api As apiSetScrollInfo ;
		Integer nhWnd, ;
		Integer fnBar, ;
		String  @lpsi, ;
		Integer fRedraw
	Return apiSetScrollInfo(m.nhWnd, m.fnBar, @m.lpsi, m.fRedraw)
Endfunc

Function apiSetTimer(nhWnd, nIDEvent, uElapse, lpTimerFunc)
	Declare Integer SetTimer In win32api As apiSetTimer ;
		Integer nhWnd, ;
		Integer nIDEvent, ;
		Integer uElapse, ;
		Integer lpTimerFunc
	Return apiSetTimer(m.nhWnd, m.nIDEvent, m.uElapse, m.lpTimerFunc)
Endfunc

Function apiSetWindowLong(nhWnd, nIndex, dwNewLong)
	Declare Integer SetWindowLong In win32api As apiSetWindowLong ;
		Integer nhWnd, ;
		Integer nIndex, ;
		Integer dwNewLong
	Return apiSetWindowLong(m.nhWnd, m.nIndex, m.dwNewLong)
Endfunc

Function apiSetWindowPlacement(nhWnd, lpwndpl)
	Declare Integer SetWindowPlacement In win32api As apiSetWindowPlacement;
		Integer nhWnd, ;
		String  lpwndpl
	Return apiSetWindowPlacement(m.nhWnd, m.lpwndpl)
Endfunc

Function apiSetWindowPos(nhWnd, nHwndInsertAfter, nx, ny, cx, cy, wFlags)
	Declare Integer SetWindowPos In win32api As apiSetWindowPos ;
		Integer nhWnd, ;
		Integer nHwndInsertAfter, ;
		Integer nx, ;
		Integer ny, ;
		Integer cx, ;
		Integer cy, ;
		Integer wFlags
	Return apiSetWindowPos(m.nhWnd, m.nHwndInsertAfter, m.nx, m.ny, m.cx, m.cy, m.wFlags)
Endfunc

Function apiSetWindowRgn(nhWnd, hRgn, bRedraw)
	Declare Integer SetWindowRgn In WIN32API As apiSetWindowRgn ;
		Integer nhWnd, ;
		Integer hRgn, ;
		Integer bRedraw
	Return apiSetWindowRgn(m.nhWnd, m.hRgn, m.bRedraw)
Endfunc

Function apiSetWindowTheme(nhWnd, pszSubAppName, pszSubIdList)
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer SetWindowTheme In uxtheme As apiSetWindowTheme ;
			Integer nhWnd, ;
			String  pszSubAppName, ;
			String  pszSubIdList
		Return  apiSetWindowTheme(m.nhWnd, m.pszSubAppName, m.pszSubIdList)
	Else
		Return 0
	Endif
Endfunc

Function apiSHDeleteKey(hKey, pszSubKey)
	Declare Integer SHDeleteKey In shlwapi As apiSHDeleteKey ;
		Integer hkey, ;
		String  pszSubKey
	Return apiSHDeleteKey(m.hKey, m.pszSubKey)
Endfunc

Function apiShellExecute(nhWnd, lpOperation, lpFile, lpParameters, lpDirectory, nShowCmd)
	Declare Integer ShellExecute In shell32 As apiShellExecute ;
		Integer nhWnd, ;
		String  lpOperation, ;
		String  lpFile, ;
		String  lpParameters, ;
		String  lpDirectory, ;
		Integer nShowCmd
	Return apiShellExecute(m.nhWnd, m.lpOperation, m.lpFile, m.lpParameters, m.lpDirectory, m.nShowCmd)
Endfunc

Function apiSHGetFolderPath(nHwndOwner, nFolder, hToken, dwFlags, pszPath)
	Declare Integer SHGetFolderPath In shfolder As apiSHGetFolderPath;
		Integer nHwndOwner, ;
		Integer nFolder, ;
		Integer hToken, ;
		Integer dwFlags, ;
		String  @pszPath
	Return apiSHGetFolderPath(m.nHwndOwner, m.nFolder, m.hToken, m.dwFlags, @m.pszPath)
Endfunc

Function apiShowScrollBar(nhWnd, wBar, bShow)
	Declare Integer ShowScrollBar In win32api As apiShowScrollBar ;
		Integer nhWnd, ;
		Integer wBar, ;
		Integer bShow
	Return apiShowScrollBar(m.nhWnd, m.wBar, m.bShow)
Endfunc

Function apiShowWindow(nhWnd, nCmdShow)
*#beautify keyword_nochange
	Declare Integer ShowWindow In win32api As apiShowWindow ;
		Integer nhWnd, ;
		Integer nCmdShow
*#beautify
	Return apiShowWindow(m.nhWnd, m.nCmdShow)
Endfunc

Function apiStartDocPrinter(hPrinter, nLevel, pDocInfo)
	Declare Integer StartDocPrinter In winspool.drv As apiStartDocPrinter ;
		Integer hPrinter,  ;
		Integer nLevel,  ;
		String  pDocInfo
	Return apiStartDocPrinter(m.hPrinter, m.nLevel, m.pDocInfo)
Endfunc

Function apiStrFormatByteSize(dw, szBuf, uiBufSize)
	Declare Integer StrFormatByteSize In shlwapi As apiStrFormatByteSize;
		Integer dw, ;
		String  @szBuf, ;
		Integer uiBufSize
	Return apiStrFormatByteSize(m.dw, @m.szBuf, m.uiBufSize)
Endfunc

Function apiStrFormatByteSize64(dw, szBuf, uiBufSize)
	Declare Integer StrFormatByteSize64 In shlwapi As apiStrFormatByteSize64;
		Integer dw, ;
		String  @szBuf, ;
		Integer uiBufSize
	Return apiStrFormatByteSize64(m.dw, @m.szBuf, m.uiBufSize)
Endfunc

Function apiStringFromGUID2(rguid, lpsz, cchMax)
	Declare Integer StringFromGUID2 In ole32 As apiStringFromGUID2;
		String  rguid, ;
		String  @lpsz, ;
		Integer cchMax
	Return apiStringFromGUID2(m.rguid, @m.lpsz, m.cchMax)
Endfunc

Function apiSystemParametersInfo(uiAction, uiParam, pvParam, fWinIni)
	Declare Integer SystemParametersInfo In win32api As apiSystemParametersInfo ;
		Integer uiAction, ;
		Integer uiParam, ;
		String  @pvParam, ;
		Integer fWinIni
	Return apiSystemParametersInfo(m.uiAction, m.uiParam, @m.pvParam, m.fWinIni)
Endfunc

Function apiTrackPopupMenuEx(hMenu, fuFlags, nx, ny, nhWnd, lptpm)
	Declare Integer TrackPopupMenuEx In win32api As apiTrackPopupMenuEx;
		Integer hMenu, ;
		Integer fuFlags, ;
		Integer nX, ;
		Integer nY, ;
		Integer nhWnd, ;
		String  @lptpm
	Return apiTrackPopupMenuEx(m.hMenu, m.fuFlags, m.nx, m.ny, m.nhWnd, @m.lptpm)
Endfunc

Function apiURLDownloadToFile(pCaller, szURL, szFileName, dwReserved, lpfnCB)
	Declare Integer URLDownloadToFile In urlmon As apiURLDownloadToFile;
		Integer pCaller, ;
		String szURL, ;
		String szFileName, ;
		Integer dwReserved, ;
		Integer lpfnCB
	Return apiURLDownloadToFile(m.pCaller, m.szURL, m.szFileName, m.dwReserved, m.lpfnCB)
Endfunc

Function apiUuidCreate(Uuid)
	Declare Integer UuidCreate In rpcrt4 As apiUuidCreate ;
		String @Uuid
	Return apiUuidCreate(@m.Uuid)
Endfunc

Function apiUuidCreateNil(Nil_Uuid)
	Declare Integer UuidCreateNil In rpcrt4 As apiUuidCreateNil ;
		String @Nil_Uuid
	Return apiUuidCreate(@m.Nil_Uuid)
Endfunc

Function apiUuidCreateSequential(Uuid)
	Declare Integer UuidCreateSequential In rpcrt4 As apiUuidCreateSequential ;
		String @Uuid
	Return apiUuidCreateSequential(@m.Uuid)
Endfunc

Function apiUuidFromString(StringUuid, Uuid)
	Declare Integer UuidFromString In rpcrt4 As apiUuidFromString ;
		String StringUuid, ;
		String @Uuid
	Return 	apiUuidFromString(m.StringUuid, @m.Uuid)
Endfunc

Function apiUuidToString(Uuid, StringUuid)
	Declare Integer UuidToString In rpcrt4 As apiUuidToString ;
		String  Uuid, ;
		Integer @StringUuid
	Return apiUuidToString(m.Uuid, @m.StringUuid)
Endfunc

Function apiWindowFromPoint(PointX, PointY)
	Declare Integer WindowFromPoint In win32api As apiWindowFromPoint ;
		Integer PointX, ;
		Integer PointY
	Return apiWindowFromPoint(m.PointX, m.PointY)
Endfunc

Function apiWriteFile(hFile, lpBuffer, nNumberOfBytesToWrite, lpNumberOfBytesWritten, lpOverlapped)
	Declare Integer WriteFile In win32api As apiWriteFile ;
		Integer hFile, ;
		String  lpBuffer, ;
		Integer nNumberOfBytesToWrite, ;
		Integer @lpNumberOfBytesWritten, ;
		Integer lpOverlapped
	Return apiWriteFile(m.hFile, m.lpBuffer, m.nNumberOfBytesToWrite, @m.lpNumberOfBytesWritten, m.lpOverlapped)
Endfunc

Function apiWritePrinter(hPrinter, pBuf, cbBuf, pcWritten)
	Declare Integer WritePrinter In winspool.drv As apiWritePrinter;
		Integer hPrinter, ;
		String  pBuf, ;
		Integer cbBuf,  ;
		Integer @pcWritten
	Return apiWritePrinter(m.hPrinter, m.pBuf, m.cbBuf, @m.pcWritten)
Endfunc

Function apiWritePrivateProfileString(lpAppName, lpKeyName, lpString, lpFileName)
	Declare Integer WritePrivateProfileString In win32api As apiWritePrivateProfileString ;
		String  lpAppName, ;
		String  lpKeyName, ;
		String  lpString, ;
		String  lpFileName
	Return apiWritePrivateProfileString(m.lpAppName, m.lpKeyName, m.lpString, m.lpFileName)
Endfunc

********************************************************************************
*!* END ctl32_api
********************************************************************************
