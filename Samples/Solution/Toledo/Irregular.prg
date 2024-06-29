DEFINE CLASS MyIrregularForm AS Form
	ShowWindow  = 2
	
PROCEDURE Init
	WITH Thisform
		.AutoCenter = .T.
		.BorderStyle= 0
		.Caption	= ""
		.Closable	= .F.
		.ControlBox	= .F.
		.TitleBar	= 0
		.BackColor	= RGB(255,0,255)
		.Height		= 370
		.Width		= 410
	ENDWITH	
ENDPROC
	
ENDDEFINE

