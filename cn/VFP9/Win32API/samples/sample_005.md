[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 获取系统和 Windows 文件夹名称
_翻译：xinjie  2020.12.31_

## 开始之前：
参考：

* [如何获得特殊文件夹的路径](sample_415.md)  
* [浏览 Windows 已知文件夹（特殊文件夹)](sample_576.md)  
* [检索默认假脱机目录（后台打印文件夹）名称](sample_358.md)  
  
***  


## 代码：
```foxpro  
DECLARE INTEGER GetWindowsDirectory IN kernel32;
	STRING @lpBuffer, INTEGER nSize

DECLARE INTEGER GetSystemDirectory IN kernel32;
	STRING @ lpBuffer, INTEGER nSize

LOCAL lpBuffer, nSizeRet

lpBuffer = SPACE (250)
nSizeRet = GetSystemDirectory(@lpBuffer, Len(lpBuffer))
lpBuffer = SUBSTR (lpBuffer, 1, nSizeRet)
? lpBuffer

lpBuffer = SPACE (250)
nSizeRet = GetWindowsDirectory(@lpBuffer, Len(lpBuffer))
lpBuffer = SUBSTR (lpBuffer, 1, nSizeRet)
? lpBuffer  
```  
***  


## 函数列表：
[GetSystemDirectory](../libraries/kernel32/GetSystemDirectory.md)  
[GetWindowsDirectory](../libraries/kernel32/GetWindowsDirectory.md)  

## 备注：
? GetEnv("windir")  
  
***  

