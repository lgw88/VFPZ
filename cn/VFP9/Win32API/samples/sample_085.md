[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索 DLL 的句柄和其中的导出函数的地址
_翻译:xinjie  2021.01.18_

## 代码：
```foxpro  
DO declare

LOCAL lcModule, lcProc, lcSysDir, hModule, lnAddr
lcModule = "kernel32.dll"
lcProc = "GetTickCount"
lcSysDir = GetSysDir()

hModule = GetModuleHandle(lcSysDir + CHR(92) + lcModule)
lnAddr = GetProcAddress(hModule, lcProc)

IF lnAddr = 0
	? "错误代码:", GetLastError()
ELSE
	? "Address of " + lcProc + " in " + lcModule + ":",;
		"0x"+int2hex(lnAddr)
ENDIF

FUNCTION GetSysDir
	LOCAL lpBuffer, lnSize
	lpBuffer = SPACE (250)
	lnSize = GetSystemDirectory (@lpBuffer, Len(lpBuffer))
RETURN LEFT(lpBuffer, lnSize)

FUNCTION int2hex(num)
	LOCAL lnResult, lcResult
	lcResult = SPACE(20)
	lnResult = wnsprintf(@lcResult, 20, "%x", num)
RETURN LEFT(lcResult, lnResult)

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER GetModuleHandle IN kernel32 STRING lpModule

	DECLARE INTEGER GetProcAddress IN kernel32;
		INTEGER hModule, STRING lpPrcName
	
	DECLARE INTEGER GetSystemDirectory IN kernel32;
		STRING @lpBuffer, INTEGER nSize

	DECLARE INTEGER wnsprintf IN Shlwapi;
		STRING @lpOut, INTEGER cchLimitIn,;
		STRING pszFmt, INTEGER  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetModuleHandle](../libraries/kernel32/GetModuleHandle.md)  
[GetProcAddress](../libraries/kernel32/GetProcAddress.md)  
[GetSystemDirectory](../libraries/kernel32/GetSystemDirectory.md)  
[wnsprintf](../libraries/shlwapi/wnsprintf.md)  
