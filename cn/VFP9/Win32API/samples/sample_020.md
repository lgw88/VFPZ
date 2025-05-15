[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 显示操作系统的内存状态
_翻译：xinjie  2021.01.02_

## 代码：
```foxpro  
*|typedef struct _MEMORYSTATUS {
*| DWORD dwLength;           0:4
*| DWORD dwMemoryLoad;       4:4
*| SIZE_T dwTotalPhys;       8:4
*| SIZE_T dwAvailPhys;      12:4
*| SIZE_T dwTotalPageFile;  16:4
*| SIZE_T dwAvailPageFile;  20:4
*| SIZE_T dwTotalVirtual;   24:4
*| SIZE_T dwAvailVirtual;   28:4
*| } MEMORYSTATUS, *LPMEMORYSTATUS; total 32 bytes
#DEFINE MEMORYSTATUS_SIZE  32
	
DECLARE GlobalMemoryStatus IN kernel32;
	STRING @lpBuffer

PRIVATE cBuffer
cBuffer = REPLI(Chr(0), MEMORYSTATUS_SIZE)
= GlobalMemoryStatus(@cBuffer)

= Writeln("正在使用的内存, % ....................",  5)
= Writeln("物理内存，字节数 .....................",  9)
= Writeln("可用物理内存，字节数 .................", 13)
= Writeln("已提交内存，字节数 ...................", 17)
= Writeln("可用内存，字节数 .....................", 21)
= Writeln("用户模式..., 字节数 .................", 25)
= Writeln("未保留/未提交内存 ......", 29)

PROCEDURE Writeln(cCaption, nOffs)
	LOCAL nSize
	nSize = buf2dword(SUBSTR(cBuffer,nOffs,4))
	? cCaption + " " + ALLTRIM(TRANS(nSize, "999,999,999,999,999,999"))

FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(cBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[GlobalMemoryStatus](../libraries/kernel32/GlobalMemoryStatus.md)  

## 备注：
MEMORYSTATUS 反映了调用时的内存状态。 它反映了当时分页文件的大小。
  
正在使用的内存--对于 WinNT，此值可以为零。
  
在内存大于 4 GB 的计算机上，MEMORYSTATUS 结构可能返回错误的信息。 如果您的应用程序有这种行为的风险，请改用 GlobalMemoryStatusEx 函数。  
  
***  

