[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将路径转换为原始大小写
_翻译：xinjie  2021.02.09_

## 开始之前：
![](../images/getfullpath.png)  

  
***  


## 代码：
```foxpro  
CLEAR
CLEAR ALL

#DEFINE MAX_PATH 260
DO declare

? GetFullPath( _vfp.ServerName )
? FULLPATH( _vfp.ServerName )

? GetFullPath( "%systemroot\system32%" )
* 主程序结束

FUNCTION GetFullPath( cPath As String ) As String
	LOCAL cFileSpec
	
	cPath = GetQualifiedPath(ExpandEnvStrings( m.cPath ))

	IF PathIsDirectory(m.cPath) = 0
		cFileSpec = JUSTFNAME(m.cPath)
		cPath = SUBSTR(m.cPath, 1, RAT(m.cFileSpec, m.cPath)-1)
	ELSE
		cFileSpec = ""
	ENDIF
	
	cPath = GetQualifiedPath(GetLongPath(GetShortPath( m.cPath )) +;
		IIF(EMPTY(cFileSpec), "", "\" + cFileSpec) )
RETURN m.cPath

FUNCTION ExpandEnvStrings( cStr As String ) As String
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), MAX_PATH)
	ExpandEnvironmentStrings( m.cStr, @cBuffer, MAX_PATH)
RETURN STRTRAN(m.cBuffer, CHR(0), "")

FUNCTION GetQualifiedPath( cStr As String ) As String
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), MAX_PATH)
	PathSearchAndQualify( m.cStr, @cBuffer, MAX_PATH)
RETURN STRTRAN(m.cBuffer, CHR(0), "")

FUNCTION GetShortPath( cStr As String ) As String
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), MAX_PATH)
	GetShortPathName( m.cStr, @cBuffer, MAX_PATH)
RETURN STRTRAN(m.cBuffer, CHR(0), "")

FUNCTION GetLongPath( cStr As String ) As String
	LOCAL cBuffer
	cBuffer = REPLICATE(CHR(0), MAX_PATH)
	GetLongPathName( m.cStr, @cBuffer, MAX_PATH)
RETURN STRTRAN(m.cBuffer, CHR(0), "")

PROCEDURE declare
	DECLARE INTEGER ExpandEnvironmentStrings IN kernel32;
		STRING lpSrc, STRING @lpDst, INTEGER nSize

	DECLARE INTEGER PathSearchAndQualify IN Shlwapi;
		STRING pcszPath, STRING @pszFullyQualifiedPath,;
		INTEGER cchFullyQualifiedPath

	DECLARE INTEGER GetShortPathName IN Kernel32;
		STRING lpszLongPath, STRING @lpszShortPath,;
		INTEGER cchBuffer

	DECLARE INTEGER GetLongPathName IN Kernel32;
		STRING lpszShortPath, STRING @lpszLongPath,;
		INTEGER cchBuffer

	DECLARE INTEGER PathIsDirectory IN Shlwapi;
		STRING pszPath  
```  
***  


## 函数列表：
[ExpandEnvironmentStrings](../libraries/kernel32/ExpandEnvironmentStrings.md)  
[GetLongPathName](../libraries/kernel32/GetLongPathName.md)  
[GetShortPathName](../libraries/kernel32/GetShortPathName.md)  
[PathIsDirectory](../libraries/shlwapi/PathIsDirectory.md)  
[PathSearchAndQualify](../libraries/shlwapi/PathSearchAndQualify.md)  

## 备注：
所介绍的过程还扩展了源路径中的环境字符串（如*%SystemRoot%，%Public%，%Temp%*等）。 
  
在某些操作系统中，文件名是区分大小写的。例如，在与Apache FTP服务器交换文件时，应该考虑到这一点。 
  
***  

