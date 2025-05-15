[<img src="../images/home.png"> 主页 ](https://github.com/vfp9/Win32API)  

# 创建一个文件夹

_翻译：xinjie  2020.12.31_

## 代码：
```foxpro  
DO declare

*!*	DO cd1 WITH "c:\temp1"
*!*	DO cd2 WITH "c:\temp2"
DO cd3 WITH "c:\temp3", GETENV("SystemRoot")

* 主程序结束

PROCEDURE cd1(cNewFolder)
* 使用默认安全描述符创建新目录
	IF CreateDirectory(cNewFolder, NULL) = 0
		*   3 = ERROR_PATH_NOT_FOUND
		*   5 = ERROR_ACCESS_DENIED
		* 183 = ERROR_ALREADY_EXISTS
		? "CreateDirectory 失败：", GetLastError()
	ENDIF

PROCEDURE cd2(cNewFolder)
* Shell 版本
	nResult = SHCreateDirectory(0,;
		STRCONV(m.cNewFolder+CHR(0),5))

	IF nResult <> 0
		? "SHCreateDirectory 失败：", nResult
	ENDIF

PROCEDURE cd3(cNewFolder, cTemplateFolder)  && 仅用于 NTFS
* 使用模板目录的安全描述符创建新目录

#DEFINE DACL_SECURITY_INFORMATION 0x0004
#DEFINE SECURITY_ATTRIBUTES_SIZE 12

*!*	typedef struct _SECURITY_ATTRIBUTES {
*!*		DWORD nLength;
*!*		LPVOID lpSecurityDescriptor;
*!*		BOOL bInheritHandle;
*!*	} SECURITY_ATTRIBUTES,
*!*	*PSECURITY_ATTRIBUTES;

	LOCAL oSD, hSD, nSDSize, nBufsize, cSecurityAttributes
	oSD = CREATEOBJECT("LocalMem", 512)
	nBufsize=0
	hSD=oSD.GetHandle()
	nSDSize=oSD.GetSize()

	* 获取模板目录的安全描述符
	IF GetFileSecurity(m.cTemplateFolder, DACL_SECURITY_INFORMATION,;
		m.hSD, m.nSDSize, @nBufsize) = 0
		? "GetFileSecurity 调用失败：", GetLastError()
		RETURN .F.
	ENDIF

	* 装配 SECURITY_ATTRIBUTES 结构
	cSecurityAttributes = num2dword(SECURITY_ATTRIBUTES_SIZE) +;
		num2dword(m.hSD) + num2dword(0)

	IF CreateDirectory(cNewFolder, @cSecurityAttributes) = 0
		? "CreateDirectory 失败：", GetLastError()
	ENDIF

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER LocalFree IN kernel32 INTEGER hMem

	DECLARE INTEGER LocalAlloc IN kernel32;
		INTEGER uFlags, INTEGER uBytes

	DECLARE INTEGER SHCreateDirectory IN shell32;
		INTEGER hwnd, STRING pszPath

	DECLARE INTEGER CreateDirectory IN kernel32;
		STRING lpPathName, STRING @lpSecurityAttr

	DECLARE INTEGER GetFileSecurity IN advapi32;
		STRING lpFileName, INTEGER RequestedInformation,;
		INTEGER pSecurityDescriptor, INTEGER nLength,;
		INTEGER @lpnLengthNeeded

DEFINE CLASS LocalMem As Session
* 实现本地分配内存块
#DEFINE LMEM_ZEROINIT 0x0040
PROTECTED hMem, bufsize
	hMem=0
	bufsize=0

PROCEDURE Init(nBufsize)
	THIS.bufsize = m.nBufsize
	THIS.hMem = LocalAlloc(LMEM_ZEROINIT, THIS.bufsize)

PROCEDURE Destroy
	IF THIS.hMem <> 0
		= LocalFree(THIS.hMem)
		THIS.hMem=0
	ENDIF

FUNCTION GetHandle
RETURN THIS.hMem

FUNCTION GetSize
RETURN THIS.bufsize

ENDDEFINE

FUNCTION num2dword(lnValue)
#DEFINE m0 0x0000100
#DEFINE m1 0x0010000
#DEFINE m2 0x1000000
	IF lnValue < 0
		lnValue = 0x100000000 + lnValue
	ENDIF
	LOCAL b0, b1, b2, b3
	b3 = Int(lnValue/m2)
	b2 = Int((lnValue - b3*m2)/m1)
	b1 = Int((lnValue - b3*m2 - b2*m1)/m0)
	b0 = Mod(lnValue, m0)
RETURN Chr(b0)+Chr(b1)+Chr(b2)+Chr(b3)  
```  
***  


## 函数列表：
[CreateDirectory](../libraries/kernel32/CreateDirectory.md)  
[GetFileSecurity](../libraries/advapi32/GetFileSecurity.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[LocalAlloc](../libraries/kernel32/LocalAlloc.md)  
[LocalFree](../libraries/kernel32/LocalFree.md)  
[SHCreateDirectory](../libraries/shell32/SHCreateDirectory.md)  
