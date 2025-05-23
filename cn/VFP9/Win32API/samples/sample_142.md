[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 获取当前 Internet Explorer 浏览器版本和 UserAgent

_翻译：xinjie  2022.01.30_

## 代码：
```foxpro  
DO declare

? "*** MSIE Version installed"
? "Version:   ", GetHKLM("Version")
? "Build:     ", GetHKLM("Build")
? "User Agent:", GetUserAgent1()
* end of main

FUNCTION GetHKLM(lcValue)  && reading LOCAL_MACHINE registry data
#DEFINE HKEY_LOCAL_MACHINE 0x80000002
#DEFINE ccKey "Software\Microsoft\Internet Explorer"
#DEFINE ERROR_SUCCESS 0
#DEFINE KEY_READ 131097

	LOCAL hKey, lcData, lnSize, lcResult
	hKey = 0

	* opening specified key
	IF RegOpenKeyEx(HKEY_LOCAL_MACHINE,;
		ccKey, 0, KEY_READ, @hKey) <> ERROR_SUCCESS
		RETURN "#error#"
	ENDIF

	lnSize = 250
	lcData = SPACE(lnSize)

	* quering the value name
	IF RegQueryValueEx(hKey, lcValue,;
		0,0, @lcData, @lnSize) = ERROR_SUCCESS
		lcResult = Left(lcData, lnSize-1)
	ELSE
		lcResult = "#not found#"
	ENDIF

	= RegCloseKey (hKey)  && releasing key handle
RETURN lcResult

FUNCTION GetUserAgent  && returns the user agent string in use
#DEFINE URLMON_OPTION_USERAGENT 0x10000001
	LOCAL nBufsize, cBuffer
	nBufsize = 0
	cBuffer = Repli(Chr(0), 250)
	nResult = UrlMkGetSessionOption(URLMON_OPTION_USERAGENT,;
		@cBuffer, Len(cBuffer), @nBufsize, 0)
RETURN SUBSTR(cBuffer, 1, nBufsize)

FUNCTION GetUserAgent1  && returns the user agent string in use
	LOCAL nBufsize, cBuffer
	nBufsize = 250
	cBuffer = Repl(Chr(0), nBufsize)
	IF ObtainUserAgentString(0, @cBuffer, @nBufsize) = 0
		RETURN PADR(cBuffer, nBufsize)
	ENDIF
RETURN ""

PROCEDURE declare
	DECLARE INTEGER RegCloseKey IN advapi32 INTEGER hKey

	DECLARE INTEGER RegOpenKeyEx IN advapi32;
		INTEGER hKey, STRING lpSubKey, INTEGER ulOptions,;
		INTEGER samDesired, INTEGER @phkResult

	DECLARE INTEGER RegQueryValueEx IN advapi32;
		INTEGER hKey, STRING lpValueName, INTEGER lpReserved,;
		INTEGER @lpType, STRING @lpData, INTEGER @lpcbData

	DECLARE INTEGER UrlMkGetSessionOption IN urlmon;
		INTEGER dwOption, STRING @pBuffer, INTEGER dwBufferLen,;
		INTEGER @pdwBufferLen, INTEGER dwReserved

	DECLARE INTEGER ObtainUserAgentString IN urlmon;
		INTEGER dwOption, STRING @pcszUAOut, INTEGER @cbSize  
```  
***  


## 函数列表：
[ObtainUserAgentString](../libraries/urlmon/ObtainUserAgentString.md)  
[RegCloseKey](../libraries/advapi32/RegCloseKey.md)  
[RegOpenKeyEx](../libraries/advapi32/RegOpenKeyEx.md)  
[RegQueryValueEx](../libraries/advapi32/RegQueryValueEx.md)  
[UrlMkGetSessionOption](../libraries/urlmon/UrlMkGetSessionOption.md)  

## 备注：
UrlMkGetSessionOption 用于获取当前的用户代理字符串。 据我检查，此字符串未作为单个键值存储在 Windows 注册表中。
  
UrlMkSetSessionOption 可用于*更改*进程的用户代理字符串。
  
***  

