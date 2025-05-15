[<img src="../images/home.png"> Home ](https://github.com/VFPX/Win32API)  

# 检索全局原子名(Global Atom names)

_翻译：xinjie  2020.12.27_

## 代码:

```foxpro  
#DEFINE MAX_ATOM_LENGTH 250

DECLARE INTEGER GlobalGetAtomName IN kernel32;
    INTEGER nAtom,;
    STRING @lpBuffer,;
    INTEGER nSize

CREATE CURSOR cs (atom N(12), atomname C(MAX_ATOM_LENGTH))

* 扫描字符串原子(string atoms)
FOR nAtom = 0xC000 TO 0xFFFF
    lpBuffer = REPLICATE(CHR(0), MAX_ATOM_LENGTH)

    lnResult = GlobalGetAtomName(;
    				nAtom,;
    				@lpBuffer,;
    				MAX_ATOM_LENGTH)

    IF lnResult > 0
        INSERT INTO cs;
        VALUES (nAtom, LEFT(lpBuffer, lnResult))
    ENDIF
ENDFOR

SELECT cs
GO TOP
BROWSE NORMAL NOWAIT  
```  
***  


## 函数列表:
[GlobalGetAtomName](../libraries/kernel32/GlobalGetAtomName.md)  

## 注释:
我想不到太多的原子(Atoms)应用场景。对 VFP 程序员来说，使用原子直接进行 DDE 编程，毫无吸引力:)
  
原子可以像公共变量那样来保存应用程序的状态。原子名在程序运行期间可以一直保存在本地的原子表中。
  
如果你想阻止用户在启动应用程序 A 之前启动应用程序 B，那么可以让应用程序 A 创建一个全局的原子，那么应用程序 B 就可以依据它来确认应用程序 A 已经启动。
  
知道了特定应用程序创建的原子，我们就可以猜测这些应用程序。例如，当启动 FireFox 浏览器时，会创建原子 "FireFox" 并保存在全局表中。

就其自身而言，这些知识好像是无用的。鬼知道在什么情况下能起什么作用。
* * *  
所有已注册的窗口类(window classes)的名称都保存在 USER32 内部的原子表中。RegisterClass 函数的返回值就是该原子。您也可以通过 GetClassWord(hwnd, GCW_ATOM) 向一个窗口类的窗口询问它的类原子来检索该类的原子。   
  
* * *  
在 <a href="http://blogs.msdn.com/b/oldnewthing/">The OldNew Thing</a> 博客上有一篇文章：<a href="http://blogs.msdn.com/b/oldnewthing/archive/2004/10/11/240744.aspx">What"s the atom returned by RegisterClass useful for?</a>  
  
***  

