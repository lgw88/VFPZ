Thor TWEeT #12: IntellisenseX by Dot or by Hot Key?
===
_本文档由 xinjie 于 2018-04-08 翻译_

有两种不同的方式可以调用 [IntellisenseX](https://github.com/VFPX/IntelliSenseX):

*   工具 **IntellisenseX by Dot** 是一个开关/关闭 IntellisenseX 的使用。 打开时，每次按下圆点（句点）时都会调用 IntellisenseX。
*   工具 **IntellisenseX by HotKey** 仅在您按下分配给它的热键时才会调用 IntellisenseX 。 当你想使用 IntellisenseX 时，你可以按下快捷键（支持“.”操作符）。

观看视频：  [“IntellisenseX by Dot” vs “IntellisenseX by Hot Key”](http://www.youtube.com/watch?v=71psd6RH2Ls&hd=1&rel=0) (3:29)

**IntellisenseX by Dot** 是调用 IntellisenseX 的“自然”方法，因为它模仿原生 Intellisense 的工作方式。 但有一些小问题，包括以下内容：

*   选择框可能会很慢，特别是在列出对象的属性和方法时。 （这可能会在一定程度上导致即将推出的一套工具“自定义关键字列表”。）
*   当你输入任何 .T.，.F. 或 .NULL. 时，它可能会有点磕磕碰碰。 这可以通过较慢的键入来避免，但没有人想这样做。
*   它使用一个每秒触发的计时器，这会在调试器中引起恼人的行为。 定时器是绝对必要的，因为当焦点不在代码窗口时，**必须禁用**IntellisenseX

所有这些问题都可以通过使用**热键**的 IntellisenseX 来解决，而不是每次你想调用 IntellisenseX 。 但是，除了学习使用不同于dot的键来调用 Intellisense 之外，还有另一个缺点 - 就像在即将到来的 TWEeT 中将会看到的那样，IntellisenseX 提供的功能不是由本地 Intellisense 提供的。 如果使用**IntellisenseX by Dot**（当您按下点时，选择框将会出现）这些将会带来惊喜。 如果 IntellisenseX 可用（即使您知道本机智能感知无效），解决方法是使用**Intellisense by HotKey**。

#### IntellisenseX by Hot Key 的其他特性

有两个功能仅可用于 **IntellisenseX by HotKey:**

*   如果您通过'！'输入 DBC 的名称，然后通过**IntellisenseX by HotKey**使用 IntellisenseX，则选择框将列出该DBC中的所有表和视图。 （如果数据库已经打开，则不需要输入 DBC 名称）。 奇怪的是，这个列表还包括正在编辑的表单的数据环境中的文件。
*   如果您通过热键使用的同时随后键入一个星号，IntellisenseX 的选择框会列出当前文件夹中的所有表格和路径。

参看 [History of all Thor TWEeTs](../TWEeTs.md) 和 [Thor 社区](https://groups.google.com/forum/?fromgroups#!forum/FoxProThor).
