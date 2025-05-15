[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何移除 FTP 目录
_翻译：xinjie  2021.01.13_

## 开始之前：
要运行这段代码，你必须有一个适当的用户级别来访问FTP。 
  
***  


## Code:
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER   0
#DEFINE INTERNET_OPEN_TYPE_DIRECT      1
#DEFINE INTERNET_SERVICE_FTP           1
#DEFINE FTP_TRANSFER_TYPE_ASCII        1
#DEFINE FTP_TRANSFER_TYPE_BINARY       2

	PUBLIC hOpen, hFtpSession
    DO decl

	* 选择FTP连接，提供适当的访问级别，在任何情况下都不能是 "匿名 "访问。
	IF connect2ftp ("ftp.???.???", "???", "???")
		lnResult = FtpRemoveDirectory (hFtpSession, "ftptest")
	
		* possible reasons for the directory not being removed:
		* - 您的访问级别无效
		* - 目录不存在
		* - 目录不为空
		IF lnResult = 0
			? GetLastError()	&& 通常错误代码是1203
		ENDIF

		= InternetCloseHandle (hFtpSession)
		= InternetCloseHandle (hOpen)
	ENDIF

PROCEDURE  decl
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER InternetOpen IN wininet.dll;
		STRING  sAgent,;
		INTEGER lAccessType,;
		STRING  sProxyName,;
		STRING  sProxyBypass,;
		STRING  lFlags

    DECLARE INTEGER InternetCloseHandle IN wininet.dll INTEGER hInet

    DECLARE INTEGER InternetConnect IN wininet.dll;
		INTEGER hInternetSession,;
		STRING  sServerName,;
		INTEGER nServerPort,;
		STRING  sUsername,;
		STRING  sPassword,;
		INTEGER lService,;
		INTEGER lFlags,;
		INTEGER lContext

	DECLARE INTEGER FtpRemoveDirectory IN wininet.dll;
    	INTEGER hConnect,;
		STRING  lpszDirectory
RETURN

FUNCTION  connect2ftp (strHost, strUser, strPwd)
	* 开放Inet功能的访问
	hOpen = InternetOpen ("vfp", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

	IF hOpen = 0
		? "无法访问 WinInet.Dll"
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hFtpSession = InternetConnect (hOpen, strHost, INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭 Inet 访问并退出
		= InternetCloseHandle (hOpen)
		? "FTP " + strHost + " 不存在"
		RETURN .F.
	ELSE
		? "连接到 " + strHost + " 用户名和密码: [" + strUser + ", *****]"
	ENDIF
RETURN .T.  
```  
***  


## 函数列表：
[FtpRemoveDirectory](../libraries/wininet/FtpRemoveDirectory.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  


***  

