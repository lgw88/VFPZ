[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 打开对应用程序的 Microsoft Internet 功能的访问
_翻译：xinjie  2021.01.05_

## 代码：
```foxpro  
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG 0
#DEFINE INTERNET_OPEN_TYPE_DIRECT 1
#DEFINE INTERNET_OPEN_TYPE_PROXY 3
#DEFINE INTERNET_FLAG_ASYNC 0x10000000
#DEFINE INTERNET_FLAG_FROM_CACHE 0x1000000
#DEFINE INTERNET_FLAG_OFFLINE 0x1000000
#DEFINE INTERNET_FLAG_CACHE_IF_NET_FAIL 0x10000

DECLARE INTEGER InternetOpen IN wininet;
	STRING sAgent, INTEGER lAccessType,;
	STRING sProxyName, STRING sProxyBypass,;
	STRING lFlags
	
DECLARE INTEGER InternetCloseHandle IN wininet INTEGER hInet

sAgent = "w32inetopen"  && 你可以选择任何名字，比如 "John Dow"
sProxyName = Chr(0)     && 无代理
sProxyBypass = Chr(0)   && nothing to bypass
lFlags = 0              && 没有使用标志

hOpen = InternetOpen(sAgent, INTERNET_OPEN_TYPE_DIRECT,;
	sProxyName, sProxyBypass, lFlags)

IF hOpen <> 0
* 关闭通道
	? "检索到的句柄:", hOpen
	= InternetCloseHandle (hOpen)
ELSE
	? "访问 WinINet 库失败"
ENDIF  
```  
***  


## 函数列表：
[InternetCloseHandle](../libraries/wininet/InternetCloseHandle.md)  
[InternetOpen](../libraries/wininet/InternetOpen.md)  

## 备注：
实际上，此代码不执行任何操作。 它仅显示了如何使用Internet功能来访问HTTP，FTP等。  
  
***  

