[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 LoadLibrary
_翻译：xinjie  2201.01.01_

## 开始之前：
参考：

* [从可执行文件加载字符串资源](sample_213.md)  
* [将 EXE 或 DLL 图标资源导出为.ICO文件](sample_502.md)  
  
***  


## 代码：
```foxpro  
DO declare

lpLibFileName = GetSystemDir() + "\mapi32.dll"
hLibModule = LoadLibrary(lpLibFileName)

IF hLibModule <> 0
	? "库句柄：", hLibModule
	= FreeLibrary(hLibModule)
ELSE
	* 1157 = ERROR_DLL_NOT_FOUND
	? "返回的错误代码：", GetLastError()
ENDIF
* 主程序结束

FUNCTION GetSystemDir
	LOCAL lpBuffer, nSizeRet
	lpBuffer = SPACE(250)
	nSizeRet = GetSystemDirectory(@lpBuffer, Len(lpBuffer))
RETURN Iif(nSizeRet<>0, Left(lpBuffer, nSizeRet), "")

PROCEDURE declare
	DECLARE INTEGER LoadLibrary IN kernel32;
		STRING lpLibFileName

	DECLARE INTEGER FreeLibrary IN kernel32;
		INTEGER hLibModule

	DECLARE INTEGER GetSystemDirectory IN kernel32;
		STRING @ lpBuffer, INTEGER nSize

	DECLARE INTEGER GetLastError IN kernel32  
```  
***  


## 函数列表：
[FreeLibrary](../libraries/kernel32/FreeLibrary.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetSystemDirectory](../libraries/kernel32/GetSystemDirectory.md)  
[LoadLibrary](../libraries/kernel32/LoadLibrary.md)  
