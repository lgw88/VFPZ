[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索互联网连接的状态
_翻译：xinjie  2021.01.11_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。

<!-- Anatoliy --> 
## 开始之前：
<table cellspacing=3 cellpadding=0 border=0><tr><td valign=top><img src="../images/readarticle.gif" border=0></td><td valign=top class=fdescr><a href="?article=3">在Visual FoxPro中对文件传输协议进行编程</a></td></tr></table>  

  
***  

## 代码：
```foxpro  
#DEFINE INTERNET_CONNECTION_MODEM        1
#DEFINE INTERNET_CONNECTION_LAN          2
#DEFINE INTERNET_CONNECTION_PROXY        4
#DEFINE INTERNET_CONNECTION_MODEM_BUSY   8
#DEFINE INTERNET_RAS_INSTALLED          16
#DEFINE INTERNET_CONNECTION_OFFLINE     32
#DEFINE INTERNET_CONNECTION_CONFIGURED  64

	DECLARE SHORT InternetGetConnectedState IN wininet.dll;
		INTEGER @lpdwFlags, INTEGER dwReserved

	DECLARE SHORT InternetGetConnectedStateEx IN wininet.dll;
    	INTEGER @lpdwFlags, STRING @lpszConnectionName,;
    	INTEGER dwNameLen, INTEGER dwReserved

	DO displayState
	DO displayStateEx
RETURN

PROCEDURE  displayState
	? "*** InternetGetConnectedState:"
	lpdwFlags = 0
	IF InternetGetConnectedState (@lpdwFlags, 0) = 1
		? "  返回的标志:       " +;
			LTRIM(STR(lpdwFlags))

		? "  调制解调器连接:     " +;
			_ok(lpdwFlags, INTERNET_CONNECTION_MODEM)

		? "  局域网连接:       " +;
			_ok(lpdwFlags, INTERNET_CONNECTION_LAN)

		? "  代理连接:     " +;
			_ok(lpdwFlags, INTERNET_CONNECTION_PROXY)

		? "  调制解调器忙:    " +;
			_ok(lpdwFlags, INTERNET_CONNECTION_MODEM_BUSY)

		? "  安装了RAS: " +;
			_ok(lpdwFlags, INTERNET_RAS_INSTALLED)

		? "  脱机连接:   " +;
			_ok(lpdwFlags, INTERNET_CONNECTION_OFFLINE)

		? "  已配置:        " +;
			_ok(lpdwFlags, INTERNET_CONNECTION_CONFIGURED)
	ELSE
		? "InternetGetConnectedState error"
	ENDIF
RETURN

PROCEDURE  displayStateEx
* 除返回连接名称外，与常规连接相同
	?
	? "*** InternetGetConnectedStateEx:"
	lpdwFlags = 0
	lcConnection = REPLI (Chr(0), 250)
	IF InternetGetConnectedStateEx (@lpdwFlags,;
		@lcConnection, Len(lcConnection), 0) = 1

		? "  返回的标志:       " + LTRIM(STR(lpdwFlags))
		? "  连接名: " +;
			SUBSTR (lcConnection, 1, AT(Chr(0), lcConnection)-1)
	ELSE
		? "InternetGetConnectedStateEx error"
	ENDIF
RETURN

FUNCTION  _ok (lnBase, lnValue)
RETURN  Iif(BitAnd(lnBase, lnValue)=lnValue, "Yes","No")  
```  
***  


## 函数列表：
[InternetGetConnectedState](../libraries/wininet/InternetGetConnectedState.md)  
[InternetGetConnectedStateEx](../libraries/wininet/InternetGetConnectedStateEx.md)  

## 备注：
远程访问服务（RAS）使用Microsoft＆reg 对计算机上的客户端应用程序提供远程访问功能。 Windows＆reg; 95或更高版本以及Windows NT＆reg; 3.5版和更高版本（包括Windows 2000）操作系统。  
  
***  

