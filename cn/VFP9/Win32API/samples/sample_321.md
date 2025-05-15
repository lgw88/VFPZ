[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 删除文件到回收站
_翻译：xinjie  2021.01.01_

## 开始之前：
SHFileOperation 可以将文件删除到回收站。  

![](../images/recyclebin.png)  

参考：

* [如何清空回收站](sample_301.md)  
* [如何检索回收站中存储的对象数量](sample_302.md)  
* [如何删除非空目录](sample_541.md)  
* [复制文件时显示标准进度对话框](sample_508.md)  
  
***  


## 代码：
```foxpro  
#DEFINE FO_MOVE 1
#DEFINE FO_COPY 2
#DEFINE FO_DELETE 3
#DEFINE FO_RENAME 4
#DEFINE FOF_ALLOWUNDO 64

DO declare

*|typedef struct _SHFILEOPSTRUCT {
*|    HWND  hwnd;                    0:4
*|    UINT  wFunc;                   4:4
*|    LPCTSTR  pFrom;                8:4
*|    LPCTSTR  pTo;                 12:4
*|    FILEOP_FLAGS  fFlags;         16:4
*|    BOOL  fAnyOperationsAborted;  20:4
*|    LPVOID  hNameMappings;        24:4
*|    LPCTSTR  lpszProgressTitle;   28:4
*|} SHFILEOPSTRUCT, *LPSHFILEOPSTRUCT; total bytes: 32

LOCAL lcBuffer, loFileToDelete

* 提供有效的文件名
loFileToDelete = CreateObject("PChar", "c:\a\test1.ldb")

lcBuffer = num2dword(GetActiveWindow()) +;
	num2dword(FO_DELETE) +;
	num2dword(loFileToDelete.GetAddr()) +;
	num2dword(0) +;
	num2dword(FOF_ALLOWUNDO) +;
	num2dword(0) + num2dword(0) + num2dword(0)

= SHFileOperation(@lcBuffer)
* 主程序结束

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

PROCEDURE declare
	DECLARE INTEGER SHFileOperation IN Shell32 STRING @lpFileOp
	DECLARE INTEGER GetActiveWindow IN user32

DEFINE CLASS PChar As Custom
	PROTECTED hMem

PROCEDURE  Init (lcString)
	THIS.hMem = 0
	THIS.setValue (lcString)

PROCEDURE  Destroy
	THIS.ReleaseString

FUNCTION getAddr  && returns a pointer to the string
RETURN THIS.hMem

FUNCTION getValue && returns string value
	LOCAL lnSize, lcBuffer
	lnSize = THIS.getAllocSize()
	lcBuffer = SPACE(lnSize)

	IF THIS.hMem <> 0
		DECLARE RtlMoveMemory IN kernel32 As Heap2Str;
			STRING @, INTEGER, INTEGER
		= Heap2Str (@lcBuffer, THIS.hMem, lnSize)
	ENDIF
RETURN lcBuffer

FUNCTION getAllocSize  && returns allocated memory size (string length)
	DECLARE INTEGER GlobalSize IN kernel32 INTEGER hMem
RETURN Iif(THIS.hMem=0, 0, GlobalSize(THIS.hMem))

PROCEDURE setValue (lcString) && assigns new string value
#DEFINE GMEM_FIXED   0
	THIS.ReleaseString

	DECLARE INTEGER GlobalAlloc IN kernel32 INTEGER, INTEGER
	DECLARE RtlMoveMemory IN kernel32 As Str2Heap;
		INTEGER, STRING @, INTEGER

	LOCAL lnSize
	lcString = lcString + Chr(0)
	lnSize = Len(lcString)
	THIS.hMem = GlobalAlloc (GMEM_FIXED, lnSize)
	IF THIS.hMem <> 0
		= Str2Heap (THIS.hMem, @lcString, lnSize)
	ENDIF

PROCEDURE ReleaseString  && releases allocated memory
	IF THIS.hMem <> 0
		DECLARE INTEGER GlobalFree IN kernel32 INTEGER
		= GlobalFree (THIS.hMem)
		THIS.hMem = 0
	ENDIF
ENDDEFINE  
```  
***  


## 函数列表：
[GetActiveWindow](../libraries/user32/GetActiveWindow.md)  
[GlobalAlloc](../libraries/kernel32/GlobalAlloc.md)  
[GlobalFree](../libraries/kernel32/GlobalFree.md)  
[GlobalSize](../libraries/kernel32/GlobalSize.md)  
[SHFileOperation](../libraries/shell32/SHFileOperation.md)  

## 备注

在 .NET 中，将文件发送到回收站只需简单的调用 [FileSystem.DeleteFile](https://msdn.microsoft.com/en-us/library/ms127976(v=vs.100).aspx)（将 *RecycleOption* 参数设置为 *SendToRecycleBin*）。 调用 [FileSystem.DeleteDirectory](https://msdn.microsoft.com/en-us/library/ms127971(v=vs.100).aspx) 时可以使用相同的选项。
  
***  

