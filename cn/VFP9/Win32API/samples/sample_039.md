[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 GetSysColor
_翻译：xinjie  2021.01.04_

## Code:
```foxpro  
#DEFINE COLOR_SCROLLBAR      0
#DEFINE COLOR_ACTIVECAPTION  2
#DEFINE COLOR_WINDOW         5
#DEFINE COLOR_WINDOWFRAME    6
#DEFINE COLOR_MENUTEXT       7
#DEFINE COLOR_WINDOWTEXT     8

	DECLARE INTEGER GetSysColor IN "user32" INTEGER nIndex
	
	? GetSysColor (COLOR_SCROLLBAR)
	? GetSysColor (COLOR_ACTIVECAPTION)
	? GetSysColor (COLOR_WINDOW)
	? GetSysColor (COLOR_WINDOWFRAME)
	? GetSysColor (COLOR_MENUTEXT)
	? GetSysColor (COLOR_WINDOWTEXT)

	* 其实，你可以测试整个范围
	FOR lnColor=0 TO 28
		? "系统颜色 ["
		?? lnColor
		?? "] = "
		?? GetSysColor (lnColor)
	ENDFOR  
```  
***  


## 函数列表：
[GetSysColor](../libraries/user32/GetSysColor.md)  

## 备注：
有些常量不能用于Win9或WinNT。  
  
***  

