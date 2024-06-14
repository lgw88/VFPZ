LOCAL lcSystemApp, lcWBS, lcUniqueId, lcParent, lcClassLoc
LOCAL loPropList as Collection
LOCAL ARRAY laProp[1,2]
PUBLIC ox

IF !('GKKDeclareAPI' $ SET( 'Procedure' ))
	SET PROCEDURE TO GKKDeclareAPI ADDITIVE
ENDIF

IF PEMSTATUS(_SCREEN,"GKKTools",5)
	IF ISNULL(_SCREEN.GKKTools)
		_SCREEN.GKKTools = CREATEOBJECT("Empty")
	ENDIF
ELSE
	_SCREEN.AddProperty("GKKTools")
	_SCREEN.GKKTools = CREATEOBJECT("Empty")
ENDIF

lcSystemApp = GKKGetSystemAPP()
IF !EMPTY(lcSystemApp)
	DO (lcSystemApp)

	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100"
	loPropList.ObjUniqueId = "000"
	loPropList.Property.Add(GKKAddProperty("Name", "GKKFormLayout"))
	loPropList.Property.Add(GKKAddProperty("Caption", "Test Layout Development Form"))
	loPropList.Property.Add(GKKAddProperty("Width", 600))
	loPropList.Property.Add(GKKAddProperty("Height", 400))
	loPropList.Property.Add(GKKAddProperty("BorderStyle", 3))

	DO FORM GKKLayoutEditor WITH .NULL., loPropList NAME loForm
	
	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.100"
	loPropList.ObjParent = "GKKFormLayout"
	loPropList.ObjUniqueId  = "777"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "commandbutton"
	loPropList.Property.Add(GKKAddProperty("Top", 10))
	loPropList.Property.Add(GKKAddProperty("Left", 10))
	loPropList.Property.Add(GKKAddProperty("Width", 80))
	loPropList.Property.Add(GKKAddProperty("Height", 24))
	loPropList.Property.Add(GKKAddProperty("Name", "cmdCancel"))
	loPropList.Property.Add(GKKAddProperty("BackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("Caption", "Cancel"))
	loPropList.Property.Add(GKKAddProperty("DisabledBackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledForeColor", "172,168,153"))
	loPropList.Property.Add(GKKAddProperty("FontBold", .T.))
	loPropList.Property.Add(GKKAddProperty("FontItalic", .T.))
	loPropList.Property.Add(GKKAddProperty("FontName", "Consolas"))
	loPropList.Property.Add(GKKAddProperty("FontSize", 11))
	loPropList.Property.Add(GKKAddProperty("ForeColor", "255,0,0"))
	loPropList.Property.Add(GKKAddProperty("Picture", "gkkctrlcentervert.bmp"))
	loPropList.Property.Add(GKKAddProperty("PicturePosition", 1))
	loPropList.Property.Add(GKKAddProperty("TabStop", 1))
	loForm.AddUserObject(loPropList)

	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.101"
	loPropList.ObjParent    = "GKKFormLayout"
	loPropList.ObjUniqueId  = "777654"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "commandbutton"
	loPropList.Property.Add(GKKAddProperty("Top", 10))
	loPropList.Property.Add(GKKAddProperty("Left", 190))
	loPropList.Property.Add(GKKAddProperty("Width", 80))
	loPropList.Property.Add(GKKAddProperty("Height", 24))
	loPropList.Property.Add(GKKAddProperty("Name", "cmdTest"))
	loPropList.Property.Add(GKKAddProperty("BackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("Caption", "Test"))
	loPropList.Property.Add(GKKAddProperty("DisabledBackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledForeColor", "172,168,153"))
	loPropList.Property.Add(GKKAddProperty("FontBold", .T.))
	loPropList.Property.Add(GKKAddProperty("FontItalic", .T.))
	loPropList.Property.Add(GKKAddProperty("FontName", "Consolas"))
	loPropList.Property.Add(GKKAddProperty("FontSize", 11))
	loPropList.Property.Add(GKKAddProperty("ForeColor", "255,0,0"))
	loPropList.Property.Add(GKKAddProperty("Picture", "gkkctrlcentervert.bmp"))
	loPropList.Property.Add(GKKAddProperty("PicturePosition", 1))
	loPropList.Property.Add(GKKAddProperty("TabStop", 3))
	loForm.AddUserObject(loPropList)

	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.102"
	loPropList.ObjParent    = "GKKFormLayout"
	loPropList.ObjUniqueId  = "777654"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "commandbutton"
	loPropList.Property.Add(GKKAddProperty("Top", 10))
	loPropList.Property.Add(GKKAddProperty("Left", 100))
	loPropList.Property.Add(GKKAddProperty("Width", 80))
	loPropList.Property.Add(GKKAddProperty("Height", 24))
	loPropList.Property.Add(GKKAddProperty("Name", "cmdOpen"))
	loPropList.Property.Add(GKKAddProperty("BackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("Caption", "Open"))
	loPropList.Property.Add(GKKAddProperty("DisabledBackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledForeColor", "172,168,153"))
	loPropList.Property.Add(GKKAddProperty("FontBold", .T.))
	loPropList.Property.Add(GKKAddProperty("FontItalic", .T.))
	loPropList.Property.Add(GKKAddProperty("FontName", "Consolas"))
	loPropList.Property.Add(GKKAddProperty("FontSize", 11))
	loPropList.Property.Add(GKKAddProperty("ForeColor", "255,0,0"))
	loPropList.Property.Add(GKKAddProperty("Picture", "gkkctrlcentervert.bmp"))
	loPropList.Property.Add(GKKAddProperty("PicturePosition", 1))
	loPropList.Property.Add(GKKAddProperty("TabStop", 2))
	loForm.AddUserObject(loPropList)

	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.103"
	loPropList.ObjParent    = "GKKFormLayout"
	loPropList.ObjUniqueId  = "999"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "editbox"
	loPropList.Property.Add(GKKAddProperty("Top", 50))
	loPropList.Property.Add(GKKAddProperty("Left", 10))
	loPropList.Property.Add(GKKAddProperty("Width", 200))
	loPropList.Property.Add(GKKAddProperty("Height", 75))
	loPropList.Property.Add(GKKAddProperty("Name", "edtLongText"))
	loPropList.Property.Add(GKKAddProperty("BackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledBackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledForeColor", "172,168,153"))
	loPropList.Property.Add(GKKAddProperty("FontBold", .F.))
	loPropList.Property.Add(GKKAddProperty("FontItalic", .F.))
	loPropList.Property.Add(GKKAddProperty("FontName", "Arial"))
	loPropList.Property.Add(GKKAddProperty("FontSize", 9))
	loPropList.Property.Add(GKKAddProperty("ForeColor", "0,255,0"))
	loPropList.Property.Add(GKKAddProperty("TabStop", 4))
	loForm.AddUserObject(loPropList)

	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.104"
	loPropList.ObjParent    = "GKKFormLayout"
	loPropList.ObjUniqueId  = "999"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "checkbox"
	loPropList.Property.Add(GKKAddProperty("Top", 25))
	loPropList.Property.Add(GKKAddProperty("Left", 100))
	loPropList.Property.Add(GKKAddProperty("Width", 100))
	loPropList.Property.Add(GKKAddProperty("Height", 22))
	loPropList.Property.Add(GKKAddProperty("Name", "chkTest"))
	loPropList.Property.Add(GKKAddProperty("Caption", "This is a checkbox"))
	loPropList.Property.Add(GKKAddProperty("TabStop", 5))
	loPropList.Property.Add(GKKAddProperty("Value", .T.))
	loForm.AddUserObject(loPropList)


	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.105"
	loPropList.ObjParent    = "GKKFormLayout"
	loPropList.ObjUniqueId  = "444"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "PageFrame"
	loPropList.Property.Add(GKKAddProperty("Top", 160))
	loPropList.Property.Add(GKKAddProperty("Left", 10))
	loPropList.Property.Add(GKKAddProperty("Width", 350))
	loPropList.Property.Add(GKKAddProperty("Height", 100))
	loPropList.Property.Add(GKKAddProperty("Name", "pgfPageFrame"))
	loPropList.Property.Add(GKKAddProperty("PageCount", 3))
	loPropList.Property.Add(GKKAddProperty("TabStop", 6))
	loPropList.Property.Add(GKKAddProperty("Themes", .F.))
	loPropList.Property.Add(GKKAddProperty("Page1.Caption", "Test 1"))
	loPropList.Property.Add(GKKAddProperty("Page1.Name", "Page1"))
	loPropList.Property.Add(GKKAddProperty("Page2.Caption", "Test 2"))
	loPropList.Property.Add(GKKAddProperty("Page2.Name", "Page2"))
	loPropList.Property.Add(GKKAddProperty("Page3.Caption", "Test 3"))
	loPropList.Property.Add(GKKAddProperty("Page3.Name", "Page3"))
	loForm.AddUserObject(loPropList)


	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.106"
	loPropList.ObjParent    = "GKKFormLayout.pgfPageFrame.Page1"
	loPropList.ObjUniqueId  = "888"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "commandbutton"
	loPropList.Property.Add(GKKAddProperty("Top", 10))
	loPropList.Property.Add(GKKAddProperty("Left", 5))
	loPropList.Property.Add(GKKAddProperty("Width", 80))
	loPropList.Property.Add(GKKAddProperty("Height", 24))
	loPropList.Property.Add(GKKAddProperty("Name", "cmdCreate"))
	loPropList.Property.Add(GKKAddProperty("BackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("Caption", "Create"))
	loPropList.Property.Add(GKKAddProperty("DisabledBackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledForeColor", "172,168,153"))
	loPropList.Property.Add(GKKAddProperty("FontBold", .F.))
	loPropList.Property.Add(GKKAddProperty("FontItalic", .F.))
	loPropList.Property.Add(GKKAddProperty("FontName", "Arial"))
	loPropList.Property.Add(GKKAddProperty("FontSize", 9))
	loPropList.Property.Add(GKKAddProperty("ForeColor", "0,0,0"))
	loPropList.Property.Add(GKKAddProperty("PicturePosition", 13))
	loPropList.Property.Add(GKKAddProperty("TabStop", 1))
	loForm.AddUserObject(loPropList)


	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.107"
	loPropList.ObjParent    = "GKKFormLayout.pgfPageFrame.Page2"
	loPropList.ObjUniqueId  = "222"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "commandbutton"
	loPropList.Property.Add(GKKAddProperty("Top", 10))
	loPropList.Property.Add(GKKAddProperty("Left", 5))
	loPropList.Property.Add(GKKAddProperty("Width", 80))
	loPropList.Property.Add(GKKAddProperty("Height", 24))
	loPropList.Property.Add(GKKAddProperty("Name", "cmdCreate2"))
	loPropList.Property.Add(GKKAddProperty("BackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("Caption", "Close"))
	loPropList.Property.Add(GKKAddProperty("DisabledBackColor", "236,233,216"))
	loPropList.Property.Add(GKKAddProperty("DisabledForeColor", "172,168,153"))
	loPropList.Property.Add(GKKAddProperty("FontBold", .F.))
	loPropList.Property.Add(GKKAddProperty("FontItalic", .F.))
	loPropList.Property.Add(GKKAddProperty("FontName", "Arial"))
	loPropList.Property.Add(GKKAddProperty("FontSize", 9))
	loPropList.Property.Add(GKKAddProperty("ForeColor", "0,0,0"))
	loPropList.Property.Add(GKKAddProperty("PicturePosition", 13))
	loPropList.Property.Add(GKKAddProperty("TabStop", 1))
	loForm.AddUserObject(loPropList)


	loPropList = GKKCreatePropertyListObj()
	loPropList.WBS = "100.108"
	loPropList.ObjParent    = "GKKFormLayout.pgfPageFrame.Page1"
	loPropList.ObjUniqueId  = "2323"
	loPropList.ObjClassLoc  = ""
	loPropList.ObjBaseClass = "textbox"
	loPropList.Property.Add(GKKAddProperty("Top", 10))
	loPropList.Property.Add(GKKAddProperty("Left", 45))
	loPropList.Property.Add(GKKAddProperty("Width", 100))
	loPropList.Property.Add(GKKAddProperty("Height", 24))
	loPropList.Property.Add(GKKAddProperty("Name", "txtUserInput"))
	loPropList.Property.Add(GKKAddProperty("TabStop", 2))
	loForm.AddUserObject(loPropList)

ENDIF
