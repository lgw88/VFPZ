[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 InternetReadFile 从 FTP 服务器下载文件
_翻译：xinjie  2021.01.11_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。

<!-- Anatoliy -->  
## 开始之前：
<table cellspacing=3 cellpadding=0 border=0><tr><td valign=top><img src="../images/readarticle.gif" border=0></td><td valign=top class=fdescr><a href="?article=3">在Visual FoxPro中对文件传输协议进行编程</a></td></tr></table>  
确保源文件和目标文件是有效的。 
  

***  

## 代码：
```foxpro  
#DEFINE INTERNET_INVALID_PORT_NUMBER   0
#DEFINE INTERNET_OPEN_TYPE_DIRECT      1
#DEFINE INTERNET_SERVICE_FTP           1
#DEFINE FTP_TRANSFER_TYPE_ASCII        1
#DEFINE FTP_TRANSFER_TYPE_BINARY       2
#DEFINE INTERNET_FLAG_NEED_FILE       16
#DEFINE FILE_ATTRIBUTE_DIRECTORY      16

#DEFINE GENERIC_READ  0x80000000
#DEFINE GENERIC_WRITE  0x40000000

	PUBLIC hOpen, hFtpSession
    DO decl

	IF connect2ftp ("ftp.???.???", "???", "???")
		lcMask = "*.htm"
		lcRemotePath = "prj/pages/"
		lcLocalPath  = "C:\temp\"
		DIMEN arr [1, 3]

		FOR ii=1 TO remoteDir2array (hFtpSession, lcRemotePath, lcMask, @arr)
			lcRemoteFile = arr [ii, 1]
			lcSource = lcRemotePath+lcRemoteFile
			lcTarget = lcLocalPath+lcRemoteFile
			? lcSource + " -> " + lcTarget
			?? ftp2local (hFtpSession, lcSource, lcTarget)
		ENDFOR

		= InternetCloseHandle (hFtpSession)
		= InternetCloseHandle (hOpen)
	ENDIF

PROCEDURE  decl
	DECLARE INTEGER InternetOpen IN wininet.dll;
		STRING sAgent, INTEGER lAccessType, STRING sProxyName,;
		STRING sProxyBypass, STRING lFlags

    DECLARE INTEGER InternetCloseHandle IN wininet.dll INTEGER hInet

    DECLARE INTEGER InternetConnect IN wininet.dll;
		INTEGER hInternetSession, STRING sServerName,;
		INTEGER nServerPort, STRING sUsername, STRING sPassword,;
		INTEGER lService, INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER FtpFindFirstFile IN wininet.dll;
		INTEGER hFtpSession, STRING lpszSearchFile,;
		STRING @lpFindFileData, INTEGER dwFlags, INTEGER dwContent

	DECLARE INTEGER InternetFindNextFile IN wininet.dll;
		INTEGER hFind, STRING @lpvFindData

	DECLARE INTEGER FtpGetCurrentDirectory IN wininet.dll;
		INTEGER hFtpSession, STRING @lpszDirectory,;
		INTEGER @lpdwCurrentDirectory

	DECLARE INTEGER FtpSetCurrentDirectory IN wininet.dll;
		INTEGER hFtpSession, STRING @lpszDirectory

	DECLARE INTEGER FtpOpenFile IN wininet.dll;
		INTEGER hFtpSession, STRING  sFileName, INTEGER lAccess,;
		INTEGER lFlags, INTEGER lContext

	DECLARE INTEGER InternetReadFile IN wininet.dll;
		INTEGER hFile, STRING @lpBuffer,;
		INTEGER dwNumberOfBytesToRead, INTEGER @lpdwNumberOfBytesRead

	DECLARE INTEGER FileTimeToSystemTime IN kernel32.dll;
		STRING @lpFileTime, STRING @lpSystemTime
RETURN

FUNCTION  connect2ftp (strHost, strUser, strPwd)
	* 打开访问 Inet 功能
	hOpen = InternetOpen ("vfp", INTERNET_OPEN_TYPE_DIRECT, 0, 0, 0)

	IF hOpen = 0
		? "无法访问 WinInet.Dll"
		RETURN .F.
	ENDIF

	* 连接到 FTP
	hFtpSession = InternetConnect (hOpen, strHost,;
		INTERNET_INVALID_PORT_NUMBER,;
		strUser, strPwd, INTERNET_SERVICE_FTP, 0, 0)

	IF hFtpSession = 0
	* 关闭对 Inet 功能的访问并退出
		= InternetCloseHandle (hOpen)
		? "FTP " + strHost + " 不可用"
		RETURN .F.
	ELSE
		? "连接到 " + strHost + " 用户名和密码: [" + strUser + ", *****]"
	ENDIF
RETURN .T.

FUNCTION  setCurrentDir (hConnection, lcNewdir)
RETURN FtpSetCurrentDirectory (hConnection, @lcNewdir) = 1

FUNCTION  getCurrentDir (hConnection)
	lcDirectory = SPACE(250)
	lnLen = Len(lcDirectory)

	IF FtpGetCurrentDirectory (hConnection, @lcDirectory, @lnLen) = 1
		RETURN LEFT(lcDirectory, lnLen)
	ELSE
		RETURN ""
	ENDIF
	
FUNCTION  remoteDir2array (hConnection, lcRemotePath, lcMask, arr)
* 用给定的远程路径的文件数据填充数组。

	lcStoredPath = getCurrentDir (hConnection)
	IF Not setCurrentDir (hConnection, lcRemotePath)
		RETURN -1	&& 路径不存在
	ENDIF

	* 用对象模拟结构
	struct = CREATEOBJECT ("struct_WIN32_FIND_DATA")

	* 找到第一个文件
	lnFound = 0
	lpFindFileData = REPLI (Chr(0), 320)
	hFind = FtpFindFirstFile (hConnection, lcMask,;
		@lpFindFileData, INTERNET_FLAG_NEED_FILE, 0)

	IF hFind <> 0
		DO WHILE .T.
			struct.setValue (lpFindFileData)
			IF Not struct.isDirectory()
				lnFound = lnFound + 1
				DIMEN arr [lnFound, 3]
				arr [lnFound, 1] = struct.fileName
				arr [lnFound, 2] = struct.fileSizeLo
				arr [lnFound, 3] = struct.lastWriteTime
			ENDIF

			IF InternetFindNextFile (hFind, @lpFindFileData) <> 1
				EXIT
			ENDIF
		ENDDO
		= InternetCloseHandle (hFind)
	ENDIF
	RELEASE struct
	= setCurrentDir (hConnection, lcStoredPath)
RETURN  lnFound

FUNCTION ftp2local (hConnect, lcSource, lcTarget)
	hTarget = FCREATE (lcTarget)
	IF (hTarget = -1)
		RETURN -1
	ENDIF

	hSource = FtpOpenFile(hConnect, lcSource,;
		GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)
	IF hSource = 0
		= FCLOSE (hTarget)
		RETURN -2
	ENDIF

	lnBytesRead = 0
	lnChunkSize = 4096	&& 256、512甚至16384都是不错的选择
	
	DO WHILE .T.
		lcBuffer = REPLI (Chr(0), lnChunkSize)
		lnLength = Len (lcBuffer)
		IF InternetReadFile (hSource, @lcBuffer, lnLength, @lnLength) = 1
			= FWRITE (hTarget, lcBuffer, lnLength)
			lnBytesRead = lnBytesRead + lnLength
			?? "�"
			IF lnLength < lnChunkSize
				EXIT
			ENDIF
		ELSE
			EXIT
		ENDIF
	ENDDO

	= InternetCloseHandle (hSource)
	= FCLOSE (hTarget)
RETURN  lnBytesRead

DEFINE CLASS struct_WIN32_FIND_DATA As Custom
*该类模拟WIN32_FIND_DATA结构。
	value            = ""
	fileAttributes   = 0
	creationTimeLo   = 0
	creationTimeHi   = 0
	lastAccessTimeHi = 0
	lastAccessTimeLo = 0
	lastWriteTimeHi  = 0
	lastWriteTimeLo  = 0
	fileSizeLo	     = 0 && fileSizeHi omitted
	fileName         = ""
	creationTime     = CTOT ("")
	lastAccessTime   = CTOT ("")
	lastWriteTime    = CTOT ("")

PROCEDURE  setValue (lcValue)	
* 将缓冲区的内容转换为对象的属性。
	THIS.value            = lcValue
	THIS.fileAttributes   = THIS.buf2num (THIS.value,  0, 4)
	THIS.creationTimeLo   = THIS.buf2num (THIS.value,  4, 4)
	THIS.creationTimeHi   = THIS.buf2num (THIS.value,  8, 4)
	THIS.lastAccessTimeHi = THIS.buf2num (THIS.value, 12, 4)
	THIS.lastAccessTimeLo = THIS.buf2num (THIS.value, 16, 4)
	THIS.lastWriteTimeHi  = THIS.buf2num (THIS.value, 20, 4)
	THIS.lastWriteTimeLo  = THIS.buf2num (THIS.value, 24, 4)
	THIS.fileSizeLo	      = THIS.buf2num (THIS.value, 32, 4)
	THIS.creationTime     = THIS.ftime2dtime (SUBSTR(THIS.value,  5, 8))
	THIS.lastAccessTime   = THIS.ftime2dtime (SUBSTR(THIS.value, 13, 8))
	THIS.lastWriteTime    = THIS.ftime2dtime (SUBSTR(THIS.value, 21, 8))

	THIS.fileName		  = ALLTRIM(SUBSTR(THIS.value, 45,250))
	IF AT(Chr(0), THIS.fileName) <> 0
		THIS.fileName = SUBSTR (THIS.fileName, 1, AT(Chr(0), THIS.fileName)-1)
	ENDIF
ENDPROC

FUNCTION  isDirectory
	RETURN BitAnd (THIS.fileAttributes,;
		FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY
ENDFUNC

PROTECTED FUNCTION  buf2num (lcBuffer, lnOffset, lnBytes)
* 将缓冲区中的N个字节转换为一个数值。
	lnResult = 0
	FOR ii=1 TO lnBytes
		lnResult = lnResult +;
			BitLShift(Asc(SUBSTR (lcBuffer, lnOffset+ii, 1)), (ii-1)*8)
	ENDFOR
RETURN  lnResult

PROTECTED FUNCTION  ftime2dtime (lcFileTime)
	lcSystemTime = REPLI (Chr(0), 16)
	= FileTimeToSystemTime (@lcFileTime, @lcSystemTime)

	wYear   = THIS.buf2num (lcSystemTime,  0, 2)
	wMonth  = THIS.buf2num (lcSystemTime,  2, 2)
	wDay    = THIS.buf2num (lcSystemTime,  6, 2)
	wHour   = THIS.buf2num (lcSystemTime,  8, 2)
	wMinute = THIS.buf2num (lcSystemTime, 10, 2)
	wSecond = THIS.buf2num (lcSystemTime, 12, 2)

	lcStoredSet = SET ("DATE")
	SET DATE TO MDY
	lcDate = STRTRAN (STR(wMonth,2) + "/" +;
		STR(wDay,2) + "/" + STR(wYear,4), " ","0")

	lcTime = STRTRAN (STR(wHour,2) + ":" +;
		STR(wMinute,2) + ":" + STR(wSecond,2), " ","0")

	ltResult = CTOT (lcDate + " " + lcTime)
	SET DATE TO &lcStoredSet
RETURN  ltResult
ENDDEFINE  
```  
***  


## 函数列表：
[FileTimeToSystemTime](../libraries/kernel32/FileTimeToSystemTime.md)  
[FtpFindFirstFile](../libraries/wininet/FtpFindFirstFile.md)  
[FtpGetCurrentDirectory](../libraries/wininet/FtpGetCurrentDirectory.md)  
[FtpOpenFile](../libraries/wininet/FtpOpenFile.md)  
[FtpSetCurrentDirectory](../libraries/wininet/FtpSetCurrentDirectory.md)  
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetConnect](../libraries/wininet/InternetConnect.md)  
[InternetFindNextFile](../libraries/wininet/InternetFindNextFile.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  
[InternetReadFile](../libraries/wininet/InternetReadFile.md)  


***  

