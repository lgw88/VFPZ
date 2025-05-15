[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 如何使用 Cryptography API 函数用随机字节填充缓冲区
_翻译：xinjie  2021.01.07_

## 开始之前：
用这段代码来填充一个大的缓冲区（一个字符串）的随机字符。MS甚至坚持认为这些字符会比标准随机函数创建的任何字符更随机。 
  
***  


## Code:
```foxpro  
#DEFINE PROV_RSA_FULL 1
#DEFINE CRYPT_VERIFYCONTEXT 0xf0000000
DO declare

LOCAL hProvider, cBuffer
hProvider=0

* 取得 CSP 句柄
IF CryptAcquireContext(@hProvider, NULL, NULL,;
	PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) = 0
	? "调用CryptAcquireContext失败：", GetLastError()
	RETURN
ENDIF

* 分配接收随机数据的缓冲区
cBuffer = REPLICATE(CHR(0), 1024)

* 用加密随机字节填充缓冲区
IF CryptGenRandom(m.hProvider, LEN(m.cBuffer), @cBuffer) = 0
	? "调用CryptGenRandom失败：", GetLastError()
ELSE
	CREATE CURSOR cs (randbytes M)
	INSERT INTO cs VALUES (m.cBuffer)
	MODIFY MEMO randbytes NOWAIT
ENDIF

= CryptReleaseContext(m.hProvider, 0)
* 主程序结束

PROCEDURE declare
	DECLARE INTEGER GetLastError IN kernel32

	DECLARE INTEGER CryptGenRandom IN advapi32;
		INTEGER hProv, LONG dwLen, STRING @pbBuffer

	DECLARE INTEGER CryptAcquireContext IN advapi32;
		INTEGER @hProvHandle, STRING cContainer, ;
		STRING cProvider, INTEGER nProvType, INTEGER nFlags

	DECLARE INTEGER CryptReleaseContext IN advapi32;
		INTEGER hProvHandle, INTEGER nReserved  
```  
***  


## 函数列表：
[CryptAcquireContext](../libraries/advapi32/CryptAcquireContext.md)  
[CryptGenRandom](../libraries/advapi32/CryptGenRandom.md)  
[CryptReleaseContext](../libraries/advapi32/CryptReleaseContext.md)  
[GetLastError](../libraries/kernel32/GetLastError.md)  
