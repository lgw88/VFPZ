[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索本地计算机和用户名
_翻译：xinjie  2021.01.04_

## 开始之前：
参考：

* [如何以其他用户的身份启动进程(NT/XP/2K))](sample_426.md)  
* [如何检索本地计算机的网络参数（包括主机名、域名、DNS服务器）](sample_348.md)  
  
***  


## Code:
```foxpro  
DO declare

DO GetNames
DO GetNameEx
DO GetNameObj
* 主程序结束

PROCEDURE GetNames
	LOCAL nSize, cBuffer

	nSize = 250
	cBuffer = Repli(Chr(0), nSize)
	IF GetComputerName (@cBuffer, @nSize) > 0
		cBuffer = STRTRAN(SUBSTR(cBuffer, 1, nSize), Chr(0),"")
		? "计算机:", cBuffer
	ENDIF

	nSize = 250
	cBuffer = Repli(Chr(0), nSize)
	IF GetUserName (@cBuffer, @nSize) > 0
		cBuffer = STRTRAN(ALLTRIM(SUBSTR (cBuffer, 1, nSize)), Chr(0),"")
		? "用户名:", cBuffer
		DO GetSid WITH cBuffer
	ENDIF

PROCEDURE GetNameEx
	LOCAL cBuffer, nBufsize, nIndex
	FOR nIndex=0 TO 7
		nBufsize = 250
		cBuffer = Repli(Chr(0), nBufsize)
		IF GetComputerNameEx(nIndex, @cBuffer, @nBufsize) <> 0
			? nIndex, LEFT(cBuffer, nBufsize)
		ENDIF
	ENDFOR

PROCEDURE GetNameObj
	LOCAL cBuffer, nBufsize, nIndex
	nBufsize = 250
	cBuffer = Repli(Chr(0), nBufsize)

	IF GetComputerObjectName(12, @cBuffer, @nBufsize) = 0
	* 1351 = ERROR_CANT_ACCESS_DOMAIN_INFO
		? "错误代码:", GetLastError()
	ELSE
		? nBufsize, "对象名: [" +;
			ALLTRIM(LEFT(cBuffer, nBufsize)) + "]"
	ENDIF

PROCEDURE GetSID(cAccount)
	LOCAL hSid, nSidsize, cDomain, nDomainsize, peUse

	nSidsize=128
	hSid=LocalAlloc(0, nSidsize)

	nDomainsize=250
	cDomain=REPLICATE(CHR(0), nDomainsize)
	
	peUse=0

	* 检索账户名称的安全标识符（SID）
	= LookupAccountName(NULL, m.cAccount,;
		hSid, @nSidSize, @cDomain, @nDomainSize, @peUse)

	* 将SID转换为字符串格式
	LOCAL nBuffer, nBufsize, cSid
	nBuffer=0
	= ConvertSidToStringSid(hSid, @nBuffer)

	nBufsize = LocalSize(nBuffer)
	cSid = REPLICATE(CHR(0), nBufsize)
	= MemToStr(@cSid, nBuffer, nBufsize)

	= LocalFree(nBuffer)
	= LocalFree(hSid)
	
	? "域名:", SUBSTR(cDomain, 1, AT(CHR(0),cDomain)-1)
	? "SID:", cSid

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER LocalFree IN kernel32 INTEGER hMem
	DECLARE LONG LocalSize IN kernel32 INTEGER hMem

	DECLARE INTEGER LocalAlloc IN kernel32;
		INTEGER uFlags, INTEGER uBytes

	DECLARE INTEGER GetComputerName IN kernel32;
		STRING @lpBuffer, INTEGER @nSize

	DECLARE INTEGER GetComputerNameEx IN kernel32;
		INTEGER NameType, STRING @lpBuffer, INTEGER @lpnSize

	DECLARE INTEGER GetUserName IN advapi32;
		STRING @lpBuffer, INTEGER @nSize

	DECLARE INTEGER GetComputerObjectName IN secur32;
		INTEGER NameFormat, STRING @lpNameBuffer, INTEGER @nSize

	DECLARE INTEGER LookupAccountName IN advapi32;
		STRING lpSystemName, STRING lpAccountName,;
		INTEGER Sid, INTEGER @cbSid,;
		STRING @RefDomainName, INTEGER @cchRefDomainName,;
		INTEGER @peUse

	DECLARE INTEGER ConvertSidToStringSid IN advapi32;
		INTEGER Sid, INTEGER @StringSid

	DECLARE RtlMoveMemory IN kernel32 As MemToStr;
		STRING @dst, INTEGER src, INTEGER nLength  
```  
***  


## 函数列表：
[ConvertSidToStringSid](../libraries/advapi32/ConvertSidToStringSid.md)  
[GetComputerName](../libraries/kernel32/GetComputerName.md)  
[GetComputerNameEx](../libraries/kernel32/GetComputerNameEx.md)  
[GetComputerObjectName](../libraries/secur32/GetComputerObjectName.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetUserName](../libraries/advapi32/GetUserName.md)  
[LocalAlloc](../libraries/kernel32/LocalAlloc.md)  
[LocalFree](../libraries/kernel32/LocalFree.md)  
[LocalSize](../libraries/kernel32/LocalSize.md)  
[LookupAccountName](../libraries/advapi32/LookupAccountName.md)  

## 备注
**SYS(0)**返回当前计算机和用户名。  
  
同样的信息可以用**GETENV()**函数获取，参数为 "COMPUTERNAME "和 "USERNAME"，或者用GetEnvironmentStrings函数 -- -- 一个[示例代码](sample_089.md)。 
  
***  

