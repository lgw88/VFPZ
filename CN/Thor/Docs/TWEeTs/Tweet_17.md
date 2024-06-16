Thor TWEeT #17: 在 <a href="https://github.com/VFPX/IntelliSenseX" target="_blank">IntellisenseX</a> 中使用局部别名
===
_本文档由 xinjie 于 2018-04-08 翻译_

在早些时候关于[VFP 表的别名](Tweet_15.md)的 TWEeT 中有关于局部别名的简短论述。 但是，它实际上提供了一些值得讨论的有价值的功能。

在两个方面它和 Local 语句(`"Local name as class of classlib”`)是类似的：

*   他们为您的代码提供注释，以便 IntellisenseX 可以提供一个下拉列表。
*   它们只适用于当前的方法或程序。

有三种等同的方法来定义局部别名：

* `{{ SomeAlias = What-It-Stand-For }}`  … 在任意的注释中
* `*#Alias SomeAlias = What-It-Stand-For`    … 在代码行的开始
* `&&#Alias SomeAlias = What-It-Stand-For`   … 在代码行的结尾

> _(上面的粗体文本必须完全按照原样输入，不得插入空格。)_

> **注意：根据大多数情况，上述第一条语句（带双花括号的语句）适用于*整个* PRG，而不仅仅是它所在的过程或函数。**

`“What-It-Stands-For”` 可以是引用表或者对象的任意一种形式。

*   表、游标或视图名
*   表的完整或相对路径名称
*   SQL 表名
*   对类库的引用; 例如  `"{{ loObject == {class, classlibrary} }}` “
*   对一个对象的引用；例如   “`{{ loObject == Thisform.oParts}}` “
*   一个可执行表达式，它返回一个对象或表，游标或视图的名称。 这个可执行表达式必须以“=”开头;例如，有时是像这样 “`{{ loObject = = MyGetObject(‘Parts’)}}` “.  (请注意双'='字符。)

使用 SCATTER NAME 命令创建的变量会发生这种情况。

```foxpro
Select MyTable

Scatter Name loObject && {{ loObject = MyTable }}
```

这将可以提供引用 loObject 的属性时表 MyTable 的下拉列表。

还要注意`"SomeAlias"`也可以引用复合名称，比如`This.oMainObj`或`This.oMainObj.oData`; 替代规则以相同的方式工作。

本 TWEeT 说明了局部别名; 更早的[别名词典](Tweet_15.md)说明了全局别名; 即将推出的 TWEet 将描述适用于整个表单或类（基于 VCX 和 PRG）的别名。

参看 [所有Thor TWEeTs的历史](../TWEeTs.md) 和 [Thor 社区](https://groups.google.com/forum/?fromgroups#!forum/FoxProThor).
