********************************************************************************
*!* ctl32_structures.prg
********************************************************************************
*!* This classes are based on the work of Christian Eischeld with vfp2c32
********************************************************************************
#Include ctl32.h
Set Procedure To Sys(16) Additive
Return

********************************************************************************
*!* This is the base classs for all structure classes below
********************************************************************************
Define Class ctlStructure As Exception

	Address = 0
	InitMembersDone = FALSE
	Protected Embedded
	Embedded = FALSE
	Name = "CTLSTRUCTURE"
	SizeOf = 0
	Value = FALSE

	Protected _MemberData
	_MemberData = '<VFPData>' + ;
		'<memberdata name="address" type="property" display="Address"/>' + ;
		'<memberdata name="initmembersdone" type="method" display="InitMembersDone"/>' + ;
		'<memberdata name="embedded" type="method" display="Embedded"/>' + ;
		'<memberdata name="name" type="property" display="Name"/>' + ;
		'<memberdata name="sizeof" type="property" display="SizeOf"/>' + ;
		'<memberdata name="value" type="property" display="Value"/>' + ;
		'</VFPData>'

	Protected Procedure Init(m.pnAddress)
		If Vartype(m.pnAddress) <> "N" Then
			This.Address = This.AllocMem(This.SizeOf)
			If This.Address = 0
				Error(43)
				Return FALSE
			Endif
		Else
			This.Address = m.pnAddress
			This.Embedded = TRUE
		Endif
		This.InitMembers()
		This.InitMembersDone = TRUE
	Endproc

	Protected Procedure Destroy()
		This.FreeMembers()
		If This.Embedded = FALSE Then
			This.FreeMem(This.Address)
		Endif
	Endproc

	Procedure InitMembers()
		*!* Here we set up initial values, like size of structure member
		*!* And also create aditional substructures
	Endproc

	Procedure FreeMembers()
		*!* Here we free aditional substructures
	Endproc

	Hidden Procedure Value_Access()
		*!* This returns the whole structure
		Return Sys(2600, This.Address, This.SizeOf)
	Endproc

	Hidden Procedure Value_Assign(m.lnNewVal)
		*!* This assigns a string to the structure as a whole
		Sys(2600, This.Address, This.SizeOf, m.lnNewVal)
	Endproc

	Protected Procedure AllocMem(m.pnLength)
		*!* Allocates memory
		Return apiHeapAlloc(apiGetProcessHeap(), HEAP_ZERO_MEMORY, m.pnLength)
	Endproc

	Protected Procedure FreeMem(m.pnAddress)
		*!* Frees allocated memory
		Return apiHeapFree(apiGetProcessHeap(), 0, m.pnAddress)
	Endproc

	Protected Procedure ReadCharArray(m.pnAddress, m.pnLength)
		*!* Reads a string array of m.pnLength, stops at first nul char
		Local m.lcString As String
		m.lcString = Sys(2600, m.pnAddress, m.pnLength)
		Return Left(m.lcString , At(NULCHAR, m.lcString) - 1)
	Endproc

	Protected Procedure WriteCharArray(m.pnAddress, m.pcCharArray, m.pnLength)
		*!* Writes a string array of m.pnLength
		=Sys(2600, m.pnAddress, Min(Len(m.pcCharArray), m.pnLength) , m.pcCharArray)
		Return m.pnAddress
	Endproc

	Protected Procedure FreePMem(m.pnAddress)
		This.FreeMem(This.ReadUInt(m.pnAddress))
	Endproc

	Protected Procedure ReadPCString(m.pnAddress)
		*!* pnAddress is a pointer to a memory pointer
		Local m.lnAddress, m.lnLength, m.lcString
		*!* Get address pointer
		m.lnAddress = This.ReadUInt(m.pnAddress)
		*!* Get length of memory pointer:
		m.lnLength = apiHeapSize(apiGetProcessHeap(), 0, m.lnAddress)
		*!* Read value of string pointer, then reads string
		If m.lnLength > 0 Then
			m.lcString = Sys(2600, m.lnAddress, m.lnLength)
			m.lcString = Left(m.lcString , At(NULCHAR, m.lcString) - 1)
		Else
			m.lcString = ""
		Endif
		Return m.lcString
	Endproc

	Protected Procedure WritePCString(m.pnAddress, m.pcString)
		Local m.lnAdress As Integer
		*!* Release memory
		This.FreePMem(m.pnAddress)
		*!* Get a new handle for the string:
		m.lnAddress = This.AllocMem(Len(m.pcString))
		*!* Save string to handle
		=Sys(2600, m.lnAddress, Len(m.pcString), m.pcString)
		*!* Save value of handle in memory pointer
		This.WriteUInt(m.pnAddress, m.lnAddress)
	Endproc

	Protected Procedure ReadUInt(m.pnAddress)
		*!* Reads an unsigned integer (4 bytes)
		Local m.lnUInt As Integer
		m.lnUInt = CToBin(Sys(2600, m.pnAddress, 4), "4rs")
		If m.lnUInt < 0 Then
			m.lnUInt = m.lnUInt + 0x100000000
		Endif
		Return m.lnUInt
	Endproc

	Protected Procedure WriteUInt(m.pnAddress, m.pnUInt)
		*!* Writes an unsigned integer (4 bytes)
		=Sys(2600, m.pnAddress, 4, BinToC(m.pnUInt, "4rs"))
	Endproc

	Protected Procedure ReadUShort(m.pnAddress)
		Local m.lnShort As Short
		m.lnShort = CToBin(Sys(2600, m.pnAddress, 2), "2rs")
		If m.lnShort < 0 Then
			m.lnShort = m.lnShort + 0x10000
		Endif
		Return m.lnShort
	Endproc

	Protected Procedure WriteUShort(m.pnAddress, m.pnShort)
		*!* Writes an unsigned short (2 bytes)
		=Sys(2600, m.pnAddress, 2, BinToC(m.pnShort, "2rs"))
	Endproc

	Protected Procedure ReadPointer(m.pnAddress)
		*!* Reads an integer (4 bytes)
		Return CToBin(Sys(2600, m.pnAddress, 4), "4rs")
	Endproc

	Protected Procedure WritePointer(m.pnAddress, m.pnInt)
		*!* Writes an integer (4 bytes)
		=Sys(2600, m.pnAddress, 4, BinToC(m.pnInt, "4rs"))
	Endproc

	Protected Procedure ReadInt(m.pnAddress)
		*!* Reads an integer (4 bytes)
		Return CToBin(Sys(2600, m.pnAddress, 4), "4rs")
	Endproc

	Protected Procedure WriteInt(m.pnAddress, m.pnInt)
		*!* Writes an integer (4 bytes)
		=Sys(2600, m.pnAddress, 4, BinToC(m.pnInt, "4rs"))
	Endproc

	Protected Procedure ReadBytes(m.pnAddress)
		*!* Reads an integer (1 bytes)
		Return CToBin(Sys(2600, m.pnAddress, 1), "1rs")
	Endproc

	Protected Procedure WriteBytes(m.pnAddress, m.pnInt)
		*!* Writes an integer (1 bytes)
		=Sys(2600, m.pnAddress, 1, BinToC(m.pnInt, "1rs"))
	Endproc

	*!*		Protected Procedure ReadPointer(m.pnAddress)
	*!*			*!* Reads an integer (4 bytes)
	*!*			Return This.ReadUInt(m.pnAddress)
	*!*		Endproc

	*!*		Protected Procedure WritePointer(m.pnAddress, m.pnInt)
	*!*			*!* Writes an integer (4 bytes)
	*!*			Return This.WriteUInt(m.pnAddress, m.pnInt)
	*!*		Endproc

Enddefine

********************************************************************************
*!*	typedef struct _DOC_INFO_1 {
*!*	  LPTSTR pDocName;
*!*	  LPTSTR pOutputFile;
*!*	  LPTSTR pDatatype;
*!*	} DOC_INFO_1;
********************************************************************************
Define Class ctlDOC_INFO_1 As ctlStructure

	Address = 0
	SizeOf = 12
	Name = "DOC_INFO_1"
	&& structure fields
	pDocName = FALSE
	pOutputFile = FALSE
	pDatatype = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="pdocname" type="property" display="pDocName"/>' + ;
		'<memberdata name="poutputfile" type="property" display="pOutputFile"/>' + ;
		'<memberdata name="pdatatype" type="property" display="pDatatype"/>' + ;
		'</VFPData>'

	Procedure FreeMembers()
		This.FreePMem(This.Address)
		This.FreePMem(This.Address + 4)
		This.FreePMem(This.Address + 8)
	Endproc

	Procedure pDocName_Access()
		Return This.ReadPCString(This.Address)
	Endproc

	Procedure pDocName_Assign(m.lnNewVal)
		This.WritePCString(This.Address, m.lnNewVal)
	Endproc

	Procedure pOutputFile_Access()
		Return This.ReadPCString(This.Address + 4)
	Endproc

	Procedure pOutputFile_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure pDatatype_Access()
		Return This.ReadPCString(This.Address+8)
	Endproc

	Procedure pDatatype_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 8, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagMENUINFO {
*!*	  DWORD   cbSize;
*!*	  DWORD   fMask;
*!*	  DWORD   dwStyle;
*!*	  UINT    cyMax;
*!*	  HBRUSH  hbrBack;
*!*	  DWORD   dwContextHelpID;
*!*	  ULONG_PTR  dwMenuData;
*!*	} MENUINFO, FAR *LPMENUINFO;
*!*	typedef MENUINFO CONST FAR *LPCMENUINFO;
********************************************************************************
Define Class ctlMENUINFO As ctlStructure

	SizeOf = 28
	Name = "MENUINFO"
	*!* structure fields
	cbSize = FALSE
	fMask = FALSE
	dwStyle = FALSE
	cyMax = FALSE
	hbrBack = FALSE
	dwContextHelpID = FALSE
	dwMenuData = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="cbsize" type="property" display="cbSize"/>' + ;
		'<memberdata name="fmask" type="property" display="fMask"/>' + ;
		'<memberdata name="dwstyle" type="property" display="dwStyle"/>' + ;
		'<memberdata name="cymax" type="property" display="cyMax"/>' + ;
		'<memberdata name="hbrback" type="property" display="hbrBack"/>' + ;
		'<memberdata name="dwcontexthelpid" type="property" display="dwContextHelpID"/>' + ;
		'<memberdata name="dwmenudata" type="property" display="dwMenuData"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		*!* Important! init cbSize to size of structure
		This.cbSize = This.SizeOf
	Endproc

	Procedure cbSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure cbSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address,lnNewVal)
	Endproc

	Procedure fMask_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure fMask_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure dwStyle_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Procedure dwStyle_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure cyMax_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure cyMax_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure hbrBack_Access()
		Return This.ReadPointer(This.Address + 16)
	Endproc

	Procedure hbrBack_Assign(m.lnNewVal)
		This.WritePointer(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure dwContextHelpID_Access()
		Return This.ReadUInt(This.Address + 20)
	Endproc

	Procedure dwContextHelpID_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 20, m.lnNewVal)
	Endproc

	Procedure dwMenuData_Access()
		Return This.ReadUInt(This.Address+24)
	Endproc

	Procedure dwMenuData_Assign(lnNewVal)
		This.WriteUInt(This.Address+24,lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagMENUITEMINFO {
*!*	  UINT    cbSize;
*!*	  UINT    fMask;
*!*	  UINT    fType;
*!*	  UINT    fState;
*!*	  UINT    wID;
*!*	  HMENU   hSubMenu;
*!*	  HBITMAP hbmpChecked;
*!*	  HBITMAP hbmpUnchecked;
*!*	  ULONG_PTR dwItemData;
*!*	  LPTSTR  dwTypeData;
*!*	  UINT    cch;
*!*	  HBITMAP hbmpItem;
*!*	} MENUITEMINFO, *LPMENUITEMINFO;
********************************************************************************
Define Class ctlMENUITEMINFO As ctlStructure

	SizeOf = 48
	Name = "MENUITEMINFO"
	*!* structure fields
	cbSize = FALSE
	fMask = FALSE
	fType = FALSE
	fState = FALSE
	wID = FALSE
	hSubMenu = FALSE
	hbmpChecked = FALSE
	hbmpUnchecked = FALSE
	dwItemData = FALSE
	dwTypeData = FALSE
	cch = FALSE
	hbmpItem = FALSE

	Protected _MemberData
	_MemberData = '<VFPData>' + ;
		'<memberdata name="cbsize" type="property" display="cbSize"/>' + ;
		'<memberdata name="fmask" type="property" display="fMask"/>' + ;
		'<memberdata name="ftype" type="property" display="fType"/>' + ;
		'<memberdata name="fstate" type="property" display="fState"/>' + ;
		'<memberdata name="wid" type="property" display="wID"/>' + ;
		'<memberdata name="hsubmenu" type="property" display="hSubMenu"/>' + ;
		'<memberdata name="hbmpchecked" type="property" display="hbmpChecked"/>' + ;
		'<memberdata name="hbmpunchecked" type="property" display="hbmpUnchecked"/>' + ;
		'<memberdata name="dwitemdata" type="property" display="dwItemData"/>' + ;
		'<memberdata name="dwtypedata" type="property" display="dwTypeData"/>' + ;
		'<memberdata name="cch" type="property" display="cch"/>' + ;
		'<memberdata name="hbmpitem" type="property" display="hbmpItem"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		*!* Important! init cbSize to size of structure
		This.cbSize = This.SizeOf
	Endproc

	Procedure FreeMembers()
		This.FreePMem(This.Address + 36)
	Endproc

	Hidden Procedure cbSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Hidden Procedure cbSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Hidden Procedure fMask_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Hidden Procedure fMask_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Hidden Procedure fType_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Hidden Procedure fType_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

	Hidden Procedure fState_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Hidden Procedure fState_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Hidden Procedure wID_Access()
		Return This.ReadUInt(This.Address + 16)
	Endproc

	Hidden Procedure wID_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 16, m.lnNewVal)
	Endproc

	Hidden Procedure hSubMenu_Access()
		Return This.ReadUInt(This.Address + 20)
	Endproc

	Hidden Procedure hSubMenu_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 20, m.lnNewVal)
	Endproc

	Hidden Procedure hbmpChecked_Access()
		Return This.ReadUInt(This.Address + 24)
	Endproc

	Hidden Procedure hbmpChecked_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 24, m.lnNewVal)
	Endproc

	Hidden Procedure hbmpUnchecked_Access()
		Return This.ReadUInt(This.Address + 28)
	Endproc

	Hidden Procedure hbmpUnchecked_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 28, m.lnNewVal)
	Endproc

	Hidden Procedure dwItemData_Access()
		Return This.ReadUInt(This.Address + 32)
	Endproc

	Hidden Procedure dwItemData_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 32, m.lnNewVal)
	Endproc

	Hidden Procedure dwTypeData_Access()
		Return This.ReadPCString(This.Address + 36)
	Endproc

	Hidden Procedure dwTypeData_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 36, m.lnNewVal)
	Endproc

	Hidden Procedure cch_Access()
		Return This.ReadUInt(This.Address + 40)
	Endproc

	Hidden Procedure cch_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 40, m.lnNewVal)
	Endproc

	Hidden Procedure hbmpItem_Access()
		Return This.ReadUInt(This.Address + 44)
	Endproc

	Hidden Procedure hbmpItem_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 44, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct _RECT {
*!*	  LONG Left;
*!*	  LONG Top;
*!*	  LONG Right;
*!*	  LONG Bottom;
*!*	} RECT, *PRECT;
********************************************************************************
Define Class ctlRECT As ctlStructure

	SizeOf = 16
	Name = "RECT"
	*!*  structure fields
	Left = FALSE
	Top = FALSE
	Right = FALSE
	Bottom = FALSE
	&& Extra properties
	Height = FALSE
	Width = FALSE

	Protected _MemberData
	_MemberData = '<VFPData>' + ;
		'<memberdata name="left" type="property" display="Left"/>' + ;
		'<memberdata name="top" type="property" display="Top"/>' + ;
		'<memberdata name="right" type="property" display="Right"/>' + ;
		'<memberdata name="bottom" type="property" display="Bottom"/>' + ;
		'<memberdata name="height" type="property" display="Height"/>' + ;
		'<memberdata name="width" type="property" display="Width"/>' + ;
		'</VFPData>'

	Hidden Procedure Left_Access()
		Return This.ReadInt(This.Address)
	Endproc

	Hidden Procedure Left_Assign(m.lnNewVal)
		This.WriteInt(This.Address, m.lnNewVal)
	Endproc

	Hidden Procedure Top_Access()
		Return This.ReadInt(This.Address + 4)
	Endproc

	Hidden Procedure Top_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 4, m.lnNewVal)
	Endproc

	Hidden Procedure Right_Access()
		Return This.ReadInt(This.Address + 8)
	Endproc

	Hidden Procedure Right_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 8, m.lnNewVal)
	Endproc

	Hidden Procedure Bottom_Access()
		Return This.ReadInt(This.Address + 12)
	Endproc

	Hidden Procedure Bottom_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 12, m.lnNewVal)
	Endproc

	Hidden Procedure Height_Access()
		Return This.Bottom - This.Top
	Endproc

	Hidden Procedure Height_Assign(m.lnNewVal)
		This.Height = m.lnNewVal
		This.Bottom = This.Top + m.lnNewVal
	Endproc

	Hidden Procedure Width_Access()
		Return This.Right - This.Left
	Endproc

	Hidden Procedure Width_Assign(m.lnNewVal)
		This.Width = m.lnNewVal
		This.Right = This.Left + m.lnNewVal
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagPOINT {
*!*	  LONG x;
*!*	  LONG y;
*!*	} POINT, *PPOINT;
********************************************************************************
Define Class ctlPOINT As ctlStructure

	SizeOf = 8
	Name = "POINT"
	&& structure fields
	x = FALSE
	Y = FALSE

	Protected _MemberData
	_MemberData = '<VFPData>' + ;
		'<memberdata name="x" type="property" display="X"/>' + ;
		'<memberdata name="y" type="property" display="Y"/>' + ;
		'</VFPData>'

	Procedure x_Access()
		Return This.ReadInt(This.Address)
	Endproc

	Procedure x_Assign(m.lnNewVal)
		This.WriteInt(This.Address, m.lnNewVal)
	Endproc

	Procedure y_Access()
		Return This.ReadInt(This.Address + 4)
	Endproc

	Procedure y_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 4, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct _WINDOWPLACEMENT {
*!*	  UINT length;
*!*	  UINT flags;
*!*	  UINT showCmd;
*!*	  POINT ptMinPosition;
*!*	  POINT ptMaxPosition;
*!*	  RECT rcNormalPosition;
*!*	} WINDOWPLACEMENT;
********************************************************************************
Define Class ctlWINDOWPLACEMENT As ctlStructure

	SizeOf = 44
	Name = "WINDOWPLACEMENT"
	&& structure fields
	Length = FALSE
	Flags = FALSE
	ShowCmd = FALSE
	ptMinPosition = .Null.
	ptMaxPosition = .Null.
	rcNormalPosition = .Null.

	Protected _MemberData
	_MemberData = '<VFPData>' + ;
		'<memberdata name="length" type="property" display="length"/>' + ;
		'<memberdata name="flags" type="property" display="flags"/>' + ;
		'<memberdata name="showcmd" type="property" display="showCmd"/>' + ;
		'<memberdata name="ptminposition" type="property" display="ptMinPosition"/>' + ;
		'<memberdata name="ptmaxposition" type="property" display="ptMaxPosition"/>' + ;
		'<memberdata name="rcnormalposition" type="property" display="rcNormalPosition"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.Length = This.SizeOf
		This.ptMinPosition = Createobject("ctlPoint", This.Address + 12)
		This.ptMaxPosition = Createobject("ctlPoint", This.Address + 20)
		This.rcNormalPosition = Createobject("ctlRect", This.Address + 28)
	Endproc

	Procedure FreeMembers()
		This.ptMinPosition = .Null.
		This.ptMaxPosition = .Null.
		This.rcNormalPosition = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.ptMinPosition.Address = m.lnAddress + 12
			This.ptMaxPosition.Address = m.lnAddress + 20
			This.rcNormalPosition.Address = m.lnAddress + 28
		Endif
	Endproc

	Procedure length_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure length_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure flags_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure flags_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure showCmd_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Procedure showCmd_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagMONITORINFOEX {
*!*	  DWORD  cbSize;
*!*	  RECT   rcMonitor;
*!*	  RECT   rcWork;
*!*	  DWORD  dwFlags;
*!*	  TCHAR  szDevice[CCHDEVICENAME];
*!*	} MONITORINFOEX, *LPMONITORINFOEX;
********************************************************************************
Define Class ctlMONITORINFOEX As ctlStructure

	SizeOf = 72
	Name = "MONITORINFOEX"
	&& structure fields
	cbSize = FALSE
	rcMonitor = .Null.
	rcWork = .Null.
	dwFlags = FALSE
	szDevice = FALSE

	Protected _MemberData
	_MemberData = '<VFPData>' + ;
		'<memberdata name="cbsize" type="property" display="cbSize"/>' + ;
		'<memberdata name="rcmonitor" type="property" display="rcMonitor"/>' + ;
		'<memberdata name="rcwork" type="property" display="rcWork"/>' + ;
		'<memberdata name="dwflags" type="property" display="dwFlags"/>' + ;
		'<memberdata name="szdevice" type="property" display="szDevice"/>' + ;
		'</VFPData>'

	Procedure InitMembers
		This.cbSize = This.SizeOf
		This.rcMonitor = Createobject('ctlRect', This.Address + 4)
		This.rcWork = Createobject('ctlRect', This.Address + 20)
	Endproc

	Procedure FreeMembers()
		This.rcMonitor = .Null.
		This.rcWork = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.rcMonitor.Address = m.lnAddress + 4
			This.rcWork.Address = m.lnAddress + 20
		Endif
	Endproc

	Procedure cbSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure cbSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure dwFlags_Access()
		Return This.ReadUInt(This.Address + 36)
	Endproc

	Procedure dwFlags_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 36, m.lnNewVal)
	Endproc

	Procedure szDevice_Access()
		Return This.ReadCharArray(This.Address + 40, 32)
	Endproc

	Procedure szDevice_Assign(m.lnNewVal)
		This.WriteCharArray(This.Address + 40, m.lnNewVal, 32)
	Endproc

Enddefine	&& ctlMonitorInfoEx

********************************************************************************
*!*	typedef struct tagMEASUREITEMSTRUCT {
*!*	  UINT CtlType;
*!*	  UINT CtlID;
*!*	  UINT itemID;
*!*	  UINT itemWidth;
*!*   UINT itemHeight;
*!*   DWORD itemData
*!*	} MEASUREITEMSTRUCT;
********************************************************************************
Define Class ctlMEASUREITEMSTRUCT As ctlStructure

	SizeOf = 24
	Name = "MEASUREITEMSTRUCT"
	&& structure fields
	CtlType = FALSE
	CtlID = FALSE
	ItemID = FALSE
	itemWidth = FALSE
	itemHeight = FALSE
	ItemData = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="ctltype" type="property" display="CtlType"/>' + ;
		'<memberdata name="ctlid" type="property" display="CtlID"/>' + ;
		'<memberdata name="itemid" type="property" display="itemID"/>' + ;
		'<memberdata name="itemwidth" type="property" display="itemWidth"/>' + ;
		'<memberdata name="itemheight" type="property" display="itemHeight"/>' + ;
		'<memberdata name="itemdata" type="property" display="itemData"/>' + ;
		'</VFPData>'

	Procedure CtlType_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure CtlType_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure CtlID_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure CtlID_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure itemID_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Procedure itemID_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure itemWidth_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure itemWidth_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure itemHeight_Access()
		Return This.ReadUInt(This.Address + 16)
	Endproc

	Procedure itemHeight_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure itemData_Access()
		Return This.ReadUInt(This.Address + 20)
	Endproc

	Procedure itemData_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 20, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagDRAWITEMSTRUCT {
*!*	  UINT CtlType;
*!*	  UINT CtlID;
*!*	  UINT itemID;
*!*	  UINT itemAction;
*!*	  UINT itemState;
*!*	  HWND hwndItem;
*!*	  HDC hDC;
*!*	  RECT rcItem;
*!*	  ULONG_PTR itemData;
*!*	} DRAWITEMSTRUCT;
********************************************************************************
Define Class ctlDRAWITEMSTRUCT As ctlStructure

	SizeOf = 48
	Name = "DRAWITEMSTRUCT"
	&& structure fields
	CtlType = FALSE
	CtlID = FALSE
	ItemID = FALSE
	itemAction = FALSE
	itemState = FALSE
	hwndItem = FALSE
	hDC = FALSE
	rcItem = .Null.
	ItemData = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="ctltype" type="property" display="CtlType"/>' + ;
		'<memberdata name="ctlid" type="property" display="CtlID"/>' + ;
		'<memberdata name="itemid" type="property" display="itemID"/>' + ;
		'<memberdata name="itemaction" type="property" display="itemAction"/>' + ;
		'<memberdata name="itemstate" type="property" display="itemState"/>' + ;
		'<memberdata name="hwnditem" type="property" display="hwndItem"/>' + ;
		'<memberdata name="hdc" type="property" display="hDC"/>' + ;
		'<memberdata name="rcitem" type="property" display="rcItem"/>' + ;
		'<memberdata name="itemdata" type="property" display="itemData"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.rcItem = Createobject('ctlRect',This.Address + 28)
	Endproc

	Procedure FreeMembers()
		This.rcItem = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.rcItem.Address = m.lnAddress + 28
		Endif
	Endproc

	Procedure CtlType_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure CtlType_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure CtlID_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure CtlID_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure itemID_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Procedure itemID_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure itemAction_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure itemAction_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure itemState_Access()
		Return This.ReadUInt(This.Address + 16)
	Endproc

	Procedure itemState_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure hwndItem_Access()
		Return This.ReadUInt(This.Address + 20)
	Endproc

	Procedure hwndItem_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 20, m.lnNewVal)
	Endproc

	Procedure hDC_Access()
		Return This.ReadPointer(This.Address + 24)
	Endproc

	Procedure hDC_Assign(m.lnNewVal)
		This.WritePointer(This.Address + 24, m.lnNewVal)
	Endproc

	Procedure itemData_Access()
		Return This.ReadUInt(This.Address + 44)
	Endproc

	Procedure itemData_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 44, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagSCROLLINFO {
*!*	    UINT cbSize;
*!*	    UINT fMask;
*!*	    int  nMin;
*!*	    int  nMax;
*!*	    UINT nPage;
*!*	    int  nPos;
*!*	    int  nTrackPos;
*!*	}   SCROLLINFO, *LPSCROLLINFO;
*!*	typedef SCROLLINFO CONST *LPCSCROLLINFO;
********************************************************************************
Define Class ctlSCROLLINFO As ctlStructure

	SizeOf = 28
	Name = "SCROLLINFO"
	&& structure fields
	cbSize = FALSE
	fMask = FALSE
	nMin = FALSE
	nMax = FALSE
	nPage = FALSE
	nPos = FALSE
	nTrackPos = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="cbsize" type="property" display="cbSize"/>' + ;
		'<memberdata name="fmask" type="property" display="fMask"/>' + ;
		'<memberdata name="nmin" type="property" display="nMin"/>' + ;
		'<memberdata name="nmax" type="property" display="nMax"/>' + ;
		'<memberdata name="npage" type="property" display="nPage"/>' + ;
		'<memberdata name="npos" type="property" display="nPos"/>' + ;
		'<memberdata name="ntrackpos" type="property" display="nTrackPos"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		*!* Important! init cbSize to size of structure
		This.cbSize = This.SizeOf
	Endproc

	Procedure cbSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure cbSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure fMask_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure fMask_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure nMin_Access()
		Return This.ReadInt(This.Address + 8)
	Endproc

	Procedure nMin_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure nMax_Access()
		Return This.ReadInt(This.Address + 12)
	Endproc

	Procedure nMax_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure nPage_Access()
		Return This.ReadUInt(This.Address + 16)
	Endproc

	Procedure nPage_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure nPos_Access()
		Return This.ReadInt(This.Address + 20)
	Endproc

	Procedure nPos_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 20, m.lnNewVal)
	Endproc

	Procedure nTrackPos_Access()
		Return This.ReadInt(This.Address + 24)
	Endproc

	Procedure nTrackPos_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 24, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagNMHDR {
*!*	  HWND hwndFrom;
*!*	  UINT_PTR idFrom;
*!*	  UINT code;
*!*	} NMHDR;
********************************************************************************
Define Class ctlNMHDR As ctlStructure

	SizeOf = 12
	Name = "NMHDR"
	&& structure fields
	hwndFrom = FALSE
	idFrom = FALSE
	Code = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="hwndfrom" type="property" display="hwndFrom"/>' + ;
		'<memberdata name="idfrom" type="property" display="idFrom"/>' + ;
		'<memberdata name="code" type="property" display="Code"/>' + ;
		'</VFPData>'

	Procedure hwndFrom_Access()
		Return This.ReadInt(This.Address)
	Endproc

	Procedure hwndFrom_Assign(m.lnNewVal)
		This.WriteInt(This.Address, m.lnNewVal)
	Endproc

	Procedure idFrom_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure idFrom_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure Code_Access()
		*!* Code is a UINT but it should be an INT
		Return This.ReadInt(This.Address + 8)
	Endproc

	Procedure Code_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 8, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagNMMOUSE {
*!*	    NMHDR hdr;
*!*	    DWORD_PTR dwItemSpec;
*!*	    DWORD_PTR dwItemData;
*!*	    POINT pt;
*!*	    LPARAM dwHitInfo;
*!*	} NMMOUSE, *LPNMMOUSE;
********************************************************************************
Define Class ctlNMMOUSE As ctlStructure

	SizeOf = 32
	Name = "NMMOUSE"
	&& structure fields
	hdr = .Null.
	dwItemSpec = FALSE
	dwItemData = FALSE
	pt = .Null.
	dwHitInfo = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="hdr" type="property" display="hdr"/>' + ;
		'<memberdata name="dwitemspec" type="property" display="dwItemSpec"/>' + ;
		'<memberdata name="dwitemdata" type="property" display="dwItemData"/>' + ;
		'<memberdata name="pt" type="property" display="pt"/>' + ;
		'<memberdata name="dwhitinfo" type="property" display="dwHitInfo"/>' + ;
		'</VFPData>'

	Procedure InitMembers
		This.hdr = Createobject('ctlNMHDR',This.Address + 0)
		This.pt = Createobject('ctlPOINT',This.Address + 20)
	Endproc

	Procedure FreeMembers()
		This.hdr = .Null.
		This.pt = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.hdr.Address = m.lnAddress + 0
			This.pt.Address = m.lnAddress + 20
		Endif
	Endproc

	Procedure dwItemSpec_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure dwItemSpec_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure dwItemData_Access()
		Return This.ReadUInt(This.Address + 16)
	Endproc

	Procedure dwItemData_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure dwHitInfo_Access()
		Return This.ReadInt(This.Address + 28)
	Endproc

	Procedure dwHitInfo_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 28, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct {
*!*	  DWORD dwStructSize;
*!*	  LPTSTR lpszScheme;
*!*	  DWORD dwSchemeLength;
*!*	  INTERNET_SCHEME nScheme;
*!*	  LPTSTR lpszHostName;
*!*	  DWORD dwHostNameLength;
*!*	  INTERNET_PORT nPort;
*!*	  LPTSTR lpszUserName;
*!*	  DWORD dwUserNameLength;
*!*	  LPTSTR lpszPassword;
*!*	  DWORD dwPasswordLength;
*!*	  LPTSTR lpszUrlPath;
*!*	  DWORD dwUrlPathLength;
*!*	  LPTSTR lpszExtraInfo;
*!*	  DWORD dwExtraInfoLength;
*!*	} URL_COMPONENTS,
*!*	*LPURL_COMPONENTS;
********************************************************************************
Define Class ctlURL_COMPONENTS As ctlStructure

	SizeOf = 60
	Name = "URL_COMPONENTS"
	&& structure fields
	dwStructSize = FALSE
	lpszScheme = FALSE
	dwSchemeLength = FALSE
	nScheme = FALSE
	lpszHostName = FALSE
	dwHostNameLength = FALSE
	nPort = FALSE
	lpszUserName = FALSE
	dwUserNameLength = FALSE
	lpszPassword = FALSE
	dwPasswordLength = FALSE
	lpszUrlPath = FALSE
	dwUrlPathLength = FALSE
	lpszExtraInfo = FALSE
	dwExtraInfoLength = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="dwstructsize" type="property" display="dwStructSize"/>' + ;
		'<memberdata name="lpszscheme" type="property" display="lpszScheme"/>' + ;
		'<memberdata name="dwschemelength" type="property" display="dwSchemeLength"/>' + ;
		'<memberdata name="nscheme" type="property" display="nScheme"/>' + ;
		'<memberdata name="lpszhostname" type="property" display="lpszHostName"/>' + ;
		'<memberdata name="dwhostnamelength" type="property" display="dwHostNameLength"/>' + ;
		'<memberdata name="nport" type="property" display="nPort"/>' + ;
		'<memberdata name="lpszusername" type="property" display="lpszUserName"/>' + ;
		'<memberdata name="dwusernamelength" type="property" display="dwUserNameLength"/>' + ;
		'<memberdata name="lpszpassword" type="property" display="lpszPassword"/>' + ;
		'<memberdata name="dwpasswordlength" type="property" display="dwPasswordLength"/>' + ;
		'<memberdata name="lpszurlpath" type="property" display="lpszUrlPath"/>' + ;
		'<memberdata name="dwurlpathlength" type="property" display="dwUrlPathLength"/>' + ;
		'<memberdata name="lpszextrainfo" type="property" display="lpszExtraInfo"/>' + ;
		'<memberdata name="dwextrainfolength" type="property" display="dwExtraInfoLength"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.dwStructSize = 60
	Endproc

	Procedure FreeMembers()
		This.FreePMem(This.Address + 4)
		This.FreePMem(This.Address + 16)
		This.FreePMem(This.Address + 28)
		This.FreePMem(This.Address + 36)
		This.FreePMem(This.Address + 44)
		This.FreePMem(This.Address + 52)
	Endproc

	Procedure dwStructSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure dwStructSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure lpszScheme_Access()
		Return This.ReadPCString(This.Address + 4)
	Endproc

	Procedure lpszScheme_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 4, m.lnNewVal)
		This.dwSchemeLength = Len(m.lnNewVal)
	Endproc

	Procedure dwSchemeLength_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Procedure dwSchemeLength_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure nScheme_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure nScheme_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure lpszHostName_Access()
		Return This.ReadPCString(This.Address + 16)
	Endproc

	Procedure lpszHostName_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 16, m.lnNewVal)
		This.dwHostNameLength = Len(m.lnNewVal)
	Endproc

	Procedure dwHostNameLength_Access()
		Return This.ReadUInt(This.Address + 20)
	Endproc

	Procedure dwHostNameLength_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 20, m.lnNewVal)
	Endproc

	Procedure nPort_Access()
		Return This.ReadUInt(This.Address + 24)
	Endproc

	Procedure nPort_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 24, m.lnNewVal)
	Endproc

	Procedure lpszUserName_Access()
		Return This.ReadPCString(This.Address + 28)
	Endproc

	Procedure lpszUserName_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 28, m.lnNewVal)
		This.dwUserNameLength = Len(m.lnNewVal)
	Endproc

	Procedure dwUserNameLength_Access()
		Return This.ReadUInt(This.Address + 32)
	Endproc

	Procedure dwUserNameLength_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 32, m.lnNewVal)
	Endproc

	Procedure lpszPassword_Access()
		Return This.ReadPCString(This.Address + 36)
	Endproc

	Procedure lpszPassword_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 36, m.lnNewVal)
		This.dwPasswordLength = Len(m.lnNewVal)
	Endproc

	Procedure dwPasswordLength_Access()
		Return This.ReadUInt(This.Address + 40)
	Endproc

	Procedure dwPasswordLength_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 40, m.lnNewVal)
	Endproc

	Procedure lpszUrlPath_Access()
		Return This.ReadPCString(This.Address + 44)
	Endproc

	Procedure lpszUrlPath_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 44, m.lnNewVal)
		This.dwUrlPathLength = Len(m.lnNewVal)
	Endproc

	Procedure dwUrlPathLength_Access()
		Return This.ReadUInt(This.Address + 48)
	Endproc

	Procedure dwUrlPathLength_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 48, m.lnNewVal)
	Endproc

	Procedure lpszExtraInfo_Access()
		Return This.ReadPCString(This.Address + 52)
	Endproc

	Procedure lpszExtraInfo_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 52, m.lnNewVal)
		This.dwExtraInfoLength = Len(m.lnNewVal)
	Endproc

	Procedure dwExtraInfoLength_Access()
		Return This.ReadUInt(This.Address + 56)
	Endproc

	Procedure dwExtraInfoLength_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 56, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct _WIN32_FIND_DATA {
*!*	  DWORD dwFileAttributes;
*!*	  FILETIME ftCreationTime;
*!*	  FILETIME ftLastAccessTime;
*!*	  FILETIME ftLastWriteTime;
*!*	  DWORD nFileSizeHigh;
*!*	  DWORD nFileSizeLow;
*!*	  DWORD dwReserved0;
*!*	  DWORD dwReserved1;
*!*	  TCHAR cFileName[MAX_PATH];
*!*	  TCHAR cAlternateFileName[14];
*!*	} WIN32_FIND_DATA,
*!*	  *PWIN32_FIND_DATA,
*!*	  *LPWIN32_FIND_DATA;
********************************************************************************
Define Class ctlWIN32_FIND_DATA As ctlStructure

	SizeOf = 320
	Name = "WIN32_FIND_DATA"
	&& structure fields
	dwFileAttributes = FALSE
	ftCreationTime = .Null.
	ftLastAccessTime = .Null.
	ftLastWriteTime = .Null.
	nFileSizeHigh = FALSE
	nFileSizeLow = FALSE
	dwReserved0 = FALSE
	dwReserved1 = FALSE
	cFileName = FALSE
	cAlternateFileName = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="dwfileattributes" type="property" display="dwFileAttributes"/>' + ;
		'<memberdata name="ftcreationtime" type="property" display="ftCreationTime"/>' + ;
		'<memberdata name="ftlastaccesstime" type="property" display="ftLastAccessTime"/>' + ;
		'<memberdata name="ftlastwritetime" type="property" display="ftLastWriteTime"/>' + ;
		'<memberdata name="nfilesizehigh" type="property" display="nFileSizeHigh"/>' + ;
		'<memberdata name="nfilesizelow" type="property" display="nFileSizeLow"/>' + ;
		'<memberdata name="dwreserved0" type="property" display="dwReserved0"/>' + ;
		'<memberdata name="dwreserved1" type="property" display="dwReserved1"/>' + ;
		'<memberdata name="cfilename" type="property" display="cFileName"/>' + ;
		'<memberdata name="calternatefilename" type="property" display="cAlternateFileName"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.ftCreationTime = Createobject('ctlFILETIME', This.Address + 4)
		This.ftLastAccessTime = Createobject('ctlFILETIME', This.Address + 12)
		This.ftLastWriteTime = Createobject('ctlFILETIME', This.Address + 20)
	Endproc

	Procedure FreeMembers()
		This.ftCreationTime = .Null.
		This.ftLastAccessTime = .Null.
		This.ftLastWriteTime = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.ftCreationTime.Address = m.lnAddress + 4
			This.ftLastAccessTime.Address = m.lnAddress + 12
			This.ftLastWriteTime.Address = m.lnAddress + 20
		Endif
	Endproc

	Procedure dwFileAttributes_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure dwFileAttributes_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure nFileSizeHigh_Access()
		Return This.ReadUInt(This.Address + 28)
	Endproc

	Procedure nFileSizeHigh_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 28, m.lnNewVal)
	Endproc

	Procedure nFileSizeLow_Access()
		Return This.ReadUInt(This.Address + 32)
	Endproc

	Procedure nFileSizeLow_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 32, m.lnNewVal)
	Endproc

	Procedure dwReserved0_Access()
		Return This.ReadUInt(This.Address + 36)
	Endproc

	Procedure dwReserved0_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 36, m.lnNewVal)
	Endproc

	Procedure dwReserved1_Access()
		Return This.ReadUInt(This.Address + 40)
	Endproc

	Procedure dwReserved1_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 40, m.lnNewVal)
	Endproc

	Procedure cFileName_Access()
		Return This.ReadCharArray(This.Address + 44, MAX_PATH)
	Endproc

	Procedure cFileName_Assign(m.lnNewVal)
		This.WriteCharArray(This.Address + 44, Padr(m.lnNewVal, MAX_PATH, NULCHAR), MAX_PATH)
	Endproc

	Procedure cAlternateFileName_Access()
		Return This.ReadCharArray(This.Address + 44 + MAX_PATH, 14)
	Endproc

	Procedure cAlternateFileName_Assign(m.lnNewVal)
		This.WriteCharArray(This.Address + 44 + MAX_PATH, Padr(m.lnNewVal, 14, NULCHAR), 14)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct _SYSTEMTIME {
*!*	  WORD wYear;
*!*	  WORD wMonth;
*!*	  WORD wDayOfWeek;
*!*	  WORD wDay;
*!*	  WORD wHour;
*!*	  WORD wMinute;
*!*	  WORD wSecond;
*!*	  WORD wMilliseconds;
*!*	} SYSTEMTIME,  *PSYSTEMTIME;
********************************************************************************
Define Class ctlSYSTEMTIME As ctlStructure

	SizeOf = 16
	Name = "SYSTEMTIME"
	&& structure fields
	wYear = FALSE
	wMonth = FALSE
	wDayOfWeek = FALSE
	wDay = FALSE
	wHour = FALSE
	wMinute = FALSE
	wSecond = FALSE
	wMilliseconds = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="wyear" type="property" display="wYear"/>' + ;
		'<memberdata name="wmonth" type="property" display="wMonth"/>' + ;
		'<memberdata name="wdayofweek" type="property" display="wDayOfWeek"/>' + ;
		'<memberdata name="wday" type="property" display="wDay"/>' + ;
		'<memberdata name="whour" type="property" display="wHour"/>' + ;
		'<memberdata name="wminute" type="property" display="wMinute"/>' + ;
		'<memberdata name="wsecond" type="property" display="wSecond"/>' + ;
		'<memberdata name="wmilliseconds" type="property" display="wMilliseconds"/>' + ;
		'</VFPData>'

	Procedure wYear_Access()
		Return This.ReadUShort(This.Address)
	Endproc

	Procedure wYear_Assign(m.lnNewVal)
		This.WriteUShort(This.Address, m.lnNewVal)
	Endproc

	Procedure wMonth_Access()
		Return This.ReadUShort(This.Address + 2)
	Endproc

	Procedure wMonth_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 2, m.lnNewVal)
	Endproc

	Procedure wDayOfWeek_Access()
		Return This.ReadUShort(This.Address + 4)
	Endproc

	Procedure wDayOfWeek_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure wDay_Access()
		Return This.ReadUShort(This.Address + 6)
	Endproc

	Procedure wDay_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 6, m.lnNewVal)
	Endproc

	Procedure wHour_Access()
		Return This.ReadUShort(This.Address + 8)
	Endproc

	Procedure wHour_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure wMinute_Access()
		Return This.ReadUShort(This.Address + 10)
	Endproc

	Procedure wMinute_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 10, m.lnNewVal)
	Endproc

	Procedure wSecond_Access()
		Return This.ReadUShort(This.Address + 12)
	Endproc

	Procedure wSecond_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure wMilliseconds_Access()
		Return This.ReadUShort(This.Address + 14)
	Endproc

	Procedure wMilliseconds_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 14, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct _FILETIME {
*!*	 DWORD dwLowDateTime;
*!*	 DWORD dwHighDateTime;
*!*	} FILETIME,
*!*	 *PFILETIME;
********************************************************************************
Define Class ctlFILETIME As ctlStructure

	SizeOf = 8
	Name = "FILETIME"
	&& structure fields
	dwLowDateTime = FALSE
	dwHighDateTime = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="dwlowdatetime" type="property" display="dwLowDateTime"/>' + ;
		'<memberdata name="dwhighdatetime" type="property" display="dwHighDateTime"/>' + ;
		'</VFPData>'

	Procedure dwLowDateTime_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure dwLowDateTime_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure dwHighDateTime_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure dwHighDateTime_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagSIZE {
*!*	  LONG cx;
*!*	  LONG cy;
*!*	} SIZE, *PSIZE;
********************************************************************************
Define Class ctlSIZE As ctlStructure
	SizeOf = 8
	Name = "SIZE"
	&& structure fields
	cx = FALSE
	cy = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="cx" type="property" display="cx"/>' + ;
		'<memberdata name="cy" type="property" display="cy"/>' + ;
		'</VFPData>'

	Procedure cx_Access()
		Return This.ReadInt(This.Address)
	Endproc

	Procedure cx_Assign(m.lnNewVal)
		This.WriteInt(This.Address, m.lnNewVal)
	Endproc

	Procedure cy_Access()
		Return This.ReadInt(This.Address + 4)
	Endproc

	Procedure cy_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 4, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagTOOLINFO{
*!*	    UINT      cbSize;
*!*	    UINT      uFlags;
*!*	    HWND      hwnd;
*!*	    UINT_PTR  uId;
*!*	    RECT      rect;
*!*	    HINSTANCE hinst;
*!*	    LPTSTR    lpszText;
*!*	#if (_WIN32_IE >= 0x0300)
*!*	    LPARAM lParam;
*!*	#endif
*!*	#if (_WIN32_WINNT >= 0x0501)
*!*	    void *lpReserved;
*!*	#endif
*!*	} TOOLINFO, NEAR *PTOOLINFO, *LPTOOLINFO;
********************************************************************************
Define Class ctlTOOLINFO As ctlStructure
	SizeOf = 48
	Name = "TOOLINFO"
	&& structure fields
	cbSize = FALSE
	uFlags = FALSE
	HWnd = FALSE
	uId = FALSE
	Rect = .Null.
	hinst = FALSE
	lpszText = FALSE
	Lparam = FALSE
	*!* if ctlOsVersion >= 5010000
	lpReserved = FALSE
	*!* Endif

	_MemberData = '<VFPData>' + ;
		'<memberdata name="cbsize" type="property" display="cbSize"/>' + ;
		'<memberdata name="uflags" type="property" display="uFlags"/>' + ;
		'<memberdata name="hwnd" type="property" display="hwnd"/>' + ;
		'<memberdata name="uid" type="property" display="uId"/>' + ;
		'<memberdata name="rect" type="property" display="rect"/>' + ;
		'<memberdata name="hinst" type="property" display="hinst"/>' + ;
		'<memberdata name="lpsztext" type="property" display="lpszText"/>' + ;
		'<memberdata name="lparam" type="property" display="lParam"/>' + ;
		'<memberdata name="*lpreserved" type="property" display="*lpReserved"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		If ctlGetOsVersion() < NTDDI_WINXP Then
			This.SizeOf = 44
		Else
			This.SizeOf = 48
		Endif

		This.cbSize = This.SizeOf
		This.Rect = Createobject('ctlRECT',This.Address + 16)
	Endproc

	Procedure FreeMembers()
		This.Rect = .Null.
		This.FreePMem(This.Address + 36)
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.Rect.Address = m.lnAddress + 16
		Endif
	Endproc

	Procedure cbSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure cbSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure uFlags_Access()
		Return This.ReadUInt(This.Address + 4)
	Endproc

	Procedure uFlags_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure hwnd_Access()
		Return This.ReadInt(This.Address + 8)
	Endproc

	Procedure hwnd_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure uId_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure uId_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure hinst_Access()
		Return This.ReadPointer(This.Address + 32)
	Endproc

	Procedure hinst_Assign(m.lnNewVal)
		This.WritePointer(This.Address + 32, m.lnNewVal)
	Endproc

	Procedure lpszText_Access()
		Return This.ReadPCString(This.Address + 36)
	Endproc

	Procedure lpszText_Assign(m.lnNewVal)
		This.WritePCString(This.Address + 36, m.lnNewVal)
	Endproc

	Procedure lParam_Access()
		Return This.ReadInt(This.Address + 40)
	Endproc

	Procedure lParam_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 40, m.lnNewVal)
	Endproc

	Procedure lpReserved_Access()
		Return This.ReadPointer(This.Address  +  44)
	Endproc

	Procedure lpReserved_Assign(m.lnNewVal)
		This.WritePointer(This.Address + 44, m.lnNewVal)
Enddefine

********************************************************************************
*!*	typedef struct tagLOGFONT {
*!*	  LONG lfHeight;
*!*	  LONG lfWidth;
*!*	  LONG lfEscapement;
*!*	  LONG lfOrientation;
*!*	  LONG lfWeight;
*!*	  BYTE lfItalic;
*!*	  BYTE lfUnderline;
*!*	  BYTE lfStrikeOut;
*!*	  BYTE lfCharSet;
*!*	  BYTE lfOutPrecision;
*!*	  BYTE lfClipPrecision;
*!*	  BYTE lfQuality;
*!*	  BYTE lfPitchAndFamily;
*!*	  TCHAR lfFaceName[LF_FACESIZE];
*!*	} LOGFONT, *PLOGFONT;
********************************************************************************
Define Class ctlLOGFONT As ctlStructure
	SizeOf = 60
	Name = "LOGFONT"
	&& structure fields
	lfHeight = FALSE
	lfWidth = FALSE
	lfEscapement = FALSE
	lfOrientation = FALSE
	lfWeight = FALSE
	lfItalic = FALSE
	lfUnderline = FALSE
	lfStrikeOut = FALSE
	lfCharSet = FALSE
	lfOutPrecision = FALSE
	lfClipPrecision = FALSE
	lfQuality = FALSE
	lfPitchAndFamily = FALSE
	lfFaceName = FALSE
	&& extra properties
	FontBold = FALSE
	FontCharSet = 1
	FontItalic = FALSE
	FontName = ""
	FontSize = 0
	FontStrikethru = FALSE
	FontUnderline = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="lfheight" type="property" display="lfHeight"/>' + ;
		'<memberdata name="lfwidth" type="property" display="lfWidth"/>' + ;
		'<memberdata name="lfescapement" type="property" display="lfEscapement"/>' + ;
		'<memberdata name="lforientation" type="property" display="lfOrientation"/>' + ;
		'<memberdata name="lfweight" type="property" display="lfWeight"/>' + ;
		'<memberdata name="lfitalic" type="property" display="lfItalic"/>' + ;
		'<memberdata name="lfunderline" type="property" display="lfUnderline"/>' + ;
		'<memberdata name="lfstrikeout" type="property" display="lfStrikeOut"/>' + ;
		'<memberdata name="lfcharset" type="property" display="lfCharSet"/>' + ;
		'<memberdata name="lfoutprecision" type="property" display="lfOutPrecision"/>' + ;
		'<memberdata name="lfclipprecision" type="property" display="lfClipPrecision"/>' + ;
		'<memberdata name="lfquality" type="property" display="lfQuality"/>' + ;
		'<memberdata name="lfpitchandfamily" type="property" display="lfPitchAndFamily"/>' + ;
		'<memberdata name="lffacename" type="property" display="lfFaceName"/>' + ;
		'<memberdata name="fontbold" type="property" display="FontBold"/>' + ;
		'<memberdata name="fontcharset" type="property" display="FontCharSet"/>' + ;
		'<memberdata name="fontitalic" type="property" display="FontItalic"/>' + ;
		'<memberdata name="fontname" type="property" display="FontName"/>' + ;
		'<memberdata name="fontsize" type="property" display="FontSize"/>' + ;
		'<memberdata name="fontstrikethru" type="property" display="FontStrikethru"/>' + ;
		'<memberdata name="fontunderline" type="property" display="FontUnderline"/>' + ;
		'</VFPData>'

	Procedure FontBold_Access()
		Return Iif(This.lfWeight >= FW_BOLD, TRUE, FALSE)
	Endproc

	Procedure FontBold_Assign(m.vNewVal)
		If Vartype(m.vNewVal) = T_NUMERIC Then
			If m.vNewVal < FW_BOLD Then
				m.vNewVal = FALSE
			Else
				m.vNewVal = TRUE
			Endif
		Endif
		If m.vNewVal = TRUE Then
			This.lfWeight = FW_BOLD
		Else
			This.lfWeight = FW_NORMAL
		Endif
	Endproc

	Procedure FontCharset_Access()
		Return This.lfCharSet
	Endproc

	Procedure FontCharset_Assign(m.vNewVal)
		This.lfCharSet = m.vNewVal
	Endproc

	Procedure FontItalic_Access()
		Return Iif(This.lfItalic <> 0, TRUE, FALSE)
	Endproc

	Procedure FontItalic_Assign(m.vNewVal)
		If Vartype(m.vNewVal) = T_NUMERIC Then
			If m.vNewVal = 0 Then
				m.vNewVal = FALSE
			Else
				m.vNewVal = TRUE
			Endif
		Endif
		If m.vNewVal = TRUE Then
			This.lfItalic = 1
		Else
			This.lfItalic = 0
		Endif
	Endproc

	Procedure FontName_Access()
		Return This.lfFaceName
	Endproc

	Procedure FontName_Assign(m.vNewVal)
		If Right(m.vNewVal, 1) <> NULCHAR Then
			m.vNewVal = m.vNewVal + NULCHAR
		Endif
		This.lfFaceName = m.vNewVal
	Endproc

	Procedure FontSize_Access()
		Return ctlFontHeightToPoints(This.lfHeight)
	Endproc

	Procedure FontSize_Assign(m.vNewVal)
		This.lfHeight = ctlFontPointsToHeight(m.vNewVal)
	Endproc

	Procedure FontStrikethru_Access()
		Return Iif(This.lfStrikeOut <> 0, TRUE, FALSE)
	Endproc

	Procedure FontStrikethru_Assign(m.vNewVal)
		If Vartype(m.vNewVal) = T_NUMERIC Then
			If m.vNewVal = 0 Then
				m.vNewVal = FALSE
			Else
				m.vNewVal = TRUE
			Endif
		Endif
		If m.vNewVal = TRUE Then
			This.lfStrikeOut = 1
		Else
			This.lfStrikeOut = 0
		Endif
	Endproc

	Procedure FontUnderline_Access()
		Return Iif(This.lfUnderline <> 0, TRUE, FALSE)
	Endproc

	Procedure FontUnderline_Assign(m.vNewVal)
		If Vartype(m.vNewVal) = T_NUMERIC Then
			If m.vNewVal = 0 Then
				m.vNewVal = FALSE
			Else
				m.vNewVal = TRUE
			Endif
		Endif
		If m.vNewVal = TRUE Then
			This.lfUnderline = 1
		Else
			This.lfUnderline = 0
		Endif
	Endproc

	Procedure lfHeight_Access()
		Return This.ReadInt(This.Address)
	Endproc

	Procedure lfHeight_Assign(m.lnNewVal)
		This.WriteInt(This.Address, m.lnNewVal)
	Endproc

	Procedure lfWidth_Access()
		Return This.ReadInt(This.Address + 4)
	Endproc

	Procedure lfWidth_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure lfEscapement_Access()
		Return This.ReadInt(This.Address + 8)
	Endproc

	Procedure lfEscapement_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure lfOrientation_Access()
		Return This.ReadInt(This.Address + 12)
	Endproc

	Procedure lfOrientation_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure lfWeight_Access()
		Return This.ReadInt(This.Address + 16)
	Endproc

	Procedure lfWeight_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure lfItalic_Access()
		Return This.ReadBytes(This.Address + 20)
	Endproc

	Procedure lfItalic_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 20, m.lnNewVal)
	Endproc

	Procedure lfUnderline_Access()
		Return This.ReadBytes(This.Address + 21)
	Endproc

	Procedure lfUnderline_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 21, m.lnNewVal)
	Endproc

	Procedure lfStrikeOut_Access()
		Return This.ReadBytes(This.Address + 22)
	Endproc

	Procedure lfStrikeOut_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 22, m.lnNewVal)
	Endproc

	Procedure lfCharSet_Access()
		Return This.ReadBytes(This.Address + 23)
	Endproc

	Procedure lfCharSet_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 23, m.lnNewVal)
	Endproc

	Procedure lfOutPrecision_Access()
		Return This.ReadBytes(This.Address + 24)
	Endproc

	Procedure lfOutPrecision_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 24, m.lnNewVal)
	Endproc

	Procedure lfClipPrecision_Access()
		Return This.ReadBytes(This.Address + 25)
	Endproc

	Procedure lfClipPrecision_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 25, m.lnNewVal)
	Endproc

	Procedure lfQuality_Access()
		Return This.ReadBytes(This.Address + 26)
	Endproc

	Procedure lfQuality_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 26, m.lnNewVal)
	Endproc

	Procedure lfPitchAndFamily_Access()
		Return This.ReadBytes(This.Address + 27)
	Endproc

	Procedure lfPitchAndFamily_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 27, m.lnNewVal)
	Endproc

	Procedure lfFaceName_Access()
		Return This.ReadCharArray(This.Address + 28,32)
	Endproc

	Procedure lfFaceName_Assign(m.lnNewVal)
		This.WriteCharArray(This.Address + 28, m.lnNewVal,32)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagBITMAPINFOHEADER{
*!*	  DWORD  biSize;
*!*	  LONG   biWidth;
*!*	  LONG   biHeight;
*!*	  WORD   biPlanes;
*!*	  WORD   biBitCount;
*!*	  DWORD  biCompression;
*!*	  DWORD  biSizeImage;
*!*	  LONG   biXPelsPerMeter;
*!*	  LONG   biYPelsPerMeter;
*!*	  DWORD  biClrUsed;
*!*	  DWORD  biClrImportant;
*!*	} BITMAPINFOHEADER, *PBITMAPINFOHEADER;
********************************************************************************
Define Class ctlBITMAPINFOHEADER As ctlStructure

	SizeOf = 40
	Name = "BITMAPINFOHEADER"
	&& structure fields
	biSize = FALSE
	biWidth = FALSE
	biHeight = FALSE
	biPlanes = FALSE
	biBitCount = FALSE
	biCompression = FALSE
	biSizeImage = FALSE
	biXPelsPerMeter = FALSE
	biYPelsPerMeter = FALSE
	biClrUsed = FALSE
	biClrImportant = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="bisize" type="property" display="biSize"/>' + ;
		'<memberdata name="biwidth" type="property" display="biWidth"/>' + ;
		'<memberdata name="biheight" type="property" display="biHeight"/>' + ;
		'<memberdata name="biplanes" type="property" display="biPlanes"/>' + ;
		'<memberdata name="bibitcount" type="property" display="biBitCount"/>' + ;
		'<memberdata name="bicompression" type="property" display="biCompression"/>' + ;
		'<memberdata name="bisizeimage" type="property" display="biSizeImage"/>' + ;
		'<memberdata name="bixpelspermeter" type="property" display="biXPelsPerMeter"/>' + ;
		'<memberdata name="biypelspermeter" type="property" display="biYPelsPerMeter"/>' + ;
		'<memberdata name="biclrused" type="property" display="biClrUsed"/>' + ;
		'<memberdata name="biclrimportant" type="property" display="biClrImportant"/>' + ;
		'</VFPData>'

	Procedure biSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure biSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure biWidth_Access()
		Return This.ReadInt(This.Address + 4)
	Endproc

	Procedure biWidth_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure biHeight_Access()
		Return This.ReadInt(This.Address + 8)
	Endproc

	Procedure biHeight_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure biPlanes_Access()
		Return This.ReadUShort(This.Address + 12)
	Endproc

	Procedure biPlanes_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure biBitCount_Access()
		Return This.ReadUShort(This.Address + 14)
	Endproc

	Procedure biBitCount_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 14, m.lnNewVal)
	Endproc

	Procedure biCompression_Access()
		Return This.ReadUInt(This.Address + 16)
	Endproc

	Procedure biCompression_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure biSizeImage_Access()
		Return This.ReadUInt(This.Address + 20)
	Endproc

	Procedure biSizeImage_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 20, m.lnNewVal)
	Endproc

	Procedure biXPelsPerMeter_Access()
		Return This.ReadInt(This.Address + 24)
	Endproc

	Procedure biXPelsPerMeter_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 24, m.lnNewVal)
	Endproc

	Procedure biYPelsPerMeter_Access()
		Return This.ReadInt(This.Address + 28)
	Endproc

	Procedure biYPelsPerMeter_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 28, m.lnNewVal)
	Endproc

	Procedure biClrUsed_Access()
		Return This.ReadUInt(This.Address + 32)
	Endproc

	Procedure biClrUsed_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 32, m.lnNewVal)
	Endproc

	Procedure biClrImportant_Access()
		Return This.ReadUInt(This.Address + 36)
	Endproc

	Procedure biClrImportant_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 36, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct
*!*	{
*!*	    BYTE        bWidth;          // Width, in pixels, of the image
*!*	    BYTE        bHeight;         // Height, in pixels, of the image
*!*	    BYTE        bColorCount;     // Number of colors in image (0 if >=8bpp)
*!*	    BYTE        bReserved;       // Reserved ( must be 0)
*!*	    WORD        wPlanes;         // Color Planes
*!*	    WORD        wBitCount;       // Bits per pixel
*!*	    DWORD       dwBytesInRes;    // How many bytes in this resource?
*!*	    DWORD       dwImageOffset;   // Where in the file is this image?
*!*	} ICONDIRENTRY, *LPICONDIRENTRY;
********************************************************************************
Define Class ctlICONDIRENTRY As ctlStructure

	SizeOf = 16
	Name = "ICONDIRENTRY"
	&& structure fields
	bWidth = FALSE
	bHeight = FALSE
	bColorCount = FALSE
	bReserved = FALSE
	wPlanes = FALSE
	wBitCount = FALSE
	dwBytesInRes = FALSE
	dwImageOffset = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="bwidth" type="property" display="bWidth"/>' + ;
		'<memberdata name="bheight" type="property" display="bHeight"/>' + ;
		'<memberdata name="bcolorcount" type="property" display="bColorCount"/>' + ;
		'<memberdata name="breserved" type="property" display="bReserved"/>' + ;
		'<memberdata name="wplanes" type="property" display="wPlanes"/>' + ;
		'<memberdata name="wbitcount" type="property" display="wBitCount"/>' + ;
		'<memberdata name="dwbytesinres" type="property" display="dwBytesInRes"/>' + ;
		'<memberdata name="dwimageoffset" type="property" display="dwImageOffset"/>' + ;
		'</VFPData>'

	Procedure bWidth_Access()
		Local m.lnWidth
		m.lnWidth = This.ReadBytes(This.Address)
		If m.lnWidth < 0 Then
			m.lnWidth = m.lnWidth + 0x100
		Endif
		If m.lnWidth = 0 Then
			m.lnWidth = 256
		Endif
		Return m.lnWidth
	Endproc

	Procedure bWidth_Assign(m.lnNewVal)
		If m.lnNewVal = 256 Then
			m.lnNewVal = 0
		Endif
		If m.lnNewVal < 0 Then
			m.lnNewVal = m.lnNewVal + 0x100
		Endif
		This.WriteBytes(This.Address, m.lnNewVal)
	Endproc

	Procedure bHeight_Access()
		Local m.lnHeight
		m.lnHeight = This.ReadBytes(This.Address + 1)
		If m.lnHeight < 0 Then
			m.lnHeight = m.lnHeight + 0x100
		Endif
		If m.lnHeight = 0 Then
			m.lnHeight = 256
		Endif
		Return m.lnHeight
	Endproc

	Procedure bHeight_Assign(m.lnNewVal)
		If m.lnNewVal = 256 Then
			m.lnNewVal = 0
		Endif
		If m.lnNewVal < 0 Then
			m.lnNewVal = m.lnNewVal + 0x100
		Endif
		This.WriteBytes(This.Address + 1, m.lnNewVal)
	Endproc

	Procedure bColorCount_Access()
		Return This.ReadBytes(This.Address + 2)
	Endproc

	Procedure bColorCount_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 2, m.lnNewVal)
	Endproc

	Procedure bReserved_Access()
		Return This.ReadBytes(This.Address + 3)
	Endproc

	Procedure bReserved_Assign(m.lnNewVal)
		This.WriteBytes(This.Address + 3, m.lnNewVal)
	Endproc

	Procedure wPlanes_Access()
		Return This.ReadUShort(This.Address + 4)
	Endproc

	Procedure wPlanes_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 4, m.lnNewVal)
	Endproc

	Procedure wBitCount_Access()
		Return This.ReadUShort(This.Address + 6)
	Endproc

	Procedure wBitCount_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 6, m.lnNewVal)
	Endproc

	Procedure dwBytesInRes_Access()
		Return This.ReadUInt(This.Address + 8)
	Endproc

	Procedure dwBytesInRes_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure dwImageOffset_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure dwImageOffset_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagBITMAPFILEHEADER {
*!*	  WORD    bfType;
*!*	  DWORD   bfSize;
*!*	  WORD    bfReserved1;
*!*	  WORD    bfReserved2;
*!*	  DWORD   bfOffBits;
*!*	} BITMAPFILEHEADER, *PBITMAPFILEHEADER;
********************************************************************************
Define Class ctlBITMAPFILEHEADER As ctlStructure

	SizeOf = 14
	Name = "BITMAPFILEHEADER"
	&& structure fields
	bfType = FALSE
	bfSize = FALSE
	bfReserved1 = FALSE
	bfReserved2 = FALSE
	bfOffBits = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="bftype" type="property" display="bfType"/>' + ;
		'<memberdata name="bfsize" type="property" display="bfSize"/>' + ;
		'<memberdata name="bfreserved1" type="property" display="bfReserved1"/>' + ;
		'<memberdata name="bfreserved2" type="property" display="bfReserved2"/>' + ;
		'<memberdata name="bfoffbits" type="property" display="bfOffBits"/>' + ;
		'</VFPData>'

	Procedure bfType_Access()
		Return This.ReadUShort(This.Address)
	Endproc

	Procedure bfType_Assign(m.lnNewVal)
		This.WriteUShort(This.Address, m.lnNewVal)
	Endproc

	Procedure bfSize_Access()
		Return This.ReadUInt(This.Address + 2)
	Endproc

	Procedure bfSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 2, m.lnNewVal)
	Endproc

	Procedure bfReserved1_Access()
		Return This.ReadUShort(This.Address + 6)
	Endproc

	Procedure bfReserved1_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 6, m.lnNewVal)
	Endproc

	Procedure bfReserved2_Access()
		Return This.ReadUShort(This.Address + 8)
	Endproc

	Procedure bfReserved2_Assign(m.lnNewVal)
		This.WriteUShort(This.Address + 8, m.lnNewVal)
	Endproc

	Procedure bfOffBits_Access()
		Return This.ReadUInt(This.Address + 10)
	Endproc

	Procedure bfOffBits_Assign(m.lnNewVal)
		This.WriteUInt(This.Address+10, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagNMCUSTOMDRAWINFO {
*!*	    NMHDR hdr;
*!*	    DWORD dwDrawStage;
*!*	    HDC hdc;
*!*	    RECT rc;
*!*	    DWORD_PTR dwItemSpec;
*!*	    UINT uItemState;
*!*	    LPARAM lItemlParam;
*!*	} NMCUSTOMDRAW, *LPNMCUSTOMDRAW;
********************************************************************************
Define Class ctlNMCUSTOMDRAW As ctlStructure

	SizeOf = 48
	Name = "NMCUSTOMDRAW"
	&& structure fields
	hdr = .Null.
	dwDrawStage = FALSE
	hDC = FALSE
	rc = .Null.
	dwItemSpec = FALSE
	uItemState = FALSE
	lItemlParam = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="hdr" type="property" display="hdr"/>' + ;
		'<memberdata name="dwdrawstage" type="property" display="dwDrawStage"/>' + ;
		'<memberdata name="hdc" type="property" display="hdc"/>' + ;
		'<memberdata name="rc" type="property" display="rc"/>' + ;
		'<memberdata name="dwitemspec" type="property" display="dwItemSpec"/>' + ;
		'<memberdata name="uitemstate" type="property" display="uItemState"/>' + ;
		'<memberdata name="litemlparam" type="property" display="lItemlParam"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.hdr = Createobject('CTLNMHDR', This.Address)
		This.rc = Createobject('CTLRECT', This.Address + 20)
	Endproc

	Procedure FreeMembers()
		This.hdr = .Null.
		This.rc = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.hdr.Address = m.lnAddress
			This.rc.Address = m.lnAddress + 20
		Endif
	Endproc

	Procedure dwDrawStage_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure dwDrawStage_Assign(lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

	Procedure hDC_Access()
		Return This.ReadPointer(This.Address + 16)
	Endproc

	Procedure hDC_Assign(m.lnNewVal)
		This.WritePointer(This.Address + 16, m.lnNewVal)
	Endproc

	Procedure dwItemSpec_Access()
		Return This.ReadUInt(This.Address + 36)
	Endproc

	Procedure dwItemSpec_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 36, m.lnNewVal)
	Endproc

	Procedure uItemState_Access()
		Return This.ReadUInt(This.Address + 40)
	Endproc

	Procedure uItemState_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 40, m.lnNewVal)
	Endproc

	Procedure lItemlParam_Access()
		Return This.ReadInt(This.Address + 44)
	Endproc

	Procedure lItemlParam_Assign(m.lnNewVal)
		This.WriteInt(This.Address + 44, m.lnNewVal)
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct tagNMSELCHANGE {
*!*	    NMHDR nmhdr;
*!*	    SYSTEMTIME stSelStart;
*!*	    SYSTEMTIME stSelEnd;
*!*	} NMSELCHANGE, *LPNMSELCHANGE;
********************************************************************************
Define Class ctlNMSELCHANGE As ctlStructure

	SizeOf = 44
	Name = "NMSELCHANGE"
	&& structure fields
	nmhdr = .Null.
	stSelStart = .Null.
	stSelEnd = .Null.

	_MemberData = '<VFPData>' + ;
		'<memberdata name="nmhdr" type="property" display="nmhdr"/>' + ;
		'<memberdata name="stselstart" type="property" display="stSelStart"/>' + ;
		'<memberdata name="stselend" type="property" display="stSelEnd"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.nmhdr = Createobject('ctlNMHDR',This.Address)
		This.stSelStart = Createobject('ctlSYSTEMTIME',This.Address + 12)
		This.stSelEnd = Createobject('ctlSYSTEMTIME',This.Address + 28)
	Endproc

	Procedure FreeMembers()
		This.nmhdr = .Null.
		This.stSelStart = .Null.
		This.stSelEnd = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.Address = m.lnAddress
			This.nmhdr.Address = m.lnAddress
			This.stSelStart.Address = m.lnAddress + 12
			This.stSelEnd.Address = m.lnAddress + 28
		Endif
	Endproc

Enddefine

********************************************************************************
*!*	typedef struct {
*!*	        UINT cbSize;
*!*	        POINT pt;

*!*	        UINT uHit;   // out param
*!*	        SYSTEMTIME st;
*!*	#if (NTDDI_VERSION >= NTDDI_LONGHORN)
*!*	        RECT rc;
*!*	        int iOffset;
*!*	        int iRow;
*!*	        int iCol;
*!*	#endif
*!*	} MCHITTESTINFO, *PMCHITTESTINFO;
********************************************************************************
Define Class ctlMCHITTESTINFO As ctlStructure

	SizeOf = 32
	Name = "MCHITTESTINFO"
	&& structure fields
	cbSize = FALSE
	pt = .Null.
	uHit = FALSE
	st = .Null.

	_MemberData = '<VFPData>' + ;
		'<memberdata name="cbsize" type="property" display="cbSize"/>' + ;
		'<memberdata name="pt" type="property" display="pt"/>' + ;
		'<memberdata name="uhit" type="property" display="uHit"/>' + ;
		'<memberdata name="st" type="property" display="st"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.cbSize = This.SizeOf
		This.pt = Createobject('ctlPOINT',This.Address + 4)
		This.st = Createobject('ctlSYSTEMTIME',This.Address + 16)
	Endproc

	Procedure FreeMembers()
		This.pt = .Null.
		This.st = .Null.
	Endproc

	Procedure Address_Assign(m.lnAddress)
		This.Address = m.lnAddress
		If This.InitMembersDone = TRUE Then
			This.pt.Address = m.lnAddress + 4
			This.st.Address = m.lnAddress + 16
		Endif
	Endproc

	Procedure cbSize_Access()
		Return This.ReadUInt(This.Address)
	Endproc

	Procedure cbSize_Assign(m.lnNewVal)
		This.WriteUInt(This.Address, m.lnNewVal)
	Endproc

	Procedure uHit_Access()
		Return This.ReadUInt(This.Address + 12)
	Endproc

	Procedure uHit_Assign(m.lnNewVal)
		This.WriteUInt(This.Address + 12, m.lnNewVal)
	Endproc

Enddefine


********************************************************************************
*!*	typedef struct tagNMDAYSTATE {
*!*	    NMHDR nmhdr;
*!*	    SYSTEMTIME stStart;
*!*	    int cDayState;
*!*	    LPMONTHDAYSTATE prgDayState;
*!*	} NMDAYSTATE, *LPNMDAYSTATE;
********************************************************************************
Define Class ctlNMDAYSTATE As ctlStructure

	SizeOf = 36
	Name = "NMDAYSTATE"
	&& structure fields
	nmhdr = .Null.
	stStart = .Null.
	cDayState = FALSE
	prgDayState = FALSE

	_MemberData = '<VFPData>' + ;
		'<memberdata name="nmhdr" type="property" display="nmhdr"/>' + ;
		'<memberdata name="ststart" type="property" display="stStart"/>' + ;
		'<memberdata name="cdaystate" type="property" display="cDayState"/>' + ;
		'<memberdata name="prgdaystate" type="property" display="prgDayState"/>' + ;
		'</VFPData>'

	Procedure InitMembers()
		This.nmhdr = Createobject('ctlNMHDR',This.Address)
		This.stStart = Createobject('ctlSYSTEMTIME',This.Address + 12)
	Endproc

	Procedure FreeMembers()
		This.nmhdr = .Null.
		This.stStart = .Null.
	Endproc

	Procedure cDayState_Access()
		Return This.ReadInt(This.Address + 28)
	Endproc

	Procedure cDayState_Assign(lnNewVal)
		This.WriteInt(This.Address + 28, m.lnNewVal)
	Endproc

	Procedure prgDayState_Access()
		Return This.ReadInt(This.Address + 32)
	Endproc

	Procedure prgDayState_Assign(lnNewVal)
		This.WriteInt(This.Address + 32, m.lnNewVal)
	Endproc

Enddefine

