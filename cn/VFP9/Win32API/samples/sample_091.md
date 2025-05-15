[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何使用 Bitmap API 函数将表单的图像复制到剪贴板上
_翻译：xinjie  2021.01.20_

## 开始之前：
此示例代码显示了如何以CF_BITMAP格式将活动表单的图像复制到剪贴板。

有一个类似的例子，使用 Bitmap API 函数复制 CF_ENHMETAFILE 格式的数据：  
[使用增强的 Metafile API 函数将活动表单的图片复制到剪贴板](sample_404.md)  

查看其它 Bitmap API 示例：  
* [将剪贴板的内容存储到一个位图文件](sample_189.md)  
* [将表单的屏幕截图存储到一个位图文件](sample_187.md)  
* [如何打印 FoxPro 表单](sample_158.md)  
* [使用 LoadImage 函数加载位图文件并将其显示在 VFP 主窗口上](sample_210.md)  
* [如何打印位图文件](sample_211.md)  
  
***  


## 代码：
```foxpro  
#DEFINE CF_BITMAP 2	&& clipboard format
#DEFINE SRCCOPY 0xCC0020  && BitBlt raster operation code
DO declare

PRIVATE hWindow, lnLeft, lnTop, lnRight, lnBottom, lnWidth, lnHeight
*hWindow = GetActiveWindow()  && active window
hWindow = GetFocus()  && a window with keyboard focus
*hWindow = Application.hWnd
*hWindow = _screen.HWnd

* 检索窗口的几何参数 
STORE 0 TO lnLeft, lnTop, lnRight, lnBottom, lnWidth, lnHeight
= GetRect(@lnLeft, @lnTop, @lnRight, @lnBottom, @lnWidth, @lnHeight)

* 和它的设备上下文
hdc = GetWindowDC(m.hWindow)

* 创建兼容的 DC 和 BITMAP
hVdc = CreateCompatibleDC(hdc)
hBitmap = CreateCompatibleBitmap(hdc, lnWidth, lnHeight)
= SelectObject(hVdc, hBitmap)  && 选择创建的BITMAP到hVdc

* 将一个矩形区域从HDC复制到hVdc
= BitBlt(hVdc, 0,0, lnWidth,lnHeight, hdc, 0,0, SRCCOPY)

* 打开剪贴板并将位图数据放置在它上面
= OpenClipboard(m.hWindow)
= EmptyClipboard()
= SetClipboardData(CF_BITMAP, m.hBitmap)
= CloseClipboard()  && clipboard not closed may affect other apps

* 释放 GDI 对象
= DeleteObject(m.hBitmap)
= DeleteDC(m.hVdc)
= ReleaseDC(m.hWindow, m.hdc)
* 主程序结束

PROCEDURE declare
	DECLARE INTEGER GetWindowRect IN user32 INTEGER hWindow, STRING @lpRect
	DECLARE INTEGER SelectObject IN gdi32 INTEGER hdc, INTEGER hObject
	DECLARE INTEGER ReleaseDC IN user32 INTEGER hWindow, INTEGER hdc
	DECLARE INTEGER CreateCompatibleDC IN gdi32 INTEGER hdc
	DECLARE INTEGER DeleteObject IN gdi32 INTEGER hObject
	DECLARE INTEGER DeleteDC IN gdi32 INTEGER hdc
	DECLARE INTEGER CloseClipboard IN user32
	DECLARE INTEGER GetFocus IN user32
	DECLARE INTEGER GetActiveWindow IN user32
	DECLARE INTEGER EmptyClipboard  IN user32
	DECLARE INTEGER GetWindowDC IN user32 INTEGER hWindow
	DECLARE INTEGER OpenClipboard IN user32 INTEGER hWindow
	DECLARE INTEGER SetClipboardData IN user32 INTEGER wFormat, INTEGER hMem

	DECLARE INTEGER CreateCompatibleBitmap IN gdi32;
		INTEGER hdc, INTEGER nWidth, INTEGER nHeight

	DECLARE INTEGER BitBlt IN gdi32;
		INTEGER hDestDC, INTEGER x, INTEGER y,;
		INTEGER nWidth, INTEGER nHeight, INTEGER hSrcDC,;
		INTEGER xSrc, INTEGER ySrc, INTEGER dwRop

PROCEDURE GetRect(lnLeft, lnTop, lnRight, lnBottom, lnWidth, lnHeight)
    LOCAL lpRect
    lpRect = REPLICATE(CHR(0), 16)
    = GetWindowRect(m.hWindow, @lpRect)

    lnLeft = buf2dword(SUBSTR(lpRect,  1,4))
    lnTop = buf2dword(SUBSTR(lpRect,  5,4))
    lnRight = buf2dword(SUBSTR(lpRect,  9,4))
    lnBottom = buf2dword(SUBSTR(lpRect, 13,4))
	lnWidth = lnRight - lnLeft
	lnHeight = lnBottom - lnTop

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 0x100 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 0x10000 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 0x1000000  
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
[GetFocus](../libraries/user32/GetFocus.md)  
[GetWindowDC](../libraries/user32/GetWindowDC.md)  
[GetWindowRect](../libraries/user32/GetWindowRect.md)  
[OpenClipboard](../libraries/user32/OpenClipboard.md)  
[ReleaseDC](../libraries/user32/ReleaseDC.md)  
[SelectObject](../libraries/gdi32/SelectObject.md)  
[SetClipboardData](../libraries/user32/SetClipboardData.md)  

## 备注：
GetFocus函数检索拥有键盘焦点的窗口的句柄。 
  
如果你从一个窗体中调用这个过程，你将在剪贴板上得到这个窗体的图像。 
  
在没有其他窗体运行的情况下，从VFP主窗口调用这个过程，可以将整个主窗口本身复制到剪贴板上。 
  
* * *  
微软帮助和支持页面上发表的一篇文章 [How To Copy the Screen or Active Window to the Clipboard from Visual Basic](https://support.microsoft.com/en-us/help/240653/how-to-copy-the-screen-or-active-window-to-the-clipboard-from-visual-b) 描述了一种不同的方法--通过虚拟按下(通过keybd_event调用)PrtScr键将整个屏幕的图片发送到剪贴板。 
  
***  

