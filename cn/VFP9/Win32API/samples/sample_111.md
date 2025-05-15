[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索 VFP 主窗口的信息
_翻译：xinjie 2021.06.24_

## 代码：
```foxpro  
#DEFINE GWL_WNDPROC -4
#DEFINE GWL_HINSTANCE -6
#DEFINE GWL_HWNDPARENT -8
#DEFINE GWL_STYLE -16
#DEFINE GWL_EXSTYLE -20
#DEFINE GWL_USERDATA -21
#DEFINE GWL_ID -12

DO declare

LOCAL hWindow
hWindow = GetActiveWindow()

? "Window procedure:", GetWindowLong (m.hWindow, GWL_WNDPROC)
? "Application instance:", GetWindowLong (m.hWindow, GWL_HINSTANCE)
? "Parent window:", GetWindowLong (m.hWindow, GWL_HWNDPARENT)
? "Window styles:", GetWindowLong (m.hWindow, GWL_STYLE)
? "Extended window styles:", GetWindowLong (m.hWindow, GWL_EXSTYLE)
? "User data associated:", GetWindowLong (m.hWindow, GWL_USERDATA)
? "Identifier of the window:", GetWindowLong (m.hWindow, GWL_ID)
? "Class name:", GetClsName(m.hWindow)
?

? "*** Application handle returned by:"
? "    GetModuleHandle:", GetModuleHandle(NULL)
? "    GetWindowLong:", GetWindowLong (m.hWindow, GWL_HINSTANCE)
?

* E_MAGIC
* GetModuleHandle实际上返回的是可执行文件被映射到内存中的地址
LOCAL hModule, cBuffer
hModule = GetModuleHandle(NULL)
cBuffer = REPLICATE(CHR(0),2)
= MemToStr(@cBuffer, hModule, LEN(cBuffer))

* 正如你所期望的那样，signature 是 "MZ"，即 Mark Zbikowski 的首字母，他是MS-DOS的最初设计者之一。
? "MS-DOS signature:", cBuffer

* 主程序结束

FUNCTION GetClsName(hWindow)
    LOCAL nBufsize, cBuffer
    cBuffer = Repli(Chr(0), 250)
    nBufsize = GetClassName(hWindow, @cBuffer, Len(cBuffer))
RETURN SUBSTR(cBuffer, 1, nBufsize)

PROCEDURE declare
	DECLARE INTEGER GetModuleHandle IN kernel32 STRING @lpModuleName
	DECLARE INTEGER GetActiveWindow IN user32

    DECLARE INTEGER GetClassName IN user32;
        INTEGER hWnd, STRING lpClassName, INTEGER nMaxCount

	DECLARE INTEGER GetWindowLong IN user32;
		INTEGER hWindow, INTEGER nIndex

	DECLARE RtlMoveMemory IN kernel32 As MemToStr;
		STRING @dst, INTEGER src, INTEGER nLength  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetClassName](../libraries/user32/GetClassName.md)  
[GetModuleHandle](../libraries/kernel32/GetModuleHandle.md)  
[GetWindowLong](../libraries/user32/GetWindowLong.md)  

## 备注：
推荐阅读：  
[深入研究Win32可移植可执行文件格式](http://bytepointer.com/resources/pietrek_in_depth_look_into_pe_format_pt1.htm) by Matt Pietrek  
  
***  

