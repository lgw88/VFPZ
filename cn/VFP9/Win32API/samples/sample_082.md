[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 枚举安装的打印机驱动程序
_翻译：xinjie  221.01.16_

## 开始之前：

参考：

* [使用 EnumPrinters 函数枚举本地安装的打印机](sample_146.md)  
* [枚举安装在指定服务器上的打印处理器和支持的数据类型](sample_333.md)  
* [枚举打印作业并检索默认打印机的信息(JOB_INFO_1结构)](sample_368.md)  
* [如何检索打印机排队等候的打印作业数量](sample_367.md)  
* [枚举指定服务器上可用的打印端口](sample_334.md)  

  
***  


## 代码：
```foxpro  
#DEFINE GMEM_FIXED 0
DO declare

*|typedef struct _DRIVER_INFO_2 {
*|  DWORD  cVersion;     0:4
*|  LPTSTR pName;        4:4
*|  LPTSTR pEnvironment; 8:4
*|  LPTSTR pDriverPath;  12:4
*|  LPTSTR pDataFile;    16:4
*|  LPTSTR pConfigFile;  20:4
*|} DRIVER_INFO_2, *PDRIVER_INFO_2; -> 24 bytes

#DEFINE DRIVER_INFO_SIZE 24

PRIVATE hBuffer, nBufsize, cBuffer, cInfo

nBufsize = 16384
hBuffer = GlobalAlloc(GMEM_FIXED, nBufsize)

LOCAL lcServer, lnResult, lnReturned, lnCount
STORE 0 TO lnReturned, lnIndex, lnCount

* 用Null代表本地计算机或使用有效的服务器名称
* e.g. "\\MYSERVER"
lcServer = Null
lnResult = EnumPrinterDrivers(lcServer,;
	Null, 2, hBuffer, nBufsize,;
	@lnReturned, @lnCount)

IF lnResult = 0
	? "错误代码:", GetLastError()
	= GlobalFree(hBuffer)
	RETURN
ENDIF

cBuffer = REPLICATE(CHR(0), nBufsize)
= Mem2Str(@cBuffer, hBuffer, nBufsize)

* 用于存储驱动程序数据的游标
CREATE CURSOR csDrvList (;
	ver I, drvname C(50),;
	envname C(20),;
	drvpath C(200),;
	drvfile C(200), cfgfile C(200))

FOR lnIndex=0 TO lnCount-1

	cInfo = SUBSTR(cBuffer,;
		lnIndex * DRIVER_INFO_SIZE+1,;
		DRIVER_INFO_SIZE)

	INSERT INTO csDrvList;
	VALUES (mw(1), ms(5), ms(9),;
		ms(13), ms(17), ms(21))

ENDFOR

= GlobalFree(hBuffer)

IF USED("csDrvList")
	GO TOP
	EDIT NORMAL NOWAIT
ENDIF
* 主程序结束

FUNCTION mw(lnOffs As Number)
RETURN buf2dword(SUBSTR(cInfo, lnOffs, 4))

FUNCTION ms(lnOffs As Number)
RETURN GetMemStr(buf2dword(SUBSTR(cInfo, lnOffs, 4)))

FUNCTION GetMemStr(lnAddr As Number)
	IF lnAddr = 0
		RETURN ""
	ENDIF

	LOCAL lnOffs, lcResult, ch
	lnOffs = lnAddr - hBuffer + 1
	lcResult = ""

	DO WHILE lnOffs < nBufsize
		ch = SUBSTR(cBuffer, lnOffs,1)
		IF ch = Chr(0)
			EXIT
		ELSE
			lcResult = lcResult + ch
		ENDIF
		lnOffs = lnOffs + 1
	ENDDO
RETURN lcResult

FUNCTION buf2dword (lcBuffer As Character)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)), 8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)

PROCEDURE declare
	DECLARE INTEGER EnumPrinterDrivers IN winspool.drv;
		STRING pName, STRING pEnvironment,;
		LONG Lvl, INTEGER pDrvInfo,;
		INTEGER cbBuf, INTEGER @pcbNeeded,;
		INTEGER @pcReturned

	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER GlobalFree IN kernel32 INTEGER hMem

	DECLARE INTEGER GlobalAlloc IN kernel32;
		INTEGER wFlags, INTEGER dwBytes

	DECLARE RtlMoveMemory IN kernel32 As Mem2Str;
		STRING @Dest, INTEGER Src,;
		INTEGER nLength  
```  
***  


## 函数列表：
[EnumPrinterDrivers](../libraries/winspool.drv/EnumPrinterDrivers.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GlobalAlloc](../libraries/kernel32/GlobalAlloc.md)  
[GlobalFree](../libraries/kernel32/GlobalFree.md)  
