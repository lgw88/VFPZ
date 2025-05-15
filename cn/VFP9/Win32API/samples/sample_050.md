[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 CreateWindowEx 函数创建窗口
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
* 扩展窗口样式
#DEFINE WS_EX_DLGMODALFRAME    1
#DEFINE WS_EX_NOPARENTNOTIFY   4
#DEFINE WS_EX_TOPMOST          8
#DEFINE WS_EX_ACCEPTFILES     16
#DEFINE WS_EX_TRANSPARENT     32
#DEFINE WS_EX_MDICHILD        64
#DEFINE WS_EX_TOOLWINDOW     128
#DEFINE WS_EX_WINDOWEDGE     256
#DEFINE WS_EX_CLIENTEDGE     512
#DEFINE WS_EX_CONTEXTHELP   1024

#DEFINE WS_EX_CONTROLPARENT 0x10000
#DEFINE WS_EX_STATICEDGE  0x20000
#DEFINE WS_EX_APPWINDOW  0x40000

#DEFINE SW_NORMAL  1
#DEFINE WS_OVERLAPPED 0
#DEFINE WS_CAPTION  0xC00000
#DEFINE WS_SYSMENU  0x80000
#DEFINE WS_THICKFRAME  0x40000
#DEFINE WS_MINIMIZEBOX  0x20000
#DEFINE WS_MAXIMIZEBOX  0x10000

DO decl

    hwnd = GetActiveWindow()
	lcClass = SPACE(250)

	lnSize = RealGetWindowClass (hwnd, @lcClass , Len(lcClass ))
	lcClass = STRTRAN (SUBSTR(lcClass, 1,lnSize), Chr(0),"")

	dwExStyle = WS_EX_APPWINDOW+WS_EX_CLIENTEDGE+WS_EX_WINDOWEDGE
	dwStyle   = WS_CAPTION+WS_SYSMENU+WS_THICKFRAME+WS_MAXIMIZEBOX+WS_MINIMIZEBOX

	hNew = CreateWindowEx (dwExStyle, lcClass, "创建的示例窗口",;
		dwStyle, 10, 10, 800, 300, hwnd, 0, 0, 0)

	= ShowWindow (hNew, SW_NORMAL)
	hDC = GetDC (hNew)
	
	lpString = "GetActiveWindow 函数检索活动窗口的句柄"
    ? TextOut (hDC, 10,10, lpString, Len(lpString)) 	

    = ReleaseDC (hNew, hDC)

PROCEDURE  decl
	DECLARE INTEGER RealGetWindowClass IN user32;
		INTEGER  hwnd,;
		STRING @ pszType,;
		INTEGER  cchType

	DECLARE INTEGER GetActiveWindow IN user32

	DECLARE INTEGER CreateWindowEx IN user32;
		INTEGER dwExStyle,;
		STRING lpClassName,;
		STRING lpWindowName,;
		INTEGER dwStyle,;
		INTEGER x,;
		INTEGER y,;
		INTEGER nWidth,;
		INTEGER nHeight,;
		INTEGER hWndParent,;
		INTEGER hMenu,;
		INTEGER hInstance,;
		INTEGER lpParam

	DECLARE INTEGER ShowWindow IN user32;
		INTEGER hwnd,;
		INTEGER nCmdShow

	DECLARE INTEGER GetDC IN user32 INTEGER hwnd

	DECLARE INTEGER TextOut IN gdi32;
        INTEGER hdc,;
        INTEGER x,;
        INTEGER y,;
        STRING  lpString,;
        INTEGER nCount

	DECLARE INTEGER ReleaseDC IN user32;
		INTEGER hwnd, INTEGER hdc  
```  
***  


## 函数列表：
[CreateWindowEx](../libraries/user32/CreateWindowEx.md)  
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetDC](../libraries/user32/GetDC.md)  
[RealGetWindowClass](../libraries/user32/RealGetWindowClass.md)  
[ReleaseDC](../libraries/user32/ReleaseDC.md)  
[ShowWindow](../libraries/user32/ShowWindow.md)  
[TextOut](../libraries/gdi32/TextOut.md)  

## 备注：
尝试使用常数设置样式和所创建窗口的扩展样式的不同组合。  
  
***  

