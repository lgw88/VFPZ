
*16* created on saturday 27 of january 2017
*this is an illustration how to work with a grid and a container class.
*a container can embed all kind of objects, here its used in each row of a grid to embed text on labels ,photos,memo field.
*a cursor gathers informations desserving this grid in particular photos and text of an editbox(can be a great qty of scrollable text in each record).
*click on any photo to zoom it in a modal form with a lightbox vfp effect (i used a shape with drawmode=9 as pointed already in my previous posts).
*setfocus and click on any label to rotate it (1 round).
*the form is resizable vertically only (to hide non used grid areas).can maximize it to have a good look its scrollable by vertical scrollbars or by mouseWhell).
*the column dynamicaOutline  property is used here (can be dynamicfontbold,or others dynamic.. in grid).
*the photos used for the demo are in vfp graphics folder
*note that the form ydemo with desktop=.t. skins a windows form (as contrary of native one whose is an >XP theme with blue titlebar+round corners!).


Local m.yrep
m.yrep=Addbs(Justpath(Sys(16,1)))
Set Defa To (yrep)
#Define rh 210
Sys(2002)
Publi oform
oform = Createobject("Form1")
oform.Show
Read Event
Retu

Define Class Form1 As Form
	AutoCenter= .T.
	ShowWindow=2
	Height = 600
	Width = 800
	Caption = 'A rich list with a vfp grid and container class'

	Add Object grid1 As Grid With ColumnCount= 1,Anchor=15,;
		Top = 0, Left = 0, HeaderHeight= 0, Width = Thisform.Width, Height = Thisform.Height,;
		RowHeight= rh, RecordMark= .F.,DeleteMark= .F., ScrollBar = 2,Name="grid1"

	Procedure Load
	declare integer Sleep in kernel32 integer
	Select * From Home(2)+'Northwind\employees' Into Cursor ycurs  Readwrite
	Inde On firstName Tag firstName
	Set Order To firstName
	i=1
	Scan
		Repl  employeeId With i
		i=i+1
	Endscan

	Local m.gnbre
	m.gnbre=Adir(gabase,Home(0)+"Samples\Data\Graphics\*.gif")
	If gnbre=0  &&no images
		Return .F.
	Endi
	Sele ycurs
	Repl All photo With Home(0)+"Samples\Data\Graphics\"+gabase(Recno(),1)
* Brow
	Locate
	Endproc

	Procedure Init
	Thisform.LockScreen=.T.
	With This.grid1 As Grid
		.Anchor=15
		.RecordSourceType= 1
		.RecordSource= 'ycurs'
		.AllowHeaderSizing=.F.
		.Column1.RemoveObject('Text1')
		.Column1.AddObject('yCNT1','yCNT')
		.Column1.yCNT1.Visible = .T.
		.Column1.Sparse = .F.
		.Column1.DynamicFontOutline = 'thisform.showCnt(this.Column1.yCNT1)'
		.Column1.Width =Thisform .Width
* .AutoFit
		Locate
		.SetFocus
		.Column1.yCNT1.Resize

		.Refresh
	Endwith
* Thisform.WindowState=2
	Thisform.LockScreen=.F.

	local m.myvar
	text to m.myvar pretext 7 noshow
this is an illustration how to work with a grid and a container class.
a container can embed all kind of objects, here its used in each row of a grid, to embed text on labels ,photos,memo field and fires some actions.
a cursor gather informations desserving this grid in particular photos and text of an editbox(can be a great qty of scrollable text in each record).
click on any photo to zoom it in a modal form with a lightbox vfp effect (i used a shape with drawmode=9 as pointed already in my previous posts).
click on the demo form to release it and return to the main form.
Set grid focus and click on any label to rotate it (1 round).
the form is resizable vertically only (to hide non used grid areas).can maximize it to have a good look its scrollable by vertical scrollbars or by mouseWhell).
the column dynamicOutline  property is used here (can be dynamicfontbold,or others dynamic.. in grid-these evaluate an expression indepently of it signification by itself).
the photos used for the demo are in vfp graphics folder

note that the form ydemo with desktop=.t. skins a windows form (as contrary of native one whose is an >XP theme with blue titlebar+round oorners!).

	ENDTEXT

	local oshell
	oshell=newObject("wscript.shell")
	oshell.Popup(m.myvar,0, ' Summary help', 0+32+4096)
	oshell=null
	Endproc

	Procedure Resize
	This.grid1.Column1.yCNT1.Resize
	Endproc

	Procedure Destroy
	Clea Events
	Endproc

	Procedure showCNT
	Lparameters oContainer
	Local lcCountry, lcCity, lcEmployee, lcTitle
*  Country label
	lcCountry = Alltrim(Country)
	oContainer.lblCountry.ForeColor= Iif(m.lcCountry='UK',Rgb(0,128,255),Rgb(255,0,0))
	oContainer.lblCountry.Caption= m.lcCountry
	oContainer.lblCountry.FontSize= 14

* City label
	With oContainer.lblCity As Label
		lcCity = Alltrim(City)
		.Caption = m.lcCity
		.ForeColor = Icase(m.lcCity = 'Seattle',Rgb(128,128,255),m.lcCity = 'Tacoma',Rgb(0,128,0),;
			m.lcCity = 'Kirkland',Rgb(255,128,0),m.lcCity = 'Redmond',Rgb(0,128,255),Rgb(255,0,128))
		.FontItalic= .T.
	Endwith

*  Employee label
	With oContainer.lblEmployee As Label
		lcEmployee = Alltrim(titleofCourtesy)+' '+Alltrim(firstName)+' '+Alltrim(lastname)
		.Caption = m.lcEmployee
		.FontBold=.T.
		.ForeColor= Rgb(0,128,128)
		.FontName= 'Calibri'
		.FontSize= 20
	Endwith

*  Title
	With oContainer.lblTitle As Label
		lcTitle = Alltrim(Title)
		.Caption = m.lcTitle
		.FontName= 'Calibri'
		.FontSize= 12
		.ForeColor= Icase(m.lcTitle = 'Sales Representative',Rgb(128,0,64),;
			m.lcTitle = 'Vice President, Sales',Rgb(128,128,255),;
			m.lcTitle = 'Sales Manager',Rgb(128,128,128),Rgb(128,128,192))
	Endwith

*  Date of Birth
	With oContainer.lblDOB As Label
		.Caption = 'Date of Birth: '+Mdy(birthdate)
		.FontName= 'Calibri'
	Endwith

*  Address
	With oContainer.lblADR As Label
		.Caption = 'Address: '+Allt(address)
		.ForeColor=Rgb(255,120,90)
		.FontName= 'Calibri'
	Endwith

*  postal code
	With oContainer.lblPC As Label
		.Caption = 'Postal code: '+Allt(Postalcode)
		.ForeColor=Rgb(0,128,0)
		.FontName= 'Calibri'
	Endwith

*  home phone
	With oContainer.lblPh As Label
		.Caption = 'Phone: '+Allt(homephone)
		.ForeColor=Rgb(255,0,0)
		.FontName= 'Calibri'
	Endwith

*  EmployeeId
	With oContainer.lblID As Label
		.Caption = Trans(employeeId)
		.ForeColor=Rgb(255,0,0)
		.FontSize=48
		.AutoSize=.T.
		.FontName= 'Calibri'
	Endwith

* image
	With oContainer.img As Image
		.Picture= photo
		.Visible=Iif(!Empty(.Picture),.T.,.F.)
	Endwith
	oContainer.edt.Refresh
	Endproc
Enddefine
*ERndDefine form1


Define Class yCNT As Container
	BorderStyle= 0
	BackStyle=0
	Height = 70
	Width = 590+100+550
	BorderWidth= 0

	Add Object lblID As ylab With Top = 40, Left = 10
	Add Object lblEmployee As ylab With Top = 0, Left = 50
	Add Object lblTitle As ylab With Top = 30, Left = 50

	Add Object lblDOB As ylab With Top = 50, Left = 50
	Add Object lblADR As ylab With Top = 80, Left = 50
	Add Object lblPC As ylab With Top = 110, Left = 50
	Add Object lblPh As ylab With Top = 140, Left = 50
	Add Object lblCountry As ylab With Top = 170, Left =50 ,BorderStyle=1
	Add Object lblCity As ylab With Top = 170, Left = 100

	Add Object img As img With Top=5,Left=595
	Add Object shp1 As shp With  Top=0,Left=590
	Add Object edt As edt With Top=0,Left=790

	Procedure Init
	DoDefault()
	This.Resize
	Endproc

	Procedure Resize
	Thisform.grid1.Refresh
	Thisform.Width=This.Width+40
	This.edt.Value=This.edt.Value
	This.edt.Refresh
	With This.shp1
		.Left=.Parent.img.Left-5
		.Top=.Parent.img.Top-5
		.Width=.Parent.img.Width+2*5
		.Height=.Parent.img.Height+2*5
		.Curvature=9
		.BorderWidth=3
		Rand(-1)
		.BackColor=Rgb(255*Rand(),255*Rand(),255*Rand())
		.ZOrder(1)
	Endwith
	Thisform.AutoCenter=.T.
	Endproc
Enddefine
*EndDefine ycnt
*

Define Class ylab As Label
	BackStyle= 0
	AutoSize= .T.
	Name="ylab"

	procedure click
	for i=0 to 35
		this.rotation=this.rotation+10
		sleep(20)
	endfor
	this.rotation=0
	endproc

Enddefine
*EndDefine ylab

Define Class img As Image
	Stretch=0
	Picture=""
	MousePointer=15
	BorderStyle=1
	BorderColor=Rgb(72,0,36)
	Name="img"

	Procedure MouseDown
	Lparameters nButton, nShift, nXCoord, nYCoord
	Local  oform
	Nodefault
	With Thisform
		Try
			.AddObject("oshp","shape")
		Catch
		Endtry
		With .oshp
			.DrawMode=9
			.BackColor=Rgb(45,45,45)
			.Left=0
			.Top=0
			.Width=.Parent.Width
			.Height=.Parent.Height
			.ZOrder(0)
			.Visible=.T.
		Endwith
	Endwith

	Sele ycurs
	oform=Newobject("ydemo","","",photo,Allt(firstName)+" "+Allt(lastname))
	oform.Show(1)
	Thisform.RemoveObject("oshp")
	Thisform.grid1.SetFocus
	Endproc
Enddefine
*EndDefine img

Define Class shp As Shape
	BackStyle=1
	Width=200
	Height=250
	BackColor=Rgb(128,0,64)
	Name="shp"

	Procedure Init
	With This
*!*	      .Left=.Parent.img.Left-5
*!*	      .Top=.Parent.img.Top-5
*!*	      .Width=.Parent.img.Width+2*5
*!*	      .Height=.Parent.img.Height+2*5
		.ZOrder(1)
*.parent.resize
		.Visible=.T.
	Endwith
	Endproc
Enddefine
*EndDefine shp

Define Class edt As EditBox
	ControlSource="ycurs.notes"
	FontName="courier new"
	FontSize=9
	ForeColor=Rgb(128,0,64)
	Margin=5
	Width=450
	Height=rh
	Value=""
	ScrollBars=0   &&2
	BorderStyle=0
	ReadOnly=.T.
	Name="edt"

Enddefine

*ydemo
Define Class ydemo As Form
	Top = 29
	Left = 40
	Height = 385
	Width = Thisform.Height*16/9
	Desktop=.T.   &&form style win10 (if not =style XP(blue rounded corners)
	ShowWindow=1
	Caption = ""
	BorderStyle=0
	ControlBox = .F.
	MaxButton = .F.
	MinButton=.F.
	AutoCenter=.F.
	WindowType = 1
	Name = "Form1"

	Add Object image1 As Image With ;
		anchor=15,;
		Stretch = 2, ;
		Height = Thisform.Height, ;
		Left = 0, ;
		MousePointer = 15, ;
		Top = 0, ;
		Width = Thisform.Width, ;
		Name = "Image1"

	Procedure Init
	Lparameters  xpicture,xcap
*   DoDefault()
	If Empty(xpicture)
		Return .F.
	Endi
	With Thisform
		.Caption=Spac(50)+Allt(xcap) +Spac(30)+"[click to exit form]"     &&justfstem(xpicture)
		.image1.Picture=xpicture
		.Refresh
	Endwith
	Endproc

	Procedure image1.Click
	Thisform.Release
	Endproc
Enddefine
*
*-- EndDefine: ydemo

