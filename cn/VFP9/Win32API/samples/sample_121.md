[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 枚举在网络上打开的文件

_翻译：xinjie  2020.01.29_

## 请注意，本文档包含一些指向旧版 news2news 网站的链接，这些链接目前无法使用。 该材料将在未来的某个时间提供。

## 开始之前：
用法：  
```foxpro
LOCAL oFiles As TOpenFiles, oFile As TOpenFile  
oFiles = CREATEOBJECT("TOpenFiles", "SOME_SERVER")  

CREATE CURSOR csFiles (fileid I, permissions I, numlocks I,;  
	username C(32), pathname C(250))  

FOR EACH oFile IN oFiles  
	WITH oFile  
		INSERT INTO csFiles (fileid, permissions, numlocks,;  
			username, pathname);  
		VALUES (.fileid, .permissions, .numlocks,;  
			FromUnicode(.username),;  
			FromUnicode(.pathname))  
	ENDWITH  
NEXT  

SELECT csFiles  
GO TOP  
BROWSE NORMAL NOWAIT
```
参看：

<!-- Anatoliy -->
* [用于 Visual FoxPro 的 FileSystemWatcher ActiveX 控件](?solution=8)   
* [监视目录中的更改](sample_117.md)  
* [枚举服务器上的全局和本地组帐户](sample_411.md)  
* [获取当前用户的本地和全局组的名称](sample_431.md)  
* [如何枚举、添加和删除本地计算机上的共享](sample_351.md)  
* [枚举在服务器上建立的会话](sample_505.md)  

  
***  


## 代码：
```foxpro  
DEFINE CLASS TOpenFiles As Collection
#DEFINE MAX_PREFERRED_LENGTH -1
	servername=NULL
	username=NULL
	basepath=NULL

PROCEDURE Init(cServerName, cUserName, cBasePath)
	THIS.declare
	THIS.servername = IIF(EMPTY(cServerName), NULL, cServerName)
	THIS.username = IIF(EMPTY(cUserName), NULL, cUserName)
	THIS.basepath = IIF(EMPTY(cBasePath), NULL, cBasePath)
	THIS.EnumOpenFiles

PROCEDURE EnumOpenFiles
* enumerates files open on the server
	DO WHILE THIS.Count > 0
		THIS.Remove(1)
	ENDDO
	
	LOCAL nResult, hBuffer, nReadCnt, nTotalCnt,;
		nResume, nIndex, cBuffer, nBufsize

	STORE 0 TO hBuffer, nReadCnt, nTotalCnt, nResume

	* 5 = ERROR_ACCESS_DENIED
	* 53 = ERROR_BAD_NETPATH
	* 123 = ERROR_INVALID_NAME
	* 1113 = ERROR_NO_UNICODE_TRANSLATION

	nResult = NetFileEnum(ToUnicode(THIS.servername),;
		ToUnicode(THIS.basepath), ToUnicode(THIS.username),;
		3, @hBuffer, MAX_PREFERRED_LENGTH,;
		@nReadCnt, @nTotalCnt, @nResume)

	IF m.hBuffer = 0 OR m.nReadCnt=0
		RETURN
	ENDIF

	nBufsize = GlobalSize(hBuffer)
	cBuffer = REPLICATE(CHR(0), nBufsize)
	= MemToStr(@cBuffer, hBuffer, nBufsize)

	FOR nIndex=1 TO m.nReadCnt
		LOCAL oFile As TOpenFile, hPath, hUser
		oFile = CREATEOBJECT("TOpenFile")
		WITH oFile
			.fileid = buf2dword(SUBSTR(cBuffer, (nIndex-1)*20 + 1, 4))
			.permissions = buf2dword(SUBSTR(cBuffer, (nIndex-1)*20 + 5, 4))
			.numlocks = buf2dword(SUBSTR(cBuffer, (nIndex-1)*20 + 9, 4))

			hPath = buf2dword(SUBSTR(cBuffer, (nIndex-1)*20 + 13, 4))
			.pathname = GetStrFromMem(@cBuffer, hPath-hBuffer+1)

			hUser = buf2dword(SUBSTR(cBuffer, (nIndex-1)*20 + 17, 4))
			.username = GetStrFromMem(@cBuffer, hUser-hBuffer+1)
		ENDWITH
		THIS.Add(oFile)
		oFile=NULL
	NEXT

	= NetApiBufferFree(hBuffer)

PROCEDURE declare
	DECLARE INTEGER NetApiBufferFree IN netapi32 INTEGER buf
	DECLARE INTEGER GlobalSize IN kernel32 INTEGER hMem

	DECLARE RtlMoveMemory IN kernel32 As MemToStr;
		STRING @dst, INTEGER src, INTEGER nLength

	DECLARE INTEGER NetFileEnum IN netapi32;
		STRING servername, STRING basepath, STRING username,;
		INTEGER lvl, INTEGER @bufptr, INTEGER prefmaxlen,;
		INTEGER @entriesread, INTEGER @totalentries,;
		INTEGER @resume

ENDDEFINE

DEFINE CLASS TOpenFile As Relation
	fileid=0
	permissions=0
	numlocks=0
	pathname=NULL
	username=NULL
ENDDEFINE

FUNCTION GetStrFromMem(cBuffer, nOffset)
	LOCAL cResult, ch
	cResult=""
	DO WHILE nOffset < LEN(cBuffer)
		ch = SUBSTR(m.cBuffer, m.nOffset, 2)
		IF m.ch = CHR(0) + CHR(0)
			EXIT
		ENDIF
		cResult = m.cResult + m.ch
		nOffset = m.nOffset + 2
	ENDDO
RETURN m.cResult

FUNCTION ToUnicode(cStr As String) As String
RETURN STRCONV(NVL(m.cStr,"")+CHR(0),5)

FUNCTION FromUnicode(cStr As String) As String
RETURN STRCONV(m.cStr,6)

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[GlobalSize](../libraries/kernel32/GlobalSize.md)  
[NetApiBufferFree](../libraries/netapi32/NetApiBufferFree.md)  
[NetFileEnum](../libraries/netapi32/NetFileEnum.md)  

## 备注：
2007 年 5 月 24 日：从头开始重写 
  
只有 Administrators 或 Server Operators 本地组的成员才能成功执行 NetFileEnum 函数。
  
以下是此代码示例返回的数据示例： 

![](../images/netfileenum_usage.png)

FILE_INFO_3 结构中文件锁的数量与 VFP 表或数据库是以独占模式还是共享模式打开无关。 该结构成员显示为零。
  
对于 RPC 通信，服务器服务打开命名管道 SRVSVC。  
  
* * *  
阅读 <a href="http://fox.wikis.com/wc.dll?Wiki~RLOCK">VFP Wiki 上的 RLOCK 主题</a> 来了解 VFP 如何锁定表记录。  
  
***  

