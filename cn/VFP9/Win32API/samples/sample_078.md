[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将 VFP 主窗口的尺寸与 _SCREEN 属性进行比较
_翻译：xinjie  2021.01.16_

## 代码：
```foxpro  
DO decl

* 显示对象的尺寸
DO _winRect      && VFP 主窗口
DO _clientRect   && 客户端部分
DO _screenRect   && _screen 对象

PROCEDURE _screenRect
	?
	? "*** _SCREEN 尺寸"
	? "    左:    " + STR(_screen.left,   6)
	? "    上:    " + STR(_screen.top,    6)
	? "    宽:    " + STR(_screen.width,  6)
	? "    高:    " + STR(_screen.height, 6)

PROCEDURE _winRect
	lpRect = REPLI (Chr(0), 16)
	= GetWindowRect (GetActiveWindow(), @lpRect)
	
	lnWinLeft   = buf2dword(SUBSTR(lpRect,  1,4))
	lnWinTop    = buf2dword(SUBSTR(lpRect,  5,4))
	lnWinRight  = buf2dword(SUBSTR(lpRect,  9,4))
	lnWinBottom = buf2dword(SUBSTR(lpRect, 13,4))
	lnWinWidth  = lnWinRight - lnWinLeft + 1
	lnWinHeight = lnWinBottom - lnWinTop + 1

	? "*** VFP主窗口区域"
	? "    左:    " + STR(lnWinLeft,   6)
	? "    上:    " + STR(lnWinTop,    6)
	? "    右:    " + STR(lnWinRight,  6)
	? "    下:    " + STR(lnWinBottom, 6)
	? "    宽:    " + STR(lnWinWidth,  6)
	? "    高:    " + STR(lnWinHeight, 6)

PROCEDURE _clientRect
	lpRect = REPLI (Chr(0), 16)
	= GetClientRect (GetActiveWindow(), @lpRect)
	
	?
	lnWinLeft   = buf2dword(SUBSTR(lpRect,  1,4))
	lnWinTop    = buf2dword(SUBSTR(lpRect,  5,4))
	lnWinRight  = buf2dword(SUBSTR(lpRect,  9,4))
	lnWinBottom = buf2dword(SUBSTR(lpRect, 13,4))
	lnWinWidth  = lnWinRight - lnWinLeft + 1
	lnWinHeight = lnWinBottom - lnWinTop + 1

	? "*** VFP客户端主窗口的区域"
	? "    左:    " + STR(lnWinLeft,   6)
	? "    上:    " + STR(lnWinTop,    6)
	? "    右:    " + STR(lnWinRight,  6)
	? "    下:    " + STR(lnWinBottom, 6)
	? "    宽:    " + STR(lnWinWidth,  6)
	? "    高:    " + STR(lnWinHeight, 6)

PROCEDURE decl
	DECLARE INTEGER GetActiveWindow IN user32
	DECLARE INTEGER GetWindowRect IN user32 INTEGER hwnd, STRING @lpRect
	DECLARE INTEGER GetClientRect IN user32 INTEGER hwnd, STRING @lpRect

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(cBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetClientRect](../libraries/user32/GetClientRect.md)  
[GetWindowRect](../libraries/user32/GetWindowRect.md)  

## 备注：
_SCREEN 宽度和高度受以下状态的影响。 
* VFP系统菜单（尝试RELEASE MENU _msysmenu）的状态。 
* VFP状态栏(尝试设置状态栏开/关)  
* VFP工具栏：它的停靠位置，包含多少个控件。 
* VFP命令窗口：是否可停靠改变这些对象的状态，并检查它如何影响该代码的输出。 
  
***  

