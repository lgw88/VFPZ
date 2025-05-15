[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 设置卷标
_翻译：xinjie  2021.01.01_

## 开始之前：

参考：  
* [显示驱动器类型值](sample_012.md)  
* [基本卷信息](sample_098.md)  
* [驱动器 A 的磁盘](sample_319.md)  
* [获取驱动器的物理参数：扇区，簇，柱面...](sample_101.md)  
  
***  


## 代码：
```foxpro  
DECLARE INTEGER GetLastError IN kernel32

DECLARE INTEGER SetVolumeLabel IN kernel32;
	STRING lpRootPathName, STRING lpVolumeName

IF SetVolumeLabel ("A:\", "VolumeA") = 0
	*    3 = 系统找不到指定的路径
	*    5 = 拒绝访问
	*   21 = 设备尚未准备好
	*  123 = ERROR_INVALID_NAME
	* 1235 = 请求被中止
	? "错误代码：", GetLastError()
ENDIF  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[SetVolumeLabel](../libraries/kernel32/SetVolumeLabel.md)  

## 备注：
在某些情况下，会出现未指定的错误 0，例如，如果软盘是写保护的。  
  
***  

