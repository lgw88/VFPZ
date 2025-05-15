[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 在 FTP 上创建一个目录
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER  0
#DEFINE INTERNET_OPEN_TYPE_DIRECT     1
#DEFINE INTERNET_SERVICE_FTP          1
#DEFINE INTERNET_SERVICE_GOPHER       2
#DEFINE INTERNET_SERVICE_HTTP         3
DO decl

* 初始化对Inet函数的访问
hOpen = InternetOpen ("w32ftpdir", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

IF hOpen = 0
		? "无法访问 WinInet.Dll"
	RETURN
ENDIF

* 将有效的FTP连接设置放在这里
strHost = "???"
strUser = "???"
strPwd  = "???"

* 连接到 FTP
hFtpSession = InternetConnect (hOpen, strHost,;
		INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

IF hFtpSession <> 0
	IF FtpCreateDirectory (hFtpSession, "mydir" + SUBSTR(SYS(3),5)) = 1
		? "已创建新目录"
	ELSE
		? "不能创建新目录"
	ENDIF
ELSE
	? "无法连接到所选的FTP"
ENDIF

* 关闭FTP连接和Wininet访问
= InternetCloseHandle (hFtpSession)
= InternetCloseHandle (hOpen)

PROCEDURE  decl
	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessType,;
		STRING sProxyName, STRING sProxyBypass,;
		STRING lFlags
	
	DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetConnect IN wininet;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername, STRING sPassword,;
		INTEGER lService, INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpCreateDirectory IN wininet;
		INTEGER hFtpSession, STRING  lpszDirectory  
```  
***  


## 函数列表：
[FtpCreateDirectory](../libraries/wininet/FtpCreateDirectory.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  

***  

