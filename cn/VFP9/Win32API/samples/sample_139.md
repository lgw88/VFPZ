[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 隐藏鼠标光标

_翻译：xinjie  2022.01.30_

## 代码：
```foxpro  
DECLARE INTEGER ShowCursor IN user32 INTEGER bShow

PROCEDURE _hide
	DO WHILE ShowCursor(0) >= -1
		DOEVENTS
	ENDDO

PROCEDURE _show
	DO WHILE ShowCursor(1) < 0
		DOEVENTS
	ENDDO  
```  
***  


## 函数列表：
[ShowCursor](../libraries/user32/ShowCursor.md)  

## 备注：
在 Visual FoxPro 中，SET MOUSE 设置被忽略。 VFP8 经常自动恢复隐藏的鼠标光标。 所以这个API函数可能没用。 适用于许多 VFP 控件（包括 Form）的 MousePointer 属性在设置为 13 时隐藏指针
  
***  

