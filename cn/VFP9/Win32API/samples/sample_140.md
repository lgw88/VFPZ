[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 自动拨号

## 代码：
```foxpro  
* Source: http://www.vb-world.net/tips/tip478.html
* Author: http://www.vb-world.net/php-bin/authorbio.php?
*         authorid=3&associd=478&assoctype=3

#DEFINE INTERNET_AUTODIAL_FORCE_ONLINE      1
#DEFINE INTERNET_AUTODIAL_FORCE_UNATTENDED  2

DECLARE INTEGER InternetAutodial IN wininet.dll;
	INTEGER dwFlags, INTEGER dwReserved

DECLARE INTEGER InternetAutodialHangup IN wininet.dll;
	INTEGER dwReserved

* To prompt the user to establish a Net connection
= InternetAutodial (INTERNET_AUTODIAL_FORCE_ONLINE, 0)

* To automatically start dialling
= InternetAutodial (INTERNET_AUTODIAL_FORCE_UNATTENDED, 0)

* To disconnect an automatically dialled connection
= InternetAutodialHangup(0)  
```  
***  


## 函数列表：
[InternetAutodial](../libraries/wininet/InternetAutodial.md)  
[InternetAutodialHangup](../libraries/wininet/InternetAutodialHangup.md)  

## 备注：
我没有机会测试此代码。 我没有拨号调制解调器。
  
*谁能测试它，请让我知道是否需要对此代码进行任何更正。 *  
  
***  

