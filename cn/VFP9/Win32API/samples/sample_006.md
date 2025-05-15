[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 获取笔记本电脑的电源状态
_翻译：xinjie  2021.01.01_

## 开始之前：
这个代码示例有助于查找系统是在交流电还是直流电上运行，电池当前是否在充电，以及电池的剩余寿命有多少。  
  
***  


## 代码：
```foxpro  
DECLARE INTEGER GetSystemPowerStatus IN kernel32;
	STRING @lpSystemPowerStatus

*|typedef struct _SYSTEM_POWER_STATUS {
*|  BYTE ACLineStatus;         0:1
*|  BYTE BatteryFlag;          1:1
*|  BYTE BatteryLifePercent;   2:1
*|  BYTE Reserved1;            3:1
*|  DWORD BatteryLifeTime;     4:4
*|  DWORD BatteryFullLifeTime; 8:4
*|} SYSTEM_POWER_STATUS, *LPSYSTEM_POWER_STATUS; total 12 bytes

LOCAL cBuffer
cBuffer = Repli(Chr(0), 12)
IF GetSystemPowerStatus(@cBuffer) = 0
	RETURN
ENDIF

LOCAL nStatus, nBattery
nStatus = Asc(SUBSTR(cBuffer,1,1))
nBattery = Asc(SUBSTR(cBuffer,2,1))

? "交流电状态: "
DO CASE
CASE nStatus = 0
	?? "断开"
CASE nStatus = 1
	?? "连接"
OTHER
	?? "未知"
ENDCASE

? "电量: "
DO CASE
CASE nBattery = 1
	?? "高"
CASE nBattery = 2
	?? "低"
CASE nBattery = 4
	?? "电量极低"
CASE nBattery = 8
	?? "充电"
CASE nBattery = 128
	?? "未安装电池"
OTHER
	?? "未知"
ENDCASE

IF nBattery <= 8
	? "剩余电量, %:", Asc(SUBSTR(cBuffer,3,1))
	? "剩余电量, 秒:", buf2dword(SUBSTR(cBuffer,5,4))
	? "电池充满时间, 秒:", buf2dword(SUBSTR(cBuffer,9,4))
ENDIF
* 主程序结束

FUNCTION buf2dword(lcBuffer)
RETURN Asc(SUBSTR(lcBuffer, 1,1)) + ;
	BitLShift(Asc(SUBSTR(lcBuffer, 2,1)),  8) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 3,1)), 16) +;
	BitLShift(Asc(SUBSTR(lcBuffer, 4,1)), 24)  
```  
***  


## 函数列表：
[GetSystemPowerStatus](../libraries/kernel32/GetSystemPowerStatus.md)  
