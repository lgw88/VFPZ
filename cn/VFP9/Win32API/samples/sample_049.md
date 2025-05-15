[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 获取 VFP 主窗口的窗口类名称
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
DO declare

LOCAL hWindow
hWindow = GetActiveWindow()

? "GetActiveWindow():", hWindow
? "窗口类:", GetWindowClass(hWindow)
? "窗口标题:", GetWindowCaption(hWindow)
?
? "_vfp.hWnd:", _vfp.hWnd
? "_screen.hWnd:", _screen.hWnd
? "_SCREEN.Caption:", _screen.Caption

FUNCTION GetWindowClass(lnWindow)
	LOCAL lnLength, lcText

	lcText = SPACE(250)
	lnLength = RealGetWindowClass(lnWindow,;
		@lcText, Len(lcText))

RETURN IIF(lnLength > 0,;
	Left(lcText, lnLength), "#empty#")

FUNCTION GetWindowCaption(lnWindow)
	LOCAL lnLength, lcText

	lcText = SPACE(250)
	lnLength = GetWindowText(lnWindow,;
		@lcText, Len(lcText))

RETURN IIF(lnLength > 0,;
	Left(lcText, lnLength), "#empty#")

PROCEDURE declare
	DECLARE INTEGER GetActiveWindow IN user32

	DECLARE INTEGER RealGetWindowClass IN user32;
		INTEGER hWindow, STRING @ pszType,;
		INTEGER cchType

	DECLARE INTEGER GetWindowText IN user32;
		INTEGER hWindow,;
		STRING @lpString, INTEGER cch  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetWindowText](../libraries/user32/GetWindowText.md)  
[RealGetWindowClass](../libraries/user32/RealGetWindowClass.md)  

## 备注：
比较以下情况的结果  
\- 在命令窗口中使用DO运行这段代码。 
\- 在打开的程序编辑窗口中使用Ctrl+E运行这段代码  
  
***  

