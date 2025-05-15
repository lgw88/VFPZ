[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 将可用的语言环境记录保存到游标中
_翻译：xinjie  2021.01.15_

## 请注意，本文件中包含一些与旧的news2news网站的链接，该网站目前无法使用。这些材料将在今后某个时候提供。

## 开始之前：
参考：

<!-- Anatoliy --> 
* [LanguageBar ActiveX 控件](?solution=7)  
* [检索国家语言设置](sample_077.md)  
* [在键盘布局之间切换](sample_275.md)  
  
***  


## 代码：
```foxpro  
* 一些LOCALE常数
#DEFINE LOCALE_ILANGUAGE                1   && 语言ID
#DEFINE LOCALE_SLANGUAGE                2   && 语言的本地化名称
#DEFINE LOCALE_SENGLANGUAGE          4097   && 语言的英文名称
#DEFINE LOCALE_SABBREVLANGNAME          3   && 语言名称缩写
#DEFINE LOCALE_SNATIVELANGNAME          4   && 语言的本地名称
#DEFINE LOCALE_ICOUNTRY                 5   && 国家代码
#DEFINE LOCALE_SCOUNTRY                 6   && 国家的本地化名称
#DEFINE LOCALE_SENGCOUNTRY           4098   && 国家的英文名称
#DEFINE LOCALE_SABBREVCTRYNAME          7   && 国家名称缩写
#DEFINE LOCALE_SNATIVECTRYNAME          8   && 国家名称
#DEFINE LOCALE_IDEFAULTLANGUAGE         9   && 默认语言ID
#DEFINE LOCALE_IDEFAULTCOUNTRY         10   && 默认国家代码
#DEFINE LOCALE_IDEFAULTCODEPAGE        11   && 默认 oem 代码页
#DEFINE LOCALE_IDEFAULTANSICODEPAGE  4100   && 默认 ansi 代码页
#DEFINE LOCALE_IDEFAULTMACCODEPAGE   4113   && 默认 mac 代码页

#DEFINE LOCALE_ILDATE                  34   && 长日期格式顺序
#DEFINE LOCALE_ILZERO                  18   && 小数点前导零
#DEFINE LOCALE_IMEASURE                13   && 0 = 公制, 1 = US
#DEFINE LOCALE_IMONLZERO               39   && 月份字段中的前导零
#DEFINE LOCALE_INEGCURR                28   && 负货币模式
#DEFINE LOCALE_INEGSEPBYSPACE          87   && mon sym sep by space from neg amt
#DEFINE LOCALE_INEGSIGNPOSN            83   && 负号位置

#DEFINE LOCALE_SDAYNAME1   0x0000002A
#DEFINE LOCALE_SMONTHNAME1  0x00000038
* 至少有216个LOCALE常数

DECLARE INTEGER GetLocaleInfo IN kernel32;
	INTEGER Locale, INTEGER LCType,;
	STRING @lpLCData, INTEGER cchData

CREATE CURSOR cs (;
	locale    N(6),;
	langid    C( 4),;
	llnagname C(30),;
	elangname C(30),;
	alangname C( 3),;
	nlangname C(30),;
	ccode     C( 3),;
	lcname    C(30),;
	ecname    C(30),;
	acname    C( 3),;
	ncname    C(30),;
	dlangid   C( 4),;
	dccode    C( 3),;
	doemcp    C( 5),;
	dansicp   C( 5),;
	dmaccp    C( 5),;
	ldtfmt    C( 2),;
	ldzeros   C( 2),;
	metrics   C( 2),;
	monzero   C( 2),;
	necurr    C( 2),;
	negsep    C( 2),;
	negsign   C( 2),;
	sdayname1 C(10),;
	smonname1 C(20);
)
	
* 在WinNT 4.0下扫描前0x10000代码，返回138条记录，WinMe--164条记录。
FOR ii=0 TO 65535
	= SaveLInfo(ii)
ENDFOR

SELECT cs
GO TOP
BROWSE NORMAL NOWAIT
* 主程序结束

PROCEDURE SaveLInfo(lnLocale)
* 为该地区保存一条本地记录
	IF Len(GetLInfo(lnLocale, LOCALE_ILANGUAGE)) = 0
	* 如果这个locale id不存在信息，则退出。
		RETURN
	ENDIF
	
	INSERT INTO cs VALUES (;
		lnLocale,;
		GetLInfo(lnLocale, LOCALE_ILANGUAGE),;
		GetLInfo(lnLocale, LOCALE_SLANGUAGE),;
		GetLInfo(lnLocale, LOCALE_SENGLANGUAGE),;
		GetLInfo(lnLocale, LOCALE_SABBREVLANGNAME),;
		GetLInfo(lnLocale, LOCALE_SNATIVELANGNAME),;
		GetLInfo(lnLocale, LOCALE_ICOUNTRY),;
		GetLInfo(lnLocale, LOCALE_SCOUNTRY),;
		GetLInfo(lnLocale, LOCALE_SENGCOUNTRY),;
		GetLInfo(lnLocale, LOCALE_SABBREVCTRYNAME),;
		GetLInfo(lnLocale, LOCALE_SNATIVECTRYNAME),;
		GetLInfo(lnLocale, LOCALE_IDEFAULTLANGUAGE),;
		GetLInfo(lnLocale, LOCALE_IDEFAULTCOUNTRY),;
		GetLInfo(lnLocale, LOCALE_IDEFAULTCODEPAGE),;
		GetLInfo(lnLocale, LOCALE_IDEFAULTANSICODEPAGE),;
		GetLInfo(lnLocale, LOCALE_IDEFAULTMACCODEPAGE),;
		GetLInfo(lnLocale, LOCALE_ILDATE),;
		GetLInfo(lnLocale, LOCALE_ILZERO),;
		GetLInfo(lnLocale, LOCALE_IMEASURE),;
		GetLInfo(lnLocale, LOCALE_IMONLZERO),;
		GetLInfo(lnLocale, LOCALE_INEGCURR),;
		GetLInfo(lnLocale, LOCALE_INEGSEPBYSPACE),;
		GetLInfo(lnLocale, LOCALE_INEGSIGNPOSN),;
		GetLInfo(lnLocale, LOCALE_SDAYNAME1),;
		GetLInfo(lnLocale, LOCALE_SMONTHNAME1);
	)
RETURN

PROCEDURE GetLInfo(nLocale, nType)
* 检索指定区域设置和类型的值
	cBuffer = REPLICATE(CHR(0), 250)
	nLength = GetLocaleInfo(nLocale, nType, @cBuffer, LEN(cBuffer))
RETURN IIF(nLength > 0, SUBSTR(cBuffer, 1, nLength), "")  
```  
***  


## 函数列表：
[GetLocaleInfo](../libraries/kernel32/GetLocaleInfo.md)  

## 备注：
此代码检索系统上可用的所有区域设置记录。 
  
此时，我不知道如何在 VFP 中创建回调过程（如果真的有可能），因此唯一的替换选项是扫描各种可能设置区域设置值。  
  
***  

