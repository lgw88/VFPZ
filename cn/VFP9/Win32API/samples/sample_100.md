[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# DiskFreeSpace 类
_翻译：xinjie  2021.02.06_

## 代码：
```foxpro  
dspace = CREATEOBJECT("Tdspace", "c:")
IF dspace.errorcode = 0
	lcMask = "999,999,999,999,999"

	? "可供调用线程使用的可用字节数:",;
		TRANS(dspace.threadFree, lcMask)

	? "磁盘上的总可用字节数:",;
		TRANS(dspace.globalFree, lcMask)

	? "可供调用线程使用的总字节数:",;
		TRANS(dspace.threadTotal, lcMask)
ELSE
	? "错误代码: ", dspace.errorcode
ENDIF

DEFINE CLASS Tdspace As Session
#DEFINE MAX_INTEGER 0x100000000
	threadFree=0
	threadTotal=0
	globalFree=0
	errorcode=0
	
FUNCTION Init(lcPath)
	THIS.declare
	THIS.GetInfo(lcPath)

PROCEDURE GetInfo(lcPath)
	IF TYPE("lcPath") <> "C"
		lcPath = ""
	ENDIF
	LOCAL lpFreeBytesAvailable, lpTotalNumberOfBytes,;
		lpTotalNumberOfFreeBytes,;
		threadFreeLo, threadFreeHi, threadTotalLo,;
		threadTotalHi, freeLo, freeHi

	STORE Repli(Chr(0), 8) TO lpFreeBytesAvailable,;
		lpTotalNumberOfBytes, lpTotalNumberOfFreeBytes
	
	IF GetDiskFreeSpaceEx(lcPath, @lpFreeBytesAvailable,;
		@lpTotalNumberOfBytes, @lpTotalNumberOfFreeBytes) = 1

		threadFreeLo = THIS.buf2dword(SUBSTR(lpFreeBytesAvailable, 1,4))
		threadFreeHi = THIS.buf2dword(SUBSTR(lpFreeBytesAvailable, 5,4))
		threadTotalLo = THIS.buf2dword(SUBSTR(lpTotalNumberOfBytes, 1,4))
		threadTotalHi = THIS.buf2dword(SUBSTR(lpTotalNumberOfBytes, 5,4))
		freeLo = THIS.buf2dword(SUBSTR(lpTotalNumberOfFreeBytes, 1,4))
		freeHi = THIS.buf2dword(SUBSTR(lpTotalNumberOfFreeBytes, 5,4))

		THIS.threadFree = THIS.GetLargeInt(threadFreeLo, threadFreeHi)
		THIS.threadTotal = THIS.GetLargeInt(threadTotalLo, threadTotalHi)
		THIS.globalFree = THIS.GetLargeInt(freeLo, freeHi)
		THIS.errorcode = 0
	ELSE
		STORE 0 TO THIS.threadFree, THIS.threadTotal, THIS.globalFree
		THIS.errorcode = GetLastError()
	ENDIF

PROTECTED PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE SHORT GetDiskFreeSpaceEx IN kernel32;
		STRING lpDirectoryName, STRING @lpFreeBytesAvailable,;
		STRING @lpTotalNumberOfBytes, STRING @lpTotalNumberOfFreeBytes

PROTECTED FUNCTION  buf2dword (lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256 +;
	Asc(SUBSTR(lcBuffer, 3,1)) * 65536 +;
	Asc(SUBSTR(lcBuffer, 4,1)) * 16777216

PROTECTED FUNCTION GetLargeInt(lo, hi)
RETURN MAX_INTEGER * m.hi + m.lo

ENDDEFINE  
```  
***  


## 函数列表：
[GetDiskFreeSpaceEx](../libraries/kernel32/GetDiskFreeSpaceEx.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  

## 备注：
DiskSpace()在大磁盘或NTFS(VFP7之前)上不可靠。  
  
***  

