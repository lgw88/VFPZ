[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 基本卷信息
_翻译：xinjie  2021.01.01_

## 开始之前：
![](../images/getvolumeinfo.png)  

参考：

* [显示驱动器类型值](sample_012.md)  
* [设置卷标](sample_151.md)  
* [驱动器 A 的磁盘](sample_319.md)  
* [获取驱动器的物理参数：扇区，簇，柱面...](sample_101.md)  
  
***  


## 代码：
```foxpro  
#DEFINE FILE_CASE_SENSITIVE_SEARCH 1
#DEFINE FILE_CASE_PRESERVED_NAMES 2
#DEFINE FILE_UNICODE_ON_DISK 4
#DEFINE FILE_PERSISTENT_ACLS 8
#DEFINE FILE_FILE_COMPRESSION 16
#DEFINE FILE_VOLUME_IS_COMPRESSED 0x8000
#DEFINE MAX_PATH 260
#DEFINE CRLF CHR(13)+CHR(10)

	DO declare
	DO GetVolumeInfo WITH "C:\"
* 主程序结束

PROCEDURE GetVolumeInfo(cRoot As String)
	LOCAL cVolNameBuffer, nVolSerialNo, nMaxCompLen, nFlags, nError
	
	STORE REPLICATE(CHR(0),MAX_PATH) TO;
		cVolNameBuffer, nFilesysNameBuffer

	STORE 0 TO nVolSerialNo, nMaxCompLen, nFlags

	nResult = GetVolumeInformation(cRoot, @cVolNameBuffer,;
		MAX_PATH, @nVolSerialNo, @nMaxCompLen, @nFlags,;
		@nFilesysNameBuffer, MAX_PATH)

	IF nResult = 0
	* 3=ERROR_PATH_NOT_FOUND
	* 21=ERROR_NOT_READY
	* 87=ERROR_INVALID_PARAMETER
		nError = GetLastError()
		= MESSAGEBOX("GetVolumeInformation() 调用失败： " +;
			TRANSFORM(m.nError), 48, m.cRoot)
		RETURN
	ENDIF

	DO LogInfo WITH "Root", m.cRoot

	DO LogInfo WITH "文件系统名称",;
		LEFT(nFilesysNameBuffer, AT(CHR(0),nFilesysNameBuffer)-1)

	DO LogInfo WITH "卷名",;
		LEFT(cVolNameBuffer, AT(CHR(0),cVolNameBuffer)-1)

	DO LogInfo WITH "卷号",;
		TRANSFORM(nVolSerialNo, "@0")

	DO LogInfo WITH "最大的文件名长度", nMaxCompLen

	DO LogInfo WITH "文件系统标志", TRANSFORM(nFlags, "@0")

	DO LogInfo WITH "支持大小写敏感的文件名",;
		IIF(BITAND(nFlags, FILE_CASE_SENSITIVE_SEARCH)=0, "No", "Yes")

	DO LogInfo WITH "文件系统保留了文件名的大小写",;
		IIF(BITAND(nFlags, FILE_CASE_PRESERVED_NAMES)=0, "No", "Yes")

	DO LogInfo WITH "文件名中支持Unicode",;
		IIF(BITAND(nFlags, FILE_UNICODE_ON_DISK)=0, "No", "Yes")

	DO LogInfo WITH "ACLs 支持",;
		IIF(BITAND(nFlags, FILE_PERSISTENT_ACLS)=0, "No", "Yes")

	DO LogInfo WITH "基于文件的压缩支持",;
		IIF(BITAND(nFlags, FILE_FILE_COMPRESSION)=0, "No", "Yes")

	DO LogInfo WITH "指定的卷是压缩卷",;
		IIF(BITAND(nFlags, FILE_VOLUME_IS_COMPRESSED)=0, "No", "Yes")

	IF USED("csResult")
		SELECT csResult
		GO TOP
		BROWSE NORMAL NOWAIT
	ENDIF

PROCEDURE LogInfo(cName, vValue)
	IF NOT USED("csResult")
		CREATE CURSOR csResult (property_name C(50), property_value C(50))
	ENDIF
	
	INSERT INTO csResult (property_name, property_value);
	VALUES (m.cName, TRANSFORM(m.vValue))

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE SHORT GetVolumeInformation IN kernel32;
		STRING lpRootPathName, STRING @lpVolumeNameBuffer,;
		LONG nVolumeNameSize, LONG @lpVolumeSerialNumber,;
		LONG @lpMaximumComponentLength, LONG @lpFlags,;
		STRING @lpFileSystemNameBuffer, LONG nFilesysNameSize  
```  
***  


## 函数列表：
[GetLastError](../libraries/kernel32/GetLastError.md)  
[GetVolumeInformation](../libraries/kernel32/GetVolumeInformation.md)  
