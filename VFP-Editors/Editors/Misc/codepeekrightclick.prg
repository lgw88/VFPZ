*-*	Generated code for menu codepeekrightclick.prg

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
	.lThemed = False
	.lUseGradient = False
	.lGlassy = False
	.lUseGradientPad = False
	.lEnhancedHilite = False
	.lHiliteUseFontBold = False
	.nHiliteStyle = 0
	.SetLeftColor(16306359)
	.SetRightColor(16777215,False)
	.hFontCustom = .CreateCustomFont(False,False,True)


*-*	Create Main Menu Popup Index 1
	.CreatePopupItem(6)
	.aPopupItem[1] = "&Copy"
	.aPopupBmp[1] = "gkkcopy.bmp"
	.aPopupItem[2] = "Copy as &RTF to clipboard"
	.aPopupBmp[2] = "gkkcopytortf.bmp"
	.aPopupItem[3] = "&Add to Copy Buffer"
	.aPopupBmp[3] = "gkkcopyclipadd.bmp"
	.aPopupItem[5] = "Goto &Definition"
	.aPopupBmp[5] = "gkkgotodefinition.bmp"
	.aPopupItem[6] = "Code &Peek"
	.aPopupBmp[6] = "gkkcodepeek.bmp"
	laPopupHdl[SHORTCUT_POP] = .CreatePopup(1001)

	.nFirstId = 1001
	lnResult  = .ActivatePopup()
ENDWITH
loPopup = .NULL.

*-*  Owner Drawn Menu Handler
*-*
DO CASE
	CASE lnResult = 1
		loCodeMax.ExecuteCmd(cmCmdCopy)

	CASE lnResult = 2
		IF loRange.IsEmpty
			_CLIPTEXT = loCodeMax.TextRTF
		ELSE
			_CLIPTEXT = loCodeMax.SelTextRTF
		ENDIF

	CASE lnResult = 3
		IF GKKOpenCopyClipMgr()
			_SCREEN.GKKTools.CopyClipMgr.AddCopyClipToCursor(loCodeMax.SelText)
		ENDIF

	CASE lnResult = 5
		loCodeMax.ObjectNavigation(loRange.StartLineNo, loRange.StartColNo)

	CASE lnResult = 6
		loCodeMax.CodePeek(loRange.StartLineNo, loRange.StartColNo)

	OTHERWISE
		IF lnResult != 0
			WAIT WINDOW "Popup Menu Item: " + TRANSFORM(lnResult)
		ENDIF
ENDCASE
RETURN lnResult
ENDPROC