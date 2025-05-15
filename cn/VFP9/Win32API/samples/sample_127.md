[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 将 Form.Closable 设置为 False 的另一种方法

_翻译：xinjie  2020.01.30_

## 开始之前：
![](../images/closable.png)  

参看：  
* [如何在 FoxPro 表单上绘制自定义窗口标题](sample_499.md)  
* [如何在表单内部创建透明区域——在表单中打孔](sample_126.md)  
* [圆形 FoxPro 表单](sample_143.md)  
* [半透明表单](sample_453.md)  
  
***  


## 代码：
```foxpro  
PUBLIC oForm
oForm = CREATEOBJECT("TestForm")
oForm.Visible = .T.

DEFINE CLASS TestForm As Form
#DEFINE SM_CXSIZE 30
#DEFINE SM_CYSIZE 31
#DEFINE SM_CXFRAME 32
#DEFINE SM_CYFRAME 33
#DEFINE RGN_XOR 3

	Width=500
	Height=300
	AutoCenter=.T.
	Caption="Closing button, ahem... disabled"

PROCEDURE Load
	THIS.declare

PROCEDURE Activate
	THIS.RegionOn

PROCEDURE Resize
	THIS.RegionOn

PROCEDURE RegionOn
	LOCAL lnBtnWidth, lnBtnHeight, hRgnBase,;
		hRgnExcl, hWindow, x1,y1

	* or use SYSMETRIC
	lnBtnWidth = GetSystemMetrics(SM_CXSIZE) +;
		GetSystemMetrics(SM_CXFRAME) + 1

	lnBtnHeight = GetSystemMetrics(SM_CYSIZE) +;
		GetSystemMetrics(SM_CYFRAME) + 1

	hWindow = GetFocus()
*	hWindow = ThisForm.HWnd
	THIS.GetFormRect(hWindow, @x1,@y1)

	hRgnBase = CreateRectRgn(0,0,x1,y1)

	hRgnExcl = CreateRectRgn(x1-lnBtnWidth,0,;
		x1,lnBtnHeight)

	= CombineRgn(hRgnBase, hRgnBase,;
		hRgnExcl, RGN_XOR)

	= SetWindowRgn(hWindow, hRgnBase, 1)
	= DeleteObject(hRgnBase)
	= DeleteObject(hRgnExcl)

PROCEDURE GetFormRect(hWindow, x1,y1)
	LOCAL lpRect
	lpRect = SPACE(16)
	= GetWindowRect(hWindow, @lpRect)

	x1 = THIS.buf2dword(SUBSTR(lpRect, 9,4)) -;
		THIS.buf2dword(SUBSTR(lpRect, 1,4))

	y1 = THIS.buf2dword(SUBSTR(lpRect, 13,4)) -;
		THIS.buf2dword(SUBSTR(lpRect, 5,4))

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(cBuffer, 2,1)), 8) +;
	BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)

PROCEDURE declare
	DECLARE INTEGER GetSystemMetrics IN user32;
		INTEGER nIndex

	DECLARE INTEGER DeleteObject IN gdi32;
		INTEGER hObject

	DECLARE INTEGER GetFocus IN user32

	DECLARE SetWindowRgn IN user32;
		INTEGER hWindow, INTEGER hRgn, SHORT bRedraw

	DECLARE SHORT GetWindowRect IN user32;
		INTEGER hWindow, STRING @lpRect

	DECLARE INTEGER CreateRectRgn IN gdi32;
		INTEGER nLeftRect, INTEGER nTopRect,;
		INTEGER nRightRect, INTEGER nBottomRect

	DECLARE INTEGER CombineRgn IN gdi32;
		INTEGER hrgnDest, INTEGER hrgnSrc1,;
		INTEGER hrgnSrc2,;
		INTEGER fnCombineMode

ENDDEFINE  
```  
***  


## 函数列表：
[CombineRgn](../libraries/gdi32/CombineRgn.md)  
[CreateRectRgn](../libraries/gdi32/CreateRectRgn.md)  
[DeleteObject](../libraries/gdi32/DeleteObject.md)  
[GetFocus](../libraries/user32/GetFocus.md)  
[GetSystemMetrics](../libraries/user32/GetSystemMetrics.md)  
[GetWindowRect](../libraries/user32/GetWindowRect.md)  
[SetWindowRgn](../libraries/user32/SetWindowRgn.md)  


***  

