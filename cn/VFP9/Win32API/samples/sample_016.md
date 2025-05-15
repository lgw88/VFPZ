[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 GetTempFileName
_翻译：xinjie  2021.01.02_

## 代码：
```foxpro  
#DEFINE MAX_PATH 260
DO decl

LOCAL cTmpPath, nIndex
cTmpPath = GetTmpPath()

FOR nIndex=0 TO 10
	? GetTmpName(cTmpPath, "vrl", .F.)
ENDFOR

FUNCTION GetTmpName(cTmpPath, cPrefix, lCreate)
	LOCAL nUnique, cTmpFile

	IF lCreate
	* GetTempFileName 会创建一个临时文件并关闭它
	* 根据当前的系统时间返回真正的唯一名称
		nUnique = 0
	ELSE
	* 文件名会被生成，尽管 GetTempFileName 并没有检查这个名字是否真的是唯一的
*		nUnique = SECONDS()  && easily creates duplicates
*		nUnique = GetTickCount() && easily creates duplicates
		nUnique = GetCounter()  && the most reliable option
	ENDIF

	cTmpFile = Repli(Chr(0), 250)
	= GetTempFileName(cTmpPath, cPrefix, nUnique, @cTmpFile)
	cTmpFile = STRTRAN(cTmpFile, Chr(0), "")
RETURN cTmpFile

FUNCTION GetTmpPath
	LOCAL cShort, cLong
	STORE Repli(Chr(0), 512) TO cShort, cLong
	= GetTempPath(Len(cShort), @cShort)
	cShort = STRTRAN(cShort, Chr(0), "")
	= GetLongPathName(cShort, @cLong, Len(cLong))
RETURN STRTRAN(cLong, Chr(0), "")

FUNCTION GetCounter
	LOCAL cBuffer
	cBuffer = Repli(Chr(0), 8)
	= QueryPerformanceCounter(@cBuffer)
RETURN LargeInt(cBuffer)

FUNCTION LargeInt(cBuffer)
#DEFINE MAX_DWORD 0x100000000
RETURN buf2dword(SUBSTR(cBuffer, 1,4)) +;
	buf2dword(SUBSTR(cBuffer, 5,4)) * MAX_DWORD

FUNCTION  buf2dword (lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 16777216

PROCEDURE decl
	DECLARE INTEGER GetTempFileName IN kernel32;
		STRING lpszPath, STRING lpPrefixString,;
		INTEGER wUnique, STRING @lpTempFileName

	DECLARE INTEGER GetTempPath IN kernel32;
		INTEGER nBufferLength, STRING @lpBuffer

	DECLARE INTEGER GetLongPathName IN kernel32;
	    STRING lpszShort, STRING @lpszLong, INTEGER cchBuffer

	DECLARE INTEGER GetTickCount IN kernel32

	DECLARE INTEGER QueryPerformanceCounter IN kernel32;
	    STRING @lpPerformanceCount  
```  
***  


## 函数列表：
[GetLongPathName](../libraries/kernel32/GetLongPathName.md)  
[GetTempFileName](../libraries/kernel32/GetTempFileName.md)  
[GetTempPath](../libraries/kernel32/GetTempPath.md)  
[GetTickCount](../libraries/kernel32/GetTickCount.md)  
[QueryPerformanceCounter](../libraries/kernel32/QueryPerformanceCounter.md)  
