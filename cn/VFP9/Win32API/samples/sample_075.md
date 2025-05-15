[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 将字符转换为大写或小写
_翻译：xinjie  2021.01.15_

## Code:
```foxpro  
DECLARE INTEGER CharLower IN user32 STRING @ lpsz
DECLARE INTEGER CharUpper IN user32 STRING @ lpsz
	
lcText = "Jack and Jill went up the hill"

? CharLower (@lcText)
? lcText

? CharUpper (@lcText)
? lcText  
```  
***  


## 函数列表：
[CharLower](../libraries/user32/CharLower.md)  
[CharUpper](../libraries/user32/CharUpper.md)  

## 备注：
这两个函数都比原生的VFP转换函数慢。至少我发现它们在我的电脑上在比较长的周期性能要慢一些。 
  
我看到使用这些函数的唯一原因是它们的参数是通过引用传递的。 
  
另外，它们可能对 Unicode 字符串有一些味道。在这一点上我不确定。 
  
***  

