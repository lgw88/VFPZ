[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索系统桌面窗口的几何参数
_翻译：xinjie  2021.01.20_

## 代码：
```foxpro  
DECLARE INTEGER GetDesktopWindow IN user32
DECLARE SHORT GetWindowRect IN user32 INTEGER hwnd, STRING @ lpRect
DECLARE SHORT GetClientRect IN user32 INTEGER hwnd, STRING @ lpRect

lpRect = REPLI (Chr(0), 16)
= GetWindowRect (GetDesktopWindow(), @lpRect)
= _show (lpRect, "*** 桌面窗口区域")
	
lpRect = REPLI (Chr(0), 16)
= GetClientRect (GetDesktopWindow(), @lpRect)
= _show (lpRect, "*** 桌面窗口客户端区域")

? "*** _SCREEN 属性"
WITH _SCREEN
	? "	left:   " + STR(.Left,   6)
	? "	top:	" + STR(.Top,	6)
	? "	right:  " + STR(.Left + .Width - 1,  6)
	? "	bottom: " + STR(.Top + .Height - 1, 6)
	? "	width:  " + STR(.Width,  6)
	? "	height: " + STR(.Height, 6)
ENDWITH

PROCEDURE  _show (lpRect, lcTitle)
	lnWinLeft   = buf2dword(SUBSTR(lpRect,  1,4))
	lnWinTop	= buf2dword(SUBSTR(lpRect,  5,4))
	lnWinRight  = buf2dword(SUBSTR(lpRect,  9,4))
	lnWinBottom = buf2dword(SUBSTR(lpRect, 13,4))
	lnWinWidth  = lnWinRight - lnWinLeft + 1
	lnWinHeight = lnWinBottom - lnWinTop + 1

	? lcTitle
	? "	left:   " + STR(lnWinLeft,   6)
	? "	top:	" + STR(lnWinTop,	6)
	? "	right:  " + STR(lnWinRight,  6)
	? "	bottom: " + STR(lnWinBottom, 6)
	? "	width:  " + STR(lnWinWidth,  6)
	? "	height: " + STR(lnWinHeight, 6)
	?

FUNCTION  buf2dword (lcBuffer)
RETURN;
	Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 16777216  
```  
***  


## 函数列表：
[GetClientRect](../libraries/user32/GetClientRect.md)  
[GetDesktopWindow](../libraries/user32/GetDesktopWindow.md)  
[GetWindowRect](../libraries/user32/GetWindowRect.md)  
