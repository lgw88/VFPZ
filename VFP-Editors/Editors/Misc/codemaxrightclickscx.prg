*-*	Generated code for menu codemaxrightclickscx.prg

#DEFINE True              .T.
#DEFINE False             .F.
#DEFINE SET_SKIPFOR       16
#DEFINE SHORTCUT_POP      1
#DEFINE COPYBUFFER_POP    2
#DEFINE FORMAT_POP        3
#DEFINE REFACTOR_POP      4
#DEFINE BOOKMARK_POP      5
#DEFINE CODEINSERT_POP    6
#DEFINE SORTLINE_POP      7
#DEFINE CLIPINSERT_POP    8
#DEFINE SURROUND_POP      9


PROCEDURE RightClick
LOCAL loPopup, lnResult
LOCAL ARRAY laPopupHdl[9]
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
	.nHiliteStyle = 1
	.SetLeftColor(16306359)
	.SetRightColor(16777215,False)
	.hFontCustom = .CreateCustomFont(False,False,True)


*-*	Create Main Menu Popup Index 1
	.CreatePopupItem(25)
	.aPopupItem[1] = "Cu&t"
	.aPopupBmp[1] = "gkkmnucut.bmp"
	.aPopupItem[2] = "&Copy"
	.aPopupBmp[2] = "gkkcopy.bmp"
	.aPopupItem[3] = "&Paste"
	.aPopupBmp[3] = "gkkpaste.bmp"
	.aPopupItem[5] = "Copy as RTF to clipboard"
	.aPopupBmp[5] = "gkkcopytortf.bmp"
	.aPopupItem[6] = "Copy to Buffer"
	.aPopupItem[8] = "&Comment"
	.aPopupBmp[8] = "gkkcomment.bmp"
	.aPopupItem[9] = "&Uncomment"
	.aPopupBmp[9] = "gkkuncomment.bmp"
	.aPopupItem[10] = "Format"
	.aPopupItem[12] = "Refactor"
	.aPopupBmp[12] = "gkkrefactor.bmp"
	.aPopupItem[13] = "Goto &Definition"
	.aPopupBmp[13] = "gkkgotodefinition.bmp"
	.aPopupItem[14] = "Goto Line"
	.aPopupBmp[14] = "gkkgoto.bmp"
	.aPopupItem[15] = "Bookmarks"
	.aPopupBmp[15] = "gkkbookmarks.bmp"
	.aPopupItem[16] = "Code Insert"
	.aPopupBmp[16] = "gkkinsertcode.bmp"
	.aPopupItem[18] = "Where Referenced"
	.aPopupBmp[18] = "gkkwhereused.bmp"
	.aPopupItem[19] = "E&xecute Command"
	.aPopupBmp[19] = "gkkexecute.bmp"
	.aPopupItem[20] = "&Build Expression"
	.aPopupBmp[20] = "gkkexprbuilder.bmp"
	.aPopupItem[21] = "&Sort Lines"
	.aPopupItem[23] = "Compare to Last"
	.aPopupBmp[23] = "gkkcompare.bmp"
	.aPopupItem[24] = "Revert to original"
	.aPopupBmp[24] = "gkkrevertcode2.bmp"
	.aPopupItem[25] = "View Inherited Code"
	.aPopupBmp[25] = "gkkvfp7enu_dll_4_542.bmp"
	laPopupHdl[SHORTCUT_POP] = .CreatePopup(SHORTCUT_POP)

*-*	Create Sub Menu Popup Index 2
	.CreatePopupItem(3)
	.aPopupItem[1] = "Add to"
	.aPopupBmp[1] = "gkkcopyclipadd.bmp"
	.aPopupItem[2] = "View..."
	.aPopupBmp[2] = "gkkcopyclipview.bmp"
	.aPopupItem[3] = "Insert from"
	.aPopupBmp[3] = "gkkcopyclipinsert.bmp"
	laPopupHdl[COPYBUFFER_POP] = .CreatePopup(1101,COPYBUFFER_POP)
	.SetSubPopup(laPopupHdl[SHORTCUT_POP],6,COPYBUFFER_POP)

*-*	Create Sub Menu Popup Index 3
	.CreatePopupItem(7)
	.aPopupItem[1] = "&Indent"
	.aPopupBmp[1] = "gkkincindent.bmp"
	.aPopupItem[2] = "&Unindent"
	.aPopupBmp[2] = "gkkdecindent.bmp"
	.aPopupItem[4] = "Make Lo&wercase"
	.aPopupBmp[4] = "gkkmnulowercase.bmp"
	.aPopupItem[5] = "Make P&ropercase"
	.aPopupItem[6] = "M&ake Uppercase"
	.aPopupBmp[6] = "gkkmnuuppercase.bmp"
	.aPopupItem[7] = "To&ggle Case"
	.aPopupBmp[7] = "gkkmnutogglecase.bmp"
	laPopupHdl[FORMAT_POP] = .CreatePopup(1201,FORMAT_POP)
	.SetSubPopup(laPopupHdl[SHORTCUT_POP],10,FORMAT_POP)

*-*	Create Sub Menu Popup Index 4
	.CreatePopupItem(3)
	.aPopupItem[1] = "Extract to Method"
	.aPopupItem[2] = "Rename"
	.aPopupBmp[2] = "gkkicon_rename.bmp"
	.aPopupItem[3] = "Surround With"
	.aPopupBmp[3] = "gkkinsertloop.bmp"
	laPopupHdl[REFACTOR_POP] = .CreatePopup(1301,REFACTOR_POP)
	.SetSubPopup(laPopupHdl[SHORTCUT_POP],12,REFACTOR_POP)

*-*	Create Sub Menu Popup Index 5
	.CreatePopupItem(3)
	.aPopupItem[1] = "Toggle &Bookmark"
	.aPopupBmp[1] = "gkkbookmarkset.bmp"
	.aPopupItem[2] = "Goto &Next Bookmark"
	.aPopupBmp[2] = "gkkbookmarknext.bmp"
	.aPopupItem[3] = "Goto &Previous Bookmark"
	.aPopupBmp[3] = "gkkbookmarkprev.bmp"
	laPopupHdl[BOOKMARK_POP] = .CreatePopup(1401,BOOKMARK_POP)
	.SetSubPopup(laPopupHdl[SHORTCUT_POP],15,BOOKMARK_POP)

*-*	Create Sub Menu Popup Index 6
	.CreatePopupItem(6)
	.aPopupItem[1] = "Declare - DLL"
	.aPopupBmp[1] = "gkkwin32.bmp"
	.aPopupItem[2] = "RGB Color"
	.aPopupBmp[2] = "gkkcolors.bmp"
	.aPopupItem[4] = "Insert - SQL"
	.aPopupBmp[4] = "gkksqlinsert.bmp"
	.aPopupItem[5] = "Update - SQL"
	.aPopupBmp[5] = "gkksqlupdate.bmp"
	.aPopupItem[6] = "Replace - With"
	.aPopupBmp[6] = "gkkdbreplace.bmp"
	laPopupHdl[CODEINSERT_POP] = .CreatePopup(1501,CODEINSERT_POP)
	.SetSubPopup(laPopupHdl[SHORTCUT_POP],16,CODEINSERT_POP)

*-*	Create Sub Menu Popup Index 7
	.CreatePopupItem(2)
	.aPopupItem[1] = "Ascending"
	.aPopupBmp[1] = "gkksortasc.bmp"
	.aPopupItem[2] = "Descending"
	.aPopupBmp[2] = "gkksortdes.bmp"
	laPopupHdl[SORTLINE_POP] = .CreatePopup(1601,SORTLINE_POP)
	.SetSubPopup(laPopupHdl[SHORTCUT_POP],21,SORTLINE_POP)

*-*	Create Sub Menu Popup Index 8
	.CreatePopupItem(1)
	.aPopupItem[1] = "clip #1"
	laPopupHdl[CLIPINSERT_POP] = .CreatePopup(1111,CLIPINSERT_POP)
	.SetSubPopup(laPopupHdl[COPYBUFFER_POP],3,CLIPINSERT_POP)

*-*	Create Sub Menu Popup Index 9
	.CreatePopupItem(6)
	.aPopupItem[1] = "&Do While - EndDo"
	.aPopupItem[2] = "&If - EndIf"
	.aPopupItem[3] = "&For - EndFor"
	.aPopupItem[4] = "&Scan - EndScan"
	.aPopupItem[5] = "&Try - EndTry"
	.aPopupItem[6] = "&With - EndWith"
	laPopupHdl[SURROUND_POP] = .CreatePopup(1311,SURROUND_POP)
	.SetSubPopup(laPopupHdl[REFACTOR_POP],3,SURROUND_POP)

	.nFirstId = 1001
	lnResult  = .ActivatePopup()
ENDWITH
loPopup = .NULL.

*-*  Owner Drawn Menu Handler
*-*
DO CASE
	CASE lnResult = 1
		GKKContextMenuCut(loCodeMax)

	CASE lnResult = 2
		loCodeMax.ExecuteCmd(cmCmdCopy)

	CASE lnResult = 3
		GKKContextMenuPaste(loCodeMax)

	CASE lnResult = 5
		

	CASE lnResult = 8
		GKKContextMenuComment(loCodeMax)

	CASE lnResult = 9
		GKKContextMenuUncomment(loCodeMax)

	CASE lnResult = 13
		loCodeMax.ObjectNavigation(loRange.StartLineNo,loRange.StartColNo)

	CASE lnResult = 14
		IF loCodeMax.LineCount > 4
			=INKEY(0.100,'H')
			thisform.clsLightBox.ShowLightbox(True,True)
			DO FORM GKKEditorGoto WITH thisform,1,loCodeMax.LineCount NAME loChildForm
			thisform.SetModalBindEvents(loChildForm,True)
		ENDIF

	CASE lnResult = 18
		loCodeMax.WhereReferenced()

	CASE lnResult = 19
		loCodeMax.ExecuteCmd(cmCmdChooseCmd)

	CASE lnResult = 20
		GKKContextMenuBuildExpression(loCodeMax)

	CASE lnResult = 23
		SELECT c_editbuffer
		LOCATE FOR ALLTRIM(wbs) == this.CurrentObject
		IF FOUND()
			WITH thisform
				lnNdx = ASCAN(.CompForms,this.CurrentObject,1,ALEN(.CompForms,1),2,15)
				IF lnNdx > 0
					.CompForms[lnNdx,1].Show()
				ELSE
					lcForm = "GKKCompareMeth"
					DO FORM (lcForm) WITH this.Text,ALLTRIM(c_editbuffer.origmeth),this.CurrentObject,thisform NAME loForm
					IF ISNULL(.CompForms[1,1])
						lnNdx = 1
					ELSE
						lnNdx = ALEN(.CompForms,1) + 1
					ENDIF
					DIMENSION .CompForms[lnNdx,2]
					.CompForms[lnNdx,1] = loForm
					.CompForms[lnNdx,2] = this.CurrentObject
					loForm.Caption = "Method Comparison - " + LOWER(ALLTRIM(c_editbuffer.fullname))
				ENDIF
			ENDWITH
		ENDIF

	CASE lnResult = 24
		lcUserMsg = "Are you sure you want to revert the method code back to last saved version?"
		=INKEY(0.100,'H')
		thisform.clsLightBox.ShowLightbox(True,True)
		lcForm = "GKKMsgBox"
		DO FORM (lcForm) WITH thisform,"RevertCode",lcUserMsg NAME loChildForm
		thisform.SetModalBindEvents(loChildForm,True)

	CASE lnResult = 25
		WITH thisform
			lnNdx = ASCAN(.InheritForms,this.CurrentObject,1,ALEN(.InheritForms,1),2,15)
			IF lnNdx > 0
				.InheritForms[lnNdx,1].Show()
			ELSE
				lcForm = "GKKInherited"
				DO FORM (lcForm) WITH lcMethCode,1,lcMethodName,thisform,this.CurrentObject NAME loForm
				IF ISNULL(.InheritForms[1,1])
					lnNdx = 1
				ELSE
					lnNdx = ALEN(.InheritForms,1) + 1
				ENDIF
				DIMENSION .InheritForms[lnNdx,2]
				.InheritForms[lnNdx,1] = loForm
				.InheritForms[lnNdx,2] = this.CurrentObject
			ENDIF
		ENDWITH

	CASE lnResult = 101
		IF GKKOpenCopyClipMgr()
			_SCREEN.GKKTools.CopyClipMgr.AddCopyClipToCursor(loCodeMax.SelText)
		ENDIF

	CASE lnResult = 102
		IF GKKOpenCopyClipMgr()
			_SCREEN.GKKTools.CopyClipMgr.DisplayCopyClipMgr()
		ENDIF

	CASE lnResult = 201
		GKKContextMenuIndent(loCodeMax,loRange.IsEmpty)

	CASE lnResult = 202
		GKKContextMenuUnindent(loCodeMax,loRange.IsEmpty)

	CASE lnResult = 204
		GKKContextMenuLowercase(loCodeMax)

	CASE lnResult = 205
		GKKContextMenuPropercase(loCodeMax)

	CASE lnResult = 206
		GKKContextMenuUppercase(loCodeMax)

	CASE lnResult = 207
		GKKContextMenuTogglecase(loCodeMax)

	CASE lnResult = 301
		thisform.clsExtractToMethod.StartMethod(loCodeMax,loRange)

	CASE lnResult = 302
		thisform.clsRefactorRename.StartMethod(loCodeMax,loRange)

	CASE lnResult = 401
		loCodeMax.ExecuteCmd(cmCmdBookmarkToggle)

	CASE lnResult = 402
		loCodeMax.ExecuteCmd(cmCmdBookmarkNext)

	CASE lnResult = 403
		loCodeMax.ExecuteCmd(cmCmdBookmarkPrev)

	CASE lnResult = 501
		LOCAL loChildForm
		=INKEY(0.100,'H')
		thisform.clsLightBox.ShowLightbox(True,True)
		DO FORM GKKWin32API WITH thisform NAME loChildForm
		thisform.SetModalBindEvents(loChildForm,True)

	CASE lnResult = 502
		=INKEY(0.050,'H')
		thisform.clsLightBox.ShowLightbox(True,False)
		lnLeft = this.Left + tnRow
		lnTop  = this.Top + tnCol
		WITH loCodeMax
			.ColorForm = NEWOBJECT("ColorPickerForm","GKKColorPicker.vcx","",lnLeft,lnTop)
			BINDEVENT(.ColorForm,"OnSetColor",loCodeMax,"OnSetColorHandler")
			IF thisform.WindowType = 1
				.ColorForm.Height = 148
				.ColorForm.Label3.Visible = True
			ENDIF
			IF lnTop + .ColorForm.Height > this.Top + this.Height
				.ColorForm.Top = .ColorForm.Top - (lnTop + .ColorForm.Height - this.Top - this.Height)
			ENDIF
			IF lnLeft + .ColorForm.Width > this.Left + this.Width
				.ColorForm.Width = .ColorForm.Width - (lnLeft + .ColorForm.Width - this.Left - this.Width)
			ENDIF
			.ColorForm.Visible = True
		ENDWITH
		thisform.SetModalBindEvents(loCodeMax.ColorForm,False)

	CASE lnResult = 504
		thisform.clsTableCmdInsert.StartMethod(loCodeMax,loRange,"InsertSQL")

	CASE lnResult = 505
		thisform.clsTableCmdInsert.StartMethod(loCodeMax,loRange,"UpdateSQL")

	CASE lnResult = 506
		thisform.clsTableCmdInsert.StartMethod(loCodeMax,loRange,"ReplaceWith")

	CASE lnResult = 601
		loCodeMax.ExecuteCmd(cmCmdSortLinesAscending)
		loCodeMax.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
		loCodeMax.SetModified()

	CASE lnResult = 602
		loCodeMax.ExecuteCmd(cmCmdSortLinesDescending)
		loCodeMax.SetChangeControl(loRange.StartLineNo,loRange.EndLineNo)
		loCodeMax.SetModified()

	CASE lnResult = 111
		WAIT WINDOW "TODO: List Copy Buffer" NOWAIT

	CASE lnResult = 311
		GKKSurroundWith(loRange, loCodeMax, "InsertDoWhile")

	CASE lnResult = 312
		GKKSurroundWith(loRange, loCodeMax, "InsertIf")

	CASE lnResult = 313
		GKKSurroundWith(loRange, loCodeMax, "InsertFor")

	CASE lnResult = 314
		GKKSurroundWith(loRange, loCodeMax, "InsertScan")

	CASE lnResult = 315
		GKKSurroundWith(loRange, loCodeMax, "InsertTry")

	CASE lnResult = 316
		GKKSurroundWith(loRange, loCodeMax, "InsertWith")

	OTHERWISE
		IF lnResult != 0
			WAIT WINDOW "Popup Menu Item: " + TRANSFORM(lnResult)
		ENDIF
ENDCASE
RETURN lnResult
ENDPROC


*-************************************************************************************************
*-*  Menu Setup Code
*-*
FUNCTION MnuSetup
*-*************** Start of Copy Clip Menu Selection
IF GKKOpenCopyClipMgr()
	lnClipCount = _SCREEN.GKKTools.CopyClipMgr.GetCopyClipList(@laClipList)
	IF lnClipCount > 0
		.CreatePopupItem(lnClipCount)
		FOR lnBar=1 TO lnClipCount
			.aPopupItem[lnBar] = TRANSFORM(lnBar) + ": " + IIF(LEN(laClipList[lnBar,1])>25, LEFT(laClipList[lnBar,1],25) + "...", laClipList[lnBar,1])
		ENDFOR
	ENDIF
ELSE
	lnClipCount = 0
	.CreatePopupItem(1)
	.aPopupItem[1] = "None available"
ENDIF	
laPopupHdl[CLIPINSERT_PAD] = .CreatePopup(1111,CLIPINSERT_PAD)
.SetSubPopup(laPopupHdl[COPYBUFFER_PAD],3,CLIPINSERT_PAD)
*-*************** End of Copy Clip Menu Selection
ENDFUNC


*-************************************************************************************************
*-*  Menu Cleanup Code
*-*
FUNCTION MnuCleanup
*-*		Disable items
IF .NOT. this.Modified
	.DisablePopupItem(SHORTCUT_PAD,22)                 && Revert to original
ENDIF
IF .NOT. this.CodeInherited()
	.DisablePopupItem(SHORTCUT_PAD,23)                 && View Inherited Code
ENDIF
IF lnClipCount = 0
	.DisablePopupItem(COPYBUFFER_PAD,3)                && Insert from Copy buffer
ENDIF
IF loRange.IsEmpty
	.DisablePopupItem(SHORTCUT_PAD,1)                  && Cut
	.DisablePopupItem(SHORTCUT_PAD,2)                  && Copy
	.DisablePopupItem(COPYBUFFER_PAD,1)                && Add to Copy buffer
ELSE
	IF loRange.StartLineNo = loRange.EndLineNo
		.DisablePopupItem(SHORTCUT_PAD,19)             && Sort lines popup menu
	ELSE
		.DisablePopupItem(REFACTOR_PAD,2)              && Refactor Rename
		.DisablePopupItem(SHORTCUT_PAD,11)             && Goto definition
		.DisablePopupItem(SHORTCUT_PAD,14)             && Code Insert
		.DisablePopupItem(SHORTCUT_PAD,16)             && Where referenced
		.DisablePopupItem(SHORTCUT_PAD,18)             && Build expression
	ENDIF
	IF loRange.StartLineNo != loRange.EndLineNo
		.DisablePopupItem(REFACTOR_PAD,2)              && Refactor Rename
	ELSE
		lcSelText = ALLTRIM(loCodeMax.GetText(loRange))
		FOR lnPos=1 TO LEN(lcSelText)
			IF SUBSTR(lcSelText,lnPos,1) $ ",.()[]';:!@#$%^&*-+=/><? " .OR. SUBSTR(lcSelText,lnPos,1) = '"'
				.DisablePopupItem(REFACTOR_PAD,2)      && Refactor Rename
				EXIT
			ENDIF
		ENDFOR
	ENDIF
ENDIF
ENDFUNC