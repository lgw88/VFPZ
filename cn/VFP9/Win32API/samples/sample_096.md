[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 当前系统信息
_翻译：xinjie  2021.02.06_

## 代码：
```foxpro  
DECLARE GetSystemInfo IN kernel32 STRING @lpSystemInfo
	
*| typedef struct _SYSTEM_INFO {
*|   union {
*|     DWORD  dwOemId;
*|     struct {
*|       WORD wProcessorArchitecture;
*|       WORD wReserved;
*|     };
*|   };
*|   DWORD  dwPageSize;
*|   LPVOID lpMinimumApplicationAddress;
*|   LPVOID lpMaximumApplicationAddress;
*|   DWORD_PTR dwActiveProcessorMask;
*|   DWORD dwNumberOfProcessors;
*|   DWORD dwProcessorType;
*|   DWORD dwAllocationGranularity;
*|   WORD wProcessorLevel;
*|   WORD wProcessorRevision;
*| } SYSTEM_INFO;

PRIVATE cSysInfo, nOffs
	
cSysInfo = Repli(Chr(0), 1024)
= GetSystemInfo(@cSysInfo)

CREATE CURSOR cs (varname C(24), prm N(12), descr C(100))
nOffs = 1

= AddParam("dwOemId",;
"用于与Windows NT 3.5和更早版本兼容", 4)

= AddParam("wProcessorArchitecture",;
"系统中的中央处理器的体系结构", 2)

= AddParam("wReserved", "保留供今后使用", 2)

= AddParam("dwPageSize",;
"页面的大小和页面保护和委托的颗粒", 4)

= AddParam("lpMinimumApplicationAddress",;
"指向应用程序和DLL可访问的最低内存地址的指针", 2)

= AddParam("lpMaximumApplicationAddress",;
"指向应用程序和DLLs可访问的最高内存地址的指针", 2)

= AddParam("dwActiveProcessorMask",;
"二进制0位是处理器0；31位是处理器31", 4)

= AddParam("dwNumberOfProcessors",;
"系统中的处理器的数目", 4)

= AddParam("dwProcessorType",;
"过时的成员", 4)

= AddParam("dwAllocationGranularity",;
"虚拟内存空间的粒度", 4)

= AddParam("wProcessorLevel",;
"对Windows NT / 2000或更高版本有效", 2)

= AddParam("wProcessorRevision",;
"对Windows NT / 2000或更高版本有效", 2)

SELECT cs
GO TOP
BROWSE NORMAL NOWAIT
* 主程序结束

PROCEDURE AddParam(cVarname, cDescr, nLen)
	IF nLen = 2
		nParam = buf2word(SUBSTR(cSysInfo, nOffs, 2))
		nOffs = nOffs + 2
	ELSE
		nParam = buf2dword(SUBSTR(cSysInfo, nOffs, 4))
		nOffs = nOffs + 4
	ENDIF
	INSERT INTO cs VALUES (cVarname, nParam, cDescr)

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 16777216

FUNCTION buf2word(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256  
```  
***  


## 函数列表：
[GetSystemInfo](../libraries/kernel32/GetSystemInfo.md)  
