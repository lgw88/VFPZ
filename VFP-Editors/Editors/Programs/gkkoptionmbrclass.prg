*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Routine for defining the MemberClass for OptionGroups
*-*
DEFINE CLASS GKKOption AS OptionButton
	AutoSize  = .T.
	Caption   = "GKKOption"
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