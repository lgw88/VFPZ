*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Routine for defining the MemberClass for OptionGroups
*-*
DEFINE CLASS GKTOption AS OptionButton
	AutoSize  = .T.
	Caption   = "GKTOption"
	BackStyle = 0
	PROCEDURE GotFocus
		this.FontBold = .T.
	ENDPROC
	PROCEDURE LostFocus
		this.FontBold = .F.
	ENDPROC
	PROCEDURE MouseEnter
		LPARAMETERS nButton, nShift, nXCoord, nYCoord
		this.FontBold = .T.
	ENDPROC
	PROCEDURE MouseLeave
		LPARAMETERS nButton, nShift, nXCoord, nYCoord
		this.FontBold = .F.
	ENDPROC
ENDDEFINE