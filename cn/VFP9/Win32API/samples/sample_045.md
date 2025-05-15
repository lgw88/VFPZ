[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 从 Windows 桌面向下扫描子窗口的层次结构
_翻译：xinjie  2021.01.06_

## 代码：
```foxpro  
DO decl

LOCAL hParent, hWindow, cTitle, cRect
hParent = GetDesktopWindow()
hWindow = 0

CREATE CURSOR cs (winhandle I,;
	x0 I, y0 I, x1 I, y1 I, wintitle C(200))

DO WHILE .T.
	STORE REPLICATE(CHR(0),255) TO cClass, cTitle
	hWindow = FindWindowEx(hParent, hWindow,;
		Null, Null)

	IF hWindow = 0
	* 123=ERROR_INVALID_NAME
	* 127=ERROR_PROC_NOT_FOUND
		? "出错时退出:", GetLastError()
		EXIT
	ELSE
		cTitle = GetWinText(hWindow)
		cRect = GetWinRect(hWindow)
		INSERT INTO cs VALUES (hWindow,;
			buf2dword(SUBSTR(cRect, 1,4)),;
			buf2dword(SUBSTR(cRect, 5,4)),;
			buf2dword(SUBSTR(cRect, 9,4)),;
			buf2dword(SUBSTR(cRect, 13,4)),;
			cTitle)
	ENDIF
ENDDO

SELECT cs
GO TOP
BROWSE NORMAL NOWAIT
* 主程序结束

FUNCTION GetWinText(hWindow)
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), 255)
	= GetWindowText(hWindow, @cBuffer, LEN(cBuffer))
RETURN STRTRAN(cBuffer, CHR(0), "")

FUNCTION GetWinRect(hWindow)
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), 16)
	= GetWindowRect(hWindow, @cBuffer)
RETURN cBuffer

PROCEDURE decl
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER GetDesktopWindow IN user32

	DECLARE INTEGER FindWindowEx IN user32;
		INTEGER hwndParent, INTEGER hwndChildAfter,;
		STRING @lpszClass, STRING @lpszWindow

	DECLARE INTEGER GetWindowText IN user32;
		INTEGER hWnd, STRING @lpString, INTEGER nMaxCount

	DECLARE INTEGER GetWindowRect IN user32;
		INTEGER hWnd, STRING lpRect

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[FindWindowEx](../libraries/user32/FindWindowEx.md)  
[GetDesktopWindow](../libraries/user32/GetDesktopWindow.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetWindowRect](../libraries/user32/GetWindowRect.md)  
[GetWindowText](../libraries/user32/GetWindowText.md)  
