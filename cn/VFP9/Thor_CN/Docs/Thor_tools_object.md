Thor 工具对象
===
_本文档由 xinjie 于 2018-04-07 翻译_

此对象是为`PEM 编辑器`创建的各种工具的集合，它也适用于`PEM 编辑器`外的应用程序。

Thor工具对象可以从这一行代码中获得：

    loTools = Execscript (_Screen.cThorDispatcher, 'class= tools from pemeditor')

请注意，这些工具的工作时并不需要打开`PEM 编辑器`。

方法 (参数)|描述
---|---
AddMRUFile (tcFileName, tcClassName)|将文件添加到其相应的 MRU 列表（在 FoxPro 资源文件中）。 如果文件是类库，但没有提供类名称，则将该文件添加到类库的 MRU 列表（对于`PEM 编辑器`是唯一的）
BeautifyCode(lcCode)|将 BeautifyX 样式应用于包含正常代码文本的字符串。 请注意，它不会在此字符串中创建局部变量; 请参阅下面的 CreateLocals
BeautifySelectStatement (lcSelectCode)|将 BeautifyX 样式应用于包含单个 SQL Select，Update 或 Delete 语句的字符串，以执行以下操作：
BeautifySelectStatement (cont.)|* 插入 CR，以便每个字段都在一个新行中
BeautifySelectStatement (cont.)|* 插入 CR，以便主要关键字在新行中
BeautifySelectStatement (cont.)|* 对子查询应用类似的格式，在它们的 SELECT 语句下为它们对齐新行
CloseForms()|如果`PEM 编辑器`和`树形文档查看器`打开的话，关闭它们
CreateLocals(lcSelectCode)|在包含正常代码文本的字符串中创建 LOCAL 语句
CreateNewPEM(tcType, tcName, txValue)|创建一个新的属性或者方法： 
CreateNewPEM (cont.)|属性:tcType = 'P', 方法：tcType = 'M'  
CreateNewPEM (cont.)|新的 PEM：tcName = Name (_Memberdata 属性值将被更新)  
CreateNewPEM (cont.)|txValue = Value (针对属性) 或者方法代码 (针对方法)
DiskFileName(tcFileName)|返回存储在磁盘上的文件名（即，使用当前的大写/小写）。
EditMethod(toObject, tcMethodName)|打开一个方法（或事件）进行编辑。 toObject 参数参看：
EditMethod (cont.)|* 一个对象引用，
EditMethod (cont.)|* 针对当前表单或类， .T. 
EditMethod (cont.)|* 如果为空，则指当前对象。
EditSourceX(tcFileName, tcClass, tcMethodName, tnStartRange, tnEndRange)|打开任意文件进行编辑（作为**EditSource**），并具有其他功能：
EditSourceX (cont.)|* 该文件被添加到其适当的MRU库。
EditSourceX (cont.)|* 该文件以正确的文件名大小写打开，以便在保存时文件名的大小写不会被更改。
EditSourceX (cont.)|* 如果该文件是类库，并且没有提供类名称，则会打开类浏览器。
EditSourceX (cont.)|* 系统会询问您是否要从源代码管理中检出文件（如果您使用SCC并且已在首选项文件中标记了适当的项目）。
FindObjects (tcSearchText)|在{tcSearchText}中查找符合搜索条件的所有对象。 搜索标准与'查找'（双筒望远镜图标）的搜索按钮指定的相同。 结果是一个集合，集合中的每个项目都是具有两个属性的对象：
FindObjects (cont.)|1.  Object - 对象的引用
FindObjects (cont.)|2.  FullObjectName - 对象的完整路径名称
FindObjects (cont.)|例如, **.FindObjects ('Exists ("ControlSource")' )** 返回具有 ControlSource 的所有对象的集合
FindProcedure(tcName)|在 PRG 中找到一个名为 {tcName} 的 PRG，或名为 {tcName} 的过程或函数，或名为 {tcName} 的常量，打开该文件进行编辑，并突出显示搜索到的名称。
GetBeautifyXOptions()|返回一个字符结果，当使用 ExecScript 执行该结果时，将使用 BeautifyX 的当前设置重新予以美化。 请注意，这不会包含 VFP 原生美化的设置。
GetClass()|使用 IDE 工具的“打开类”对话框时对类予以提示; 返回具有两个属性的对象，‘Class’ 和 ‘ClassLib’
GetClassList(tcClass, tcClassLib, tlSearchClassLibs, tlSearchProcs, tlProjectVCXs, tlProjectPRGs, tcFolder, tlSubFolders)|创建活动项目中定义的所有类的数组。 该数组仅仅包含对象的唯一属性。 该数组有三列：
GetClassList (cont.)|1.  类名
GetClassList (cont.)|2.  类库（全路径名）
GetClassList (cont.)|3.  内部时间戳（仅适用于VCX类）
GetClassList (cont.)|这些参数提供了许多不同的搜索：
GetClassList (cont.)|*   tcClass – 要搜索的类的名称（全部为空）
GetClassList (cont.)|*   tcClassLib – VCX或PRG的名称（全部为空）
GetClassList (cont.)|*   tlSearchClassLibs – 搜索 Set(‘ClassLibs’)
GetClassList (cont.)|*   tlSearchProcs – 搜索 Set(‘Procedures’)
GetClassList (cont.)|*   tlProjectsVCXs – 搜索活动项目中的VCX
GetClassList (cont.)|*   tlProjectPRGs – 搜索活动项目中的PRG
GetClassList (cont.)|*   tcFolder – 搜索此文件夹中的所有文件（除非空）
GetClassList (cont.)|*   tcSubFolders – 搜索 tcFolder 的子文件夹
GetCurrentObject(tlTopOfForm)|如果（tlTopOfForm）为 true，则返回当前表单/类。 否则，返回当前选中的对象。
GetFullObjectName(toObject)|返回对象的全名路径{toObject}
GetPEMList(toObject, tcTypes|返回一个对象的PEM名称的集合。
GetPEMList (cont.)|{toObject} 可以是
GetPEMList (cont.)|*   一个对象引用
GetPEMList (cont.)|*   .T. 表示当前表单或类
GetPEMList (cont.)|*   空 表示当前对象
GetPEMList (cont.)|{tcTypes} 可以是一个或多个的组合
GetPEMList (cont.)|*   'P' (针对属性),
GetPEMList (cont.)|*   'E' (针对事件),
GetPEMList (cont.)|*   'M' (针对方法)
GetPEMList (cont.)|或者, 如果空或缺少，集合将包含所有PEM。
GetMRUList (tcName)|返回MRU列表中文件名的集合。 {tcName}可能是文件名，文件扩展名或实际的 MRU-ID（如果你知道的话）
GetThis()|返回当前方法所属的对象。
GetVariablesList(tcCodeBlock, tcTypes)|返回代码块中的 Parameters (‘P’), Locals (‘L’), 或者 assigned (‘!’)的变量名称集合。 如果tcTypes为空列表返回所有变量的参数。 如果tcTypes为'＃'则返回一个包含两列的单一数组（'aList'）的对象，其中，列出了所有参数以及局部，私有和公共变量。
SelectObject (toObject)|选择{toObject}作为PEM编辑器窗体和属性窗口中显示的当前对象（如果可能）。
UseHighlightedTable()|选择或打开当前突出显示的文件。  
UseHighlightedTable (cont.)|如果别名存在，则选择它。 否则，它会查找{PEME_OpenTable.PRG}并执行它，假设它将打开表（如果可能的话）
UseHighlightedTable (cont.)|如果没有突出显示的文本，则使用当前的游标或表。 
UseHighlightedTable (cont.)|在PEM编辑器的安装文件夹的子文件夹**Dynamic Snippets \ Snippet Samples**中可找到{PEME_OpenTable.PRG}的示例。 您可以通过将其复制到其父文件夹来激活它（根据需要对其进行任何调整）。
