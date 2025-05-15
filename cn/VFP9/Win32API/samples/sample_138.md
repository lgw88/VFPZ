[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 如何查找与文件名关联的应用程序

_翻译：xinjie  2022.01.30_

## 开始之前：
参看：

* [查找与文件名关联的应用程序、图标和名称](sample_584.md)  
* [显示文件和文件夹的相关图标和描述](sample_530.md)  
* [如何查看安装在本地机器上的类的系统图标](sample_544.md)  
* [如何从系统注册表中获取文件类型的 Content-Type 值](sample_468.md)  
  
***  


## 代码：
```foxpro  
DECLARE INTEGER FindExecutable IN shell32;
	STRING lpFile, STRING lpDir, STRING @lpResult

lcResult = SPACE(250)

IF FindExecutable ("c:\MyDocuments\daily.doc", "", @lcResult) > 32
	lcResult = ALLTRIM(STRTRAN(lcResult, Chr(0), " "))
	? lcResult
ELSE
	*    2 = ERROR_FILE_NOT_FOUND
	*    3 = ERROR_PATH_NOT_FOUND
	*   21 = ERROR_NOT_READY
	*  123 = ERROR_INVALID_NAME
	*  127 = ERROR_PROC_NOT_FOUND
	* 1008 = ERROR_NO_TOKEN

	DECLARE INTEGER GetLastError IN kernel32
	? "Error code:", GetLastError()
ENDIF  
```  
***  


## 函数列表：
[FindExecutable](../libraries/shell32/FindExecutable.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  

## 备注：
通常，此代码返回 Microsoft Word 或与 DOC 文件关联的任何应用程序的路径。
  
请注意，源文件——在示例代码“c:\MyDocuments\daily.doc”中——必须存在，即使是零大小的虚拟文件。
  
与 FindExecutable 不同，另一个 API 函数 AssocQueryString 检索文件关联，而不依赖于物理文件的名称。  
  
***  

