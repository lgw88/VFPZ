push menu _msysmenu
set sysmenu to
define pad File of _msysmenu prompt 'File' ;
	color scheme 3
on selection pad File of _msysmenu do ShowPopup
set sysmenu automatic
activate menu _msysmenu nowait


function ShowPopup

loPop = newobject('PopMenu', 'VCX_Tool.vcx')

with loPop
	.nMenuBackColor = Rgb(255,251,247)
	.nItemHeight = 23

	.nBarStyle = 2
	.nBarWidth = 22
	.nBarFillColor1 = Rgb(255,251,247)
	.nBarFillColor2 = Rgb(214,215,206)

	.nTextLeft = 23
	.nTextMargin = 8

	.nSelectedStyle = 1
	.lSelectedEnabled = .T.
	.nSelectedForeColor = Rgb(0, 0, 0)
	.nReturn = 2
	.lOwnerDraw = .T.

	.Add('', '', '\<New', 	'messagebox("new")', 'new.bmp')
		&& ParentKey, Key, Caption, Command, Image
	.Add('', '', '\<Open', 	'', 'open.bmp')
	.Add('', '', '\-')
	loItem = .Add('', 'Edit', 'Edit', '', 'xtextbox.bmp')
	loItem.cMessage = "This is join shortmenu sample 1"
	.Add("", "", "\<Save", 	"", 'save.bmp')
	.Add("", "", "\<xykjsoft", 	"", 'alignheightmin.bmp')
	.Add("", "", "xykjsoft Disabled", "", 'alignheightmin.bmp', .F.)
	.Add("", "", "VFP is rock", "", 'alignwidthmin.bmp')
	.Add("", "", "VFP is rock Disalbed", "", 'alignwidthmin.bmp', .F.)
	.Add("", "01", "\<Format", "")
	.Add("01", "", "Adjust to &Highest")
	.Add("01", "", "Adjust to &Shortest", "", 'exit.bmp')
	.Add("01", "", "Adjust to &Wide")
	.Add("01", "", "Adjust to &Narrow", "", 'vfpx.bmp')
	.Add("01", "02", "More...")
	.Add("", "", "\-")
	.Add("", "", "\<Close", 	"pop menu _msysmenu", 'exit.bmp')
*With toPop.Add("", "", "Join FORM shortmenu")
*	.oRefMenu = ThisFormSet.oFormPopup
*EndWith
endwith

*--
With loPop.Add("02", "", "")
	.cTitle = "HeHe, you fooled the, No more of the operation"			&& 菜单文本
	.cMessage = ""								&& 菜单 Message
	.cCommand = ""								&& 选择后执行的命令
	.cEnabled = .F.								&& Enabled 状态
	.cPicture = ""								&& 图片
EndWith
*With toPop.Add("02", "", "Join EDIT shortmenu again")
*	lo.cMessage = "This is join shortmenu sample 2"
*	.oRefMenu = ThisFormSet.oTextPopup
*EndWith



*loPop.CreateContext(lo, ThisFormSet.oTextPopup)

loPop.Show(0, 0)