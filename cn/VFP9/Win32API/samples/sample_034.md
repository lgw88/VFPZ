[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 在 VFP 主窗口的客户端区域打印文本
_翻译：xinjie  2021.01.04_

## 代码：
```foxpro  
DO decl

hwnd = GetActiveWindow()
hDC = GetDC (hwnd)

lpString = "使用 TextOut 打印文本"
= TextOut (hDC, 50,80, lpString, Len(lpString)) &&

= ReleaseDC (hwnd, hDC)

PROCEDURE  decl
	DECLARE INTEGER GetDC IN user32 INTEGER hwnd

	DECLARE INTEGER ReleaseDC IN user32;
		INTEGER hwnd, INTEGER hdc

	DECLARE INTEGER GetActiveWindow IN user32

	DECLARE INTEGER TextOut IN gdi32;
		INTEGER hdc,;
		INTEGER x,;
		INTEGER y,;
		STRING  lpString,;
		INTEGER nCount  
```  
***  


## 函数历表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetDC](../libraries/user32/GetDC.md)  
[ReleaseDC](../libraries/user32/ReleaseDC.md)  
[TextOut](../libraries/gdi32/TextOut.md)  

## 代码：
这段不起作用-因为没有可用的客户区。   
  
始终使用 GetWindowDC 来访问设备上下文，该上下文可用于在VFP窗口上打印和绘图。  
  
***  

