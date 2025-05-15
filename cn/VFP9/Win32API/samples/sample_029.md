[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 谁拥有 Windows 剪贴板
_翻译：xinjie  2021.01.03_

## 代码：
```foxpro  
DO declare

hWindow=GetActiveWindow()
hOwner=GetClipboardOwner()
	
? "活动窗口: ............", hWindow,;
	"["+GetWinText(hWindow)+"]"

? "_SCREEN.HWnd: .............", _screen.HWnd,;
	"["+GetWinText(_screen.HWnd)+"]"

? "拥有剪贴板的窗口: ..", hOwner,;
	"["+GetWinText(hOwner)+"]"

FUNCTION GetWinText(hWindow)
	LOCAL nBufsize, cBuffer
	nBufsize = 128
	cBuffer = Repli(Chr(0), nBufsize)
	nBufsize = GetWindowText(hWindow, @cBuffer, nBufsize)
RETURN Iif(nBufsize=0, "", Left(cBuffer, nBufsize))

PROCEDURE declare
	DECLARE INTEGER GetActiveWindow IN user32
	DECLARE INTEGER GetClipboardOwner IN user32

	DECLARE INTEGER GetWindowText IN user32;
		INTEGER hwnd, STRING @lpString, INTEGER cch  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetClipboardOwner](../libraries/user32/GetClipboardOwner.md)  
[GetWindowText](../libraries/user32/GetWindowText.md)  
