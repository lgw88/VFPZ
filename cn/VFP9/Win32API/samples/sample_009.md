[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 CopyFile
_翻译：xinjie  2021.01.01_

## 开始之前：
参考：

* [将复制文件作为一项事务性操作（Vista）](sample_540.md)  
* [复制文件时显示标准进度对话框](sample_508.md)  
* [删除文件到回收站](sample_321.md)  

  
***  


## 代码：
```foxpro  
DECLARE INTEGER CopyFile IN kernel32;
	STRING lpExistingFileName,;
	STRING lpNewFileName,;
	INTEGER bFailIfExists

? CopyFile("C:\Autoexec.bat", "C:\Autoexec.cpy", 0)  
```  
***  


## 函数列表：
[CopyFile](../libraries/kernel32/CopyFile.md)  
