[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 显示驱动器类型值
_翻译：xinjie  2021.01.01_

## 开始之前：
参考：  
* [基本卷信息](sample_098.md)  
* [设置卷标](sample_151.md)  
* [驱动器 A 的磁盘](sample_319.md)  
* [获取驱动器的物理参数：扇区，簇，柱面...](sample_101.md)  
  
***  


## 代码：
```foxpro  
#DEFINE DRIVE_UNKNOWN     0
#DEFINE DRIVE_NO_ROOT_DIR 1
#DEFINE DRIVE_REMOVABLE   2
#DEFINE DRIVE_FIXED       3
#DEFINE DRIVE_REMOTE      4
#DEFINE DRIVE_CDROM       5
#DEFINE DRIVE_RAMDISK     6

DECLARE INTEGER GetDriveType IN kernel32 STRING nDrive

DECLARE INTEGER RealDriveType IN shell32;
	INTEGER iDrive, INTEGER fOKToHitNet

LOCAL nIndex, nType

FOR nIndex=Asc("A") TO Asc("Z")

	* 两个函数的结果是一样的
	nType = RealDriveType(nIndex-65, 0)
*	nType = GetDriveType(Chr(nIndex) + ":")

	DO CASE
	CASE nType = DRIVE_REMOVABLE
		? Chr(nIndex)+":", "可移动"
	CASE nType = DRIVE_FIXED
		? Chr(nIndex)+":", "固定"
	CASE nType = DRIVE_REMOTE
		? Chr(nIndex)+":", "远程"
	CASE nType = DRIVE_CDROM
		? Chr(nIndex)+":", "CDROM"
	CASE nType = DRIVE_RAMDISK
		? Chr(nIndex)+":", "RAM"
	ENDCASE
ENDFOR  
```  
***  


## 函数列表：
[GetDriveType](../libraries/kernel32/GetDriveType.md)  
[RealDriveType](../libraries/shell32/RealDriveType.md)  
