[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 从可执行文件加载字符串资源
_翻译：xinjie  2021.01.01_

## 代码：
```foxpro  
DO declare

LOCAL lcSysDir, hModule, lFreeModule, lcBuffer, lnBufsize, ii, loPChar
lcSysDir = GetSysDir()
lFreeModule = .F.
hModule = GetHandle(lcSysDir + "\wininet.dll", @lFreeModule)

* 也可以尝试：
* lcSysDir + "\mshtml.dll"
* lcSysDir + "\vbrun500.dll"
* lcSysDir + "\mapi32.dll"
* lcSysDir + "\comdlg32.dll"
* lcSysDir + "\syssetup.dll"
* lcSysDir + "\userenv.dll"

IF hModule <> 0
	CREATE CURSOR cs (id N(6), txt C(250))
	loPChar = CreateObject("PChar", Repli(Chr(0), 256))

	FOR ii=0 TO 4096
		lnBufsize = LoadString(hModule, ii, loPChar.GetAddr(), 1024)
		IF lnBufsize <> 0
			INSERT INTO cs VALUES (ii, SUBSTR(loPChar.GetValue(), 1, lnBufsize))
		ENDIF
	ENDFOR

	IF lFreeModule
		= FreeLibrary(hModule)
	ENDIF
	
	GO TOP
	BROWSE NORMAL NOWAIT
ENDIF

FUNCTION GetHandle(lcModuleName, lRelease)
	LOCAL hModule
	hModule = GetModuleHandle(lcModuleName)
	IF hModule <> 0
		lRelease = .F.
	ELSE
		lRelease = .T.
		hModule = LoadLibrary(lcModuleName)
	ENDIF
RETURN hModule

FUNCTION GetSysDir
	DECLARE INTEGER GetSystemDirectory IN kernel32;
		STRING @lpBuffer, INTEGER nSize

	LOCAL lcBuffer, lnResult
	lcBuffer = SPACE(250)
	lnResult = GetSystemDirectory(@lcBuffer, Len(lcBuffer))
RETURN Left(lcBuffer, lnResult)

IF nSizeRet <> 0
	lpBuffer = SUBSTR(lpBuffer, 1, nSizeRet)
	? lpBuffer
ENDIF

PROCEDURE declare
	DECLARE INTEGER LoadString IN user32;
		INTEGER hInstance, INTEGER uID,;
		INTEGER lpBuffer, INTEGER nBufferMax

	DECLARE INTEGER LoadLibrary IN kernel32 STRING lpLibFileName
	DECLARE INTEGER FreeLibrary IN kernel32 INTEGER hLibModule
	DECLARE INTEGER GetModuleHandle IN kernel32 STRING lpModuleName

DEFINE CLASS PChar As Custom
	PROTECTED hMem

PROCEDURE Init(lcString)
	THIS.hMem = 0
	THIS.SetValue(lcString)

PROCEDURE Destroy
	THIS.ReleaseString

FUNCTION getAddr  && 返回一个指向字符串的指针
RETURN THIS.hMem

FUNCTION GetValue && 返回字符串值
	LOCAL lnSize, lcBuffer
	lnSize = THIS.GetAllocSize()
	lcBuffer = SPACE(lnSize)

	IF THIS.hMem <> 0
		DECLARE RtlMoveMemory IN kernel32 As Heap2Str;
			STRING @, INTEGER, INTEGER
		= Heap2Str(@lcBuffer, THIS.hMem, lnSize)
	ENDIF
RETURN lcBuffer

FUNCTION GetAllocSize  && 返回分配的内存大小（字符串长度）
	DECLARE INTEGER GlobalSize IN kernel32 INTEGER hMem
RETURN Iif(THIS.hMem=0, 0, GlobalSize(THIS.hMem))

PROCEDURE SetValue(lcString) && 分配新的字符串值
#DEFINE GMEM_FIXED   0
	THIS.ReleaseString

	DECLARE INTEGER GlobalAlloc IN kernel32 INTEGER, INTEGER
	DECLARE RtlMoveMemory IN kernel32 As Str2Heap;
		INTEGER, STRING @, INTEGER

	LOCAL lnSize
	lcString = lcString + Chr(0)
	lnSize = Len(lcString)
	THIS.hMem = GlobalAlloc(GMEM_FIXED, lnSize)
	IF THIS.hMem <> 0
		= Str2Heap(THIS.hMem, @lcString, lnSize)
	ENDIF

PROCEDURE ReleaseString  && releases allocated memory
	IF THIS.hMem <> 0
		DECLARE INTEGER GlobalFree IN kernel32 INTEGER
		= GlobalFree(THIS.hMem)
		THIS.hMem = 0
	ENDIF
ENDDEFINE  
```  
***  


## 函数列表：
[FreeLibrary](../libraries/kernel32/FreeLibrary.md)  
[GetModuleHandle](../libraries/kernel32/GetModuleHandle.md)  
[GetSystemDirectory](../libraries/kernel32/GetSystemDirectory.md)  
[GlobalAlloc](../libraries/kernel32/GlobalAlloc.md)  
[GlobalFree](../libraries/kernel32/GlobalFree.md)  
[GlobalSize](../libraries/kernel32/GlobalSize.md)  
[LoadLibrary](../libraries/kernel32/LoadLibrary.md)  
[LoadString](../libraries/user32/LoadString.md)  
