LPARAMETERS pcUrlName, tcDownloadDestinationFile 

DECLARE INTEGER InternetOpen IN wininet.DLL STRING sAgent, ;
      INTEGER lAccessType, STRING sProxyName, ;
      STRING sProxyBypass, INTEGER lFlags
 
DECLARE INTEGER InternetOpenUrl IN wininet.DLL ;
   INTEGER hInternetSession, STRING sUrl, STRING sHeaders,;
   INTEGER lHeadersLength, INTEGER lFlags, INTEGER lContext
 
DECLARE INTEGER InternetReadFile IN wininet.DLL INTEGER hfile, ;
      STRING @sBuffer, INTEGER lNumberofBytesToRead, INTEGER @lBytesRead
 
DECLARE short InternetCloseHandle IN wininet.DLL INTEGER hInst
 
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG 0
#DEFINE INTERNET_OPEN_TYPE_DIRECT 1
#DEFINE INTERNET_OPEN_TYPE_PROXY 3
#DEFINE SYNCHRONOUS 0
#DEFINE INTERNET_FLAG_RELOAD 2147483648
#DEFINE CR CHR(13)
 
local lsAgent, lhInternetSession, lhUrlFile, llOk, lnOk, lcRetVal, lcReadBuffer, lnBytesRead
 
ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow",  [正在连接服务器.... 请等待。] ) 

*--- 2011-11-02 M. Slay: Added this guard against empty parameters being passed
If Empty(pcUrlName) or Empty(tcDownloadDestinationFile)
	llReturn = .f.
	Execscript (_Screen.cThorDispatcher, 'Result=', llReturn)
	Return llReturn
EndIf

*--- 2011-11-02: Added support for expanding Bitly URL to long URL
If 'http://bit.ly' $ lower(pcUrlName)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog',  [展开 bitly 链接 【]  + pcUrlName + '】')
	pcUrlName = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_Expand_Bitly_Url', pcUrlName)
	If !Empty(pcUrlName)
		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog',  [展开 bitly 链接 【]  + pcUrlName + '】')	
	Endif
EndIf
			
If Empty(pcUrlName)
	lcMessage =  [所请求的 URL 是一个空字符串。] 
	ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow", lcMessage)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', lcMessage)	
	llReturn = .f.
	Execscript (_Screen.cThorDispatcher, 'Result=', llReturn)
	Return llReturn
Endif

If '?' $ pcUrlName
     lcUrl = pcUrlName + '&' + Sys(2015)
Else
     lcUrl = pcUrlName + '?=' + Sys(2015)
EndIf

 *-- what application is using Internet services?
lsAgent = "VPF 5.0"
  
lhInternetSession = InternetOpen(lsAgent, INTERNET_OPEN_TYPE_PRECONFIG, '', '', SYNCHRONOUS)
 
*-- debugging line - uncomment to see session handle
*-- WAIT WINDOW "Internet session handle: " + LTRIM(STR(lhInternetSession))
 
IF lhInternetSession = 0
	lcMessage =  [互联网会话无法建立] 
	ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow", lcMessage)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', lcMessage)	
	llReturn = .f.
	Execscript (_Screen.cThorDispatcher, 'Result=', llReturn)
	Return llReturn
Else
	lcMessage =  [正在请求文件 ]  + JustFname(pcUrlName) +  [ 从服务器] 
	ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow", lcMessage)
	lcMessage =  [正在请求文件 ]  + JustFname(lcUrl) +  [ 从服务器] 
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', lcMessage)	
ENDIF
 
 lhUrlFile = InternetOpenUrl(lhInternetSession, lcUrl, '', 0, INTERNET_FLAG_RELOAD, 0)
 
*-- debugging line - uncomment to see URL handle
*-- WAIT WINDOW "URL Handle: " + LTRIM(STR(lhUrlFile))
 
IF lhUrlFile = 0
	lcMessage =  [URL 不能打开] 
	ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow", lcMessage)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', lcMessage)	
	llReturn = .f.
	Execscript (_Screen.cThorDispatcher, 'Result=', llReturn)
	Return llReturn
Else
	lcMessage =  [正在下载...] 
	ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow", lcMessage)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', lcMessage)	
ENDIF
 
lcRetVal = ""
llOk = .t.
 
DO WHILE llOK
   *-- set aside a big buffer
   lsReadBuffer = SPACE(32767)
   lnBytesRead = 0
   lnOK = InternetReadFile(lhUrlFile, @lsReadBuffer, LEN(lsReadBuffer), @lnBytesRead)
 
   if (lnBytesRead > 0)
      lcRetVal = lcRetVal + left(lsReadBuffer, lnBytesRead)
   endif
 
   *-- error trap - either a read failure or read past eof()
   llOk = (lnOK = 1) and (lnBytesRead > 0)
ENDDO
 
*--close all the handles we opened
InternetCloseHandle(lhUrlFile)
InternetCloseHandle(lhInternetSession)
 
Try
	Erase (tcDownloadDestinationFile)
	StrToFile(lcRetVal, tcDownloadDestinationFile,0)
	llReturn = .t.
	lcMessage =  [下载完成。] 
Catch
	llReturn = .f.
	lcMessage =  [在下载或保存过程中出现错误。] 
Endtry
	
ExecScript(_Screen.cThorDispatcher, "Thor_Proc_UpdateWaitWindow", lcMessage)
Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', lcMessage)	
Execscript (_Screen.cThorDispatcher, 'Result=', llReturn)
Return llReturn

