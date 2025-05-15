[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何使用 FtpGetFile 从 FTP 服务器下载文件
_翻译：xinjie  2021.01.05_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。


## 开始之前：
参考：

* [用于 Visual FoxPro 应用程序的自定义 FTP 类](sample_344.md)  
<!-- Anatoliy --> 
* [在 Visual FoxPro 中对文件传输协议进行编程](?article=3)  

  
***  


## 代码：
```foxpro  
* lAccessType - 一些值
#DEFINE INTERNET_INVALID_PORT_NUMBER  0
#DEFINE INTERNET_OPEN_TYPE_DIRECT     1
#DEFINE INTERNET_OPEN_TYPE_PROXY      3
#DEFINE INTERNET_DEFAULT_FTP_PORT     21

* lFlags：只有几个
#DEFINE INTERNET_FLAG_ASYNC 0x10000000
#DEFINE INTERNET_FLAG_FROM_CACHE  0x1000000
#DEFINE INTERNET_FLAG_OFFLINE  0x1000000
#DEFINE INTERNET_FLAG_CACHE_IF_NET_FAIL 0x10000

* 注册表访问设置
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG  0
#DEFINE FTP_TRANSFER_TYPE_ASCII       1
#DEFINE FTP_TRANSFER_TYPE_BINARY      2

* 要访问的服务类型
#DEFINE INTERNET_SERVICE_FTP     1
#DEFINE INTERNET_SERVICE_GOPHER  2
#DEFINE INTERNET_SERVICE_HTTP    3

* 文件属性
#DEFINE FILE_ATTRIBUTE_NORMAL  0x80

	do decl

	* 你可以自由选择任何名字，比如  "John Dow"
	* 服务器端变量$AGENT是目标
	sAgent = "vfp6"

	sProxyName = Chr(0)		&& 我没有代理
	sProxyBypass = Chr(0)	&& 所以没有什么可以绕过的
	lFlags = 0				&& 无标志

	* 初始化对Inet函数的访问
	hOpen = InternetOpen (sAgent, INTERNET_OPEN_TYPE_DIRECT,;
		sProxyName, sProxyBypass, lFlags)

	IF hOpen = 0
		? "无法访问WinInet.Dll。"
		RETURN
	ELSE
		? "Wininet访问句柄: " + LTRIM(STR(hOpen))
	ENDIF
	
	* 连接参数 - 你最好使用你自己的数据
	strHost = "ftp.gnu.org"
	strUser = "anonymous"		&& 这个用户名几乎在所有的地方都能使用
	strPwd  = "vfp" + SYS(3) + "@msn.com"

	* 连接到FTP
	hFtpSession = InternetConnect (hOpen, strHost,;
		INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd,;
		INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭访问Inet功能并退出
		= InternetCloseHandle (hOpen)
		? 无法连接到所选择的FTP"
		RETURN
	ELSE
		? "连接到 " + strHost + " 以下面身份: [" + strUser + ", " + strPwd + "]"
		? "FTP 连接句柄: " + LTRIM(STR(hFtpSession))
	ENDIF
	
	* 从FTP下载文件
	* 不检查目标文件是否存在
	lpszRemoteFile = "welcome.msg"		    && 如果还存在
	lpszNewFile    = "c:\Temp\welcome.txt"	&& 检查目标文件夹
	fFailIfExists  = 0		&& 如果目标已经存在，不要停止
	dwContext      = 0

	lnResult = FtpGetFile (hFtpSession, lpszRemoteFile, lpszNewFile,;
		fFailIfExists, FILE_ATTRIBUTE_NORMAL, FTP_TRANSFER_TYPE_ASCII,;
		dwContext)

	IF lnResult = 1
		MODI FILE (lpszNewFile)	&& 打开所下载的文件
	ELSE
		? "无法下载所选文件"
	ENDIF

	* 关闭句柄
	= InternetCloseHandle (hFtpSession)
	= InternetCloseHandle (hOpen)
RETURN		&& main

PROCEDURE  decl
	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessType, STRING sProxyName,;
		STRING sProxyBypass, STRING  lFlags
	
	DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetConnect IN wininet;
		INTEGER hInternetSession, STRING  sServerName,;
		INTEGER nServerPort, STRING  sUsername,;
		STRING  sPassword, INTEGER lService,;
		INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpGetFile IN wininet;
		INTEGER hFtpSession, STRING  lpszRemoteFile,;
		STRING  lpszNewFile, INTEGER fFailIfExists,;
		INTEGER dwFlagsAndAttributes,;
		INTEGER dwFlags, INTEGER dwContext  
```  
***  


## 函数列表：
[FtpGetFile](../libraries/wininet/FtpGetFile.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  

## 备注：
这个例子很简单。我知道这个远程文件存在于FTP上 而且是ASCII类型的文件  
  
那么我建议你最好选择另一个FTP和一个文件名来测试。只是为了避免打扰GNU ftp的人。 

***  

