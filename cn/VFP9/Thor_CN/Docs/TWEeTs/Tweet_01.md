Thor TWEeT #1: [PEM 编辑器](https://github.com/VFPX/PEMEditor), [GoFish](https://github.com/mattslay/GoFish), 和“替换代码窗口关联菜单”
===
_本文档由 xinjie 于 2018-04-08 翻译_

在 SW Fox 时，我意识到很多来自 Thor 的工具都没有被使用，因为它们的数量太多了。 看来，如果他们适当地被介绍，以更宽松的步伐，可能会有更广泛的使用。

因此，我将在每周描述一种工具，我将其称为 TWeeTs (**T**his **W**eek's **E**xc**e**ptional **T**ools).

我会在这个星期采取简单的方法，注意两个你不应该没有的工具：[PEM 编辑器](https://github.com/VFPX/PEMEditor) 和 [GoFish](https://github.com/mattslay/GoFish).

我认为对这两个工具没有什么需要说的，因为它们非常受欢迎。 （除了这个：如果你不使用它们，你真的错过了）

有一个你应该知道的 Thor 相关工具，一个相当麻烦的工具： **替换代码窗口关联菜单**.

此工具更新 _FoxRef 系统变量，以便代码窗口中上下文菜单中的两个选项使用 Thor 工具：

      Option "View Definition"       uses **Go To Definition** (我将在另一个TWeeT中描述这个工具)

      Option "Look up Reference" uses **GoFish**

这不会影响 VFP 工具菜单中代码引用的使用。 （说实话，尽管我是 VFPX 中`代码引用`项目的项目经理，但我多年没有使用代码引用了，因为我使用[GoFish](https://github.com/mattslay/GoFish)代替）。

只需要在每个 IDE 会话中执行一次**替换代码窗口关联菜单**。 推荐的方法是在“工具定义”页面上选中“在启动时运行”。

参看 [所有Thor TWEeTs的历史](../TWEeTs.md) 和 [Thor 社区](https://groups.google.com/forum/?fromgroups#!forum/FoxProThor).
