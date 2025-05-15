[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 检索可用磁盘驱动器的列表
_翻译：xinjie  2021.01.01_

## 开始之前：
查找本地系统上可用的可移动、固定、CD-ROM、RAM磁盘和网络驱动器。  

参考：

* [以程序方式断开USB大容量存储设备的连接](sample_553.md)  
* [映射和断开网络驱动器的连接](sample_387.md)  
* [枚举网络资源](sample_313.md)  
* [枚举卷和卷安装点(NTFS)](sample_087.md)  
* [驱动器 A 的磁盘](sample_319.md)  
* [检测与可移动硬盘的连接变化(VFP9)](sample_573.md)  

  
***  


## 代码：
```foxpro  
DECLARE INTEGER GetLogicalDrives IN kernel32
DECLARE INTEGER GetDriveType IN kernel32 STRING nDrive

LOCAL nDrivesMask, nIndex, nShift, cDrive
nDrivesMask = GetLogicalDrives()

? "可用磁盘驱动器:"

nIndex = 0
DO WHILE .T.
	nShift = BitLShift(1, nIndex)
	cDrive = Chr(nIndex + 65) + ":"

	IF BitAnd(nDrivesMask, nShift) = nShift
		? cDrive, GetDriveType(cDrive)
	ENDIF

	IF nShift > nDrivesMask
		EXIT
	ENDIF

	nIndex = nIndex + 1
ENDDO  
```  
***  


## 函数列表：
[GetDriveType](../libraries/kernel32/GetDriveType.md)  
[GetLogicalDrives](../libraries/kernel32/GetLogicalDrives.md)  

## 备注：
驱动器类型：  
```txt
0 未知   
1 无 Root 目录   
2 可移动磁盘   
3 本地磁盘   
4 网络驱动器   
5 光盘   
6 RAM 磁盘
```

相关的VFP函数：DRIVETYPE(), SYS(5), DISKSPACE()。  
  
***  

