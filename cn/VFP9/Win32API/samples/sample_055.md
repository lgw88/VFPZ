[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将长文件名转换为短格式，反之亦然
_翻译：xinjie  2021.01.07_

## 开始之前：
参考：

* [如何不使用文件名而使用别名访问文件（硬链接）](sample_018.md)  

  
***  


## 代码：
```foxpro  
DO declare

LOCAL lcSourceFile, lcShort, lcLong
lcSourceFile = "C:\Program Files\Microsoft Office\Office10\finderr.exe"
lcShort = GetShort(lcSourceFile)
lcLong = GetLong(lcShort)

? "源文件名:", lcSourceFile
? "获得的短名称:", lcShort
? "获得的长名称: ", lcLong

FUNCTION GetLong(lcName)
	LOCAL lcBuffer, lnResult
	lcBuffer = Repli(Chr(0), 512)
	lnResult = GetLongPathName(lcName, @lcBuffer, Len(lcBuffer))
* 2=ERROR_FILE_NOT_FOUND
RETURN IIF(lnResult=0, "error #" + LTRIM(STR(GetLastError())),;
	Left(lcBuffer, lnResult))

FUNCTION GetShort(lcName)
	LOCAL lcBuffer, lnResult
	lcBuffer = Repli(Chr(0), 512)
	lnResult = GetShortPathName(lcName, @lcBuffer, Len(lcBuffer))
RETURN IIF(lnResult=0, "error #" + LTRIM(STR(GetLastError())),;
	Left(lcBuffer, lnResult))

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER GetLongPathName IN kernel32;
		STRING lpszShortPath, STRING @lpszLongPath,;
		INTEGER cchBuffer

	DECLARE INTEGER GetShortPathName IN kernel32;
		STRING lpszLongPath, STRING @lpszShortPath,;
		INTEGER cchBuffer  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetLongPathName](../libraries/kernel32/GetLongPathName.md)  
[GetShortPathName](../libraries/kernel32/GetShortPathName.md)  

## 备注：
“短路径”是指8.3兼容路径/文件名。 源路径必须始终有效。 您不能转换不存在的文件的名称。
  
参考： [PathGetShortPath](../libraries/shell32/PathGetShortPath.md)
  
***  

