[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索鼠标光标所在的矩形区域
_翻译：xinjie  2021.01.15_

## 代码：
```foxpro  
DECLARE INTEGER GetClipCursor IN user32 STRING @lpRect

* 指向一个RECT结构（四个DWORD--16字节）
lpRect = REPLICATE(Chr(0), 16)
= GetClipCursor(@lpRect)
	
? "左:  ", buf2dword(SUBSTR(lpRect, 1,4))
? "上:  ", buf2dword(SUBSTR(lpRect, 5,4))
? "右:  ", buf2dword(SUBSTR(lpRect, 9,4))
? "下:  ", buf2dword(SUBSTR(lpRect, 13,4))

? "SYSMETRIC():", SYSMETRIC(1), "x", SYSMETRIC(2)

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(cBuffer, 2,1)), 8) +;
	BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[GetClipCursor](../libraries/user32/GetClipCursor.md)  

## 备注：
在大多数情况下，返回的坐标是当前的显示分辨率。 
  
使用此函数可以在更改前保存原始值。 
  
***  

