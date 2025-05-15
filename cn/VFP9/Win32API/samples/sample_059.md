[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 FtpCommand

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。


## 开始之前：
<!-- Anatoliy -->
<table cellspacing=3 cellpadding=0 border=0><tr><td valign=top><img src="../images/readarticle.gif" border=0></td><td valign=top class=fdescr><a href="?article=3">在 Visual FoxPro 中对文件传输协议进行编程</a></td></tr></table>  

 
参考：

* [Winsock：访问 FTP](sample_386.md)  
<!-- Anatoliy -->
完整的FTP方案：  
<a href="http://www.news2news.com/vfp/?solution=1&src=x59"><img src="../images/ftplib_270_48.jpg" width=270 height=48 border=0  vspace=5 hspace=5 alt="下载 FTP 类库"></a>  
 
  
***  


## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER   0
#DEFINE INTERNET_OPEN_TYPE_DIRECT      1
#DEFINE INTERNET_SERVICE_FTP           1
#DEFINE FTP_TRANSFER_TYPE_ASCII        1
#DEFINE FTP_TRANSFER_TYPE_BINARY       2
SET MEMOWIDTH TO 250
DO decl

PRIVATE hWininet, hSession, cServer, cUser, cPwd
STORE 0 TO hWininet, hSession
cServer = "ftp.gutenpress.org"
cUser = "anonymous"
cPwd = "ano@nymous.com"

IF Connect2Ftp()
	DO ShowResponse
	= ExecCmd("SYST", 0)
	= ExecCmd("HELP", 0)

*	DO test1
*	DO test2
*	DO test3
	
	= ExecCmd("QUIT", 0)

	= InternetCloseHandle(hSession)
	= InternetCloseHandle (hWininet)
ELSE
	? "没有连接到", cServer
ENDIF
* 主程序结束

PROCEDURE test1  && root directory list
	= ExecCmd("LIST", 1)

PROCEDURE test2
* 这两个命令可以用 "LIST <目录名>"来代替。
	= ExecCmd("CWD pub/gutenberg", 0)
	= ExecCmd("PWD", 0)
*	= ExecCmd("LIST", 1)

PROCEDURE test3  && retrieving an ASCII file
	= ExecCmd("RETR pub/gutenberg/donate-howto.txt", 1)

FUNCTION Connect2Ftp
	* 开启对Inet功能的访问
	hWininet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT, 0,0,0)

	IF hWininet = 0
	* wininet.dll不可用
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hSession = InternetConnect(hWininet, cServer,;
		INTERNET_INVALID_PORT_NUMBER,;
		cUser, cPwd, INTERNET_SERVICE_FTP, 0,0)

	IF hSession = 0
	* 连接失败
		= InternetCloseHandle(hWininet)
		RETURN .F.
	ENDIF
RETURN .T.

FUNCTION ExecCmd(lcCommand, fExpectResponse)
* 注意，ASCII码是硬编码
	? ">>", lcCommand
	LOCAL nResult
	hFile = 0
	nResult = FtpCommand (hSession, fExpectResponse,;
		FTP_TRANSFER_TYPE_ASCII, lcCommand, 0, @hFile)

	IF nResult = 0
		? "命令执行错误:", GetLastError()
		RETURN
	ENDIF

	IF hFile <> 0
	* 如果有返回 - 在屏幕上显示出来
		lnBufsize = 128		&& 读取缓冲区大小
		?
		DO WHILE .T.
			lcBuffer = REPLI (Chr(0), lnBufsize)
			lnBytesRead = 0
			IF InternetReadFile(hFile, @lcBuffer, lnBufsize,;
				@lnBytesRead) = 1
				lcBuffer = LEFT(lcBuffer, lnBytesRead)
				?? lcBuffer
				IF lnBytesRead < lnBufsize
					EXIT
				ENDIF
			ELSE
				EXIT
			ENDIF
		ENDDO
		= InternetCloseHandle (hFile)
	ENDIF
	DO ShowResponse

PROCEDURE ShowResponse
	LOCAL nError, cBuffer, nBufsize
	nBufsize = 16384
	cBuffer = Repli(Chr(0), nBufsize)
	nError = 0
	IF InternetGetLastResponseInfo(@nError, @cBuffer, @nBufsize) <> 0
		? LEFT(cBuffer, nBufsize)
	ENDIF

PROCEDURE  decl
	DECLARE INTEGER GetLastError IN kernel32
	DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessType,;
		STRING sProxyName, STRING sProxyBypass, STRING lFlags

	DECLARE INTEGER InternetConnect IN wininet;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername,;
		STRING sPassword, INTEGER lService,;
		INTEGER lFlags,INTEGER lContext

	DECLARE INTEGER FtpCommand IN wininet;
		INTEGER hConnect, INTEGER fExpectResponse,;
		INTEGER dwFlags, STRING lpszCommand,;
		STRING @dwContext, INTEGER @phFtpCommand

	DECLARE INTEGER InternetReadFile IN wininet;
		INTEGER hFile, STRING @sBuffer,;
		INTEGER lNumBytesToRead, INTEGER @dwNumberOfBytesRead

	DECLARE INTEGER InternetGetLastResponseInfo IN wininet;
		INTEGER @lpdwError, STRING @lpszBuffer,;
		INTEGER @lpdwBufferLength  
```  
***  


## 函数列表：
[FtpCommand](../libraries/wininet/FtpCommand.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetGetLastResponseInfo](../libraries/wininet/InternetGetLastResponseInfo.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  
[InternetReadFile](../libraries/wininet/InternetReadFile.md)  

## 备注：
例子修订：2003年2月24日  
  
* [RFC 765 (RFC765 ) File Transfer Protocol](http://www.faqs.org/rfcs/rfc765.html)  
* [How to use WinInet FTPCommand function from Visual Basic](http://www.planetsourcecode.com/vb/scripts/ShowCode.asp?txtCodeId=38947&lngWId=1)（译者注：链接失效）  

***  

