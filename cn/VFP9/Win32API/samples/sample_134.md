[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 读取当前硬件配置文件

_翻译：xinjie  2022.01.30_

## 开始之前：
此代码返回如下内容：
```txt
Docking state: 7  
GUID: {374a...696a}  
Profile name: Profile 1
```
  
***  


## 代码：
```foxpro  
CLEAR
CLEAR ALL

DECLARE INTEGER GetLastError IN kernel32
DECLARE INTEGER GetCurrentHwProfile IN advapi32 STRING @lpHwInfo

#DEFINE HW_PROFILE_GUIDLEN      39
#DEFINE MAX_PROFILE_LEN         80
#DEFINE DOCKINFO_UNDOCKED       1
#DEFINE DOCKINFO_DOCKED         2
#DEFINE DOCKINFO_USER_SUPPLIED  4
#DEFINE DOCKINFO_USER_UNDOCKED  DOCKINFO_USER_SUPPLIED + DOCKINFO_UNDOCKED
#DEFINE DOCKINFO_USER_DOCKED    DOCKINFO_USER_SUPPLIED + DOCKINFO_DOCKED

*| typedef struct tagHW_PROFILE_INFO {
*|   DWORD           dwDockInfo;
*|   TCHAR           szHwProfileGuid[HW_PROFILE_GUIDLEN];
*|   TCHAR           szHwProfileName[MAX_PROFILE_LEN];
*| } HW_PROFILE_INFO, *LPHW_PROFILE_INFO;

LOCAL cBuffer
cBuffer = Repli(Chr(0),;
	4+HW_PROFILE_GUIDLEN + MAX_PROFILE_LEN)

IF GetCurrentHwProfile (@cBuffer) = 0
*  120 = ERROR_CALL_NOT_IMPLEMENTED
* 1015 = ERROR_REGISTRY_CORRUPT
	? "Error code:", GetLastError()
ELSE
	? "Docking state:", buf2dword(SUBSTR(cBuffer,1,4))
	? "GUID:", SUBSTR(cBuffer,5,39)
	? "Profile name:", SUBSTR(cBuffer,44)
ENDIF

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[GetCurrentHwProfile](../libraries/advapi32/GetCurrentHwProfile.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
