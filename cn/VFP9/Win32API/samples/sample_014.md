[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 基于现有的文件名创建一个唯一的文件名
_翻译：xinjie  2021.01.02_

## 代码：
```foxpro  
#DEFINE CP_ACP         0
#DEFINE CP_OEMCP       1
#DEFINE MB_PRECOMPOSED 1
#DEFINE MAX_PATH       260
DO decl

LOCAL cPath, cFile, cUnique, cTpl

* 检索 FoxPro 可执行文件名
cPath = Repli(Chr(0),MAX_PATH)
= GetModuleFileName(0, @cPath, Len(cPath))
cPath = SUBSTR(cPath, 1, AT(Chr(0),cPath)-1)
cFile = SUBSTR(cPath, RAT("\",cPath)+1)
? "基本文件名:", cPath

cUnique = Repli(Chr(0),MAX_PATH*2)
= PathYetAnotherMakeUniqueName(@cUnique, a2u(cPath), Null, a2u(cFile))
cUnique = u2a(cUnique)
? "唯一文件名:", cUnique
?

cUnique = Repli(Chr(0),MAX_PATH*2)
cTpl = "MyFile.Dat"
cPath = GetLongTempPath()
? "基本文件名:", cPath + cTpl

= PathMakeUniqueName(@cUnique, MAX_PATH, a2u(cTpl), a2u(cTpl), a2u(cPath))
cUnique = u2a(cUnique)
? "唯一文件名:", cUnique
* 主程序结束

FUNCTION GetLongTempPath
	LOCAL cPath, cLongPath, nBufsize
	cPath = Repli(Chr(0),MAX_PATH)
	cLongPath = Repli(Chr(0),MAX_PATH*2)
	nBufsize = GetTempPath(Len(cPath), @cPath)
	cPath = LEFT(cPath, nBufsize)
	= GetLongPathName(cPath, @cLongPath, Len(cLongPath))
RETURN SUBSTR(cLongPath, 1,AT(Chr(0),cLongPath)-1)

FUNCTION u2a(cText)
* 将 Unicode 字符串转换为 ANSI 字符串。
	LOCAL lcBuffer, lnBufsize
	cText = SUBSTR(cText, 1, AT(Chr(0)+Chr(0),cText))

	* 首次调用定义所需的缓冲区大小
	lcBuffer = ""
	lnBufsize = WideCharToMultiByte(CP_ACP, 0,;
		cText, Len(cText), @lcBuffer, 0, Chr(0), 0)
		
	lcBuffer = Repli(Chr(0), lnBufsize)
	= WideCharToMultiByte(CP_ACP, 0,;
		cText, Len(cText), @lcBuffer, lnBufsize, Chr(0), 0)
RETURN SUBSTR(lcBuffer, 1, AT(Chr(0),lcBuffer)-1)

FUNCTION a2u(cText)
* 将 ANSI 字符串转换为 Unicode 字符串。
	LOCAL lcBuffer, lnBufsize
	
	* 首次调用定义所需的缓冲区大小
	lcBuffer = ""
	lnBufsize = MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,;
		cText, Len(cText), @lcBuffer, 0)

	lcBuffer = Repli(Chr(0), lnBufsize*2)  && in wide chars
	= MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED,;
		cText, Len(cText), @lcBuffer, lnBufsize)
RETURN lcBuffer

