*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              green.gregory@comcast.net
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Generates a program menu definition for use with Herman Tan's OwnerDrawn menu class
*-*
#INCLUDE GKKAPI_Menu.h
FUNCTION GKKGenOwnerDrawnShortCut
LPARAMETERS toForm,tcFileName
LOCAL lnNumPads, lcMenu, lnPopUpNdx, lnBar, lnLevel, lnFirstId, lcLastHier, lnHierNdx, lnNumLines
LOCAL lnLine, lcMenuWBS, lcDefines, lcLevelName
LOCAL ARRAY laPopupNames[1]
CREATE CURSOR c_commands (menuid I, menucmd M)
CREATE CURSOR c_subpopup (wbslevel C(100), popupid I, popupndx I, popupcnt I)
SELECT c_editmnu
COUNT FOR OCCURS(".",wbslevel)=2 .AND. wbslevel="1.001" .AND. objtype=3 .AND. !DELETED() TO lnNumPads
IF lnNumPads > 0
	WITH toForm
*-*		Define the menu initialization
		lcMenu = '*-*	Generated code for menu ' + JUSTFNAME(tcFileName)
		lcMenu = lcMenu + CRLF
		lcMenu = lcMenu + CRLF + "#DEFINE True              .T."
		lcMenu = lcMenu + CRLF + "#DEFINE False             .F."
		lcMenu = lcMenu + CRLF + "#DEFINE SET_SKIPFOR       " + TRANSFORM(myODF_SKIPFOR)
		lcMenu = lcMenu + CRLF + '**DEFINES**'
		lcMenu = lcMenu + CRLF
		lcMenu = lcMenu + CRLF + 'PROCEDURE RightClick'	
		lcMenu = lcMenu + CRLF + 'LOCAL loPopup, lnResult'
		SELECT DISTINCT LevelName FROM mnufile ;
			WHERE !EMPTY( LevelName ) .AND. !('_MSYSMENU' $ UPPER( ALLTRIM( LevelName ))) ;
			INTO CURSOR curTemp
		USE IN curTemp
		lcMenu = lcMenu + CRLF + 'LOCAL ARRAY laPopupHdl[' + TRANSFORM(_Tally) + ']'
		lcMenu = lcMenu + CRLF + 'loPopup = NEWOBJECT("PopupMenu","OwnerDrawn_Menu","",1024)'
		lcMenu = lcMenu + CRLF + 'WITH loPopup'
		lcMenu = lcMenu + CRLF + '	.GDIPlus_Start()'
		lcMenu = lcMenu + CRLF + '	.hWndParent = thisform.hWnd'
		lcMenu = lcMenu + CRLF + '	.lThemed = '            + IIF(.chkOfficeThemed.value,"True","False")
		lcMenu = lcMenu + CRLF + '	.lUseGradient = '       + IIF(.chkGradLeftSide.value,"True","False")
		lcMenu = lcMenu + CRLF + '	.lGlassy = '            + IIF(.chkGlassyLook.value,"True","False")
		lcMenu = lcMenu + CRLF + '	.lUseGradientPad = '    + IIF(.chkGradMnuPad.value,"True","False")
		lcMenu = lcMenu + CRLF + '	.lEnhancedHilite = '    + IIF(.chkShadTxt.value,"True","False")
		lcMenu = lcMenu + CRLF + '	.lHiliteUseFontBold = ' + IIF(.chkBoldItem.value,"True","False")
*		lcMenu = lcMenu + CRLF + '	.nTextHiliteColor = '   + TRANSFORM()
		lcMenu = lcMenu + CRLF + '	.nHiliteStyle = ' + TRANSFORM(ODHS_ALL + ;
																  IIF(.chkRounded.value,ODHS_ROUNDED,0) + ;
																  IIF(.chkBitmapOnly.value,ODHS_BITMAPONLY,0) + ;
																  IIF(.chkRoundBitmap.value,ODHS_ROUNDED_BITMAP,0))
		lcMenu = lcMenu + CRLF + '	.SetLeftColor(' + TRANSFORM(.clsMenuLeftColor.SelectedColor) + ')'
		lcMenu = lcMenu + CRLF + '	.SetRightColor(' + TRANSFORM(.clsMenuRightColor.SelectedColor) + ',False)'
		lcMenu = lcMenu + CRLF + '	.hFontCustom = .CreateCustomFont(False,False,True)'
		lcMenu = lcMenu + CRLF
	ENDWITH
*-*	Add the main popup menu items; process the menu definition in the table
	lnPopUpNdx = 1
	lcMenu     = lcMenu + CRLF
	lcMenu     = lcMenu + CRLF + '*-*	Create Main Menu Popup Index ' + TRANSFORM(lnPopUpNdx)
	lcMenu     = lcMenu + CRLF + '	.CreatePopupItem(' + TRANSFORM(lnNumPads) + ')'
	lnBar      = 0
	SELECT MAX(OCCURS(".",wbslevel)) AS maxvalue FROM c_editmnu INTO CURSOR c_max
	lnPopUpID  = 10^(c_max.maxvalue-1) * lnPopUpNdx + 1
	lnFirstId  = lnPopUpID
	lnLevel    = 2
	SELECT c_editmnu
	SCAN FOR OCCURS(".",wbslevel)=lnLevel .AND. wbslevel="1.001" .AND. objtype=3 .AND. !DELETED()
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
					INSERT INTO c_commands (menuid,menucmd) VALUES (lnBar,c_editmnu.command)
				CASE c_editmnu.objcode = 80        && Procedure assigned
					INSERT INTO c_commands (menuid,menucmd) VALUES (lnBar,c_editmnu.procedure)
			ENDCASE
		ENDIF
	ENDSCAN
	laPopupNames[1] = lcLevelName + IIF(RIGHT(lcLevelName,1) = "_", "POP", "_POP")
	lcMenu = lcMenu + CRLF + '	laPopupHdl[' + laPopupNames[1] + '] = .CreatePopup(' + TRANSFORM(lnFirstId) + ')'
*-*	Get the menu popups for this menu
	IF RECCOUNT('c_subpopup') > 0
*-*		Get the menu popups by level
		lnLevel = lnLevel + 1
		GOTO TOP
		LOCATE FOR OCCURS(".",wbslevel)=lnLevel .AND. objtype=3 .AND. !DELETED()
		DO WHILE FOUND()
*-*			Get the menus at this level
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
*-*			Get the next level of menus
			lnLevel = lnLevel + 1
			SELECT c_editmnu
			GOTO TOP
			LOCATE FOR OCCURS(".",wbslevel)=lnLevel .AND. objtype=3 .AND. !DELETED()
		ENDDO
	ENDIF
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + '	.nFirstId = ' + TRANSFORM(lnFirstId)
	lcMenu = lcMenu + CRLF + '	lnResult  = .ActivatePopup()'
	lcMenu = lcMenu + CRLF + 'ENDWITH'
	lcMenu = lcMenu + CRLF + 'loPopup = .NULL.'
*-*	Set the menu function handler
	lcMenu = lcMenu + CRLF
	lcMenu = lcMenu + CRLF + '*-*  Owner Drawn Menu Handler'
	lcMenu = lcMenu + CRLF + '*-*'
	lcMenu = lcMenu + CRLF + 'DO CASE'
	SELECT c_commands
	SCAN
		lcMenu = lcMenu + CRLF + '	CASE lnResult = ' + TRANSFORM(c_commands.menuid)
		lnNumLines = ALINES(laCmd,c_commands.menucmd,True)
		FOR lnLine=1 TO lnNumLines
			lcMenu = lcMenu + CRLF + '		' + laCmd[lnLine]
		ENDFOR
		lcMenu = lcMenu + CRLF
	ENDSCAN
	lcMenu = lcMenu + CRLF + '	OTHERWISE'
	lcMenu = lcMenu + CRLF + '		IF lnResult != 0'
	lcMenu = lcMenu + CRLF + '			WAIT WINDOW "Popup Menu Item: " + TRANSFORM(lnResult)'
	lcMenu = lcMenu + CRLF + '		ENDIF'
	lcMenu = lcMenu + CRLF + 'ENDCASE'
*-*	Close the menu procedure
	lcMenu = lcMenu + CRLF + 'RETURN lnResult'
	lcMenu = lcMenu + CRLF + 'ENDPROC'
*-*	Add Setup function definition
	SELECT c_editmnu
	GOTO TOP
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
*-*	Set the menu defines for the Popup names
	lcDefines = "#DEFINE " + PADR(laPopupNames[1],18," ") + "1" + CRLF
	FOR lnNdx=2 TO ALEN(laPopupNames,1)
		lcDefines = lcDefines + "#DEFINE " + PADR(laPopupNames[lnNdx],18," ") + TRANSFORM(lnNdx) + CRLF
	ENDFOR
	lcMenu = STRTRAN(lcMenu,'**DEFINES**',lcDefines)
	USE IN c_subpopup
	USE IN c_commands
	USE IN c_max
	=STRTOFILE(lcMenu,tcFileName,0)
ELSE
	DO FORM GKKDisplayMsg WITH 1.5,"There are not any nodes defined in this short-cut menu"
	=INKEY(0.001,'H')
ENDIF
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
	tcMenu    = tcMenu + CRLF
	tcMenu    = tcMenu + CRLF + '*-*	Create Sub Menu Popup Index ' + TRANSFORM(tnPopUpNdx)
	tcMenu    = tcMenu + CRLF + '	.CreatePopupItem(' + TRANSFORM(tnNumBars) + ')'
	lnBar     = 0
	lnPopUpID = fGetPopupID(tcMenuWBS,tnLevel)
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
					INSERT INTO c_commands (menuid,menucmd) VALUES (lnPopUpID-10^INT(LOG10(lnPopUpID))+lnBar-1,c_editmnu.command)
				CASE c_editmnu.objcode = 80        && Procedure assigned
					INSERT INTO c_commands (menuid,menucmd) VALUES (lnPopUpID-10^INT(LOG10(lnPopUpID))+lnBar-1,c_editmnu.procedure)
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
FUNCTION fGetPopupID
LPARAMETERS tcMenuWBS,tnLevel
LOCAL lnPopUpID
SELECT c_subpopup
LOCATE FOR ALLTRIM(wbslevel) == tcMenuWBS
IF FOUND()
	lnPopUpID = c_subpopup.popupid + (c_subpopup.popupcnt * 10^(c_max.maxvalue+1-tnLevel))
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