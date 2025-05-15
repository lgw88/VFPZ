[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 扩展的操作系统版本信息
_翻译:_

## 开始之前：
参考：

* [操作系统的版本和修订版](sample_022.md)  
  
***  


## 代码：
```foxpro  
*| typedef struct _OSVERSIONINFO{
*|   DWORD dwOSVersionInfoSize;  0 | 4
*|   DWORD dwMajorVersion;       4 | 4
*|   DWORD dwMinorVersion;       8 | 4
*|   DWORD dwBuildNumber;       12 | 4
*|   DWORD dwPlatformId;        16 | 4
*|   TCHAR szCSDVersion[ 128 ]; 20 | 128 = 148 bytes
*| } OSVERSIONINFO;

*| typedef struct _OSVERSIONINFOEX {
*|   DWORD dwOSVersionInfoSize;  0 | 4
*|   DWORD dwMajorVersion;       4 | 4
*|   DWORD dwMinorVersion;       8 | 4
*|   DWORD dwBuildNumber;       12 | 4
*|   DWORD dwPlatformId;        16 | 4
*|   TCHAR szCSDVersion[ 128 ]; 20 | 128
*|   WORD wServicePackMajor;   148 | 2
*|   WORD wServicePackMinor;   150 | 2
*|   WORD wSuiteMask;          152 | 2
*|   BYTE wProductType;        154 | 1
*|   BYTE wReserved;           155 | 1 = 156 bytes
*| } OSVERSIONINFOEX, *POSVERSIONINFOEX, *LPOSVERSIONINFOEX;

DECLARE INTEGER GetVersionEx IN kernel32;
    STRING @ lpVersionInformation

* 设置 dwOSVersionInfoSize 为 148(OSVERSIONINFO) 或 156(OSVERSIONINFOEX) 字节
lcInfo = Chr(156) + REPLI (Chr(0), 300)  && some loose space

nResult = GetVersionEx (@lcInfo)

? "主要版本: ", buf2dword(SUBSTR(lcInfo,  5,4))
? "次要版本: ", buf2dword(SUBSTR(lcInfo,  9,4))
? "内部版本号:  ", buf2dword(SUBSTR(lcInfo, 13,4))
? "额外信息:  ", "["+STRTRAN(SUBSTR(lcInfo, 21,128), Chr(0),"")+"]"
?
? "主要 Service Pack: ", buf2word(SUBSTR(lcInfo,  149,2))
? "次要 Service Pack: ", buf2word(SUBSTR(lcInfo,  151,2))
? "Suite 标志位:    ", buf2word(SUBSTR(lcInfo,  153,2))
? "产品类型:       ", Asc(SUBSTR(lcInfo,155,1))
? "保留位:      ", Asc(SUBSTR(lcInfo,156,1))

FUNCTION  buf2dword (lcBuffer)
RETURN;
	Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 16777216
ENDFUNC

FUNCTION  buf2word (lcBuffer)
RETURN;
	Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256
ENDFUNC  
```  
***  


## 函数列表：
[GetVersionEx](../libraries/kernel32/GetVersionEx.md)  
