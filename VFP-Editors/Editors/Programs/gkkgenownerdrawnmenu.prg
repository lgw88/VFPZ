*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*
*-* Copyright ©2009-2011 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Generates a program menu definition for use with Herman Tan's OwnerDrawn menu class
*-*
#INCLUDE GKKAPI_Menu.h
FUNCTION GKKGenOwnerDrawnMenu
LPARAMETERS toForm,tcFileName
LOCAL lcMenu, lnPad, lnPopUpNdx, lnNdx, lnNumPads, lnNumLines, lnLine, lcSetSubMenu, lcLastHier
LOCAL lnPopUpID, lnLevel, lnBar, lcMenuWBS, lnHierNdx, lcDefines
LOCAL ARRAY laPad[1], laCmd[1], laPopupNames[1], laPadNames[1]
CREATE CURSOR c_commands (menuid I, menucmd M)
CREATE CURSOR c_subpopup (wbslevel C(100), popupid I, popupndx I, popupcnt I)
SELECT c_editmnu
SET ORDER TO TAG wbslevel
GOTO TOP
WITH toForm
*-*	Define the menu initialization
	lcMenu =                 '*-*' + REPLICATE("*",95)
	lcMenu = lcMenu + CRLF + 'ADDPROPERTY(_VFP,"ODMenu")'	
	lcMenu = lcMenu + CRLF + '_VFP.ODMenu = NEWOBJECT("PopupMenu","OwnerDrawn_Menu")'
	lcMenu = lcMenu + CRLF + 'IF VARTYPE(_VFP.ODMenu) != "O"'
	lcMenu = lcMenu + CRLF + '	RETURN'
	lcMenu = lcMenu + CRLF + 'ENDIF'
	lcMenu = lcMenu + CRLF + 'IF !("' + JUSTSTEM(tcFileName) + '" $ SET("Procedure"))'
	lcMenu = lcMenu + CRLF + '	SET PROCEDURE TO ' + JUSTSTEM(tcFileName) + ' ADDITIVE'
	lcMenu = lcMenu + CRLF + 'ENDIF'
	IF !EMPTY(c_editmnu.setup)
		lcMenu = lcMenu + CRLF + 'DO MnuSetup'
	ENDIF
	lcMenu = lcMenu + CRLF + 'DO DefineMenu'
	lcMenu = lcMenu + CRLF + 'READ EVENTS'
	lcMenu = lcMenu + CRLF + '_VFP.ODMenu = .NULL.'
	lcMenu = lcMenu + CRLF + 'REMOVEPROPERTY(_VFP,"ODMenu")'
	IF !EMPTY(c_editmnu.cleanup)
		lcMenu = lcMenu + CRLF + 'DO MnuCleanup'
	ENDIF
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + '*-*' + REPLICATE("*",95)
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + "#DEFINE True              .T."
	lcMenu = lcMenu + CRLF + "#DEFINE False             .F."
	lcMenu = lcMenu + CRLF + "#DEFINE SET_SKIPFOR       " + TRANSFORM(myODF_SKIPFOR)
	lcMenu = lcMenu + CRLF + '**DEFINES**'
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + '*-*' + REPLICATE("*",95)
	lcMenu = lcMenu + CRLF + '*-*  Additional commands for managing menu'
	lcMenu = lcMenu + CRLF + '*-*'
	lcMenu = lcMenu + CRLF + '*-*	WITH _VFP.ODMenu'
	lcMenu = lcMenu + CRLF + '*-*		.DisableMainMenu()'
	lcMenu = lcMenu + CRLF + '*-*		.EnableMainMenu()'
	lcMenu = lcMenu + CRLF + '*-*'
	lcMenu = lcMenu + CRLF + '*-*		.DisableMenuPad()'
	lcMenu = lcMenu + CRLF + '*-*		.EnableMenuPad()'
	lcMenu = lcMenu + CRLF + '*-*'
	lcMenu = lcMenu + CRLF + '*-*		.DisablePopupItem(lnMenuPos,lnItemPos)'
	lcMenu = lcMenu + CRLF + '*-*		.EnablePopupItem(lnMenuPos,lnItemPos)'
	lcMenu = lcMenu + CRLF + '*-*	ENDWITH'
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF
*-*	Define the menu definition header
	lcMenu = lcMenu + CRLF + '*-*' + REPLICATE("*",95)
	lcMenu = lcMenu + CRLF + '*-*  Procedure for defining the Owner Drawn menu system'
	lcMenu = lcMenu + CRLF + '*-*'
	lcMenu = lcMenu + CRLF + 'FUNCTION DefineMenu'
	lcMenu = lcMenu + CRLF + '#INCLUDE API_MENU.H'
	SELECT DISTINCT LevelName FROM mnufile ;
		WHERE !EMPTY( LevelName ) AND !('_MSYSMENU' $ UPPER( ALLTRIM( LevelName ))) ;
		INTO CURSOR curTemp
	USE IN curTemp
	lcMenu = lcMenu + CRLF + 'LOCAL ARRAY laPopupHdl[' + TRANSFORM(_Tally) + ']'
	lcMenu = lcMenu + CRLF + 'WITH _VFP.ODMenu'
	lcMenu = lcMenu + CRLF + '	.hWndParent = _VFP.hWnd'
	lcMenu = lcMenu + CRLF + '	.Gdiplus_Start()'
	lcMenu = lcMenu + CRLF + '	.lThemed = '            + IIF(.chkOfficeThemed.value,"True","False")
	lcMenu = lcMenu + CRLF + '	.lUseGradient = '       + IIF(.chkGradLeftSide.value,"True","False")
	lcMenu = lcMenu + CRLF + '	.lGlassy = '            + IIF(.chkGlassyLook.value,"True","False")
	lcMenu = lcMenu + CRLF + '	.lUseGradientPad = '    + IIF(.chkGradMnuPad.value,"True","False")
	lcMenu = lcMenu + CRLF + '	.lEnhancedHilite = '    + IIF(.chkShadTxt.value,"True","False")
	lcMenu = lcMenu + CRLF + '	.lHiliteUseFontBold = ' + IIF(.chkBoldItem.value,"True","False")
*	lcMenu = lcMenu + CRLF + '	.nTextHiliteColor = '   + TRANSFORM()
	lcMenu = lcMenu + CRLF + '	.nHiliteStyle = ' + TRANSFORM(ODHS_ALL + ;
															  IIF(.chkRounded.value,ODHS_ROUNDED,0) + ;
															  IIF(.chkBitmapOnly.value,ODHS_BITMAPONLY,0) + ;
															  IIF(.chkRoundBitmap.value,ODHS_ROUNDED_BITMAP,0))
	lcMenu = lcMenu + CRLF + '	.SetLeftColor(' + TRANSFORM(.clsMenuLeftColor.SelectedColor) + ')'
	lcMenu = lcMenu + CRLF + '	.SetRightColor(' + TRANSFORM(.clsMenuRightColor.SelectedColor) + ',False)'
	lcMenu = lcMenu + CRLF + '	.hFontCustom = .CreateCustomFont(False,False,True)'
	lcMenu = lcMenu + CRLF
*-*	Define the main menu pads
	SELECT c_editmnu
	COUNT FOR OCCURS(".",wbslevel)=1 .AND. objtype=3 .AND. !DELETED() TO lnNumPads
	lnPad  = 0
	lcMenu = lcMenu + CRLF + '*-*	Create Menu Pad'
	lcMenu = lcMenu + CRLF + '	DIMENSION .aMenuPad[' + TRANSFORM(lnNumPads) + ',2]'
	SCAN FOR OCCURS(".",wbslevel)=1 .AND. objtype=3 .AND. !DELETED()
		lnPad = lnPad + 1
		DIMENSION laPad[lnPad], laPadNames[lnPad]
		laPad[lnPad] = ALLTRIM(c_editmnu.wbslevel) + "."
		laPadNames[lnPad] = UPPER(STRTRAN(ALLTRIM(c_editmnu.prompt)," ","_")) + "_PAD"
		lcMenu = lcMenu + CRLF + '	.aMenuPad[' + TRANSFORM(lnPad) + ',1] = "' + ALLTRIM(c_editmnu.prompt) + '"'
		IF ATC('\<',c_editmnu.prompt) > 0
			lcMenu = lcMenu + CRLF + '	.aMenuPad[' + TRANSFORM(lnPad) + ',2] = "' + SUBSTR(ALLTRIM(c_editmnu.prompt),ATC('\<',c_editmnu.prompt)+2,1) + '"'
		ENDIF
	ENDSCAN
	lcMenu = lcMenu + CRLF + '	.CreatePad()'
*-*	Add the menu pad popups
	lnPopUpNdx   = 0
	lcSetSubMenu = CRLF + '*-*	Attach SubMenus to the Menu Pads'
	FOR lnPad=1 TO ALEN(laPad,1)
		COUNT FOR OCCURS(".",wbslevel)=2 .AND. wbslevel=laPad[lnPad] .AND. objtype=3 .AND. !DELETED() TO lnNumPads
		IF lnNumPads > 0
			lnPopUpNdx = lnPopUpNdx + 1
			lcMenu     = lcMenu + CRLF
			lcMenu     = lcMenu + CRLF + '*-*	Create Pad ' + TRANSFORM(lnPad) + ' Menu Popup Index ' + TRANSFORM(lnPopUpNdx)
			lcMenu     = lcMenu + CRLF + '	.CreatePopupItem(' + TRANSFORM(lnNumPads) + ')'
			lnBar      = 0
			lnPopUpID  = 100000 * lnPopUpNdx + 1
			SCAN FOR OCCURS(".",wbslevel)=2 .AND. wbslevel=laPad[lnPad] .AND. objtype=3 .AND. !DELETED()
				lcLevelName = UPPER(ALLTRIM(c_editmnu.levelname))
				lnBar = lnBar + 1
				IF ALLTRIM(c_editmnu.prompt) != "\-"
					lcMenu = lcMenu + CRLF + '	.aPopupItem[' + TRANSFORM(lnBar) + '] = "' + STRTRAN(ALLTRIM(c_editmnu.prompt),"\<","&") + '"'
					IF !EMPTY(c_editmnu.resname) .AND. c_editmnu.sysres = 2
						lcMenu = lcMenu + CRLF + '	.aPopupBmp[' + TRANSFORM(lnBar) + '] = "' + JUSTFNAME(ALLTRIM(c_editmnu.resname)) + '"'
					ENDIF
					IF !EMPTY(c_editmnu.skipfor)
						lcMenu = lcMenu + CRLF + '	.aCmdSkipForItem[' + TRANSFORM(lnBar) + '] = "' + ALLTRIM(c_editmnu.skipfor,1," ",CR,LF) + '"'
						lcMenu = lcMenu + CRLF + '	.aPopupFlags[' + TRANSFORM(lnBar) + '] = SET_SKIPFOR'
					ENDIF
					DO CASE
						CASE c_editmnu.objcode = 77        && Submenu assigned
							SELECT * FROM c_subpopup WHERE popupid = lnPopUpID INTO CURSOR c_temp
							INSERT INTO c_subpopup (wbslevel,popupid,popupndx,popupcnt) VALUES (c_editmnu.wbslevel,lnPopUpID,lnPopUpNdx,_TALLY+1)
							USE IN c_temp
						CASE c_editmnu.objcode = 67        && Command assigned
							INSERT INTO c_commands (menuid,menucmd) VALUES (lnPopUpID+lnBar-1,c_editmnu.command)
						CASE c_editmnu.objcode = 80        && Procedure assigned
							INSERT INTO c_commands (menuid,menucmd) VALUES (lnPopUpID+lnBar-1,c_editmnu.procedure)
					ENDCASE
				ENDIF
			ENDSCAN
			DIMENSION laPopupNames[lnPopUpNdx]
			laPopupNames[lnPopUpNdx] = lcLevelName + IIF(RIGHT(lcLevelName,1) = "_","POP","_POP")
			lcMenu = lcMenu + CRLF + '	' + 'laPopupHdl[' + laPopupNames[lnPopUpNdx] + ']'  + ' = .CreatePopup(' + TRANSFORM(lnPopUpID) + ',' + laPopupNames[lnPopUpNdx] + ')'
			lcSetSubMenu = lcSetSubMenu + CRLF + '	.SetSubMenu(' + laPadNames[lnPad] + "," + laPopupNames[lnPopUpNdx] + ')'
		ENDIF
	ENDFOR
*-*	Get the menu popups by level
	lnLevel = 3
	GOTO TOP
	LOCATE FOR OCCURS(".",wbslevel)=lnLevel .AND. objtype=3 .AND. !DELETED()
	DO WHILE FOUND()
*-*		Get the menus at this level
		SELECT wbslevel,numitems FROM c_editmnu ;
			WHERE OCCURS(".",wbslevel)=lnLevel .AND. objtype=2 .AND. !DELETED() ;
			INTO CURSOR c_popmenus
		SELECT c_popmenus
		GOTO TOP
		lcLastHier = ""
		lnHierNdx  = 0
		SCAN
			lcMenuWBS = LEFT(c_popmenus.wbslevel,RATC(".",c_popmenus.wbslevel)-1)
			IF lcLastHier != LEFT(c_popmenus.wbslevel,ATC(".",c_popmenus.wbslevel,lnLevel-1))
				lnHierNdx  = 0
				lcLastHier = LEFT(c_popmenus.wbslevel,ATC(".",c_popmenus.wbslevel,lnLevel-1))
			ENDIF
			lnHierNdx = lnHierNdx + 1
			IF lnHierNdx <= 9
				lnPopUpNdx = fAddPopUpMenu(lnLevel,lcMenuWBS,c_popmenus.numitems,lnPopUpNdx,@lcMenu,@laPopupNames)
			ELSE
				GKKDisplayMsg("Too many menu popups defined for menu level (max supported is 9)")
			ENDIF
			SELECT c_popmenus
		ENDSCAN
		USE IN c_popmenus
*-*		Get the next level of menus
		lnLevel = lnLevel + 1
		SELECT c_editmnu
		GOTO TOP
		LOCATE FOR OCCURS(".",wbslevel)=lnLevel .AND. objtype=3 .AND. !DELETED()
	ENDDO
*-*	Close the menu procedure
	lcMenu = lcMenu + CRLF
	IF .chkColMnuBar.value
		lcMenu = lcMenu + CRLF + '	.SetMenuBarColor(.GetBrightColor(' + TRANSFORM(.clsMnuBarColor.SelectedColor) + ',108))'
	ENDIF
	lcMenu = lcMenu + CRLF + lcSetSubMenu
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + '*-*	Bind and activate menu'
	lcMenu = lcMenu + CRLF + '	.BindMessages()'
	lcMenu = lcMenu + CRLF + '	ACTIVATE MENU (.cMenuName) NOWAIT'
	lcMenu = lcMenu + CRLF + 'ENDWITH'
	lcMenu = lcMenu + CRLF + 'ENDFUNC'
*-*	Add the menu event handler definition
	SELECT c_commands
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + '*-*' + REPLICATE("*",95)
	lcMenu = lcMenu + CRLF + '*-*  Owner Drawn Menu Handler'
	lcMenu = lcMenu + CRLF + '*-*'
	lcMenu = lcMenu + CRLF + 'FUNCTION OnSelection'
	lcMenu = lcMenu + CRLF + 'LPARAMETERS tnMenuPos,tnItemID'
	lcMenu = lcMenu + CRLF + 'DO CASE'
	SCAN
		lcMenu = lcMenu + CRLF + '	CASE tnItemID = ' + TRANSFORM(c_commands.menuid)
		lnNumLines = ALINES(laCmd,c_commands.menucmd,.T.)
		FOR lnLine=1 TO lnNumLines
			lcMenu = lcMenu + CRLF + '		' + laCmd[lnLine]
		ENDFOR
		lcMenu = lcMenu + CRLF
	ENDSCAN
	lcMenu = lcMenu + CRLF + '	OTHERWISE'
	lcMenu = lcMenu + CRLF + '		IF tnItemID != 0'
	lcMenu = lcMenu + CRLF + '			WAIT WINDOW "Menu Item: " + TRANSFORM(tnMenuPos) + "  Item ID: " + TRANSFORM(tnItemID)'
	lcMenu = lcMenu + CRLF + '		ENDIF'
	lcMenu = lcMenu + CRLF + 'ENDCASE'
	lcMenu = lcMenu + CRLF + 'ENDFUNC'
	SELECT c_editmnu
	GOTO TOP
*-*	Add Setup function definition
	IF !EMPTY(c_editmnu.setup)
		lcMenu = lcMenu + CRLF
		lcMenu = lcMenu + CRLF
		lcMenu = lcMenu + CRLF + '*-*' + REPLICATE("*",95)
		lcMenu = lcMenu + CRLF + '*-*  Menu Setup Code'
		lcMenu = lcMenu + CRLF + '*-*'
		lcMenu = lcMenu + CRLF + 'FUNCTION MnuSetup'
		lcMenu = lcMenu + CRLF + ALLTRIM(c_editmnu.setup)
		lcMenu = lcMenu + CRLF + 'ENDFUNC'
	ENDIF
*-*	Add Cleanup function definition
	IF !EMPTY(c_editmnu.cleanup)
		lcMenu = lcMenu + CRLF
		lcMenu = lcMenu + CRLF
		lcMenu = lcMenu + CRLF + '*-*' + REPLICATE("*",95)
		lcMenu = lcMenu + CRLF + '*-*  Menu Cleanup Code'
		lcMenu = lcMenu + CRLF + '*-*'
		lcMenu = lcMenu + CRLF + 'FUNCTION MnuCleanup'
		lcMenu = lcMenu + CRLF + ALLTRIM(c_editmnu.cleanup)
		lcMenu = lcMenu + CRLF + 'ENDFUNC'
	ENDIF
*-*	Set the menu defines for the Pad names
	lcDefines = "#DEFINE " + PADR(laPadNames[1],18," ") + "1" + CRLF
	FOR lnNdx=2 TO ALEN(laPadNames,1)
		lcDefines = lcDefines + "#DEFINE " + PADR(laPadNames[lnNdx],18," ") + TRANSFORM(lnNdx) + CRLF
	ENDFOR
	FOR lnNdx=1 TO ALEN(laPopupNames,1)
		lcDefines = lcDefines + "#DEFINE " + PADR(laPopupNames[lnNdx],18," ") + TRANSFORM(lnNdx) + CRLF
	ENDFOR
	lcMenu = STRTRAN(lcMenu,'**DEFINES**',lcDefines)
ENDWITH
USE IN c_subpopup
USE IN c_commands
=STRTOFILE(lcMenu,tcFileName,0)
ENDFUNC


*-***********************************************************************************************
*-* Function for adding the submenu popups
*-*
FUNCTION fAddPopUpMenu
LPARAMETERS tnLevel,tcMenuWBS,tnNumBars,tnPopUpNdx,tcMenu,taPopupNames
LOCAL lnBar, lnNdx, lnPopUpID, lnCurPopUpID, lnIndex, lcLevelName
EXTERNAL ARRAY taPopupNames
IF tnNumBars > 0
	tnPopUpNdx = tnPopUpNdx + 1
	DIMENSION taPopupNames[tnPopUpNdx]
	tcMenu     = tcMenu + CRLF
	tcMenu     = tcMenu + CRLF + '*-*	Create Sub Menu Popup Index ' + TRANSFORM(tnPopUpNdx)
	tcMenu     = tcMenu + CRLF + '	.CreatePopupItem(' + TRANSFORM(tnNumBars) + ')'
	lnBar      = 0
	lnPopUpID  = GetPopupID(tcMenuWBS,tnLevel)
	SELECT c_editmnu
	SCAN FOR OCCURS(".",wbslevel)=tnLevel .AND. wbslevel=tcMenuWBS .AND. objtype=3 .AND. !DELETED()
		lcLevelName = UPPER(ALLTRIM(c_editmnu.levelname))
		lnBar = lnBar + 1
		IF ALLTRIM(c_editmnu.prompt) != "\-"
			tcMenu = tcMenu + CRLF + '	.aPopupItem[' + TRANSFORM(lnBar) + '] = "' + STRTRAN(ALLTRIM(c_editmnu.prompt),"\<","&") + '"'
			IF !EMPTY(c_editmnu.resname) .AND. c_editmnu.sysres = 2
				tcMenu = tcMenu + CRLF + '	.aPopupBmp[' + TRANSFORM(lnBar) + '] = "' + JUSTFNAME(ALLTRIM(c_editmnu.resname)) + '"'
			ENDIF
			IF !EMPTY(c_editmnu.skipfor)
				tcMenu = tcMenu + CRLF + '	.aCmdSkipForItem[' + TRANSFORM(lnBar) + '] = "' + ALLTRIM(c_editmnu.skipfor,1," ",CR,LF) + '"'
				tcMenu = tcMenu + CRLF + '	.aPopupFlags[' + TRANSFORM(lnBar) + '] = SET_SKIPFOR'
			ENDIF
			DO CASE
				CASE c_editmnu.objcode = 77        && Submenu assigned
					SELECT * FROM c_subpopup WHERE popupid = lnPopUpID INTO CURSOR c_temp
					INSERT INTO c_subpopup (wbslevel,popupid,popupndx,popupcnt) VALUES (c_editmnu.wbslevel,lnPopUpID,tnPopUpNdx,_TALLY+1)
					USE IN c_temp
				CASE c_editmnu.objcode = 67        && Command assigned
					INSERT INTO c_commands (menuid,menucmd) VALUES (lnPopUpID+lnBar-1,c_editmnu.command)
				CASE c_editmnu.objcode = 80        && Procedure assigned
					INSERT INTO c_commands (menuid,menucmd) VALUES (lnPopUpID+lnBar-1,c_editmnu.procedure)
			ENDCASE
		ENDIF
	ENDSCAN
	taPopupNames[tnPopUpNdx] = lcLevelName + IIF(RIGHT(lcLevelName,1) = "_", "POP", "_POP")
	tcMenu = tcMenu + CRLF + '	' + 'laPopupHdl[' + taPopupNames[tnPopUpNdx] + ']' + ' = .CreatePopup(' + TRANSFORM(lnPopUpID) + ',' + taPopupNames[tnPopUpNdx] + ')'
	tcMenu = tcMenu + CRLF + '	.SetSubPopup(laPopupHdl[' + taPopupNames[fGetPopupHdl(tcMenuWBS)] + "]," + fGetItemPos(tcMenuWBS) + "," + taPopupNames[tnPopUpNdx] + ')'
ENDIF
RETURN tnPopUpNdx
ENDFUNC


*-***********************************************************************************************
*-* Function for getting the submenu ID
*-*
FUNCTION GetPopupID
LPARAMETERS tcMenuWBS,tnLevel
LOCAL lnPopUpID
SELECT c_subpopup
LOCATE FOR ALLTRIM(wbslevel) == tcMenuWBS
IF FOUND()
	lnPopUpID = c_subpopup.popupid + (c_subpopup.popupcnt * 10^(7-tnLevel))
ELSE
ENDIF
RETURN INT(lnPopUpID)
ENDFUNC


*-***********************************************************************************************
*-* Function for getting the handle ID to the parent popup
*-*
FUNCTION fGetPopupHdl
LPARAMETERS tcMenuWBS
LOCAL lnPopUpHdl
SELECT c_subpopup
LOCATE FOR ALLTRIM(wbslevel) == tcMenuWBS
IF FOUND()
	lnPopUpHdl = c_subpopup.popupndx
ELSE
	lnPopUpHdl = 1
ENDIF
RETURN lnPopUpHdl
ENDFUNC


*-***********************************************************************************************
*-* Function for getting the parent menu item bar position
*-*
FUNCTION fGetItemPos
LPARAMETERS tcMenuWBS
RETURN ALLTRIM(SUBSTR(tcMenuWBS,RATC(".",tcMenuWBS)+1),1,"0"," ")
ENDFUNC