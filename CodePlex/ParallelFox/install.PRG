* Install/register ParallelFox on developer machine

* Registering ParallelFox.exe requires elevation on Windows Vista/7
* ParallelFox /regserver without elevation will fail, but will not notify user of failure.
* This program requests elevation and confirms registration.
ShellExec(FullPath("ParallelFox.exe"),"RunAs","/regserver")
Wait "Registering ParallelFox..." window timeout .5	&& wait for registration to complete
If IsRegistered("ParallelFox.Application")
	MessageBox("ParallelFox was registered successfully.", 64, "ParallelFox")
Else
	MessageBox("ParallelFox was NOT registered.", 16, "ParallelFox")
EndIf 

If MessageBox("Do you want to install ParallelFox IntelliSense scripts? (Recommended)", 4+32, "ParallelFox IntelliSense") = 6
	Do InstallFFI
EndIf

MessageBox("Install Complete.", 64, "ParallelFox")

Return 

* Install IntelliSense scripts
* Currently, this does not overwrite existing entries, but that may change if necessary
Procedure InstallFFI
Local lnCurrentArea, lcScript, lcProxyClassLib, lcProxyEXE

lnCurrentArea = Select()
Select 0
Use (_FoxCode) Again Alias FFIFoxCode Shared

* Parallel Script
Locate for Lower(Abbrev) = "parallel " and Type = "U" and !Deleted()
If !Found()
	Append From FFI\ParFoxCode for Lower(Abbrev) = "parallel" and Type = "U"
EndIf 

* Parallel Type
Locate for Lower(Abbrev) = "parallel " and Type = "T" and !Deleted()
If !Found()
	Append From FFI\ParFoxCode for Lower(Abbrev) = "parallel" and Type = "T"
EndIf 

* Worker Script
Locate for Lower(Abbrev) = "worker " and Type = "U" and !Deleted()
If !Found()
	Append From FFI\ParFoxCode for Lower(Abbrev) = "worker" and Type = "U"
EndIf 

* Worker Type
Locate for Lower(Abbrev) = "worker " and Type = "T" and !Deleted()
If !Found()
	Append From FFI\ParFoxCode for Lower(Abbrev) = "worker" and Type = "T"
EndIf 

* FFI Script
* Worker Script
Locate for Lower(Abbrev) = "pfhandleffi " and Type = "S" and !Deleted()
If !Found()
	Append From FFI\ParFoxCode for Lower(Abbrev) = "pfhandleffi" and Type = "S"
	lcProxyClassLib = FullPath("FFI\FFI.vcx")
	lcProxyEXE = FullPath("FFI\FoxCode.EXE")
	Replace Data with Textmerge(Data)
EndIf 

Use
Use in Select("ParFoxCode")
Select (lnCurrentArea)

EndProc 

Function ShellExec
LParameter lcLink, lcAction, lcParms

lcAction = IIf(Empty(lcAction), "Open", lcAction)
lcParms = IIf(Empty(lcParms), "", lcParms)

DECLARE INTEGER ShellExecute ;
	IN SHELL32.dll ;
	INTEGER nWinHandle, ;
	STRING cOperation, ;
	STRING cFileName, ;
	STRING cParameters, ;
	STRING cDirectory, ;
	INTEGER nShowWindow
	
DECLARE INTEGER FindWindow ;
	IN WIN32API ;
	STRING cNull,STRING cWinName
	
Return ShellExecute(FindWindow(0, _Screen.caption), lcAction, ;
	lcLink, lcParms, JustPath(lcLink), 1)
EndFunc 

Function IsRegistered
Lparameters lcLookUpKey

* Registry roots
#DEFINE HKEY_CLASSES_ROOT           -2147483648  && BITSET(0,31)
#DEFINE HKEY_CURRENT_USER           -2147483647  && BITSET(0,31)+1
#DEFINE HKEY_LOCAL_MACHINE          -2147483646  && BITSET(0,31)+2
#DEFINE HKEY_USERS                  -2147483645  && BITSET(0,31)+3

* Load DLLs
Clear Dlls RegOpenKey
Clear Dlls RegCloseKey
LOCAL nHKey,cSubKey,nResult
DECLARE Integer RegOpenKey IN Win32API ;
	Integer nHKey, String @cSubKey, Integer @nResult
DECLARE Integer RegCloseKey IN Win32API ;
	Integer nHKey

* Try to open key
Local lnErrorCode, lnSubKey
lnSubKey = 0
lnErrorCode = RegOpenKey(HKEY_CLASSES_ROOT,lcLookUpKey,@lnSubKey)
If lnErrorCode = 0	&& success
	* Close key
	=RegCloseKey(lnSubKey)
	Return .t.
Else
	Return .f.
EndIf 
EndFunc 