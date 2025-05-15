[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 在 VFP 主窗口上打印文本
_翻译：xinjie  2021.01.04_

## 代码：
```foxpro  
#DEFINE ANSI_CHARSET          0
#DEFINE OUT_DEFAULT_PRECIS    0
#DEFINE OUT_DEVICE_PRECIS     5
#DEFINE OUT_OUTLINE_PRECIS    8

#DEFINE CLIP_DEFAULT_PRECIS   0
#DEFINE CLIP_STROKE_PRECIS    2

#DEFINE DEFAULT_QUALITY       0
#DEFINE PROOF_QUALITY         2

#DEFINE DEFAULT_PITCH         0
#DEFINE FW_BOLD             700

#DEFINE TRANSPARENT           1
#DEFINE OPAQUE                2

	DO decl
	
	lcText = "打印的文本"
	FOR ii=200 TO 1 STEP-1
		lnColor = Rgb(Max(0,255-ii), Max(0,128-ii*5), Min(255,128+ii*10))
		= _print (lcText, lnColor, -ii)

		ii = ii - 30
		= _print (lcText, Rgb(80,80,80), -ii)
	ENDFOR
	= _print (lcText, Rgb(164,0,0), 0)

PROCEDURE  _print (lcText, lnColor, lnAngle)
	hFont = CreateFont (;
		100,0, lnAngle,lnAngle, FW_BOLD, 0,0,0, ANSI_CHARSET,;
		OUT_OUTLINE_PRECIS, CLIP_STROKE_PRECIS,;
		PROOF_QUALITY, DEFAULT_PITCH, "Times New Roman")

	hwnd = GetActiveWindow()
	hdc = GetWindowDC (hwnd)

	* 在设备上下文中选择新字体并删除旧字体。
	= DeleteObject (SelectObject (hdc, hFont))

	* 设置透明背景上的文字颜色
	= SetTextColor (hdc, lnColor)
	= SetBkMode (hdc, TRANSPARENT)

	* 打印
	= TextOut (hdc, 50, 100, lcText, Len(lcText))

	* 释放系统资源
	= DeleteObject (hFont)
	= ReleaseDC (hwnd, hdc)

PROCEDURE  decl
	DECLARE INTEGER GetActiveWindow IN user32
	DECLARE INTEGER GetWindowDC IN user32 INTEGER hwnd

	DECLARE INTEGER DeleteObject IN gdi32 INTEGER hObject
	DECLARE INTEGER ReleaseDC IN user32;
		INTEGER hwnd, INTEGER hdc

	DECLARE INTEGER SetTextColor IN gdi32;
		INTEGER hdc, INTEGER crColor

	DECLARE INTEGER SelectObject IN gdi32;
		INTEGER hdc, INTEGER hObject

	DECLARE INTEGER TextOut IN gdi32;
		INTEGER hdc, INTEGER x, INTEGER y,;
		STRING  lpString, INTEGER nCount

	DECLARE INTEGER SetBkMode IN gdi32;
		INTEGER hdc, INTEGER iBkMode

	DECLARE INTEGER CreateFont IN gdi32;
		INTEGER nHeight, INTEGER nWidth,;
		INTEGER nEscapement, INTEGER nOrientation,;
		INTEGER fnWeight, INTEGER fdwItalic,;
		INTEGER fdwUnderline, INTEGER fdwStrikeOut,;
		INTEGER fdwCharSet,;
		INTEGER fdwOutputPrecision,;
		INTEGER fdwClipPrecision,;
		INTEGER fdwQuality,;
		INTEGER fdwPitchAndFamily,;
		STRING  lpszFace  
```  
***  


## 函数列表：
[CreateFont](../libraries/gdi32/CreateFont.md)  
[DeleteObject](../libraries/gdi32/DeleteObject.md)  
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetWindowDC](../libraries/user32/GetWindowDC.md)  
[ReleaseDC](../libraries/user32/ReleaseDC.md)  
[SelectObject](../libraries/gdi32/SelectObject.md)  
[SetBkMode](../libraries/gdi32/SetBkMode.md)  
[SetTextColor](../libraries/gdi32/SetTextColor.md)  
[TextOut](../libraries/gdi32/TextOut.md)  

## 备注：
任何来自 FoxPro 命令的输出，如 CLEAR 和 ?/??，都会擦掉这段代码所产生的图像。奇怪的是，CLEAR 命令甚至在源代码中高于 TextOut，有时会删除 TextOut 产生的任何打印。  
  
***  

