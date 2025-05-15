[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何删除 FTP 服务器上的文件
_翻译：xinjie  2021.01.15_

## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER   0
#DEFINE INTERNET_OPEN_TYPE_DIRECT      1
#DEFINE INTERNET_SERVICE_FTP           1
#DEFINE FTP_TRANSFER_TYPE_ASCII        1
#DEFINE FTP_TRANSFER_TYPE_BINARY       2

	PUBLIC hOpen, hFtpSession
    DO decl

	IF connect2ftp ("ftp.???.???", "???", "???")

		* 不接受通配符；只接受有效的文件名
		? FtpDeleteFile (hFtpSession, "ftptest/noname.txt")

		= InternetCloseHandle (hFtpSession)
		= InternetCloseHandle (hOpen)
	ENDIF

PROCEDURE  decl
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

	DECLARE INTEGER FtpDeleteFile IN wininet.dll;
    	INTEGER hConnect,;
    	STRING  lpszFileName

RETURN

FUNCTION  connect2ftp (strHost, strUser, strPwd)
	* 开放访问Inet功能
	hOpen = InternetOpen ("vfp", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

	IF hOpen = 0
		? "无法访问 WinInet.Dll"
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hFtpSession = InternetConnect (hOpen, strHost, INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭访问 Inet 功能并退出
		= InternetCloseHandle (hOpen)
		? "FTP " + strHost + " 不可用"
		RETURN .F.
	ELSE
		? "连接到 " + strHost + " 用户名和密码: [" + strUser + ", *****]"
	ENDIF
RETURN .T.  
```  
***  


## 函数列表：
[FtpDeleteFile](../libraries/wininet/FtpDeleteFile.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  

## 备注：
不接受通配符；只接受有效的文件名 
  
***  

