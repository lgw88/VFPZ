#If Version(3) = "86"
*-- 简体中文
	*** ToolTipText
	***
	#Define ManyHeader_Controls_ImgLock  "锁列标记，在此处按下鼠标左键不放并移动鼠标"
	***
	***

	*** InitHeader
	#Define ManyHeader_InitHeader_1		"在 InitHeader 中必须传递一个有效 GRID 对象参数！"
	#Define ManyHeader_InitHeader_2		"当 AllowCellSelection = .F. 时，表格的 Valid 至少需要一行空指令，请随便添加一行 * 指令。"

	*** MergeHeader
	#Define ManyHeader_MergeHeader_1	"ManyHeader 未与 GRID 对象相绑定或者 GRID 对象己无效！"
	#Define ManyHeader_MergeHeader_2	"未指定合并后组标头的标题！"
	#Define ManyHeader_MergeHeader_3	"未指定将要合并的列范围！"
	#Define ManyHeader_MergeHeader_4	"合并列的起始位置应该大于终止位置！"
	#Define ManyHeader_MergeHeader_5	"指定的列范围非法！起始列应大于 0。"
	#Define ManyHeader_MergeHeader_6	"指定的列范围非法！终止列不能大于表格列的总数。"

	*** HeaderLock
	#Define ManyHeader_HeaderLock_1		"不能锁组标头的部份列，请将组展开后从组的最左列往右依次锁列。"

	*** HeaderSwap
	#Define ManyHeader_HeaderSwap_1		"不能执行这个操作！子标头与子标头的父标头无法对调顺序！"
	#Define ManyHeader_HeaderSwap_2		"系统错误！！没有匹配的交换方案！"

	*** GetHeaderLeft
	#Define ManyHeader_GetHeaderLeft_1	"错误的 nType = "

#ElIf Version(3) = "88"
*-- 羉砰いゅ
	*** ToolTipText
	***
	#Define ManyHeader_Controls_ImgLock  "玛夹癘矪公夹オ龄ぃ簿笆公夹"
	***
	***

	*** InitHeader
	#Define ManyHeader_InitHeader_1		" InitHeader いゲ斗肚患Τ GRID 癸禜把计!"
	#Define ManyHeader_InitHeader_2		"讽 AllowCellSelection = .F.  Valid ぶ惠璶︽叫繦獽睰︽ * "

	*** MergeHeader
	#Define ManyHeader_MergeHeader_1	"ManyHeader ゼ籔 GRID 癸禜竕﹚┪ GRID 癸禜礚"
	#Define ManyHeader_MergeHeader_2	"ゼ﹚舱夹繷夹肈"
	#Define ManyHeader_MergeHeader_3	"ゼ﹚盢璶璖瞅"
	#Define ManyHeader_MergeHeader_4	"癬﹍竚莱赣沧ゎ竚"
	#Define ManyHeader_MergeHeader_5	"﹚璖瞅獶猭癬﹍莱 0"
	#Define ManyHeader_MergeHeader_6	"﹚璖瞅獶猭沧ゎぃ羆计"

	*** HeaderLock
	#Define ManyHeader_HeaderLock_1		"ぃ玛舱夹繷场叫盢舱甶秨眖舱程オ┕ㄌΩ玛"

	*** HeaderSwap
	#Define ManyHeader_HeaderSwap_1		"ぃ磅︽硂巨夹繷籔夹繷夹繷礚猭癸秸抖"
	#Define ManyHeader_HeaderSwap_2		"╰参岿粇⊿Τで皌ユ传よ"

	*** GetHeaderLeft
	#Define ManyHeader_GetHeaderLeft_1	"岿粇 nType = "

#Else
*-- Englisth
	*** ToolTipText
	***
	#Define ManyHeader_Controls_ImgLock  "Tag of Lock,Its can be drag and drop to different location."
	***
	***

	*** InitHeader
	#Define ManyHeader_InitHeader_1		"InitHeader in need of an effective transfer of the GRID object as a parameter!"
	#Define ManyHeader_InitHeader_2		"When AllowCellSelection =. F., Grid.Valid() methods can not be empty. not add his command: *"

	*** MergeHeader
	#Define ManyHeader_MergeHeader_1	"Please run headerInit() bind GRID object first!"
	#Define ManyHeader_MergeHeader_2	"After the merger does not specify the title of the header group!"
	#Define ManyHeader_MergeHeader_3	"Is not specified to be out of the merger!"
	#Define ManyHeader_MergeHeader_4	"Merger out of the starting position should be greater than the termination position!"
	#Define ManyHeader_MergeHeader_5	"Designated out of the illegal! Start out should be greater than 0."
	#Define ManyHeader_MergeHeader_6	"Designated out of the illegal! Termination are not greater than the total number of forms out."

	*** HeaderLock
	#Define ManyHeader_HeaderLock_1		"Group can not lock out the group part, please expand group and lock by left Column."

	*** HeaderSwap
	#Define ManyHeader_HeaderSwap_1		"Unable to perform this operation! Father and son header order can not be reversed."
	#Define ManyHeader_HeaderSwap_2		"System Error! Can not solve the problems."

	*** GetHeaderLeft
	#Define ManyHeader_GetHeaderLeft_1	"NTYPE the wrong values = "

#EndIf