[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何通过 WinInet 函数使用 InternetOpenUrl 下载该参考文献的档案
_翻译：xinjie 2021.06.24_

## 开始之前
查看[类似的例子](sample_175.md)-基于 URL Monikers 函数。  
  
***  


## 代码：
```foxpro  
#DEFINE INTERNET_OPEN_TYPE_DIRECT    1
#DEFINE INTERNET_FLAG_NEED_FILE     16

	DO decl		&& 声明外部函数

	* 初始化 Wininet library
	PRIVATE hOpen

    hOpen = InternetOpen ("w32vfp=110", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)
    IF hOpen = 0
		? "GetLastError:", GetLastError()
		? "此计算机上没有 WinInet"
		RETURN
    ENDIF

	LOCAL lcBaseUrl, lcDstPath, hFile, lcFile

	lcBaseUrl = "https://github.com/VFPX/Win32API/tree/master/downloads/"
	lcFile    = "w32data.zip"	&& 带有DBF表的远程档案文件
	lcDstPath = "c:\Temp\"  && 指定一个目标目录

	* 获取远程文件的句柄
	hFile = InternetOpenUrl (hOpen,;
				lcBaseUrl + lcFile, "", 0,;
				INTERNET_FLAG_NEED_FILE, 0)

	IF hFile <> 0
	* 即使没有这样的文件，最明显的你也会得到一个 ASCII 文件作为响应（404 错误页面）
		= http2local (hFile, lcDstPath + lcFile)
		= InternetCloseHandle (hFile)
	ELSE
		? "无法打开源文件"
		? "GetLastError:", GetLastError()
	ENDIF
	
	* 释放 WinInet library
    = InternetCloseHandle (hOpen)
RETURN		&& main

FUNCTION http2local (hSource, lcTarget)
* 从远程文件中读取数据
#DEFINE TransferBuffer   4096
	? lcTarget + " "
	
	* 创建目标文件
	hTarget = FCREATE (lcTarget)
	IF (hTarget = -1)
		?? "无效的目标文件名"
		RETURN -1
	ENDIF

	LOCAL lnTotalBytesRead, lnBytesRead
	lnTotalBytesRead = 0
	
	DO WHILE .T.
		lcBuffer = REPLI (Chr(0), TransferBuffer)
		lnBytesRead = 0

		IF InternetReadFile (hSource, @lcBuffer,;
			TransferBuffer, @lnBytesRead) = 1

			= FWRITE (hTarget, lcBuffer, lnBytesRead)
			IF lnBytesRead = 0
				EXIT
			ENDIF

			lnTotalBytesRead = lnTotalBytesRead + lnBytesRead
			?? "�"
		ELSE
			EXIT
		ENDIF
	ENDDO

	= FCLOSE (hTarget)
	?? " " + LTRIM(STR(lnTotalBytesRead)) + " bytes Ok"
RETURN  lnBytesRead

PROCEDURE  decl
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessTypem,;
		STRING sProxyName, STRING ProxyBypass, STRING lFlags

	DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetOpenUrl IN wininet;
		INTEGER hInternet, STRING lpszUrl, STRING lpszHeaders,;
		INTEGER dwHeadersLength, INTEGER dwFlags,;
		INTEGER dwContext

	DECLARE INTEGER InternetReadFile IN wininet;
		INTEGER hFile, STRING @lpBuffer,;
		INTEGER dwNumberOfBytesToRead,;
		INTEGER @lpdwNumberOfBytesRead  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  
[InternetOpenUrl](../libraries/wininet/InternetOpenUrl.md)  
[InternetReadFile](../libraries/wininet/InternetReadFile.md)  

## 备注：
这个特殊的例子让你下载VFP表格，其中包含这个参考的最新数据。 
\- 函数列表  
\- 示例列表  
\- 按分组排列的函数列表  
\- 列表中的库  
  
之后你就可以在本地处理这些数据了。  
  
通过超文本传输协议--也称为HTTP--这个程序打开一个远程Zip档案，并将其传输到你的计算机上的一个本地文件。 
  
尽管这段代码的主要任务是演示InternetOpenUrl功能。 
  
当然，你也可以[在这里直接下载](./downloads/w32data.zip)。
  
***  

