[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# System and Local Time values

## 代码：
```foxpro  
DECLARE GetSystemTime IN kernel32 STRING @ lpSystemTime
	DECLARE GetLocalTime  IN kernel32 STRING @ lpSystemTime

*| typedef struct _SYSTEMTIME {
*|	 WORD wYear;
*|	 WORD wMonth;
*|	 WORD wDayOfWeek;
*|	 WORD wDay;
*|	 WORD wHour;
*|	 WORD wMinute;
*|	 WORD wSecond;
*|	 WORD wMilliseconds;
*| } SYSTEMTIME, *PSYSTEMTIME; -> 16 bytes

	lcTimeBuffer = REPLI (Chr(0), 16)  && SYSTEMTIME structure
	= GetSystemTime (@lcTimeBuffer)
	? "GetSystemTime(): ", _systemtime(lcTimeBuffer)
	
	lcTimeBuffer = REPLI (Chr(0), 16)  && SYSTEMTIME structure
	= GetLocalTime (@lcTimeBuffer)
	? "GetLocalTime():  ", _systemtime(lcTimeBuffer)

	? "VFP DateTime():  ", DATETIME()
RETURN

FUNCTION  _systemtime (lcBuffer)
	wYear   = buf2word (SUBSTR(lcBuffer,  1, 2))
	wMonth  = buf2word (SUBSTR(lcBuffer,  3, 2))
	wDay	= buf2word (SUBSTR(lcBuffer,  7, 2))
	wHour   = buf2word (SUBSTR(lcBuffer,  9, 2))
	wMinute = buf2word (SUBSTR(lcBuffer, 11, 2))
	wSecond = buf2word (SUBSTR(lcBuffer, 13, 2))

	lcStoredSet = SET ("DATE")
	SET DATE TO MDY

	lcDate = STRTRAN (STR(wMonth,2) + "/" + STR(wDay,2) +;
		"/" + STR(wYear,4), " ","0")

	lcTime = STRTRAN (STR(wHour,2) + ":" + STR(wMinute,2) +;
		":" + STR(wSecond,2), " ","0")

	ltResult = CTOT (lcDate + " " + lcTime)
	SET DATE TO &lcStoredSet
RETURN  ltResult

FUNCTION  buf2word (lcBuffer)
RETURN;
	Asc(SUBSTR(lcBuffer, 1,1)) + ;
	Asc(SUBSTR(lcBuffer, 2,1)) * 256
ENDFUNC  
```  
***  


## 函数列表：
[GetLocalTime](../libraries/kernel32/GetLocalTime.md)  
[GetSystemTime](../libraries/kernel32/GetSystemTime.md)  

## Comment:
GetSystemTime返回UTC（世界标准时间）值。
  
* * *  
在WinXP/2003/Vista系统上支持WMI时间类。在Win2K系统上，你仍然可以通过查询Win32_OperatingSystem类并检查LocalDateTime属性的值来获取系统时间。 
  
***  

