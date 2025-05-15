[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 时间以毫秒为单位，用字符串表示（如1小时24分36秒）
_翻译：xinjie  2021.02.09_

## 代码：
```foxpro  
DECLARE INTEGER StrFromTimeInterval IN Shlwapi;
	STRING @ pszOut,;
   	INTEGER  cchMax,;
   	INTEGER  dwTimeMS,;
	INTEGER  digits

DECLARE INTEGER GetTickCount IN kernel32

lnFromStart = GetTickCount()
? "自系统启动以来的时间:", lnFromStart

pszOut = SPACE(50)
FOR lnMax=1 TO 10
	lnLen = StrFromTimeInterval (@pszOut, Len(pszOut), lnFromStart, lnMax)
	? LEFT (pszOut, lnLen)
ENDFOR  
```  
***  


## 函数列表：
[GetTickCount](../libraries/kernel32/GetTickCount.md)  
[StrFromTimeInterval](../libraries/shlwapi/StrFromTimeInterval.md)  
