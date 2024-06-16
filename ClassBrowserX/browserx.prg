* BROWSER.PRG - Class Browser.
*
* Copyright (c) 1995-2003 Microsoft Corp.
* 1 Microsoft Way
* Redmond, WA 98052
*
* Description:
* Class Browser for VCX/SCX files.
*

#INCLUDE "browser.h"

Parameters tcFileName,tcDefaultClass,tlListBox,tcClassType,tnWindowState,tlGallery,tlNoShow
Local oLastBrowser,lcLastSetTalk
Private lcProgramName
lcLastSetTalk=Set("TALK")
Set Talk Off
If _vfp.LanguageOptions=1
  Messagebox(M_LANGOPT_LOC)
  _vfp.LanguageOptions=0
Endif
Sys(2333,0)
oLastBrowser=.Null.
If Type("_oBrowser")=="O" And Not Isnull(_oBrowser)
  oLastBrowser=_oBrowser
Endif
Release _oBrowser
Public _oBrowser
_oBrowser=.Null.
lcProgramName=Lower(Sys(16))
If Type("tcFileName")=="N" And tcFileName=0
  If lcLastSetTalk=="ON"
    Set Talk On
  Else
    Set Talk Off
  Endif
  Return
Endif
If tlListBox And tlGallery
  Messagebox(M_LISTBOX_MODE_ERROR_LOC+".",48,M_COMPONENT_GALLERY_LOC)
  If lcLastSetTalk=="ON"
    Set Talk On
  Else
    Set Talk Off
  Endif
  Return
Endif
tlBrowser=(Not tlGallery)
If tlNoShow
  Do Form (Fullpath("browser",lcProgramName)) ;
    WITH (tcFileName),(tcDefaultClass),(tlListBox),(tcClassType), ;
    (tnWindowState),(tlGallery) Name _oBrowser Noshow
  If Vartype(_oBrowser)=="O"
    _oBrowser.Activate
  Endif
Else
  Do Form (Fullpath("browser",lcProgramName)) ;
    WITH (tcFileName),(tcDefaultClass),(tlListBox),(tcClassType), ;
    (tnWindowState),(tlGallery) Name _oBrowser
Endif
If Type("_oBrowser")#"O" Or Isnull(_oBrowser)
  _oBrowser=oLastBrowser
Endif
oLastBrowser=.Null.
If lcLastSetTalk=="ON"
  Set Talk On
Else
  Set Talk Off
Endif
Return

*-- Dummy lines for adding files to project.
Do c:\dev\BrowseR\RunCode.prg
Do c:\dev\BrowseR\VFPScrpt.prg

Do activdoc.ico
Do addclslb.bmp
Do addclslb.msk
Do addsbcls.bmp
Do addsbcls.msk
Do addins.bmp
Do addins.msk
Do apilibra.ico
Do apps.ico
Do Back.bmp
Do Back.msk
Do BrowseR.bmp
Do BrowseR.ico
Do BrowseR.msk
Do Catalog.ico
Do catalog2.ico
Do checkbx.ico
Do cfldr.ico
Do cfldr2.ico
Do Classlib.ico
Do clibrary.ico
Do cleanup.bmp
Do cleanup.msk
Do Collection.ico
Do Collection.msk
Do cmdgroup.ico
Do Code.ico
Do Combo.ico
Do cofldr.ico
Do cofldr2.ico
Do containr.ico
Do Control.ico
Do Cursor.ico
Do Cursor.msk
Do CursorAdapter.ico
Do CursorAdapter.msk
Do Custom.ico
Do Data.ico
Do DataEnvironment.ico
Do Database.ico
Do datagrid.ico
Do detlview.bmp
Do dfldr.ico
Do dfldr2.ico
Do docs.ico
Do dofldr.ico
Do dofldr2.ico
Do EditBox.ico
Do explorer.ico
Do Export.bmp
Do Export.msk
Do Find.bmp
Do Find.msk
Do ffldr.ico
Do ffldr2.ico
Do fofldr.ico
Do fofldr2.ico
Do folder.ico
Do folder2.ico
Do c:\dev\BrowseR\Forms.ico
Do frm.ico
Do forward.bmp
Do forward.msk
Do gallery.bmp
Do gallery.ico
Do gallery.msk
Do Help.bmp
Do Help.msk
Do hyprlink.ico
Do Image.ico
Do instance.ico
Do Item.ico
Do labels.ico
Do lbl.ico
Do leaf.bmp
Do lgicview.bmp
Do Line.ico
Do ListBox.ico
Do listview.bmp
Do Menus.ico
Do method.ico
Do methodc.ico
Do methodh.ico
Do oclosed.bmp
Do ole.ico
Do OleBound.ico
Do oopen.bmp
Do Open.bmp
Do Open.msk
Do openfldr.ico
Do openfld2.ico
Do openctlg.ico
Do openctl2.ico
Do OptionB.ico
Do OptionG.ico
Do options.bmp
Do options.msk
Do othrfile.ico
Do Page.ico
Do Page.msk
Do pagefrm.ico
Do pclsbrw.bmp
Do pclsbrw.msk
Do pfldr.ico
Do pfldr2.ico
Do pofldr.ico
Do pofldr2.ico
Do programs.ico
Do projhook.ico
Do Prop.ico
Do propc.ico
Do proph.ico
Do pushb.ico
Do queries.ico
Do redefine.bmp
Do redefine.msk
Do Refresh.bmp
Do Refresh.msk
Do Relation.ico
Do Relation.msk
Do Rename.bmp
Do Rename.msk
Do reports.ico
Do sep.ico
Do Shape.ico
Do smicview.bmp
Do Spinner.ico
Do stop.bmp
Do stop.msk
Do Table.ico
Do Text.ico
Do TextBox.ico
Do Timer.ico
Do Toolbar.ico
Do toolbox.ico
Do uplevel.bmp
Do uplevel.msk
Do web_doc.ico
Do web_file.ico
Do web_site.ico
Do Xmladapter.ico
Do Xmladapter.msk
Do Xmlfield.ico
Do Xmlfield.msk
Do Xmltable.ico
Do Xmltable.msk
Set Procedure To Formset.ico
Set Procedure To formpg.ico
Do Control.cur
Do dragcopy.cur
Do nodrop.cur
Do dragmove.cur
Do dragit.cur
Do Control.crm
Do dragcopy.crm
Do nodrop.crm
Do dragmove.crm
Return



Function brwGetDataType(lnType)
Do Case
  Case Type("lnType")#"N"
    Return "UNKNOWN"
  Case lnType=1
    Return "VT_NULL"
  Case lnType=2
    Return "INTEGER"
  Case lnType=3
    Return "INTEGER"
  Case lnType=4
    Return "VT_R4"
  Case lnType=5
    Return "VT_R8"
  Case lnType=6
    Return "VT_CY"
  Case lnType=7
    Return "DATE"
  Case lnType=8
    Return "STRING"
  Case lnType=9
    Return "VT_DISPATCH"
  Case lnType=10
    Return "VT_ERROR"
  Case lnType=11
    Return "BOOLEAN"
  Case lnType=12
    Return "VARIANT"
  Case lnType=13
    Return "VT_UNKNOWN"
  Case lnType=16
    Return "VT_I1"
  Case lnType=17
    Return "VT_UI1"
  Case lnType=18
    Return "VT_UI2"
  Case lnType=19
    Return "VT_UI4"
  Case lnType=20
    Return "VT_I8"
  Case lnType=21
    Return "VT_UI8"
  Case lnType=22
    Return "VT_INT"
  Case lnType=23
    Return "VT_UINT"
  Case lnType=24
    Return "VT_VOID"
  Case lnType=25
    Return "VT_HRESULT"
  Case lnType=26
    Return "VT_PTR"
  Case lnType=27
    Return "VT_SAFEARRAY"
  Case lnType=28
    Return "VT_CARRAY"
  Case lnType=29
    Return "VT_USERDEFINED"
  Case lnType=30
    Return "VT_LPSTR"
  Case lnType=31
    Return "VT_LPWSTR"
  Case lnType=64
    Return "VT_FILETIME"
  Case lnType=65
    Return "VT_BLOB"
  Case lnType=66
    Return "VT_STREAM"
  Case lnType=67
    Return "VT_STORAGE"
  Case lnType=68
    Return "VT_STREAMED_OBJECT"
  Case lnType=69
    Return "VT_STORED_OBJECT"
  Case lnType=70
    Return "VT_BLOB_OBJECT"
  Case lnType=71
    Return "VT_CF"
  Case lnType=72
    Return "VT_CLSOD"
Endcase
Return "UNKNOWN"
Endfunc



Function brwDisplayFileMenu(toBrowser,tlAddFile)
Local lnMenuCount,lnBar,lcFileName,lcAlias,lcDesc,lcJustFileName,lnAtPos
Local laMenu[1],laFiles[1]

If toBrowser.lRelease
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To (toBrowser.DataSessionId)
lcAlias=Lower(Sys(2015))
If Used(lcAlias)
  Use In (lcAlias)
Endif
If toBrowser.lBrowser
  Select Name,Desc From BrowseR ;
    WHERE Not Deleted() And Not Global And ;
    UPPER(Alltrim(Platform))==toBrowser.cPlatform And ;
    NOT Lower(Right(Name,4))==".dbf" And ;
    UPPER(Alltrim(Type))=="PREFW" And ;
    UPPER(Alltrim(Id))=="FORMINFO" And Not Empty(Name) ;
    ORDER By Updated Desc ;
    INTO Cursor (lcAlias)
Else
  Select Name,Desc From BrowseR ;
    WHERE Not Deleted() And Not Global And ;
    UPPER(Alltrim(Platform))==toBrowser.cPlatform And ;
    LOWER(Right(Name,4))==".dbf" And ;
    UPPER(Alltrim(Type))=="PREFW" And ;
    UPPER(Alltrim(Id))=="FORMINFO" And Not Empty(Name) ;
    ORDER By Updated Desc ;
    INTO Cursor (lcAlias)
Endif
lnMenuCount=0
Scan Rest
  If ":"$Name Or "\\"$Name
    lcFileName=Lower(Alltrim(Name))
  Else
    lcFileName=Lower(Fullpath(Alltrim(Name)))
  Endif
  If toBrowser.lBrowser
    If tlAddFile And Ascan(toBrowser.aFiles,lcFileName)>0
      Loop
    Endif
  Endif
  lcDesc=Alltrim(Mline(Desc,1))
  If Empty(lcDesc)
    lcDesc=lcFileName
  Endif
  If Len(lcDesc)>64
    lnAtPos=Rat("\",lcDesc)
    If lnAtPos<=3
      lcDesc=Alltrim(Left(lcDesc,61))
    Else
      lcJustFileName=Justfname(lcDesc)
      lnAtPos=Rat("\",Left(lcDesc,61-Len(lcJustFileName)))
      If lnAtPos>0
        lcDesc=Alltrim(Left(lcDesc,lnAtPos))+"\...\"+lcJustFileName
      Else
        lcDesc=lcJustFileName
      Endif
    Endif
  Endif
  lnMenuCount=lnMenuCount+1
  Dimension laMenu[lnMenuCount],laFiles[lnMenuCount]
  laMenu[lnMenuCount]=lcDesc
  laFiles[lnMenuCount]=lcFileName
  If lnMenuCount>=toBrowser.nHistoryMaxLength
    Exit
  Endif
Endscan
Use
Select 0
Set Message To
If lnMenuCount=0
  Return
Endif
toBrowser.lModalDialog=.T.
toBrowser.ShowMenu(@laMenu)
lnBar=Bar()
toBrowser.DeactivateMenu
toBrowser.lModalDialog=.F.
If lnBar=0
  Return
Endif
lcFileName=laFiles[lnBar]
If tlAddFile
  toBrowser.AddFile(lcFileName)
Else
  If toBrowser.lBrowser
    toBrowser.OpenFile(lcFileName)
  Else
    toBrowser.OpenFile(lcFileName,toBrowser.lAddFileDefault)
  Endif
Endif
Endfunc



Function brwDisplayHistoryMenu(toBrowser)
Local lnBar,lcPrompt,lcItem,lcFileName,lcMember,llBrowser,llFound
Local lnAtPos,lcAlias,lnCount,lcCount
Local laMenu[1]

If toBrowser.lRelease Or toBrowser.nHistoryCount<1
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To (toBrowser.DataSessionId)
For lnCount= 1 To toBrowser.nHistoryCount
  If lnCount>toBrowser.nHistoryMaxLength
    Exit
  Endif
  lcItem=toBrowser.aHistory[lnCount,1]
  Dimension laMenu[lnCount]
  laMenu[lnCount]=toBrowser.aHistory[lnCount,1]
Endfor
Set Message To
toBrowser.lModalDialog=.T.
toBrowser.ShowMenu(@laMenu)
lnBar=Bar()
toBrowser.DeactivateMenu
toBrowser.lModalDialog=.F.
If lnBar=0
  Return
Endif
lcItem=toBrowser.aHistory[lnBar,2]
lcFileName=toBrowser.aHistory[lnBar,3]
llBrowser=toBrowser.aHistory[lnBar,4]
If toBrowser.lBrowser#llBrowser
  toBrowser.SwitchBrowser
Endif
llFound=.T.
If llBrowser
  If Not Empty(lcFileName) And File(lcFileName) And Ascan(toBrowser.aFiles,lcFileName)=0
    llFound=toBrowser.AddFile(lcFileName)
  Endif
  If llFound
    lnAtPos=At("::",lcItem)
    If lnAtPos=0
      lcMember=""
    Else
      lcMember=Alltrim(Substr(lcItem,lnAtPos+2))
      lcItem=Alltrim(Left(lcItem,lnAtPos-1))
    Endif
    llFound=toBrowser.SeekClass(lcItem)
    If llFound
      If Empty(lcMember)
        toBrowser.oleClassList.SetFocus
      Else
        llFound=toBrowser.SeekMember(lcMember)
        If llFound
          toBrowser.oleMembers.SetFocus
        Endif
      Endif
    Endif
  Endif
Else
  If Not Empty(lcFileName) And File(lcFileName)
    llFound=.F.
    For lnCount = 1 To 256
      lcCount=Alltrim(Str(lnCount))
      lcAlias="catalog"+lcCount
      If Used(lcAlias) And Lower(Dbf(lcAlias))==lcFileName
        llFound=.T.
        Exit
      Endif
    Endfor
    If Not llFound
      llFound=toBrowser.AddFile(lcFileName)
      If llFound
        toBrowser.oleFolderList.SetFocus
      Endif
    Endif
  Endif
  If llFound
    llFound=toBrowser.SelectItem(lcItem,.T.)
  Endif
Endif
If Not llFound
  With toBrowser
    Adel(.aHistory,lnBar)
    .nHistoryCount=.nHistoryCount-1
    Dimension .aHistory[.nHistoryCount,4]
  Endwith
  Wait Clear
  Wait Window M_MATCH_NOT_FOUND_LOC Nowait
Endif
toBrowser.vResult=llFound
Return toBrowser.vResult
Endfunc



Function brwDisplayMenu(toBrowser,tnMenuMode)
Local lnMenuMode,lnMenuCount,lnMenuEndCount,lnMenuOffset,lnBar,lcMarker
Local lcMemberType,lcMember,lcToMember
Local laMenu[1]

If toBrowser.lRelease
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
toBrowser.DeactivateMenu
lnMenuMode=Iif(Type("tnMenuMode")=="N",tnMenuMode,0)
lnMenuEndCount=5
lnMenuOffset=0
Do Case
  Case Not toBrowser.lBrowser
    lnMenuMode=3
    lnMenuCount=10+lnMenuEndCount
    lnMenuOffset=5
  Case lnMenuMode=1
    lnMenuCount=15+lnMenuEndCount
  Case lnMenuMode=2
    lnMenuCount=11+lnMenuEndCount
  Otherwise
    lnMenuMode=0
    lnMenuCount=15+lnMenuEndCount
Endcase
Dimension laMenu[lnMenuCount]
laMenu=""
lcMarker="^"
laMenu[1]=B_DESCRIPTIONS1_LOC
If toBrowser.lDescriptions
  laMenu[1]=lcMarker+laMenu[1]
Endif
laMenu[2]=B_ALWAYSONTOP1_LOC
If toBrowser.AlwaysOnTop
  laMenu[2]=lcMarker+laMenu[2]
Endif
laMenu[3]=B_AUTOEXPAND1_LOC
If toBrowser.lAutoExpand
  laMenu[3]=lcMarker+laMenu[3]
Endif
laMenu[4]=B_PARENTCLASSTB1_LOC
If toBrowser.lParentClassBrowser
  laMenu[4]=lcMarker+laMenu[4]
Endif
laMenu[5]=B_RESTOREDEFAULTS1_LOC
If lnMenuMode<3
  laMenu[6]="\-"
  laMenu[7]=B_HIERARCHICAL1_LOC
  If toBrowser.nDisplayMode=1
    laMenu[7]=lcMarker+laMenu[7]
  Endif
  laMenu[8]=B_PROTECTED1_LOC
  If toBrowser.lProtectedFilter
    laMenu[8]=lcMarker+laMenu[8]
  Endif
  laMenu[9]=B_HIDDEN1_LOC
  If toBrowser.lHiddenFilter
    laMenu[9]=lcMarker+laMenu[9]
  Endif
  laMenu[10]=B_EMPTY1_LOC
  If toBrowser.lEmptyFilter
    laMenu[10]=lcMarker+laMenu[10]
  Endif
Endif
Do Case
  Case lnMenuMode=0 Or lnMenuMode=3
    laMenu[11-lnMenuOffset]="\-"
    laMenu[12-lnMenuOffset]=B_FONT1_LOC
    If (toBrowser.lBrowser And toBrowser.lVCXSCXMode) Or ;
        (Not toBrowser.lBrowser And toBrowser.nFolderCount>0)
      laMenu[13-lnMenuOffset]=B_EXPORT1_LOC
    Else
      laMenu[13-lnMenuOffset]=B_EXPORT2_LOC
    Endif
    laMenu[14-lnMenuOffset]=B_ADDINS1_LOC
  Case lnMenuMode=1
    laMenu[11]="\-"
    If Not toBrowser.lSCXMode
      laMenu[12]=B_MODIFY1_LOC
    Else
      laMenu[12]=B_MODIFY2_LOC
    Endif
    If Not toBrowser.lReadOnly And Not toBrowser.lSCXMode
      laMenu[13]=B_CONTAINERICON1_LOC
    Else
      laMenu[13]=B_CONTAINERICON2_LOC
    Endif
    If Not toBrowser.lReadOnly And Not toBrowser.lSCXMode
      laMenu[14]=B_REMOVE1_LOC
    Else
      laMenu[14]=B_REMOVE2_LOC
    Endif
    If Not "."$toBrowser.cClass
      lnMenuCount=lnMenuCount+4
      Dimension laMenu[lnMenuCount]
      If Not toBrowser.lReadOnly And Not toBrowser.lSCXMode
        laMenu[15]=B_RENAME1_LOC
      Else
        laMenu[15]=B_RENAME2_LOC
      Endif
      If Not toBrowser.lReadOnly
        laMenu[16]=B_REDEFINE1_LOC
      Else
        laMenu[16]=B_REDEFINE2_LOC
      Endif
      If Not Empty(toBrowser.aClassList[toBrowser.nClassListIndex+1,5]) And ;
          NOT toBrowser.aClassList[toBrowser.nClassListIndex+1,5]== ;
          toBrowser.aClassList[toBrowser.nClassListIndex+1,8]
        laMenu[lnMenuCount-lnMenuEndCount-2]=B_SELECTPARENTCLASS1_LOC
      Else
        laMenu[lnMenuCount-lnMenuEndCount-2]=B_SELECTPARENTCLASS2_LOC
      Endif
      If Not toBrowser.lReadOnly And Not toBrowser.lSCXMode
        laMenu[lnMenuCount-lnMenuEndCount-1]=B_OLEPUBLIC1_LOC
      Else
        laMenu[lnMenuCount-lnMenuEndCount-1]=B_OLEPUBLIC2_LOC
      Endif
      If toBrowser.aClassList[toBrowser.nClassListIndex+1,9]
        laMenu[lnMenuCount-lnMenuEndCount-1]=lcMarker+ ;
          laMenu[lnMenuCount-lnMenuEndCount-1]
      Endif
    Endif
  Case lnMenuMode=2
    With toBrowser
      lcMember=.aMemberList[.nMemberListIndex,1]
      lcMemberType=.aMemberList[.nMemberListIndex,2]
    Endwith
    Do Case
      Case lcMemberType=="o"
        lnMenuCount=lnMenuCount+2
        Dimension laMenu[lnMenuCount]
        laMenu[11]="\-"
        If Empty(toBrowser.cLastValue) Or Not ","$toBrowser.cLastValue
          laMenu[12]=B_SELECTCLASS2_LOC
        Else
          laMenu[12]=B_SELECTCLASS1_LOC
        Endif
      Case lcMemberType=="m" Or lcMemberType=="p"
        lnMenuCount=lnMenuCount+3
        Dimension laMenu[lnMenuCount]
        laMenu[11]="\-"
        If lcMemberType=="m"
          laMenu[12]=B_MODIFY1_LOC
        Else
          laMenu[12]=B_VIEW1_LOC
        Endif
        If Not toBrowser.lReadOnly And Not toBrowser.lSCXMode
          laMenu[13]=B_RENAME1_LOC
        Else
          laMenu[13]=B_RENAME2_LOC
        Endif
    Endcase
Endcase
laMenu[lnMenuCount-5]="\-"
laMenu[lnMenuCount-4]=B_NEWWINDOW1_LOC
If toBrowser.lBrowser
  laMenu[lnMenuCount-3]=B_NEWCG1_LOC
Else
  laMenu[lnMenuCount-3]=B_NEWCB1_LOC
Endif
laMenu[lnMenuCount-2]=B_REFRESH1_LOC
laMenu[lnMenuCount-1]="\-"
laMenu[lnMenuCount]=B_HELP1_LOC
toBrowser.lModalDialog=.T.
toBrowser.ShowMenu(@laMenu)
lnBar=Bar()
toBrowser.DeactivateMenu
toBrowser.lModalDialog=.F.
If lnBar=0
  Return
Endif
If lnMenuMode=3 And (lnBar+lnMenuOffset)>=12
  lnBar=lnBar+lnMenuOffset
  lnMenuCount=lnMenuCount+lnMenuOffset
Endif
Do Case
  Case lnBar=lnMenuCount
    If lnMenuMode=2 And Not toBrowser.lVCXSCXMode And toBrowser.nMemberListIndex>=1
      toBrowser.nMouseButton=1
      If toBrowser.lOutlineOCX
        toBrowser.oleMembers.DblClick
      Else
        toBrowser.lstMembers.DblClick
      Endif
    Else
      toBrowser.Help
    Endif
  Case lnBar=(lnMenuCount-2)
    toBrowser.RefreshBrowser
  Case lnBar=(lnMenuCount-3)
    toBrowser.StartNewWindow(toBrowser.lBrowser)
  Case lnBar=(lnMenuCount-4)
    toBrowser.StartNewWindow(Not toBrowser.lBrowser)
  Case lnBar=1
    toBrowser.lDescriptions=(Not toBrowser.lDescriptions)
    toBrowser.RefreshDescriptions
    toBrowser.SavePreferences
  Case lnBar=2
    toBrowser.AlwaysOnTop=(Not toBrowser.AlwaysOnTop)
    toBrowser.SavePreferences
  Case lnBar=3
    toBrowser.lAutoExpand=(Not toBrowser.lAutoExpand)
    toBrowser.RefreshBrowser
    toBrowser.SavePreferences
  Case lnBar=4
    toBrowser.lParentClassBrowser=(Not toBrowser.lParentClassBrowser)
    toBrowser.RefreshParentClassBrowser
    toBrowser.SavePreferences
  Case lnBar=5
    toBrowser.ResetDefaults
  Case lnBar=7
    toBrowser.DisplayMode(Iif(toBrowser.nDisplayMode=1,2,1))
    toBrowser.SavePreferences
  Case lnBar=8
    toBrowser.lProtectedFilter=(Not toBrowser.lProtectedFilter)
    toBrowser.RefreshMembers
    toBrowser.SavePreferences
  Case lnBar=9
    toBrowser.lHiddenFilter=(Not toBrowser.lHiddenFilter)
    toBrowser.RefreshMembers
    toBrowser.SavePreferences
  Case lnBar=10
    toBrowser.lEmptyFilter=(Not toBrowser.lEmptyFilter)
    toBrowser.RefreshMembers
    toBrowser.SavePreferences
  Case lnBar=12
    Do Case
      Case lnMenuMode=0 Or lnMenuMode=3
        toBrowser.SetFont
      Case lnMenuMode=1
        toBrowser.ModifyClass
      Case lnMenuMode=2
        Do Case
          Case lcMemberType=="o"
            toBrowser.nMouseButton=1
            If toBrowser.lOutlineOCX
              toBrowser.oleMembers.DblClick
            Else
              toBrowser.lstMembers.DblClick
            Endif
          Case lcMemberType=="p"
            toBrowser.ViewProperty(lcMember)
          Case lcMemberType=="m"
            toBrowser.ModifyClass(lcMember)
        Endcase
    Endcase
  Case lnBar=13
    Do Case
      Case lnMenuMode=0 Or lnMenuMode=3
        If toBrowser.lBrowser
          toBrowser.ExportClass(.T.,"")
        Else
          toBrowser.ExportView
        Endif
      Case lnMenuMode=1
        toBrowser.cmdClassIcon.RightClick
      Case lnMenuMode=2
        toBrowser.RenameMember
    Endcase
  Case lnBar=14
    Do Case
      Case lnMenuMode=0 Or lnMenuMode=3
        toBrowser.AddInMenu
      Case lnMenuMode=1
        toBrowser.RemoveClass(.T.)
    Endcase
  Case lnBar=15
    Do Case
      Case lnMenuMode=1
        toBrowser.RenameClass
    Endcase
  Case lnBar=16
    Do Case
      Case lnMenuMode=1
        toBrowser.RedefineClass
    Endcase
  Case lnBar=(lnMenuCount-lnMenuEndCount-2)
    Do Case
      Case lnMenuMode=1
        toBrowser.SeekParentClass
    Endcase
  Case lnBar=(lnMenuCount-lnMenuEndCount-1)
    Do Case
      Case lnMenuMode=1
        Set Message To M_UPDATING_OLEPUBLIC_LOC+" ..."
        Select (toBrowser.cAlias)
        Locate For Upper(Alltrim(Platform))=="COMMENT" And ;
          LOWER(Alltrim(ObjName))==toBrowser.cClass
        If Not Eof()
          If toBrowser.aClassList[toBrowser.nClassListIndex+1,9]
            Replace Reserved2 With ""
          Else
            Replace Reserved2 With "OLEPublic"
          Endif
          toBrowser.RefreshBrowser
        Endif
        Select 0
        Set Message To
    Endcase
  Otherwise
    Return
Endcase
Endfunc



Function brwRefreshCaption(toBrowser)
Local lcCaption,lcMember,lcHistoryItem

If toBrowser.lRelease
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcCaption=""
Do Case
  Case toBrowser.lBrowser And toBrowser.nClassListIndex<0
    lcCaption=T_CLASS_BROWSER_LOC
  Case Not toBrowser.lBrowser And toBrowser.nFolderCount<1
    lcCaption=T_COMPONENT_GALLERY_LOC
  Case toBrowser.lBrowser
    With toBrowser
      lcHistoryItem=.cClass
      If Not Empty(.cFileName)
        lcCaption=Justfname(.cFileName)
      Endif
      If .nMemberListIndex>=1
        lcMember=.aMemberList[.nMemberListIndex,1]
        lcHistoryItem=lcHistoryItem+"::"+lcMember
        If .lFileMode
          lcCaption=lcCaption+" ("+lcMember+")"
        Else
          lcCaption=lcCaption+" ("+.cClass
          If Not Empty(lcMember)
            lcCaption=lcCaption+"::"+lcMember
          Endif
          lcCaption=lcCaption+")"
        Endif
      Else
        If .lFileMode
          lcCaption=lcCaption+" ("+.cFileName+")"
        Else
          lcCaption=lcCaption+" ("+.cClass+")"
        Endif
      Endif
      lcCaption=lcCaption+" - "+T_CLASS_BROWSER_LOC
      If .lReadOnly
        lcCaption=lcCaption+" ["+M_READ_ONLY_LOC+"]"
      Endif
      .AddHistoryItem(lcHistoryItem,lcHistoryItem,.cFileName)
    Endwith
  Otherwise
    With toBrowser
      If Not Isnull(.oCatalogSource)
        lcCaption=.oCatalogSource.cText
        If Not Isnull(.oFolderSource) And Not .oItemSource.cID==.oCatalogSource.cID
          lcCaption=lcCaption+" ("+Alltrim(.oFolderSource.cText)
          If Not Isnull(.oItemSource) And Not .oItemSource.cID==.oFolderSource.cID
            lcCaption=lcCaption+"::"+Alltrim(.oItemSource.cText)
          Endif
          lcCaption=lcCaption+")"
        Endif
      Endif
      .AddHistoryItem(.oItem.cText,.oItem.cID,Iif(.nViewType=1,.oItem.cCatalog,""))
    Endwith
    lcCaption=lcCaption+" - "+T_COMPONENT_GALLERY_LOC
Endcase
If toBrowser.Caption==lcCaption
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
toBrowser.Caption=lcCaption
If toBrowser.AddInMethod("REFRESHCAPTION")
  Return
Endif
Endfunc



Function brwOpenCatalog(toBrowser,tcFileDesc,tlAddMode)

toBrowser.vResult=toBrowser.OpenFile(tcFileDesc,tlAddMode)
Return toBrowser.vResult
Endfunc



Function brwOpenFile(toBrowser,tcFileName,tlAddMode,tlIgnoreRefresh)
Local lcFileName,lcFileName2,llAddMode,lcFilter,lcClass,lcName,lnFileNo
Local llRefreshClassList,lnCount,lcCount,lcAlias,lcAlias2,lcKeywordsDBF
Local lnFileCount,lnFileOpenCount,oOpenCatalogForm,llIgnoreErrors
Local lcSelectFileName,oFolder,oFolder2
Local laFiles[1],laFilesOpen[1]

If toBrowser.lRelease
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To toBrowser.DataSessionId
llAddMode=tlAddMode
llRefreshClassList=.F.
If toBrowser.lInitialized
  toBrowser.SavePreferences(,Not toBrowser.lBrowser)
Endif
Do While .T.
  If Empty(tcFileName) Or Type("tcFileName")#"C"
    Select 0
    Set Message To
    If toBrowser.lBrowser
      lcFileName=toBrowser.Getfile()
    Else
      toBrowser.lModalDialog=.T.
      Do Form cgopncat Name oOpenCatalogForm ;
        WITH toBrowser To lcFileName
      Set DataSession To toBrowser.DataSessionId
      If Left(lcFileName,1)=="+"
        lcFileName=Lower(Alltrim(Substr(lcFileName,2)))
        llAddMode=.T.
      Endif
    Endif
  Else
    lcFileName=Lower(Alltrim(tcFileName))
    If Empty(Justext(lcFileName))
      lcFileName=Forceext(lcFileName,Iif(toBrowser.lBrowser,"vcx","dbf"))
    Endif
  Endif
  If Empty(lcFileName)
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  lcSelectFileName=lcFileName
  If Not toBrowser.lBrowser
    If Empty(Justext(lcFileName))
      lcFileName=Forceext(lcFileName,"dbf")
    Endif
    If Not ":"$lcFileName And Not "\\"$lcFileName
      lcFileName=Lower(Fullpath(lcFileName))
    Endif
    If Not File(lcFileName)
      lcFileName=Lower(Forcepath(lcFileName,toBrowser.cProgramPath+"gallery\"))
      If Not File(lcFileName)
        toBrowser.cCatalog=""
        Select 0
        Set Message To
        toBrowser.MsgBox(M_FILE_LOC+[ "]+lcFileName+[" ]+M_DOES_NOT_EXIST_LOC+[.],16)
        toBrowser.vResult=.F.
        Return toBrowser.vResult
      Endif
    Endif
    If llAddMode
      lcAlias2="catalog"
      For lnCount = 1 To 256
        lcCount=Alltrim(Str(lnCount))
        lcAlias=lcAlias2+lcCount
        If Not Used(lcAlias)
          Exit
        Endif
        If Lower(Dbf(lcAlias))==lcFileName
          Select 0
          Return
        Endif
      Endfor
    Endif
    toBrowser.CloseViews(.T.)
    lcAlias2="catalog"
    For lnCount = 1 To 256
      lcCount=Alltrim(Str(lnCount))
      lcAlias=lcAlias2+lcCount
      If Not Used(lcAlias)
        Exit
      Endif
      If Not llAddMode
        toBrowser.UpdateFormCount(-1,Dbf(lcAlias))
        Use In (lcAlias)
      Endif
    Endfor
    If Not llAddMode
      lnFileCount=0
      laFiles=""
      lnFileOpenCount=0
      laFilesOpen=""
      Select BrowseR
      Scan All For Global And;
          UPPER(Alltrim(Platform))==toBrowser.cPlatform And ;
          UPPER(Alltrim(Type))=="PREFW" And ;
          UPPER(Alltrim(Id))=="FORMINFO" And Not Empty(Name)
        lcName=Lower(Alltrim(Mline(Name,1)))
        If Not (".dbf"$lcName)
          Loop
        Endif
        If Not File(lcName)
          Delete
          Loop
        Endif
        lnFileCount=lnFileCount+1
        Dimension laFiles[lnFileCount]
        laFiles[lnFileCount]=Iif(Default," ","_")+Ttoc(Updated)+lcName
      Endscan
      Select 0
      For lnCount = 1 To lnFileCount
        lcName=Substr(laFiles[lnCount],22)
        If lcName==lcFileName Or (lnFileOpenCount>0 And Ascan(laFilesOpen,lcName)>0)
          Loop
        Endif
        lnFileOpenCount=lnFileOpenCount+1
        Dimension laFilesOpen[lnFileOpenCount]
        laFilesOpen[lnFileOpenCount]=lcName
        If toBrowser.AddFile(lcName,.T.)
          llAddMode=.T.
        Endif
      Endfor
      Select 0
    Endif
    Set Message To M_OPENING_FILE_LOC+[ "]+lcFileName+[" ...]
    If toBrowser.lInitialized And Not llAddMode
      toBrowser.CloseViews(.T.)
      toBrowser.ClearBrowser
    Endif
    lcAlias2="catalog"
    lnCount=1
    Do While .T.
      lcCount=Alltrim(Str(lnCount))
      lnCount=lnCount+1
      lcAlias=lcAlias2+lcCount
      If Not Used(lcAlias)
        Exit
      Endif
    Enddo
    If Not llAddMode
      lcCount="1"
      lcAlias=lcAlias2+lcCount
    Endif
    If Empty(toBrowser.cGallery)
      toBrowser.cGallery=lcAlias
    Endif
    If Used(lcAlias)
      toBrowser.UpdateFormCount(-1,Dbf(lcAlias))
      Use In (lcAlias)
    Endif
    Select 0
    llIgnoreErrors=toBrowser.lIgnoreErrors
    toBrowser.lIgnoreErrors=.T.
    Select 0
    Use (lcFileName) Exclusive Alias (lcAlias)
    If Used()
      Pack Memo
    Endif
    Use (lcFileName) Again Shared Alias (lcAlias)
    toBrowser.lIgnoreErrors=llIgnoreErrors
    If Not Used()
      toBrowser.MsgBox(M_UNABLE_TO_OPEN_LOC+[ "]+lcFileName+[".],16)
      toBrowser.cCatalog=""
      Select 0
      Set Message To
      toBrowser.vResult=.F.
      Return toBrowser.vResult
    Endif
    toBrowser.cCatalog=lcFileName
    If Not toBrowser.VersionCheck(.T.)
      If Used(lcAlias)
        Use In (lcAlias)
      Endif
      toBrowser.cCatalog=""
      Select 0
      Set Message To
      toBrowser.vResult=.F.
      Return toBrowser.vResult
    Endif
    Set Filter To Not Deleted()
    Locate
    If Empty(toBrowser.cDefaultCatalog)
      toBrowser.cDefaultCatalog=lcFileName
      toBrowser.cDefaultCatalogPath=Iif(Empty(lcFileName),"",Justpath(lcFileName)+"\")
    Endif
    Replace All SrcAlias With Lower(Alias()), SrcRecNo With Recno()
    toBrowser.UpdateFormCount(1,lcFileName)
    With toBrowser
      .cGallery=lcAlias
      lcAlias2="view_default"
      .ClearProperties
      If Used("catalog1")
        Select catalog1
        lcFileName=Lower(Dbf())
        .RefreshPrefRecNo
      Endif
    Endwith
    If Not Used("keywords")
      lcKeywordsDBF=toBrowser.cDefaultCatalogPath+"keywords.dbf"
      Select 0
      If Not File(lcKeywordsDBF)
        Create Table (lcKeywordsDBF) (Keyword c(30))
      Endif
      Use (lcKeywordsDBF) Again Shared Alias keywords
      If Not Lower(Key(1))=="keyword"
        Index On Keyword Tag Keyword
      Endif
      Set Order To Keyword
      Locate
      Select 0
    Endif
    Select 0
    With toBrowser
      If .lInitialized And Not tlIgnoreRefresh
        .RefreshBrowser
        oFolder=.Null.
        If Not Empty(lcSelectFileName)
          For lnCount = 1 To .nFolderCount
            oFolder2=.aFolderList[lnCount]
            If Isnull(oFolder2) Or Not oFolder2.lFolder
              Loop
            Endif
            With oFolder2
              If Lower(Alltrim(.cCatalog))==lcSelectFileName
                oFolder=oFolder2
                If oFolder.lDeleted
                  oFolder=.Null.
                Endif
                Exit
              Endif
            Endwith
          Endfor
          oFolder2=.Null.
          If Not Isnull(oFolder)
            .SelectFolder(oFolder)
          Endif
        Endif
        Set Message To
      Endif
    Endwith
    Return
  Endif
  If Empty(lcFileName)
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  If lcFileName==toBrowser.cFileName And toBrowser.nFileCount=1
    toBrowser.SeekClass("("+lcFileName+")")
    Return
  Endif
  If File(lcFileName) Or toBrowser.NewFile(lcFileName)
    Exit
  Endif
  If Not ":"$lcFileName And Not "\\"$lcFileName
    lcFileName=Lower(Fullpath(lcFileName))
  Endif
  If Not File(lcFileName)
    Select 0
    Set Message To
    toBrowser.MsgBox(M_FILE_LOC+[ "]+lcFileName+[" ]+M_DOES_NOT_EXIST_LOC+[.],16)
    toBrowser.cFileName=""
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
Enddo
If Right(lcFileName,4)==".pjx"
  If Used("_tempproject")
    Use In _tempproject
  Endif
  Use (lcFileName) Again Shared Alias _tempproject
  If Not Used()
    toBrowser.cFileName=""
    toBrowser.MsgBox(M_UNABLE_TO_OPEN_LOC+[ "]+lcFileName+[".],16)
    Select 0
    Set Message To
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  Set Filter To Not Deleted()
  Locate
  Scan All For Type=="V" Or Type=="K"
    llRefreshClassList=.T.
    lcFileName2=Lower(Alltrim(Strtran(Mline(Name,1),Chr(0),"")))
    If Not ":"$lcFileName2 And Not "\\"$lcFileName2
      lcFileName2=Lower(Fullpath(lcFileName2,lcFileName))
    Endif
    If llAddMode
      toBrowser.AddFile(lcFileName2,.T.)
    Else
      toBrowser.OpenFile(lcFileName2,.T.,.T.)
      llAddMode=.T.
    Endif
  Endscan
  Use
  If toBrowser.lInitialized And llRefreshClassList
    toBrowser.RefreshBrowser
  Endif
  Select 0
  If toBrowser.lInitialized
    Set Message To
  Endif
  Return
Endif
Set Message To M_OPENING_FILE_LOC+[ "]+lcFileName+[" ...]
With toBrowser
  For lnFileNo = 1 To .nFileCount
    lcFileName2=.aFiles[lnFileNo]
    If Empty(lcFileName2)
      Loop
    Endif
    lcAlias="metadata"+Alltrim(Str(Ascan(.aFiles,lcFileName2)))
    If Used(lcAlias)
      toBrowser.UpdateFormCount(-1,lcFileName2)
      Use In (lcAlias)
    Endif
  Endfor
  If Not Empty(.cAlias) And Used(.cAlias)
    Use In (.cAlias)
  Endif
  If .lInitialized
    .ClearBrowser
  Endif
  .nFileCount=1
  Dimension .aFiles[1]
  .aFiles[1]=lcFileName
  .cAlias="metadata1"
  lcClass=.cClass
  Select 0
  .cFileName=lcFileName
  .cFileNamePath=Iif(Empty(lcFileName),"",Justpath(lcFileName)+"\")
  .nClassTimeStamp=0
  .cClass=""
  .lFileMode=.T.
  .RefreshFileAttrib
  .lSCXMode=(Right(.cFileName,4)==".scx")
  .lVCXSCXMode=(.lSCXMode Or Right(.cFileName,4)==".vcx")
Endwith
If toBrowser.lVCXSCXMode
  Use (toBrowser.cFileName) Again Shared Alias (toBrowser.cAlias)
  If Not Used()
    toBrowser.MsgBox(M_UNABLE_TO_OPEN_LOC+[ "]+toBrowser.cFileName+[".],16)
    toBrowser.cFileName=""
    Select 0
    Set Message To
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  If Not toBrowser.VersionCheck(.T.)
    toBrowser.cFileName=""
    If Used(toBrowser.cAlias)
      Use In (toBrowser.cAlias)
    Endif
    Select 0
    Set Message To
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  CursorSetProp("Buffering",1)
  lcFilter=toBrowser.cFilter
  Set Filter To &lcFilter
  Locate
  Select 0
Endif
Select 0
If toBrowser.lInitialized And Not tlIgnoreRefresh
  toBrowser.cClass="("+toBrowser.cFileName+")"
  toBrowser.RefreshBrowser
  Set Message To
Endif
toBrowser.UpdateFormCount(1,toBrowser.cFileName)
Endfunc



Function brwAddFile(toBrowser,tcFileName,tlIgnoreRefresh)
Local lcFileName,lcFilter,lcLastFileName,lcLastAlias
Local lnFileCount,lnCount,llMatch,lnFileNo

If toBrowser.lRelease
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To toBrowser.DataSessionId
If Not toBrowser.lBrowser
  Return toBrowser.OpenFile(tcFileName,.T.,tlIgnoreRefresh)
Endif
If Empty(tcFileName)
  Select 0
  Set Message To
  lcFileName=toBrowser.Getfile()
Else
  lcFileName=Lower(tcFileName)
Endif
If Empty(lcFileName)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcFileName=Alltrim(lcFileName)
If Empty(Justext(lcFileName))
  lcFileName=Forceext(lcFileName,"vcx")
Endif
If Not ":"$lcFileName And Not "\\"$lcFileName
  lcFileName=Lower(Fullpath(lcFileName))
Endif
If Not File(lcFileName) And Not toBrowser.NewFile(lcFileName)
  Select 0
  Set Message To
  toBrowser.MsgBox(M_FILE_LOC+[ "]+Lower(Fullpath(lcFileName,toBrowser.cProgramPath))+ ;
    [" ]+M_DOES_NOT_EXIST_LOC+[.],16)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Ascan(toBrowser.aFiles,lcFileName)>0
  toBrowser.SeekClass("("+lcFileName+")")
  Return
Endif
If Right(lcFileName,4)==".pjx"
  toBrowser.OpenFile(lcFileName,.T.)
  Return
Endif
Set Message To M_ADDING_FILE_LOC+[ "]+lcFileName+[" ...]
lnFileCount=toBrowser.nFileCount
lcLastFileName=toBrowser.cFileName
lcLastAlias=toBrowser.cAlias
For lnCount = 1 To lnFileCount
  If Empty(toBrowser.aFiles[lnCount])
    lnFileNo=lnCount
    llMatch=.T.
    Exit
  Endif
Endfor
With toBrowser
  If Not llMatch
    .nFileCount=.nFileCount+1
    Dimension .aFiles[.nFileCount]
    lnFileNo=.nFileCount
  Endif
  .aFiles[lnFileNo]=lcFileName
  .cAlias="metadata"+Alltrim(Str(lnFileNo))
  If Not Empty(.cAlias) And Used(.cAlias)
    Use In (.cAlias)
  Endif
  Select 0
  .cFileName=lcFileName
  .cFileNamePath=Iif(Empty(lcFileName),"",Justpath(lcFileName)+"\")
  .RefreshFileAttrib
  .lSCXMode=(Right(lcFileName,4)==".scx")
  .lVCXSCXMode=(.lSCXMode Or Right(lcFileName,4)==".vcx")
Endwith
If toBrowser.lVCXSCXMode
  Use (toBrowser.cFileName) Again Shared Alias (toBrowser.cAlias)
  If Not Used()
    With toBrowser
      .nFileCount=lnFileCount
      Dimension .aFiles[lnFileCount]
      .cFileName=lcLastFileName
      .cFileNamePath=Iif(Empty(lcLastFileName),"",Justpath(lcLastFileName)+"\")
      .cAlias=lcLastAlias
      .RefreshFileAttrib
      .lSCXMode=(Right(lcFileName,4)==".scx")
      .lVCXSCXMode=(.lSCXMode Or Right(lcFileName,4)==".vcx")
    Endwith
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  If Not toBrowser.VersionCheck(.T.)
    With toBrowser
      .nFileCount=lnFileCount
      Dimension .aFiles[lnFileCount]
      .cFileName=lcLastFileName
      .cFileNamePath=Iif(Empty(lcLastFileName),"",Justpath(lcLastFileName)+"\")
      .cAlias=lcLastAlias
      .RefreshFileAttrib
      .lSCXMode=(Right(.cFileName,4)==".scx")
      .lVCXSCXMode=(.lSCXMode Or Right(.cFileName,4)==".vcx")
    Endwith
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  CursorSetProp("Buffering",1)
  lcFilter=toBrowser.cFilter
  Set Filter To &lcFilter
  Locate
Else
  toBrowser.cClass="("+lcFileName+")"
Endif
If Not tlIgnoreRefresh
  If toBrowser.lBrowser
    toBrowser.cClass="("+lcFileName+")"
  Endif
  toBrowser.RefreshBrowser
Endif
Select 0
If toBrowser.lInitialized
  Set Message To
Endif
toBrowser.UpdateFormCount(1,lcFileName)
Endfunc



Function brwRefreshFolderList(toBrowser)
Local oItem,lcCatalog,lnCount,llActive,lcClassLibrary,llLockScreen

If toBrowser.lRelease Or toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To toBrowser.DataSessionId
Select 0
Set Message To M_REFRESH_FOLDER_LIST_LOC+" ("+toBrowser.cViewType+") ..."
With toBrowser
  If Used(.cGallery)
    .cCatalog=Lower(Dbf(.cGallery))
  Endif
  lcCatalog=.cCatalog
  If .lInitialized
    .ClearNodes(.oleFolderList)
    .nFolderCount=0
    .RefreshCaption
    .RefreshItemList
  Endif
Endwith
If Empty(lcCatalog)
  Select 0
  Set Message To
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcCatalog=toBrowser.cCatalog
If Empty(lcCatalog)
  Select 0
  Set Message To
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set Message To M_REFRESH_FOLDER_LIST_LOC+" ("+toBrowser.cViewType+") ..."
lcClassLibrary=Lower(Alltrim(toBrowser.cDefaultCatalogClassLibrary))
If Empty(lcClassLibrary)
  toBrowser.cCatalog=""
  Select 0
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Not File(lcClassLibrary)
  lcClassLibrary=Lower(Forcepath(lcClassLibrary,toBrowser.cProgramPath+"gallery\"))
  If Not File(lcClassLibrary)
    toBrowser.cCatalog=""
    If Used(toBrowser.cGallery)
      Use In (toBrowser.cGallery)
    Endif
    Select 0
    Set Message To
    toBrowser.MsgBox(M_FILE_LOC+[ "]+lcClassLibrary+[" ]+M_DOES_NOT_EXIST_LOC+[.],16)
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  toBrowser.cDefaultCatalogClassLibrary=lcClassLibrary
Endif
With toBrowser
  .lError=.F.
  llActive=.lActive
  .lActive=.T.
  llLockScreen=.LockScreen
  .LockScreen=.T.
  If Not .lRefreshBrowserMode
    .oleFolderList.Enabled=.F.
    .oleFolderList.Visible=.F.
  Endif
  .RefreshObjects
Endwith
If toBrowser.lRelease
  toBrowser.LockScreen=llLockScreen
  Select 0
  Set Message To
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Type("toBrowser.oleFolderList.object.Nodes[1].Selected")#"L"
  toBrowser.nFolderCount=0
Endif
If toBrowser.nFolderListIndex<1 And toBrowser.nFolderCount>0
  With toBrowser
    .nFolderListIndex=1
    .nLastFolderListIndex=-1
    .oleFolderList.Object.Nodes[1].Selected=.T.
    .oCatalogSource=.aFolderList[1]
    .oCatalog=.oCatalogSource.oLink
    .oFolderSource=.oCatalogSource
    .oFolder=.oCatalog
    .oItemSource=.oFolderSource
    .oItem=.oFolder
    .cCatalog=.oItem.cSourceCatalog
  Endwith
Endif
With toBrowser
  .lError=.F.
  If Not .lRefreshBrowserMode
    .oleFolderList.Enabled=.T.
    .oleFolderList.Visible=.T.
  Endif
  .lActive=llActive
  .LockScreen=llLockScreen
Endwith
Select 0
Set Message To
Endfunc



Function brwRefreshObjects(toBrowser,toFolder)
Private oTHIS
Local llRefreshFolders,oNode,lcText,lcClass,lcItemClass,lcClassLibrary,lcItemType
Local oParent,oFolder,oItem,lcItem,oObject,oView,lcCatalog,lcLastCatalog,lcCatalogPath
Local lnType,lnIndex,lnImageIndex,lcKey,lcAlias,lcAlias2,lcDBF,lcID,lcID2,lcPicture
Local lcFolderID,llIgnoreErrors,lnCount,lcCount,lnCount2,lnAtPos,lnAtPos2,llVisible
Local lnViewType,lcViewType,lcViews,lcViewItem,lcViewAlias,lcViewCatalog,lcSourceAlias
Local lnCatalogRecNo,lcCatalogID,lcProperties,lcLabel,lcProperty,lcWidth,lcValidExpr
Local lcDesc,lcClassLib,lcItemClass,lcItemTypes,llReadOnly,llViewMode,llMenuItem
Local lcGetFileExt,lcRowSource,lcScript,lnFolderCount,llMatch,oRecord
Local lcMemLine,lnRecNo,llMaxFolderCountErrorMsg,lcType,lcLink
Local laFolderID[1],laFolderText[1]

If toBrowser.lRelease Or toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To toBrowser.DataSessionId
llMaxFolderCountErrorMsg=.F.
lcCatalog=""
lcLastCatalog=" "
lnCatalogRecNo=0
lcCatalogID=""
oTHIS=.Null.
oParent=.Null.
oFolder=.Null.
oNode=.Null.
oItem=.Null.
oRecord=.Null.
oView=.Null.
llRefreshFolders=(Type("toFolder")#"O" Or Isnull(toFolder))
If llRefreshFolders
  If toBrowser.nFolderCount>0
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  lcFolderID=""
  lcViewCatalog=""
Else
  oFolder=toFolder
  toFolder=.Null.
  oFolder.nItemCount=0
  If toBrowser.nFolderCount<=0
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  lcFolderID=oFolder.cID
  oParent=oFolder
  Do While Not oParent.cID==oParent.oFolder.cID
    oParent=oParent.oFolder
  Enddo
  lcViewCatalog=Lower(oParent.cCatalog)
  oParent=.Null.
Endif
lcClassLibrary=toBrowser.cClassLibrary
If Not brwSetClassLibrary(toBrowser,toBrowser.cDefaultCatalogClassLibrary)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Empty(toBrowser.cGallery)
  toBrowser.cGallery="view_default"
Endif
lnViewType=toBrowser.nViewType
lcViewType=Lower(Alltrim(toBrowser.cViewType))
If llRefreshFolders
  lcAlias="view_default"
  If Used(lcAlias)
    Select (lcAlias)
    Zap
  Else
    toBrowser.CreateCatalog(lcAlias)
    If Not Used(lcAlias)
      toBrowser.vResult=.F.
      Return toBrowser.vResult
    Endif
  Endif
  Select (lcAlias)
  Set Order To
  Locate
  lcAlias2="catalog"
  For lnCount = 1 To 256
    lcCount=Alltrim(Str(lnCount))
    lcViewAlias=lcAlias2+lcCount
    If Not Used(lcViewAlias)
      Loop
    Endif
    Select (lcAlias)
    Append From (Dbf(lcViewAlias)) For Not Deleted()
  Endfor
  Index On Upper(Type) Tag Type
Endif
lcAlias=Lower(toBrowser.cGallery)
llViewMode=(llRefreshFolders And lnViewType>1 And Left(lcAlias,5)=="view_")
oView=toBrowser.oView
toBrowser.oView=.Null.
If llViewMode And Vartype(oView)=="O" And toBrowser.RefreshView(oView)=0
  oView.Release
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If llViewMode And Isnull(oView)
  Select (lcAlias)
  Zap
  lnFolderCount=0
  Dimension laFolderID[1],laFolderText[1]
  laFolderID=""
  laFolderText=""
  lcCatalog=Lower(Sys(2015))
  oNode=toBrowser.CreateNode(lcAlias,"FOLDER")
  With oNode
    .cID=lcCatalog
    .cText=toBrowser.cViewType
    .WriteProperties
  Endwith
  Select view_default
  Scan All
    lcType=Upper(Alltrim(Type))
    If lcType=="OBJECT"
      oRecord=.Null.
      Scatter Memo Name oRecord
      Select (lcAlias)
      Append Blank
      Gather Memo Name oRecord
      oRecord=.Null.
      Select view_default
      Loop
    Endif
    If lcType=="VIEW"
      oRecord=.Null.
      Scatter Memo Name oRecord
      Select (lcAlias)
      Append Blank
      oRecord.Parent=lcCatalog
      Gather Memo Name oRecord
      oRecord=.Null.
      Select view_default
      Loop
    Endif
    If Empty(Views) Or Not lcType=="ITEM"
      Loop
    Endif
    lcViews=Alltrim(Views)
    lcID=Lower(Sys(2015))
    _Mline=0
    For lnCount = 1 To Memlines(lcViews)
      lcMemLine=Alltrim(Mline(lcViews,1,_Mline))
      If Empty(lcMemLine)
        Loop
      Endif
      lnAtPos=At("=",lcMemLine)
      If lnAtPos=0
        Loop
      Endif
      lcViewAlias=Proper(Alltrim(Left(lcMemLine,lnAtPos-1)))
      If Empty(lcViewAlias)
        Loop
      Endif
      lcViewAlias="view_"+Strtran(lcViewAlias," ","_")
      If Not Lower(lcViewAlias)==lcAlias
        Loop
      Endif
      lcViewItem=Alltrim(Substr(lcMemLine,lnAtPos+1))
      oRecord=.Null.
      Scatter Memo Name oRecord
      lcParent=Lower(Alltrim(oRecord.Parent))
      If Empty(lcViewItem)
        oRecord.Parent=lcCatalog
      Else
        lnIndex=Ascan(laFolderText,Lower(lcViewItem)+" ")
        If lnIndex=0
          If Vartype(oNode)=="O"
            oNode.Release
          Endif
          oNode=toBrowser.CreateNode(lcAlias,"FOLDER")
          With oNode
            .cParent=lcCatalog
            .cText=lcViewItem
            .WriteProperties
            lnFolderCount=lnFolderCount+1
            Dimension laFolderID[lnFolderCount],laFolderText[lnFolderCount]
            laFolderID[lnFolderCount]=.cID
            laFolderText[lnFolderCount]=Lower(lcViewItem)+" "
            oRecord.Parent=.cID
          Endwith
          If Vartype(oNode)=="O"
            oNode.Release
          Endif
          oNode=.Null.
        Else
          oRecord.Parent=laFolderID[lnIndex]
        Endif
      Endif
      lnRecNo=Recno()
      Do While Not Empty(lcParent)
        Locate For Lower(Alltrim(Id))==lcParent
        If Eof()
          Exit
        Endif
        lcParent=Lower(Alltrim(Parent))
        With oRecord
          If Empty(.Classlib) And Not Empty(Classlib)
            .Classlib=Classlib
          Endif
          If Empty(.ItemClass) And Not Empty(ItemClass)
            .ItemClass=ItemClass
          Endif
          If lcType=="ITEM" And Empty(.ClassName) And Not Empty(ItemClass)
            .ClassName=ItemClass
          Endif
          If Empty(.ItemTpDesc) And Not Empty(ItemTpDesc)
            .ItemTpDesc=ItemTpDesc
          Endif
          If Empty(.Picture) And Not Empty(Picture)
            .Picture=Picture
          Endif
        Endwith
      Enddo
      lcID=Lower(Alltrim(oRecord.Id))
      Go lnRecNo
      Select (lcAlias)
      Locate For Lower(Alltrim(Id))==lcID
      If Eof()
        Append Blank
        Gather Memo Name oRecord
      Endif
      oRecord=.Null.
    Endfor
  Endscan
  If Vartype(oNode)=="O"
    oNode.Release
  Endif
  oNode=.Null.
Endif
If Vartype(oView)=="O"
  oView.Release
  oView=.Null.
Endif
Select 0
If llRefreshFolders And lnViewType=1
  If Used("itemtypes")
    Select itemtypes
    Zap
  Else
    Create Cursor itemtypes (Class c(64), Text c(32), Label c(32), Property c(64), ;
      Width N(4), ValidExpr M, Visible L, MenuItem L, ReadOnly L, Desc M, Classlib M, ;
      ItemClass M, itemtypes M, GetFileExt M, RowSource M, Script M)
    Select itemtypes
    Index On Class Tag Class For Not MenuItem
    Index On Upper(Text) Tag Text For MenuItem Unique Additive
    Set Order To Class
    Locate
  Endif
  Select 0
Endif
Select (lcAlias)
If llRefreshFolders
  Locate
Else
  Seek "FOLDER "
Endif
Scan Rest
  lnRecNo=Recno()
  lcType=Upper(Alltrim(Type))
  If llRefreshFolders
    If lcType=="CLASS"
      If lnViewType#1
        Loop
      Endif
      lcID=Lower(Alltrim(Id))
      lcText=Alltrim(Text)
      lcDesc=Alltrim(Desc)
      lcClassLib=Alltrim(Classlib)
      lcClass=Lower(Alltrim(ClassName))
      lcItemClass=Alltrim(ItemClass)
      If Empty(ItemTpDesc)
        lcItemTypes=""
      Else
        lcItemTypes=CR+Lower(Strtran(Strtran(Strtran(Strtran(Strtran(Alltrim(ItemTpDesc), ;
          CR_LF,CR),LF,CR),";",CR)," ",""),Tab,""))+CR
      Endif
      If Empty(Views)
        lcGetFileExt=""
      Else
        lcGetFileExt=Lower(Strtran(Strtran(Strtran(Alltrim(Views), ;
          CR_LF,";"),LF,";"),CR,";"))
      Endif
      lcScript=Alltrim(Script)
      lcProperties=Alltrim(Properties)
      lcProperty=Alltrim(TypeDesc)
      llMenuItem=.T.
      llVisible=.F.
      If Not Empty(lcText)
        If Left(lcText,1)=="!"
          lcText=Alltrim(Substr(lcText,2))
        Else
          llVisible=.T.
        Endif
      Endif
      Insert Into itemtypes (Class, Text, Property, Visible, MenuItem, Desc, Classlib, ;
        ItemClass, itemtypes, GetFileExt, Script) ;
        VALUES (lcClass, lcText, lcProperty, llVisible, llMenuItem, lcDesc, ;
        lcClassLib, lcItemClass, lcItemTypes, lcGetFileExt, lcScript)
      Select itemtypes
      _Mline=0
      For lnCount = 1 To Memlines(lcProperties)
        lcLabel=""
        lcProperty=""
        lcWidth=""
        lcValidExpr=""
        lcGetFileExt=""
        lcLabel=Alltrim(Mline(lcProperties,1,_Mline))
        lnAtPos=At(":=",lcLabel)
        If lnAtPos>0
          lcValidExpr=Alltrim(Substr(lcLabel,lnAtPos+2))
          lcLabel=Alltrim(Left(lcLabel,lnAtPos-1))
        Endif
        lnAtPos=At("{",lcLabel)
        If lnAtPos>0
          lnAtPos2=At("}",lcLabel)
          If lnAtPos2>lnAtPos
            lcGetFileExt=Substr(lcLabel,lnAtPos+1,lnAtPos2-lnAtPos-1)
            If Empty(lcGetFileExt)
              lcGetFileExt="*"
            Else
              lcGetFileExt=Lower(Alltrim(lcGetFileExt))
            Endif
            lcLabel=Left(lcLabel,lnAtPos-1)+Substr(lcLabel,lnAtPos2+1)
          Endif
        Endif
        lnAtPos=At(",",lcLabel)
        If lnAtPos=0
          Loop
        Endif
        lcProperty=Alltrim(Substr(lcLabel,lnAtPos+1))
        lcLabel=Alltrim(Left(lcLabel,lnAtPos-1))
        lnAtPos=At("[",lcProperty)
        lnAtPos2=At("]",lcProperty)
        If lnAtPos=0 Or lnAtPos2=0 Or lnAtPos>lnAtPos2
          lcRowSource=""
        Else
          lcRowSource=Alltrim(Substr(lcProperty,lnAtPos+1,lnAtPos2-lnAtPos-1))
          lcProperty=Alltrim(Left(lcProperty,lnAtPos-1))+ ;
            ALLTRIM(Substr(lcProperty,lnAtPos2+1))
        Endif
        lcWidth="50"
        lnAtPos=At(",",lcProperty)
        If lnAtPos>0
          lnAtPos2=At("]",lcProperty)
          If lnAtPos2=0
            lnAtPos2=At(")",lcProperty)
          Endif
          If Between(lnAtPos,1,lnAtPos2)
            lnAtPos=At(",",lcProperty,2)
          Endif
        Endif
        If lnAtPos>0
          lcWidth=Alltrim(Substr(lcProperty,lnAtPos+1))
          lcProperty=Alltrim(Left(lcProperty,lnAtPos-1))
        Endif
        llReadOnly=.F.
        llVisible=.F.
        If Not Empty(lcLabel)
          If Left(lcLabel,1)=="!"
            lcLabel=Alltrim(Substr(lcLabel,2))
          Else
            llVisible=.T.
            If Left(lcLabel,1)=="*"
              lcLabel=Alltrim(Substr(lcLabel,2))
              llReadOnly=.T.
            Endif
          Endif
        Endif
        Insert Into itemtypes (Class, Label, Property, Width, ValidExpr, Visible, ;
          ReadOnly, itemtypes, GetFileExt, RowSource) ;
          VALUES (lcClass, lcLabel, lcProperty, Evaluate(lcWidth), ;
          lcValidExpr, llVisible, llReadOnly, lcItemTypes, ;
          lcGetFileExt, lcRowSource)
      Endfor
      Select BrowseR
      Loop
    Endif
    If lnViewType=1 And lnCatalogRecNo>0 And Not Empty(Views) And lcType=="ITEM"
      lcViews=Alltrim(Views)
      _Mline=0
      For lnCount = 1 To Memlines(lcViews)
        lcMemLine=Alltrim(Mline(lcViews,1,_Mline))
        If Empty(lcMemLine)
          Loop
        Endif
        lnAtPos=At("=",lcMemLine)
        If lnAtPos=0
          Loop
        Endif
        lcViewAlias=Proper(Alltrim(Left(lcMemLine,lnAtPos-1)))
        If Empty(lcViewAlias)
          Loop
        Endif
        lcViewAlias="view_"+Strtran(lcViewAlias," ","_")
        If Used(lcViewAlias)
          Loop
        Endif
        lcViewAlias=toBrowser.CreateView(lcViewAlias)
      Endfor
      oRecord=.Null.
    Endif
  Endif
  Do Case
    Case lcType=="FOLDER"
      If llRefreshFolders
        If toBrowser.nFolderCount>toBrowser.nMaxFolderCount
          If Not llMaxFolderCountErrorMsg
            llMaxFolderCountErrorMsg=.T.
            toBrowser.MsgBox(M_FOLDERS_PAST_LIMIT_LOC+" "+ ;
              TRANSFORM(toBrowser.nMaxFolderCount)+"."+CR+CR+ ;
              M_FOLDERS_NOT_VISIBLE_LOC+".",16)
          Endif
          Loop
        Endif
        lnType=Iif(Empty(Parent),1,2)
      Else
        If Empty(Parent)
          Loop
        Endif
        lnType=4
      Endif
    Case lcType=="ITEM"
      If llRefreshFolders
        Loop
      Endif
      If Empty(Parent)
        Loop
      Endif
      lnType=5
    Case Not llRefreshFolders
      Exit
    Case lcType=="OBJECT"
      lnType=3
    Case lcType=="VIEW"
      If Empty(Parent)
        Replace Parent With lcCatalogID
      Endif
      lnType=6
    Otherwise
      Loop
  Endcase
  If toBrowser.lRelease
    Select 0
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  lcID=Lower(Alltrim(Id))
  lcSourceAlias=Lower(Alltrim(SrcAlias))
  If Empty(lcID)
    lcSourceAlias=Lower(Alias())
    lcDBF=Iif(Used(lcSourceAlias),Lower(Dbf(lcSourceAlias)),"")
  Else
    Do Case
      Case Empty(lcSourceAlias)
        lcSourceAlias=Lower(Alias())
      Case Not Used(lcSourceAlias)
        Loop
    Endcase
    If lnViewType=1 Or lnType=1
      lcDBF=Iif(Used(lcSourceAlias),Lower(Dbf(lcSourceAlias)),"")
    Else
      If Empty(lcViewCatalog)
        Loop
      Endif
      lcDBF=lcViewCatalog
    Endif
  Endif
  lcID2=Strtran(Juststem(lcDBF)," ","_")
  lcCatalog=Iif(Used(lcSourceAlias),Lower(Dbf(lcSourceAlias)),"")
  If lnType=1 And lnViewType=1
    If lcCatalog==lcLastCatalog
      Loop
    Endif
    lcLastCatalog=lcCatalog
  Endif
  lcCatalogPath=Iif(Empty(lcDBF),"",Justpath(lcDBF)+"\")
  toBrowser.oNodeObject.cCatalogPath=lcCatalogPath
  oParent=.Null.
  If Not Empty(lcID)
    lcID=lcID2+"!"+lcID
  Endif
  If Inlist(lnType,1,3)
    lcParent=""
  Else
    lcParent=Lower(Alltrim(Parent))
    If Not Empty(lcParent) And Not "!"$lcParent
      lcParent=lcID2+"!"+lcParent
    Endif
  Endif
  lcLink=Lower(Alltrim(Link))
  If Not Empty(lcLink) And Not "!"$lcLink
    lcLink=lcID2+"!"+lcLink
  Endif
  If llRefreshFolders
    If Not Empty(lcParent)
      For lnType2 = 1 To toBrowser.nFolderCount
        If toBrowser.aFolderList[lnType2].cID==lcParent
          oParent=toBrowser.aFolderList[lnType2]
          Exit
        Endif
      Endfor
      If Isnull(oParent)
        Loop
      Endif
    Endif
  Else
    If Not lcParent==lcFolderID
      Loop
    Endif
    oParent=oFolder
  Endif
  lcText=Alltrim(Mline(Text,1))
  If Empty(lcText)
    lcText=Alltrim(Mline(Id,1))
  Endif
  lcKey=lcID
  If lnType=1
    brwReleaseClassLibraries(toBrowser)
    If Not brwSetClassLibrary(toBrowser,toBrowser.cDefaultCatalogClassLibrary)
      toBrowser.MsgBox(M_NODE_LOC+" ("+Iif(Empty(lcText),lcID,lcText)+") "+ ;
        M_COULD_NOT_BE_CREATED_LOC+[.],16)
      toBrowser.vResult=.F.
      Return toBrowser.vResult
    Endif
  Endif
  lcClassLibrary=toBrowser.oNodeObject.Fullpath(Lower(Alltrim(Mline(Classlib,1))))
  If Not Empty(lcClassLibrary) And Not Empty(lcCatalogPath) And ;
      EMPTY(Sys(2000,lcClassLibrary))
    lcClassLibrary=Lower(Forcepath(lcClassLibrary,lcCatalogPath))
  Endif
  If Not Empty(lcID) And Not Empty(lcClassLibrary) And ;
      NOT brwSetClassLibrary(toBrowser,lcClassLibrary)
    toBrowser.MsgBox(M_NODE_LOC+" ("+Iif(Empty(lcText),lcID,lcText)+") "+ ;
      M_COULD_NOT_BE_CREATED_LOC+[.],16)
    oParent=.Null.
    oItem=.Null.
    Loop
  Endif
  lcClass=Lower(Alltrim(Mline(ClassName,1)))
  If Empty(lcID)
    lcProperties=Strtran(Alltrim(Properties),";",CR)
    lcItem=lcText+CR+ ;
      ALLTRIM(Picture)+CR+ ;
      lcClass+CR+ ;
      lcClassLibrary+CR+ ;
      ALLTRIM(FileName)+CR+ ;
      ALLTRIM(Class)+CR+ ;
      CHR(0)+lcProperties
    toBrowser.nItemCount=toBrowser.nItemCount+1
    lnIndex=toBrowser.nItemCount
    Dimension toBrowser.aItemList[lnIndex]
    oFolder.nItemCount=oFolder.nItemCount+1
    If oFolder.nItemCount=1
      oFolder.nItemIndex=lnIndex
    Endif
    Dimension oFolder.aItemIndexes[oFolder.nItemCount]
    oFolder.aItemIndexes[oFolder.nItemCount]=lnIndex
    toBrowser.aItemList[lnIndex]=lcItem
    Loop
  Endif
  If Empty(lcClass)
    Do Case
      Case lnType=1
        If lnCatalogRecNo=0
          lcViewCatalog=lcCatalog
        Endif
        lnCatalogRecNo=Recno()
        lcCatalogID=lcID
        lcClass=toBrowser.cFolderClass
      Case lnType=2
        lcClass=oParent.Class
        If Not brwSetClassLibrary(toBrowser,oParent.ClassLibrary)
          toBrowser.MsgBox(M_NODE_LOC+" ("+Iif(Empty(lcText),lcID,lcText)+") "+ ;
            M_COULD_NOT_BE_CREATED_LOC+[.],16)
          oParent=.Null.
          oItem=.Null.
          Loop
        Endif
      Case lnType=3
        If Not Isnull(oParent) And Not Empty(oParent.cItemClass)
          lcClass=oParent.cItemClass
          If Not brwSetClassLibrary(toBrowser,oParent.cItemClassLibrary)
            toBrowser.MsgBox(M_NODE_LOC+" ("+Iif(Empty(lcText),lcID,lcText)+") "+ ;
              M_COULD_NOT_BE_CREATED_LOC+[.],16)
            oParent=.Null.
            oItem=.Null.
            Loop
          Endif
        Else
          lcClass=toBrowser.cObjectClass
        Endif
      Case lnType=4
        lcClass=oParent.Class
        If Not brwSetClassLibrary(toBrowser,oParent.ClassLibrary)
          toBrowser.MsgBox(M_NODE_LOC+" ("+Iif(Empty(lcText),lcID,lcText)+") "+ ;
            M_COULD_NOT_BE_CREATED_LOC+[.],16)
          oParent=.Null.
          oItem=.Null.
          Loop
        Endif
      Case lnType=5
        If Not Isnull(oParent) And Not Empty(oParent.cItemClass)
          lcClass=oParent.cItemClass
          If Not brwSetClassLibrary(toBrowser,oParent.cItemClassLibrary)
            toBrowser.MsgBox(M_NODE_LOC+" ("+Iif(Empty(lcText),lcID,lcText)+") "+ ;
              M_COULD_NOT_BE_CREATED_LOC+[.],16)
            oParent=.Null.
            oItem=.Null.
            Loop
          Endif
        Else
          lcClass=toBrowser.cItemClass
        Endif
      Case lnType=6
        lcClass=toBrowser.cViewClass
    Endcase
  Endif
  If Empty(lcClass)
    oParent=.Null.
    oItem=.Null.
    Loop
  Endif
  oItem=Createobject(lcClass)
  Go lnRecNo
  If Vartype(oItem)#"O"
    oParent=.Null.
    oItem=.Null.
    Loop
  Endif
  If Not oItem.Visible Or oItem.lDeleted
    oParent=.Null.
    oItem.Release
    oItem=.Null.
    Loop
  Endif
  oTHIS=oItem
  oRecord=.Null.
  Scatter Memo Name oRecord
  With oItem
    .oHost=toBrowser
    .oRecord=oRecord
    If Not Isnull(oParent)
      .oParent=oParent
      If .oParent.lDynamic
        .lDynamic=.T.
      Endif
      If lnType=4
        oParent=toBrowser.GetFolder(lcID2+"!"+Alltrim(Id),.T.)
        If Isnull(oParent)
          .oFolder=oItem
        Else
          .oFolder=oParent
        Endif
      Else
        .oFolder=oParent
      Endif
    Else
      .oParent=oItem
      .oFolder=oItem
      If .oParent.lDynamic
        .lDynamic=.T.
      Endif
    Endif
    oParent=.Null.
    If lnType=2 And .oParent.nIndex=0
      oTHIS=.Null.
      oParent=.Null.
      oItem.Release
      oItem=.Null.
      Loop
    Endif
    Set DataSession To toBrowser.DataSessionId
    Select (toBrowser.cGallery)
    Do Case
      Case lnType=1
        .lCatalog=.T.
        .lFolder=.T.
      Case lnType=2
        .lFolder=.T.
      Case lnType=3
        .lObject=.T.
      Case lnType=4
        .lFolderItem=.T.
      Case lnType=6
        .lView=.T.
    Endcase
    .cType=lcType
    .cID=lcID
    .cID2=lcID2
    .cParent=lcParent
    If Not Empty(lcLink)
      .cLink=lcLink
    Endif
    .oLink=oItem
    .oAction=oItem
    .oShortCutMenu=.oHost.oShortCutMenu
    .oShortCutMenu.oHost=oItem
    .cCatalog=lcCatalog
    .cCatalogPath=lcCatalogPath
    .cAlias=lcAlias
    .cSourceAlias=lcSourceAlias
    .cSourceCatalog=lcCatalog
    .cSourceCatalogPath=lcCatalogPath
    .nSourceRecNo=SrcRecNo
    .nRecNo=Recno()
    If Empty(.cViews)
      .cViews=Alltrim(Views)
    Endif
    If lnType=3
      lcItemClass=Lower(Alltrim(Mline(ItemClass,1)))
      If Not Empty(lcItemClass)
        oObject=Createobject(lcItemClass)
        Set DataSession To toBrowser.DataSessionId
        Select (toBrowser.cGallery)
        If Type("oObject")#"O" Or Isnull(oObject)
          oObject=.Null.
          toBrowser.MsgBox(M_CLASS_LOC+" ("+lcItemClass+") "+ ;
            M_COULD_NOT_BE_CREATED_LOC+[.],16)
        Else
          oItem.oObject=oObject
          oObject=.Null.
        Endif
      Endif
    Endif
    If Not Empty(Properties)
      .cProperties=Alltrim(Properties)
    Endif
    If Not Empty(Script)
      .cScript=Alltrim(Script)
    Endif
    If Not Empty(Classlib)
      .cClassLib=Mline(Classlib,1)
    Endif
    .cClassLib=Lower(.Fullpath(.cClassLib))
    If Not Empty(ClassName)
      .cClassName=Alltrim(Mline(ClassName,1))
    Endif
    If Not Empty(ItemTpDesc)
      .cItemTpDesc=Alltrim(ItemTpDesc)
    Endif
    If Not Empty(keywords)
      .cKeywords=Alltrim(keywords)
    Endif
    .tUpdated=Updated
    If Not Empty(Comment)
      .cComment=Alltrim(Comment)
    Endif
    If Not Empty(User)
      .cUser=Alltrim(User)
    Endif
    .SetProperties(.cProperties)
    If toBrowser.lRelease
      Go lnRecNo
      oTHIS=.Null.
      oParent=.Null.
      oItem.Release
      oItem=.Null.
      Loop
    Endif
    Go .nRecNo
    Set DataSession To toBrowser.DataSessionId
    Select (toBrowser.cGallery)
    If Not .Visible Or .lDeleted
      Go lnRecNo
      oTHIS=.Null.
      oParent=.Null.
      oItem.Release
      oItem=.Null.
      Loop
    Endif
    Go .nRecNo
    Set DataSession To toBrowser.DataSessionId
    Select (toBrowser.cGallery)
    If Not .Visible Or .lDeleted
      oTHIS=.Null.
      oParent=.Null.
      oItem.Release
      oItem=.Null.
      Loop
    Endif
    If Not Empty(lcText)
      .cText=lcText
    Endif
    If Not Empty(Desc)
      .cDesc=Alltrim(Desc)
    Endif
    If Empty(.cDesc)
      .cDesc=lcText
    Endif
    If Not Empty(TypeDesc)
      .cTypeDesc=Alltrim(TypeDesc)
    Endif
    If Empty(.cTypeDesc) And lnType#5
      .cTypeDesc=.oParent.cTypeDesc
    Endif
    If Not Empty(FileName)
      .cFileName=Mline(FileName,1)
    Endif
    .cFileName=Lower(.Fullpath(.cFileName))
    If Not Empty(Class)
      .cClass=Lower(Alltrim(Mline(Class,1)))
    Endif
    If Not Empty(Picture)
      .cPicture=Mline(Picture,1)
    Endif
    If .lDynamic And "\dev\browser\"$.cPicture
      .cPicture=Lower(brwImagePictureFile(toBrowser,Justfname(.cPicture)))
    Else
      .cPicture=Lower(brwImagePictureFile(toBrowser,.Fullpath(.cPicture)))
    Endif
    If Not Empty(FolderPict)
      .cFolderPicture=Mline(FolderPict,1)
    Endif
    If .lDynamic And "\dev\browser\"$.cFolderPicture
      .cFolderPicture=Lower(brwImagePictureFile(toBrowser,Justfname(.cFolderPicture)))
    Else
      .cFolderPicture=Lower(brwImagePictureFile(toBrowser,.Fullpath(.cFolderPicture)))
    Endif
    If Not Inlist(lnType,3,5,6)
      If Not Empty(ItemClass)
        .cItemClass=Lower(Alltrim(Mline(ItemClass,1)))
      Endif
      If Not Empty(.cItemClass)
        .cItemClass=.cItemClass
        If Empty(.cItemClassLibrary)
          .cItemClassLibrary=lcClassLibrary
        Endif
      Else
        If Not Isnull(.oParent) And Not Empty(.oParent.cItemClass)
          .cItemClass=.oParent.cItemClass
          If Empty(.cItemClassLibrary)
            .cItemClassLibrary=.oParent.cItemClassLibrary
          Endif
        Endif
      Endif
      If Not Empty(ItemTpDesc)
        .cItemTypeDesc=Lower(Alltrim(ItemTpDesc))
      Endif
    Endif
    .cItemType=Alltrim(.cItemType)
    If Not .InitProperties()
      oTHIS=.Null.
      oParent=.Null.
      oItem.Release
      oItem=.Null.
      Loop
    Endif
    oNode=.Null.
    Do Case
      Case lnType=1
        lcPicture="catalog.ico"
        oNode=toBrowser.oleFolderList.Object.Nodes.Add(,4,lcKey,lcText)
        If Isnull(oNode)
          toBrowser.MsgBox(M_CATALOG_LOC+" ("+.cID+") "+ ;
            M_COULD_NOT_BE_CREATED_LOC+".",16)
          oTHIS=.Null.
          oParent=.Null.
          oItem.Release
          oItem=.Null.
          Loop
        Endif
        .nNodeIndex=oNode.Index
        If toBrowser.lAutoExpand
          oNode.Expanded=.T.
        Endif
      Case lnType=2
        If .lWebView
          lcPicture=toBrowser.GetWebIcon(.cFileName)
        Else
          lcPicture="folder.ico"
        Endif
        oNode=toBrowser.oleFolderList.Object.Nodes.Add(lcParent, ;
          4,lcKey,lcText,,)
        If Isnull(oNode)
          toBrowser.MsgBox(M_FOLDER_LOC+" ("+.cID+") "+ ;
            M_COULD_NOT_BE_CREATED_LOC+".",16)
          oTHIS=.Null.
          oParent=.Null.
          oItem.Release
          oItem=.Null.
          Loop
        Endif
        .nNodeIndex=oNode.Index
      Case lnType=4
        Do Case
          Case .lFolderItem
            lcPicture=.oFolder.cFolderPicture
            .cPicture=lcPicture
            .cFolderPicture=lcPicture
          Case Not Empty(.cPicture)
            lcPicture=.cPicture
            .cPicture=lcPicture
          Case .lWebView
            lcPicture=toBrowser.GetWebIcon(.cFileName)
            lcPicture="folder.ico"
            .cPicture=lcPicture
        Endcase
      Case lnType=6
        If Empty(.cText)
          Loop
        Endif
        .cViewAlias=toBrowser.CreateView("view_"+Lower(.cText))
    Endcase
    If Not Isnull(oNode)
      llIgnoreErrors=toBrowser.lIgnoreErrors
      toBrowser.lIgnoreErrors=.T.
      If .lFolderItem And Not Empty(.cPicture)
        oNode.Image=lcPicture
      Else
        If Not Empty(.cFolderPicture)
          lnImageIndex=toBrowser.GetImageIndex(.T.,.cFolderPicture)
          If lnImageIndex=0
            .cFolderPicture=lcPicture
          Endif
        Else
          If Not .oFolder.lFolder And Not Empty(.oFolder.cFolderPicture)
            .cFolderPicture=.oFolder.cFolderPicture
          Else
            .cFolderPicture=lcPicture
          Endif
        Endif
        oNode.Image=.cFolderPicture
      Endif
      toBrowser.lIgnoreErrors=llIgnoreErrors
    Endif
    If Empty(.cToolTipText)
      lcItemType=Proper(Iif(Empty(.cItemType),.cType,.cItemType))
      If lnType=1
        .cToolTipText=.cText+" ("+lcItemType+"):"+"  "+lcCatalog
      Else
        .cToolTipText=.cText+" ("+lcItemType+")"
      Endif
    Endif
    If Empty(.cStatusBarText)
      .cStatusBarText=.cToolTipText
    Endif
  Endwith
  oNode=.Null.
  If lnType=4 Or lnType=5
    If oItem.oParent.nIndex<1
      oTHIS=.Null.
      oParent=.Null.
      oItem.Release
      oItem=.Null.
      Loop
    Endif
    llMatch=.F.
    For lnCount = 1 To toBrowser.nItemCount
      If Vartype(toBrowser.aItemList[lnCount])#"O"
        Loop
      Endif
      With toBrowser.aItemList[lnCount]
        If Not .cID==oItem.cID
          Loop
        Endif
        llMatch=.T.
        lnIndex=lnCount
        .oObject=.Null.
        .oSource=.Null.
        .oTarget=.Null.
        .oControl=.Null.
        .oHost=.Null.
        .oAction=.Null.
        .oShortCutMenu=.Null.
        .oLink=.Null.
        .oFolder=.Null.
        .oParent=.Null.
        toBrowser.aItemList[lnCount]=.Null.
        Exit
      Endwith
    Endfor
    If Not llMatch
      toBrowser.nItemCount=toBrowser.nItemCount+1
      lnIndex=toBrowser.nItemCount
      Dimension toBrowser.aItemList[lnIndex]
    Endif
    oFolder.nItemCount=oFolder.nItemCount+1
    If oFolder.nItemCount=1
      oFolder.nItemIndex=lnIndex
    Endif
    Dimension oFolder.aItemIndexes[oFolder.nItemCount]
    oFolder.aItemIndexes[oFolder.nItemCount]=lnIndex
    oItem.nIndex=lnIndex
    oItem.nItemIndex=oFolder.nItemCount
    oItem.oControl=toBrowser.oleItems
    toBrowser.aItemList[lnIndex]=oItem
  Else
    toBrowser.nFolderCount=toBrowser.nFolderCount+1
    Dimension toBrowser.aFolderList[toBrowser.nFolderCount]
    oItem.nIndex=toBrowser.nFolderCount
    oItem.oControl=toBrowser.oleFolderList
    toBrowser.aFolderList[toBrowser.nFolderCount]=oItem
  Endif
  If Type("oItem.oAction")=="O" And Not Isnull(oItem.oAction) And Not oItem.lRefreshed
    oItem.lRefreshed=.T.
    oItem.oAction.Refreshed
  Endif
  oTHIS=.Null.
  oParent=.Null.
  oItem=.Null.
Endscan
oNode=.Null.
oTHIS=.Null.
oParent=.Null.
oItem=.Null.
oFolder=.Null.
toBrowser.RefreshLinks(llRefreshFolders)
brwReleaseClassLibraries(toBrowser)
Select 0
Endfunc



Function brwRefreshItemList(toBrowser)
Local oNode,oParent,oFolder,oItem,lcItem,lnItemCount
Local lcPicture,lcCatalog,lcID,lcText,lcClassName,lcClassLibrary
Local lcObjName,llLockScreen,lcItemType,lcURL,lcFileName,lcFileExt
Local lnImageIndex,lnIndex,lnLastIndex,lnCount,lnFileItemCount
Local lcItemTypes,lcProperties,lnAtPos,lnLastSelect,llIgnoreErrors
Local laFileItems[1,2]

If toBrowser.lRelease Or toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To toBrowser.DataSessionId
If Not Used(toBrowser.cGallery)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lnFileItemCount=0
With toBrowser
  .oItem=.Null.
  .oItemSource=.Null.
  .nItemListIndex=-1
  .imgClassIcon.Visible=.F.
  .cmdClassIcon.Visible=.F.
  .edtItemDesc.Value=""
  If .nFolderCount<=0
    .oFolder=.Null.
    .oFolderSource=.Null.
    .oCatalog=.Null.
    .oCatalogSource=.Null.
    .nFolderListIndex=-1
    .nLastFolderListIndex=-1
    Return
  Endif
  lnLastIndex=.nLastFolderListIndex
  If lnLastIndex>0
    lcPicture=.oleFolderList.Object.Nodes[lnLastIndex].Image
    Do Case
      Case lcPicture=="openctlg.ico"
        lcPicture="catalog.ico"
      Case lcPicture=="openfldr.ico"
        lcPicture="folder.ico"
      Case lcPicture=="cofldr.ico"
        lcPicture="cfldr.ico"
      Case lcPicture=="dofldr.ico"
        lcPicture="dfldr.ico"
      Case lcPicture=="fofldr.ico"
        lcPicture="ffldr.ico"
      Case lcPicture=="pofldr.ico"
        lcPicture="pfldr.ico"
      Otherwise
        lcPicture=""
    Endcase
    If Not Empty(lcPicture)
      .oleFolderList.Object.Nodes[lnLastIndex].Image=lcPicture
    Endif
  Endif
Endwith
If toBrowser.nFolderListIndex<1
  With toBrowser
    .nFolderListIndex=1
    .nLastFolderListIndex=-1
    .oleFolderList.Object.Nodes[1].Selected=.T.
    .oCatalogSource=.aFolderList[1]
    .oCatalog=.oCatalogSource.oLink
    .oFolderSource=oCatalogSource
    .oFolder=.oCatalog
    .oItemSource=.oFolderSource
    .oItem=.oFolder
    .cCatalog=.oItem.cSourceCatalog
  Endwith
Endif
With toBrowser
  .nFolderListIndex=.oleFolderList.Object.SelectedItem.Index
  oFolder=.aFolderList[.nFolderListIndex]
  .oFolderSource=oFolder
  oFolder=oFolder.oLink
  .oFolder=oFolder
  If oFolder.lWebView
    Set Message To M_REFRESH_WEB_VIEW_LOC+" ..."
  Else
    Set Message To M_REFRESH_ITEM_LIST_LOC+" ..."
  Endif
  lnItemCount=oFolder.nItemCount
  If lnItemCount<=0 Or .nItemListIndex<1
    .oItemSource=.oFolderSource
    .oItem=.oFolder
    .cCatalog=.oItem.cSourceCatalog
  Endif
  oParent=.oFolderSource
  Do While Not oParent.cID==oParent.oFolder.cID
    oParent=oParent.oFolder
  Enddo
  .oCatalogSource=oParent
  .oCatalog=oParent.oLink
  lnIndex=oFolder.nIndex
  If lnIndex>0
    lcPicture=.oleFolderList.Object.Nodes[lnIndex].Image
    Do Case
      Case lcPicture=="catalog.ico"
        lcPicture="openctlg.ico"
      Case lcPicture=="folder.ico"
        lcPicture="openfldr.ico"
      Case lcPicture=="cfldr.ico"
        lcPicture="cofldr.ico"
      Case lcPicture=="dfldr.ico"
        lcPicture="dofldr.ico"
      Case lcPicture=="ffldr.ico"
        lcPicture="fofldr.ico"
      Case lcPicture=="pfldr.ico"
        lcPicture="pofldr.ico"
      Otherwise
        lcPicture=""
    Endcase
    If Not Empty(lcPicture)
      .oleFolderList.Object.Nodes[lnIndex].Image=lcPicture
    Endif
  Endif
  .oleItems.Object.ListItems.Clear
  If oFolder.lWebView And Not .lWebBrowser
    .SetWebBrowser
  Endif
  If .lWebBrowser
    .lWebView=oFolder.lWebView
    If .lWebView
      .oleItems.Visible=.F.
      .oleWebBrowser.Visible=.T.
    Else
      If Not Lower(Alltrim(.oleWebBrowser.LocationURL))==Lower(Alltrim(.cBlankHTMLFile))
        .oleWebBrowser.Navigate(.cBlankHTMLFile)
      Endif
      If Not .lRefreshBrowserMode
        .oleWebBrowser.Visible=.F.
        .oleItems.Visible=.T.
      Endif
    Endif
  Else
    .lWebView=.F.
    If Not .lRefreshBrowserMode
      .oleItems.Visible=.T.
    Endif
  Endif
  llLockScreen=.LockScreen
  .Draw
  .LockScreen=.T.
Endwith
If oFolder.nItemCount=-1
  toBrowser.RefreshObjects(oFolder)
Endif
For lnCount = 1 To Iif(toBrowser.lWebView,0,oFolder.nItemCount)
  If toBrowser.lRelease
    toBrowser.LockScreen=llLockScreen
    Select 0
    Set Message To
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  lnIndex=oFolder.aItemIndexes[lnCount]
  oItem=toBrowser.aItemList[lnIndex]
  lcPicture=""
  Do Case
    Case Vartype(oItem)=="O"
      If Not oItem.Visible Or oItem.lDeleted
        oItem=.Null.
        Loop
      Endif
      lcPicture=oItem.cPicture
      If oItem.lFolderItem
        lcPicture=oItem.cFolderPicture
        lcItemType="Folder"
      Else
        lcItemType=oItem.cItemType
        If Empty(lcItemType)
          oParent=oItem
          Do While Not oParent.cID==oParent.oFolder.oLink.cID
            oParent=oParent.oFolder.oLink
            If Not Empty(oParent.cItemType)
              lcItemType=oParent.cItemType
              Exit
            Endif
          Enddo
          oParent=.Null.
          If Empty(lcItemType)
            lcItemType="Item"
          Endif
        Endif
      Endif
      If oItem.cType=="ITEM"
        lcPicture=oItem.cPicture
        If Empty(lcPicture) And Not oItem.lFolderItem
          oParent=oItem
          Do While Not oParent.cID==oParent.oFolder.oLink.cID
            oParent=oParent.oFolder.oLink
            If oParent.lCatalog
              Exit
            Endif
            If Not Empty(oParent.cPicture)
              lcPicture=oParent.cPicture
              Exit
            Endif
          Enddo
          oParent=.Null.
        Endif
      Endif
      lcCatalog=oItem.cCatalog
      lcID=oItem.cID
      lcText=oItem.cText
    Case Vartype(oItem)=="C"
      lcItem=oItem
      lcClassName=Lower(Mline(lcItem,3))
      If Empty(lcClassName)
        lcClassName=Lower(oFolder.cItemClass)
        If Empty(lcClassName)
          Loop
        Endif
      Endif
      lcClassLibrary=Lower(Mline(lcItem,4))
      lcFileName=Lower(Mline(lcItem,5))
      lcFileExt=Justext(lcFileName)
      If Not Empty(lcFileExt)
        lnAtPos=Ascan(laFileItems,lcFileExt)
        If lnAtPos>0
          lcClassName=laFileItems[lnAtPos+1]
        Else
          lnLastSelect=Select()
          Select itemtypes
          Set Order To Class
          Seek lcClassName
          If Not Eof()
            lcItemTypes=Alltrim(itemtypes)
            lnAtPos=Atc(CR+lcFileExt+"=",lcItemTypes)
            If lnAtPos>0
              lcClassName=Lower(Mline(Substr(lcItemTypes,lnAtPos+Len(lcFileExt)+2),1))
              lnFileItemCount=lnFileItemCount+1
              Dimension laFileItems[lnFileItemCount,2]
              laFileItems[lnFileItemCount,1]=lcFileExt
              laFileItems[lnFileItemCount,2]=lcClassName
            Endif
          Endif
        Endif
        Select (lnLastSelect)
      Endif
      lcObjName="o"+lcClassName
      With toBrowser.oNodes
        If Type("toBrowser.oNodes."+lcObjName)#"O"
          .Newobject(lcObjName,lcClassName,lcClassLibrary)
          If Type("toBrowser.oNodes."+lcObjName)#"O"
            Loop
          Endif
        Endif
        oItem=.&lcObjName
      Endwith
      If Vartype(oItem)#"O"
        Loop
      Endif
      oItem.oParent=oParent
      oItem.oFolder=oFolder
      lnAtPos=At(Chr(0),lcItem)
      lcProperties=Iif(lnAtPos>0,Substr(lcItem,lnAtPos+1),"")
      oItem.SetProperties(lcProperties)
      lcItemType=oItem.cItemType
      lcID=Lower(Sys(2015))
      lcText=Mline(lcItem,1)
      lcPicture=Lower(Mline(lcItem,2))
      If Empty(lcPicture)
        lcPicture=oItem.cPicture
      Endif
      If Not Empty(lcPicture) And Empty(Justfname(lcPicture))
        lcPicture=oItem.cPicture
      Endif
      If Empty(lcPicture)
        If Not Empty(oItem.cPicture)
          lcPicture=Lower(Fullpath(oItem.cPicture,lcClassLibrary))
        Endif
        If Empty(lcPicture)
          oParent=oFolder
          Do While Not oParent.cID==oParent.oFolder.oLink.cID
            If Not Empty(oParent.cPicture)
              lcPicture=oParent.cPicture
              Exit
            Endif
            oParent=oParent.oFolder.oLink
            If oParent.lCatalog
              Exit
            Endif
          Enddo
        Endif
        If Not Empty(lcPicture)
          lcItem=Strtran(lcItem,CR+CR,CR+lcPicture+CR,1,1)
          toBrowser.aItemList[lnIndex]=lcItem
        Endif
      Endif
      If Empty(lcPicture)
        If Type([GETPEM(lcClassName,"cPicture")])=="U"
          Newobject(lcClassName,lcClassLibrary)
        Endif
        If Type([GETPEM(lcClassName,"cPicture")])=="C"
          lcPicture=GETPEM(lcClassName,"cPicture")
        Endif
      Endif
      If Not Empty(lcPicture) And Not ":"$lcPicture And Not "\\"$lcPicture
        lcPicture=toBrowser.cDefaultCatalogPath+lcPicture
      Endif
      oItem.cPicture=lcPicture
      lcCatalog=oFolder.cCatalog
    Otherwise
      Loop
  Endcase
  oNode=toBrowser.oleItems.Object.ListItems.Add(,lcCatalog+"_"+lcID,lcText)
  If Isnull(oNode)
    toBrowser.MsgBox(M_ITEM_LOC+" ("+lcID+") "+M_COULD_NOT_BE_CREATED_LOC+".",16)
    oItem=.Null.
    Loop
  Endif
  llIgnoreErrors=toBrowser.lIgnoreErrors
  toBrowser.lIgnoreErrors=.T.
  lnImageIndex=Iif(Empty(lcPicture),0,toBrowser.GetImageIndex(,lcPicture))
  If lnImageIndex=0
    lcPicture="item.ico"
    If Vartype(oItem)=="O"
      oItem.nNodeIndex=oNode.Index
      If oItem.cType=="FOLDER" Or oItem.lFolderItem
        Do Case
          Case oItem.lCatalog
            lcPicture="catalog.ico"
          Case oItem.lWebView
            lcPicture=toBrowser.GetWebIcon(oItem.cFileName)
          Otherwise
            lcPicture="folder.ico"
        Endcase
      Endif
      If Not oItem.Enabled
        oNode.Ghosted=.T.
      Endif
    Endif
    lnImageIndex=toBrowser.GetImageIndex(,lcPicture)
  Endif
  oNode.Icon=lnImageIndex
  oNode.SmallIcon=lnImageIndex
  oNode.SubItems[1]=lcItemType
  oItem.nNodeIndex=oNode.Index
  toBrowser.lIgnoreErrors=llIgnoreErrors
  oItem=.Null.
Endfor
With toBrowser
  .RefreshItem
  If .oleItems.Object.View#.nImageView
    .oleItems.Object.View=.nImageView
  Endif
  If .lWebView
    If Empty(oFolder.cFileName)
      .oleWebBrowser.Navigate(.cBlankHTMLFile)
    Else
      .oleWebBrowser.Navigate(Alltrim(oFolder.cFileName))
    Endif
  Endif
  .RefreshButtons
  .LockScreen=.F.
  .Draw
  Select 0
  Set Message To
  If Type("oFolder.oAction")=="O" And Not Isnull(oFolder.oAction)
    oFolder.oAction.Selected
  Endif
  oFolder=.Null.
  .LockScreen=llLockScreen
Endwith
Endfunc



Function brwRefreshItem(toBrowser)
Local oFolder,oItem,lcItem,lcID,lcText,lcPicture,lcFileName,lcClass
Local lnItemIndex,lcVarType,lnIndex,lnCount,lcClassName,lcClassLibrary
Local lcItemTypes,lcFileExt,lcProperties,lnAtPos,lnLastSelect

If toBrowser.lRelease Or toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
With toBrowser
  .oItem=.Null.
  .oItemSource=.Null.
  oItem=.Null.
  oFolder=.oFolder
Endwith
Set DataSession To toBrowser.DataSessionId
If Not Used(toBrowser.cGallery)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Not Isnull(oFolder)
  lnIndex=toBrowser.nItemListIndex
  If lnIndex>0
    For lnCount = 1 To oFolder.nItemCount
      lnItemIndex=oFolder.aItemIndexes[lnCount]
      oItem=toBrowser.aItemList[lnItemIndex]
      If lnItemIndex>oFolder.aItemIndexes[lnIndex]
        Exit
      Endif
      If Vartype(oItem)=="O" And (Not oItem.Visible Or oItem.lDeleted)
        lnIndex=lnIndex+1
      Endif
    Endfor
  Else
    If Type("toBrowser.oleItems.SelectedItem.Selected")=="L" And ;
        toBrowser.oleItems.SelectedItem.Selected
      toBrowser.oleItems.SelectedItem.Selected=.F.
    Endif
  Endif
  With toBrowser
    If Isnull(oItem)
      oItem=toBrowser.oFolderSource
    Else
      oItem=.aItemList[oFolder.aItemIndexes[lnIndex]]
    Endif
    lcVarType=Vartype(oItem)
    If lcVarType=="C"
      lcItem=oItem
      oItem=.Null.
      lcClassName=Lower(Mline(lcItem,3))
      If Empty(lcClassName)
        lcClassName=.cItemClass
      Endif
      lcClassLibrary=Lower(Mline(lcItem,4))
      If Empty(lcClassLibrary)
        lcClassLibrary=.cDefaultCatalogClassLibrary
      Endif
      lcText=Mline(lcItem,1)
      lcPicture=Mline(lcItem,2)
      If Not Empty(lcPicture) And Not ":"$lcPicture And Not "\\"$lcPicture
        lcPicture=toBrowser.cDefaultCatalogPath+lcPicture
      Endif
      lcFileName=Mline(lcItem,5)
      lcClass=Mline(lcItem,6)
      lnAtPos=At(Chr(0),lcItem)
      lcProperties=Iif(lnAtPos>0,Substr(lcItem,lnAtPos+1),"")
      lcFileExt=Justext(lcFileName)
      If Not Empty(lcFileExt)
        lnLastSelect=Select()
        Select itemtypes
        Set Order To Class
        Seek lcClassName
        If Not Eof()
          lcItemTypes=Alltrim(itemtypes)
          lnAtPos=Atc(CR+lcFileExt+"=",lcItemTypes)
          If lnAtPos>0
            lcClassName=Lower(Mline(Substr(lcItemTypes,lnAtPos+Len(lcFileExt)+2),1))
          Endif
        Endif
        Select (lnLastSelect)
      Endif
      oItem=Newobject(lcClassName,lcClassLibrary)
      If Vartype(oItem)=="O"
        With oItem
          .oHost=toBrowser
          .cID2=Strtran(Juststem(oFolder.cCatalog)," ","_")
          .cID=.cID2+"!"+Lower(Sys(2015))
          .oParent=oFolder
          .oFolder=oFolder
          .cParent=oFolder.cID
          If .oParent.lDynamic
            .lDynamic=.T.
          Endif
          .cProperties=lcProperties
          If Not Empty(lcText)
            .cText=lcText
          Endif
          If Empty(lcPicture)
            lcPicture=.cPicture
          Endif
          If Not Empty(lcPicture) And Not ":"$lcPicture And Not "\\"$lcPicture
            lcPicture=toBrowser.cDefaultCatalogPath+lcPicture
          Endif
          .cPicture=lcPicture
          .RefreshPicture
          If Not Empty(lcFileName)
            .cFileName=lcFileName
          Endif
          If Not Empty(lcClass)
            .cClass=lcClass
          Endif
          If Not Empty(lcClassName)
            .cClassName=lcClassName
          Endif
          If Not Empty(lcClassLibrary)
            .cClassLib=lcClassLibrary
          Endif
          .oParent=oFolder
          .cParent=.oParent.cID
          If .oParent.lDynamic
            .lDynamic=.T.
          Endif
          .oLink=oItem
          .oAction=oItem
          .oShortCutMenu=.oHost.oShortCutMenu
          .oShortCutMenu.oHost=oItem
          .cCatalog=oFolder.cCatalog
          .cCatalogPath=oFolder.cCatalogPath
          .cAlias=oFolder.cAlias
          .cSourceAlias=oFolder.cSourceAlias
          .cSourceCatalog=oFolder.cSourceCatalog
          .cSourceCatalogPath=oFolder.cSourceCatalogPath
          .nSourceRecNo=-1
          .nRecNo=-1
          .SetProperties(.cProperties)
          .cItemType=Alltrim(.cItemType)
          .InitProperties
          If Empty(.cDesc)
            .cDesc=.cText
          Endif
        Endwith
      Endif
    Endif
    .oItemSource=oItem
    .oItem=.oItemSource.oLink
    .cCatalog=.oItem.cSourceCatalog
  Endwith
Endif
If Used(oItem.cAlias) And Between(oItem.nRecNo,1,Reccount(oItem.cAlias))
  Go oItem.nRecNo In (oItem.cAlias)
Endif
With toBrowser
  If Not .lRefreshBrowserMode
    .RefreshCaption
  Endif
  .cmdClassIcon.Refresh
  .edtItemDesc.Refresh
Endwith
Wait Clear
If Type("oItem.oAction")=="O" And Not Isnull(oItem.oAction) And Not oItem.lFolder
  oItem.oAction.Selected
Endif
oItem=.Null.
oFolder=.Null.
Endfunc



Function brwRefreshLinks(toBrowser,tlRefreshFolders)
Local oFolder,oItem,oItem2,oLink,lcLink,lcType,lcID,lnCount,lnCount2

If toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If tlRefreshFolders
  For lnCount = 1 To toBrowser.nFolderCount
    oFolder=toBrowser.aFolderList[lnCount]
    If Isnull(oFolder)
      Loop
    Endif
    lcLink=oFolder.cLink
    oFolder.oLink=oFolder
    If Empty(lcLink)
      Loop
    Endif
    lcType=oFolder.cType
    oLink=.Null.
    For lnCount2 = 1 To toBrowser.nFolderCount
      If toBrowser.aFolderList[lnCount2].cID==lcLink
        oLink=toBrowser.aFolderList[lnCount2].oLink
        Exit
      Endif
    Endfor
    If Not Isnull(oLink)
      oFolder.oLink=oLink
      oLink=.Null.
    Endif
  Endfor
Else
  For lnCount = 1 To toBrowser.nItemCount
    oItem=toBrowser.aItemList[lnCount]
    If Vartype(oItem)#"O" Or Not oItem.Visible Or oItem.lDeleted
      Loop
    Endif
    oItem.oLink=oItem
    lcLink=oItem.cLink
    If Empty(lcLink)
      Loop
    Endif
    lcType=oItem.cType
    lcID=oItem.cID
    oLink=.Null.
    For lnCount2 = 1 To toBrowser.nItemCount
      oItem2=toBrowser.aItemList[lnCount2]
      If Vartype(oItem2)#"O"
        Loop
      Endif
      If oItem2.cID==lcLink
        oLink=oItem2.oLink
        Exit
      Endif
    Endfor
    If Isnull(oLink)
      oLink=toBrowser.GetItem(lcLink)
    Endif
    If Not Isnull(oLink)
      oItem.oLink=oLink.oLink
      oLink=.Null.
    Endif
  Endfor
Endif
oItem=.Null.
oFolder=.Null.
Endfunc



Function brwClearProperties(toBrowser,tlItemsOnly)
Local lcAlias,lcDBF,lcClass,lnClassCount,llRefreshBrowserMode
Local lnCount,lcFileName,lnFileNo,oItem,llBrowser,llBrowserUsed
Local laClasses[1]

If Type("_screen._oCGClipBoard")=="O"
  _Screen._oCGClipBoard.ReleaseObjects
Endif
With toBrowser
  llRefreshBrowserMode=.lRefreshBrowserMode
  .lRefreshBrowserMode=.T.
  llBrowser=.lBrowser
  llBrowserUsed=Used("browser")
  If .lRelease
    If Vartype(.oView)=="O"
      .oView.Release
    Endif
    .oView=.Null.
  Endif
Endwith
If toBrowser.lBrowser Or toBrowser.lRelease
  toBrowser.lBrowser=.T.
  With toBrowser
    For lnFileNo = 1 To .nFileCount
      lcFileName=.aFiles[lnFileNo]
      If Empty(lcFileName)
        Loop
      Endif
      lcAlias="metadata"+Alltrim(Str(Ascan(.aFiles,lcFileName)))
      If Used(lcAlias)
        toBrowser.UpdateFormCount(-1,lcFileName)
        Use In (lcAlias)
      Endif
    Endfor
    If Not Empty(.cAlias) And Used(.cAlias)
      Use In (.cAlias)
    Endif
    Dimension .aFiles[1]
    .aFiles=.F.
    .nFileCount=1
    .cFileName=""
    .cFileNamePath=""
    .lFileMode=.T.
    .lVCXSCXMode=.F.
    .lSCXMode=.F.
    .cAlias=""
    .nClassCount=0
    .nClassListIndex=-1
    .nMemberListIndex=-1
    .nClassTimeStamp=0
    .cClass=""
    .cParentClass=""
    .cClassLibrary=""
    .cBaseClass=""
    .lBrowser=llBrowser
  Endwith
  If toBrowser.lRelease
    If toBrowser.nFolderCount>0
      oItem=toBrowser.GetFolder("VFPGlry!VFPCats")
      If Vartype(oItem)=="O" And oItem.lCatalog
        oItem.oHost=toBrowser
        oItem.cleanup(.T.)
        oItem.Release
        oItem=.Null.
      Endif
    Endif
  Else
    If toBrowser.lInitialized
      toBrowser.SavePreferences
    Endif
    toBrowser.lRefreshBrowserMode=llRefreshBrowserMode
    Return
  Endif
Endif
If Not tlItemsOnly
  With toBrowser
    If Not .lSwitchViewMode
      If Vartype(.oView)=="O"
        .oView.Release
      Endif
      .oView=.Null.
      .CloseViews(.T.)
      .cboViewType.ListIndex=1
      Do While .cboViewType.ListCount>1
        .cboViewType.RemoveItem(2)
      Enddo
      .cGallery="view_default"
      .CreateCatalog(.cGallery)
      .cCatalog=Iif(Used("catalog1"),Lower(Dbf("catalog1")),"")
    Endif
    .lBrowser=.F.
    .oItem=.Null.
    .oItemSource=.Null.
    .oFolder=.Null.
    .oFolderSource=.Null.
    .oCatalog=.Null.
    .oCatalogSource=.Null.
  Endwith
Endif
brwReleaseClassLibraries(toBrowser)
lnClassCount=0
For lnCount = toBrowser.nItemCount To 1 Step -1
  oItem=toBrowser.aItemList[lnCount]
  If Vartype(oItem)#"O"
    Loop
  Endif
  lcClass=Lower(oItem.Class)+" "
  If Ascan(laClasses,lcClass)=0
    lnClassCount=lnClassCount+1
    Dimension laClasses[lnClassCount]
    laClasses[lnClassCount]=lcClass
  Endif
  oItem.Release
  oItem=.Null.
Endfor
If Not tlItemsOnly
  For lnCount = toBrowser.nFolderCount To 1 Step -1
    oItem=toBrowser.aFolderList[lnCount]
    If Vartype(oItem)#"O"
      Loop
    Endif
    lcClass=Lower(oItem.Class)+" "
    If Ascan(laClasses,lcClass)=0
      lnClassCount=lnClassCount+1
      Dimension laClasses[lnClassCount]
      laClasses[lnClassCount]=lcClass
    Endif
    oItem.Release
    oItem=.Null.
  Endfor
  With toBrowser
    If .lWebView
      .SetWebBrowser
    Endif
    .lWebView=.F.
    Dimension .aFolderList[1]
    .aFolderList=.Null.
    .nFolderCount=0
    .nFolderListIndex=-1
    .nLastFolderListIndex=-1
  Endwith
Endif
With toBrowser
  Dimension .aItemList[1]
  .aItemList=.Null.
  .nItemCount=0
Endwith
For lnCount = 1 To lnClassCount
  lcClass=Alltrim(laClasses[lnCount])
  Clear Class (lcClass)
Endfor
If Not tlItemsOnly
  Clear Class (toBrowser.cFolderClass)
  Clear Class (toBrowser.cItemClass)
  Clear Class (toBrowser.cObjectClass)
  Clear Class (toBrowser.cViewClass)
  Clear Class (toBrowser.cNodeClass)
Endif
toBrowser.lBrowser=llBrowser
toBrowser.lRefreshBrowserMode=llRefreshBrowserMode
Endfunc



Function brwClearBrowser(toBrowser,tlSaveProperties)
Local llLockScreen

llLockScreen=toBrowser.LockScreen
toBrowser.LockScreen=.T.
If Not tlSaveProperties
  toBrowser.ClearProperties
Endif
Wait Clear
With toBrowser
  .RefreshButtons
  .imgClassIcon.Visible=.F.
  .cmdClassIcon.Visible=.F.
Endwith
If toBrowser.lBrowser
  With toBrowser
    .edtClassDesc.Value=""
    .edtClassDesc.ReadOnly=.T.
    .edtClassDesc.ScrollBars=0
    .edtMemberDesc.Value=""
    .edtMemberDesc.ReadOnly=.T.
    .edtMemberDesc.ScrollBars=0
    If .lOutlineOCX
      .ClearNodes(.oleClassList)
      .ClearNodes(.oleMembers)
    Else
      .lstClassList.Clear
      .lstMembers.Clear
    Endif
  Endwith
Else
  With toBrowser
    .edtItemDesc.Value=""
    .edtItemDesc.ReadOnly=.T.
    .edtItemDesc.ScrollBars=0
    .ClearNodes(.oleFolderList)
    .oleItems.Object.ListItems.Clear
  Endwith
Endif
With toBrowser
  .RefreshCaption
  .LockScreen=.F.
  .Draw
  .LockScreen=llLockScreen
Endwith
Endfunc



Function brwRefreshBrowser(toBrowser)
Local lcMember,llLockScreen,lcFolderID,lcItemID,llRefreshItemList

If toBrowser.lRelease Or toBrowser.lRefreshBrowserMode
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
With toBrowser
  If Not .lOutlineOCX
    .lBrowser=.T.
    .lLastBrowser=.T.
  Endif
  If .lBrowser#.lLastBrowser
    .lRefreshBrowserMode=.F.
    .SwitchBrowser
  Endif
  .lRefreshBrowserMode=.T.
  If .lOutlineOCX
    If .lBrowser
      .oleClassList.Enabled=.F.
      .oleClassList.Visible=.F.
      .oleMembers.Enabled=.F.
      .oleMembers.Visible=.F.
    Else
      .oleFolderList.Enabled=.F.
      .oleFolderList.Visible=.F.
      .oleItems.Visible=.F.
      If .lWebBrowser
        .oleWebBrowser.Visible=.F.
      Endif
    Endif
  Else
  Endif
  llLockScreen=.LockScreen
  .LockScreen=.T.
Endwith
If toBrowser.lInitialized
  Set Message To M_REFRESHING_LOC+[ ]+ ;
    IIF(toBrowser.lBrowser,M_CLASS_BROWSER_LOC,M_COMPONENT_GALLERY_LOC)+" ..."
  toBrowser.SetBusyState(.T.)
Endif
If toBrowser.lBrowser
  With toBrowser
    lcMember=Iif(.nMemberListIndex>0,.aMemberList[.nMemberListIndex,1],"")
    .ClearBrowser(.T.)
    .RefreshClassList(.cClass)
    .RefreshMembers(lcMember)
  Endwith
Else
  With toBrowser
    If Isnull(.oItemSource)
      lcFolderID=""
      lcItemID=""
    Else
      lcFolderID=.oFolderSource.cID
      lcItemID=.oItemSource.cID
    Endif
    .ClearBrowser
    .RefreshFolderList
    llRefreshItemList=.lWebView
    If Not llRefreshItemList
      If Empty(lcFolderID)
        llRefreshItemList=.T.
        .RefreshItemList
      Else
        llRefreshItemList=.SelectFolder(lcFolderID)
        If Not llRefreshItemList
          llRefreshItemList=.T.
          .RefreshItemList
        Endif
      Endif
      If Not Empty(lcItemID)
        .SelectItem(lcItemID)
      Endif
    Endif
  Endwith
Endif
With toBrowser
  If .lInitialized
    .SavePreferences
  Endif
  If .lOutlineOCX
    If .lBrowser
      .oleClassList.Enabled=.T.
      .oleClassList.Visible=.T.
      .oleMembers.Enabled=.T.
      .oleMembers.Visible=.T.
    Else
      .oleFolderList.Enabled=.T.
      .oleFolderList.Visible=.T.
      .oleItems.Visible=(Not .lWebView)
      If .lWebBrowser
        .oleWebBrowser.Visible=.lWebView
      Endif
    Endif
  Else
  Endif
  .SetBusyState(.F.)
  .LockScreen=llLockScreen
  .lRefreshBrowserMode=.F.
  .RefreshCaption
Endwith
Select 0
If Not toBrowser.lBrowser And Not toBrowser.lWebView
  Set Message To
Endif
Endfunc



Function brwSwitchBrowser(toBrowser)
Local llBrowser,llGallery,llLockScreen,oColumnHeader

If toBrowser.lRelease Or Not toBrowser.lOutlineOCX
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set DataSession To toBrowser.DataSessionId
llGallery=toBrowser.lBrowser
llBrowser=(Not llGallery)
If toBrowser.lInitialized
  toBrowser.SavePreferences
Endif
toBrowser.lBrowser=llBrowser
toBrowser.lLastBrowser=llBrowser
If toBrowser.lInitialized
  Set Message To M_SWITCHING_TO_LOC+ ;
    IIF(llBrowser,M_CLASS_BROWSER_LOC,M_COMPONENT_GALLERY_LOC)+" ..."
Endif
With toBrowser
  llLockScreen=.LockScreen
  .LockScreen=.T.
  .cboClassType.Visible=llBrowser
  .cboViewType.Visible=llGallery
  .cmdAdd.Visible=llBrowser
  .cmdExport.Visible=llBrowser
  .cmdFind.Left=.cmdExport.Left+Iif(llBrowser,24,0)
  .cmdSubclass.Visible=llBrowser
  .cmdRename.Visible=llBrowser
  .cmdRedefine.Visible=llBrowser
  .cmdCleanup.Visible=llBrowser
  .cmdUpOneLevel.Visible=llGallery
  .cmdOptions.Visible=llGallery
  .RefreshButtons
  .edtClassDesc.Visible=(llBrowser And .lDescriptions)
  .edtMemberDesc.Visible=(llBrowser And .lDescriptions)
  .edtItemDesc.Visible=(llGallery And .lDescriptions)
Endwith
If toBrowser.lInitialized
  toBrowser.RefreshDescriptions
  toBrowser.cmdOpen.Refresh
Endif
If llGallery And toBrowser.oleItems.Object.ColumnHeaders.Count<=1
  With toBrowser
    .oleItems.Object.ColumnHeaders.Clear
    oColumnHeader=.oleItems.Object.ColumnHeaders.Add(,"_object","Object",96)
    oColumnHeader=.oleItems.Object.ColumnHeaders.Add(,"_type","Type",64)
    oColumnHeader=.Null.
  Endwith
Endif
With toBrowser
  If .lInitialized
    .SavePreferences
  Endif
  .cmdClassIcon.Refresh
  .oleClassList.Visible=llBrowser
  .oleMembers.Visible=llBrowser
  .oleFolderList.Visible=llGallery
  .oleItems.Visible=(Not llBrowser And Not .lWebView)
  .Icon="c:\dev\browser\"+Iif(llBrowser,"browser.ico","gallery.ico")
  .RefreshCaption
  With .cmdBrowser
    .Picture=Iif(llBrowser,"c:\dev\browser\gallery.bmp","c:\dev\browser\browser.bmp")
    .Refresh
  Endwith
  If Not .lRelease And .lActive
    .cmdOpen.SetFocus
  Endif
  If llBrowser
    .HelpContextID=95825501
    .cmdBrowser.HelpContextID=0
    .cmdOpen.HelpContextID=0
    .cmdFind.HelpContextID=0
    .txtClassList3D.Height=.oleClassList.Height
    .txtClassList3D.Width=.oleClassList.Width
    .txtMembers3D.Height=.oleMembers.Height
    .txtMembers3D.Left=.oleMembers.Left
    .txtMembers3D.Width=.oleMembers.Width
    .shpSplitterH.Top=.edtClassDesc.Top-4
  Else
    .HelpContextID=189582651
    .cmdBrowser.HelpContextID=189582651
    .cmdOpen.HelpContextID=189582651
    .cmdFind.HelpContextID=189582651
    .txtClassList3D.Height=.oleFolderList.Height
    .txtClassList3D.Width=.oleFolderList.Width
    .txtMembers3D.Height=.oleItems.Height-2
    .txtMembers3D.Left=.oleItems.Left
    .txtMembers3D.Width=.oleItems.Width
    .shpSplitterH.Top=.edtItemDesc.Top-4
  Endif
  .shpSplitterV.Left=.txtMembers3D.Left-4
Endwith
If llGallery And toBrowser.lInitialized And Empty(toBrowser.cCatalog)
  toBrowser.RefreshBrowser
Endif
If toBrowser.lWebBrowser
  toBrowser.oleWebBrowser.Visible=(Not llBrowser And toBrowser.lWebView)
Endif
toBrowser.LockScreen=llLockScreen
Endfunc



Function brwRefreshItemDesc(toBrowser)
Local oItem,oParent,lcTypeDesc,lcDesc,lcToolTipText

If toBrowser.lRelease Or toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If toBrowser.nFolderCount<1 Or toBrowser.lBrowser
  With toBrowser.edtItemDesc
    .SelLength=0
    .SelStart=0
    .ReadOnly=.T.
    .MaxLength=0
    .StatusBarText=""
    .ToolTipText=""
    .Value=""
    .ScrollBars=0
  Endwith
  Return
Endif
lcToolTipText=""
lcTypeDesc=""
If toBrowser.nItemListIndex>0
  oItem=toBrowser.oItem
  Do Case
    Case Vartype(oItem)=="O"
      lcTypeDesc=oItem.cTypeDesc
      If Empty(lcTypeDesc)
        oParent=oItem
        Do While Not oParent.cID==oParent.oFolder.oLink.cID
          oParent=oParent.oFolder.oLink
          If Not Empty(oParent.cItemTypeDesc)
            lcTypeDesc=oParent.cItemTypeDesc
            Exit
          Endif
        Enddo
        oParent=.Null.
      Endif
  Endcase
Else
  oItem=toBrowser.oFolder
  Do Case
    Case Vartype(oItem)=="O"
      lcTypeDesc=oItem.cTypeDesc
      If Empty(lcTypeDesc) And Vartype(oItem)=="O"
        oParent=oItem
        Do While Not oParent.cID==oParent.oFolder.oLink.cID
          oParent=oParent.oFolder.oLink
          If Not Empty(oParent.cTypeDesc)
            lcTypeDesc=oParent.cTypeDesc
            Exit
          Endif
        Enddo
        oParent=.Null.
      Endif
  Endcase
Endif
lcDesc=""
If Vartype(oItem)=="O"
  lcToolTipText=Left(oItem.cFileName,127)
  If Empty(lcToolTipText)
    If oItem.lCatalog
      lcToolTipText=Left(oItem.cCatalog,127)
    Else
      lcToolTipText=Left(oItem.cText,127)
    Endif
  Endif
  lcDesc=oItem.cDesc
Endif
Do While Left(lcDesc,1)==CR Or Left(lcDesc,1)==LF
  lcDesc=Alltrim(Substr(lcDesc,2))
Enddo
Do While Right(lcDesc,1)==CR Or Right(lcDesc,1)==LF
  lcDesc=Trim(Left(lcDesc,Len(lcDesc)-1))
Enddo
If Vartype(oItem)=="O" And oItem.lFolder And Not oItem.cFolderType=="web"
  If Not Empty(lcDesc)
    lcDesc=lcDesc+CR
  Endif
  lcDesc=lcDesc+Transform(Max(oItem.nItemCount,0))+" "+M_ITEMS_LOC
Endif
If Not Empty(lcTypeDesc)
  Do While Left(lcTypeDesc,1)==CR Or Left(lcTypeDesc,1)==LF
    lcTypeDesc=Alltrim(Substr(lcTypeDesc,2))
  Enddo
  Do While Right(lcTypeDesc,1)==CR Or Right(lcTypeDesc,1)==LF
    lcTypeDesc=Trim(Left(lcTypeDesc,Len(lcTypeDesc)-1))
  Enddo
  If Empty(lcDesc)
    lcDesc=lcTypeDesc
  Else
    lcDesc=lcDesc+CR+CR+lcTypeDesc
  Endif
Endif
With toBrowser.edtItemDesc
  .SelLength=0
  .SelStart=0
  .ReadOnly=.T.
  .MaxLength=0
  .StatusBarText=M_ITEM_LOC+" ("+.Class+") "+M_DESCRIPTION_LOC
  .ToolTipText=lcToolTipText
  .Value=lcDesc
  .ScrollBars=Iif(Empty(lcDesc),0,2)
Endwith
oItem=.Null.
Endfunc



Function brwStartNewWindow(toBrowser,tlGallery)
Local llGallery,lcFileName,lcFileName2,lcDefaultClass,llListBox,lcClassType
Local lnCount,lcCount,lnWindowState,lcAlias,lcAlias2,lcFolderID,lcItemID

With toBrowser
  .SavePreferences
  If tlGallery
    lcFileName=""
    lcAlias2="catalog"
    For lnCount = 1 To 256
      lcCount=Alltrim(Str(lnCount))
      lcAlias=lcAlias2+lcCount
      If Not Used(lcAlias)
        Exit
      Endif
      lcFileName2=Lower(Dbf(lcAlias))
      If lcFileName2==toBrowser.cDefaultCatalog
        Loop
      Endif
      If Not Empty(lcFileName)
        lcFileName=lcFileName+","
      Endif
      lcFileName=lcFileName+lcFileName2
    Endfor
    lcFolderID=Iif(Isnull(.oFolderSource),"",.oFolderSource.cID)
    lcItemID=Iif(Isnull(.oItemSource),"",.oItemSource.cID)
    lcDefaultClass=lcItemID
    llListBox=.F.
    lcClassType=.cViewType
  Else
    lcFileName=.cFileName
    For lnCount = 1 To .nFileCount
      lcFileName2=.aFiles[lnCount]
      If Empty(lcFileName2) Or lcFileName2==.cFileName
        Loop
      Endif
      If Not Empty(lcFileName)
        lcFileName=lcFileName+","
      Endif
      lcFileName=lcFileName+lcFileName2
    Endfor
    lcFolderID=""
    lcItemID=""
    lcDefaultClass=Iif(.nMemberListIndex>0,.aMemberList[.nMemberListIndex,1],"")
    lcDefaultClass=Iif(Empty(lcDefaultClass),.cClass,.cClass+"."+lcDefaultClass)
    llListBox=(Not .lOutlineOCX)
    lcClassType=.cClassType
  Endif
  lnWindowState=.WindowState
  Do (.cProgramName) With (lcFileName),(lcDefaultClass),(llListBox),(lcClassType), ;
    (lnWindowState),(tlGallery)
  If _oBrowser=toBrowser
    Return .F.
  Endif
  With _oBrowser
    If Not Empty(lcFolderID)
      .SelectFolder(lcFolderID,.T.)
    Endif
    If Not Empty(lcItemID)
      .SelectItem(lcItemID,.T.)
    Endif
  Endwith
Endwith
Endfunc



Function brwSetClassLibrary(toBrowser,tcClassLibraryList)
Local lcClassLibraryList,lcClassLibrary,lcClassLibraryAlias,lnClassLibraryCount,lnMemLine

If Empty(tcClassLibraryList)
  Return
Endif
lcClassLibraryList=Lower(Alltrim(Strtran(Strtran(tcClassLibraryList,",",CR),LF,CR)))
_Mline=0
For lnMemLine = 1 To Memlines(lcClassLibraryList)
  lcClassLibrary=Lower(Alltrim(Mline(lcClassLibraryList,1,_Mline)))
  If Empty(lcClassLibrary) Or Left(lcClassLibrary,1)=="*"
    Loop
  Endif
  If Empty(Justext(lcClassLibrary))
    lcClassLibrary=Forceext(lcClassLibrary,"vcx")
  Endif
  If (Not ":"$lcClassLibrary And Not "\\"$lcClassLibrary)
    lcClassLibrary=Lower(Forcepath(lcClassLibrary,toBrowser.cDefaultCatalogPath))
  Endif
  If Empty(Sys(2000,lcClassLibrary))
    toBrowser.MsgBox(M_FILE_LOC+[ "]+lcClassLibrary+[" ]+ ;
      M_DOES_NOT_EXIST_LOC+[.],16)
    Set DataSession To toBrowser.DataSessionId
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  If toBrowser.nClassLibraryCount>0 And Ascan(toBrowser.aClassLibrary,lcClassLibrary)>0
    Return
  Endif
  lcClassLibraryAlias=Lower(Sys(2015))
  toBrowser.nClassLibraryCount=toBrowser.nClassLibraryCount+1
  lnClassLibraryCount=toBrowser.nClassLibraryCount
  Dimension toBrowser.aClassLibrary[lnClassLibraryCount,2]
  toBrowser.aClassLibrary[lnClassLibraryCount,1]=lcClassLibrary
  toBrowser.aClassLibrary[lnClassLibraryCount,2]=lcClassLibraryAlias
  If Right(lcClassLibrary,4)==".prg"
    Set Procedure To (lcClassLibrary) Additive
  Else
    Set Classlib To (lcClassLibrary) Alias (lcClassLibraryAlias) Additive
  Endif
Endfor
Endfunc



Function brwReleaseClassLibraries(toBrowser)
Local lcClassLibrary,lcClassLibraryAlias,lcSetClassLib,lnCount

For lnCount = 1 To toBrowser.nClassLibraryCount
  lcClassLibrary=toBrowser.aClassLibrary[lnCount,1]
  lcClassLibraryAlias=toBrowser.aClassLibrary[lnCount,2]
  If Right(lcClassLibrary,4)==".prg"
    If Atc(lcClassLibrary,Set("PROCEDURE"))>0
      Release Procedure (lcClassLibrary)
    Endif
  Else
    lcSetClassLib=Set("CLASSLIB")
    If Atc(lcClassLibrary,lcSetClassLib)>0 And ;
        ATC(" ALIAS "+lcClassLibraryAlias+",",lcSetClassLib+",")>0
      Release Classlib Alias (lcClassLibraryAlias)
    Endif
  Endif
Endfor
toBrowser.nClassLibraryCount=0
Dimension toBrowser.aClassLibrary[1,2]
toBrowser.aClassLibrary=""
Endfunc



Function brwCopy(toBrowser,toObject,tlCut)
Local oObject

toBrowser.ClearClipBoard
oObject=Iif(Vartype(toObject)#"O",toBrowser.oItemSource,toObject)
If Type("oObject")#"O" Or Isnull(oObject)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
With _Screen._oCGClipBoard
  .cHostName=toBrowser.Name
  .oItem=oObject
  .lCut=tlCut
Endwith
Endfunc



Function brwPaste(toBrowser,toTarget,tlLink,tlNoRefresh)
Local oTarget,oItem,oItem2,oLastItem,oRecord,oNode,llCut,lcAppendText,lcID,lnCount,lcHost

oTarget=Iif(Type("toTarget")#"O" Or Isnull(toTarget),toBrowser.oFolder,toTarget)
With _Screen._oCGClipBoard
  oItem=.oItem
  If Vartype(oItem)#"O" Or oItem=oTarget Or Vartype(oItem.oRecord)#"O"
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  oRecord=oItem.oRecord
  llCut=.lCut
  If Vartype(oItem.oHost)#"O"
    oItem.oHost=toBrowser
  Endif
  lcHost=oItem.oHost.Name
  If llCut
    If tlLink
      toBrowser.vResult=.F.
      Return toBrowser.vResult
    Endif
    .lCut=.F.
    .oItem.Remove(.F.,.T.)
    .oItem.oHost.ClearClipBoard
  Endif
  oLastItem=.oItem
Endwith
oNode=toBrowser.CreateNode(oTarget.cAlias,oRecord)
If Isnull(oNode)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcID=Lower(Sys(2015))
With oNode
  lcAppendText=""
  .cID=lcID
  .cType=oItem.cType
  If Not llCut
    If tlLink
      .cLink=oItem.cID
      lcAppendText="Link to "
    Else
      lcAppendText="Copy of "
    Endif
  Endif
  If tlLink
    .cProperties=""
  Endif
  If Not Empty(lcAppendText)
    .cText=lcAppendText+oItem.cText
  Endif
  .cParent=oTarget.cID
  .oParent=oTarget
  If .oParent.lDynamic
    .lDynamic=.T.
  Endif
  .cFolderPicture=oItem.cFolderPicture
  .cPicture=oItem.cPicture
  .cClassLib=oItem.ClassLibrary
  .cClassName=oItem.Class
  .cCatalog=oTarget.cCatalog
  .cAlias=oTarget.cAlias
  .cSourceCatalog=oTarget.cSourceCatalog
  .cSourceCatalogPath=oTarget.cSourceCatalogPath
  .cSourceAlias=oTarget.cSourceAlias
  .nSourceRecNo=0
  .cID2=Strtran(Juststem(.cCatalog)," ","_")
  .cID=.cID2+"!"+.cID
  .nIndex=0
  .WriteProperties(.T.,.T.)
Endwith
If oItem.lFolder And Not tlLink And Not Isnull(oLastItem)
  For lnCount = 1 To oItem.nItemCount
    Exit
    oItem2=toBrowser.aItemList[oItem.aItemIndexes[lnCount]]
    If Vartype(oItem2)#"O"
      Loop
    Endif
    _Screen._oCGClipBoard.oItem=oItem2
    toBrowser.Paste(oNode,tlLink,.T.)
  Endfor
Endif
If Not tlNoRefresh
  oNode.Refresh(.T.)
  toBrowser.SelectItem(lcID,.T.)
Endif
If Not Isnull(oLastItem)
  If toBrowser.Name==lcHost
    lcID=oLastItem.cID
    oItem=Iif(oLastItem.lFolder,toBrowser.GetFolder(lcID),toBrowser.GetItem(lcID))
  Else
    oItem=oLastItem
  Endif
  _Screen._oCGClipBoard.oItem=oItem
Endif
If Vartype(oNode)=="O"
  oNode.Release
Endif
Endfunc



Function brwCreateLink(toBrowser,toObject)
Local oObject,oItem,oRecord,llCut

oObject=Iif(Vartype(toObject)#"O",toBrowser.oItem,toObject)
If Vartype(oObject)#"O" Or oObject.lCatalog
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
With _Screen._oCGClipBoard
  oItem=.oItem
  llCut=.lCut
  .oItem=toObject
  .lCut=.F.
  If Not toBrowser.Copy(oObject) Or Not toBrowser.Paste(oObject.oFolder,.T.)
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  .oItem=oItem
  .lCut=llCut
Endwith
Endfunc



Function brwGetRecordObject(toBrowser,toNode)
Local oNode,oRecord,lcAlias,lnRecNo,lnLastSelect

oNode=Iif(Vartype(toNode)#"O",toBrowser.oItemSource,toNode)
If Type("oNode")#"O" Or Isnull(oNode)
  toBrowser.vResult=.Null.
  Return .Null.
Endif
lcAlias=oNode.cAlias
If Empty(lcAlias) Or Not Used(lcAlias)
  toBrowser.vResult=.Null.
  Return .Null.
Endif
lnLastSelect=Select()
Select (lcAlias)
lnRecNo=Iif(Eof() Or Recno()>Reccount(),0,Recno())
Go oNode.nRecNo
oRecord=.Null.
Scatter Memo Name oRecord
If Select()=lnLastSelect
  Go lnRecNo
Else
  Select (lnLastSelect)
Endif
toBrowser.vResult=oRecord
Return oRecord
Endfunc



Function brwCheckGalleryTableStructure(toBrowser)
Local lcCatalog,lcCatalogPath,lcAlias,lcTempTable,lcStructureTable

If Type("ID")#"C" Or Type("Properties")#"M" Or Type("Script")#"M"
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcCatalog=Lower(Dbf())
lcCatalogPath=Iif(Empty(lcCatalog),"",Justpath(lcCatalog)+"\")
lcAlias=Lower(Alias())
Do While Not toBrowser.lRelease And Type("FileName")#"M"
  Use (lcCatalog) Exclusive Alias (lcAlias)
  If Not Used()
    toBrowser.cCatalog=""
    If Used(lcAlias)
      Use In (lcAlias)
    Endif
    Select 0
    Set Message To
    toBrowser.MsgBox(M_FILE_LOC+[ "]+lcCatalog+[" ]+M_COULD_NOT_OPENED_EXCL_LOC,16)
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  Set Filter To Not Deleted()
  Locate
  lcTempTable=Lower(Fullpath("_1"+Sys(2015),lcCatalogPath))
  lcStructureTable=Lower(Fullpath("_2"+Sys(2015),lcCatalogPath))
  Use (lcCatalog) Exclusive Alias _TempTable
  Copy To (lcTempTable)
  Copy To (lcStructureTable) Structure Extended
  Use
  Use (lcStructureTable) Exclusive Alias _TempTable
  Set Filter To Not Deleted()
  Locate
  Locate For Upper(Alltrim(Field_Name))=="PARENT"
  If Not Eof() And Not Field_Type=="M"
    Replace Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="LINK"
  If Not Eof() And Not Field_Type=="M"
    Replace Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="TYPEDESC"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="DESC"
    Insert Blank Before
    Replace Field_Name With "TYPEDESC", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="FILENAME"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="PROPERTIES"
    Insert Blank
    Replace Field_Name With "FILENAME", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="CLASS"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="SCRIPT"
    Insert Blank Before
    Replace Field_Name With "CLASS", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="PICTURE"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="SCRIPT"
    Insert Blank Before
    Replace Field_Name With "PICTURE", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="FOLDERPICT"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="SCRIPT"
    Insert Blank Before
    Replace Field_Name With "FOLDERPICT", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="ITEMTPDESC"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="UPDATED"
    Insert Blank Before
    Replace Field_Name With "ITEMTPDESC", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="VIEWS"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="UPDATED"
    Insert Blank Before
    Replace Field_Name With "VIEWS", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="KEYWORDS"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="VIEWS"
    Insert Blank
    Replace Field_Name With "KEYWORDS", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="SRCALIAS"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="UPDATED"
    Insert Blank Before
    Replace Field_Name With "SRCALIAS", Field_Type With "M", Field_Len With 4
  Endif
  Locate For Upper(Alltrim(Field_Name))=="SRCRECNO"
  If Eof()
    Locate For Upper(Alltrim(Field_Name))=="UPDATED"
    Insert Blank Before
    Replace Field_Name With "SRCRECNO", Field_Type With "N", Field_Len With 6
  Endif
  Use
  Create (lcCatalog) From (lcStructureTable)
  Use (lcCatalog) Exclusive Alias (lcAlias)
  Zap
  Append From (lcTempTable)
  Replace All Parent With Alltrim(Parent), Link With Alltrim(Link)
  brwReMapCatalogProperties(toBrowser)
  Use
  Erase (lcTempTable+".dbf")
  Erase (lcTempTable+".fpt")
  Erase (lcStructureTable+".dbf")
  Erase (lcStructureTable+".fpt")
  Select 0
  Use (lcCatalog) Again Shared Alias (lcAlias)
  Set Filter To Not Deleted()
  Locate
Enddo
Endfunc



Function brwReMapCatalogProperties(toBrowser)
Local lcProperties,lcNewProperties,lcProperty,lnProperty
Local lnMemLine,lcMemLine,lnCount,lnAtPos,lcValue
Local laProperites[4]

laProperites[1]="cfilename"
laProperites[2]="cclass"
laProperites[3]="cpicture"
laProperites[4]="cfolderpicture"
Scan All For Not Empty(Properties)
  If toBrowser.lRelease
    Return .F.
  Endif
  lcProperties=Properties
  lcProperties=Strtran(Strtran(lcProperties,CR+CR,CR),CR_LF+CR_LF,CR_LF)
  Do While Left(lcProperties,1)==CR Or Left(lcProperties,1)==LF
    lcProperties=Alltrim(Substr(lcProperties,2))
  Enddo
  Do While Right(lcProperties,1)==CR Or Right(lcProperties,1)==LF
    lcProperties=Trim(Left(lcProperties,Len(lcProperties)-1))
  Enddo
  lcNewProperties=lcProperties
  For lnMemLine = 1 To Memlines(lcProperties)
    lcMemLine=Mline(lcProperties,lnMemLine)
    lnAtPos=At("=",lcMemLine)
    If lnAtPos=0
      Loop
    Endif
    lcProperty=Lower(Alltrim(Left(lcMemLine,lnAtPos-1)))
    If Empty(lcProperty)
      Loop
    Endif
    lnProperty=Ascan(laProperites,lcProperty)
    If lnProperty=0
      Loop
    Endif
    lcValue=Alltrim(Substr(lcMemLine,lnAtPos+1))
    lcNewProperties=Strtran(lcNewProperties,lcMemLine,"")
    lcNewProperties=Strtran(Strtran(lcNewProperties,CR+CR,CR),CR_LF+CR_LF,CR_LF)
    Do Case
      Case lnProperty=1
        Replace FileName With lcValue
      Case lnProperty=2
        Replace Class With lcValue
      Case lnProperty=3
        Replace Picture With lcValue
      Case lnProperty=4
        Replace FolderPict With lcValue
    Endcase
  Endfor
  lcNewProperties=Strtran(Strtran(lcNewProperties,CR+CR,CR),CR_LF+CR_LF,CR_LF)
  Do While Left(lcNewProperties,1)==CR Or Left(lcNewProperties,1)==LF
    lcNewProperties=Alltrim(Substr(lcNewProperties,2))
  Enddo
  Do While Right(lcNewProperties,1)==CR Or Right(lcNewProperties,1)==LF
    lcNewProperties=Trim(Left(lcNewProperties,Len(lcNewProperties)-1))
  Enddo
  lcNewProperties=Strtran(lcNewProperties,CR_LF,CR)
  If Not Properties==lcNewProperties
    Replace Properties With lcNewProperties
  Endif
Endscan
Endfunc



Function brwRefreshView(toBrowser,toView,tcSearchAlias)
Local oView,lcSearchAlias,oRecord,lcViewAlias,lcCatalog
Local lcContaining,lcLookIn,lcLookInAlias,lcKeywordList,llItemName,llDescription
Local llFileName,llClassName,llProperties,lcItemTypes,llMatch,llKeywordMatch
Local lcText,lcContaining,lcKeyword1,lcKeyword2,lcType,lcParent,oCatalog
Local lnCount,lnCount2,lnLastSelect,lnLastRecNo,lnRecNolnMatchCount
Dimension laKeywords1[1],laKeywords2[1]

Set DataSession To (toBrowser.DataSessionId)
lcSearchAlias=Iif(Type("tcSearchAlias")=="C",Lower(Alltrim(tcSearchAlias)),"view_default")
lcText=toView.cText
If Vartype(toView)#"O" Or Not Used(lcSearchAlias) Or ;
    EMPTY(toView.cID) Or Empty(lcText) Or Empty(toView.cViewAlias)
  toBrowser.vResult=0
  Return 0
Endif
lnLastSelect=Select()
lnLastRecNo=Iif(Used() And Not Eof(),Recno(),0)
lcViewAlias=Lower(toView.cViewAlias)
If lcViewAlias=="view_default"
  toBrowser.vResult=Iif(Used(lcViewAlias),Reccount(lcViewAlias),0)
  Return toBrowser.vResult
Endif
If Empty(lcViewAlias) Or Not Used(lcViewAlias)
  If Empty(lcText)
    toBrowser.vResult=0
    Return 0
  Endif
  lcViewAlias="view_"+Lower(Strtran(lcText," ","_"))
  lcViewAlias=toBrowser.CreateView(lcViewAlias)
Endif
If Not Used(lcViewAlias)
  toBrowser.vResult=0
  Return 0
Endif
If lcViewAlias==lcSearchAlias
  lcSearchAlias="view_default"
Endif
lnMatchCount=0
With toView
  lcContaining=Lower(Alltrim(.cContaining))
  Do Case
    Case Empty(lcContaining)
      lcContaining="*"
    Case Not "*"$lcContaining And Not "?"$lcContaining And Not "%"$lcContaining
      lcContaining="%"+lcContaining+"%"
  Endcase
  lcLookIn=Lower(Alltrim(.cLookIn))
  lcLookInAlias=Lower(Alltrim(.cLookInAlias))
  lcKeywordList=.cKeywordList
  llItemName=.lItemName
  llDescription=.lDescription
  llFileName=.lFileName
  llClassName=.lClassName
  llProperties=.lProperties
  lcItemTypes=Lower(Alltrim(.cItemTypes))
Endwith
Dimension laKeywords1[1]
laKeywords1=""
If Not Empty(lcKeywordList)
  brwKeywordListToArray(lcKeywordList,@laKeywords1)
Endif
Select (lcViewAlias)
Zap
lcCatalog=Lower(Sys(2015))
Append Blank
Replace Type With "FOLDER", Id With lcCatalog, Text With lcText
Select (lcSearchAlias)
With toBrowser
  Scan All For Not Empty(SrcAlias)
    lcType=Upper(Alltrim(Type))
    If Inlist(lcType+" ","OBJECT ","VIEW ")
      oRecord=.Null.
      Scatter Memo Name oRecord
      Select (lcViewAlias)
      Append Blank
      If lcType=="VIEW"
        oRecord.Parent=lcCatalog
      Endif
      Gather Memo Name oRecord
      oRecord=.Null.
      Select (lcSearchAlias)
      Loop
    Endif
    If Not lcType=="ITEM" Or (Not Empty(lcLookInAlias) And ;
        NOT Lower(SrcAlias)==lcLookInAlias) And ;
        (lcType=="ITEM" Or Not Lower(SrcAlias)=="catalog1")

      Loop
    Endif
    llMatch=(Empty(lcContaining) Or lcContaining=="*")
    If Not llMatch
      llMatch=((llItemName And .WildCardMatch(lcContaining,Text)) Or ;
        (llDescription And .WildCardMatch(lcContaining,Desc)) Or ;
        (llFileName And .WildCardMatch(lcContaining,FileName)) Or ;
        (llClassName And .WildCardMatch(lcContaining,Class)) Or ;
        (llProperties And .WildCardMatch(lcContaining,Properties)))
      If Not llMatch
        Loop
      Endif
    Endif
    llKeywordMatch=(Empty(keywords) And Empty(lcKeywordList))
    If Not llKeywordMatch
      Dimension laKeywords2[1]
      laKeywords2=""
      brwKeywordListToArray(keywords,@laKeywords2)
      For lnCount = 1 To Alen(laKeywords1)
        lcKeyword1=laKeywords1[lnCount]
        For lnCount2 = 1 To Alen(laKeywords2)
          lcKeyword2=laKeywords2[lnCount2]
          If .WildCardMatch(lcKeyword1,lcKeyword2)
            llKeywordMatch=.T.
            Exit
          Endif
        Endfor
        If llKeywordMatch
          Exit
        Endif
      Endfor
    Endif
    If Not llKeywordMatch
      Loop
    Endif
    oRecord=.Null.
    Scatter Memo Name oRecord
    If Empty(ClassName) And Not Empty(Parent)
      lnRecNo=Recno()
      Do While .T.
        lcParent=Lower(Alltrim(Parent))
        If Empty(lcParent)
          Exit
        Endif
        Locate For Lower(Alltrim(Id))==lcParent
        If Eof()
          Exit
        Endif
        If Not Empty(ItemClass)
          oRecord.ClassName=Lower(Alltrim(ItemClass))
          If Empty(oRecord.Classlib) And Not Empty(Classlib)
            oRecord.Classlib=Lower(Alltrim(Classlib))
          Endif
          Exit
        Endif
      Enddo
      Go lnRecNo
    Endif
    Select (lcViewAlias)
    Append Blank
    oRecord.Parent=lcCatalog
    Gather Memo Name oRecord
    oRecord=.Null.
    Select (lcSearchAlias)
    lnMatchCount=lnMatchCount+1
  Endscan
Endwith
Select (lnLastSelect)
If Used() And Between(lnLastRecNo,1,Reccount())
  Go lnLastRecNo
Endif
toBrowser.vResult=lnMatchCount
Return lnMatchCount
Endfunc



Function brwKeywordListToArray(tcKeywordList,taKeywords)
Local lcKeywordList,lnKeywordCount,lcList,lcKeyword

lcKeywordList=Lower(Alltrim(Chrtran(tcKeywordList,Tab+CR+LF+",;","     ")))
Dimension taKeywords[1]
taKeywords=""
lnKeywordCount=0
If Empty(lcKeywordList)
  Return lnKeywordCount
Endif
lcList=lcKeywordList
Do While Not Empty(lcList)
  lnKeywordCount=lnKeywordCount+1
  lnAtPos=At(" ",lcList)
  If lnAtPos=0
    lcKeyword=Alltrim(lcList)
    lcList=""
  Else
    lcKeyword=Alltrim(Left(lcList,lnAtPos-1))
    lcList=Alltrim(Substr(lcList,lnAtPos+1))
  Endif
  If Empty(lcKeyword)
    Loop
  Endif
  Dimension taKeywords[lnKeywordCount]
  taKeywords[lnKeywordCount]=lcKeyword
Enddo
Return lnKeywordCount
Endfunc



Function brwCreateView(toBrowser,tcAlias,tcFileName)
Local lcAlias,lcFileName,lcViewName,lcViewItem,oRecord
Local llMatch,lnCount,lnLastSelect

lcAlias=Iif(Empty(tcAlias),Lower(Sys(2015)),Strtran(Lower(Alltrim(tcAlias))," ","_"))
lcFileName=Iif(Empty(tcFileName),"",Alltrim(tcFileName))
If lcAlias=="view_" Or lcAlias==toBrowser.cGallery Or ;
    NOT toBrowser.CreateCatalog(lcAlias,lcFileName)
  toBrowser.vResult=""
  Return ""
Endif
lnLastSelect=Select()
Select (lcAlias)
Index On Upper(Type)+Iif(Empty(Parent)," ",Upper(Text)) Tag Type
Select (lnLastSelect)
If Not Left(lcAlias,5)=="view_"
  toBrowser.vResult=lcAlias
  Return lcAlias
Endif
lcViewName=Strtran(Substr(lcAlias,6),"_"," ")
llMatch=.F.
With toBrowser.cboViewType
  For lnCount = 1 To .ListCount
    lcViewItem=.List[lnCount]
    If Not llMatch And Lower(lcViewItem)==Lower(lcViewName)
      llMatch=.T.
      Exit
    Endif
  Endfor
  If Not llMatch
    .AddItem(Proper(lcViewName))
  Endif
Endwith
toBrowser.vResult=lcAlias
Return lcAlias
Endfunc



Function brwCreateCatalog(toBrowser,tcAlias,tcFileName)
Local lcFileName,lcAlias,lnLastSelect,lnLastRecNo,lcID
Local laFields[1]

lcAlias=Iif(Empty(tcAlias),"",Strtran(Lower(Alltrim(tcAlias))," ","_"))
lcFileName=Iif(Empty(tcFileName),"",Alltrim(tcFileName))
If (Empty(lcAlias) And Empty(lcFileName)) Or Not Used("catalog1")
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lnLastSelect=Select()
lnLastRecNo=Iif(Used() And Not Eof(),Recno(),0)
If Not Empty(lcAlias) And Used(lcAlias)
  If Empty(lcFileName)
    Select (lcAlias)
    Zap
    Select (lnLastSelect)
    Return
  Endif
  Use In (lcAlias)
Endif
Afields(laFields,"catalog1")
Select 0
If Empty(lcFileName)
  Create Cursor (lcAlias) From Array laFields
Else
  Create Table (lcFileName) From Array laFields
  If Not Used()
    Select (lnLastSelect)
    If Used() And Between(lnLastRecNo,1,Reccount())
      Go lnLastRecNo
    Endif
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  If Empty(lcAlias)
    lcID=Lower(Sys(2015))
    Append Blank
    Replace Type With "FOLDER", ;
      ID With lcID, ;
      Text With Forceext(Justfname(lcFileName),"")
    Select (lnLastSelect)
    If Used() And Between(lnLastRecNo,1,Reccount())
      Go lnLastRecNo
    Endif
    Return
  Endif
  Use (lcFileName) Exclusive Alias (lcAlias)
  Set Filter To Not Deleted()
  Locate
Endif
If Not Used(lcAlias)
  Select (lnLastSelect)
  If Used() And Between(lnLastRecNo,1,Reccount())
    Go lnLastRecNo
  Endif
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
CursorSetProp("Buffering",1)
Set Filter To Not Deleted()
Locate
Select (lnLastSelect)
If Used() And Between(lnLastRecNo,1,Reccount())
  Go lnLastRecNo
Endif
Endfunc



Function brwCreateNode(toBrowser,tvAlias,tvType,tcFileName,tlRefresh,tlNoWriteProperties)
Local lcAlias,lcType,oRecord,oNode,oFolder,lcClassLibrary,lcClassLibraryAlias,oItem
Local llCopyNode,lcID,lcScriptCode,lcText,lcText2,lnDuplicateCount,lcClass,lcNewClass
Local lcItemTypes,lcGetFileExt,lcFileName,lcFileExt,lnRecNo,lnLastRecNo,lnLastSelect
Local lnCount,lnAtPos,lnMaxCount,llAddFile,lcSourceAlias,lcSourceCatalog

oFolder=.Null.
lnRecNo=0
llAddFile=.F.
lcNewClass=""
lcClass=""
lcClassLibrary=""
lcFileName=Iif(Empty(tcFileName),"",Lower(Alltrim(tcFileName)))
Do Case
  Case Type("tvAlias")=="C"
    lcAlias=Lower(Alltrim(tvAlias))
  Case Type("tvAlias")=="O"
    lcAlias="itemtypes"
    If Not Empty(tvType) And Type("tvType")=="N"
      lnRecNo=tvType
    Endif
    Do Case
      Case Not Empty(lcFileName)
        llAddFile=.T.
        oFolder=tvAlias
        lcClass=tvType
      Case lnRecNo=0 Or Not Between(lnRecNo,1,Reccount("itemtypes"))
        lnRecNo=0
        oFolder=tvAlias
        lcAlias=oFolder.cSourceAlias
      Otherwise
        oFolder=tvAlias
    Endcase
  Otherwise
    lcAlias=""
Endcase
If Empty(lcAlias) Or Type("lcAlias")#"C" Or Not Used(lcAlias)
  toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
    M_NODE_LOC+[ ]+M_ERROR_LOC+[ 1],16)
  toBrowser.vResult=.Null.
  Return .Null.
Endif
lnLastSelect=Select()
lnLastRecNo=Iif(Used() And Not Eof(),Recno(),0)
If Not Isnull(oFolder)
  Select itemtypes
  Set Order To
  If Not llAddFile
    Go lnRecNo
    lcType=Upper(Alltrim(Mline(Property,1)))
    lcClass=Lower(Alltrim(Mline(Class,1)))
  Else
    lnRecNo=0
    If Empty(tvType)
      toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
        M_NODE_LOC+[ ]+M_ERROR_LOC+[ 2],16)
      Select (lnLastSelect)
      toBrowser.vResult=.Null.
      Return .Null.
    Endif
    lcType=Alltrim(tvType)
    Do Case
      Case lcType=="FOLDER"
        lcClass=toBrowser.cFolderClass
      Case lcType=="ITEM"
        lcClass=toBrowser.cItemClass
      Case lcType=="OBJECT"
        lcClass=toBrowser.cObjectClass
      Case lcType=="VIEW"
        lcClass=toBrowser.cViewClass
      Case lcType=="NODE"
        lcClass=toBrowser.cNodeClass
      Otherwise
        Locate For Lower(Alltrim(Class))==Lower(Alltrim(lcType))
        If Eof()
          Select (lnLastSelect)
          toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
            M_NODE_LOC+[ ]+M_ERROR_LOC+[ 3],16)
          toBrowser.vResult=.Null.
          Return .Null.
        Endif
        lnRecNo=Recno()
        lcType=Upper(Alltrim(Mline(Property,1)))
        lcClass=Lower(Alltrim(Mline(Class,1)))
    Endcase
  Endif
  If Empty(lcType)
    Select (lnLastSelect)
    toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
      M_NODE_LOC+[ ]+M_ERROR_LOC+[ 4],16)
    toBrowser.vResult=.Null.
    Return .Null.
  Endif
  If Not llAddFile
    lcGetFileExt=Lower(Alltrim(GetFileExt))
    If Not Empty(lcGetFileExt)
      If Atc("htm",lcGetFileExt)>0
        lcFileName=toBrowser.oFolder.GetFileAddress(.T.,lcGetFileExt)
      Else
        Do While .T.
          lcFileName=toBrowser.Getfile(lcGetFileExt,.T.)
          If Empty(lcFileName) Or "/"$lcFileName Or ","$lcFileName Or ;
              FILE(lcFileName)
            Exit
          Endif
          Messagebox(M_FILE_LOC+[ "]+lcFileName+[" ]+M_NOT_FOUND_LOC+[.],16, ;
            toBrowser.Caption)
        Enddo
      Endif
      lnAtPos=At(",",lcFileName)
      If lnAtPos>0
        lcNewClass=Alltrim(Substr(lcFileName,lnAtPos+1))
        lcFileName=Alltrim(Left(lcFileName,lnAtPos-1))
      Endif
      If Empty(lcFileName)
        Select (lnLastSelect)
        toBrowser.vResult=.Null.
        Return .Null.
      Endif
    Endif
  Endif
  lcFileExt=Justext(lcFileName)
  If Not Empty(lcFileExt)
    lcItemTypes=Alltrim(itemtypes)
    lnAtPos=Atc(CR+lcFileExt+"=",lcItemTypes)
    If lnAtPos>0
      lcClass=Lower(Mline(Substr(lcItemTypes,lnAtPos+Len(lcFileExt)+2),1))
    Endif
  Endif
  If Not Empty(Classlib)
    lcClassLibrary=Lower(Alltrim(Mline(Classlib,1)))
    lcClass=lcClassLibrary+","+lcClass
  Endif
  oNode=toBrowser.CreateNode(oFolder.cSourceAlias,lcClass)
  If Isnull(oNode)
    Select (lnLastSelect)
    toBrowser.vResult=.Null.
    Return .Null.
  Endif
  lcAlias=tvAlias.cAlias
  With oNode
    .cAlias=lcAlias
    .oFolder=oFolder
    .oParent=.oFolder
    .cParent=.oParent.cID
    If .oParent.lDynamic
      .lDynamic=.T.
    Endif
    If Empty(lcFileName)
      lcText=M_NEW_LOC+" "+Chrtran(Alltrim(Text),"*~\<>","")
    Else
      lcText=Iif(Not Empty(lcNewClass),lcNewClass,Justfname(lcFileName))
    Endif
    lcClassLibrary=Lower(.Fullpath(lcClassLibrary))
    lnDuplicateCount=0
    For lnCount = 1 To toBrowser.nItemCount
      oItem=toBrowser.aItemList[lnCount]
      If Vartype(oItem)#"O" Or Not oItem.cParent==.cParent Or ;
          NOT oItem.Visible Or oItem.lDeleted
        Loop
      Endif
      lcText2=Alltrim(Lower(oItem.cText))
      lnAtPos=Rat("(",lcText2)
      If lnAtPos>0
        lnMaxCount=Val(Substr(lcText2,lnAtPos+1))
        lcText2=Alltrim(Left(lcText2,lnAtPos-1))
      Else
        lnMaxCount=0
      Endif
      If lcText2==Lower(lcText)
        lnDuplicateCount=Max(lnDuplicateCount+1,lnMaxCount)
      Endif
    Endfor
    oItem=.Null.
    If lnDuplicateCount>0
      lcText=lcText+" ("+Alltrim(Str(lnDuplicateCount+1))+")"
    Endif
    If Empty(.cText)
      .cText=lcText
    Endif
    If Not Empty(Desc)
      .cDesc=Alltrim(Desc)
    Endif
    If Not Empty(lcClassLibrary)
      .cClassLib=lcClassLibrary
    Endif
    If Not Empty(ItemClass)
      .cItemClass=Alltrim(Mline(ItemClass,1))
    Endif
    If Not Empty(lcFileName)
      .cFileName=lcFileName
    Endif
    If Not Empty(lcNewClass)
      .cClass=lcNewClass
    Endif
    If Not Empty(.cPicture)
      .cPicture=Lower(brwImagePictureFile(toBrowser,.Fullpath(.cPicture)))
    Endif
    If Not Empty(.cFolderPicture)
      .cFolderPicture=Lower(brwImagePictureFile(toBrowser,.Fullpath(.cFolderPicture)))
    Endif
    lcScriptCode=Alltrim(Script)
    Select 0
    .SetProperties(.cProperties)
    If Not Empty(lcScriptCode)
      .RunCode(lcScriptCode)
    Endif
    If Not tlNoWriteProperties
      .WriteProperties(.T.,.T.)
    Endif
    If tlRefresh
      lcID=.cID
      toBrowser.RefreshBrowser
      toBrowser.SelectItem(lcID,.T.)
    Endif
  Endwith
  Select 0
  toBrowser.vResult=oNode
  Return oNode
Endif
llCopyNode=.F.
oRecord=.Null.
Do Case
  Case Type("tvType")=="C"
    lcType=Upper(Alltrim(tvType))
  Case Type("tvType")=="O"
    oRecord=tvType
    If PEMSTATUS(tvType,"ParentClass",5)
      If Not PEMSTATUS(oRecord,"cType",5) Or Not PEMSTATUS(oRecord,"cAlias",5) Or ;
          NOT PEMSTATUS(oRecord,"nRecNo",5) Or Not Used(oRecord.cAlias) Or ;
          oRecord.nRecNo<=0
        toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
          M_NODE_LOC+[ ]+M_ERROR_LOC+[ 5],16)
        toBrowser.vResult=.Null.
        Return .Null.
      Endif
      llCopyNode=.T.
      oRecord=tvType.oRecord
      If Isnull(oRecord)
        toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
          M_NODE_LOC+[ ]+M_ERROR_LOC+[ 6],16)
        toBrowser.vResult=.Null.
        Return .Null.
      Endif
    Endif
    If Not PEMSTATUS(oRecord,"Type",5)
      toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
        M_NODE_LOC+[ ]+M_ERROR_LOC+[ 7],16)
      toBrowser.vResult=.Null.
      Return .Null.
    Endif
    lcType=Upper(Alltrim(oRecord.Type))
  Otherwise
    toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
      M_NODE_LOC+[ ]+M_ERROR_LOC+[ 8],16)
    toBrowser.vResult=.Null.
    Return .Null.
Endcase
If Empty(lcClass)
  Do Case
    Case lcType=="FOLDER"
      lcClass=toBrowser.cFolderClass
    Case lcType=="ITEM"
      lcClass=toBrowser.cItemClass
    Case lcType=="OBJECT"
      lcClass=toBrowser.cObjectClass
    Case lcType=="VIEW"
      lcClass=toBrowser.cViewClass
    Case lcType=="NODE"
      lcClass=toBrowser.cNodeClass
    Otherwise
      lcClass=Lower(lcType)
      lcType=""
      lnAtPos=At(",",lcClass)
      If lnAtPos>0
        lcClassLibrary=Lower(Alltrim(Mline(Left(lcClass,lnAtPos-1),1)))
        lcClass=Lower(Alltrim(Substr(lcClass,lnAtPos+1)))
      Endif
      If Empty(lcClass)
        lcClass=toBrowser.cItemClass
      Endif
  Endcase
Endif
lcSourceAlias=lcAlias
lcSourceCatalog=Lower(Dbf(lcSourceAlias))
lcID=Lower(Sys(2015))
lcClassLibraryAlias=Lower(Sys(2015))
If Empty(lcClassLibrary)
  lcClassLibrary=toBrowser.cDefaultCatalogClassLibrary
Else
  If Empty(Justext(lcClassLibrary))
    lcClassLibrary=Forceext(lcClassLibrary,"vcx")
  Endif
  lcClassLibrary=Lower(Forcepath(lcClassLibrary,toBrowser.cDefaultCatalogPath))
  If Empty(Sys(2000,lcClassLibrary))
    lcClassLibrary=Lower(Forcepath(lcClassLibrary,Justpath(lcSourceCatalog)))
  Endif
Endif
oNode=Newobject(lcClass,lcClassLibrary)
If Type("oNode")#"O" Or Isnull(oNode)
  Select (lnLastSelect)
  If Used() And Between(lnLastRecNo,1,Reccount())
    Go lnLastRecNo
  Endif
  toBrowser.MsgBox(M_NODE_LOC+[ ]+M_COULD_NOT_BE_CREATED_LOC+[.  ]+ ;
    M_NODE_LOC+[ ]+M_ERROR_LOC+[ 9],16)
  toBrowser.vResult=.Null.
  Return .Null.
Endif
With oNode
  Select (lcAlias)
  .oHost=toBrowser
  .oRecord=oRecord
  If Not Empty(lcType)
    .cType=lcType
  Else
    .cType=Iif(.lFolder,"FOLDER","ITEM")
    .cClassName=Lower(.Class)
    .cClassLib=Lower(.ClassLibrary)
  Endif
  .cSourceAlias=lcSourceAlias
  .cSourceCatalog=lcSourceCatalog
  .cSourceCatalogPath=Iif(Empty(.cSourceCatalog),"",Justpath(.cSourceCatalog)+"\")
  .oLink=oNode
  .oAction=oNode
  .oShortCutMenu=.oHost.oShortCutMenu
  .oShortCutMenu.oHost=oNode
  .cAlias=lcAlias
  If Not Isnull(oRecord)
    If llCopyNode
      With oRecord
        .Id=lcID
        .SrcAlias=tvType.cSourceAlias
        .SrcRecNo=0
        .Updated={:}
      Endwith
    Endif
    Append Blank
    Gather Memo Name oRecord
    .nRecNo=Recno()
    .ReadProperties
    .SetProperties(.cProperties)
    If llCopyNode
      .cSourceAlias=oRecord.SrcAlias
      .nSourceRecNo=oRecord.SrcRecNo
    Else
      .nSourceRecNo=-1
    Endif
  Endif
  If Empty(.cID)
    .cID=lcID
  Endif
  If Empty(.cType)
    .cType=lcType
  Endif
Endwith
Select (lnLastSelect)
If Used() And Between(lnLastRecNo,1,Reccount())
  Go lnLastRecNo
Endif
If tlRefresh
  lcID=oNode.cID
  toBrowser.RefreshBrowser
  toBrowser.SelectItem(lcID,.T.)
Endif
toBrowser.vResult=oNode
Return oNode
Endfunc



Function brwReadProperties(toNode)
Local toBrowser,lnLastSelect

toBrowser=toNode.oHost
Set DataSession To (toBrowser.DataSessionId)
If toNode.nRecNo<=0 Or Empty(toNode.cAlias) Or Not Used(toNode.cAlias)
  toNode.vResult=.F.
  Return toBrowser.vResult
Endif
With toNode
  lnLastSelect=Select()
  Select (.cAlias)
  Go .nRecNo
  .cType=Alltrim(Type)
  .cID=Alltrim(Id)
  .cParent=Alltrim(Parent)
  .cLink=Alltrim(Link)
  If Not Empty(Text)
    .cText=Alltrim(Text)
  Endif
  If Not Empty(TypeDesc)
    .cTypeDesc=Alltrim(TypeDesc)
  Endif
  If Not Empty(Desc)
    .cDesc=Alltrim(Desc)
  Endif
  If Not Empty(Properties)
    .cProperties=Alltrim(Properties)
  Endif
  If Not Empty(FileName)
    .cFileName=Mline(FileName,1)
  Endif
  If Not Empty(.cFileName)
    .cFileName=Lower(.Fullpath(.cFileName))
  Endif
  If Not Empty(Class)
    .cClass=Lower(Alltrim(Mline(Class,1)))
  Endif
  If Not Empty(Picture)
    .cPicture=Mline(Picture,1)
  Endif
  If Not Empty(.cPicture)
    .cPicture=Lower(brwImagePictureFile(toBrowser,.Fullpath(.cPicture)))
  Endif
  If Not Empty(FolderPict)
    .cFolderPicture=Mline(FolderPict,1)
  Endif
  If Not Empty(.cFolderPicture)
    .cFolderPicture=Lower(brwImagePictureFile(toBrowser,.Fullpath(.cFolderPicture)))
  Endif
  If Not Empty(Script)
    .cScript=Alltrim(Script)
  Endif
  If Not Empty(Classlib)
    .cClassLib=Mline(Classlib,1)
  Endif
  If Not Empty(.cClassLib)
    .cClassLib=Lower(.Fullpath(.cClassLib))
  Endif
  If Not Empty(ClassName)
    .cClassName=Lower(Alltrim(Mline(ClassName,1)))
  Endif
  If Not Empty(ItemClass)
    .cItemClass=Lower(Alltrim(Mline(ItemClass,1)))
  Endif
  If Not Empty(ItemTpDesc)
    .cItemTpDesc=Alltrim(ItemTpDesc)
  Endif
  If Not Empty(Views)
    .cViews=Alltrim(Views)
  Endif
  If Not Empty(keywords)
    .cKeywords=Alltrim(keywords)
  Endif
  .tUpdated=Updated
  .cComment=Alltrim(Comment)
  .cUser=Alltrim(User)
  .SetProperties(.cProperties)
Endwith
Select (lnLastSelect)
Endfunc



Function brwWriteProperties(toNode,tlUpdateSource,tlAutoAdd)
Local toBrowser,lnLastSelect,lcType,oRecord,lcProperties,oRecord,lcClauses,lcClass
Local oParent,lcFileName,lcPicture,lcFolderPicture,lcClassLib,lnLastMLine
Local lnAtPos,lcProperty,lcProperty2,lcValue,lvValue,lvDefaultValue,lcDesc
Local lcAlias,lcSourceCatalog,lcSourceCatalogPath,lcSourceAlias,lcPictureFile

toBrowser=toNode.oHost
Set DataSession To (toBrowser.DataSessionId)
lcAlias=Lower(toNode.cAlias)
If Empty(lcAlias) Or Not Used(lcAlias)
  toNode.vResult=.F.
  Return toBrowser.vResult
Endif
lnLastMLine=_Mline
Set DataSession To toBrowser.DataSessionId
lnLastSelect=Select()
Select (lcAlias)
With toNode
  lcType=Upper(Alltrim(.cType))
  lcClass=Lower(Alltrim(.cClassName))
  If Empty(lcClass)
    oParent=.oParent
    If Isnull(oParent) And Not Empty(.cParent)
      oParent=toBrowser.GetFolder(.cParent,.T.)
    Endif
    If Not Isnull(oParent)
      Do While .T.
        lcClass=Lower(Alltrim(oParent.cItemClass))
        If Not Empty(lcClass) Or oParent.cID==oParent.oFolder.cID
          Exit
        Endif
        oParent=oParent.oFolder
      Enddo
    Endif
    oParent=.Null.
  Endif
  If Empty(lcClass)
    lcClass=Lower(Alltrim(.Class))
  Endif
  If .nRecNo<=0
    Append Blank
    .nRecNo=Recno()
  Else
    If Not Between(.nRecNo,1,Reccount())
      Select (lnLastSelect)
      toNode.vResult=.F.
      Return toBrowser.vResult
    Endif
    Go .nRecNo
  Endif
  lcProperties=.cProperties
  If Atc("lFullPath=",lcProperties)>0
    brwPropertyStuff(@lcProperties,"lFullPath",Iif(.lFullPath,".T.",".F."), ;
      IIF(GETPEM(.Class,"lFullPath"),".T.",".F."),tlAutoAdd)
  Endif
  If .lView
    brwPropertyStuff(@lcProperties,"cContaining",.cContaining, ;
      GETPEM(.Class,"cContaining"),.T.)
    brwPropertyStuff(@lcProperties,"cLookIn",.cLookIn, ;
      GETPEM(.Class,"cLookIn"),.T.)
    brwPropertyStuff(@lcProperties,"cKeywordList",.cKeywordList, ;
      GETPEM(.Class,"cKeywordList"),.T.)
    brwPropertyStuff(@lcProperties,"lItemName",Iif(.lItemName,".T.",".F."), ;
      IIF(GETPEM(.Class,"lItemName"),".T.",".F."),.T.)
    brwPropertyStuff(@lcProperties,"lDescription",Iif(.lDescription,".T.",".F."), ;
      IIF(GETPEM(.Class,"lDescription"),".T.",".F."),.T.)
    brwPropertyStuff(@lcProperties,"lFileName",Iif(.lFileName,".T.",".F."), ;
      IIF(GETPEM(.Class,"lFileName"),".T.",".F."),.T.)
    brwPropertyStuff(@lcProperties,"lClassName",Iif(.lClassName,".T.",".F."), ;
      IIF(GETPEM(.Class,"lClassName"),".T.",".F."),.T.)
    brwPropertyStuff(@lcProperties,"lProperties",Iif(.lProperties,".T.",".F."), ;
      IIF(GETPEM(.Class,"lProperties"),".T.",".F."),.T.)
    brwPropertyStuff(@lcProperties,"cItemTypes",.cItemTypes, ;
      GETPEM(.Class,"cItemTypes"),.T.)
  Endif
  Select itemtypes
  Set Order To Class
  Locate
  Seek lcClass
  If Eof()
    Locate
    lcClauses=[ALL FOR ATC("="+lcClass+CR,ItemTypes)>0]
  Else
    lcClauses=[REST WHILE ALLTRIM(Class)==lcClass]
  Endif
  Scan &lcClauses
    lcProperty=Lower(Alltrim(Property))
    lnAtPos=At("[",lcProperty)
    If lnAtPos=0
      lnAtPos=At("(",lcProperty)
      If lnAtPos>0
        lcProperty=Strtran(Strtran(lcProperty,"(","["),")","]")
      Endif
    Endif
    lcProperty2=Iif(lnAtPos=0,lcProperty,Alltrim(Left(lcProperty,lnAtPos-1)))
    If Empty(lcProperty) Or Inlist(lcProperty+" ","cfilename ","cclass ","cpicture ", ;
        "cfolderpicture ","classlib ","classname ","itemclass ","cfoldertype ") Or ;
        NOT PEMSTATUS(toNode,lcProperty2,5)
      Loop
    Endif
    lvValue=Evaluate("toNode."+lcProperty)
    If Type("lvValue")=="U"
      Loop
    Endif
    If Type("lvValue")#"C"
      lvValue=Transform(lvValue)
    Endif
    lvDefaultValue=Iif(lcProperty==lcProperty2,Transform(GETPEM(.Class,lcProperty)),"")
    brwPropertyStuff(@lcProperties,lcProperty,lvValue,lvDefaultValue,.T.)
  Endscan
  Select (lcAlias)
  .tUpdated=Datetime()
  .cProperties=lcProperties
  If tlUpdateSource
    lnAtPos=At("!",.cParent)
    If lnAtPos>0
      .cParent=Alltrim(Substr(.cParent,lnAtPos+1))
    Endif
  Endif
  Replace Type With lcType, Id With toBrowser.ValidID(.cID), ;
    Link With .cLink, Parent With .cParent
  lcSourceCatalog=.cSourceCatalog
  If Empty(lcSourceCatalog)
    lcSourceCatalog=Lower(Dbf(lcAlias))
  Endif
  lcSourceCatalogPath=Iif(Empty(lcSourceCatalog),"",Justpath(lcSourceCatalog)+"\")
  lcSourceAlias=.cSourceAlias
  lcFileName=Alltrim(.cFileName)
  If Not Empty(lcFileName)
    If Left(lcFileName,2)=="\\" Or Not Substr(lcFileName,2,1)==":" Or ;
        LEFT(lcFileName,4)=="www."
      If Left(lcFileName,2)=="\\" And Not "."$lcFileName And ;
          NOT Right(lcFileName,1)=="\"
        lcFileName=lcFileName+"\"
      Endif
      lcFileName=Lower(Alltrim(lcFileName))
    Else
      lcFileName=Lower(Sys(2014,lcFileName,lcSourceCatalogPath))
    Endif
  Endif
  lcPicture=brwImagePictureFile(toBrowser,.cPicture,lcSourceCatalogPath)
  If Not Empty(.cFolderPicture) And Inlist(Lower(Justfname(.cFolderPicture)), ;
      "catalog.ico","openctlg.ico","folder.ico","openfldr.ico", ;
      "web_file.ico","web_site.ico","web_doc.ico","explorer.ico")
    lcFolderPicture=""
  Else
    lcFolderPicture=brwImagePictureFile(toBrowser,.cFolderPicture,lcSourceCatalogPath)
  Endif
  lcClassLib=.cClassLib
  If Not Empty(lcClassLib)
    lcClassLib=Lower(Sys(2014,lcClassLib,lcSourceCatalogPath))
  Endif
  If Type(".oRecord")=="O"
    lcValue=.oRecord.FileName
    If Left(lcValue,1)=="(" And Right(lcValue,1)==")"
      lvValue=Evaluate(Substr(lcValue,2,Len(lcValue)-2))
      If Lower(Justfname(lvValue))==Lower(Justfname(lcFileName))
        lcFileName=.oRecord.FileName
      Endif
    Endif
    lcValue=.oRecord.Picture
    If Left(lcValue,1)=="(" And Right(lcValue,1)==")"
      lvValue=Evaluate(Substr(lcValue,2,Len(lcValue)-2))
      If Lower(Justfname(lvValue))==Lower(Justfname(lcPicture))
        lcPicture=.oRecord.Picture
      Endif
    Endif
    lcValue=.oRecord.FolderPict
    If Left(lcValue,1)=="(" And Right(lcValue,1)==")"
      lvValue=Evaluate(Substr(lcValue,2,Len(lcValue)-2))
      If Lower(Justfname(lvValue))==Lower(Justfname(lcFolderPicture))
        lcFolderPicture=.oRecord.FolderPict
      Endif
    Endif
    lcValue=.oRecord.Classlib
    If Left(lcValue,1)=="(" And Right(lcValue,1)==")"
      lvValue=Evaluate(Substr(lcValue,2,Len(lcValue)-2))
      If Lower(Justfname(lvValue))==Lower(Justfname(lcClassLib))
        lcClassLib=.oRecord.Classlib
      Endif
    Endif
  Endif
  lcDesc=.cDesc
  If lcDesc==.cText Or lcDesc==Text
    lcDesc=""
  Endif
  Replace Text With .cText, TypeDesc With .cTypeDesc, Desc With lcDesc, ;
    Class With .cClass, Properties With lcProperties, Script With .cScript, ;
    ClassName With .cClassName, ItemClass With .cItemClass, ;
    ItemTpDesc With .cItemTpDesc, Views With .cViews, keywords With .cKeywords, ;
    Comment With .cComment, User With .cUser, FileName With lcFileName, ;
    Picture With lcPicture, FolderPict With lcFolderPicture, ;
    ClassLib With lcClassLib, Updated With .tUpdated
  oRecord=.Null.
  Scatter Memo Name oRecord
  .oRecord=oRecord
  If tlUpdateSource And Not Empty(.cSourceAlias) And Used(.cSourceAlias) And ;
      .nSourceRecNo>=0
    If Lower(.cSourceAlias)==lcAlias
      .nSourceRecNo=Recno()
      .cSourceAlias=lcSourceAlias
      .cSourceCatalog=Lower(Dbf(lcSourceAlias))
      .cSourceCatalogPath=Iif(Empty(.cCatalog),"",Justpath(.cCatalog)+"\")
      Replace SrcAlias With .cSourceAlias, SrcRecNo With .nSourceRecNo
    Else
      If .nSourceRecNo=0
        Select (.cSourceAlias)
        Append Blank
        .nSourceRecNo=Recno()
        Replace SrcRecNo With .nSourceRecNo
        Select (lcAlias)
        Replace SrcRecNo With .nSourceRecNo
      Endif
      oRecord=.Null.
      Scatter Memo Name oRecord
      Select (.cSourceAlias)
      Go .nSourceRecNo
      If .oHost.nViewType>1 And Not Empty(Id)
        oRecord.Id=Id
        oRecord.Parent=Parent
        oRecord.Link=Parent
      Endif
      Gather Memo Name oRecord
      If Empty(SrcAlias)
        .cSourceAlias=lcSourceAlias
        .cSourceCatalog=lcSourceCatalog
        .cSourceCatalogPath=Iif(Empty(.cSourceCatalog),"",Justpath(.cSourceCatalog)+"\")
        .nSourceRecNo=Recno()
      Endif
      Replace SrcAlias With .cSourceAlias, SrcRecNo With .nSourceRecNo
      Select (lcAlias)
      Replace SrcAlias With .cSourceAlias, SrcRecNo With .nSourceRecNo
      oRecord=.Null.
    Endif
  Else
    If Empty(SrcAlias)
      .cSourceAlias=lcSourceAlias
      .cSourceCatalog=Lower(Dbf(lcSourceAlias))
      .cSourceCatalogPath=Iif(Empty(.cCatalog),"",Justpath(.cCatalog)+"\")
      Replace SrcAlias With .cSourceAlias, SrcRecNo With .nSourceRecNo
    Endif
  Endif
Endwith
Select (lnLastSelect)
_Mline=lnLastMLine
Endfunc



Function brwImagePictureFile(toBrowser,tcFileName,tcCatalogPath)
Local lcFileName,lcPictureFile

If Empty(tcFileName)
  Return ""
Endif
lcFileName=Lower(Alltrim(tcFileName))
lcPictureFile=Justfname(lcFileName)
If Ascan(toBrowser.aImageList,lcPictureFile)>0 And ;
    ASCAN(toBrowser.aSmallImages,lcPictureFile)>0
  lcFileName=lcPictureFile
Else
  If Not Empty(tcCatalogPath) And Not "\\"$lcFileName
    lcFileName=Lower(Sys(2014,lcFileName,tcCatalogPath))
  Endif
Endif
Return lcFileName
Endfunc



Function brwScaleResize(toBrowser)
Local lnHeight,lnWidth,lnMaxHeight,lnMaxWidth,llWebBrowserVisible

With toBrowser
  lnHeight=.Height-.nLastHeight
  lnWidth=.Width-.nLastWidth
  lnMaxHeight=toBrowser.Height-2
  lnMaxWidth=toBrowser.Width-1
  If (lnHeight=0 And lnWidth=0) Or Type("toBrowser.cmdOpen")#"O" Or ;
      (.lOutlineOCX And Type("toBrowser.oleClassList")#"O")
    .nLastHeight=.Height
    .nLastWidth=.Width
    .vResult=.F.
    Return .vResult
  Endif
  .LockScreen=.T.
  If .lInitialized And Not .lRefreshBrowserMode
    If .lOutlineOCX
      If .lBrowser
        .oleClassList.Enabled=.F.
        .oleClassList.Visible=.F.
        .oleMembers.Enabled=.F.
        .oleMembers.Visible=.F.
      Else
        .oleFolderList.Enabled=.F.
        .oleFolderList.Visible=.F.
        .oleItems.Visible=.F.
        If .lWebBrowser
          llWebBrowserVisible=.oleWebBrowser.Visible
          .oleWebBrowser.stop
          .oleWebBrowser.Visible=.F.
        Endif
      Endif
    Endif
  Endif
  If lnHeight#0
    .txtClassList3D.Height=Max(.txtClassList3D.Height+lnHeight,0)
    .txtMembers3D.Height=.txtClassList3D.Height
    If .lOutlineOCX
      .oleClassList.Height=Max(.oleClassList.Height+lnHeight,0)
      .oleMembers.Height=.oleClassList.Height
      .oleFolderList.Height=Max(.oleFolderList.Height+lnHeight,0)
      .oleItems.Height=.oleFolderList.Height+2
      If .lWebBrowser
        .oleWebBrowser.Height=.oleFolderList.Height
      Endif
      .edtItemDesc.Top=Max(.edtItemDesc.Top+lnHeight,0)
      .edtItemDesc.Height=Max(lnMaxHeight-.edtItemDesc.Top,0)
    Else
      .lstClassList.Height=.txtClassList3D.Height
      .lstMembers.Height=.txtMembers3D.Height
    Endif
    .edtClassDesc.Top=Max(.edtClassDesc.Top+lnHeight,0)
    .edtClassDesc.Height=Max(lnMaxHeight-.edtClassDesc.Top,0)
    .edtMemberDesc.Top=.edtClassDesc.Top
    .edtMemberDesc.Height=.edtClassDesc.Height
    .MinHeight=Iif(.lBrowser,.edtClassDesc.Height,.edtItemDesc.Height)+.nMinHeightOffset
    If .lBrowser
      .shpSplitterV.Height=Max(lnMaxHeight-.shpSplitterV.Top,0)
      .shpSplitterH.Top=.edtClassDesc.Top-4
    Else
      .shpSplitterV.Height=.oleFolderList.Height
      .shpSplitterH.Top=.edtItemDesc.Top-4
    Endif
  Endif
  If lnWidth#0
    .txtMembers3D.Width=Max(lnMaxWidth-.txtMembers3D.Left,0)
    If .lOutlineOCX
      .oleMembers.Width=Max(lnMaxWidth-.oleMembers.Left,0)
      .oleItems.Width=Max(lnMaxWidth-.oleItems.Left,0)
      If .lWebBrowser
        .oleWebBrowser.Width=.oleItems.Width
      Endif
      .edtMemberDesc.Width=.oleMembers.Width
      .edtItemDesc.Width=Max(lnMaxWidth-.edtItemDesc.Left,0)
      .shpSplitterV.Left=Iif(.lBrowser,.oleMembers.Left,.oleItems.Left)-4
    Else
      .lstMembers.Width=Max(lnMaxWidth-.lstMembers.Left,0)
      .edtMemberDesc.Width=.lstMembers.Width
      .shpSplitterV.Left=.lstMembers.Left-4
    Endif
    .shpSplitterH.Width=Max(lnMaxWidth-.shpSplitterH.Left,0)
  Endif
  .Cls
  .LockScreen=.F.
  If .lInitialized And Not .lRefreshBrowserMode
    If .lOutlineOCX
      .oleClassList.Enabled=.T.
      .oleClassList.Visible=.lBrowser
      .oleMembers.Enabled=.T.
      .oleMembers.Visible=.lBrowser
      .oleFolderList.Enabled=.T.
      .oleFolderList.Visible=(Not .lBrowser)
      .oleItems.Visible=(Not .lBrowser And Not .lWebView)
      If .lWebBrowser
        .oleWebBrowser.Visible=llWebBrowserVisible
      Endif
    Endif
  Endif
  .nLastHeight=.Height
  .nLastWidth=.Width
  If .lInitialized
    .SavePreferences
  Endif
Endwith
Endfunc



Function brwFind(toBrowser,tcFind)
Local llCancel,oFind2Form,llEditMode,lcViewType,oLastView,lnLastSelect

If toBrowser.lBrowser
  toBrowser.vResult=toBrowser.FindClass(tcFind)
  Return toBrowser.vResult
Endif
If toBrowser.AddInMethod("FIND")
  Return
Endif
If toBrowser.nFolderCount=0
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set Message To M_LOADING_LOC+" "+M_FIND_LOC+" ..."
oLastView=toBrowser.oView
llEditMode=(Not Isnull(toBrowser.oView) And toBrowser.oView.lEditMode)
lnLastSelect=Select()
toBrowser.lModalDialog=.T.
Do Form brwfind2 Name oFind2Form With (toBrowser) To llCancel
Set DataSession To toBrowser.DataSessionId
Select (lnLastSelect)
Set Message To
If llEditMode
  Return
Endif
With toBrowser
  If llCancel Or Vartype(.oView)#"O" Or Empty(.oView.cText)
    If Vartype(oLastView)=="O"
      If Vartype(.oView)=="O" And .oView#oLastView
        .oView.Release
      Endif
      .oView=oLastView
    Endif
    .vResult=.F.
    Return .vResult
  Endif
  lcViewType=Proper(.oView.cText)
  .nViewType=-1
  .lSwitchViewMode=.T.
  .lRefreshBrowserMode=.T.
  .cboViewType.DisplayValue=lcViewType
  .lRefreshBrowserMode=.F.
  .RefreshBrowser
  .lSwitchViewMode=.F.
  If Vartype(.oView)=="O"
    .oView.Release
  Endif
  .oView=.GetView(lcViewType)
Endwith
Endfunc



Function brwOptions(toBrowser)
Local oOptionsForm,oNewCatalogs,llApply,lnLastSelect,lnCount

If toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If toBrowser.AddInMethod("OPTIONS")
  Return
Endif
Set Message To M_LOADING_LOC+" "+M_OPTIONS_LOC+" ..."
lnLastSelect=Select()
oNewCatalogs=Createobject("Custom")
oNewCatalogs.AddProperty("nNewCatalogCount",0)
oNewCatalogs.AddProperty("aNewCatalogs[1]","")
toBrowser.lModalDialog=.T.
Do Form brwoptns Name oOptionsForm With (toBrowser),(oNewCatalogs) To llApply
Set DataSession To toBrowser.DataSessionId
Select (lnLastSelect)
Set Message To
If Isnull(llApply) And oNewCatalogs.nNewCatalogCount=0
  Return
Endif
toBrowser.SavePreferences(,.T.)
If oNewCatalogs.nNewCatalogCount>0
  llApply=.T.
  For lnCount = 1 To oNewCatalogs.nNewCatalogCount
    toBrowser.AddFile(oNewCatalogs.aNewCatalogs[lnCount],.T.)
  Endfor
Endif
If llApply
  toBrowser.RefreshBrowser
Endif
Endfunc



Function brwProperties(toBrowser,tvNode)
Local oNode,oPropertiesForm,llApply,lnLastSelect

If toBrowser.lBrowser
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If toBrowser.AddInMethod("PROPERTIES")
  Return
Endif
oNode=Iif(Type("tvNode")#"O" Or Isnull(tvNode),toBrowser.oItemSource,tvNode)
If Type("oNode")#"O" Or Isnull(oNode)
  oNode=.Null.
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set Message To M_LOADING_LOC+" "+M_PROPERTIES_LOC+" ..."
lnLastSelect=Select()
toBrowser.lModalDialog=.T.
Do Form brwprops Name oPropertiesForm With (toBrowser),(oNode) To llApply
Set DataSession To toBrowser.DataSessionId
Select (lnLastSelect)
Set Message To
If Isnull(llApply)
  Return
Endif
If llApply
  oNode.WriteProperties(.T.,.T.)
Endif
oNode.Refresh
Endfunc



Function brwKeywords(toBrowser)
Local oKeywordsForm,lcKeywords,lnLastSelect

If toBrowser.lBrowser
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
If toBrowser.AddInMethod("KEYWORDS")
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
Set Message To M_LOADING_LOC+" "+M_KEYWORDS_LOC+" ..."
lnLastSelect=Select()
toBrowser.lModalDialog=.T.
Do Form brwkywrd Name oKeywordsForm With (toBrowser) To lcKeywords
Set DataSession To toBrowser.DataSessionId
Select (lnLastSelect)
Set Message To
If Isnull(lcKeywords) Or Empty(lcKeywords)
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
toBrowser.vResult=lcKeywords
Return toBrowser.vResult
Endfunc



Function brwGetFileAddress(toBrowser,tlShellExecute,tcFileExt)
Local oGetAddressForm,lcAddress,lcFileName

If toBrowser.AddInMethod("GETADDRESS")
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
lcFileName=Lower(Home()+"ffc\openadlg.scx")
If Not File(lcFileName)
  Set Message To
  toBrowser.MsgBox(M_FILE_LOC+[ "]+lcFileName+[" ]+M_DOES_NOT_EXIST_LOC+[.],16)
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
Set Message To M_LOADING_LOC+" "+M_ADDRESSES_LOC+" ..."
toBrowser.lModalDialog=.T.
Do Form (lcFileName) Name oAddressForm With (tlShellExecute),(tcFileExt) To lcAddress
Set DataSession To toBrowser.DataSessionId
Set Message To
If Isnull(lcAddress)
  Return
Endif
toBrowser.vResult=lcAddress
Return toBrowser.vResult
Endfunc



Function brwHelp(toBrowser)
Local lcFileName

If toBrowser.AddInMethod("HELP")
  Return
Endif
Set Message To M_LOADING_LOC+" "+M_HELP_LOC+" ..."
Help Id (toBrowser.HelpContextID) Nowait
Set Message To
Endfunc



Function brwCleanupCatalog(toNode,tlNoRefresh,tlIgnoreErrors)
Local toBrowser,lcCatalog,lcAlias,lnRecNo,lcFilter,lnLastSelect,llMatch
Local lcSortTable,lcSortTable2,lcID,lcParent,lcText,llIgnoreErrors

toBrowser=toNode.oHost
If Vartype(toBrowser)#"O"
  Return .F.
Endif
Set DataSession To (toBrowser.DataSessionId)
If Not toNode.lCatalog
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcCatalog=toNode.cSourceCatalog
lcAlias=toNode.cSourceAlias
If Empty(lcCatalog) Or Empty(lcAlias) Or ;
    NOT Lower(Justext(lcCatalog))=="dbf" Or Not File(lcCatalog)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lnLastSelect=Select()
Select (lcAlias)
lcFilter=Set("FILTER")
llIgnoreErrors=toBrowser.lIgnoreErrors
toBrowser.lIgnoreErrors=.T.
Use (lcCatalog) Exclusive Alias (lcAlias)
toBrowser.lIgnoreErrors=llIgnoreErrors
If Not Used()
  Use (lcCatalog) Again Shared Alias (lcAlias)
  If Not Empty(lcFilter)
    Set Filter To &lcFilter
  Endif
  Locate
  Select (lnLastSelect)
  If Not tlIgnoreErrors And Not toBrowser.lRelease
    toBrowser.MsgBox(M_UNABLE_TO_OPEN_LOC+[ "]+lcCatalog+[" ]+ ;
      M_EXCLUSIVELY_LOC+[.],16)
  Endif
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Scan All For Not Empty(Type) And Not Empty(Parent) And Not "!"$Parent
  lnRecNo=Recno()
  lcParent=Lower(Alltrim(Parent))
  Locate For Lower(Alltrim(Id))==lcParent Or ;
    LOWER(Alltrim(Id))==Lower(Alltrim(Parent))
  If Eof()
    Go lnRecNo
    Delete
    Loop
  Endif
  Go lnRecNo
Endscan
If Not tlNoRefresh
  Set Message To M_PACKING_FILE_LOC+[ "]+toNode.cCatalog+[" ...]
Endif
Pack
If toNode.cCatalog==toBrowser.cDefaultCatalog Or Not toNode.lSortOnCleanup
  Use (lcCatalog) Again Shared Alias (lcAlias)
  If Not Empty(lcFilter)
    Set Filter To &lcFilter
  Endif
Else
  lcSortTable=Lower(Sys(2023)+"\"+Sys(2015))
  lcSortTable2=Lower(Sys(2023)+"\"+Sys(2015))
  Sort To (lcSortTable) On Type
  Use (lcSortTable) Exclusive Alias (lcAlias)
  Index On Lower(Type+Text) Tag Type
  Set Filter To Not Upper(Alltrim(Type))=="FOLDER" Or ;
    EMPTY(Id) Or "!"$Parent
  Copy To (lcCatalog)
  Delete All
  Pack
  Set Filter To Not Deleted()
  Locate
  Do While .T.
    llMatch=.F.
    Scan All
      lcText=Lower(Text)
      If Empty(lcText)
        Loop
      Endif
      lnRecNo=Recno()
      lcID=Lower(Alltrim(Id))
      Set Order To
      Locate For Lower(Alltrim(Parent))==lcID And Lower(Text)<lcText
      If Not Eof()
        Scan All For Lower(Alltrim(Parent))==lcID
          llMatch=.T.
          Replace Text With Chr(255)+Text
        Endscan
      Endif
      Set Order To Type
      Go lnRecNo
    Endscan
    If Not llMatch
      Exit
    Endif
  Enddo
  Copy To (lcSortTable2)
  Use (lcCatalog) Again Shared Alias (lcAlias)
  Append From (lcSortTable2)
  Replace All Text With Strtran(Text,Chr(255),"") For Chr(255)$Text
  If Not Empty(lcFilter)
    Set Filter To &lcFilter
  Endif
  Erase (lcSortTable+".dbf")
  Erase (lcSortTable+".fpt")
  Erase (lcSortTable+".cdx")
  Erase (lcSortTable2+".dbf")
  Erase (lcSortTable2+".fpt")
  Erase (lcSortTable2+".cdx")
Endif
Replace All SrcAlias With Lower(Alias()), SrcRecNo With Recno()
Locate
Select (lnLastSelect)
If Not tlNoRefresh
  Set Message To
  toNode.Refresh
Endif
Endfunc



Function brwBackupCatalog(toNode,tlRestore,tcFileName)
Local toBrowser,lcFileName,lcPath,lcCatalog,lcAlias,lcFilter,lnLastSelect

toBrowser=toNode.oHost
If Vartype(toBrowser)#"O"
  Return .F.
Endif
Set DataSession To (toBrowser.DataSessionId)
If Not toNode.lCatalog
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lcCatalog=toNode.cSourceCatalog
lcAlias=toNode.cSourceAlias
If Empty(lcCatalog) Or Empty(lcAlias) Or ;
    NOT Lower(Justext(lcCatalog))=="dbf" Or Not File(lcCatalog)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Empty(tcFileName)
  lcPath=Justpath(lcCatalog)+"\backup\"
  lcFileName=lcPath+Justfname(lcCatalog)
Else
  lcFileName=Lower(Fullpath(Alltrim(tcFileName)))
  lcPath=Justpath(lcFileName)+"\"
Endif
If toBrowser.MsgBox(Iif(tlRestore,M_RESTORE_LOC,M_BACKUP_LOC)+ ;
    [ ]+Lower(M_CATALOG_LOC)+[ "]+lcFileName+["?],292)#6
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Not File(lcFileName)
  llIgnoreErrors=toBrowser.lIgnoreErrors
  toBrowser.lIgnoreErrors=.T.
  Md (lcPath)
  toBrowser.lIgnoreErrors=llIgnoreErrors
Endif
If tlRestore And Not File(lcFileName)
  toBrowser.MsgBox(M_FILE_LOC+[ "]+lcFileName+[" ]+M_NOT_FOUND_LOC+[.],16)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
lnLastSelect=Select()
Select (lcAlias)
lcFilter=Set("FILTER")
Set Filter To
If Not tlRestore
  Set Message To M_RESTORING_FILE_LOC+[ "]+toNode.cCatalog+[" ...]
  Copy To (lcFileName)
  If Not Empty(lcFilter)
    Set Filter To &lcFilter
  Endif
  Locate
  Select (lnLastSelect)
  Set Message To
  toBrowser.MsgBox(["]+lcFileName+[" ]+M_SUCCESSFULLY_CREATED_LOC+[.])
  Return
Endif
llIgnoreErrors=toBrowser.lIgnoreErrors
toBrowser.lIgnoreErrors=.T.
Use (lcCatalog) Exclusive Alias (lcAlias)
toBrowser.lIgnoreErrors=llIgnoreErrors
If Not Used()
  Use (lcCatalog) Again Shared Alias (lcAlias)
  If Not Empty(lcFilter)
    Set Filter To &lcFilter
  Endif
  Locate
  Select (lnLastSelect)
  If Not toBrowser.lRelease
    toBrowser.MsgBox(M_UNABLE_TO_OPEN_LOC+[ "]+lcCatalog+[" ]+ ;
      M_EXCLUSIVELY_LOC+[.],16)
  Endif
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
Set Message To M_BACKING_UP_FILE_LOC+[ "]+toNode.cCatalog+[" ...]
Zap
Append From (lcFileName)
Use (lcCatalog) Again Shared Alias (lcAlias)
If Not Empty(lcFilter)
  Set Filter To &lcFilter
Endif
Locate
Select (lnLastSelect)
Set Message To
toNode.Refresh
Endfunc



Function brwPropertyStuff(tcProperties,tcProperty,tcValue,tcDefaultValue,tlAutoAdd)
Local lcProperty,lcValue,lcDefaultValue,lcProperty2,lcOldProperties,lcNewProperties
Local lcMemLine,lnCount,lnAtPos,llMatch

If Empty(tcProperty)
  Return .F.
Endif
lcProperty=Alltrim(tcProperty)
lcValue=Iif(Empty(tcValue),"",Alltrim(tcValue))
lcDefaultValue=Iif(Empty(tcDefaultValue),"",Alltrim(tcDefaultValue))
lcNewProperties=""
llMatch=.F.
_Mline=0
For lnCount = 1 To Memlines(tcProperties)
  lcMemLine=Mline(tcProperties,1,_Mline)
  If Empty(lcMemLine)
    Loop
  Endif
  lnAtPos=At("=",lcMemLine)
  If lnAtPos>0
    lcProperty2=Alltrim(Left(lcMemLine,lnAtPos-1))
    If Lower(lcProperty)==Lower(lcProperty2)
      If llMatch
        Loop
      Endif
      llMatch=.T.
      If Empty(lcValue) Or lcValue==lcDefaultValue
        Loop
      Endif
      lcMemLine=lcProperty2+"="+lcValue
    Endif
  Endif
  lcNewProperties=lcNewProperties+lcMemLine+CR_LF
Endfor
If tlAutoAdd And Not llMatch And Not Empty(lcValue) And Not lcValue==lcDefaultValue
  lcNewProperties=lcNewProperties+lcProperty+"="+lcValue
Endif
If Right(lcNewProperties,2)==CR_LF
  lcNewProperties=Alltrim(Left(lcNewProperties,Len(lcNewProperties)-2))
Endif
tcProperties=lcNewProperties
Return tcProperties
Endfunc



Function brwHitTest(toBrowser,oControl,x,Y)
Local oNode,oItem,llFolder,lnXFactor,lnYFactor

llFolder=(Lower(oControl.Name)=="olefolderlist")
lnXFactor=1440/96*(13/Fontmetric(1,"MS Sans Serif",8,""))
lnYFactor=1440/96*(11/Fontmetric(7,"MS Sans Serif",8,""))
oNode=oControl.HitTest(x*lnXFactor,Y*lnYFactor)
If Type("oNode")#"O" Or Isnull(oNode)
  oNode=.Null.
  If Not llFolder
    oNode=toBrowser.oFolder
  Endif
  toBrowser.vResult=oNode
  Return oNode
Endif
oItem=toBrowser.GetItem(oNode)
toBrowser.vResult=oItem
Return oItem
Endfunc


Function brwExportClass(toBrowser,tlShow,tcExportToFile)
Local lcExportToFile,lcCode,lcInsertCode,lcAppendCode,lcDefineClass,llHTML
Local lcClass,lcParentClass,lcBaseClass,lcObjectClass,lcObjectBaseClass,lcParent
Local lcClassLoc,lcProperties,lcAddObject,lcInsertDefineCode,lcAppendDefineCode,llSCXMode
Local lcFileName,lcFileName2,lnClassCount,lnListIndex,lcFilter,lcViewCodeFileName
Local llFileMode,lnClassLibCount,laClassLib,lnRecNo,lcCRLF3,lcCRLF4,lcMemberType
Local lcMember,lcMember2,lcMemberDesc,lnMemberCount,laMembers,laMemberDesc,lcTimeStamp
Local lnProtectedCount,laProtected,lnAtPos,lnElement,lcComment,lnLastSelect
Local lcVarName,lcArrayInfo,lcBorder,lnCount,llHidden,lcMethods,lcMethods2,lcSearchStr
LOCAL lcFullParent

* 06/10/2005 Also working SCX Dataenvironment is generated if there is one to the viewcode
*
* 03/26/2004 Added support to multilevel containers and methods
*
* Original Browser.prg code is from VFP9 SP1
*
* 0 = Old MS way. Doesn't support controls in container which is inside of another container
*     No dataenvironment support.
*
*     NEW MODES 2, 3, 4 and 5
*     Controls in container are supported. 
*     Methods are supported.
*     ActiveX:s are suported (Imagelist is still problem child)
*     Dataenvironment is supported
*     Right mouse click works also with all new modes.
*     Few bugs fixed (see the following code)
*
* 2 = If class contains controls OR method code (VFP base or subclassed), 
*     or even noe method or subcontrols it is always subclassed.
*     Properties and method codes are added to the 
*     DEFINE CLASS...ENDDEFINE. All subcontrols are also subclasses
*     Controls that cannot be defined WITH ADD OBJECT are defined 
*     PARENT OBJECT m.lcInitName method. 
*     m.lcInitName is usually "init" (these bad behaving objects are 
*     Pageframes (Pages) and grids (columns and headers). These objects
*     are defined in m.lcAddInitContainers.
*     Mode 2 is launched when Ctrl is down and "view class code" button
*     is clicked.
* 3 = Same as 2 but Controls that cannot be defined WITH ADD OBJECT are defined 
*     between oForm1.NEWOBJECT - oForm1.SHOW()
*     Mode 3 is launched when Shift + Ctrl is down and "view class code" button
*     is clicked.
* 
*     14/02/2006 modes 4 and 5 redefined.
*
* 4 = If class contains controls OR method code (VFP base or subclass), 
*     it is subclassed. Method code is added to the DEFINE CLASS...ENDDEFINE
*     All controsl are subclasses except those which haven't methods or 
*     subcontrols (empty containers). Controls that cannot be defined 
*     WITH ADD OBJECT are defined PARENT OBJECT m.lcInitName method
*     m.lcInitName is usually "init" (these bad behaving objects are 
*     Pageframes (Pages) and grids (columns and headers). These objects
*     are defined in m.lcAddInitContainers.
*     Mode 4 is launched when Alt is down and "view class code" button
*     is clicked.
* 5 = Same as 4 but Controls that cannot be defined WITH ADD OBJECT are defined 
*     between oForm1.NEWOBJECT - oForm1.SHOW()
*     Mode5 is launched when Shift + ALt is down and "view class code" button
*     is clicked.
*
* 06/18/2005 Now HOME() is used in SET CLASSLIB TO when possible -> better support for 
* running code in different PCs
*
*Problems:
* CLSID value can be red now from OLE field (Thanks to Sergey Berezniker). Final obstacle is to 
* find pointer which shows which is the offset to that CLSID value. I'v found so far 4 differnt offsets. 
* CLSID is needed to find OleClass value (like MSComctlLib.ListViewCtrl.2 ) from the registry.

*oMyForm.AddObject("oleListview","olecontrol", ;
   "MSComctlLib.ListViewCtrl.2")

* 02/14/2006 CLSID PROBLEM SOLVED !!!! And OleClass value is red from the Registry
* Long time it took but I enjoyed of this challenge.
* Two FUnctions added to get it work
* Function ReadOleClass(nType)
* Function Read_ProgID(lcCLSID,lcProgID)

* Imagelist problem
* At the moment (don't have a tool to decrypt OLE field from the SCX file)
* there is no way to read Imagelist Image properties so it must be added manually after the viewcode
* is generated. Add it f.ex to Imagelist INIT procedure
* If you don't do it you will get an 
* OLE IDispatch exception code 0 from TreeCtrl: ImageList must be initialized before it can be used..
* error. 
*
* If you have a clue all real working solution how to decrypt OLE field, it would be a great thing
* to add here.
*
* NEXT A SAMPLE how to avoid above error:
*
*   **************************************************
*   *-- Olecontrol:      oleimages (d:\program files\microsoft visual foxpro 9\samples\solution\solution.scx)
*   *-- ParentClass:     olecontrol
*   *-- BaseClass:       olecontrol
*   *-- Time Stamp:      03/16/98 06:49:11 PM
*   *-- OLEObject = C:\WINDOWS\system32\mscomctl.ocx
*
*   DEFINE CLASS olecontrol_L3_C2_TC38 AS olecontrol
*  
*  
*    	Top = 136
*    	Left = 347
*       Height = 100
*       Width = 100
*   	Name = "oleImages"
*   	OleClass = "MSComctlLib.ImageListCtrl.2"
*   	Visible = .T.
*   
*   	PROCEDURE INIT
*   	
*         THIS.OBJECT.ListImages.ADD(1,"cmd",LOADPICTURE(home()+;
*            "\samples\solution\pscmd.bmp"))
*         THIS.OBJECT.ListImages.ADD(2,"chk",LOADPICTURE(home()+;
*            "\samples\solution\pscheck.bmp"))
*         THIS.OBJECT.ListImages.ADD(3,"ole",LOADPICTURE(home()+;
*            "\samples\solution\psole.bmp"))
*         THIS.OBJECT.ListImages.ADD(4,"world",LOADPICTURE(home()+;
*            "\samples\solution\connectn.bmp"))
*         THIS.OBJECT.ListImages.ADD(5,"api",LOADPICTURE(home()+;
*            "\samples\solution\apilibra.bmp"))
*         THIS.OBJECT.ListImages.ADD(6,"app",LOADPICTURE(home()+;
*            "\samples\solution\apps.bmp"))
*         THIS.OBJECT.ListImages.ADD(7,"db",LOADPICTURE(home()+;
*            "\samples\solution\database.bmp"))
*         THIS.OBJECT.ListImages.ADD(8,"frm",LOADPICTURE(home()+;
*            "\samples\solution\forms.bmp"))
*         THIS.OBJECT.ListImages.ADD(9,"idx",LOADPICTURE(home()+;
*            "\samples\solution\indexes.bmp"))
*         THIS.OBJECT.ListImages.ADD(10,"dot",LOADPICTURE(home()+;
*            "\samples\solution\leaf.bmp"))
*         THIS.OBJECT.ListImages.ADD(11,"menu",LOADPICTURE(home()+;
*            "\samples\solution\menu.bmp"))
*         THIS.OBJECT.ListImages.ADD(12,"cbo",LOADPICTURE(home()+;
*            "\samples\solution\psdropdn.bmp"))
*         THIS.OBJECT.ListImages.ADD(13,"edt",LOADPICTURE(home()+;
*            "\samples\solution\pseditbx.bmp"))
*         THIS.OBJECT.ListImages.ADD(14,"grd",LOADPICTURE(home()+;
*            "\samples\solution\psgrid.bmp"))
*         THIS.OBJECT.ListImages.ADD(15,"lst",LOADPICTURE(home()+;
*            "\samples\solution\pslistbx.bmp"))
*         THIS.OBJECT.ListImages.ADD(16,"pgf",LOADPICTURE(home()+;
*            "\samples\solution\pspgfr.bmp"))
*         THIS.OBJECT.ListImages.ADD(17,"opt",LOADPICTURE(home()+;
*            "\samples\solution\psradio.bmp"))
*         THIS.OBJECT.ListImages.ADD(18,"spn",LOADPICTURE(home()+;
*            "\samples\solution\psspin.bmp"))
*         THIS.OBJECT.ListImages.ADD(19,"tmr",LOADPICTURE(home()+;
*            "\samples\solution\pstimer.bmp"))
*         THIS.OBJECT.ListImages.ADD(20,"txt",LOADPICTURE(home()+;
*            "\samples\solution\pstxtbx.bmp"))
*         THIS.OBJECT.ListImages.ADD(21,"frs",LOADPICTURE(home()+;
*            "\samples\solution\query.bmp"))
*         THIS.OBJECT.ListImages.ADD(22,"frx",LOADPICTURE(home()+;
*            "\samples\solution\report.bmp"))
*         THIS.OBJECT.ListImages.ADD(23,"dbf",LOADPICTURE(home()+;
*            "\samples\solution\table.bmp"))
*         THIS.OBJECT.ListImages.ADD(24,"tbr",LOADPICTURE(home()+;
*            "\samples\solution\toolbar2.bmp"))
*         THIS.OBJECT.ListImages.ADD(25,"qpr",LOADPICTURE(home()+;
*            "\samples\solution\query.bmp"))
*   
*   	ENDPROC
*   
*   
*   ENDDEFINE
*   *
*   *-- EndDefine: oleimages


*!* Old modes 4 and 5 are cancelled and explained next. New modes 4 and 5 work and explained above
*!* 06/08/2005 Arto Toikka Modes 4 and 5 cancelled because then user defined code
*!* should seriously modified byt this program -> a mess
* 4 = Controls in container is supported. Methods are supported too.
*     If class contains controls OR method code (VFP base or subclassed), it is subclassed.
*     Method code is added after ADD OBJECT in PROCEDURES
*     Controls that cannot be defined WITH ADD OBJECT are defined PARENT OBJECT m.lcInitName method
*     m.lcInitName is usually "init"
*     Mode 4 is done when Alt is downd and mouse is clicked
* 5 = Same as 4 but 2 but Controls that cannot be defined WITH ADD OBJECT are defined 
*     between oForm1.NEWOBJECT - oForm1.SHOW()
*     Mode 5 is done when Shift + Alt is downd and mouse is clicked

*!* Next is a example why modes 4 and 5 are not workable
*!* Look for the PROCEDURE Container1.click
*!* You cannot set object references with mode 4 or 5
*!* without that browser.prg seriously modifies user defined method/event codes 
*!* it would be a mess.

*!* * _co1.prg Mode 4 or 5
*!* 
*!* PUBLIC oform1
*!* 
*!* oform1=NEWOBJECT("form1")
*!* 
*!* oform1.Show
*!* RETURN
*!* 
*!* **************************************************
*!* *-- Form:         form1 (d:\program files\microsoft visual foxpro 9\browserfix\co1.scx)
*!* *-- ParentClass:  form
*!* *-- BaseClass:    form
*!* *-- Time Stamp:   06/08/05 02:41:04 PM
*!* *
*!* DEFINE CLASS form1 AS form
*!* 
*!*   Top = 0
*!*   Left = 0
*!*   Height = 595
*!*   Width = 654
*!*   DoCreate = .T.
*!*   ShowTips = .T.
*!*   Caption = "Form1"
*!*   Name = "form1"
*!*   testpropertynormal = .F.
*!*   AAA = "Form AAA"
*!* 
*!*   ADD OBJECT container1 AS container WITH ;
*!*     Top = 96
*!*     Left = 72
*!*     Width = 216
*!*     Height = 168
*!*     Name = "cont1_Container1"
*!*     AAA = "Container AAA"
*!* 
*!*   PROCEDURE Init
*!*     * This is form Init"
*!*     DODEFAULT()
*!*   ENDPROC
*!* 
*!*   PROCEDURE Click
*!*     MESSAGEBOX("Whoo, I'm Mr Form")
*!*   ENDPROC
*!* 
*!*   PROCEDURE Container1.Click
*!*     MESSAGEBOX("Whoo, I'm Mr Container1")
*!*     ?This.Name  && Container1
*!*     ?This.Parent.Name  && "cont1_Container1"
*!*     ?This.AAA  && Error
*!*     ?This.Parent.AAA  && "Container AAA
*!*     
*!*     ?This.Parent.Parent.Name  && Error
*!*     ?This.Parent.Parent.AAA  && Error
*!*   ENDPROC
*!* 
*!* ENDDEFINE
*!* *
*!* *-- EndDefine: form1
*!* **************************************************

Local lnAppType

* nShiftAltCtrl  Modifier key  
* 1              SHIFT
* 2              CTRL
* 4              ALT

* m.lnAppType = IIF(toBrowser.nShift==2,1,IIF(toBrowser.nShift==4,2,0))

* m.lnAppType = IIF(INLIST(toBrowser.nShift,2,3,4,5) AND toBrowser.lSCXMode,toBrowser.nShift,0)
m.lnAppType = IIF(INLIST(toBrowser.nShift,2,3,4,5),toBrowser.nShift,0)

* 06/08/2005 Arto Toikka Instead of cancelling modes 4 and 5, they are changed now
* Mode 4 same as mode 2 but if control has no methods or subcontrols its properties are 
* defined in ADD OBJECT cProperty AS cProertyBaseName WITH 
* Mode 5 same as mode 3 but even if control has no methods or subcontrols it is subclassed
* and its properties are defined in subclass. 

If m.lnAppType > 0
  Local llIncludeDefined, lcIncludeCode
  Local lcTmpControlCur, lcTmpGroupCur
  Local lnDataenvOK, lcDataEnvName, lcDEClasses
  Local lcTopMost, lcParentName, lcObjName
  Local lnControlCount, llEndDefine
  Local lnContainerLevel, lnControlNumber, laParents(1,3), lnTotalControlCount
  Local llBranchOK, laControlOk(1,2), lnMetadrecn
  Local laParentDaughterCheck(1), llCyclicClassDefinition
  Local lnaParentsRow
  Local lcInsertInitCode, laMethodLines(1), llInitExist, lcAddInitContainers, ;
        lcInitName, lcBranchContainer, lcContainerParent
  Local lcParentContainers, lcPreviousControl, lcPreviousContainer
  Local lcInsertAddObjCode, lcMyObjRef
  Local llDefiningGrid, llAddGirdtoInitNow, llFirstGridObj, lcRemoveObjText1
  Local llDefiningPageFrame, llSavePageFrameSubsNow, llFirstPGFObj
  Local laContainers(1,2), lcAO_ParentClass
  Local lcParentColumn
  Local lcAddQuotationsProps
  Local lcExtraCareProps, llCheckExtraCareProps
  Local laParentProps(1), laAddParentProps(1,2), lcInsertRestiveProps
  Local llPropsInDEFINE_CLASS
  Local lni1, lni2, lni3, lni4, lcTmpString1, lcTmpString2, lcTmpString3, lnAscanValue
  Local lcOleClass, lcOleClassValue, lcAddMethodsCode

  m.llIncludeDefined = .F.      && Is include File code line generated
  m.lcIncludeCode = ""          && Content of the INCLUDE code line

  m.lcTmpGroupCur = "_TmpGroup" && Container + its coltrols
  m.lcTmpControlCur = "_TmpControls" && For control count in container
  m.lnDataenvOK = 0 && Is dataenvironment generated
  m.lcDataEnvName = "cDataenvironment"  && Name for the dataenvironment
  m.lcDEClasses = ",dataenvironment,cursor,cursoradapter,relation,"  && DE memebers
  m.lcTopMost = ""  && Top most container ObjName
  m.lcParentName = ""  && current control parent name
  m.lcObjName = ""  && current control ObjName
  m.lnControlCount = 0  && How many control the container has
  m.llEndDefine = .F.  && Should Define Class ... Enddefine be generated next
  m.lnContainerLevel = 0  && Container level from top. Is used in subclass naming (next one too)
  m.lnControlNumber = 0   && Control order number in above container level
  * laParents[1,3] is used in subclass naming
  m.lnTotalControlCount = 0  && Used for naming, this separates controls in same level 
                             && (f.ex page1 and page2)
  m.llBranchOK = .F.      && When Branch code generated ( skip -> eof() ) this is set to .T.
  * laControlOk(1,2)      && Column 2 gets .T. when code for the control in record n on metadata is generated
  m.lnMetadrecn = 0       && Current recno() from metadata
  * laParentDaughterCheck(1) see next
  m.llCyclicClassDefinition = .F.
  * If Parent and daughter container has a same name and type
  * Daughter container properties must be defined in ADDOBJECT() WITH clause within the 
  * parent container
  * If properties are defined in DEFINE CLASS => Cannot add CONTAINER1. Class definition is cyclical
  * 
  m.lnaParentsRow = 0 && ASCAN() saves the row from laParents if current object is found there
  
  * Variables lcInsertInitCode, laMethodLines(1), llInitExist, lcAddInitContainers, lcIniName, 
  * lcBranchContainer, lcContainerParent, llAddGirdtoInitNow
  * are used in mode 3 and 5
  * Mode 3/5 adds "restive" controls in respective Init / load event using ADDOBJECT()
  * Mode 3/5 could be ready and in use in near or distant future??
  * Difficulty with mode 3/5 is that control can be pointed in other controls INIT
  * before it is created. F.ex Forms init can set values to control in 
  * form.pageframe.page.column.text1 but it isn't created yet.
  * Maybe mode 3/5 should use the forms load event where are then all ADDOBJECT() functions
  * but then it doesn't differ much how this is handled in modes 2 and 4
  * maybe mode 3/5 is needless!??
  m.lcInsertInitCode = "" && If Control contains objects thos should defined in the begining of 
                          && controls Init code but this is a hell of the job as INIT could have 
                          && LPARAMETER OR PARAMETER. Would be hard to find where to put the 
                          && definition code
  * laMethodLines(1)      && Array to save method code line per array row
  m.llInitExist = .F. && Does the control have an init method
  * m.lcAddInitContainers = ",grid," && ",form,pageframe,grid,container,"
  m.lcAddInitContainers = ",pageframe,grid," && ",form,pageframe,grid,container,"
  * comma limited list of containers whose next object level is defined
  * in their init code NOTE: in case of form,  used only if form is not the top most container
  m.lcInitName = "init"      && Name of the method / event where to generate ADDOBJECT() code
  m.lcBranchContainer = ""   && Container name to which m.lcInitName ADDOBJECT() are added
                             && I.e. container in each Y-branch of tree which then has own controls
  m.lcContainerParent = ""   && BaseClass of the m.lcBranchContainer parent
 
  m.lcParentContainers = ",form,pageframe,container,grid"  && Comma separated list of containers 
                                                           && which can hold other containers
  m.lcPreviousControl = ""   && This control previous control
  m.lcPreviousContainer = "" && This control previous container
                                                       
  
  m.lcInsertAddObjCode = ""  && Variable to hold ADDOBJECT() code
  m.lcMyObjRef = "THIS_IS_AT_ObjRef."  && reference the main container
  * laContainers(1,2)        && is used to add objects to PAGES and COLUMNS
  m.llDefiningGrid = .F.     && .T. when defining grid subcontrols to its init
  m.llAddGirdtoInitNow = .F. && Grid should add to parents INIT PROCE allways and grids column /header addobject() 
                             && code to the grids init code
  m.llFirstGridObj = .F.     && This is set to .T. for the first 
                             && time when defining current grid
                             && with this variable check we can define
                             && to current grid some properties only one 
                             && time
  m.llDefiningPageFrame = .F.     && Defining the Pageframe
  m.llSavePageFrameSubsNow = .F.  && When Pageframe object is defined (and what subs it contains)
                                  && all the subs of it should write to the generated gode
                                  && = ADDOBJECT()
  m.llFirstPGFObj = .F.           && This is set to .T. for the first 
                                  && time when defining current pageframe
                                  && with this variable check we can define
                                  && to current pageframe some properties only onec
                             
  m.lcRemoveObjText1 = ""    && code block of removing "text1" from current column is stored here
  
  m.lcAO_ParentClass = ""    && Parent class to the control added with ADDOBJECT()
  m.lcParentColumn = ""      && Reference to the current column in grid 
  m.lcAddQuotationsProps = ",cursorsource,database,"
  							 && Comma separated list (starts and ends to comma too) 
  							 && of properties which values are in properties field
  							 && without quotations marks but should write to the viewcode.prg
  							 && with quotations mark
  							 && f.ex CursorSource is in properties field as
  							 && CursorSource = MyDataDIr\MyData.dbf
  							 && and it should change to
  							 && CursorSource = "MyDataDIr\MyData.dbf"
  							 && to work in PRG file
  							 
  m.lcExtraCareProps = ",currentcontrol,"  && .name," 
  *                          && Comma separated list (starts and ends to comma too) 
  *                          of properties which are not added in its parent 
  *                          DEFINE CLASS ADD OBJECT but between lines 
  *                          oform1=NEWOBJECT("form1") and oform1.Show
  *                          this is done because this object property behaves 
  *                          badly like column1.CurrentControl
  *                          f.ex. column1.CurrentControl tries to set current control
  *                          before control in question is defined => error
  *
  m.llCheckExtraCareProps = .F.  && Flag that extra care props is checked
                                 && per current control only
                                 && Otherwise f.ex. if grid follows pageframe
                                 && then grid extracare prop definition is added to the
                                 && pageframe init. This is wrong and using this flag
                                 && this can be avoided
  *
  * laParentProps(1)         array to ALINE() object properties from PROPERTIES field
  *                          and then m.lcExtraCareProps is moved to laAddParentProps[1,2]
  *
  *                          NOTE: All PAGEFRAME.PAGES are next level object-atomized
  *                          after oform1=NEWOBJECT("form1") this is done also because
  *                          DEFINE CLASS ADD OBJECT tries to add objects to the page
  *                          which are not defined yet => error
  *
  m.lcInsertRestiveProps = ""   && String block "bad props" to add just before form.show
  
  m.llPropsInDEFINE_CLASS = .T. && If .T. Properties are written in DEFINE CLASS
                                && otherwise after ADD OBJECT AS cNmae WITH

  m.lni1=0  && Local counter 1
  m.lni2=0  && Local counter 2
  m.lni3=0  && Local counter 3
  m.lni4=0  && Local counter 4
  m.lcTmpString1 = ""  && temporary string to save values
  m.lcTmpString2 = ""  && temporary string to save values
  m.lcTmpString3 = ""  && temporary string to save values
  m.lnAscanValue = 0   && Stores ASCAN() value
  * Not used
  * Supported container (last chr must be a comma)
  * m.lcContainer = "FORM,CONTAINER," &&"FORMSET,PAGEFRAME,PAGE,COLUMN,OPTIONGROUP,COMMANDGROUP,"
  
  m.lcOleClass = ""          && Used for OleCalss property in ADDOBJECT()
  m.lcOleClassValue = ""	 && Pure OleClass value. Above contains commas, parentheses etc.
                             && I.e. this is the return value of ReadOleClass() function
  m.lcAddMethodsCode = ""    && Is used to add Method code if needed (f.ex olecontrol / imagelist)
  
Endif
* --- End of AT part

If Not toBrowser.lVCXSCXMode
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
If toBrowser.AddInMethod("EXPORTCLASS")
  toBrowser.vResult=""
  Return toBrowser.vResult
Endif
llHTML=.F.
Do Case
  Case Type("tcExportToFile")#"C"
    lcExportToFile=""
  Case Upper(Alltrim(tcExportToFile))=="HTML"
    lcExportToFile=""
    llHTML=.T.
  Case Not Empty(tcExportToFile)
    lcExportToFile=Alltrim(tcExportToFile)
  Otherwise
    lcExportToFile=Lower(Putfile(M_SAVE_LOC,"","prg|txt|htm|html"))
    If Empty(lcExportToFile)
      toBrowser.vResult=""
      Return toBrowser.vResult
    Endif
Endcase
If Not Empty(lcExportToFile)
  If Not ":"$lcExportToFile And Not "\\"$lcExportToFile
    lcExportToFile=Lower(Fullpath(lcExportToFile))
  Endif
  If File(lcExportToFile)
    If tlShow And toBrowser.MsgBox(lcExportToFile+M_ALREADY_EXISTS_OVER_LOC,35)#6
      toBrowser.vResult=""
      Return toBrowser.vResult
    Endif
  Endif
  llHTML=Inlist(Lower(Justext(lcExportToFile)),"htm","html")
Endif
*** Set Message To M_GEN_CLASS_DEF_LOC+[ ...]
lcCRLF3=Replicate(CR_LF,3)
lcCRLF4=Replicate(CR_LF,4)
lnLastSelect=Select()
toBrowser.SetBusyState(.T.)
lcBorder=Replicate("*",50)
lcComment="*-- "
lcCode=""
lcInsertCode=""
lcAppendCode=""
lcInsertDefineCode=""
lcAppendDefineCode=""
lcDefineClass=""
lnClassLibCount=0

Dimension laClassLib[1]
llFileMode=toBrowser.lFileMode
lcFileName=toBrowser.cFileName
llSCXMode=toBrowser.lSCXMode
lnClassCount=0

* 03/26/2004 Arto Toikka Added support to multilevel containers and methods
* Used to count how many controls the container has
If m.lnAppType > 0

  * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
  * 02/14/2006 AT START
  * IF m.lnAppType > 3
  *   m.llPropsInDEFINE_CLASS = .F.
  *   m.lnAppType = m.lnAppType - 2
  * ELSE
  *   m.llPropsInDEFINE_CLASS = .T.
  * Endif  
  m.llPropsInDEFINE_CLASS = INLIST(m.lnAppType,2,3)
  * 02/14/2006 AT END

  Select ObjName, Parent From (toBrowser.cAlias) Having !Deleted() Into Cursor (m.lcTmpControlCur)
ENDIF
* --- End of AT part

* SET STEP ON 

Select (toBrowser.cAlias)
LOCATE

Do While .T.

  If toBrowser.lRelease
    Select (lnLastSelect)
    toBrowser.vResult=""
    Return toBrowser.vResult
  Endif
  
  If lnClassCount>0
    If Eof()

      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      If m.lnAppType > 0
        If Alias() == Upper(toBrowser.cAlias)
          * Clean temp cursors
          If Used(m.lcTmpGroupCur)
            Use In (m.lcTmpGroupCur)
          Endif
          If Used(m.lcTmpControlCur)
            Use In (m.lcTmpControlCur)
          Endif
          Exit
        Else
          Select (toBrowser.cAlias)
          m.llEndDefine = .T.
        Endif
        * --- End of AT part
      Else
        Exit
      Endif

    Endif

    Skip

    * 05/01/2005 Arto Toikka Added support to multilevel containers and methods
    * Loop if End of container
    If m.lnAppType > 0
      If Eof() And Alias() == Upper(m.lcTmpGroupCur)
        * If previous records was to define grid
        * and gird is now defined because of eof() of 
        * grid defining records -> grid definition shoud write 
        * to lcCode
        m.llAddGirdtoInitNow = m.llDefiningGrid
        m.llSavePageFrameSubsNow = m.llDefiningPageFrame
        m.llBranchOK = .T.
        Loop
      Endif
    Endif
    * --- End of AT part

  Endif
  lcParent=Lower(Alltrim(Parent))

  * 06/10/2005 Arto Toikka Next if changed to support dataenvironment
  * If lnClassCount<=0 Or Empty(lcParent)
  If (lnClassCount<=0 Or Empty(lcParent)) AND IIF(m.lnAppType=0,.T.,m.lnDataenvOK # 1)
  
    lnClassCount=lnClassCount+1
    If lnClassCount>toBrowser.nClassCount Or ;
        (Not llFileMode And lnClassCount>=2)
      Exit
    Endif
    If llFileMode
      lnListIndex=lnClassCount
    Else
      lnListIndex=toBrowser.nClassListIndex+1
    Endif
    lcClass=toBrowser.aClassList[lnListIndex,1]
    lcFileName2=toBrowser.aClassList[lnListIndex,6]
    
    Select (toBrowser.cAlias)
    
    If "."$lcClass Or Not lcFileName==lcFileName2
      Locate
      Loop
    Endif

    Go toBrowser.aClassList[lnListIndex,2]

    * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
    * Here is the top most container
    If m.lnAppType > 0
      m.lcTopMost = Lower(Alltrim(ObjName))
      * IF INLIST(m.lnAppType,2,4)
      *   m.lcMyObjRef = m.lcTopMost+"."
      * Endif
    Endif
    * --- End of AT part

    lcParent=Lower(Alltrim(Parent))
    lcParentClass=Lower(Alltrim(Class))
    *** Set Message To M_GEN_CLASS_DEF_LOC+[ (]+lcClass+[) ...]
  Else
    lcClass=Lower(Alltrim(ObjName))
    lcParentClass=Lower(Alltrim(Class))
    *** Set Message To M_GEN_CLASS_DEF_LOC+[ (]+lcDefineClass+[.]+lcClass+[) ...]
  Endif

  * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
  If m.lnAppType > 0
    * Generates temporary cursors for a Metadata
    If Alias() == Upper(toBrowser.cAlias)

      If Empty(lcParent) && Add main container record too

        m.lcParentName = ""
        m.lcObjName = Lower(Alltrim(ObjName))
      
        DO WHILE .T.

          IF m.llSCXMode AND m.lnDataenvOK = 0
            
            Select RECNO() AS nMetadrecn, * From (toBrowser.cAlias) ;
              WHERE AT(Lower(Alltrim(Baseclass)),m.lcDEClasses)>0 ;
              HAVING !Deleted() ;
              INTO Cursor (m.lcTmpGroupCur)

            IF RECCO(m.lcTmpGroupCur) < 2
              Select (toBrowser.cAlias)
              m.lnDataenvOK = -1 && No DE
              LOOP
            ELSE
              GO &lcTmpGroupCur->nMetadrecn IN (toBrowser.cAlias)  && first record of the DE
            ENDIF
            
            lcClass=Lower(Alltrim(ObjName))
            lcParentClass=Lower(Alltrim(Class))

            m.lnDataenvOK = 1  && There is a dataenvironment but it has not been generated yet
        
          Else    
          
            m.lnDataenvOK = IIF(m.lnDataenvOK < 0,-1, 2) && DE generation finished

            Select RECNO() AS nMetadrecn, * From (toBrowser.cAlias) ;
              WHERE (Lower(Alltrim(Parent)) == m.lcObjName ;
              OR Empty(Parent) And Lower(Alltrim(ObjName)) == m.lcObjName) ;
              HAVING !Deleted() ;
              INTO Cursor (m.lcTmpGroupCur)
          
          Endif
          
          exit
          
        Enddo  

      Else

        m.lcParentName = Lower(Alltrim(Parent))
        m.lcObjName = Lower(Alltrim(ObjName))
        
        * 06/06/2005 AT
        IF ATC(Lower(Alltrim(BaseClass)),m.lcAddInitContainers)>0 && INLIST(m.lnAppType,2,4)
          * Next gives top branch container and it next leve sub controls
          m.llDefiningGrid = (Lower(Alltrim(BaseClass)) == "grid")
          m.llFirstGridObj = m.llDefiningGrid  && This is set to .T. for the first 
                                               && time when defining current grid
                                               && with this variable check we can define
                                               && to current grid some properties only onec
          m.llDefiningPageFrame = (Lower(Alltrim(BaseClass)) == "pageframe")
          m.llFirstPGFObj = m.llDefiningPageFrame
                                               && This is set to .T. for the first 
                                               && time when defining current pageframe
                                               && with this variable check we can define
                                               && to current pageframe some properties only onec
                                               
          * IF Lower(Alltrim(BaseClass)) == "grid"
          
            Select RECNO() AS nMetadrecn, * From (toBrowser.cAlias) ;
              WHERE (Lower(Alltrim(Parent)) == m.lcParentName And ;
              LOWER(Alltrim(ObjName)) == m.lcObjName) Or ;
              JUSTSTEM(LOWER(Alltrim(Parent))) == m.lcParentName+"."+m.lcObjName OR ;
              LOWER(Alltrim(Parent)) == m.lcParentName+"."+m.lcObjName ;
              HAVING !Deleted() ;
              INTO Cursor (m.lcTmpGroupCur)
          * ELSE
          *   Select * From (toBrowser.cAlias) ;
          *    WHERE Lower(Alltrim(Parent)) == m.lcParentName And ;
          *    LOWER(Alltrim(ObjName)) == m.lcObjName ;
          *    HAVING !Deleted() ;
          *    INTO Cursor (m.lcTmpGroupCur)
          * Endif
        ELSE
          Select RECNO() AS nMetadrecn, * From (toBrowser.cAlias) ;
            WHERE (Lower(Alltrim(Parent)) == m.lcParentName And ;
            LOWER(Alltrim(ObjName)) == m.lcObjName Or ;
            LOWER(Alltrim(Parent)) == m.lcParentName+"."+m.lcObjName) ;
            HAVING !Deleted() ;
            INTO Cursor (m.lcTmpGroupCur)
        ENDIF
      
        *!* I think that laContainers should release 
        *!* for the top branch container
        DIMENSION laContainers[1,2]
        laContainers[1,1] = .F.
        laContainers[1,2] = .F.

      Endif

      m.lnControlNumber = 0
      
      DIMENSION laParentDaughterCheck(1)

      * laParentDaughterCheck(m.lnControlNumber + 1,1) = RECNO()  && 1, 2
      * laParentDaughterCheck(m.lnControlNumber + 1,2) = Lower(Alltrim(Parent)) && form1, form1.container1
      * laParentDaughterCheck(m.lnControlNumber + 1,3) = Lower(Alltrim(BaseClass))  && container, container
      * laParentDaughterCheck(m.lnControlNumber + 1,4) = Lower(Alltrim(ObjName))  && container1, container1

      laParentDaughterCheck(1) = Lower(Alltrim(Parent))+","+;
                                                       Lower(Alltrim(BaseClass))+","+;
                                                       Lower(Alltrim(ObjName))
    Else

      m.lcParentName = Lower(Alltrim(Parent))
      m.lcObjName = Lower(Alltrim(ObjName))

      m.lnControlNumber = m.lnControlNumber + 1
      
      DIMENSION laParentDaughterCheck(m.lnControlNumber + 1)

      laParentDaughterCheck(m.lnControlNumber + 1) = Lower(Alltrim(Parent))+","+;
                                                       Lower(Alltrim(BaseClass))+","+ ;
                                                       Lower(Alltrim(ObjName))
    Endif

    *!* NOTE IF still needs more check then have to add laUniqueId[1,2] Uh...
    *!* cannot use UniqueId or Timestamp both can be same with another record
    *!* -> laControlOk(n,2), SELECT - SQL also recno() from Metadata ->
    *!* save recno() to laControlOk(n,1) and status to laControlOk(n,2)
    *!* .T. control code generated .F. not yet. Note: recno() from metadata
    *!* is nMetadrecn field IN (m.lcTmpGroupCur) Cursor us it and laControlOk(n,2)
    *!* for more robust check

    m.lnMetadrecn = nMetadrecn
    DIMENSION laControlOk(m.lnMetadrecn,2)
    laControlOk(m.lnMetadrecn,1) = m.lcParentName+"."+m.lcObjName

    m.llCyclicClassDefinition = (ASCAN(laParentDaughterCheck,;
        SUBSTR(Lower(Alltrim(Parent)),1,RAT(".",Lower(Alltrim(Parent)))-1)+","+;
        Lower(Alltrim(BaseClass))+","+;
        Lower(Alltrim(ObjName)),1,-1,-1,14) > 0 AND !EMPTY(Parent))

    If !Empty(lcParent)  && No need to count for main container
      
      * Counting how many controls container has if none and no methos conde in the container
      * no need to add DEFINE CLASS ... ENDDEFINE to that container

      * IF INLIST(Alltrim(BaseClass),"pageframe","grid")
      *   Select (m.lcTmpControlCur)
      *   Count For Lower(JUSTSTEM(Alltrim(Parent))) == m.lcParentName+"."+m.lcObjName To m.lnControlCount
      *   * m.lnControlNumber = IIF(m.lnControlNumber = 0 AND m.lnControlCount > 0,1,m.lnControlNumber)
      * Else
      *   Select (m.lcTmpControlCur)
      *   Count For Lower(Alltrim(Parent)) == m.lcParentName+"."+m.lcObjName To m.lnControlCount
      * Endif

      IF AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0 AND RECNO() = 1 AND ;
        (ATC(m.lcBranchContainer,m.lcParentName+"."+m.lcObjName) = 0)
        
        *?* m.llAddGirdtoInitNow = ;
          IIF(INLIST(m.lnAppType,2,4) AND ;
            m.lcPreviousControl == "grid" AND ;
            Lower(Alltrim(BaseClass)) == "header",.T.,m.llAddGirdtoInitNow)
            
        
        && .T. && AT(m.lcContainerParent,m.lcParentContainers) = 0
        
        * In the loop of looking PageFrame Methods, Properties and Controls
        * But don't enter here if conainer is hold by m.lcParentContainers container
        
        m.lcContainerParent = Lower(Alltrim(BaseClass))
        m.lcPreviousControl = Lower(Alltrim(BaseClass))
        
        m.lcBranchContainer = m.lcParentName+"."+m.lcObjName
        
        Select (m.lcTmpControlCur)
        
        IF m.lcPreviousControl == "pageframe" OR m.lcPreviousControl == "grid" 
          * pageframe/grid cannot be a parent but instead of page/column is
          Count For JUSTSTEM(Lower(Alltrim(Parent))) = m.lcParentName+"."+m.lcObjName To m.lnControlCount
        ELSE
          Count For Lower(Alltrim(Parent)) = m.lcParentName+"."+m.lcObjName To m.lnControlCount
        ENdif  
        
      ELSE

        *?* m.llAddGirdtoInitNow = ;
          IIF(INLIST(m.lnAppType,2,4) AND ;
            m.lcPreviousControl == "grid" AND ;
            Lower(Alltrim(BaseClass)) == "header",.T.,m.llAddGirdtoInitNow)
            
      
        m.lcPreviousControl = Lower(Alltrim(BaseClass))
        Select (m.lcTmpControlCur)
        
        IF m.lcPreviousControl == "pageframe" OR m.lcPreviousControl == "grid" 
          * pageframe/grid cannot be a parent but instead of page/column is
          Count For JUSTSTEM(Lower(Alltrim(Parent))) == m.lcParentName+"."+m.lcObjName To m.lnControlCount
        Else  
          Count For Lower(Alltrim(Parent)) == m.lcParentName+"."+m.lcObjName To m.lnControlCount
        ENDIF
          
      Endif
      
      * IF m.lncontrolcount = 0 && m.lcPreviousControl == "pageframe" OR m.lcPreviousControl == "grid" 
      *   SET STEP ON 
      * Endif

      Select (m.lcTmpGroupCur)
      
      * 06/05/2005 Arto Toikka 
      * mode 3 and 5 support. ADDOBJECT() are added to the container INIT
      * lcInsertAddObjCode are collected and moved out from the container controls
      * Time to write container ADDOBJECT() code

      * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
      * IF m.lnAppType = 2 AND
      IF INLIST(m.lnAppType,2,4) AND ;
        !EMPTY(m.lcBranchContainer) AND ;
          !EMPTY(m.lcInsertAddObjCode) AND ;
          m.llAddGirdtoInitNow

      *?* IF INLIST(m.lnAppType,2,4) AND ;
        !EMPTY(m.lcBranchContainer) AND ;
          !EMPTY(m.lcInsertAddObjCode) AND ;
          (!JUSTSTEM(m.lcParentName) == m.lcBranchContainer ;
          OR m.llAddGirdtoInitNow)
          
        * lcInsertAddObjCode = FormatProperties(lcInsertAddObjCode,.T.)
        IF ATC("*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *",lcCode)>0

          m.lcInsertAddObjCode = m.lcInsertAddObjCode + m.lcInsertRestiveProps
          m.lcInsertAddObjCode = toBrowser.FormatMethods(m.lcInsertAddObjCode)
          

          lcCode = STRTRAN(lcCode,"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *",;
            m.lcInsertAddObjCode,1,1)+CR_LF
            
          m.lcInsertAddObjCode = ""
          m.lcInsertRestiveProps = ""
          m.lcBranchContainer = ""
          m.lcContainerParent = ""
          m.llAddGirdtoInitNow = .F.
          m.llDefiningGrid = .F.
        ELSE
          *!* Write grid lcInsertRestiveProps before 
          *!* Entering to define crid control CLASSES which can have
          *!* own lcInsertRestiveProps
          m.lcInsertAddObjCode = m.lcInsertAddObjCode + m.lcInsertRestiveProps
          m.lcInsertRestiveProps = ""
        ENDIF
      ENDIF
    
    Endif



    * 09/08/2004 Arto Toikka Added support to multilevel containers and methods
    * Properties value firs modifications
    lcProperties=Alltrim(Properties)
    
    IF m.lnDataenvOK = 1  && Generating dataenvironment code
      * Name = "Dataenvironment" should change to someone other
      * If you run MyPrg1.prg with a dataenvironment and then exit from the MyPrg1.prg
      * Then you run MyPrg2.prg with a dataenvironment with has also 
      * Dataenvironment name as "Dataenvironment", error 
      * 1771 "A member object with this name already exists." is generated.
      * This can be avoided if the dataenvironment name is changed f.ex 
      * "Dataenvironment_" in both PRGs
      IF ATC('Name = "Dataenvironment"',lcProperties) > 0
        m.lcProperties = STRTRAN(m.lcproperties,'Name = "Dataenvironment"','Name = "Dataenvironment_"')
      Endif  
    Endif

    IF !EMPTY(lcProperties) AND (!EMPTY(m.lcExtraCareProps) OR !EMPTY(m.lcAddQuotationsProps))
      IF m.llBranchOK 
      
        * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
        * IF m.lnAppType = 2 AND !EMPTY(lcInsertRestiveProps) AND
        IF INLIST(m.lnAppType,2,4) AND !EMPTY(m.lcInsertRestiveProps) AND ;
          !EMPTY(m.lcInsertAddObjCode)
        
          *!* !EMPTY(lcInsertAddObjCode) because should write lcInsertRestiveProps
          *!*  to the end of lcInsertAddObjCode
          m.lcInsertAddObjCode = m.lcInsertAddObjCode + m.lcInsertRestiveProps
          m.lcInsertRestiveProps = ""
        ELSE
          m.llBranchOK = .F.  
        Endif  
      ENDIF  

      ALINES("laParentProps",lcProperties)
      
      * IF there is a property that is defined in m.lcAddQuotationsProps
      * i.e. property value is without quotations mark but
      * to get it to work in PRG shoud have quotations mark
      * those are added here
      m.lni3 = 0
      For m.lni1 = 1 TO OCCURS(",",m.lcAddQuotationsProps)-1
        m.lcTmpString1 = STREXTRACT(m.lcAddQuotationsProps,",",",",m.lni1)
        FOR m.lni2 = 1 TO ALEN(laParentProps)
          
          IF ATC(m.lcTmpString1,laParentProps(m.lni2)) > 0 AND ;
            ATC(CHR(34),laParentProps(m.lni2))=0 AND ;
            ATC(CHR(39),laParentProps(m.lni2))=0
            
            laParentProps(m.lni2) = STREXTRACT(laParentProps(m.lni2),"","=",1,4)+" "+ ;
            CHR(34)+ALLTRIM(STREXTRACT(laParentProps(m.lni2),"="))+CHR(34)
            
            m.lni3 = m.lni2
            
          Endif
        Endfor
      Endfor

      IF m.lni3 > 0
      
        m.lcProperties = ""
        FOR m.lni2 = 1 TO ALEN(laParentProps)
          IF !EMPTY(laParentProps(m.lni2))
            m.lcProperties = m.lcProperties + laParentProps(m.lni2) + CR_LF
          ENDIF
        ENDFOR
       
        ALINES("laParentProps",m.lcProperties)     
      
      Endif
     
      * Parsing badly behaving properties out
      * and adding them to laAddParentProps
      * and then those "bad properties" are written
      * to m.lcInsertRestiveProps which is
      * added to m.lcInsertAddObjCode
      * m.lcInsertAddObjCode is written to the topmost container INIT method (mode 2 and 4)
      * or between oform1=NEWOBJECT("form1") -- oform1.Show (mode 3 and 5)
      
      DO case
        CASE m.lcContainerParent == "pageframe" AND m.llFirstPGFObj
          m.llFirstPGFObj = .F.
          m.llCheckExtraCareProps = .T.

        CASE m.lcContainerParent == "pageframe" AND m.llDefiningPageFrame
          m.llCheckExtraCareProps = .F.
          
        CASE m.lcContainerParent == "grid" AND m.llFirstGridObj
          m.llFirstGridObj = .F.
          m.llCheckExtraCareProps = .T.
        
        CASE m.lcContainerParent == "grid" AND m.llDefiningGrid
          m.llCheckExtraCareProps = .F.
        
        OTHERWISE
          m.llCheckExtraCareProps = .T.  
      Endcase
          

      IF m.llCheckExtraCareProps
        
        m.llCheckExtraCareProps = .F.
         
      FOR m.lni1 = 1 TO OCCURS(",",m.lcExtraCareProps)-1
        m.lcTmpString1 = STREXTRACT(m.lcExtraCareProps,",",",",m.lni1)
        FOR m.lni2 = 1 TO ALEN(laParentProps)
          IF ATC(m.lcTmpString1,laParentProps(m.lni2)) > 0
          
            * If properties field contains value like Page1.Name="nn" or Column1.Name="nn"
            * value nn is looked for and saved to m.lcTmpString2 for the 
            * correnct object name reference
            m.lcTmpString2 = STREXTRACT(laParentProps(m.lni2),"",".")
            m.lni3 = ASCAN(laParentProps,m.lcTmpString2+".Name",-1,-1,1,13)
            IF m.lni3 > 0
              m.lcTmpString2 = STREXTRACT(laParentprops(m.lni3),CHR(34),chr(34),1)
            ENDIF
            
            * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
            * m.lcTmpString3 = IIF(m.lnAppType = 2,"This"
            m.lcTmpString3 = IIF(INLIST(m.lnAppType,2,4),"This",;
                m.lcMyObjRef+LOWER(Strextract(m.lcParentName + "." + m.lcObjName,".",""))) + ;
                "." + m.lcTmpString2 + IIF(!EMPTY(laParentProps(m.lni2)),".","") + ;
                SUBSTR(laParentProps(m.lni2),ATC(".",laParentProps(m.lni2))+1)

            * m.lcTmpString3 = LOWER(Strextract(m.lcParentName + "." + m.lcObjName + "." + m.lcTmpString2 + ;
                IIF(!EMPTY(laParentProps(m.lni2)),".",""),".","")) + ;
                SUBSTR(laParentProps(m.lni2),ATC(".",laParentProps(m.lni2))+1)
                
            * m.lnAscanValue = ASCAN(laAddParentProps,m.lcTmpString3,-1,-1,1,14)
            * IF laAddParentProps swells too large to handle with FOR ENDFOR
            * use next code to use ASCAN 
            * The below FOR ... ENDFOR code is needed because there can be objects with same
            * name but in different containers. Both have same Object reference name i.e. m.lcTmpString3
            * value but different m.lnContainerLevel, m.lnControlNumber and m.lnTotalControlCount
            * which identifies objects as different ones.
            
            m.lnAscanValue = 0
            
            FOR m.lni3 = 1 TO ALEN(laAddParentProps,1)
              IF TRANSFORM(laAddParentProps(m.lni3,1)) == m.lcTmpString3 AND ;
                TRANSFORM(laAddParentProps(m.lni3,2)) == m.lcParentName+"."+ m.lcObjName
                
                m.lnAscanValue = m.lni3
                EXIT
              ENDIF  
            ENDFOR            
            
            IF m.lnAscanValue = 0
                
              m.lni4 = m.lni4 + 1
              DIMENSION laAddParentProps(m.lni4,2)
       
              laAddParentProps(m.lni4,1) = m.lcTmpString3
              laAddParentProps(m.lni4,2) = m.lcParentName+"."+ m.lcObjName && Parent object name
                
               * If Try...Catch...Entry
               * m.lcInsertRestiveProps = m.lcInsertRestiveProps + ;
               * IIF(llHTML,[<font color="red">]+CR_LF,[])+ ;
               * "Try"+CR_LF+;
               * IIF(llHTML,[</font><font color="black">],[])+ ;
               * toBrowser.IndentText(m.lcMyObjRef + m.lcTmpString2,1) + CR_LF +;
               * IIF(llHTML,[</font><font color="red">],[])+ ;
               * "Catch"+CR_LF+;
               * "Endtry"+CR_LF+;
               * IIF(llHTML,[</font>],[])
               
               * IF VARTYPE()#'U'
               
               * IF INLIST(m.lnAppType,2,4)
                 m.lcInsertRestiveProps = m.lcInsertRestiveProps + ;
                 IIF(llHTML,[<font color="red">]+CR_LF,[])+ ;
                 "IF TYPE('"+ALLTRIM(STREXTRACT(m.lcTmpString3,'','=',1))+"') # 'U'"+CR_LF+;
                 IIF(llHTML,[</font><font color="black">],[])+ ;
                 toBrowser.IndentText(m.lcTmpString3,1) + CR_LF +;
                 IIF(llHTML,[</font><font color="red">],[])+ ;
                 "Endif"+CR_LF+;
                 IIF(llHTML,[</font></font>],[])
               * ELSE
               *?*  m.lcInsertRestiveProps = m.lcInsertRestiveProps + ;
               *?*  IIF(llHTML,[<font color="red">]+CR_LF,[])+ ;
               *?*  "IF TYPE('"+m.lcMyObjRef + ALLTRIM(STREXTRACT(m.lcTmpString3,'','=',1))+"') # 'U'"+CR_LF+;
               *?*  IIF(llHTML,[</font><font color="black">],[])+ ;
               *?*  toBrowser.IndentText(m.lcMyObjRef + m.lcTmpString3,1) + CR_LF +;
               *?*  IIF(llHTML,[</font><font color="red">],[])+ ;
               *?*  "Endif"+CR_LF+;
               *?*  IIF(llHTML,[</font>],[])
               * Endif
              
              * m.lcInsertRestiveProps = m.lcInsertRestiveProps + m.lcMyObjRef + m.lcTmpString2 + CR_LF
            
            Endif  

            laParentProps(m.lni2) = ""
            
          Endif
        ENDFOR
      ENDFOR
      Endif
      lcProperties = ""
      FOR m.lni2 = 1 TO ALEN(laParentProps)
        IF !EMPTY(laParentProps(m.lni2))
          lcProperties = lcProperties + laParentProps(m.lni2) + CR_LF
        ENDIF
      ENDFOR
    Endif     


    * Method code prime modifications
    lcMethods=Alltrim(Methods)
    
    If INLIST(Lower(Alltrim(BaseClass)),"olecontrol")
       m.lcOleClassValue = ReadOleClass(0)
    ENDIF
    
    IF ATC("imagelist",LOWER(m.lcOleClassValue)) > 0
      m.lcAddMethodsCode = CR_LF+CR_LF+;
        '* This is an example of initializing ImageList control'+CR_LF+;
        '* As there is no way at the moment to read above properties'+CR_LF+;
        '* from the OLE field, these have to add manually to get it to work'+CR_LF+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(1,"cmd",LOADPICTURE(home()+;'+CR_LF+;
        '*   "\samples\solution\pscmd.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(2,"chk",LOADPICTURE(home()+;'+CR_LF+;
        '*   "\samples\solution\pscheck.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(3,"ole",LOADPICTURE(home()+;'+CR_LF+;
        '*   "\samples\solution\psole.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(4,"world",LOADPICTURE(home()+;'+CR_LF+;
        '*   "\samples\solution\connectn.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(5,"api",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\apilibra.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(6,"app",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\apps.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(7,"db",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\database.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(8,"frm",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\forms.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(9,"idx",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\indexes.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(10,"dot",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\leaf.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(11,"menu",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\menu.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(12,"cbo",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\psdropdn.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(13,"edt",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\pseditbx.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(14,"grd",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\psgrid.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(15,"lst",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\pslistbx.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(16,"pgf",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\pspgfr.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(17,"opt",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\psradio.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(18,"spn",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\psspin.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(19,"tmr",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\pstimer.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(20,"txt",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\pstxtbx.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(21,"frs",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\query.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(22,"frx",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\report.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(23,"dbf",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\table.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(24,"tbr",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\toolbar2.bmp"))'+CR_LF+;
        '* THIS.OBJECT.ListImages.ADD(25,"qpr",LOADPICTURE(home()+;'+CR_LF+;
        '*    "\samples\solution\query.bmp"))'+CR_LF+CR_LF
      
      IF EMPTY(lcMethods)
        lcMethods = ;
          'PROCEDURE Init'+;
          m.lcAddMethodsCode+;
          'ENDPROC'
      ELSE
        lcMethods = STRTRAN(lcMethods,'PROCEDURE Init','PROCEDURE Init'+CR_LF+CR_LF+m.lcAddMethodsCode)
      
      ENDIF
      
    Endif    

    If llHTML
      lcProperties=brwValidHTMLText(Alltrim(lcProperties))
      lcMethods=brwValidHTMLText(Alltrim(lcMethods))
    Else
      lcProperties=Alltrim(lcProperties)
      lcMethods=Alltrim(lcMethods)
    ENDIF

    m.lnContainerLevel = Occurs(".",Parent)+1

    m.lnTotalControlCount = m.lnTotalControlCount + 1

  ENDIF
  * --- End of AT part

  lcBaseClass=Lower(Alltrim(BaseClass))
  lcClassLoc=Iif(Empty(ClassLoc),"",Lower(Fullpath(Alltrim(ClassLoc),lcFileName)))
  
  * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
  * Save reference to the Column
  If m.lnAppType > 0
    IF lcBaseClass == "header"
      m.lcParentColumn = m.lcParentName && + "."+m.lcObjName
    ELSE
      * m.lcParentColumn = ""
    ENDIF
  Endif
  * --- End of AT part

 
  If m.lnAppType = 0  && Run only if in MS mode
    If llHTML
      lcProperties=brwValidHTMLText(Alltrim(Properties))
      lcMethods=brwValidHTMLText(Alltrim(Methods))
    Else
      lcProperties=Alltrim(Properties)
      lcMethods=Alltrim(Methods)
    ENDIF
  Endif

  * m.lcParentContainerName = "" 
  * m.lcDaughterContainerName = ""

  lnMemberCount=0
  Dimension laMembers[1]
  Dimension laMemberDesc[1]
  _Mline=0
  For lnCount = 1 To Memline(Reserved3)
    lcMember=Alltrim(Mline(Reserved3,1,_Mline))
    lcArrayInfo=""
    If Empty(lcMember)
      Loop
    Endif
    If Left(lcMember,1)=="*"
      lcMember=Alltrim(Substr(lcMember,2))
      lnAtPos=At(" ",lcMember)
      If lnAtPos=0
        lcMemberDesc=""
        lcMember=Lower(lcMember)
      Else
        lcMemberDesc=Alltrim(Substr(lcMember,lnAtPos+1))
        lcMember=Lower(Alltrim(Left(lcMember,lnAtPos-1)))
      Endif
      lnAtPos=Atc(CR_LF+"PROCEDURE "+lcMember+CR_LF,CR_LF+lcMethods+CR_LF)
      If Not Empty(lcMethods)
        lcMethods=lcMethods+CR_LF
      Endif
      If lnAtPos>0
        If Empty(lcMemberDesc)
          lcMemberDesc=CR_LF+CR_LF
        Else
          lcMemberDesc=toBrowser.IndentText(lcComment+lcMemberDesc)
        Endif
        lcMethods=Left(lcMethods,lnAtPos-1)+CR_LF+CR_LF+ ;
          MARKER+Iif(llHTML,[<font color="green">],[])+ ;
          +lcMemberDesc+Iif(llHTML,[</font><font color="black">],[])+CR_LF+ ;
          SUBSTR(lcMethods,lnAtPos)
        Loop
      Endif
      If Not Empty(lcMethods)
        lcMethods=lcMethods+CR_LF
      Endif
      If Not Empty(lcMemberDesc)
        lcMethods=lcMethods+MARKER+toBrowser.IndentText(lcComment+lcMemberDesc)
      Endif
      If Not Empty(lcMethods)
        lcMethods=lcMethods+CR_LF
      Endif
      lcMethods=lcMethods+"PROCEDURE "+lcMember+CR_LF+"ENDPROC"+CR_LF+CR_LF
      Loop
    Endif
    If Left(lcMember,1)=="^"
      lcMember=Strtran(Strtran(Strtran(Alltrim(Substr(lcMember,2)), ;
        "(","["),")","]"),",0]","]")
      lnAtPos=At("[",lcMember)
      If lnAtPos>0
        lcArrayInfo=Alltrim(Substr(lcMember,lnAtPos))
        lcMember=Alltrim(Left(lcMember,lnAtPos-1))
      Endif
      If Empty(lcMember)
        Loop
      Endif
      lnMemberCount=lnMemberCount+1
      Dimension laMembers[lnMemberCount]
      Dimension laMemberDesc[lnMemberCount]
      laMembers[lnMemberCount]=Lower(lcMember)+" "
      lnAtPos=At(" ",lcArrayInfo)
      If lnAtPos=0
        laMemberDesc[lnMemberCount]=MARKER+lcArrayInfo
      Else
        laMemberDesc[lnMemberCount]=Alltrim(Substr(lcArrayInfo,lnAtPos+1))+ ;
          MARKER+Alltrim(Left(lcArrayInfo,lnAtPos-1))
      Endif
      Loop
    Endif
    lnMemberCount=lnMemberCount+1
    Dimension laMembers[lnMemberCount]
    Dimension laMemberDesc[lnMemberCount]
    lnAtPos=At(" ",lcMember)
    If lnAtPos=0
      laMembers[lnMemberCount]=Lower(lcMember)+" "
      laMemberDesc[lnMemberCount]=""
    Else
      laMembers[lnMemberCount]=Lower(Alltrim(Left(lcMember,lnAtPos-1)))+" "
      laMemberDesc[lnMemberCount]=Alltrim(Substr(lcMember,lnAtPos+1))
    Endif
  Endfor
  lnProtectedCount=0
  Dimension laProtected[1]
  _Mline=0
  For lnCount = 1 To Memline(Protected)
    lcMember=Lower(Alltrim(Mline(Protected,1,_Mline)))
    If Empty(lcMember)
      Loop
    Endif
    llHidden=("^"$lcMember)
    lcMember2=Alltrim(Strtran(lcMember,"^",""))
    lcMemberType=Iif(PEMSTATUS(lcBaseClass,lcMember2,5), ;
      LOWER(PEMSTATUS(lcBaseClass,lcMember2,3)),"")
    If Ascan(laMembers,lcMember2+" ")=0 And Not lcMemberType=="property"
      lcMethods2=CR_LF+lcMethods
      lcSearchStr=CR_LF+"PROCEDURE "+lcMember2+CR_LF
      lnAtPos=Atc(lcSearchStr,lcMethods2)
      If lnAtPos>0
        * 06/10/2004 Arto Toikka Tab modified
        * it generates needless tab on the first line
        * lcMethods=Substr(Left(lcMethods2,lnAtPos),3)+Tab+ 
        * --- End of AT part
        * lcMethods=Substr(Left(lcMethods2,lnAtPos),3)+IIF(lnCount>1,Tab,"")+ ;
        
        lcMethods=Substr(Left(lcMethods2,lnAtPos),3)+Tab+;
          IIF(llHidden,"HIDDEN ","PROTECTED ")+ ;
          SUBSTR(lcMethods2,lnAtPos+2)
        lcMethods2=""
        Loop
      Endif
      lcMethods2=""
    Endif
    lnProtectedCount=lnProtectedCount+1
    Dimension laProtected[lnProtectedCount]
    laProtected[lnProtectedCount]=lcMember+" "
  Endfor

  If llFileMode And llSCXMode And Not Empty(lcClassLoc) And ;
      ASCAN(laClassLib,lcClassLoc)=0
    lnClassLibCount=lnClassLibCount+1
    Dimension laClassLib[lnClassLibCount]
    laClassLib[lnClassLibCount]=lcClassLoc
  Endif

  Do Case

      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods

      * Case Empty(lcParent) Or Iif(m.lnAppType > 0,m.llEndDefine And !Empty(Class),Empty(lcParent))
 
 
    Case Empty(lcParent) Or Iif(m.lnAppType > 0,m.llEndDefine And !Empty(Class) AND ;
      (Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0 OR m.llAddGirdtoInitNow),;
      Empty(lcParent))
      
 
      *!* Case last modifications 06/09/2005 AT
      *!* Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0 ?? = same as
      * !m.lnContainerParent == "grid" and !m.lnContainerParent == "pageframe" && ??
      *!* i.e. !INLIST(m.lnContainerParent,m.lcAddInitContainers)
      
      *?*    Case Empty(lcParent) Or Iif(m.lnAppType > 0,m.llEndDefine And !Empty(Class) And ;
             (Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0 Or ;
               (!Empty(lcMethods) OR RECCOUNT() = 1 AND m.lcBaseClass = "grid") ;
               OR m.lnControlCount>0),Empty(lcParent))

      *!* Should enter here when:
      *!* 1) The topmost container  (= Empty(lcParent) )
      *!* 2) All conrol info is written to variables and then
      *!*    skipped to the next control 
      *!*    Then here previous control DEFINE CLASS are ended with ENDPROC
      *!*    all codes are written to the m.lccode and defining current control
      *!*    is started with lines:
      *!*    *************
      *!*    *--
      *!*    *--
      *!*    *--
      *!*    *--
      *!*    *
      *!*    DEFINE CLASS
      *!*    
      *!*    2) is when m.lnAppType > 0,m.llEndDefine And !Empty(Class)
      *!*    
      *!*    AND 
      *!*     current pageframe / grid are not handled yet but
      *!*    handling pageframe / grid controls -> do not enter here
      *!*    (= Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)>0 )
      *!*    OR
      *!*    There is method code with current control (= Empty(lcMethods) )
      *!*    OR 
      *!*    GRID code generated and should write to lccode and end with ENDPROC
      *!*    ( = RECCOUNT() = 1 AND m.lcBaseClass = "grid" )
      *!*    OR 
      *!*    Control has subcontrols
      *!*    (= m.lnControlCount>0 )
      *!* 3) When grid definition is ended and entered to define crid control DEFINE CLASSes
      

      * MS Original
      * CASE EMPTY(lcParent)
      * --- End of AT part

      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      If m.lnAppType > 0

        * If Container has no controls or methods do not generate DEFINE CLASS ... ENDDEFINE
        * It is still ADD OBJECTed in it's parent container
        * If m.llPropsInDEFINE_CLASS = .T. then propeties are not added in ADD OBJECT ->
        * must generae DEFINE CLASS
        If !Empty(lcParent)
          If m.lnControlCount = 0 And (Empty(lcMethods) AND (RECCOUNT() > 1 OR !m.lcBaseClass == "grid")) ;
          AND (!m.lcParent==m.lcTopMost OR RECNO() = 1) AND !m.llPropsInDEFINE_CLASS

            m.llEndDefine = .F.
            
            *!* (!m.lcParent==m.lcTopMost OR RECNO() = 1) Loop if topmost containers control
            *!* And !m.llPropsInDEFINE_CLASS and no method code - it has been
            *!* defined in topmost container eith ADD OBJECT cname AS cBaseClass WITH
            
            *!* NOTE IF still needs more check then have to add laUniqueId[1,2] Uh...
            *!* cannot use UniqueId or Timestamp both can be same with another record
            *!* -> laControlOk(n,2), SELECT - SQL also recno() from Metadata ->
            *!* save recno() to laControlOk(n,1) and status to laControlOk(n,2)
            *!* .T. control code generated .F. not yet. Note: ecno() from metadata
            *!* is nrec field IN (m.lcTmpGroupCur) Cursor us it and laControlOk(n,2)
            *!* for more robust check
            
            laControlOk(m.lnMetadrecn,2) = .T.
            
            Loop
          Endif
        Endif

        IF Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)>0 AND !m.llAddGirdtoInitNow
        
          *!* See case condition -> never enteres here
          *!* Why the heck this is coded here, maybe some old partly working situation
          *!* and no need anymore. Do not remove yet, there might be some cases 
          *!* not tested yet.
        
        *???* If (!Empty(lcMethods) OR m.lnControlCount>0) AND ;
          !Empty(lcParent) AND !m.lcParent==m.lcTopMost
        
        *??* !Empty(lcMethods) OR m.lnControlCount>0
        *?* Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)>0
        
        *!* Here is DEFINE CLASS name individualixed -> CLASS is subclassed
        *!* Enter here when control has method code or subcontrols
        *!* Do not enter if grid definiton is ended and it shoud write to lccode
        
          * ADD Objects to the Page/Column

          * 14/02/2006 AT START
          * Added full support to ActiveX (= get OleClass value)
          
          * If m.lnDataenvOK # 1 AND INLIST(Lower(Alltrim(BaseClass)),"olecontrol") And ;
          
          If !INLIST(Lower(Alltrim(BaseClass)),"olecontrol") And ;
            !"OleClass"$lcProperties
            lcProperties = lcProperties + "A1_OleClass = "+'"'+ReadOleClass(0)+'"'+CR_LF
          ENDIF
          * 14/02/2006 AT START
          
          * Next code is used to Add Visible = .T. as it is default but
          * When conatiner.addobject() adds an object to the container
          * it is not visible if this is not set here.
          * Add all controls to the inlist not have Visible property
          If !INLIST(Lower(Alltrim(BaseClass)),"header") And ;
            !"Visible = .T."+CR_LF$lcProperties And !"Visible = .F."+CR_LF$lcProperties
            lcProperties = lcProperties + "Visible = .T."+CR_LF
          Endif

          * There is method code in VFP base class. We have to subclass it
          * But we have to subclass it even if not baseclass but contains method code
          Dimension laParents(Alen(laParents,1)+Iif(Vartype(laParents(1,1))="L",0,1),3)
          lcAO_ParentClass = lcParentClass+"_L"+Transform(m.lnContainerLevel)+;
            "_C"+Transform(m.lnControlNumber)+;
            "_TC"+Transform(m.lnTotalControlCount)
          laParents(Alen(laParents,1),1)=lcParent+"."+lcClass
          laParents(Alen(laParents,1),2)=lcAO_ParentClass

          * 25/03/2004 By Arto Toikka browser to support add object to the container inside of a container
          * Do not add objects to the container which is inside of a container
          
          
          * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
          * lcAddObject = IIF(llHTML,[<font color="navy">]+CR_LF,[])+ ;
            IIF(m.lnAppType=2,"This."+JUSTEXT(m.lcParent),;


          * 14/02/2006 AT START
          * Added full support to ActiveX (= get OleClass value)
          If INLIST(Lower(Alltrim(BaseClass)),"olecontrol")
            * m.lnDataenvOK # 1 AND INLIST(Lower(Alltrim(BaseClass)),"olecontrol")
            m.lcOleClass = ',"'+ReadOleClass(0)+'")'
          ELSE
            m.lcOleClass = ")"  
          ENDIF
          * 14/02/2006 AT START
          
          lcAddObject = IIF(llHTML,[<font color="navy">]+CR_LF,[])+ ;
            IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(m.lcParent),;
            m.lcMyObjRef+Strextract(m.lcParent,".",""))+"."+;
            "ADDOBJECT__("+Iif(llHTML,[</font><font color="blue">],[])+ ;
            '"'+lcClass+'","'

          * Next lcParentClass is wrong should be reference to the defined class because contains method
          Do Case
            Case Not llHTML
              lcAddObject=lcAddObject+lcAO_ParentClass+'"'+m.lcOleClass
            Case lcParentClass==lcObjectBaseClass Or Not toBrowser.lFileMode Or ;
                EMPTY(lcClassLoc) Or Not toBrowser.cFileName==lcClassLoc
              lcAddObject=lcAddObject+Iif(llHTML,[<font color="blue">],[])+lcAO_ParentClass+'"'+m.lcOleClass
            Otherwise
              * Hmm??
              lcAddObject=lcAddObject+Iif(llHTML,[<a href="#]+lcAO_ParentClass+[">],[])+lcAO_ParentClass+'"'+ ;
                m.lcOleClass+IIF(llHTML,[</a>],[])
          Endcase
          lcAddObject=lcAddObject+Iif(llHTML,[</font><font color="navy">],[])  && +CR_LF

          If Empty(lcProperties) OR .T. && Actually if this object has methodcode. properties are defined
            * in DEFINE CLASS code
            
            * lcAddObject=toBrowser.IndentText(lcAddObject)+ ;
            *   IIF(llHTML,[<font color="black">],[])
            * lcAddObject=CR_LF+lcAddObject+ ;
            *   IIF(llHTML,[<font color="black">],[])

            * lcAddObject=IIF(INLIST(m.lnAppType,2,4),CHR(9)+CHR(9),CR_lF)+lcAddObject+ ;
            *   IIF(llHTML,[<font color="black">],[])

            * lcAddObject=IIF(m.lnAppType=2,"",CR_lF)+lcAddObject+ ;
              IIF(llHTML,[<font color="black">],[])

            lcAddObject=IIF(INLIST(m.lnAppType,2,4),"",CR_lF)+lcAddObject+ ;
              IIF(llHTML,[<font color="black">],[])
              
          Else
            lcProperties=;
              "With "+m.lcMyObjRef+Strextract(m.lcParent,".","")+"."+lcClass+CR_LF+;
              STRTRAN(Strtran(Strtran(Strtran(toBrowser.FormatProperties(lcProperties,.T.),Chr(13),""),;
              CHR(10),""),;
              CHR(9),Chr(9)+"."),;
              ", ;",CR_LF)+CR_LF+"Endwith"+CR_LF

            * Indent only if Try Endtry routine
            * IF lcParent == m.lcParentColumn
            *   lcAddObject=lcAddObject+Iif(llHTML,[<font color="black">],[])+ ;
            *     CR_LF+toBrowser.IndentText(lcProperties,1)
            * Else
              lcAddObject=lcAddObject+Iif(llHTML,[<font color="black">],[])+ ;
                CR_LF+lcProperties
            * ENdif    
          ENDIF

          * VFP can't add programmatically different types of controls
          * to the column (f.ex. textbox + checkbox) with out a Try Endtry
          * First you need to remove object too otherwise ADDOBJECT generates
          * and error for headers and default column controls.
          
          IF lcParent == m.lcParentColumn AND !EMPTY(lcParent)
             *!* Enters here when generating Grid control code (columns and column subcontrols)
             
            
            * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
            lcAddObject = ;
            IIF(llHTML,[<font color="red">]+CR_LF,[])+ ;
            "Try"+Iif(llHTML,[</font><font color="red">],[])+CR_LF+;
            toBrowser.IndentText(IIF(llHTML,[<font color="navy">],[])+ ;
            IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;            
            lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
            "REMOVEOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
            '"'+lcClass+'")',1)+CR_LF+;
            IIF(llHTML,[<font color="red">],[])+ ;
            "Catch"+CR_LF+;
            "Endtry"+CR_LF+;
            "Try"+Iif(llHTML,[</font><font color="red">],CR_LF)+;
            toBrowser.IndentText(lcAddObject,1)+CR_LF+;
            IIF(llHTML,[<font color="red">],[])+ ;
            "Catch"+CR_LF+;
            "Endtry"+Iif(llHTML,[</font>],[])+CR_LF
          Endif

          *lcAddObject=toBrowser.IndentText(lcAddObject)
          m.lcInsertAddObjCode=m.lcInsertAddObjCode+CR_LF+m.lcAddObject+CR_LF
        Endif

        * If Lower(Alltrim(BaseClass)) == "pageframe" OR Lower(Alltrim(BaseClass)) == "grid"
        If AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0
          Dimension laContainers(Alen(laContainers,1)+Iif(Vartype(laContainers(1,1))="L",0,1),2)
          laContainers(Alen(laContainers,1),1)=lcParent+"."+lcClass+"_"
          laContainers(Alen(laContainers,1),2)=lcParentClass
        Endif

      Endif
      * --- End of AT part

      If Not Empty(lcDefineClass)
        If Not Empty(lcInsertDefineCode)
          lcInsertDefineCode=lcInsertDefineCode+CR_LF+CR_LF
        Endif
        lcCode=lcCode+lcInsertDefineCode+lcAppendDefineCode
        Do While Right(lcCode,2)==CR_LF
          lcCode=Left(lcCode,Len(lcCode)-2)
        ENDDO

        * 02/16/2006 Arto Toikka Added support to multilevel containers and methods
        If m.lnAppType > 0
          IF m.lnMetadrecn > 1
            laControlOk(m.lnMetadrecn-1,2) = .T.
          ENDIF
        Endif
        
        lcCode=lcCode+lcCRLF3+ ;
          IIF(llHTML,[<font color="navy">]+CR_LF,[])+"ENDDEFINE"+CR_LF+ ;
          +Iif(llHTML,CR_LF+[</font><font color="green">]+CR_LF,[])+"*"+CR_LF+ ;
          lcComment+"EndDefine: "+lcDefineClass+CR_LF+lcBorder+ ;
          IIF(llHTML,CR_LF+[</font><font color="black">]+CR_LF,[])+CR_LF+CR_LF
      ENDIF
      

      lcInsertDefineCode=""
      lcAppendDefineCode=""

      If Not Empty(lcDefineClass)
        lcCode=lcCode+CR_LF+Iif(llHTML,[<hr>],CR_LF+CR_LF)+CR_LF+CR_LF
      ENDIF

      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      * Do not write DEFINE CLASS...ENDDEFINE code if methods are added after ADD OBJECT
      * Do not loop if adding Main container code (usually Form) = Empty(lcParent)
      * Do not loop if added with ADDOBJECT() and contains method code
      
      * 02/16/2006 Arto Toikka Added support to multilevel containers and methods
      If m.lnAppType > 0

        IF m.llEndDefine = .F.
      
          If INLIST(m.lnAppType,4,5) AND !Empty(lcParent) AND ;
            !(Empty(lcMethods) OR RECCOUNT() = 1 AND m.lcBaseClass = "grid") ;
             And m.lnControlCount>0 And ;
              LOWER(Alltrim(Parent))+Lower(Alltrim(ObjName)) == m.lcParentName+m.lcObjName And ;
               Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14) = 0
          
            *!* Newer comes here
             
            * IF "SUSPEND"$lcMethods
            *   SUSPEND
            * ENDIF
          
            lcDefineClass = ""
            laControlOk(m.lnMetadrecn,2) = .T.
        
            LOOP
          ENDIF
        
        ELSE
      
          m.llEndDefine = .F.

        ENDIF

      Endif
      
      * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
      * IF m.lnAppType = 2 AND
      
      * If Grid and list of what subs it contains is defined
      * or pageframe  and list of what subs it contains is defined
      * that code shoud be written to the INIT method now
      IF INLIST(m.lnAppType,2,4) AND ;
          !EMPTY(m.lcInsertAddObjCode) AND ;
          (m.llAddGirdtoInitNow OR m.llSavePageFrameSubsNow)

      *?*Ä IF INLIST(m.lnAppType,2,4) AND ;
        !m.lcPreviousContainer == "grid" AND m.lcBaseClass == "grid" AND ;
          !EMPTY(lcInsertAddObjCode)
          
        * lcInsertAddObjCode = FormatProperties(lcInsertAddObjCode,.T.)
        IF ATC("*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *",lcCode)>0


          * Next line is already done in previous m.llAddGridInitNow IF Endif
          * lcInsertAddObjCode = lcInsertAddObjCode + lcInsertRestiveProps
          m.lcInsertAddObjCode = toBrowser.FormatMethods(m.lcInsertAddObjCode)

          lcCode = STRTRAN(lcCode,"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *",;
            m.lcInsertAddObjCode,1,1)+CR_LF
            
          * m.lcInsertRestiveProps = ""
          m.lcInsertAddObjCode = ""
          
          m.llAddGirdtoInitNow = IIF(m.llSavePageFrameSubsNow,m.llAddGirdtoInitNow,.F.)
          m.llDefiningGrid = IIF(m.llSavePageFrameSubsNow,m.llDefiningGrid,.F.)
          
          m.llDefiningPageFrame = IIF(m.llAddGirdtoInitNow,m.llDefiningPageFrame,.F.)
          m.llSavePageFrameSubsNow = IIF(m.llAddGirdtoInitNow,m.llSavePageFrameSubsNow,.F.)

        ENDIF
      ENDIF
      
      * --- End of AT part

      lcDefineClass=lcClass

      If llHTML
        lcCode=lcCode+Iif(llHTML,CR_LF+[<font color="green">]+CR_LF,[])
      Endif
      If llFileMode And Not llSCXMode And Empty(lcCode)
        lnRecNo=Recno()
        Locate
        lcCode=lcCode+lcBorder+CR_LF+ ;
          lcComment+"Class Library:     "+lcFileName+CR_LF
        If Not Empty(Reserved7)
          lcCode=lcCode+toBrowser.IndentText(lcComment+Alltrim(Reserved7))+CR_LF
        Endif
        lcCode=lcCode+lcBorder+lcCRLF3
        Go lnRecNo
      Endif
      lcCode=lcCode+lcBorder+CR_LF+lcComment+Padr(Iif(llSCXMode, ;
        PROPER(lcBaseClass)+":","Class:"),17)+ ;
        IIF(llHTML,[<font color="blue">],[])+lcClass+ ;
        IIF(llHTML,[</font><font color="green">],[])+" ("+lcFileName+")"+CR_LF+ ;
        lcComment+"ParentClass:     "
      Do Case
        Case Not llHTML
          lcCode=lcCode+lcParentClass
        Case lcParentClass==lcBaseClass Or Not toBrowser.lFileMode Or ;
            EMPTY(lcClassLoc) Or Not toBrowser.cFileName==lcClassLoc
          lcCode=lcCode+Iif(llHTML,[</font><font color="blue">],[])+lcParentClass
        Otherwise
          lcCode=lcCode+Iif(llHTML,[<a href="#]+lcParentClass+[">],[])+lcParentClass+ ;
            IIF(llHTML,[</a>],[])
      Endcase
      lcCode=lcCode+Iif(llHTML,[</font><font color="green">],[])+Iif(Empty(lcClassLoc),""," ("+lcClassLoc+")")+CR_LF+ ;
        lcComment+"BaseClass:       "+Iif(llHTML,[</font><font color="blue">],[])+ ;
        lcBaseClass+Iif(llHTML,[</font><font color="green">  ],[])+CR_LF
      lcTimeStamp=toBrowser.GetTimeStamp(Timestamp)
      If Not Empty(lcTimeStamp)
        lcCode=lcCode+lcComment+M_TIMESTAMP_LOC+"    "+lcTimeStamp+CR_LF
      Endif
      If Not Empty(OLE2)
        lcCode=lcCode+lcComment+Mline(OLE2,1)+CR_LF
      Endif
      If Not Empty(Reserved7)
        lcCode=lcCode+lcComment+Reserved7+CR_LF
      Endif
      lcCode=toBrowser.IndentText(lcCode)
      
      
      * 02/27/2006 This reads INCLUDE file if any for the MODES 2-5
      If m.lnAppType > 0 AND llSCXMode
        IF !m.llIncludeDefined
          m.llIncludeDefined = .T.
          Select (toBrowser.cAlias)
          lnRecNo=Recno()
          LOCATE
          If Not Empty(Reserved8)
            m.lcIncludeCode = [#INCLUDE ]+Chr(34)+ ;
              LOWER(Fullpath(Alltrim(Mline(Reserved8,1)),lcFileName))+ ;
              CHR(34)+CR_LF+CR_LF
          ENDIF
          Go lnRecNo
          Select (m.lcTmpGroupCur)
        Endif  
      Else  
        * MS original
        If llSCXMode
          lnRecNo=Recno()
          Locate
        Endif
        If Not Empty(Reserved8)
          lcCode=lcCode+"*"+CR_LF+[#INCLUDE ]+Chr(34)+ ;
            LOWER(Fullpath(Alltrim(Mline(Reserved8,1)),lcFileName))+ ;
            CHR(34)+CR_LF
        Endif
        If llSCXMode
          Go lnRecNo
        Endif
      Endif

      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      If m.lnAppType > 0
        * Define Class name for objects that have methods or controls inside
        * or is in main container and m.llPropsInDEFINE_CLASS
        IF m.llSCXmode AND Lower(Alltrim(BaseClass)) == "dataenvironment"
          Dimension laParents(Alen(laParents,1)+Iif(Vartype(laParents(1,1))="L",0,1),3)
          lcClass = lcClass+"_L"+Transform(m.lnContainerLevel)+;
            "_C"+Transform(m.lnControlNumber)+;
            "_TC"+Transform(m.lnTotalControlCount)
          laParents(Alen(laParents,1),1)=lcParent+"."+lcClass
          laParents(Alen(laParents,1),2)=lcClass
          m.lcDataEnvName = lcClass
        Else
          If !Empty(lcParent) And !Empty(lcMethods) OR m.lcParent==m.lcTopMost OR m.lnControlCount > 0 OR ;
            m.llPropsInDEFINE_CLASS 
            && m.llPropsInDEFINE_CLASS=.T. -> it is subclassed and now we have to get it subclass name
          
            m.lnaParentsRow = Ascan(laParents,lcParent+"."+lcClass,-1,-1,1,14)
            If m.lnaParentsRow>0
              lcClass = laParents(m.lnaParentsRow,2)
              * Flag that properties are defined already in ADD OBJECT because of
              * cyclic definition and should not be defined in DEFINE CALSS again.
              m.llCyclicClassDefinition = laParents(m.lnaParentsRow,3)
            ENDIF
          ENDIF
        Endif  
      Endif
      * --- End of AT part

      lcCode=lcCode+"*"+CR_LF+Iif(llHTML,[<font color="navy">]+CR_LF+ ;
        [<a name="]+lcClass+[">]+CR_LF,[])+ ;
        "DEFINE CLASS "+Iif(llHTML,[</a></font><font color="blue">],[])+lcClass+ ;
        IIF(llHTML,[</font><font color="navy">],[])+" AS "
      Do Case
        Case Not llHTML
          lcCode=lcCode+lcParentClass
        Case lcParentClass==lcBaseClass Or Not toBrowser.lFileMode Or ;
            EMPTY(lcClassLoc) Or Not toBrowser.cFileName==lcClassLoc
          lcCode=lcCode+Iif(llHTML,[</font><font color="blue">],[])+lcParentClass
        Otherwise
          lcCode=lcCode+Iif(llHTML,[<a href="#]+lcParentClass+[">],[])+lcParentClass+ ;
            IIF(llHTML,[</a>],[])
      Endcase
      If Not llSCXMode
        lnRecNo=Recno()
        Locate For Upper(Alltrim(Platform))=="COMMENT" And ;
          LOWER(Alltrim(ObjName))==lcClass
        If Not Eof() And Upper(Alltrim(Mline(Reserved2,1)))=="OLEPUBLIC"
          lcCode=lcCode+Iif(llHTML,[<font color="navy">],[])+" OLEPUBLIC"
        Endif
        Go lnRecNo
      Endif
      lcCode=lcCode+CR_LF+Iif(llHTML,[</font><font color="black">]+CR_LF,[])+CR_LF

      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      If m.lnAppType > 0
        * Adding properties to the current DEFINE CLASS
        * SET STEP ON
        
        IF (!Empty(lcProperties) AND ;
          (EMPTY(lcParent) OR !Empty(lcMethods) OR m.lnControlCount > 0) OR ;
          m.llPropsInDEFINE_CLASS OR ;
          AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)=0) AND ;
          !m.llCyclicClassDefinition
          
          *!* In the case of cyclical class definition ( = same baseclass and same name) 
          *!* daughter properties have to write with ADD OBJECT in parents DEFINE CLASS

        *??* IF (!Empty(lcProperties) AND ;
          (EMPTY(lcParent) OR !Empty(lcMethods) OR m.lnControlCount > 0) AND ;
          !m.llCyclicClassDefinition) AND (m.llPropsInDEFINE_CLASS OR ;
          AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)=0)
          
          *?* IF (!Empty(lcProperties) AND (EMPTY(lcParent) OR ;
          !Empty(lcMethods) OR m.lcParent==m.lcTopMost OR ;
          m.lnControlCount > 0) AND !m.llCyclicClassDefinition) AND ;
          (m.llPropsInDEFINE_CLASS OR ;
          AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)=0)
            
          *!* Enters here 
          *!* If properties
          *!* No parent ( = topmost container )
          *!* If subclassed - methods exist or subcontrols exist
          *!* if m.llPropsInDEFINE_CLASS i.e. properties definend in subclass
          *!* If control is subclassed even if no method or properties
          *!* those controls are definend in m.lcAddInitContainers
         
          && AND m.lnaParentsRow > 0) ?????
          
          * ((!Empty(lcMethods) OR m.lcParent==m.lcTopMost OR ;
          *  m.lnControlCount > 0) AND m.lnaParentsRow > 0)
         
          *!* Add Dataenvironment variables to the main container if dataenvironment exist
          IF m.llSCXMode AND m.lnDataenvOK = 2 AND EMPTY(lcParent)  && OR m.lcParent==m.lcTopMost
            *!* Have to add dummy . so that FomatProperties don't add quotation marks
            * lcProperties = 'DEClassLibrary = .CHR(34)+FORCEEXT(FULLPATH(PROGRAM(0),"prg"))+CHR(34)'+CR_LF+lcProperties
            * FULLPATH(PROGRAM(0)) changed to SYS(16) it is because FULLPATH(PROGRAM(0)) 
            * in DEFINE CLASS doesn't return file extension
            lcProperties = 'DEClassLibrary = .CHR(34)+SYS(16)+CHR(34)'+CR_LF+lcProperties
            lcProperties = "DEClass = "+m.lcDataEnvName+CR_LF+lcProperties
          ENDIF

          * 14/02/2006 AT START
          * Added ~full support to ActiveX (= get OleClass value)
          If m.lnDataenvOK # 1 AND INLIST(Lower(Alltrim(BaseClass)),"olecontrol") And ;
            !"OleClass"$lcProperties
            lcProperties = lcProperties + "OleClass = "+'"'+ReadOleClass(0)+'"'+CR_LF
          ENDIF
          * 14/02/2006 AT START

          * Visible = .T. is missing from the properties field. Added here
          If m.lnDataenvOK # 1 AND !INLIST(Lower(Alltrim(BaseClass)),"header") And ;
            !"Visible = .T."+CR_LF$lcProperties And !"Visible = .F."+CR_LF$lcProperties
            lcProperties = lcProperties + "Visible = .T."+CR_LF
          Endif

          lcProperties = toBrowser.FormatProperties(lcProperties)

          IF m.llSCXMode AND m.lnDataenvOK = 2 AND EMPTY(lcParent)  && OR m.lcParent==m.lcTopMost
            *!* Remove dummy .
            lcProperties = STRTRAN(lcProperties,".CHR(34)","CHR(34)",1,1)
          Endif
          
          lcInsertDefineCode=lcInsertDefineCode+CR_LF+;
            lcProperties
            
        Endif
      Else
        * MS Part
        If Not Empty(lcProperties)
          lcInsertDefineCode=lcInsertDefineCode+CR_LF+ ;
            toBrowser.FormatProperties(lcProperties)
        Endif
      Endif

      Do While Right(lcInsertDefineCode,2)==CR_LF
        lcInsertDefineCode=Left(lcInsertDefineCode,Len(lcInsertDefineCode)-2)
      Enddo
      lcInsertDefineCode=lcInsertDefineCode+CR_LF
      For lnCount = 1 To lnMemberCount
        lcMember=Alltrim(laMembers[lnCount])
        llHidden=("^"$lcMember)
        lcMember2=Alltrim(Strtran(lcMember,"^",""))
        lcMemberDesc=laMemberDesc[lnCount]
        lnAtPos=At(MARKER,lcMemberDesc)
        If lnAtPos=0
          lcArrayInfo=""
        Else
          lcArrayInfo=Substr(lcMemberDesc,lnAtPos+1)
          lcMemberDesc=Left(lcMemberDesc,lnAtPos-1)
        Endif
        If Not Empty(lcMemberDesc)
          lnAtPos=Atc(Tab+lcMember2+" = ",lcInsertDefineCode)
          If lnAtPos=0
            lcInsertDefineCode=lcInsertDefineCode+CR_LF+ ;
              IIF(llHTML,[<font color="green">],[])+ ;
              toBrowser.IndentText(toBrowser.IndentText(lcComment+ ;
              lcMemberDesc),1)+Iif(llHTML,[</font><font color="black">],[])+CR_LF
          Else
            lcInsertDefineCode=Left(lcInsertDefineCode,lnAtPos-1)+ ;
              IIF(llHTML,[<font color="green">],[])+ ;
              toBrowser.IndentText(toBrowser.IndentText(lcComment+ ;
              lcMemberDesc),1)+Iif(llHTML,[</font><font color="black">],[])+CR_LF+ ;
              SUBSTR(lcInsertDefineCode,lnAtPos)
          Endif
        Endif
        lnElement=Ascan(laProtected,lcMember+" ")
        If lnElement=0
          lnElement=Ascan(laProtected,lcMember+"^ ")
          If lnElement>0
            llHidden=.T.
          Endif
        Endif
        If lnElement>0
          laProtected[lnElement]=""
        Endif
        If Empty(lcArrayInfo)
          lnAtPos=Atc(Tab+lcMember2+" ",lcInsertDefineCode)
          If lnElement>0
            If lnAtPos=0
              lcInsertDefineCode=lcInsertDefineCode+Tab+ ;
                IIF(llHidden,"HIDDEN ","PROTECTED ")+lcMember2+CR_LF
              Loop
            Else
              lcInsertDefineCode=Left(lcInsertDefineCode,lnAtPos-1)+ ;
                TAB+Iif(llHidden,"HIDDEN ","PROTECTED ")+lcMember2+CR_LF+ ;
                SUBSTR(lcInsertDefineCode,lnAtPos)
            Endif
          Endif
          If lnAtPos>0
            Loop
          Endif
        Else
          lcInsertDefineCode=lcInsertDefineCode+Tab+ ;
            IIF(lnElement>0,Iif(llHidden,"HIDDEN ","PROTECTED "), ;
            "DIMENSION ")+lcMember2+lcArrayInfo+CR_LF
        Endif
        If Empty(lcArrayInfo)
          lcInsertDefineCode=lcInsertDefineCode+Tab+lcMember2+" = .F."+CR_LF
        Endif
      Endfor
      For lnCount = 1 To lnProtectedCount
        lcMember=Alltrim(laProtected[lnCount])
        If Empty(lcMember)
          Loop
        Endif
        llHidden=("^"$lcMember)
        lcMember2=Alltrim(Strtran(lcMember,"^",""))
        lcInsertDefineCode=lcInsertDefineCode+Tab+ ;
          IIF(llHidden,"HIDDEN ","PROTECTED ")+lcMember2+CR_LF
        laProtected[lnCount]=""
      Endfor
      
      * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
      * If m.lnAppType=2 AND m.lnControlCount>0 AND RECNO() = 1 AND 
      If INLIST(m.lnAppType,2,4) AND m.lnControlCount>0 AND RECNO() = 1 AND ;
        (AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0)

        *?* If INLIST(m.lnAppType,2,4) AND ;
          (AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0) AND ;
            (m.lnControlCount > 0 OR (RECCOUNT() = 1 AND m.lcBaseClass = "grid" ;
            AND !m.lcPreviousContainer=="grid"))
          
        *!* Enters here when top branch container (recno() = 1) has method or subcontrols
        *!* And INLIST(m.lnAppType,2,4) I.e. ADDOBJECT() codes for its subcontrol
        *!* is written in its INIT. Here is generated INIT tag with is latter on
        *!* replaced with the code block of ADDOBJECT()s
        *!* Only when top branch container is pageframe or grid
        
        * SET STEP ON 
       
        If Not Empty(lcMethods)
          Alines(laMethodLines, lcMethods)
          **
          m.lcExact = Set("EXACT")
          Set Exact Off
          m.llInitStart = 0
          m.llInitEnd = 0
          m.llInitAdd = 0
        
          For m.lni = 1 To Alen(laMethodLines,1)
            If Lower(laMethodLines(m.lni)) == "procedure "+m.lcInitName Or ;
                LOWER(laMethodLines(m.lni)) == "hidden procedure "+m.lcInitName Or ;
                LOWER(laMethodLines(m.lni)) == "protected procedure "+m.lcInitName
              m.llInitStart = m.lni
              Exit
            Endif
          Endfor
          
          If m.llInitStart > 0
            m.llInitAdd = m.llInitStart
            For m.lni = m.llInitStart To Alen(laMethodLines,1)
              If Lower(laMethodLines(m.lni)) == "endproc"
                m.llInitEnd = m.lni
                Exit
              Endif
            Endfor
            m.llInitEnd = Iif(m.llInitEnd = 0,Alen(laMethodLines,1),m.llInitEnd)
        
            For m.lni = m.llInitStart + 1 To m.llInitEnd - 1
              If Lower(Alltrim(laMethodLines(m.lni)))="param" Or ;
                  LOWER(Alltrim(laMethodLines(m.lni)))="lpara"
                m.llInitAdd = m.lni
              Endif
              If m.llInitAdd > m.llInitStart
                *!* param or lparam found
                *!* Check if para / lpara line continues with ";"
                If Right(Alltrim(laMethodLines(m.lni)),1) == ";"
                  Loop
                Else
                  m.llInitAdd = m.lni
                  Exit
                Endif
              Endif
            Endfor
            Dimension laMethodLines(Alen(laMethodLines,1)+1)
            Ains(laMethodLines,m.llInitAdd+1)
            
            * laMethodLines(m.llInitAdd+1) = CHR(9)+CHR(9)+"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"
            laMethodLines(m.llInitAdd+1) = "*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"
        
            m.lcMethods = ""
            For m.lni = 1 To Alen(laMethodLines,1)
              IF m.lni = m.llInitStart
                laMethodLines(m.lni) = laMethodLines(m.lni) + " "+Chr(38)+Chr(38)+" 1 "
              ENDIF
              m.lcMethods = m.lcMethods  + laMethodLines(m.lni)+CR_LF
            Endfor
          Else
            * lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 2 "+CR_LF+;
              CHR(9)+CHR(9)+"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
              "ENDPROC" + CR_LF + ;
              lcMethods
            
            lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 2 "+CR_LF+;
              "*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
              "ENDPROC" + CR_LF + ;
              lcMethods
        
          Endif
          Set Exact &lcExact
        Else
          *lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 3 "+CR_LF+;
            CHR(9)+CHR(9)+"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
            "ENDPROC"
          lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 3 "+CR_LF+;
            "*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
            "ENDPROC"
        ENDIF
      Endif
  
      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      * Write method code if Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14) > 0
      * I.e. control added with ADDOBJECT()
      If .T. && 

      *!* Old code
      *?* If m.lnAppType < 4 OR Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14) > 0 OR ;
        (m.lnAppType = 4 AND EMPTY(lcParent)) OR m.lnAppType = 5
        
        If Not Empty(lcMethods)
          lcAppendDefineCode=lcAppendDefineCode+toBrowser.FormatMethods(lcMethods)
        ENDIF
      Endif
      * --- End of AT part
      
      * MS Code (Above contains this too)
      * If Not Empty(lcMethods)
      *   lcAppendDefineCode=lcAppendDefineCode+toBrowser.FormatMethods(lcMethods)
      * ENDIF

    Case Not Empty(lcClass) And Not Empty(lcParent)
      lcObjectClass=Iif(lcParent==lcDefineClass,"",lcParent+".")+lcClass
      lcObjectBaseClass=Lower(Alltrim(BaseClass))
      
      *IF lcObjectBaseClass = "pageframe"
      *  SET STEP ON 
      *endif

      * Case last modified 06/09/2005 AT
      * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
      * If m.lnAppType = 0 Or !Empty(lcMethods) OR m.lnControlCount>0
      
      If m.lnAppType = 0 Or ;
        (Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0 AND !m.llDefiningGrid)
      
        *??* Or RECNO() > 1
      
        *?* If m.lnAppType = 0 Or Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0
        *!* Enters here when MS mode or Generating top branch container 
        *!* ADD OBJECT code to its subcontrols
        *!* DO not enter here if grid or pageframe. Grid or pageframe controls
        *!* are not added with ADD OBJECT
        *!* !m.lnContainerParent == "grid" AND !m.lnContainerParent == "pageframe"
        *!* i.e. !INLIST(m.lnContainerParent,m.lcAddInitContainers)

        If m.lnAppType > 0
          * SET STEP ON
          lcAddObject=Iif(llHTML,[<font color="navy">]+CR_LF,[])+ ;
            "ADD OBJECT "+Iif(llHTML,[</font><font color="blue">],[])+ ;
            lcClass+Iif(llHTML,[</font><font color="navy">],[])+" AS "

          If AT(","+lcObjectBaseClass+",",m.lcAddInitContainers)>0
            Dimension laContainers(Alen(laContainers,1)+Iif(Vartype(laContainers(1,1))="L",0,1),2)
            laContainers(Alen(laContainers,1),1)=lcParent+"."+lcClass+"_"
            laContainers(Alen(laContainers,1),2)=lcParentClass
          Endif

          * There is method code in VFP base class. We have to subclass it
          * But we have to subclass it even if not baseclass but contains method code
          * Also it have to subclass if it has controls inside
          * Also all objects in main container is subclassed !!!
          
          If !Empty(lcMethods) OR m.lnControlCount > 0 OR ;
            INLIST(lcObjectBaseClass,"grid","pageframe") OR m.llPropsInDEFINE_CLASS

            * INLIST(lcObjectBaseClass,"grid","olecontrol") OR m.llPropsInDEFINE_CLASS

            *?* If !Empty(lcMethods) OR m.lnControlCount > 0 OR m.lcParent==m.lcTopMost OR ;
            INLIST(lcObjectBaseClass,"grid")
            
            *!* Enters here if controls must have individualized name
            *!* I.e. when it has methods or subcontrols (=container)
            *!* or it is grid = container
            *!* IF m.lcParent==m.lcTopMost then all controls main container are subclassed too
            *!* If properties are defined in DEFINE CLASS i.e. control is subclassed
            *!* ( m.llPropsInDEFINE_CLASS = .T. ) then enters here too.
            *!* olecontrols should always subclassed then add OleClass = cOleClassRegistryName
            *!* to the DEFINE CLASS cOleName AS olecontrol
            *!* otherwise Insert Object window is popping up and asking Inserted activex type
            
            * 14/02/2006 AT START
            *!* no need to olecontrol to enter here: OleClass = cOleClassRegistryName
            *!* works very well in DEFINE CLASS .... WITH... properties too.
            * 14/02/2006 AT END
            
            && m.lcParent==m.lcTopMost apparently never

            *?* If (!Empty(lcMethods) OR m.lcParent==m.lcTopMost) And INLIST(m.lnAppType,2,3) OR m.lnControlCount > 0 OR ;
              INLIST(lcObjectBaseClass,"grid")
            
            && Empty(lcClassLoc) = VFP Base class
            Dimension laParents(Alen(laParents,1)+Iif(Vartype(laParents(1,1))="L",0,1),3)
            lcParentClass = lcParentClass+"_L"+Transform(m.lnContainerLevel)+;
              "_C"+Transform(m.lnControlNumber)+;
              "_TC"+Transform(m.lnTotalControlCount)
            laParents(Alen(laParents,1),1)=lcParent+"."+lcClass
            laParents(Alen(laParents,1),2)=lcParentClass
            laParents(Alen(laParents,1),3)=m.llCyclicClassDefinition
          Endif
          * --- End of AT part

        Else

          * MS part
          lcAddObject=Iif(llHTML,[<font color="navy">]+CR_LF,[])+ ;
            "ADD OBJECT "+Iif(llHTML,[</font><font color="blue">],[])+ ;
            lcObjectClass+Iif(llHTML,[</font><font color="navy">],[])+" AS "
        Endif

        Do Case
          Case Not llHTML
            lcAddObject=lcAddObject+lcParentClass
          Case lcParentClass==lcObjectBaseClass Or Not toBrowser.lFileMode Or ;
              EMPTY(lcClassLoc) Or Not toBrowser.cFileName==lcClassLoc
            lcAddObject=lcAddObject+Iif(llHTML,[<font color="blue">],[])+lcParentClass
          Otherwise
            lcAddObject=lcAddObject+Iif(llHTML,[<a href="#]+lcParentClass+[">],[])+lcParentClass+ ;
              IIF(llHTML,[</a>],[])
        Endcase
        lcAddObject=lcAddObject+Iif(llHTML,[</font><font color="navy">],[])
        If Upper(Alltrim(Reserved8))=="NOINIT"
          lcAddObject=lcAddObject+" NOINIT"
        Endif

        * 09/09/2004 Arto Toikka Added support to multilevel containers and methods
        IF m.lnAppType > 0

          If (Empty(lcProperties) OR ;
            (!Empty(lcMethods) OR m.lnControlCount > 0) OR m.llPropsInDEFINE_CLASS OR ;
            AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0) AND ;
            !m.llCyclicClassDefinition
            
            *!* In the case of cyclical class definition ( = same baseclass and same name) 
            *!* daughter properties have to write with ADD OBJECT in parents DEFINE CLASS

          *?* If (Empty(lcProperties) OR ;
            (!Empty(lcMethods) OR m.lnControlCount > 0) AND ;
            !m.llCyclicClassDefinition) OR m.llPropsInDEFINE_CLASS OR ;
            AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0
           
            *!* Enters here 
            *!* if no properties
            *!* If subclassed - methods exist or subcontrols exist
            *!* if m.llPropsInDEFINE_CLASS i.e. properties definend in subclass
            *!* If control are in m.lcAddInitContainers list -> have to subclass
            *!* and then not ADD OBJECTed but DECINE CLASSed

            *?* If (Empty(lcProperties) OR ((!Empty(lcMethods) OR m.lcParent==m.lcTopMost) And ;
            INLIST(m.lnAppType,2,3) OR m.lnControlCount > 0) AND !m.llCyclicClassDefinition) OR ;
            (m.llPropsInDEFINE_CLASS AND AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0)
            
            lcAddObject=toBrowser.IndentText(lcAddObject,1)+ ;
              IIF(llHTML,[<font color="black">],[])
          ELSE

            * 14/02/2006 AT START
            * Added full support to ActiveX (= get OleClass value)
            If INLIST(Lower(Alltrim(BaseClass)),"olecontrol") And ;
              !"OleClass"$lcProperties
              lcProperties = lcProperties + "OleClass = "+'"'+ReadOleClass(0)+'"'+CR_LF
            ENDIF
            * 14/02/2006 AT START

            If !INLIST(Lower(Alltrim(BaseClass)),"header") And ;
              !"Visible = .T."+CR_LF$lcProperties And !"Visible = .F."+CR_LF$lcProperties
              lcProperties = lcProperties + "Visible = .T."+CR_LF
            Endif
          
            lcProperties=toBrowser.FormatProperties(lcProperties,.T.)
            lcAddObject=lcAddObject+" WITH "+Iif(llHTML,[<font color="black">],[])+";"+ ;
              CR_LF+toBrowser.IndentText(lcProperties,1)
          ENDIF
        ELSE
          * MS part
          If Empty(lcProperties)
            lcAddObject=toBrowser.IndentText(lcAddObject)+ ;
              IIF(llHTML,[<font color="black">],[])
          Else
            lcProperties=toBrowser.FormatProperties(lcProperties,.T.)
            lcAddObject=lcAddObject+" WITH "+Iif(llHTML,[<font color="black">],[])+";"+ ;
              CR_LF+toBrowser.IndentText(lcProperties,1)
          ENDIF
        ENDIF
          
        lcAddObject=toBrowser.IndentText(lcAddObject)

        * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
        If m.lnAppType > 0
          * Add only container method code to the DEFINE CLASS ... ENDDEFINE

          * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
          * Write method code if m.lnAppType = 2 (AT mode method code after ADD OBJECT)
          If (!Empty(lcMethods) OR m.lnControlCount > 0) And recno() = 1

            *?* If INLIST(m.lnAppType,4,5) And ;
                LOWER(Alltrim(Parent))+Lower(Alltrim(ObjName)) == m.lcParentName+m.lcObjName
               
            *!* Enteres here when generating current container method or it has ADDOBJECT() code
            *!* This generation happens only when recno() = 1 i.e. is container and top of the branch
            *!* Only when top bracnch container is pageframe or grid
              
            * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
            If (AT(","+Lower(Alltrim(BaseClass))+",",m.lcAddInitContainers)>0) AND ;
               INLIST(m.lnAppType,3,5)  && m.lnControlCount > 0
                * m.lnAppType = 5  && m.lnControlCount > 0
              
              * INLIST(m.lnAppType,3,5)
                
              *!* Never enters here ??? Then why the heck this code is?
              
              SET STEP ON  
              
              If Not Empty(lcMethods)
                Alines(laMethodLines, lcMethods)
                **
                m.lcExact = Set("EXACT")
                Set Exact Off
                m.llInitStart = 0
                m.llInitEnd = 0
                m.llInitAdd = 0
              
                For m.lni = 1 To Alen(laMethodLines,1)
                  If Lower(laMethodLines(m.lni)) == "procedure "+m.lcInitName Or ;
                      LOWER(laMethodLines(m.lni)) == "hidden procedure "+m.lcInitName Or ;
                      LOWER(laMethodLines(m.lni)) == "protected procedure "+m.lcInitName
                    m.llInitStart = m.lni
                    Exit
                  Endif
                Endfor
                If m.llInitStart > 0
                  m.llInitAdd = m.llInitStart
                  For m.lni = m.llInitStart To Alen(laMethodLines,1)
                    If Lower(laMethodLines(m.lni)) == "endproc"
                      m.llInitEnd = m.lni
                      Exit
                    Endif
                  Endfor
                  m.llInitEnd = Iif(m.llInitEnd = 0,Alen(laMethodLines,1),m.llInitEnd)
              
                  For m.lni = m.llInitStart + 1 To m.llInitEnd - 1
                    If Lower(Alltrim(laMethodLines(m.lni)))="param" Or ;
                        LOWER(Alltrim(laMethodLines(m.lni)))="lpara"
                      m.llInitAdd = m.lni
                    Endif
                    If m.llInitAdd > m.llInitStart
                      *!* param or lparam found
                      *!* Check if para / lpara line continues with ";"
                      If Right(Alltrim(laMethodLines(m.lni)),1) == ";"
                        Loop
                      Else
                        m.llInitAdd = m.lni
                        Exit
                      Endif
                    Endif
                  Endfor
                  Dimension laMethodLines(Alen(laMethodLines,1)+1)
                  Ains(laMethodLines,m.llInitAdd+1)
                  
                  * laMethodLines(m.llInitAdd+1) = CHR(9)+CHR(9)+"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"
                  laMethodLines(m.llInitAdd+1) = "*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"
              
                  m.lcMethods = ""
                  For m.lni = 1 To Alen(laMethodLines,1)
                    IF m.lni = m.llInitStart
                      laMethodLines(m.lni) = laMethodLines(m.lni) + " "+Chr(38)+Chr(38)+" 1 "
                    ENDIF
                    m.lcMethods = m.lcMethods  + laMethodLines(m.lni)+CR_LF
                  Endfor
                Else
                  * lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 2 "+CR_LF+;
                    CHR(9)+CHR(9)+"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
                    "ENDPROC" + CR_LF + ;
                    lcMethods
                  
                  lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 2 "+CR_LF+;
                    "*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
                    "ENDPROC" + CR_LF + ;
                    lcMethods
              
                Endif
                Set Exact &lcExact
              Else
                *lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 3 "+CR_LF+;
                  CHR(9)+CHR(9)+"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
                  "ENDPROC"
                lcMethods = "PROCEDURE "+Upper(Left(m.lcInitName,1))+Substr(m.lcInitName,2)+" "+Chr(38)+Chr(38)+" 3 "+CR_LF+;
                  "*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *"+CR_LF+;
                  "ENDPROC"
              ENDIF
            ELSE
              ASSERT .F. MESSAGE "!!!!!!!!!!!!!!!!!!!!NOW I WOULD LIKE TO ADD INIT MARKER!!!!!!!!!!!!!"
            Endif
              
            lcMethods=toBrowser.FormatMethods(lcMethods)
            lcMethods=Strtran(lcMethods,"PROCEDURE ","PROCEDURE "+lcClass+".")
            If Not Empty(lcAppendDefineCode)
              lcAppendDefineCode=lcAppendDefineCode+CR_LF
            Endif
            lcAppendDefineCode=lcAppendDefineCode+lcMethods
          Endif
          * --- End of AT part
        Else

          * MS

          If Not Empty(lcMethods)
            lcMethods=toBrowser.FormatMethods(lcMethods)

			* AT Note! Code below was added into the VFP9 source code
			* but it was commented out -> it is in no use in VFP9 browser
			
			* RMK - 2004/05/11 - per ID 233847, added code to put in full object hierarchy here
			*lcFullParent = parent + '.' + ObjName
			*lcMethods=STRTRAN(lcMethods,"PROCEDURE ","PROCEDURE "+ lcFullParent + ".")
            
            lcMethods=Strtran(lcMethods,"PROCEDURE ","PROCEDURE "+lcClass+".")
            If Not Empty(lcAppendDefineCode)
              lcAppendDefineCode=lcAppendDefineCode+CR_LF
            Endif
            lcAppendDefineCode=lcAppendDefineCode+lcMethods
          Endif
        Endif
        lcInsertDefineCode=lcInsertDefineCode+CR_LF+CR_LF+lcAddObject+CR_LF

      Else
      
        * Enters here if control is not top of the branch container
        * This code is generate to the branch INIT (= INLIST(m.lnAppType,2,4)
        * or between oForm1=NEWOBJECT() ... Show.oForm1 (= INLIST(m.lnAppType,3,5)
        
        * Pageframe or Column container
        * ( = Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)>0 ) 

        If AT(","+lcObjectBaseClass+",",m.lcAddInitContainers)>0
          Dimension laContainers(Alen(laContainers,1)+Iif(Vartype(laContainers(1,1))="L",0,1),2)
          laContainers(Alen(laContainers,1),1)=lcParent+"."+lcClass+"_"
          laContainers(Alen(laContainers,1),2)=lcParentClass
        Endif

        * ARTO ARTO ARTO
        IF (!Empty(lcMethods) OR m.lnControlCount > 0) AND ;
           (m.llDefiningGrid OR recno() > 1) OR m.llPropsInDEFINE_CLASS
           
          * ;
          * Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0 OR ;
          * m.llDefiningGrid

          && And recno() > 1
          && Ascan(laContainers,Juststem(lcParent)+"_",-1,-1,1,14)=0
          *!* same as
          *!* !m.lnContainerParent == "grid" AND !m.lnContainerParent == "pageframe"
          *!* i.e. !INLIST(m.lnContainerParent,m.lcAddInitContainers)
          
        
          Dimension laParents(Alen(laParents,1)+Iif(Vartype(laParents(1,1))="L",0,1),3)
          lcParentClass = lcParentClass+"_L"+Transform(m.lnContainerLevel)+;
            "_C"+Transform(m.lnControlNumber)+;
            "_TC"+Transform(m.lnTotalControlCount)
          laParents(Alen(laParents,1),1)=lcParent+"."+lcClass
          laParents(Alen(laParents,1),2)=lcParentClass
        Endif

        * * It have to subclass if it has controls inside
        * If m.lnControlCount > 0 && Empty(lcClassLoc)  && = VFP Base class
        *   Dimension laParents(Alen(laParents,1)+Iif(Vartype(laParents(1,1))="L",0,1),2)
        *   lcParentClass = lcParentClass+"_L"+Transform(m.lnContainerLevel)+;
        *     "_C"+Transform(m.lnControlNumber)+;
        *     "_TC"+Transform(m.lnTotalControlCount)
        *   laParents(Alen(laParents,1),1)=lcParent+"."+lcClass
        *   laParents(Alen(laParents,1),2)=lcParentClass
        * Endif

        * 25/203/2004 By Arto Toikka browser to support add object to the container inside of a container
        
        * Next code is used to Add Visible = .T. as it is default but
        * When conatiner.addobject() adds an object to the container
        * it is not visible if this is not set here.
        * Add all controls to the inlist not have Visible property
        If !INLIST(Lower(Alltrim(BaseClass)),"header") And ;
          !"Visible = .T."+CR_LF$lcProperties And !"Visible = .F."+CR_LF$lcProperties
          lcProperties = lcProperties + "Visible = .T."+CR_LF
        ENDIF

        * IF lcParent == m.lcParentColumn
        *   * IF Lower(Alltrim(BaseClass)) == "header" OR ;
        *   *   lcParent+"."+lcClass == m.lcParentColumn
        *   lcAddObject = ;
        *     IIF(llHTML,[<font color="navy">]+CR_LF,[])+ ;
        *     "Try"+CR_LF+;
        *     lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".","")+;
        *     "REMOVEOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
        *     '"'+lcClass+'")'+CR_LF
        * ELSE
        *   lcAddObject = ""
        * Endif
        
        * m.lni1 = ASCAN(laAddParentProps,m.lcParentName+".",-1,-1,2,14)
        * IF m.lni1 > 0
        *   lcAddObject = IIF(llHTML,[<font color="navy">]+CR_LF,[])+ ;
        *     
        *     m.lcMyObjRef+Strextract(m.lcParentName,".","")+"."+lcClass+CR_LF+;
        *     
        *     lcMyObjRef+
        *     
        *     Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".","")+;
        *     "ADDOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
        *     '"'+lcClass+'","'
        
        * HOIJAA2


        * 14/02/2006 AT START
        * Added full support to ActiveX (= get OleClass value)
        If INLIST(Lower(Alltrim(BaseClass)),"olecontrol") AND !m.llPropsInDEFINE_CLASS AND Empty(lcMethods)
          m.lcOleClass = ',"'+ReadOleClass(0)+'")'
        ELSE
          m.lcOleClass = ")"  
        ENDIF
        * 14/02/2006 AT START
       
        * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
        m.lcAddObject = IIF(llHTML,[<font color="navy">]+CR_LF,[])+ ;
          IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
          m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
          "ADDOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
          '"'+lcClass+'","'
          
        Do Case
          Case Not llHTML
            lcAddObject=lcAddObject+lcParentClass+'"'+m.lcOleClass
          Case lcParentClass==lcObjectBaseClass Or Not toBrowser.lFileMode Or ;
              EMPTY(lcClassLoc) Or Not toBrowser.cFileName==lcClassLoc
            lcAddObject=lcAddObject+Iif(llHTML,[<font color="blue">],[])+lcParentClass+'"'+m.lcOleClass
          Otherwise
            * Hmm??
            lcAddObject=lcAddObject+Iif(llHTML,[<a href="#]+lcParentClass+[">],[])+lcParentClass+'"'+ ;
              m.lcOleClass+IIF(llHTML,[</a>],[])
        Endcase
        lcAddObject=lcAddObject+Iif(llHTML,[</font><font color="navy">],[]) && +CR_LF

        If Empty(lcProperties) OR ;
          ATC("_L",lcParentClass)>0 AND ATC("_C",lcParentClass)>0 AND ATC("_TC",lcParentClass)>0
          *!* DO NOT ENTER properties with With clause because
          *!* control is subclassed and properties are given in subclass
          
          * lcAddObject=toBrowser.IndentText(lcAddObject)+ ;
          *   IIF(llHTML,[<font color="black">],[])
          lcAddObject=lcAddObject+ ;
            IIF(llHTML,[<font color="black">],[])+CR_LF
        Else

          * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
          lcProperties=;
            "With "+IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
            lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+lcClass+CR_LF+;
            STRTRAN(Strtran(Strtran(Strtran(toBrowser.FormatProperties(lcProperties,.T.),Chr(13),""),;
            CHR(10),""),;
            CHR(9),Chr(9)+"."),;
            ", ;",CR_LF)+CR_LF+"Endwith"+CR_LF

         * Indent only if Try Endtry routine
          * IF lcParent == m.lcParentColumn
          *   lcAddObject=lcAddObject+Iif(llHTML,[<font color="black">],[])+ ;
          *    CR_LF+toBrowser.IndentText(lcProperties,1)
          * Else
            lcAddObject=lcAddObject+Iif(llHTML,[<font color="black">],[])+ ;
              CR_LF+lcProperties
          * Endif
          
          laControlOk(m.lnMetadrecn,2) = .T.
          
        Endif

        * VFP can't add programmatically different types of controls
        * to the column (f.ex. textbox + checkbox) with out a Try Endtry
        * First you need to remove object otherwise ADDOBJECT generates
        * an error for headers and default column controls.

        * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
        IF lcParent == m.lcParentColumn AND !EMPTY(lcParent)
        
          * VFP6 VFP6 VFP6
          
          IF .T.  && VFP 8 or 9
          
            * next code doesn't work in VFP6
            * When some of the controls like CHECKBOX (different vartype than textbox) 
            * is added to the column -> data type mismatch error (IF Column.Bound = .T.)
            * but it IS added there even there is an erro situation
            * so we have to use try ... endtry to ignore the error 
            * BTW control is still added the control in question even if it is not handel with the TRY ENDTRY
            * so there is a wayh to use this earlier VFP versions.
            * Then add an error procedure to the PRG to handle this error situation (IF you are going to
            * use this with VFP with no TRY ENDTRY support).
                    
            IF LOWER(ALLTRIM(baseclass)) == "header"  && m.llFirstGridObj && m.llDefiningGrid AND RECNO() = 2
              * remove text1 object from every column. It is defined later on
            
              lcRemoveObjText1 = ;
              IIF(llHTML,[<font color="red">]+CR_LF,[])+ ;
              "Try"+Iif(llHTML,[</font><font color="red">],[])+CR_LF+;
              toBrowser.IndentText(IIF(llHTML,[<font color="navy">],[])+ ;
              IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
              m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
              "REMOVEOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
              '"text1")',1)+CR_LF+;
              IIF(llHTML,[<font color="red">],[])+ ;
              "Catch"+CR_LF+;
              "Endtry"+Iif(llHTML,[</font>],[])+CR_LF+CR_LF
            
            ELSE
          
              lcRemoveObjText1 = ""
          
            ENDIF    
          
            *!* Enters here when generating Grid control code (columns and column subcontrols)
            lcAddObject = lcRemoveObjText1 + ;
            IIF(llHTML,[<font color="red">]+CR_LF,[])+ ;
            "Try"+Iif(llHTML,[</font><font color="red">],[])+CR_LF+;
            toBrowser.IndentText(IIF(llHTML,[<font color="navy">],[])+ ;
            IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
            m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
            "REMOVEOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
            '"'+lcClass+'")',1)+CR_LF+;
            IIF(llHTML,[<font color="red">],[])+ ;
            "Catch"+CR_LF+;
            "Endtry"+CR_LF+;
             "Try"+Iif(llHTML,[</font><font color="red">],CR_LF)+;
            toBrowser.IndentText(lcAddObject,1)+;
            IIF(llHTML,[<font color="red">],[])+ ;
            "Catch"+CR_LF+;
            "Endtry"+Iif(llHTML,[</font>],[])+CR_LF

          ELSE
            * Next code works in VFP6 (but then you have to make the error procedure there
            * ( it is not added by this browser but this browser.prg can be modified to do so).
            * When some of the controls like CHECKBOX (different vartype than textbox) 
            * is added to the column -> data type mismatch error (IF Column.Bound = .T.)
            * so we have to use error routine to ignore the error but still add the control in question
            * or maybe add column.bound = .F. ??
            
            * If you make a form with a grid where is a column with a Checkbox and a textbox
            * VFP can run this from. Somehow VFP innerly handle the error situation and (can change the
            * column BOUND value) ignores this. But with the prg this situation have to handle by the prg file.
            

            IF LOWER(ALLTRIM(baseclass)) == "header"  && m.llFirstGridObj && m.llDefiningGrid AND RECNO() = 2
              * remove text1 object from every column. It is defined later on
              lcRemoveObjText1 = ;
              IIF(llHTML,[<font color="red">],[])+ ;
              "If "+IIF(llHTML,[</font><font color="red">],[])+;
              IIF(llHTML,[<font color="navy">],[])+ ;
              "VARTYPE("+IIF(llHTML,[</font><font color="blue">],[])+;
              IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
              m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
              'text1'+IIF(llHTML,[</font><font color="navy">],[])+;
              ') = "O"'+CR_LF+;
              toBrowser.IndentText(IIF(llHTML,[<font color="navy">],[])+ ;
              IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
              m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
              "REMOVEOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
              '"text1"'+IIF(llHTML,[</font><font color="navy">],[])+')',1)+CR_LF+;
              IIF(llHTML,[</font><font color="red">],[])+ ;
              "Endif"+Iif(llHTML,[</font>],[])+CR_LF+CR_LF
            ELSE
          
              lcRemoveObjText1 = ""
          
            ENDIF    
          
            *!* Enters here when generating Grid control code (columns and column subcontrols)
            
            lcAddObject = lcRemoveObjText1 + ;
            IIF(llHTML,[<font color="red">],[])+ ;
            "If "+Iif(llHTML,[</font><font color="red">],[])+;
            IIF(llHTML,[<font color="navy">],[])+ ;
            "VARTYPE("+IIF(llHTML,[</font><font color="blue">],[])+;
            IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
            m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
            lcClass+IIF(llHTML,[</font><font color="navy">],[])+') = "O"'+CR_LF+;
            toBrowser.IndentText(IIF(llHTML,[<font color="navy">],[])+ ;
            IIF(INLIST(m.lnAppType,2,4),"This."+JUSTEXT(JUSTSTEM(lcObjectClass))+".",;
            m.lcMyObjRef+Strextract(Left(lcObjectClass,Rat(".",lcObjectClass)),".",""))+;
            "REMOVEOBJECT("+Iif(llHTML,[</font><font color="blue">],[])+ ;
            '"'+lcClass+'"'+IIF(llHTML,[</font><font color="navy">],[])+')',1)+CR_LF+;
            IIF(llHTML,[</font><font color="red">],[])+ ;
            "Endif"+Iif(llHTML,[</font>],[])+CR_LF+;
            lcAddObject+Iif(llHTML,[</font>],[])+CR_LF
          
            Endif
                   
        Endif

        * lcAddObject=toBrowser.IndentText(lcAddObject)
        * 06/05/2005 Arto Toikka
        * ADDOBJECT() code to the container init
        * IF INLIST(m.lnAppType,2,4)
        *   *!* Change m.lcMyObjRef to This. 
        *   lcAddObject = STRTRAN(lcAddObject,m.lcMyObjRef,"This.",1,1)
        * Endif
        
        m.lcInsertAddObjCode=m.lcInsertAddObjCode+CR_LF+CR_LF+m.lcAddObject+CR_LF
        
        * --- End of AT part
      Endif

  Endcase

  If Not Empty(lcMethods)
    Do While Left(lcAppendDefineCode,2)==CR_LF
      lcAppendDefineCode=Substr(lcAppendDefineCode,3)
    Enddo
    Do While Right(lcAppendDefineCode,2)==CR_LF
      lcAppendDefineCode=Left(lcAppendDefineCode, ;
        LEN(lcAppendDefineCode)-2)
    Enddo
    lcAppendDefineCode=lcAppendDefineCode+lcCRLF3
  ENDIF

  * 06/07/2005 Arto Toikka
  IF m.lnAppType > 0
     m.lcPreviousContainer = IIF(!Lower(Alltrim(BaseClass))==m.lcPreviousContainer AND ;
                                 ATC(Lower(Alltrim(BaseClass)),m.lcParentContainers)>0,;
                                 Lower(Alltrim(BaseClass)),m.lcPreviousContainer)
  Endif
  * --- End of AT part
  
Enddo

* 03/26/2004 Arto Toikka Added support to multilevel containers and methods
* toBrowser.IndentText(lcCode) adds false extra TABS to the begining of the lccode,
* those tabs are removed here
If m.lnAppType > 0
  lcCode = "*"+Strextract(lcCode,"*")
Endif
* --- End of AT part

Set Message To ""

If Not Empty(lcDefineClass)
  If Not Empty(lcInsertDefineCode)
    lcInsertDefineCode=lcInsertDefineCode+CR_LF+CR_LF
  Endif
  lcCode=lcCode+lcInsertDefineCode+lcAppendDefineCode
  Do While Right(lcCode,2)==CR_LF
    lcCode=Left(lcCode,Len(lcCode)-2)
  Enddo
  lcCode=lcCode+lcCRLF3+ ;
    IIF(llHTML,[<font color="navy">]+CR_LF,[])+"ENDDEFINE"+CR_LF+ ;
    +Iif(llHTML,CR_LF+[</font><font color="green">]+CR_LF,[])+"*"+CR_LF+ ;
    lcComment+"EndDefine: "+lcDefineClass+CR_LF+lcBorder+ ;
    IIF(llHTML,CR_LF+[</font><font color="black">]+CR_LF,[])+CR_LF
ENDIF

* 06/05/2005 Arto Toikka 
If m.lnAppType > 0
  * mode 3 and 5 support. ADDOBJECT() are added to the container INIT
  * lcInsertAddObjCode are collected and moved out from the container controls
  * Time to write container ADDOBJECT() code
  
  * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
  IF INLIST(m.lnAppType,2,4) AND ;
    !EMPTY(m.lcBranchContainer) AND ;
      !EMPTY(m.lcInsertAddObjCode)
    * lcInsertAddObjCode = FormatProperties(lcInsertAddObjCode,.T.)
    m.lcInsertAddObjCode = m.lcInsertAddObjCode + m.lcInsertRestiveProps
    m.lcInsertAddObjCode = toBrowser.FormatMethods(m.lcInsertAddObjCode)
    IF ATC("*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *",lcCode)>0
      lcCode = STRTRAN(lcCode,"*"+CHR(255)+CHR(255)+"MODE1 Subcontrol definition *",;
        m.lcInsertAddObjCode,1,1)+CR_LF
    ENDIF
    m.lcInsertAddObjCode = ""
    m.lcInsertRestiveProps = ""
    m.lcBranchContainer = ""
    m.lcContainerParent = ""
    m.llAddGirdtoInitNow = .F.
    m.llDefiningGrid = .F.
  ENDIF
ENDIF
* --- End of AT part

If llFileMode And llSCXMode And Not Empty(lcCode)

  * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
  If m.lnAppType > 0
    * 06/18/2005 HOME() added to better support for running in different computers and VFP installations
    For lnCount = 1 To lnClassLibCount
      IF ATC(HOME(),laClassLib(lnCount))>0
        m.lcTmpString1 = "HOME()+"+"'"+STRTRAN(laClassLib(lnCount),HOME(),"",1,1,1)+"'"
      Else
        IF " "$laClassLib[lnCount]
          m.lcTmpString1 = "'"+laClassLib(lnCount)+"'"
        ELSE
          m.lcTmpString1 = laClassLib(lnCount)
        ENDIF
      Endif    
      lcInsertCode=lcInsertCode+"SET CLASSLIB TO "+ ;
      m.lcTmpString1 + ;
      " ADDITIVE"+CR_LF
    Endfor
    * --- End of AT part

  Else
    * Next MS code has a bug, I fixed it too
    * Path should be in quotations if contains spaces
    For lnCount = 1 To lnClassLibCount
      lcInsertCode=lcInsertCode+"SET CLASSLIB TO "+laClassLib[lnCount]+ ;
        " ADDITIVE"+CR_LF
    Endfor
  Endif

  If Not Empty(lcInsertCode)
    lcInsertCode=lcInsertCode+CR_LF
  Endif


  * 03/26/2004 Arto Toikka Added support to multilevel containers and methods
  If m.lnAppType > 0
  
    * Referenct to the top most container (Form)
    lcVarName="o"+m.lcTopMost
    
    * 02/22/2006 Unique name added to the Ofrm Object name 
    * so that if two different PRG files are generated from the same 
    * SCX file, both PRG files can be ran at the same time
    lcVarName=lcVarName+SYS(2015)

    * 04/10/2004 Arto Toikka added support to the page objects

    m.lcInsertAddObjCode = Strtran(m.lcInsertAddObjCode,lcMyObjRef,lcVarName+[.])
    m.lcInsertRestiveProps = Strtran(m.lcInsertRestiveProps,lcMyObjRef,lcVarName+[.])
  
  
    * INLIST(m.lnAppType,2,4) CASE TÄÄLLÄ
    * PADR("* Mode "+TRANSFORM(m.lnAppType+IIF(!m.llPropsInDEFINE_CLASS,2,0)),50," ")+"*"+CR_LF+;
  
    lcInsertCode= ;
    Iif(llHTML,[<font color="green">],[])+ ;
    "***************************************************"+CR_LF+;
    "* Class Browser modifications by Arto Toikka 2005 *"+CR_LF+;
    "* =============================================== *"+CR_LF+;
    "*                                                 *"+CR_LF+;
    PADR("* Mode "+TRANSFORM(m.lnAppType),50," ")+"*"+CR_LF+;
    PADR("* View Code generated: "+TRANSFORM(DATETIME()),50," ")+"*"+CR_LF+;
    "***************************************************"+CR_LF+CR_LF+;
    IIF(llHTML,[</font><font color="black">],[]) + ;
    m.lcIncludeCode + ;
    [PUBLIC ]+lcVarName+CR_LF+CR_LF+lcInsertCode+ ;
      lcVarName+[=NEWOBJECT("]+m.lcTopMost+[")]+CR_LF+CR_LF+ ;
      m.lcInsertAddObjCode+Iif(!Empty(m.lcInsertAddObjCode),CR_LF,"")+ ;
      Iif(llHTML,[<font color="black">],[])+ ;
      m.lcInsertRestiveProps+Iif(!Empty(m.lcInsertRestiveProps),CR_LF,"")+ ;
      lcVarName+[.Show]+CR_LF+ ;
      [RETURN]+Iif(llHTML,[</font><font color="green">],[])+lcCRLF3


    If Used(m.lcTmpGroupCur)
      Use In (m.lcTmpGroupCur)
    Endif
    If Used(m.lcTmpControlCur)
      Use In (m.lcTmpControlCur)
    Endif

    * --- End of AT part
  Else

    lcVarName="o"+lcDefineClass
    
    * 09/09/2004 Arto Toikka added Page topic * Mode MS-original
    lcInsertCode= ;
      Iif(llHTML,[<font color="green">],[])+ ;
      "* Mode MS-original"+CR_LF+CR_LF+ ;
      IIF(llHTML,[</font><font color="black">],[]) + ;
      [PUBLIC ]+lcVarName+CR_LF+CR_LF+lcInsertCode+ ;
      lcVarName+[=NEWOBJECT("]+lcDefineClass+[")]+CR_LF+ ;
      lcVarName+[.Show]+CR_LF+ ;
      [RETURN]+lcCRLF3
    * --- End of AT part
    * Original MS code
    * lcInsertCode=[PUBLIC ]+lcVarName+CR_LF+CR_LF+lcInsertCode+ ;
    *   lcVarName+[=NEWOBJECT("]+lcDefineClass+[")]+CR_LF+ ;
    *   lcVarName+[.Show]+CR_LF+ ;
    *   [RETURN]+lcCRLF3
    * -- End of Original MS code

  Endif

Endif
If Not Empty(lcInsertCode)
  lcCode=lcInsertCode+lcCode
Endif
If Not Empty(lcAppendCode)
  lcCode=lcCode+lcAppendCode
Endif
lcCode=Strtran(Strtran(lcCode,MARKER,""),CR_LF+Tab+CR_LF)
Do While Left(lcCode,1)==Tab
  lcCode=Alltrim(Substr(lcCode,2))
Enddo
If llHTML
  lcCode=[<html>]+CR_LF+ ;
    [<head>]+CR_LF+ ;
    [<title>]+Iif(toBrowser.lFileMode,M_CLASS_LIBRARY_LOC+" "+toBrowser.cClass, ;
    M_CLASS_LOC+" ("+toBrowser.cClass+")")+ ;
    [</title>]+CR_LF+ ;
    [</head>]+CR_LF+ ;
    [<body>]+CR_LF+CR_LF+ ;
    [<pre><b>]+CR_LF+ ;
    lcCode+CR_LF+ ;
    [</b></pre>]+CR_LF+CR_LF+ ;
    [</body>]+CR_LF+ ;
    [</html>]+CR_LF
Endif
lcCode=Strtran(Strtran(Strtran(lcCode,LF+Tab+CR,""),LF+LF,LF),CR+CR,CR)
Do While lcCRLF4$lcCode
  lcCode=Strtran(lcCode,lcCRLF4,lcCRLF3)
Enddo
If Not Empty(lcExportToFile)
  If Wexist(Justfname(lcExportToFile))
    Release Window (Justfname(lcExportToFile))
  Endif
  Strtofile(lcCode,lcExportToFile)
Endif
If tlShow
  If Not Empty(lcExportToFile)
    If llHTML
      toBrowser.ShellExecute(lcExportToFile)
    Else
      If Lower(Justext(lcExportToFile))=="prg"
        Modify Comm (lcExportToFile) Range 1,1 In Screen Nowait
      Else
        Modify File (lcExportToFile) Range 1,1 In Screen Nowait
      Endif
    Endif
  Else
    lcViewCodeFileName=Lower(toBrowser.cViewCodeFileName)
    If Empty(lcViewCodeFileName)
      lcViewCodeFileName=Lower(toBrowser.cProgramPath+Sys(2015)+".prg")
    Endif
    If Wexist(Justfname(lcViewCodeFileName))
      Release Window (Justfname(lcViewCodeFileName))
    Endif
    Strtofile(lcCode,lcViewCodeFileName)
    If Lower(Justext(lcViewCodeFileName))=="prg"
      Modify Comm (lcViewCodeFileName) Range 1,1 In Screen Nowait
    Else
      Modify File (lcViewCodeFileName) Range 1,1 In Screen Nowait
    Endif
  Endif
Endif
toBrowser.SetBusyState(.F.)
Select (lnLastSelect)
Set Message To
toBrowser.vResult=lcCode
Return toBrowser.vResult
Endfunc



Function brwExportView(toBrowser,tcAlias,tcExportToFile)
Local lcExportToFile,lcAlias,lnLastSelect

If toBrowser.AddInMethod("EXPORTVIEW")
  Return
Endif
lcAlias=Iif(Empty(tcAlias),toBrowser.cGallery,Lower(Alltrim(tcAlias)))
If Not Used(lcAlias)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Vartype(tcExportToFile)=="C" And Not Empty(tcExportToFile)
  lcExportToFile=Alltrim(tcExportToFile)
Else
  lcExportToFile=Lower(Putfile(M_SAVE_LOC,"","dbf"))
Endif
If Empty(lcExportToFile)
  toBrowser.vResult=.F.
  Return toBrowser.vResult
Endif
If Not ":"$lcExportToFile And Not "\\"$lcExportToFile
  lcExportToFile=Lower(Fullpath(lcExportToFile))
Endif
If File(lcExportToFile)
  If toBrowser.MsgBox(lcExportToFile+M_ALREADY_EXISTS_OVER_LOC,35)#6
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
  Erase (lcExportToFile)
  If File(lcExportToFile)
    toBrowser.vResult=.F.
    Return toBrowser.vResult
  Endif
Endif
lnLastSelect=Select()
Select (lcAlias)
Copy To (lcExportToFile)
Select (lnLastSelect)
Endfunc



Function brwValidHTMLText(tcText)

If Vartype(tcText)#"C"
  Return ""
Endif
Return Strtran(Strtran(Strtran(Strtran(tcText,[&],[&amp;]),[-],[&ndash;]),[<],[&lt;]),[>],[&gt;])
Endfunc


*************************
* 02/14/2006 Arto Toikka added Function to read OleClass value for ActiveX START

Function ReadOleClass(nType)

  If Vartype(m.nType)#"N"
    m.nType = 0
  Endif

  Local ;
    cCLSID_HEADER, ;
    nCLSIDAddress, ;
    lcCLSIDBin, ;
    lcStr, ;
    lcCLSID, ;
    lcProgID, ;
    lnSize, ;
    lni, ;
    lcRetVal

  
  If m.nType # 0
    * Just for fun another type of reading CLSID
    * Thanks to Sergey for this too
    
    Declare Integer StringFromGUID2 ;
      IN Ole32.Dll ;
      STRING cGUIDStruc, ;
      STRING @cGUID, ;
      LONG nSize
  
  Endif
  
  
  FOR m.lni = 1 TO 3
  
    DO CASE
      CASE m.lni = 1
        m.cCLSID_HEADER=Chr(0x01)+Chr(0x00)+Chr(0xFE)+Chr(0xFF)+Chr(0x03)+Chr(0x0A)+;
          CHR(0x00)+Chr(0x00)+Chr(0xFF)+Chr(0xFF)+Chr(0xFF)+Chr(0xFF)

        m.nCLSIDAddress = Iif(At(m.cCLSID_HEADER,OLE)=0,0x800,At(m.cCLSID_HEADER,OLE)+11)
      
      CASE m.lni = 2

        m.cCLSID_HEADER=Chr(0x00)+Chr(0x4C)+Chr(0x01)+Chr(0x00)+Chr(0x00)+Chr(0x00)+;
          CHR(0xC0)+Chr(0x00)+Chr(0xFF)+Chr(0x00)+Chr(0x00)+Chr(0x01)

        m.nCLSIDAddress = Iif(At(m.cCLSID_HEADER,OLE)=0,0x800,At(m.cCLSID_HEADER,OLE)+11)

      CASE m.lni = 3
        
        m.nCLSIDAddress = 0x900

    Endcase

    If m.nType = 0
      * With nType value = 0 no DLL is used with binary conversion

      * Thanks to Sergey for the next m.lcCLSIDBin binary conversion to CLSID key
      m.lcCLSIDBin = Substr(OLE, m.nCLSIDAddress+1,16)
      m.lcStr = Substr(Transform(CToBin(Left(m.lcCLSIDBin,4), "4RS"), "@0"), 3)
      m.lcCLSID = "{"
      m.lcCLSID = m.lcCLSID +  m.lcStr + "-"
      m.lcStr = Substr(Transform(CToBin(Substr(m.lcCLSIDBin,5,4), "4RS"), "@0"),3)
      m.lcCLSID = m.lcCLSID + Right(m.lcStr,4) + "-" + Left(m.lcStr,4) + "-"
      m.lcStr = Substr(Transform(CToBin(Substr(m.lcCLSIDBin,9,2), "2S"), "@0"),7)
      m.lcCLSID = m.lcCLSID + Right(m.lcStr,4) + "-"
      m.lcStr = Substr(Transform(CToBin(Substr(m.lcCLSIDBin,11,4), "4S"), "@0"),3)
      m.lcCLSID = m.lcCLSID + m.lcStr
      m.lcStr = Substr(Transform(CToBin(Substr(m.lcCLSIDBin,15,2), "2S"), "@0"),7)
      m.lcCLSID = m.lcCLSID + Right(m.lcStr,4)
      m.lcCLSID = m.lcCLSID + "}"

      m.lcRetVal = Iif(Read_ProgID(m.lcCLSID,@lcProgID)>0,m.lcProgID,"Invalid CLSID used.")

    Else

      * Just for fun another type of reading CLSID
      * Thanks to Sergey for this too
    
      m.lcCLSIDBin = Substr(OLE, m.nCLSIDAddress+1,16)
      m.lcCLSID = Space(80)
      m.lnSize = 40

      m.lcRetVal = Iif(StringFromGUID2(m.lcCLSIDBin, @lcCLSID, m.lnSize)#0,Strconv(Left(m.lcCLSID,76),6),"Invalid CLSID used.")

    Endif

    * LOCAL cTmp_Debug_Var
    * cTmp_Debug_Var = m.lcCLSID
    * ? TRANSFORM(m.nCLSIDAddress,"@0") + "   " + m.lcCLSID

  
    IF m.lcRetVal # "Invalid CLSID used."
      RETURN m.lcRetVal
    Endif
  
  Endfor

  * Next returns the OleClass name from the Registry
  Return m.lcRetVal

Endfunc

Function Read_ProgID(lcCLSID,lcProgID)

  If .F.
    * THIS WORKS TOO BUT MORE DIFFICULT TO HANDLE ERROR SITUATIONS IF KEY DOESN'T EXIST
    Local ;
      lRetVal, ;
      WSHShell

    m.WSHShell = Createobject("WScript.Shell")
    m.lRetVal = WSHShell.RegRead("HKCR\CLSID\"+m.lcCLSID+"\ProgID\")
    m.WSHShell=.Null.
    Return m.lRetVal

  Else
    * Longer code but better (=local) error handling

    #Define HKEY_CLASSES_ROOT           -2147483648
    #Define HKEY_CURRENT_USER           -2147483647
    #Define HKEY_LOCAL_MACHINE          -2147483646
    #Define HKEY_USERS                  -2147483645

    * Constants that are needed for Registry functions
    #Define REG_NONE                 0
    #Define REG_SZ                   1
    #Define REG_EXPAND_SZ            2
    #Define REG_BINARY               3
    #Define REG_DWORD                4
    #Define REG_DWORD_LITTLE_ENDIAN  4
    #Define REG_DWORD_BIG_ENDIAN     5
    #Define REG_LINK                 6
    #Define REG_MULTI_SZ             7

    Local nKey, cSubKey, cValue

    m.nKey = HKEY_CLASSES_ROOT
    m.cSubKey = "CLSID\"+m.lcCLSID+"\ProgID"
    m.cValue = ""

    * WIN 32 API functions that are used
    Declare Integer RegOpenKey In Win32API ;
      Integer nHKey, String @cSubKey, Integer @nResult
    Declare Integer RegQueryValueEx In Win32API ;
      Integer nHKey, String lpszValueName, Integer dwReserved,;
      Integer @lpdwType, String @lpbData, Integer @lpcbData
    Declare Integer RegCloseKey In Win32API Integer nHKey

    * Local variables used
    Local nErrCode       && Error Code returned from Registry functions
    Local nKeyHandle     && Handle to Key that is opened in the Registry
    Local lpdwValueType  && Type of Value that we are looking for
    Local lpbValue       && The data stored in the value
    Local lpcbValueSize  && Size of the variable
    Local lpdwReserved   && Reserved Must be 0

    * Initialize the variables
    m.nKeyHandle = 0
    m.lpdwReserved = 0
    m.lpdwValueType = REG_SZ

    m.nErrCode = RegOpenKey(m.nKey, m.cSubKey, @nKeyHandle)
    * If the error code isn't 0, then the key doesn't exist or can't be opened.
    If (m.nErrCode # 0) Then
      Return 0
    Endif

    m.lpbValue = ""
    m.lpcbValueSize = 1
    * Get the size of the data in the value
    m.nErrCode=RegQueryValueEx(m.nKeyHandle, m.cValue, m.lpdwReserved, @lpdwValueType, @lpbValue, @lpcbValueSize)

    * Make the buffer big enough
    m.lpbValue = Space(m.lpcbValueSize)
    m.nErrCode=RegQueryValueEx(m.nKeyHandle, m.cValue, m.lpdwReserved, @lpdwValueType, @lpbValue, @lpcbValueSize)

    =RegCloseKey(m.nKeyHandle)
    If (m.nErrCode # 0) Then
      Return 0
    Endif

    m.lcProgID = Left(m.lpbValue,m.lpcbValueSize-1) &&Dump the null value

    Return m.lpcbValueSize

  Endif

Endfunc
 
* 02/14/2006 Arto Toikka added Function to read OleClass value for ActiveX END

*-- end BROWSER.PRG
