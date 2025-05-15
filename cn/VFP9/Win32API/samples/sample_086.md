[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 找到运行 VFP 可执行文件的路径
_翻译：xinjie  2021.01.20_

## 代码：
```foxpro  
DECLARE INTEGER GetModuleHandle IN kernel32;
	INTEGER lpModuleName

DECLARE INTEGER GetModuleFileName IN kernel32;
	INTEGER  hModule,;
	STRING @ lpFilename,;
	INTEGER  nSize

hModule = GetModuleHandle(0)
lpFilename = SPACE(250)

lnLen = GetModuleFileName (hModule, @lpFilename, Len(lpFilename))
? Left (lpFilename, lnLen)  
```  
***  


## 函数列表：
[GetModuleFileName](../libraries/kernel32/GetModuleFileName.md)  
[GetModuleHandle](../libraries/kernel32/GetModuleHandle.md)  

## Comment:
根据操作系统，VFP版本的运行情况以及运行时和命令窗口模式的不同，您可能会得到各种结果： 
  
c:\vfp\vfp.exe  
c:\winnt\system32\vfp300.esl  
c:\Program Files\Microsoft Visual Studio\VFP98\VFP6.Exe  
...  
  
***  
```foxpro
? _vfp.servername
```
  
  
  
  
***  

