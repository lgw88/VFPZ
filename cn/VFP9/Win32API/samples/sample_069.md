[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何检索远程文件的大小(FTP)
_翻译；xinjie  2021.01.13_

## 开始之前：
参考：

* [使用 GetFileSize](sample_114.md)  
  
***  


## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER   0
#DEFINE INTERNET_OPEN_TYPE_DIRECT      1
#DEFINE INTERNET_SERVICE_FTP           1
#DEFINE FTP_TRANSFER_TYPE_ASCII        1
#DEFINE FTP_TRANSFER_TYPE_BINARY       2

#DEFINE GENERIC_READ 0x80000000
#DEFINE GENERIC_WRITE 0x40000000

    PUBLIC hOpen, hFtpSession
    DO declare

	IF connect2ftp ("ftp.???.???", "???", "???")
		lcRemoteFile = "fpttest/win32api.txt"

		hFile = FtpOpenFile(hFtpSession, lcRemoteFile,;
				GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)

		IF hFile <> 0
			LOCAL lnSizeHigh
			lnSizeHigh = 0
			? "远程文件大小:", FtpGetFileSize (hFile, @lnSizeHigh)
			= InternetCloseHandle (hFile)
		ENDIF

		= InternetCloseHandle (hFtpSession)
		= InternetCloseHandle (hOpen)
	ENDIF

PROCEDURE declare
	DECLARE INTEGER InternetOpen IN wininet;
		STRING sAgent, INTEGER lAccessType,;
		STRING sProxyName, STRING sProxyBypass, STRING lFlags
	
	DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

	DECLARE INTEGER InternetConnect IN wininet;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername, STRING sPassword,;
		INTEGER lService, INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpOpenFile IN wininet;
		INTEGER hFtpSession, STRING sFileName,;
		INTEGER lAccess, INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpGetFileSize IN wininet;
		INTEGER hFile, INTEGER @lpdwFileSizeHigh
RETURN

FUNCTION  connect2ftp (strHost, strUser, strPwd)
	* 开放Inet功能的访问
	hOpen = InternetOpen ("w32rmsize",;
			INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

	IF hOpen = 0
		? "无法访问 WinInet.Dll"
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hFtpSession = InternetConnect (hOpen, strHost,;
		INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭 Inet 的访问并退出
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
[FtpGetFileSize](../libraries/wininet/FtpGetFileSize.md)  
[FtpOpenFile](../libraries/wininet/FtpOpenFile.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  

## 备注：
代码不处理高阶部分*lpdwFileSizeHigh*。为了获得大于4GBytes的文件大小，请处理这部分。 
  
* * *  
2013年7月8日：<a href="http://msdn.microsoft.com/zh-cn/library/system.net.webrequestmethods.ftp.getfilesize.aspx"> WebRequestMethods.Ftp.GetFileSize </a>失败 错误550：在ASCII模式下不允许使用SIZE。
   
显然，没有办法使FtpWebRequest变为<a href ="http://social.msdn.microsoft.com/Forums/en-US/0c38814e-d8e3-49f3-8818-b5306cc100ce/ftpwebrequestusebinary-does-not-work">send the TYPE I command before the SIZE</a>？
***  

