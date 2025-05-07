Thor EditorWindow 对象
===
_本文档由 xinjie 于 2018-04-07 翻译_

访问和/或修改当前打开的编辑窗口中的文本的所有`PEM 编辑器`的 IDE 功能都使用**FoxTools.fll**中的函数。

Thor EditorWindow 对象可用于构建 Thor 工具，这些工具还可以访问或修改当前打开的编辑窗口中的文本。 这个对象有两个作用：

1.  它提供了**FoxTools.fll**中最有用功能的封装。
2.  当被访问时，它已经确定了当前编辑窗口的句柄。 它的所有方法都引用这个句柄，而不需要另外知道或引用句柄。

Thor EditorWindow 对象可以从这一行代码中获得：

```foxpro
loEditorWin = Execscript (_Screen.cThorDispatcher, 'class= editorwin from pemeditor')
```


一些进一步的说明：

1.  字符位置和行数从0开始，而不是1 。 （小心）
2.  虽然只有安装了`PEM 编辑器`才能使用此对象，但`PEM 编辑器`表单本身无需打开即可使用该对象。
3.  在`Thor 仓库`中的工具中该对象具有很多用途。

### 窗口操作：句柄，大小，位置，标题等

方法(参数)|描述
---|---
CloseWindow()|关闭当前窗口
FindLastWindow()|返回最近使用的窗口的句柄，它是来自 Form 或 Class Designer 的 PRG 或方法代码。
FindWindow() |保存当前活动窗口的句柄，并返回其窗口类型：
FindWindow() return value x|x=0: 命令窗口，表单和类设计器，其他 FoxPro 窗口|
FindWindow() return value x|x=1: 程序文件 (MODIFY COMMAND)|
FindWindow() return value x|x=2: 文本编辑器 (MODIFY FILE)|
FindWindow() return value x|x=8: 菜单代码编辑窗口|
FindWindow() return value x|x=10: 类或表单设计器的方法代码编辑窗口
FindWindow() return value x|x=12: DBC 的存储过程 (MODIFY PROCEDURE)
FindWindow() return value x|x=-1: 无
GetHeight()|返回编辑窗口的高度，以像素为单位。
GetLeft()|返回编辑窗口的左侧位置，以像素为单位。
GetOpenWindows()|返回最近最先使用的所有打开窗口句柄的集合。
GetTitle()|返回当前窗口的标题
GetTop()|返回编辑窗口的顶部位置，以像素为单位。
GetWidth()|返回编辑窗口的宽度，以像素为单位。
GetWindowHandle()|返回当前编辑窗口的句柄
MoveWindow (tnLeft, tnTop)|将编辑窗口移动到位置{tnLeft}，{tnTop}。 两者都以像素为单位。
ResizeWindow (tnWidth, tnHeight)|{tHeight}将编辑窗口的大小调整为{tnWidth}。 两者都以像素为单位。
SelectWindow (tnHandle)|选择句柄{tnhandle}的窗口
SetHandle (tnHandle)|设置句柄（用于指示大多数这些命令中引用的窗口）
SetTitle (tcNewTitle)|将编辑窗口的标题设置为{tcNewTitle}


### 文本操作

方法(参数)|描述|
---|---
Copy()|将当前突出显示的文本复制到剪贴板中
Cut()|剪切当前突出显示的文本
EnsureVisible (tnPosition, tlScroll)|确保位置{tnPosition}处的字符在编辑窗口中可见。 如果{tlScroll}为true，它会被带到编辑窗口的中点
GetCharacter (tnPosition)|返回位置{tnPosition}处的字符
GetEnvironment {tnIndex}|返回单个环境设置。 {tnIndex}取值从1到25 \.有关FoxTools的帮助，请参阅_EdGetEnv以获取所有设置的说明。 常用的值是：
GetEnvironment {tnIndex} Return value x|x=2: 文件大小
GetEnvironment {tnIndex} Return value x|x=17: 选择开始
GetEnvironment {tnIndex} Return value x|x=18x: 选择结束
GetEnvironment {tnIndex} Return value x|x=25: 窗口类型
GetFileSize()|返回文件大小
GetLineNumber (tnSelStart)|返回位置{tnPosition}处字符的行号
GetLineStart (tnSelStart, tnLineOffset)|确定位置{tnPosition}中字符的行号，并返回该行开始处字符的位置。 如果提供了{tnLineOffset}，它首先以该数量偏移行号。 因此.GetLineStart（tnSelStart，1）给出{tnSelStart}行之后的下一行的开始位置，
GetSelEnd()|返回当前突出显示的文本结尾处的位置
GetSelStart()|返回当前突出显示的文本的开始位置
GetString (tnSelStart, tnSelEnd)|返回从位置{tnSelStart}到{tnSelEnd}的字符串
Paste(tcText)|如果提供{tcText}，则将其粘贴到编辑窗口中，并保持_ClipText不变。 否则，将剪贴板的内容粘贴到编辑窗口中。
Select (tnSelStart, tnSelEnd)|从位置{tnSelStart}到{tnSelEnd}中选择（高亮显示）字符串
SetInsertionPoint (tnPosition)|将插入点设置为{tnPosition}
