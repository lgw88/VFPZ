*=============================================================================================================
*- Program             : install_zproc.prg
*- Author              : Jijo Pappachan
*- Date                : 12/02/09 03:07:46 PM
*- Copyright           :
*- Description         : Program to install 'zproc' intelliSense
*- Revision Information:
*=============================================================================================================

Close All
Local lc_Safety, ;
  lc_Talk, ;
  lc_Notify

Private lc_SourcePath, ;
  lc_Zproctable

lc_SourcePath = Addbs(Justpath(Sys(16)))
lc_Zproctable = lc_SourcePath + "zproc.dbf"
lc_Safety     = Set("Safety")
lc_Talk       = Set("Talk")
lc_Notify     = Set("Notify", 1)

Set Safety Off
Set Talk Off
Set Notify Cursor Off

*-- Use foxcode table
Use (_Foxcode) Shared Alias "FoxCode_Table"
Select "FoxCode_Table"

If (IsInstalled("zproc") Or IsInstalled("zvfp") or IsInstalled("zcom"))
  If Messagebox("zProc/zVfp/zCom scripts already installed on your computer. Do you want to uninstall it?", 292) = 6
    =UnInstall_Script()
  Endif
Else
  =Install_Sript()
Endif

Use In Select("FoxCode_Table")
Use In Select("Zproc_Table")

Set Safety &lc_Safety
Set Talk &lc_Talk
Set Notify Cursor &lc_Notify

*=============================================================================================================
*!*	 PROCEDURE : Install_Sript
*!*	 COMMENT   : Install script into foxcode table
*=============================================================================================================
Procedure Install_Sript

  Local lc_path, ;
    lc_FoxCodeBackup

  lc_path          = lc_SourcePath
  lc_FoxCodeBackup = Home() + "Foxcode_backup.Dbf"

  If Not File(lc_Zproctable)
    = Messagebox("File " + Displaypath(Proper(lc_Zproctable), 150) + " not found." + ;
      "Cannot proceed installation.")
    Return .F.
  Endif

  Select "FoxCode_Table"
  Copy To (lc_FoxCodeBackup)

  Use (lc_Zproctable) In 0 Alias "Zproc_Table"

  =UpdateFoxCode("zproc")
  =UpdateFoxCode("zvfp")
  =UpdateFoxCode("zcom")
  =CopyFiles()

  =Messagebox("Installation completed. A backup of FoxCode table has been copied to " + Proper(lc_FoxCodeBackup))
Endproc

*=============================================================================================================
*!*	 PROCEDURE : UpdateFoxCode
*!*	 COMMENT   : Add intellisence script into foxcode table
*=============================================================================================================
Procedure UpdateFoxCode(tc_ScriptName)

  Local lo_Script, ll_Return
  ll_Return = .F.

  Select "zproc_Table"

  If IsInstalled(tc_ScriptName)
    ll_Return = .T.

    Scatter Name lo_Zproc Memo

    Select "FoxCode_Table"

    If Not IsInstalled(tc_ScriptName)
      Append Blank
    Endif

    Gather Name lo_Zproc Memo

    Replace Timestamp With Datetime()

  Endif

  Return ll_Return
Endproc

*=============================================================================================================
*!*	 PROCEDURE : UnInstall_Script
*!*	 COMMENT   : Remove zproc and zvfp script from foxcode table
*=============================================================================================================
Procedure UnInstall_Script

  Select "FoxCode_Table"

  Delete For Upper(FoxCode_Table.Type+FoxCode_Table.abbrev) == Padr("UZPROC", 25)
  Delete For Upper(FoxCode_Table.Type+FoxCode_Table.abbrev) == Padr("UZVFP", 25)
  Delete For Upper(FoxCode_Table.Type+FoxCode_Table.abbrev) == Padr("UZCOM", 25)
Endproc

*=============================================================================================================
*!*	 PROCEDURE : IsInstalled
*!*	 COMMENT   : Check whether zproc and zvfp is installed already
*=============================================================================================================
Procedure IsInstalled
  Lparameters tc_ScriptName

  Local lc_LocateExp, lc_Alias
  lc_Alias     = Alltrim(Alias()) + "."
  lc_LocateExp = [UPPER(] + lc_Alias + [Type+] + lc_Alias + [abbrev) == '] + ;
    "U" + Upper(Padr(tc_ScriptName, 24)) +[']

  Locate For &lc_LocateExp

  Return Found()
Endproc

*=============================================================================================================
*!*	 PROCEDURE : CopyFiles
*!*	 COMMENT   : Copy other supporting files to VFP home directory
*=============================================================================================================
Procedure CopyFiles
  Local Array la_Files[3]
  Local ln_FileIndex, ;
    lc_FileName

  la_Files[1] = [zproc_method.bmp]
  la_Files[2] = [VfpNativeFuncs.bmp]
  la_Files[3] = [ComClasses.bmp]

  For ln_FileIndex = 1 To Alen(la_Files, 1)
    lc_FileName = lc_SourcePath + la_Files[ln_FileIndex]

    If File(lc_FileName)
      Copy File (lc_FileName) To (Home() + la_Files[ln_FileIndex])
    Endif

  Endfor

Endproc
