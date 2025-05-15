[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 更改系统颜色
_翻译：xinjie  2021.01.04_

## 开始之前：
该代码示例改变了任何窗口的窗口背景和活动标题的颜色，而不必费心去监听由 SetSysColors 函数广播的 WM_SYSCOLORCHANGE 消息。 

运行这个代码示例后，你会注意到，通过操作系统，所有窗口的颜色都发生了变化。这甚至包括文本框和组合框等控件。请注意，原生的 VFP 控件并不是像 VB.NET 控件那样的窗口。但它们在绘制自己的时候，确实会紧跟系统颜色。 

不要惊慌，下面就来看看如何将颜色恢复到原来的值。 
  
***  


## Code:
```foxpro  
* 注意：要将系统颜色恢复到正常状态，请释放oColorTest变量

PUBLIC oColorTest As TColorTest
oColorTest = CREATEOBJECT("TColorTest")
oColorTest.ChangeColors
* 主程序结束

DEFINE CLASS TColorTest As Session
PROTECTED ColorMask, SavedColors, NewColors

PROCEDURE Init
	THIS.declare

PROCEDURE ChangeColors
#DEFINE COLOR_SCROLLBAR 0
#DEFINE COLOR_ACTIVECAPTION 2
#DEFINE COLOR_WINDOW 5
#DEFINE COLOR_WINDOWFRAME 6
#DEFINE COLOR_MENUTEXT 7
#DEFINE COLOR_WINDOWTEXT 8
	* 这两个元素的颜色要改变，并最终恢复到原来的颜色。
	THIS.ColorMask = num2dword(COLOR_WINDOW)+;
		num2dword(COLOR_ACTIVECAPTION)

	* 原始颜色被保存在类属性
	THIS.SavedColors = num2dword(GetSysColor(COLOR_WINDOW))+;
		num2dword(GetSysColor(COLOR_ACTIVECAPTION))

	* 变色
	THIS.NewColors = num2dword(RGB(128,192,230))+;
		num2dword(RGB(192,0,192))

	= SetSysColors(2, THIS.ColorMask, THIS.NewColors)

PROCEDURE Destroy
* 确保在释放该类的实例时，所有的颜色都会被还原回来
	THIS.RestoreColors

PROCEDURE RestoreColors
	= SetSysColors(2, THIS.ColorMask, THIS.SavedColors)

PROCEDURE declare
	DECLARE INTEGER GetSysColor IN user32 INTEGER nIndex

	DECLARE INTEGER SetSysColors IN user32;
		INTEGER nElements, STRING lpSysColor,;
		STRING lpColorValues

ENDDEFINE

FUNCTION num2dword(lnValue)
#DEFINE m0 0x0000100
#DEFINE m1 0x0010000
#DEFINE m2 0x1000000
	IF lnValue < 0
		lnValue = 0x100000000 + lnValue
	ENDIF
	LOCAL b0, b1, b2, b3
	b3 = Int(lnValue/m2)
	b2 = Int((lnValue - b3*m2)/m1)
	b1 = Int((lnValue - b3*m2 - b2*m1)/m0)
	b0 = Mod(lnValue, m0)
RETURN Chr(b0)+Chr(b1)+Chr(b2)+Chr(b3)  
```  
***  


## 函数列表：
[GetSysColor](../libraries/user32/GetSysColor.md)  
[SetSysColors](../libraries/user32/SetSysColors.md)  

## 备注：
这段代码的编写可以说是一种安全的方式--当TColorTest类的实例被释放时，系统的颜色会恢复到原始值。在命令窗口中键入CLEAR ALL或直接关闭Visual FoxPro即可。 
  
***  

