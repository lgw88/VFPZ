[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何获得特殊文件夹的路径
_翻译：xinjie  2020.12.31_

## 开始之前：
这段代码展示了如何获取特殊文件夹的路径，如*我的文档、我的图片、开始菜单、启动、收藏夹、最近文件*等。  

参考：

* [浏览 Windows 已知文件夹（特殊文件夹)](sample_576.md)  
* [获取系统和 Windows 文件夹名称](sample_005.md)  
  
***  


## 代码：
```foxpro  
#DEFINE CSIDL_ALTSTARTUP 0x001d
#DEFINE CSIDL_APPDATA 0x001a
#DEFINE CSIDL_BITBUCKET 0x000a
#DEFINE CSIDL_COMMON_ALTSTARTUP 0x001e
#DEFINE CSIDL_COMMON_DESKTOPDIR 0x0019
#DEFINE CSIDL_COMMON_FAVORITES 0x001f
#DEFINE CSIDL_COMMON_PROGRAMS 0x0017
#DEFINE CSIDL_COMMON_STARTMENU 0x0016
#DEFINE CSIDL_COMMON_STARTUP 0x0018
#DEFINE CSIDL_CONTROLS 0x0003
#DEFINE CSIDL_COOKIES 0x0021
#DEFINE CSIDL_DESKTOP 0x0000
#DEFINE CSIDL_DESKTOPDIRECTORY 0x0010
#DEFINE CSIDL_DRIVES 0x0011
#DEFINE CSIDL_FAVORITES 0x0006
#DEFINE CSIDL_FONTS 0x0014
#DEFINE CSIDL_HISTORY 0x0022
#DEFINE CSIDL_INTERNET 0x0001
#DEFINE CSIDL_INTERNET_CACHE 0x0020
#DEFINE CSIDL_NETHOOD 0x0013
#DEFINE CSIDL_NETWORK 0x0012
#DEFINE CSIDL_PERSONAL 0x0005
#DEFINE CSIDL_PRINTERS 0x0004
#DEFINE CSIDL_PRINTHOOD 0x001b
#DEFINE CSIDL_PROGRAMS 0x0002
#DEFINE CSIDL_RECENT 0x0008
#DEFINE CSIDL_SENDTO 0x0009
#DEFINE CSIDL_STARTMENU 0x000b
#DEFINE CSIDL_STARTUP 0x0007
#DEFINE CSIDL_TEMPLATES 0x0015

DECLARE SHORT SHGetFolderPath IN shell32;
	INTEGER hwndOwner, INTEGER nFolder,;
	INTEGER hToken, INTEGER dwFlags,;
	STRING @pszPath

CREATE CURSOR csResult (;
	csidl I, path0 C(100), path1 C(100))

* 所有特殊的 CSIDL 都在 0xff 范围内
FOR nIndex=-1 TO 255
	= GetPath(nIndex)
ENDFOR

GO TOP
BROWSE NORMAL NOWAIT
* 主程序结束

PROCEDURE GetPath(nCSIDL)
#DEFINE MAX_PATH 260
#DEFINE SHGFP_TYPE_CURRENT 0 && returns current path
#DEFINE SHGFP_TYPE_DEFAULT 1 && returns default path
#DEFINE CSIDL_FLAG_PER_USER_INIT 0x0800
#DEFINE CSIDL_FLAG_NO_ALIAS 0x1000
#DEFINE CSIDL_FLAG_DONT_VERIFY 0x4000
#DEFINE CSIDL_FLAG_CREATE 0x8000
#DEFINE CSIDL_FLAG_MASK 0xff00

	LOCAL nFlag, nToken, cBuffer, nResult, cPath0, cPath1
	STORE "" To cPath0, cPath1

	nFlag = BitOr(nCSIDL, CSIDL_FLAG_PER_USER_INIT)
*	nToken = -1 && default user
	nToken = 0 && current user
	
	cBuffer = Repli(Chr(0), MAX_PATH)
	IF SHGetFolderPath(0, nFlag, nToken,;
		SHGFP_TYPE_CURRENT, @cBuffer) = 0
		cPath0 = STRTRAN(cBuffer, Chr(0), "")
	ENDIF

	cBuffer = Repli(Chr(0), MAX_PATH)
	IF SHGetFolderPath(0, nFlag, nToken,;
		SHGFP_TYPE_DEFAULT, @cBuffer) = 0
		cPath1 = STRTRAN(cBuffer, Chr(0), "")
	ENDIF

	IF Not EMPTY(cPath0 + cPath1)
		INSERT INTO csResult VALUES (;
			nCSIDL, cPath0, cPath1)
	ENDIF  
```  
***  


## 函数列表：
[SHGetFolderPath](../libraries/shell32/SHGetFolderPath.md)  

## 备注：
对于Windows 98、NT4版本，SHGetFolderPath是通过SHFolder.dll获得的，而不是通过Shell32.dll。  
  
为了向后兼容，SHFolder.dll继续被包含在内，尽管该功能现在是在Shell32.dll中实现的。 
  
CSIDL值提供了一种独特的、与系统无关的方式来识别应用程序经常使用的特殊文件夹，但这些文件夹在任何给定的系统中可能没有相同的名称或位置。例如，系统文件夹在一个系统中可能是 "C:\Windows"，而在另一个系统中可能是 "C:\Winnt"。 
  
从Windows Vista开始，这些值已经被KNOWNFOLDERID值取代。 
  
<a href="http://msdn.microsoft.com/en-us/library/bb762494(v=vs.85).aspx">CSIDL 列表</a>.  
  
***  

