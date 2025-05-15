[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# Wininet 最后的错误描述
_翻译：xinjie  2021.06.16_

## 代码：
```foxpro  
#DEFINE ERROR_INSUFFICIENT_BUFFER   122

	DECLARE SHORT InternetGetLastResponseInfo IN wininet;
		INTEGER @ lpdwError,;
		STRING  @ lpszBuffer,;
		INTEGER @ lpdwBufferLength

	DECLARE INTEGER GetLastError IN kernel32

	LOCAL lpdwError, lpdwBufferLength, lpszBuffer, lnResult

	lpdwError = 0
	lpdwBufferLength = 250
	lpszBuffer = SPACE(lpdwBufferLength)
	
	lnResult = InternetGetLastResponseInfo (@lpdwError,;
			@lpszBuffer, @lpdwBufferLength)

	IF lnResult = 0 And GetLastError() = ERROR_INSUFFICIENT_BUFFER
		lpszBuffer = SPACE(lpdwBufferLength)
		lnResult = InternetGetLastResponseInfo (@lpdwError,;
				@lpszBuffer, @lpdwBufferLength)
	ENDIF

	IF lnResult = 1
		? "错误：", lpdwError
		? "消息：", LEFT(lpszBuffer, lpdwBufferLength)
	ELSE
		? "没有响应"
	ENDIF
RETURN  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[InternetGetLastResponseInfo](../libraries/wininet/InternetGetLastResponseInfo.md)  

## 备注：
这个过程在调用它的线程上检索最后一个Microsoft&reg; Win32&reg; Internet函数的错误描述或服务器响应。 
  
除非你有一个与服务器的连接，否则不要期待这个函数的任何有效响应。 
  
  
***  

