[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 使用 EnumPrinters 函数来列举本地安装的打印机

## 开始之前：
参看：

* [枚举安装的打印机驱动程序](sample_082.md)  
* [枚举指定服务器上安装的打印处理器和支持的数据类型](sample_333.md)  
* [枚举打印作业和检索默认打印机的信息](sample_368.md)  
* [如何检索已经排队的打印机的打印作业数量](sample_367.md)  
* [枚举指定服务器上可用于打印的端口](sample_334.md)  

  
***  


## 代码：
```foxpro  
#DEFINE PRINTER_ENUM_DEFAULT      1
#DEFINE PRINTER_ENUM_LOCAL        2
#DEFINE PRINTER_ENUM_CONNECTIONS  4
#DEFINE PRINTER_ENUM_FAVORITE     4
#DEFINE PRINTER_ENUM_NAME         8
#DEFINE PRINTER_ENUM_REMOTE      16
#DEFINE PRINTER_ENUM_SHARED      32
#DEFINE PRINTER_ENUM_NETWORK     64

#DEFINE GMEM_FIXED  0

*|typedef struct _PRINTER_INFO_2 {
*|  LPTSTR    pServerName;       0:4
*|  LPTSTR    pPrinterName;      4:4
*|  LPTSTR    pShareName;        8:4
*|  LPTSTR    pPortName;        12:4
*|  LPTSTR    pDriverName;      16:4
*|  LPTSTR    pComment;         20:4
*|  LPTSTR    pLocation;        24:4
*|  LPDEVMODE pDevMode;         28:4
*|  LPTSTR    pSepFile;         32:4
*|  LPTSTR    pPrintProcessor;  36:4
*|  LPTSTR    pDatatype;        40:4
*|  LPTSTR    pParameters;      44:4
*|  PSECURITY_DESCRIPTOR pSecurityDescr;
*|  DWORD     Attributes;       52:4
*|  DWORD     Priority;         56:4
*|  DWORD     DefaultPriority;  60:4
*|  DWORD     StartTime;        64:4
*|  DWORD     UntilTime;        68:4
*|  DWORD     Status;           72:4
*|  DWORD     cJobs;            76:4
*|  DWORD     AveragePPM;       80:4
*|} PRINTER_INFO_2, *PPRINTER_INFO_2; total 84 bytes
#DEFINE PRINTER_INFO_2_SIZE  84

DO declare

PRIVATE hBuffer, nBufsize, cBuffer, nCount, cInfo
LOCAL lnNeeded, lnResult, lnIndex

nBufsize = 16384
hBuffer = GlobalAlloc(GMEM_FIXED, nBufsize)
STORE 0 TO lnNeeded, nCount

lnResult = EnumPrinters(PRINTER_ENUM_LOCAL, 0, 2,;
	hBuffer, nBufsize, @lnNeeded, @nCount)

IF lnResult=0
	? "Error code:", GetLastError()
ELSE
	IF nCount = 0
		? "Nothing found"
	ELSE
		cBuffer = Repli(Chr(0), nBufsize)
		= Mem2Str(@cBuffer, hBuffer, nBufsize)
		FOR lnIndex=0 TO nCount-1
			cInfo = SUBSTR(cBuffer,;
				lnIndex*PRINTER_INFO_2_SIZE+1, PRINTER_INFO_2_SIZE)

			DO DisplayResult
		ENDFOR
	ENDIF
ENDIF
IF USED("csResult")
	GO TOP
	BROW NORMAL NOWAIT
ENDIF
= GlobalFree(hBuffer)
* end of main

PROCEDURE DisplayResult
	IF Not USED("csResult")
		CREATE CURSOR csResult ( prnname C(64), sharename C(20),;
			portname C(20), drvname C(30), pcomment C(20),;
			location C(20), sepfile C(20), processor C(20),;
			datatype C(20), params C(20), pattrib I,;
			priority I, pstatus I, numjobs I)
	ENDIF
	INSERT INTO csResult VALUES (ms(5), ms(9), ms(13),;
		ms(17), ms(21), ms(25), ms(33), ms(37), ms(41), ms(45),;
		mw(53), mw(57), mw(73), mw(77);
	)
RETURN

FUNCTION mw(lnOffs)
RETURN buf2dword(SUBSTR(cInfo, lnOffs,4))

FUNCTION ms(lnOffs)
RETURN GetMemStr(buf2dword(SUBSTR(cInfo, lnOffs,4)))

FUNCTION GetMemStr(lnAddr)
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

FUNCTION buf2dword (lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER GlobalAlloc IN kernel32 INTEGER wFlags, INTEGER dwBytes
	DECLARE INTEGER GlobalFree IN kernel32 INTEGER hMem

	DECLARE RtlMoveMemory IN kernel32 As CopyMemory;
		STRING @Dest, INTEGER Src, INTEGER nLength

	DECLARE INTEGER EnumPrinters IN winspool.drv;
		INTEGER Flags, INTEGER EnumName, INTEGER Level,;
		INTEGER pPrinterEnum, INTEGER cbBuf,;
		INTEGER @pcbNeeded, INTEGER @pcReturned

	DECLARE RtlMoveMemory IN kernel32 As Mem2Str;
		STRING @Dest, INTEGER Src, INTEGER nLength  
```  
***  


## 函数列表：
[EnumPrinters](../libraries/winspool.drv/EnumPrinters.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GlobalAlloc](../libraries/kernel32/GlobalAlloc.md)  
[GlobalFree](../libraries/kernel32/GlobalFree.md)  

## 备注：
要获得关于默认打印机的信息，调用GetProfileString函数，将部分名称字符串设置为 "windows"，关键名称字符串设置为 "device"。返回的字符串包含默认打印机的名称，打印机DRV文件的名称，以及打印机连接的端口。 
  
***  

