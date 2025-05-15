[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将主 VFP 窗口的任意矩形区域放置在剪贴板上
_翻译：xinjie  221.01.16_

## 代码：
```foxpro  
LPARAMETERS  lnLeft, lnTop, lnRight, lnBottom

#DEFINE CF_BITMAP  2	     && 剪贴板格式
#DEFINE SRCCOPY    13369376  && BitBlt raster operation code

DO decl

* 矩形区域的宽度和高度
lnWidth = lnRight - lnLeft + 1
lnHeight = lnBottom - lnTop + 1

* 检索主VFP窗口的HWND和DC
hwnd = GetActiveWindow()

* 尝试两个HDC值，并注意其差异
hdc = GetWindowDC (hwnd)  && 整个窗口的设备上下文
*hdc = GetDC (hwnd)	&& 客户端区域的设备上下文
	
* 创建兼容的DC和BITMAP
hVdc = CreateCompatibleDC (hdc)
hBitmap = CreateCompatibleBitmap (hdc, lnWidth, lnHeight)
= SelectObject (hVdc, hBitmap)  && 将创建的BITMAP插入到hVdc中

* 将一个矩形区域从HDC复制到hVdc。
= BitBlt (hVdc, 0,0, lnWidth,lnHeight,;
	hdc, lnLeft,lnTop, SRCCOPY)

* 打开剪贴板并将位图数据放入其中
= OpenClipboard (hwnd)
= EmptyClipboard()

lnResult = SetClipboardData (CF_BITMAP, hBitmap)
IF lnResult <> 0
* 完成! 查看剪贴板查看器中出现的片段。
ELSE
	? "错误代码: "
	?? GetLastError()
ENDIF

* 关闭剪贴板 -- 重要
= CloseClipboard()

* 释放系统资源
= DeleteObject (hBitmap)
= DeleteDC (hVdc)
= ReleaseDC (hwnd, hdc)
* 主程序结束

PROCEDURE  decl   && not a few
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER GetActiveWindow IN user32
	DECLARE INTEGER GetWindowDC IN user32 INTEGER hwnd
	DECLARE INTEGER GetDC IN user32 INTEGER hwnd
	DECLARE INTEGER CreateCompatibleDC IN gdi32 INTEGER hdc
	DECLARE INTEGER DeleteDC IN gdi32 INTEGER hdc
	DECLARE INTEGER ReleaseDC IN user32 INTEGER hwnd, INTEGER hdc
	DECLARE INTEGER SelectObject IN gdi32 INTEGER hdc, INTEGER hObject
	DECLARE INTEGER DeleteObject IN gdi32 INTEGER hObject
	DECLARE INTEGER OpenClipboard IN user32 INTEGER hwnd
	DECLARE INTEGER CloseClipboard IN user32
	DECLARE INTEGER EmptyClipboard  IN user32
	DECLARE INTEGER SetClipboardData IN user32 INTEGER wFmt, INTEGER hMem

	DECLARE INTEGER CreateCompatibleBitmap IN gdi32;
		INTEGER hdc, INTEGER nWidth, INTEGER nHeight

	DECLARE INTEGER BitBlt IN gdi32;
		INTEGER hDestDC, INTEGER x, INTEGER y,;
		INTEGER nWidth, INTEGER nHeight, INTEGER hSrcDC,;
		INTEGER xSrc, INTEGER ySrc, INTEGER dwRop  
```  
***  


## 函数列表：
[BitBlt](../libraries/gdi32/BitBlt.md)  
[CloseClipboard](../libraries/user32/CloseClipboard.md)  
[CreateCompatibleBitmap](../libraries/gdi32/CreateCompatibleBitmap.md)  
[CreateCompatibleDC](../libraries/gdi32/CreateCompatibleDC.md)  
[DeleteDC](../libraries/gdi32/DeleteDC.md)  
[DeleteObject](../libraries/gdi32/DeleteObject.md)  
[EmptyClipboard](../libraries/user32/EmptyClipboard.md)  
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GetDC](../libraries/user32/GetDC.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetWindowDC](../libraries/user32/GetWindowDC.md)  
[OpenClipboard](../libraries/user32/OpenClipboard.md)  
[ReleaseDC](../libraries/user32/ReleaseDC.md)  
[SelectObject](../libraries/gdi32/SelectObject.md)  
[SetClipboardData](../libraries/user32/SetClipboardData.md)  

## 备注：
将四个屏幕坐标传递到此过程，这些坐标相对于主 VFP 窗口的左上角或其工作区 - 具体取决于使用的 HDC。 
  
***  

