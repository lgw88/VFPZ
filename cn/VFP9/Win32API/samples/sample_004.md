[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 当前应用程序的目录
_翻译：xinjie  2020.12.31_

## 代码：
```foxpro  
DECLARE INTEGER SetCurrentDirectory IN kernel32;
	STRING lpPathName

DECLARE INTEGER GetCurrentDirectory IN kernel32;
	INTEGER nBufferLength, STRING @lpBuffer

LOCAL cPath
cPath = SYS(5) + SYS(2003)

= SetCurrentDirectory("c:\Program Files")
? GetCD()
? GetCD1()

= SetCurrentDirectory(cPath)
? GetCD()
? GetCD1()
* 主程序结束

FUNCTION GetCD
RETURN SYS(5) + SYS(2003)

FUNCTION GetCD1
	LOCAL cBuffer, nBufsize
	cBuffer = SPACE(250)
	nBufsize = GetCurrentDirectory(Len(cBuffer), @cBuffer)
RETURN SUBSTR(cBuffer, 1, nBufsize)  
```  
***  


## 函数列表：
[GetCurrentDirectory](../libraries/kernel32/GetCurrentDirectory.md)  
[SetCurrentDirectory](../libraries/kernel32/SetCurrentDirectory.md)  
