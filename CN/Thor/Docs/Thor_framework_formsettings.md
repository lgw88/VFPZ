FormSettings 对象
===
_本文档由 xinjie 于 2018-04-07 翻译_

此对象允许表单保存其设置（大小，位置和任何其他表单属性），并将表单与鼠标或光标位置对齐。

FormSettings 对象可以从这一行代码中获得，它通常放置在表单的 Init 方法中：

```loSettings = Execscript (_Screen.cThorDispatcher, 'class= ThorFormSettings', lxFormID)```

lxFormID 含义：

*   ThisForm (但仅限于在SCX内部调用)
*   或用于保存设置的文件名（例如'GoToMethod.Settings'）

为了稍后使用此对象（表单关闭时），它必须保存为表单属性：

    Thisform.AddProperty(‘oSettings’, loSettings)


### 这个对象然后可以如下使用：

方法|含义
---|---
.Restore(ThisForm)|恢复顶部，左侧，高度和宽度的保存设置
.Restore(ThisForm, ‘propertylist’)|恢复名为{属性列表}中所有属性的值，该属性是以逗号分隔的现有属性名称的字符串。
.AlignToCursor(ThisForm, llAlignToMouse, tnVerticalAdjustment, tnHorizontalAdjustment)|如果可能，将表单（顶部和左侧属性）与当前编辑窗口中的光标位置对齐。 如果当前窗口不是编辑窗口或 llAlignToMouse = .T。 ，表单将与光标位置对齐。
.Save(ThisForm)|保存表单中属性的值，以便可以在下一个会话中恢复它们的值。 保存的属性是所有调用 .Restore 后恢复的属性。 此调用通常在表单的 Destroy 事件中进行


### 示例用法:

在表单的 ‘**Init**’ 事件：

#### [点击此处查看ThorFormSettings主页](Thor_framework_formsettings.md)


    loSettings = ExecScript(_Screen.cThorDispatcher, "Class= ThorFormSettings", lxFormID)
    Thisform.AddProperty ('oSettings', loSettings)
    loSettings.Restore (Thisform) && 获取顶部，左侧，高度，宽度
    loSettings.Restore (Thisform, 'nObjectType, cSearchString') && 和另外两个属性

lxFormID 含义：

*   ThisForm (但仅限于在 SCX 内部调用)
*   或用于保存设置的文件名（例如'GoToMethod.Settings'）

并且在表单的 ‘**Destroy’** 事件：

    This.oSettings.Save (This)
    This.oSettings = .Null.
