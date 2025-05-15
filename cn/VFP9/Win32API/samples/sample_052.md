[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何建立 UDP 应答器
_翻译：xinjie  2021.01.07_

## 开始之前：
目标是创建一个 VFP 应用程序，用于接收来自客户端的 UDP 数据包，并使用从初始数据包中获得的 IP 地址和端口对同一客户端进行响应。recvfrom 调用填充的*sockaddr*结构包含了所需信息。 

UdpBase 类使用了多个 Winsock API 函数。它实现了基本的功能，比如创建一个 UDP 套接字，并将其绑定到一个本地端口。之后，该类就可以使用这个套接字来发送和接收数据报。 

该类的 WaitForRequest 方法无限期地等待传入的数据包。一旦收到数据包，它就会向客户端发送消息。 

```foxpro
DEFINE CLASS UdpServer As UdpBase  

PROCEDURE WaitForRequest(nPort)  
	IF NOT THIS.StartServer(nPort)  
		RETURN .F.  
	ELSE  
		? "等待收到的请求 " +;  
			THIS.LocalIP + ":" +;  
			TRANSFORM(THIS.LocalPort) + "..."  
	ENDIF  

	* 无限期地等待来自客户端的请求  
	* 在本地ip地址和nPort中指定的端口上  
	THIS.ReceiveDatagram  

	IF EMPTY(THIS.SenderIP) OR EMPTY(THIS.SenderPort)  
	* 未能得到回应或   
	* 在定义响应源时  
		RETURN .F.  
	ELSE  
	* 显示收到的请求  
		? "收到的请求来自 " + THIS.SenderIP +;  
			":" + TRANSFORM(THIS.SenderPort)  
		? THIS.DataReceived  
	ENDIF  

	* 汇集数据发回客户端  
	LOCAL cConfirmation  
	cConfirmation = "应答器: " + SYS(0) +;  
		" " + TTOC(DATETIME())  

	* 将数据发回给客户 
	* 客户端应该处于监听模式  
	THIS.SendDatagram(m.cConfirmation,;  
		THIS.SenderIP, THIS.SenderPort)  

ENDDEFINE
```
参考：

* [如何创建无阻塞的 Winsock 服务器](sample_412.md)  
  
***  


## 代码：
```foxpro  
#DEFINE AF_INET 2
#DEFINE SOCK_DGRAM 2
#DEFINE IPPROTO_UDP 17
#DEFINE SOCKET_ERROR -1
#DEFINE INVALID_SOCKET 0
#DEFINE WSADATA_SIZE 398
#DEFINE WS_VERSION 0x0202
#DEFINE SOMAXCONN 0x7FFFFFFF

DEFINE CLASS UdpClient As UdpBase

PROCEDURE SendRequest(nLocalPort, cData, cRemoteIP, nRemotePort)
	IF NOT THIS.StartServer(nLocalPort)
		= MESSAGEBOX(TRANSFORM(THIS.errorno) + ". " +;
			THIS.errormessage + "     ", 48,;
			"在端口上创建 UDP 套接字失败 " +;
			TRANSFORM(m.nLocalPort))
		RETURN .F.
	ENDIF

	* 将数据发送到由cRemoteIP、nRemotePort指定的服务器。
	* 服务器应该处于监听模式
	THIS.SendDatagram(m.cData, cRemoteIP, nRemotePort)
	
	* 无限期地等待服务器的响应
	* 在本地IP地址和nLocalPort中指定的端口上
	THIS.ReceiveDatagram

	IF EMPTY(THIS.SenderIP) OR EMPTY(THIS.SenderPort)
	* 未能获得响应或未能定义响应的来源
		= MESSAGEBOX(TRANSFORM(THIS.errorno) + ". " +;
			THIS.errormessage + "     ", 48, "Error")
		EXIT
	ELSE
	* 显示收到的回复
		? "收到回应 " +;
			THIS.SenderIP + ":" + TRANSFORM(THIS.SenderPort)
		? THIS.DataReceived
	ENDIF
ENDDEFINE

DEFINE CLASS UdpServer As UdpBase

PROCEDURE WaitForRequest(nLocalPort)
	IF NOT THIS.StartServer(nLocalPort)
		= MESSAGEBOX(TRANSFORM(THIS.errorno) + ". " +;
			THIS.errormessage + "     ", 48,;
			"在端口上创建 UDP 套接字失败 " +;
			TRANSFORM(m.nLocalPort))
		RETURN .F.
	ELSE
		? "等待收到的请求 " +;
			THIS.LocalIP + ":" + TRANSFORM(THIS.LocalPort) + "..."
	ENDIF
	
	* 无限期地等待客户的请求
	* 在本地IP地址和nLocalPort中指定的端口上
	THIS.ReceiveDatagram

	IF EMPTY(THIS.SenderIP) OR EMPTY(THIS.SenderPort)
	* 未能获得响应或未能定义响应的来源
		= MESSAGEBOX(TRANSFORM(THIS.errorno) + ". " +;
			THIS.errormessage + "     ", 48, "Error")
		EXIT
	ELSE
	* 显示收到的请求
		? "收到的请求 " + THIS.SenderIP + ":" + TRANSFORM(THIS.SenderPort)
		? THIS.DataReceived
	ENDIF
	
	* 汇集数据发回客户端
	LOCAL cConfirmation
	cConfirmation = "Responder: " + SYS(0) + " " + TTOC(DATETIME())
	
	* 将数据发回给客户
	* 客户端应该处于监听模式
	THIS.SendDatagram(m.cConfirmation,;
		THIS.SenderIP, THIS.SenderPort)
	
ENDDEFINE

DEFINE CLASS UdpBase As Session
	errorno=0
	errormessage=""
	LocalIP=""
	LocalName=""
	LocalPort=0
	hSocket=0
	SenderIP=""
	SenderPort=""
	DataReceived=""

PROCEDURE Init
	THIS.declare
	IF NOT THIS.InitWinsock()
		THIS.SetLastError(-1,;
			"在此计算机上初始化 Winsock 失败。")
		RETURN .F.
	ENDIF
	THIS.GetLocalIP

PROCEDURE StartServer(nLocalPort)
	THIS.StopServer
	THIS.LocalPort = m.nLocalPort
	THIS.hSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)

	LOCAL cBindBuffer, nError
	cBindBuffer = THIS.GetBindBuf(THIS.LocalIP, THIS.LocalPort)

	IF ws_bind(THIS.hSocket, @cBindBuffer, LEN(m.cBindBuffer)) <> 0
		THIS.SetLastError(WSAGetLastError(),;
			"未能将套接字绑定到本地地址。")
		RETURN .F.
	ENDIF
RETURN .T.

PROCEDURE StopServer
	IF THIS.hSocket <> 0
		IF closesocket(THIS.hSocket) = 0
			THIS.hSocket=0
		ELSE
			THIS.SetLastError(WSAGetLastError(),;
				"调用 closesocket() API失败。")
			RETURN .F.
		ENDIF
	ENDIF
RETURN .T.

PROCEDURE Destroy
	THIS.StopServer
	= WSACleanup()

PROTECTED PROCEDURE InitWinsock
	LOCAL lcWSADATA, lnInitResult
	lcWSADATA = REPLICATE(CHR(0), WSADATA_SIZE)
	lnInitResult = WSAStartup(WS_VERSION, @lcWSADATA)
RETURN (lnInitResult = 0)

PROCEDURE ResetLastError
	THIS.SetLastError(0, "")

PROCEDURE SetLastError(nError, cMsg)
	THIS.errorno=m.nError
	THIS.errormessage=m.cMsg

PROTECTED PROCEDURE GetLocalIP
#DEFINE HOSTENT_SIZE 16
	LOCAL cBuffer, nResult, nAddr

	cBuffer = REPLICATE(CHR(0), 250)
	nResult = gethostname(@cBuffer, Len(cBuffer))

	THIS.LocalName = IIF(nResult=0,;
		SUBSTR(cBuffer, 1,AT(Chr(0),cBuffer)-1), "")

	nAddr = gethostbyname(THIS.LocalName)
	IF nAddr <> 0
		cBuffer = REPLICATE(CHR(0), HOSTENT_SIZE)
		= MemToStr(@cBuffer, nAddr, HOSTENT_SIZE)
		
		* 获得指向地址列表的指针。
		nAddr = buf2dword(SUBSTR(cBuffer, 13,4))

		cBuffer = REPLICATE(CHR(0), 4)
		= MemToStr(@cBuffer, nAddr, 4)
		nAddr = buf2dword(cBuffer)
		= MemToStr(@cBuffer, nAddr, 4)
		nAddr = buf2dword(cBuffer)
		THIS.LocalIP = inet_ntoa(nAddr)
	ENDIF

FUNCTION SendDatagram(cData, cTargetIP, nTargetPort) As Number
	LOCAL cBindBuffer, nResult

	IF THIS.hSocket = INVALID_SOCKET
		THIS.SetLastError(WSAGetLastError(),;
			"SendDatagram：调用socket()API失败。")
		RETURN .F.
	ENDIF

	cBindBuffer = THIS.GetBindBuf(m.cTargetIP, m.nTargetPort)
	nResult = sendto(THIS.hSocket, @cData, LEN(m.cData),;
		0, @cBindBuffer, LEN(m.cBindBuffer))

	IF nResult = SOCKET_ERROR
		THIS.SetLastError(WSAGetLastError(),;
			"SendDatagram：调用sendto()API失败。")
	ENDIF
RETURN m.nResult

PROCEDURE ReceiveDatagram
	LOCAL cBuffer, cSockaddr, nSockaddrLen, nResult
	cBuffer = REPLICATE(CHR(0), 0x1000)
	nSockaddrLen=64
	cSockaddr = REPLICATE(CHR(0), nSockaddrLen)

	THIS.SenderIP=""
	THIS.SenderPort=0

	nResult = recvfrom(THIS.hSocket, @cBuffer, LEN(m.cBuffer),;
		0, @cSockaddr, @nSockaddrLen)

	IF nResult = SOCKET_ERROR
		THIS.SetLastError(WSAGetLastError(),;
			"ReceiveDatagram：调用recvfrom() API失败。")
	ENDIF

	THIS.SenderIP = inet_ntoa(buf2dword(SUBSTR(cSockaddr,5,4)))
	THIS.SenderPort = ASC(SUBSTR(m.cSockaddr, 3,1)) * 256 +;
		ASC(SUBSTR(m.cSockaddr, 4,1))
		
	IF nResult > 0
		THIS.DataReceived = SUBSTR(m.cBuffer, 1, m.nResult)
	ELSE
		THIS.DataReceived = ""
	ENDIF

PROTECTED FUNCTION GetBindBuf(cIP, nPort)
	LOCAL cBuffer, cPort, cHost
	cPort = num2word(htons(nPort))
	cHost = num2dword(inet_addr(cIP))
RETURN num2word(AF_INET) + cPort + cHost + REPLICATE(CHR(0),8)

PROTECTED PROCEDURE declare
	DECLARE INTEGER inet_addr IN ws2_32 STRING cp
	DECLARE STRING inet_ntoa IN ws2_32 INTEGER in_addr
	DECLARE INTEGER htons IN ws2_32 INTEGER hostshort
	DECLARE INTEGER WSAGetLastError IN ws2_32
	DECLARE INTEGER closesocket IN ws2_32 INTEGER s
	DECLARE INTEGER WSACleanup IN ws2_32
	DECLARE INTEGER gethostbyname IN ws2_32 STRING hostname

	DECLARE INTEGER gethostname IN ws2_32;
		STRING @hstname, INTEGER namlen

	DECLARE INTEGER bind IN ws2_32 As ws_bind;
		INTEGER s, STRING @sockaddr, INTEGER namelen

	DECLARE INTEGER WSAStartup IN ws2_32;
		INTEGER wVerRq, STRING @lpWSAData

	DECLARE INTEGER socket IN ws2_32;
		INTEGER af, INTEGER socktype, INTEGER protocol

	DECLARE INTEGER recvfrom IN ws2_32;
		INTEGER s, STRING @buf, INTEGER buflen,;
		INTEGER rcvflags, STRING @sockaddr, INTEGER @fromlen

	DECLARE INTEGER sendto IN ws2_32;
		INTEGER s, STRING @buf, INTEGER buflen,;
		INTEGER wsflags, STRING @sendto, INTEGER tolen

	DECLARE RtlMoveMemory IN kernel32 As MemToStr;
		STRING @dst, INTEGER src, INTEGER nLen

	DECLARE RtlMoveMemory IN kernel32 As StrToMem;
		INTEGER dst, STRING @src, INTEGER nLen

ENDDEFINE

*** static functions ***
FUNCTION buf2dword(cBuffer)
RETURN Asc(SUBSTR(cBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(cBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(cBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(cBuffer, 4,1)), 24)

FUNCTION buf2word(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
       Asc(SUBSTR(lcBuffer, 2,1)) * 256

FUNCTION num2dword(lnValue)
#DEFINE m0 0x0000100
#DEFINE m1 0x0010000
#DEFINE m2 0x1000000
	IF lnValue < 0
		lnValue = 0x100000000 + lnValue
	ENDIF
	LOCAL b0, b1, b2, b3
	b3 = Int(lnValue/m2)
	b2 = Int((lnValue - b3*m2)/m1)
	b1 = Int((lnValue - b3*m2 - b2*m1)/m0)
	b0 = Mod(lnValue, m0)
RETURN Chr(b0)+Chr(b1)+Chr(b2)+Chr(b3)

FUNCTION num2word(lnValue)
RETURN Chr(MOD(m.lnValue,256)) + CHR(INT(m.lnValue/256))  
```  
***  


## 函数列表：
[WSACleanup](../libraries/ws2_32/WSACleanup.md)  
[WSAGetLastError](../libraries/ws2_32/WSAGetLastError.md)  
[WSAStartup](../libraries/ws2_32/WSAStartup.md)  
[bind](../libraries/ws2_32/bind.md)  
[closesocket](../libraries/ws2_32/closesocket.md)  
[gethostbyname](../libraries/ws2_32/gethostbyname.md)  
[gethostname](../libraries/ws2_32/gethostname.md)  
[htons](../libraries/ws2_32/htons.md)  
[inet_addr](../libraries/ws2_32/inet_addr.md)  
[inet_ntoa](../libraries/ws2_32/inet_ntoa.md)  
[recvfrom](../libraries/ws2_32/recvfrom.md)  
[sendto](../libraries/ws2_32/sendto.md)  
[socket](../libraries/ws2_32/socket.md)  

## 备注：
<a href="http://en.wikipedia.org/wiki/User_Datagram_Protocol">用户数据报协议（UDP）</a>是核心互联网协议之一。通过使用 UDP，应用程序可以在网络上发送短消息（也称为数据报）。 
  
数据报是一个独立的无连接的<a href="http://en.wikipedia.org/wiki/Packet">数据包</a>，它在报头中包含足够的信息，使网络能够将其转发到目的地，而不受之前或未来数据报的影响。 
  
***  

