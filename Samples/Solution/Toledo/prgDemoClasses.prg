*** Classes for Solution member class demo.
*** JSK (9/5/2002)
*** (C) 2002 Microsoft Corporation

DEFINE CLASS prgpageclass AS Page
	BackColor=RGB(0,255,0)
	Caption="PRG Page"
ENDDEFINE

DEFINE CLASS prgoptionbuttonclass AS OptionButton
	Autosize=.T.
	BackColor=RGB(0,255,0)
	BackStyle=1
	Caption="PRG Optionbutton"
ENDDEFINE

DEFINE CLASS prgcommandbuttonclass AS CommandButton
	Autosize=.T.
	BackColor=RGB(0,255,0)
	BackStyle=1
	Caption="PRG Commandbutton"
ENDDEFINE

DEFINE CLASS prggridcolumnclass AS Column
	Width=100
	BackColor=RGB(255,0,0)
ENDDEFINE