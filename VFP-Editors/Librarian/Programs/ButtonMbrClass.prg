*-***********************************************************************************************
*-* Copyright ©2014 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Routine for defining the MemberClass for ButtonGroups
*-*
DEFINE CLASS CommandTreeButton AS CommandButton
	Alignment = 0          && Middle Left
	AutoSize  = .F.
	Caption   = "TreeButton"
	BackColor = RGB(198, 211, 239)
	ForeColor = RGB(128,128,128)
	DisabledBackColor = RGB(214,223,247)
	Height    = 44
	Width     = 99
	Themes    = .F.
	ColorSource = 0        && Object's Color Properties
	PicturePosition = 1    && Left of caption
	PictureSpacing  = 2
	SpecialEffect   = 2    && Hot-tracking

	PROCEDURE GotFocus
		this.ForeColor = RGB(0,0,0)
*		this.FontBold = .T.
*		this.BackColor = RGB(VAL(GETWORDNUM(this.Parent.ButtonHighlightColor, 1, ",")),;
*							 VAL(GETWORDNUM(this.Parent.ButtonHighlightColor, 2, ",")),;
*							 VAL(GETWORDNUM(this.Parent.ButtonHighlightColor, 3, ",")))
	ENDPROC

	PROCEDURE LostFocus
*		this.FontBold = .F.
*		IF this.Parent.CurrentButton.Name != this.Name
*			this.BackColor = RGB(VAL(GETWORDNUM(this.Parent.ButtonBackColor, 1, ",")),;
*								 VAL(GETWORDNUM(this.Parent.ButtonBackColor, 2, ",")),;
*								 VAL(GETWORDNUM(this.Parent.ButtonBackColor, 3, ",")))
*		ENDIF
	ENDPROC

	PROCEDURE MouseEnter
		LPARAMETERS nButton, nShift, nXCoord, nYCoord
		this.FontBold = .T.
		this.ForeColor = RGB(0,0,0)
		this.BackColor = RGB(VAL(GETWORDNUM(this.Parent.ButtonHighlightColor, 1, ",")),;
							 VAL(GETWORDNUM(this.Parent.ButtonHighlightColor, 2, ",")),;
							 VAL(GETWORDNUM(this.Parent.ButtonHighlightColor, 3, ",")))
	ENDPROC

	PROCEDURE MouseLeave
		LPARAMETERS nButton, nShift, nXCoord, nYCoord
		this.FontBold = .F.
		IF this.Parent.CurrentButton.Name != this.Name
			this.ForeColor = RGB(128,128,128)
			this.BackColor = RGB(VAL(GETWORDNUM(this.Parent.ButtonBackColor, 1, ",")),;
								 VAL(GETWORDNUM(this.Parent.ButtonBackColor, 2, ",")),;
								 VAL(GETWORDNUM(this.Parent.ButtonBackColor, 3, ",")))
		ENDIF
	ENDPROC
ENDDEFINE