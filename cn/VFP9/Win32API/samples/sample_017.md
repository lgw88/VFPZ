[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 GetLogicalDriveStrings
_翻译：xinjie  2021.01.02_

## 代码：
```foxpro  
DECLARE INTEGER GetDriveType IN kernel32 STRING nDrive

DECLARE INTEGER GetLogicalDriveStrings IN kernel32;
	INTEGER nBufferLength, STRING @lpBuffer

LOCAL cBuffer, nBufsize, cName, ch
cBuffer = REPLICATE(CHR(0), 250)
	
nBufsize = GetLogicalDriveStrings(Len(cBuffer), @cBuffer)
cBuffer = PADR(cBuffer, nBufsize)
? cBuffer
	
cName = ""
FOR nBufsize=1 TO Len(cBuffer)
	ch = SUBSTR(cBuffer, nBufsize,1)
	IF ch = Chr(0)
		? cName, GetDriveType(cName)
		cName = ""
	ELSE
		cName = cName + ch
	ENDIF
ENDFOR  
```  
***  


## 函数列表：
[GetDriveType](../libraries/kernel32/GetDriveType.md)  
[GetLogicalDriveStrings](../libraries/kernel32/GetLogicalDriveStrings.md)  
