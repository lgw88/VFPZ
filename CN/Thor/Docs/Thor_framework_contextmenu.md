ContextMenu 对象
===
_本文档由 xinjie 于 2018-04-07 翻译_

该对象提供了一个用于创建弹出式上下文菜单的简单机制。

它可以从这一行代码中获得：

    loContextMenu = Execscript (_Screen.cThorDispatcher, 'class= Contextmenu')

使用 .AddMenuItem 方法添加项目，使用 AddSubMenu / EndSubMenu 创建子菜单，并使用 Activate 方法激活菜单。

AddMenuItem 参数允许您定义要执行的字符串或可在 Activate 方法之后处理的关键字/参数对，从而允许将所有处理包含在单个方法中。 参看最后一个例子。

这个对象可以如下使用：

方法|参数|含义
---|---|---
.AddMenuItem(lcPrompt, lcExec, lcStatusBar, lcKeyStroke, lcKeyWord, lxParameters)|lcPrompt|菜单项的提示
.AddMenuItem parameter|lcExec|要执行的字符串。 这可能是空的，在这种情况下，使用 lcKeyword 和 lxParameters 。
.AddMenuItem parameter|lcStatusBar|文本显示在状态栏上
.AddMenuItem parameter|lcKeyStroke|按键
.AddMenuItem parameter|lcKeyword|如果选择了该项目，将从对象中提供关键字（仅当 lcExec 为空时才相关）
.AddMenuItem parameter|lxParameters|如果选择此项目，则可以从对象中提供的其他参数（仅当 lcExec 为空时才相关）
.AddMenuItem parameter||请注意，可以通过调用不带参数的 AddMenuItem 来创建分隔栏
.AddSubMenu(lcPrompt)||开始定义一个子菜单。 所有对 AddMenuItem 的调用，直到关闭 EndSubMenu 的调用都将在此子菜单中。 可能本身包含一个子菜单
.EndSubMenu||标记子菜单的结尾。
.Activate||激活弹出式菜单。 如果选择的项目具有 lcExec 的空值，则返回一个指示所选项目的整数。 在这种情况下，loContextMenu.Keyword 返回所选项目的 lcKeyword 值，对于 loContextMenu.Parameters 也是如此


### \* Sample 1: 简单的菜单，两种选择
```foxpro
loContextMenu = Execscript (_Screen.cThorDispatcher, 'class= Contextmenu')  
With loContextMenu  
    .AddMenuItem ('Item 1', [MessageBox('Item 1')])  
    .AddMenuItem ('Item 2', [MessageBox('Item 2')])  
    .Activate()  
Endwith
```
 
### \* Sample 2: 子菜单
 
```foxpro
loContextMenu = Execscript (_Screen.cThorDispatcher, 'class= Contextmenu')  
With loContextMenu  
    .AddMenuItem ('Item 1', [MessageBox('Item 1')])  
    .AddMenuItem ('Item 2', [MessageBox('Item 2')])
 
    .AddSubMenu ('SubMenu 1')  
    .AddMenuItem ('Item 1-1', [MessageBox('Item 1-1')])  
    .AddMenuItem ('Item 1-2', [MessageBox('Item 1-2')])  
    .EndSubMenu()

    .AddSubMenu ('SubMenu 2')  
    .AddMenuItem ('Item 2-1', [MessageBox('Item 2-1')])  
    .AddMenuItem ('Item 2-2', [MessageBox('Item 2-2')])  
    .EndSubMenu()

    .Activate()  
Endwith
```

### \* Sample 3:  与每个菜单项传递的内容不同，关键字与每个项目相关联。 如果.Activate（）返回.T.，则所选项目的关键字可用于以下代码。

```foxpro
loContextMenu = Execscript (_Screen.cThorDispatcher, 'class= Contextmenu')  
With loContextMenu  
    .AddMenuItem ('Item 1', , , , 'This is the first item')  
    .AddMenuItem ('Item 2', , , , 'This is the second item')  
    If .Activate()  
        lcKeyword = .KeyWord  
        Messagebox (lcKeyword)  
    Endif  
Endwith
```
