[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 从 INI 文件中读取数据

_翻译：xinjie  2022.01.30_

## 开始之前：
INI 文件是常规文本文件，但文件内的数据是结构化的。

参看：

* [写入 INI 文件](sample_137.md)  
* [从事件日志中读取条目](sample_524.md)  
* [将条目写入自定义事件日志](sample_564.md)  
  
***  


## 代码：
```foxpro  
* select valid INI file
LOCAL lcFileName
lcFileName = GetWindowsDir() + "\winsight.ini"

CREATE CURSOR csResult (section C(50), keyname C(50),;
	keyvalue C(200))

lcSections = GetSections(lcFileName)
= str2cursor(lcSections, "csSections")

SELECT csSections
SCAN ALL
	SELECT csSections
	lcKeys = GetKeys(lcFileName, csSections.strvalue)
	= str2cursor(lcKeys, "csKeys")
	
	SELECT csKeys
	SCAN ALL
		lcValue = GetKeyValue(lcFileName,;
			csSections.strvalue, csKeys.strvalue)
		INSERT INTO csResult VALUES (;
			csSections.strvalue, csKeys.strvalue, lcValue)
	ENDSCAN
ENDSCAN

SELECT csResult
GO TOP
BROWSE NORMAL NOWAIT

FUNCTION GetSections(lcFileName)
	DECLARE INTEGER GetPrivateProfileString IN kernel32;
		INTEGER lpAppName, INTEGER lpKeyName,;
		STRING lpDefault, STRING @lpReturnedString,;
		INTEGER nSize, STRING lpFileName

	LOCAL lnSize, lpReturnedString, lnResult
	lnSize = 0x1000
	lpReturnedString = Repli(Chr(0), lnSize)
	
	lnResult = GetPrivateProfileString(0,0,;
		"#empty#", @lpReturnedString, lnSize,;
		lcFileName)
RETURN Left(lpReturnedString, lnResult)

FUNCTION GetKeys(lcFileName, lcSection)
	DECLARE INTEGER GetPrivateProfileString IN kernel32;
		STRING lpAppName, INTEGER lpKeyName,;
		STRING lpDefault, STRING @lpReturnedString,;
		INTEGER nSize, STRING lpFileName

	LOCAL lnSize, lpReturnedString, lnResult
	lnSize = 0x4000
	lpReturnedString = Repli(Chr(0), lnSize)
	
	lnResult = GetPrivateProfileString(lcSection,0,;
		"#empty#", @lpReturnedString, lnSize,;
		lcFileName)
RETURN Left(lpReturnedString, lnResult)

FUNCTION GetKeyValue(lcFileName, lcSection, lcKey)
	DECLARE INTEGER GetPrivateProfileString IN kernel32;
		STRING lpAppName, STRING lpKeyName,;
		STRING lpDefault, STRING @lpReturnedString,;
		INTEGER nSize, STRING lpFileName

	LOCAL lnSize, lpReturnedString, lnResult
	lnSize = 0x4000
	lpReturnedString = Repli(Chr(0), lnSize)
	
	lnResult = GetPrivateProfileString(lcSection, lcKey,;
		"#empty#", @lpReturnedString, lnSize,;
		lcFileName)
RETURN Left(lpReturnedString, lnResult)

FUNCTION str2cursor(lcSource, lcCursor)
* split zero-delimited string to substrings
* and save them in the given cursor

	CREATE CURSOR (lcCursor) (strvalue C(250))
	LOCAL ii, ch, ss, lnResult
	ss = ""
	lnResult = 0
	FOR ii=1 TO Len(lcSource)
		ch = SUBSTR(lcSource, ii,1)
		IF ch = Chr(0)
			INSERT INTO (lcCursor) VALUES (ss)
			lnResult = lnResult + 1
			ss = ""
		ELSE
			ss = ss + ch
		ENDIF
	ENDFOR
RETURN lnResult

FUNCTION GetWindowsDir
	DECLARE INTEGER GetWindowsDirectory IN kernel32;
		STRING @lpBuffer, INTEGER nSize

	lpBuffer = SPACE(250)
	nSizeRet = GetWindowsDirectory(@lpBuffer, Len(lpBuffer))
RETURN SUBSTR(lpBuffer, 1, nSizeRet)  
```  
***  


## 函数列表：
[GetPrivateProfileString](../libraries/kernel32/GetPrivateProfileString.md)  
[GetWindowsDirectory](../libraries/kernel32/GetWindowsDirectory.md)  

## 备注：
目标文件应符合常规 INI 文件格式： 
```txt
[section]  
key=string  
...
```
  
在某些情况下，此函数应用于 Win.Ini 可以读取相应的注册表值而不是实际文件。
  
Msdn：对私有配置文件函数的调用可能会映射到注册表而不是指定的初始化文件。
  
将此函数应用于 Win.Ini 并检查结果。 
  
***  

