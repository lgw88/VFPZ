![](Docs/Images/Thor.png)  
## VFP的工具管理器

版本 1.40 发布日期 2013-08-26

[此版本新增功能](#WhatsNew)

_本工具仅可运行于 VFP9_

_本文档由 xinjie 于 2018-04-06 翻译_

***

_**Thor** 是一个管理 IDE 中插件工具的的管理器，用于管理访问 IDE 工具的菜单和快捷键。_

[此版本新增功能](#WhatsNew)

[获取 Thor 的最新消息](Docs/Thor_news.md)

**下载 App:** [点击此处下载最新的编译版本](http://vfpxrepository.com/dl/thorupdate/thor/Thor.zip)

**如何使用:** [点击此处查看安装说明](Docs/Thor_install.md)

**帮助:** [点击此处查看完整在线文档](Docs/Thor_help.md)

**讨论组:** [点击此处在 Thor 讨论组提交你的问题、BUG报告并参与讨论](http://groups.google.com/group/FoxProThor)

**Thor 工具: [具有 IDE 工具的 PEM 编辑器](https://github.com/VFPX/PEMEditor),[Thor 仓库](Docs/Thor_repository.md),  [GoFish4](https://github.com/mattslay/GoFish)**

Thor:

*   它具有一个用户界面，用来指定工具和用户自定义菜单的快捷键。UI 提供了四种方式来访问这些工具：
    1.  使用所定义的快捷键
    2.  创建可使用快捷键的弹出菜单
    3.  在固有系统菜单(文件、编辑、查看等)下创建新的自定义菜单项
    4.  在VFP系统菜单中创建新的菜单
*   它提供了注册工具的统一的方法。
*   简化了开发者之间的共享。

Thor 附带两个工具：**Thor 仓库**和**PEM 编辑器** 。(详见下文)

与 ON KEY LABEL 不同，Thor 可以提供全方位的多键组合 (例如：{Ctrl + Alt + A})。

它所管理的“工具”其实是很简单的PRG，它们具有以下特征：

*   PRG的命名方式为：**Thor_Tool_*.PRG**
*   PRG文件必须保存在搜索目录下，或者在两个 Tools 目录下（它们在安装时被创建） -- 一个用于（通过Thor）下载的工具，一个用于个人制作的工具。
*   PRG文件的前大概40行代码必须遵循固定的模板格式，用于 Thor 获取该工具的名称、描述等信息。

### 文档

[点击此处查看Thor的完整联机文档](Docs/Thor_help.md)

### 如何使用

[点击此处下载最新的编译版本](http://vfpxrepository.com/dl/thorupdate/thor/Thor.zip).

[点击此处查看安装说明](Docs/Thor_install.md).

### Thor 社区

请访问[Thor 社区](http://groups.google.com/group/FoxProThor) 提交问题、建议，报告BUG以及你对该工具的期望。 这里集中了所有 Thor 相关的主题，是你的最佳去处。

### Thor 仓库

Thor 设计的初衷是为了使 VFP 社区成员可以共享有价值的工具。PRG工具的结构使这种共享变得异常简单。  

`Thor 仓库`就是这些工具的目录。随着开发者不断提交新的工具，它也会不断的增长。在初始阶段，它大约包含十几个工具。点击此处可以查看[Thor 仓库](Docs/Thor_repository.md)的帮助。

作为[一键更新 Thor](Docs/Thor_one-click_update.md)的一部分，它将被自动下载并予以安装。

### 来自 PEM Editor 的 IDE 工具

PEM Editor Version 7， 现在已经改名为`具有 IDE 工具的 PEM 编辑器`，它包含可以通过 Thor 访问的超过30个工具，其中一部分是 PEM Editor Version 6 中包含的，其余的是全新开发的工具。这些工具可以从 PEM 编辑器主页下载。点击此处访问帮助页面：[具有 IDE 工具的 PEM 编辑器的帮助](https://github.com/VFPX/PEMEditor)  

`PEM 编辑器`同时"发布" 一对儿用于简单的构建更多工具的对象。`Thor 仓库`中超过一半的内置工具使用了它们。

下载和安装`具有 IDE 工具的 PEM 编辑器`的步骤已经是[一键更新 Thor](Docs/Thor_one-click_update.md)的一部分.

### 示例

系统菜单中两个新的菜单(Thor 和个人定制菜单 JRN)以及在 Thor 菜单中的菜单选项：
**(译者注：此截图和最新版本略有区别！)**

![](Docs/Images/Thor_image_4.png)

<a name="WhatsNew">**新增功能**</a>

Thor 1.40 – 发布日期 2013-08-26

增加 Thor 工具栏。通过配置表单中的选择，你可以将工具添加到工具栏，如下图所示(也可用于[工具启动器](Docs/Thor_launcher.md).)

![](Docs/Images/Thor_SNAGHTMLf389404.png)

当你向 Thor 工具栏增加一个工具时，你可以选择一个工具标题或者一个图片来表示它。在下面的示例中使用了缩写的标题。

![](Docs/Images/Thor_SNAGHTMLf3b4e2e.png)

工具栏的尺寸、位置、停靠以及在工作期切换时保持稳定。(事实是，工作期切换时一直有问题。)

Thor 1.30 – 发布日期 2012-08-19

*   增加 [工具启动器](Docs/Thor_launcher.md), 通过VFP系统菜单中 Thor 菜单可以调用它

![](Docs/Images/Thor_SNAGHTML39362d.png)

*   增加 [Thor IntellisenseX](https://github.com/VFPX/IntelliSenseX).

![](Docs/Images/Thor_image_2.png)

Thor 1.1 - 发布日期 2011-10-23  

Thor 正式版发布 - 发布日期 2011-09-03  

Thor I Beta 6 - 发布日期 2011-08-22 (88 downloads)

*   一些小的BUG修复

Thor I Beta 5 - 发布日期 2011-08-09 (91 downloads)

*   一些小的调整和BUG修复

Thor I Beta 4 - 发布日期 2011-07-17 (125 downloads)

*   重装将以自动的方式进行。你只需要简单的执行最新版本的 Thor.app 就可以完成。
*   包含完整在线文档。

Thor I Beta 3 - 发布日期 2011-07-06 (94 downloads)  

Thor I Beta 2 - 发布日期 2011-07-04 (61 downloads)  

Thor I Beta - 发布日期 2011-06-03 (237 downloads)

## 鸣谢

*   该项目的概念概念出自 Jim Nelson (项目经理).
*   设计实现由 Doug Hennig, Eric Selje, 和 Tore Bleken 完成。
*   整个项目的UI由 Doug Hennig 设计实现。
