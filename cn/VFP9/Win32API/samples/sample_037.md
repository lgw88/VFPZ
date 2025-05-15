[<img src="../images/home.png"> 主页 ](https://github.com/VFP9/Win32API)  

# 使用 MessageBeep
_翻译：xinjie  2021.01.04_

## 开始之前：
参考：

* [使用Beep和Sleep功能让蜂鸣器唱歌（仅限WinNT？）](sample_240.md)  
* [如何演奏 MIDI 音符](sample_537.md)  
  
***  


## 代码：
```foxpro  
#DEFINE MB_OK                0
#DEFINE MB_OKCANCEL          1
#DEFINE MB_ICONHAND         16
#DEFINE MB_ICONQUESTION     32
#DEFINE MB_ICONEXCLAMATION  48
#DEFINE MB_ICONASTERISK     64
#DEFINE MB_ICONMASK        240

DECLARE INTEGER MessageBeep IN "user32" INTEGER wType
	
? MessageBeep (MB_ICONEXCLAMATION)  
```  
***  


## 函数列表：
[MessageBeep](../libraries/user32/MessageBeep.md)  
