[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 为　FoxPro　设置最后的错误代码
_翻译：xinjie  2021.01.07_

## 代码：
```foxpro  
DECLARE INTEGER GetLastError IN kernel32
	DECLARE SetLastError IN kernel32 INTEGER dwErrCode

	* 设置 54=ERROR_NETWORK_BUSY: 网络忙
	= SetLastError (54)
	? GetLastError()	&& 测试结果  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[SetLastError](../libraries/kernel32/SetLastError.md)  

## 备注：
SetlastError主要用于动态链接库（DLL）。 发生错误后调用此函数可使DLL模拟Win32 API的行为 
  
***  

