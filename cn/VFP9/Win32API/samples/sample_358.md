[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索默认假脱机目录（后台打印文件夹）名称
_翻译：xinjie  2020.12.31_

## 开始之前：
参考：

* [如何删除打印机的所有打印任务](sample_370.md)  
* [如何检索打印机排队等候的打印作业数量](sample_367.md)  
* [简单的打印机队列监视器](sample_373.md)  
  
***  


## 代码：
```foxpro  
DO decl

LOCAL cPrinter, hPrinter, lnType, lcBuffer, lnBufsize
cPrinter = GetDefaultPrinter()
STORE 0 TO hPrinter, lnType, lnBufsize

IF OpenPrinter(cPrinter, @hPrinter, 0) <> 0
	lcBuffer = Repli(Chr(0), 250)
	= GetPrinterData(hPrinter, "DefaultSpoolDirectory",;
		@lnType, @lcBuffer, Len(lcBuffer), @lnBufsize)

	? "默认假脱机目录：", SUBSTR(lcBuffer, 1,lnBufsize-1)

	= ClosePrinter(hPrinter)
ENDIF
* 主程序结束

FUNCTION GetDefaultPrinter
	LOCAL lcBuffer
	lcBuffer = Repli(Chr(0), 120)

	* 检索打印机、打印机驱动程序和输出端口名
	DECLARE INTEGER GetProfileString IN kernel32;
		STRING lpApp, STRING lpKey, STRING lpDefault,;
		STRING @lpReturnedString, INTEGER nSize

	= GetProfileString("Windows", "Device", ",,,", @lcBuffer, Len(lcBuffer))
	lcBuffer = STRTRAN(lcBuffer, Chr(0), "")
RETURN SUBSTR(lcBuffer, 1, AT(",", lcBuffer)-1)

PROCEDURE decl
	DECLARE INTEGER GetPrinterData IN winspool.drv;
		INTEGER hPrinter, STRING pValueName, INTEGER @pType,;
		STRING @pData, LONG nSize, LONG @pcbNeeded

	DECLARE INTEGER OpenPrinter IN winspool.drv;
		STRING pPrinterName, INTEGER @phPrinter, INTEGER pDefault

	DECLARE INTEGER ClosePrinter IN winspool.drv INTEGER hPrinter  
```  
***  


## 函数列表：
[ClosePrinter](../libraries/winspool.drv/ClosePrinter.md)  
[GetPrinterData](../libraries/winspool.drv/GetPrinterData.md)  
[GetProfileString](../libraries/kernel32/GetProfileString.md)  
[OpenPrinter](../libraries/winspool.drv/OpenPrinter.md)  

## Comment:
可能存在某些原因更改打印假脱机目录（WIN10:后台打印文件夹），可以使用 SetPrinterData 函数或通过“开始-设置-打印机”命令手动完成此任务。  
  
***  

