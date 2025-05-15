[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 读取互联网查询选项
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER  0
#DEFINE INTERNET_OPEN_TYPE_DIRECT     1
#DEFINE INTERNET_SERVICE_FTP          1
#DEFINE FTP_TRANSFER_TYPE_ASCII       1
#DEFINE FTP_TRANSFER_TYPE_BINARY      2

#DEFINE INTERNET_OPTION_CONNECT_TIMEOUT     2
#DEFINE INTERNET_OPTION_RECEIVE_TIMEOUT     6
#DEFINE INTERNET_OPTION_SEND_TIMEOUT        5
#DEFINE INTERNET_OPTION_USERNAME            28
#DEFINE INTERNET_OPTION_PASSWORD            29
#DEFINE INTERNET_OPTION_VERSION             40
#DEFINE INTERNET_OPTION_PROXY_USERNAME      43
#DEFINE INTERNET_OPTION_PROXY_PASSWORD      44
#DEFINE INTERNET_OPTION_CONNECTED_STATE     50
#DEFINE INTERNET_OPTION_CLIENT_CERT_CONTEXT 84
    DO decl

	PRIVATE hOpen, hFtpSession
	STORE 0 TO hOpen, hFtpSession

	IF connect2ftp("ftp.linux.com", "anonymous",;
			"vfp"+LEFT(SYS(3),5)+"@win32.com")
		? GetFtpStatus (hFtpSession)
		? GetUserData (hFtpSession)
		= InternetCloseHandle (hFtpSession)
		= InternetCloseHandle (hOpen)
	ENDIF
* 主程序结束

FUNCTION GetFtpStatus(hConnection)
	LOCAL lcBuffer, lnBufsize
	lcBuffer = " "
	lnBufsize = 0
	IF ReadOption(hConnection, INTERNET_OPTION_CONNECTED_STATE,;
		@lcBuffer, @lnBufsize)
		RETURN (LEFT(lcBuffer,1) = Chr(1))
	ENDIF
RETURN .F.

FUNCTION GetUserData(hConnection)
	LOCAL lcBuffer, lnBufsize, lcResult

	lnBufsize = 64
	lcBuffer = " "
	= ReadOption(hConnection, INTERNET_OPTION_USERNAME,;
		@lcBuffer, @lnBufsize)
	lcResult = LEFT(lcBuffer, lnBufsize)

	lnBufsize = 64
	lcBuffer = " "
	= ReadOption(hConnection, INTERNET_OPTION_PASSWORD,;
		@lcBuffer, @lnBufsize)
	lcResult = lcResult + ", " + LEFT(lcBuffer, lnBufsize)
RETURN  lcResult

FUNCTION ReadOption(hConnection, lnOption, lcBuffer, lnBufsize)
	LOCAL lnResult
	IF TYPE("lnBufsize")<>"N" Or lnBufsize<=0
	* 这个调用决定了所需的缓冲区大小
		= InternetQueryOption(0, lnOption, @lcBuffer, @lnBufsize)
	ENDIF

	* 读取选项
	lcBuffer = REPLI (Chr(0), lnBufsize)
RETURN InternetQueryOption(hConnection, lnOption, @lcBuffer, @lnBufsize) = 1

FUNCTION connect2ftp(strHost, strUser, strPwd)
	* 开始访问 Inet 函数
	hOpen = InternetOpen ("vfp", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

	IF hOpen = 0
		? "无法访问 WinInet.Dll"
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hFtpSession = InternetConnect (hOpen, strHost, INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭 Inet 函数并退出
		= InternetCloseHandle (hOpen)
		? "FTP " + strHost + " 不可用"
		RETURN .F.
	ELSE
		? "连接到 " + strHost + " 用户名和密码: [" + strUser + ", *****]"
	ENDIF
RETURN .T.

PROCEDURE  decl
    DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetQueryOption IN wininet;
		INTEGER hInternet, INTEGER lOption,;
		STRING @sBuffer, INTEGER @lBufferLength

	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessType, STRING sProxyName,;
		STRING sProxyBypass, STRING lFlags

    DECLARE INTEGER InternetConnect IN wininet;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername,;
		STRING sPassword, INTEGER lService,;
		INTEGER lFlags, INTEGER lContext

RETURN  
```  
***  


## 函数列表：
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  
[InternetQueryOption](../libraries/wininet/InternetQueryOption.md)  

## 备注：
在这里你可以访问[Internet选项标志的完整列表](https://msdn.microsoft.com/en-us/library/windows/desktop/aa385328(v=vs.85).aspx)，只要呈现的链接保持有效。MSDN以其不稳定的链接而闻名。 
  
当你在一段时间前连接到 FTP，并想在交换数据或发送命令之前验证连接时，FTP 状态的测试似乎很有用。  
  
**INTERNET_OPTION_CLIENT_CERT_CONTEXT**  
这个标志不被 InternetQueryOption 支持。lpBuffer 参数必须是指向 CERT CONTEXT 结构的指针，而不是指向 CERT CONTEXT 指针的指针。  
  
如果应用程序接收到 ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED，它必须在重试请求之前调用 InternetErrorDlg 或使用 InternetSetOption 来提供证书。然后调用 CertDuplicateCertificateContext，这样应用程序就可以独立释放传递的证书上下文。   
  
* * *  
有一篇 Ayhan AVCI 的文章： 
[使用 Wininet 用 SSL 连接到 HTTPS 服务器，发送客户端证书并读取响应](https://www.codeproject.com/Articles/3898/Connecting-to-a-HTTPS-server-with-SSL-using-Winine)。 
这是我最近在[Code Project](http://www.codeproject.com/)发现的。虽然是基于VB代码，但它可能还是会节省你的时间。
  
***  

