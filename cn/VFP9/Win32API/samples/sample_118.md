[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 提取路径字符串的文件名和扩展名

_翻译：xinjie  2020.01.29_

## 代码：
```foxpro  
DECLARE SHORT GetFileTitle IN Comdlg32;
	STRING   lpszFile,;
	STRING @ lpszTitle,;
	INTEGER  cbBuf

lpszFile = "c:\Program Files\NetLab\AddressBook.dat"
lpszTitle = SPACE(250)

* for this path the return is "addressbook.dat"

IF GetFileTitle (lpszFile, @lpszTitle, Len(lpszTitle)) = 0
	lpszTitle = LEFT (lpszTitle, AT(Chr(0),lpszTitle)-1)
	? lpszTitle
ENDIF  
```  
***  


## 函数列表：
[GetFileTitle](../libraries/comdlg32/GetFileTitle.md)  

## 备注：
路径字符串应该是有效的 Win32 名称。 虽然这并不意味着该文件应该存在。  
  
***  

