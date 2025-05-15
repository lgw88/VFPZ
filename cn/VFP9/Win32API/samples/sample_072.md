[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索系统时间的调整
_翻译：xinjie  2021.01.15_

## Code:
```foxpro  
DECLARE INTEGER GetLastError IN kernel32

	DECLARE SHORT GetSystemTimeAdjustment IN kernel32.dll;
		INTEGER @ lpTimeAdjustment,;
		INTEGER @ lpTimeIncrement,;
		SHORT   @ lpTimeAdjustmentDisabled

	STORE 0 TO lpTimeAdjustment, lpTimeIncrement,;
		lpTimeAdjustmentDisabled

	IF GetSystemTimeAdjustment (@lpTimeAdjustment,;
		@lpTimeIncrement, @lpTimeAdjustmentDisabled) = 1

		? "时间的调整为: " +;
			Iif(lpTimeAdjustmentDisabled=0, "可用", "禁用")
		?
		? "每次定期时间调整时，添加到时钟中的100纳秒单位数: "
		?? lpTimeAdjustment
		?
		? "定期时间调整之间的间隔（以100纳秒为单位）: "
		?? lpTimeIncrement
	ELSE
		? "GetSystemTimeAdjustment 调用失败: "
		?? GetLastError()
	ENDIF  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetSystemTimeAdjustment](../libraries/kernel32/GetSystemTimeAdjustment.md)  

## 备注：
仅适用于WinNT。在Win9x下不支持此功能。  
  
***  

