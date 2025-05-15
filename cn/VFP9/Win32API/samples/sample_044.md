[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 GetNearestColor
_翻译：xinjie  2021.01.05_

## 代码：
```foxpro  
DO decl

	* 为VFP主窗口定义设备上下文
	hWnd = GetActiveWindow ()
	hDc = GetDC (hWnd)
	
	crColor = RGB (16, 108, 231)
	matchColor = GetNearestColor (hDc, crColor)
	? LTRIM(STR(crColor)) + " 转化为 " + LTRIM(STR(matchColor))

	= ReleaseDC (hwnd, hdc)

PROCEDURE  decl
    DECLARE INTEGER GetDC IN user32 INTEGER hwnd
    DECLARE INTEGER GetActiveWindow IN user32

	DECLARE INTEGER ReleaseDC IN user32;
		INTEGER hwnd, INTEGER hdc

    DECLARE INTEGER GetNearestColor IN gdi32;
		INTEGER hdc,;
		INTEGER crColor  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetDC](../libraries/user32/GetDC.md)  
[GetNearestColor](../libraries/gdi32/GetNearestColor.md)  
[ReleaseDC](../libraries/user32/ReleaseDC.md)  

## 备注
我用两种颜色分辨率运行这段代码。  
  
用32位真彩色，结果是：  
15166480 to 15166480  
  
用256色，结果是：  
15166480 to 8421376  
  
***  

