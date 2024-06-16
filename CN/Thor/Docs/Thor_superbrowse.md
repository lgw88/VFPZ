超级浏览器
===
_本文档由 xinjie 于 2018-04-07 翻译_

![](Images/Thor_Super_Browse_SNAGHTML8410e4d.png)

### 左窗格

左侧窗格显示一个表格，其中包含表格的数据结构。 这些字段按字母顺序列出。 点击其中一个标题即可更改排序。

点击 Grid 中列出的字段标记你想要“处理”的字段。

Grid 下方有两个按钮：

**按钮** |**描述**
---|---
保存所选|保存当前选择，以便下次打开此表格时将选择相同的字段。
显示概要|在浏览器中打开关于表的详细描述。

### Picker 页

此页面是一个 SQL 和 Browse 语法构建器。

![](Images/Thor_Super_Browse_image_thumb_3.png)

**按钮** |**描述**
---|---
仅字段|创建所选字段的列表
Select ...|创建一个 SQL Select 声明
Update ...|创建一个 SQL Update 声明
Insert ...|创建一个 SQL Insert 声明
Create ...|创建一个 SQL Create 声明
Browse|创建一个 Browse 命令


#### 选项组用于选择SQL语法类型：

**按钮** |**描述**
---|---
VFP|以 VFP SQL 语法创建
SQLExec|以 MsSQL 语法创建

#### NVL()的选择:

**按钮** |**描述**
---|---
添加 NVL()|在适当的地方添加NVL（）语法

#### 选项组选择字段映射类型：

**按钮** |**描述**
---|---
不使用 Cast()|不增加 Cast()
VFP|增加 VFP 类型的 Cast()
ANSI|创建 ANSI 类型的 Cast()

#### 其他选项和控制：

**控制** |**描述**
---|---
“From:” 文本框|显示当前表名
“Add From” 选择框|将“From”短语添加到Select语句
“执行后关闭游标” 选择框|超级浏览器退出时关闭表
“As:” 文本框|填写 Table_Alias
“=表名” 按钮|在 As 文本框中填写当前表名
“移除” 按钮|As 文本框置空
“Into Table” 文本框|填写目标表/游标的名称
Option 1\. 表|目标是一个表
Option 2\. 游标|目标是一个只读游标
Option 3\. 可读写游标|目标是一个可读写的游标

### Grid 页:

此页是一个高级 grid。

点击列标题可以选择/取消选择一个字段。

双击任何记录都可以在由`Dynamic Forms`创建的单独窗口中打开并进行编辑。 如果选中“只读”复选框，则不可用）。

![](Images/Thor_Super_Browse_image_thumb_2.png)

#### Grid 的过滤设置:

**控制** |**描述**
---|---
查找值 文本框|输入你想要搜索的内容
表达式 选项|搜索您输入的表达式 
值 选项|输入你想要搜索的内容

#### 在表中搜索

搜索选项最好由一些样本来描述：

**选项类型** |**键入的内容**|**描述**
---|---|---
表达式|Name='Jim' 或 name = 'Tore'|自解释
表达式|Obsolete|查找逻辑字段 Obsolete 是.T的每个记录。
表达式|Inlist(custno,10,20,30)|自解释
表达式|'nit'$country|查找“nit”位于字段 Country 内的每条记录
值|usa|查找“usa”一词所在的每个记录**任何**所选字段
值|samsung 5110|查找单词'samsung'**和**'5110'在**任何**所选字段内的每条记录
值|jim nelson kong|查找每个记录中**任意**所选字段包含'jim'和'nelson'以及'kong'字样的记录
表达式|*jim nelson kong|与上面的相同，星号是用于强调**任意**所选的字段
值|=price>100|查找 price >100 的所有记录，等号（=）将强制执行表达式类型搜索**任意**所选字段


#### 轻松使用正确的搜索类型

*   用等号（=）开始搜索文本以强制执行表达式类型搜索
*   同样，星号（*）强制执行值类型搜索

#### 对于值搜索，以下规则适用：

*   每个单词都是分开的，并且每个单词都必须存在于记录中
*   只搜索选定的字段
*   所有搜索都不区分大小写
*   备注字段也被搜索
*   在字符和数字字段中搜索数字值

#### 本页其他控制:

**控制** |**描述**
---|---
排序 列表框|选择当前的排序顺序
按钮 \|<|转到首记录
按钮 \|>|转到末记录
按钮 +|添加一条新记录
按钮 Edit|在单独的表单上编辑当前记录
只读 选择框|自解释
隐藏未选字段 选择框|使 Grid 仅显示选定的字段
按钮 修改结构|给你修改结构的可能性。 如果表是共享打开的，则会询问您是否要将其重新打开。

### Index 页

列出所有活动的索引标记，并显示重新创建索引文件的语法。 可以通过用鼠标标记文本并按下 Ctrl-C 将其复制到剪贴板。

### Settings 页

此页是自解释的。
提示：ForeColor 和 BackColor 是查找颜色的 RGB 值的好工具。 选择任何颜色，按确定，您将看到该值。
请注意！通常最好使用 ForeColor，因为默认值是 Black。

### 在左侧 Grid 处于活动状态时的键盘快捷键：

#### 通用：

**快捷键** |**描述**
---|---
Escape|关闭表单
Enter|关闭表单
Spacebar|切换选择字段
A|按下 Select All 按钮
B|将当前的SQL语句复制到剪贴板
G|激活 Grid 页面
H|切换 Grid 页中 Hide unselected Fields 的值
K|激活 Picker 页面
O|将当前的SQL语句复制到剪贴板
R|按下按钮 Reverse all
S|切换 Select Field
U|按下按钮 Unselect all


#### 当 Picker 页可见时，下面的快捷键也是可用的：

**快捷键** |**描述**
---|---
\:|设置焦点到 Into Cursor 文本框
C|选择选项 SQL Create...
D|设置焦点到 Into Local Alias 文本框
E|选择选项 SQL Select...
F|切换 Add From 选择框
I|选择选项 SQL Insert...
L|切换 Add NVL() 选择框
M|点击按钮 Remove
N|选择选项 ANSI Cast
P|选择选项 SQL Update...
T|选择选项 No Cast
V|选择选项 VFP Cast
W|选择选项 Browse
X|将本地别名设置为当前别名
Y|选择选项 Only fields
1|选择选项 Into Table
2|选择选项 Into Cursor

### 当主(右侧)Grid 为当前控件时的快捷键：

#### **注意** 这些快捷方式仅在只读模式下有效！

**快捷键** |**描述**
---|---
Enter|选择左侧 grid
F|设置焦点到 Searc Values 文本框
K|选择左侧 grid
