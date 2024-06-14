*-*	Generated code for menu tabrightclick.prg

#DEFINE True              .T.
#DEFINE False             .F.
#DEFINE SET_SKIPFOR       16
#DEFINE SHORTCUT_POP      1


PROCEDURE RightClick
LOCAL loPopup, lnResult
LOCAL ARRAY laPopupHdl[1]
loPopup = NEWOBJECT("PopupMenu","OwnerDrawn_Menu","",1024)
WITH loPopup
	.GDIPlus_Start()
	.hWndParent = thisform.hWnd
	.lThemed = True
	.lUseGradient = True
	.lGlassy = False
	.lUseGradientPad = False
	.lEnhancedHilite = False
	.lHiliteUseFontBold = True
	.nHiliteStyle = 0
	.SetLeftColor(16306359)
	.SetRightColor(16777215,False)
	.hFontCustom = .CreateCustomFont(False,False,True)


*-*	Create Main Menu Popup Index 1
	.CreatePopupItem(8)
	.aPopupItem[1] = "Close"
	.aPopupBmp[1] = "gkkclsdfold.bmp"
	.aPopupItem[2] = "Close All BUT this"
	.aPopupBmp[2] = "gkkclsdbut.bmp"
	.aPopupItem[3] = "Close All to the Left"
	.aPopupBmp[3] = "gkkclsdleft.bmp"
	.aPopupItem[4] = "Close All to the Right"
	.aPopupBmp[4] = "gkkclsdright.bmp"
	.aPopupItem[6] = "Compare to Last"
	.aPopupBmp[6] = "gkkcompare.bmp"
	.aPopupItem[8] = "Copy to Clipboard"
	.aPopupBmp[8] = "gkkcopy16.bmp"
	laPopupHdl[SHORTCUT_POP] = .CreatePopup(11)

	.nFirstId = 11
	lnResult  = .ActivatePopup()
ENDWITH
loPopup = .NULL.

*-*  Owner Drawn Menu Handler
*-*
DO CASE
	CASE lnResult = 1
		thisform.CloseTabManager(lnTab, "All")

	CASE lnResult = 2
		thisform.CloseTabManager(lnTab, "Keep")

	CASE lnResult = 3
		thisform.CloseTabManager(lnTab, "Left")

	CASE lnResult = 4
		thisform.CloseTabManager(lnTab, "Right")

	CASE lnResult = 6
		thisform.CompareMethodToSave(this)

	CASE lnResult = 8
		

	OTHERWISE
		IF lnResult != 0
			WAIT WINDOW "Popup Menu Item: " + TRANSFORM(lnResult)
		ENDIF
ENDCASE
RETURN lnResult
ENDPROC