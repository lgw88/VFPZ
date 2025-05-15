[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 列出 Windows 桌面的子窗口
_翻译：xinjie  2021.01.03_

## 代码：
```foxpro  
#DEFINE GW_HWNDLAST 1
#DEFINE GW_HWNDNEXT 2
#DEFINE GW_CHILD 5
DO declare

CREATE CURSOR csResult (hWnd N(12), isvisible N(1),;
	leftpos I, toppos I, rightpos I, botpos I, wincap C(64), classname C(64))

LOCAL hDesktop, hFirstChild, hLastChild, rc, cWinCap, cWinClass,;
	nVisible, nLeft, nTop, nRight, nBottom

hDesktop = GetDesktopWindow()
hFirstChild = GetWindow(hDesktop, GW_CHILD)
hLastChild = GetWindow(hFirstChild, GW_HWNDLAST)

hCurrent = hFirstChild
DO WHILE .T.
	cWinCap = GetWinText(hCurrent)
	cWinClass= GetClsName(hCurrent)
	nVisible = IsWindowVisible(hCurrent)

	rc = Repli(Chr(0),16)
	= GetWindowRect(hCurrent, @rc)
	nLeft = buf2dword(SUBSTR(rc, 1,4))
	nTop = buf2dword(SUBSTR(rc, 5,4))
	nRight = buf2dword(SUBSTR(rc, 9,4))
	nBottom = buf2dword(SUBSTR(rc, 13,4))
	
	INSERT INTO csResult VALUES (hCurrent, nVisible,;
		nLeft, nTop, nRight, nBottom, cWinCap, cWinClass)

	IF hCurrent = hLastChild
		EXIT
	ENDIF
	hCurrent = GetWindow(hCurrent, GW_HWNDNEXT)
ENDDO
GO TOP
BROWSE NORMAL NOWAIT
* 主程序结束

FUNCTION GetClsName(hWindow)
    LOCAL nBufsize, cBuffer
    cBuffer = Repli(Chr(0), 250)
    nBufsize = GetClassName(hWindow, @cBuffer, Len(cBuffer))
RETURN SUBSTR(cBuffer, 1, nBufsize)

FUNCTION GetWinText(hWindow)
* 返回窗口标题栏文本--Win9*/Me/XP/2000
	LOCAL cBuffer, nResult
	cBuffer = Space(250)
	nResult = GetWindowText(hWindow, @cBuffer, Len(cBuffer))
RETURN SUBSTR(cBuffer, 1, nResult)

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)

PROCEDURE declare
	DECLARE INTEGER GetDesktopWindow IN user32
	DECLARE INTEGER GetWindow IN user32 INTEGER hwnd, INTEGER wFlag
	DECLARE INTEGER GetWindowRect IN user32 INTEGER hwnd, STRING @lpRect
	DECLARE INTEGER IsWindowVisible IN user32 INTEGER hWnd

	DECLARE INTEGER GetWindowText IN user32;
		INTEGER hwnd, STRING @lpString, INTEGER cch

    DECLARE INTEGER GetClassName IN user32;
        INTEGER hWnd, STRING lpClassName, INTEGER nMaxCount  
```  
***  


## 函数列表：
[GetClassName](../libraries/user32/GetClassName.md)  
[GetDesktopWindow](../libraries/user32/GetDesktopWindow.md)  
[GetWindow](../libraries/user32/GetWindow.md)  
[GetWindowRect](../libraries/user32/GetWindowRect.md)  
[GetWindowText](../libraries/user32/GetWindowText.md)  
[IsWindowVisible](../libraries/user32/IsWindowVisible.md)  

## Comment:
在生成的列表中，你可能会发现一个类名为 **Shell_TrayWnd** 的窗口，它就是 Windows 任务栏。使用 ShowWindow 函数可以控制其可见性。 
  
C#代码通过调用EnumWindows来枚举屏幕上的顶层窗口。 
  
***  

