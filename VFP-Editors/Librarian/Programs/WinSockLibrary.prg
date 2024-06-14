FUNCTION apiGetTimeZoneInformation
	LPARAMETERS TZInfo
	DECLARE INTEGER GetTimeZoneInformation IN kernel32 AS apiGetTimeZoneInformation STRING @TZInfo
	RETURN apiGetTimeZoneInformation(@TZInfo)
ENDFUNC

*-***********************************************************************************************
*-*	MSWINSCK.WinSock activeX control functions
*-*
FUNCTION apiWSAStartup
	LPARAMETERS wVerRq, lpWSAData
	DECLARE INTEGER WSAStartup IN ws2_32 AS apiWSAStartup INTEGER wVerRq, STRING lpWSAData
	RETURN apiWSAStartup(wVerRq, lpWSAData)
ENDFUNC


FUNCTION apiWSACleanup
	DECLARE INTEGER WSACleanup IN ws2_32 AS apiWSACleanup
	RETURN apiWSACleanup()
ENDFUNC


FUNCTION apiGetHostByName
	LPARAMETERS Host
	DECLARE INTEGER gethostbyname IN ws2_32 AS apiGetHostByName STRING Host
	RETURN apiGetHostByName(Host)
ENDFUNC


FUNCTION apiInetNota
	LPARAMETERS in_addr
	DECLARE STRING inet_ntoa IN ws2_32 AS apiInetNota INTEGER in_addr
	RETURN apiInetNota(in_addr)
ENDFUNC


FUNCTION apiSocket
	LPARAMETERS af, tp, pt
	DECLARE INTEGER socket IN ws2_32 AS apiSocket INTEGER af, INTEGER tp, INTEGER pt
	RETURN apiSocket(af, tp, pt)
ENDFUNC


FUNCTION apiCloseSocket
	LPARAMETERS socket
	DECLARE INTEGER closesocket IN ws2_32 AS apiCloseSocket INTEGER socket
	RETURN apiCloseSocket(socket)
ENDFUNC


FUNCTION apiInetAddr
	LPARAMETERS cp
	DECLARE INTEGER inet_addr IN ws2_32 AS apiInetAddr STRING cp
	RETURN apiInetAddr(cp)
ENDFUNC


FUNCTION apiHtons
	LPARAMETERS hostshort
	DECLARE INTEGER htons IN ws2_32 AS apiHtons INTEGER hostshort
	RETURN apiHtons(hostshort)
ENDFUNC


FUNCTION apiConnect
	LPARAMETERS s, sname, namelen
	DECLARE INTEGER connect IN ws2_32 AS apiConnect INTEGER s, STRING @sname, INTEGER namelen
	RETURN apiConnect(s, @sname, namelen)
ENDFUNC


FUNCTION apiSend
	LPARAMETERS s, buf, buflen, iFlags
	DECLARE INTEGER send IN ws2_32 AS apiSend INTEGER s, STRING @buf, INTEGER buflen, INTEGER FLAGS
	RETURN apiSend(s, @buf, buflen, iFlags)
ENDFUNC


FUNCTION apiRecv
	LPARAMETERS s, buf, buflen, iFlags
	DECLARE INTEGER recv IN ws2_32 AS apiRecv INTEGER s, STRING @buf, INTEGER buflen, INTEGER FLAGS
	RETURN apiRecv(s, @buf, buflen, iFlags)
ENDFUNC


FUNCTION apiWinSockCopyMemory
	LPARAMETERS Dest, Src, nLength
	DECLARE RtlMoveMemory IN kernel32 AS apiWinSockCopyMemory STRING @Dest, INTEGER Src, INTEGER nLength
	RETURN apiWinSockCopyMemory(@Dest, Src, nLength)
ENDFUNC


FUNCTION apiSetSockOpt
LPARAMETERS s, level, optname, optval, optlen
	DECLARE INTEGER setsockopt IN ws2_32 AS apiSetSockOpt INTEGER s, INTEGER level, INTEGER optname, STRING @optval, INTEGER optlen
	RETURN apiSetSockOpt(s, level, optname, @optval, optlen)
ENDFUNC