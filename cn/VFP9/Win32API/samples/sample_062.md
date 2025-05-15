[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 InternetWriteFile 上传文件到FTP服务器
_翻译：xinjie  2021.01.11_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。

<!-- Anatoliy --> 

## 开始之前：
<table cellspacing=3 cellpadding=0 border=0><tr><td valign=top><img src="../images/readarticle.gif" border=0></td><td valign=top class=fdescr><a href="?article=3">在Visual FoxPro中对文件传输协议进行编程</a></td></tr></table>    

  
***  

## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER 0
#DEFINE INTERNET_OPEN_TYPE_DIRECT 1
#DEFINE INTERNET_SERVICE_FTP 1
#DEFINE FTP_TRANSFER_TYPE_ASCII 1
#DEFINE FTP_TRANSFER_TYPE_BINARY 2
#DEFINE GENERIC_READ 0x80000000
#DEFINE GENERIC_WRITE 0x40000000

PUBLIC hOpen, hFtpSession
DO declare

* 选择合适的访问级别的FTP连接
* 在任何情况下，它都不可能是任何 "匿名 "的访问
IF connect2ftp("ftp.???.???", "???", "???")
	lcSourcePath = "C:\Temp\"       && 本地源目录
	lcTargetPath = "ftptest/"       && ftp目标目录
	lnFiles = ADIR(arr, lcSourcePath + "*.html")

	FOR lnCnt=1 TO lnFiles
		lcSource = lcSourcePath + LOWER(arr [lnCnt, 1])
		lcTarget = lcTargetPath + LOWER(arr [lnCnt, 1])
		? lcSource + " -> " + lcTarget
		?? local2ftp(hFtpSession, lcSource, lcTarget)
	ENDFOR

	= InternetCloseHandle(hFtpSession)
	= InternetCloseHandle(hOpen)
ENDIF

PROCEDURE declare
	DECLARE INTEGER InternetOpen IN wininet.dll;
		STRING sAgent, INTEGER lAccessType, STRING sProxyName,;
		STRING sProxyBypass, STRING lFlags

	DECLARE INTEGER InternetCloseHandle IN wininet.dll INTEGER hInet

	DECLARE INTEGER InternetConnect IN wininet.dll;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername,;
		STRING sPassword, INTEGER lService,;
		INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpOpenFile IN wininet.dll;
		INTEGER hFtpSession, STRING  sFileName,;
		INTEGER lAccess, INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER InternetWriteFile IN wininet;
		INTEGER hFile, STRING @sBuffer,;
		INTEGER lBytesToWrite, INTEGER @dwBytesWritten

FUNCTION connect2ftp(strHost, strUser, strPwd)
	* 打开访问 Inet 功能
	hOpen = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

	IF hOpen = 0
		? "无法访问 WinInet.Dll"
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hFtpSession = InternetConnect(hOpen, strHost, INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭对 Inet 功能的访问并退出
		= InternetCloseHandle(hOpen)
		? "FTP " + strHost + " 不可用"
		RETURN .F.
	ELSE
		? "连接到 " + strHost + " 用户名和密码: [" + strUser + ", *****]"
	ENDIF
RETURN .T.

FUNCTION local2ftp(hConnect, lcSource, lcTarget)
* 复制本地文件到远程目标
	hSource = FOPEN(lcSource)
	IF (hSource = -1)
		RETURN -1
	ENDIF

	* 此调用会创建一个新的远程文件
	hTarget = FtpOpenFile(hConnect, lcTarget, GENERIC_WRITE,;
		FTP_TRANSFER_TYPE_BINARY, 0)
	IF hTarget = 0
		= FCLOSE(hSource)
		RETURN -2
	ENDIF

	lnBytesWritten = 0
	lnChunkSize = 256	&& 128, 512, 16384 and so on are Ok

	DO WHILE Not FEOF(hSource)
		lcBuffer = FREAD(hSource, lnChunkSize)
		lnLength = Len(lcBuffer)
		IF lnLength > 0
			IF InternetWriteFile(hTarget, @lcBuffer, lnLength, @lnLength) = 1
				lnBytesWritten = lnBytesWritten + lnLength
				* 这时可以显示进度和测试事件：键盘、鼠标等，决定是否中止上传
				?? "�"	&& 你可以把进度条的链接放到这里来代替
			ELSE
				EXIT
			ENDIF
		ELSE
			EXIT
		ENDIF
	ENDDO
	= InternetCloseHandle(hTarget)
	= FCLOSE(hSource)
RETURN lnBytesWritten  
```  
***  


## 函数列表：
[FtpOpenFile](../libraries/wininet/FtpOpenFile.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  
[InternetWriteFile](../libraries/wininet/InternetWriteFile.md)  

## 备注：
与FtpPutFile不同的是，使用这个功能你可以控制整个上传过程。当然，这取决于您将源文件分割成多少块。 
  
在各块之间，您可以显示上传的进度。您也可以测试按下的键或其他事件，并停止上传。 
  
***  

