[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 用 FtpPutFile 上传本地文件到 FTP 服务器
_翻译：xinjie  2021.01.09_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。


## 开始之前：
<!-- Anatoliy -->
<table cellspacing=3 cellpadding=0 border=0><tr><td valign=top><img src="../images/readarticle.gif" border=0></td><td valign=top class=fdescr><a href="?article=3">在Visual FoxPro中对文件传输协议进行编程</a></td></tr></table>  
FtpPutFile在一次操作中就可以在FTP服务器上存储一个文件。您不能对文件传输进行密切的控制，您可能需要，例如，显示进度条。对于这些情况，您应该使用FtpOpenFile和InternetWriteFile函数。 

 
参考：

[使用InternetWriteFile上传文件到FTP服务器](sample_062.md).

  
***  


## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER 0
#DEFINE INTERNET_OPEN_TYPE_DIRECT 1
#DEFINE INTERNET_SERVICE_FTP 1
#DEFINE FTP_TRANSFER_TYPE_ASCII 1
#DEFINE FTP_TRANSFER_TYPE_BINARY 2
DO declare

	PRIVATE hInet, hSession
	STORE 0 TO hInet, hSession

	* 选择您有适当访问级别的FTP连接，允许上传文件到远程服务器并重命名文件。
	LOCAL cHost, cUser, cPwd
	cHost = "ftp2.server.com"
	cUser = "foxpro"
	cPwd = "qwerty"

	IF connect2ftp(cHost, cUser, cPwd)

		* 选择有效的源文件和目标文件名;
		* 源文件必须存在于本地驱动器上;
		*  请注意，下面的文件名只是例子
		LOCAL cSource, cTarget, cRenameTo
		cSource  = "c:\temp\test.txt"
		cTarget  = "test.txt"
		cRenameTo = "test.tx~"
		
		* 选择了二进制传输类型，这意味着文件将被准确地传输。
		IF FtpPutFile(hSession, cSource,;
			cTarget, FTP_TRANSFER_TYPE_BINARY, 0) = 0
			= MESSAGEBOX("上传文件失败： " + cSource +;
				" 到 " + cTarget + ".     ", 48, "错误")
		ELSE
			? "文件下载成功。"
		* 如果文件(cRenameTo)在远程服务器上已经存在，它可能会被新的文件所取代，或者你会得到一个错误信息；它随不同的FTP服务器而变化。
			IF FtpRenameFile(hSession, cTarget, cRenameTo) = 0
				= MESSAGEBOX("重命名文件失败： " + cTarget +;
					" 到 " + cRenameTo + ".     ", 48, "错误")
			ELSE
				? "文件重命名成功。"
			ENDIF
		ENDIF

		* 退出时释放资源
		= InternetCloseHandle(hSession)
		= InternetCloseHandle(hInet)
	ENDIF

FUNCTION connect2ftp(cHost, cUser, cPwd)
* 此函数可打开对Inet函数的访问

	* 第一个参数lpszAgent可以是任何字符串。
	hInet = InternetOpen(VERSION(),;
		INTERNET_OPEN_TYPE_DIRECT, 0,0,0)

	IF hInet = 0
		= MESSAGEBOX("无法打开对WinINet库的访问。     ", 48, "错误")
		RETURN .F.
	ENDIF

	WAIT WINDOW NOWAIT "Establishing connection with FTP server..."
	hSession = InternetConnect(hInet, cHost,;
		INTERNET_INVALID_PORT_NUMBER,;
		cUser, cPwd, INTERNET_SERVICE_FTP, 0,0)
	WAIT CLEAR

	IF hSession = 0
	* 退出时关闭对 WinInet 的访问
		= InternetCloseHandle(hInet)
		= MESSAGEBOX("FTP 服务器 [" + cHost +;
			"] 不能访问。     ", 48, "错误")
		RETURN .F.
	ELSE
		WAIT WINDOW NOWAIT "连接到 " + cHost +;
			" 用户名和密码: [" + cUser + ", *****]"
	ENDIF
RETURN .T.

PROCEDURE declare
	DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessType, STRING sProxyName,;
		STRING sProxyBypass, STRING lFlags

	DECLARE INTEGER InternetConnect IN wininet;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername,;
		STRING sPassword, INTEGER lService,;
		INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpPutFile IN wininet;
		INTEGER hConnect, STRING lpszLocalFile,;
		STRING lpszNewRemoteFile, INTEGER dwFlags,;
		INTEGER dwContext

	DECLARE INTEGER FtpRenameFile IN wininet;
		INTEGER hConnect, STRING lpszExisting,;
		STRING lpszNew  
```  
***  


## 函数列表：
[FtpPutFile](../libraries/wininet/FtpPutFile.md)  
[FtpRenameFile](../libraries/wininet/FtpRenameFile.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  

## 备注：
请注意，您只能在您有足够访问级别的FTP服务器上测试这个例子。  
  
***  

