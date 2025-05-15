[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 可用剪贴板格式的数量

## 代码：
```foxpro  
#DEFINE CF_TEXT              1
#DEFINE CF_BITMAP            2
#DEFINE CF_METAFILEPICT      3
#DEFINE CF_SYLK              4
#DEFINE CF_TIFF              6
#DEFINE CF_DIF               5
#DEFINE CF_OEMTEXT           7
#DEFINE CF_DIB               8
#DEFINE CF_PALETTE           9
#DEFINE CF_PENDATA          10
#DEFINE CF_RIFF             11
#DEFINE CF_WAVE             12
#DEFINE CF_UNICODETEXT      13
#DEFINE CF_ENHMETAFILE      14
#DEFINE CF_HDROP            15
#DEFINE CF_LOCALE           16
#DEFINE CF_DIBV5            17
DO declare

? "当前剪贴板上的格式数量: " +;
	LTRIM(STR(CountClipboardFormats()))

cBuffer = Chr(CF_TEXT) + Repli(Chr(0),3) +;
	Chr(CF_OEMTEXT) + Repli(Chr(0),3) +;
	Chr(CF_UNICODETEXT) + Repli(Chr(0),3)

? "第一个可用的文本格式，ID: " +;
	LTRIM(STR(GetPriorityClipboardFormat(@cBuffer, 3)))

PROCEDURE declare
	DECLARE INTEGER CountClipboardFormats IN user32

	DECLARE INTEGER GetPriorityClipboardFormat IN user32;
		STRING @paFormatPriorityList, INTEGER cFormats  
```  
***  


## 函数列表：
[CountClipboardFormats](../libraries/user32/CountClipboardFormats.md)  
[GetPriorityClipboardFormat](../libraries/user32/GetPriorityClipboardFormat.md)  
