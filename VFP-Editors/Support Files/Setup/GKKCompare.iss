#define MyAppName      "GKK Tools - Comparison Tools"
#define MyAppVersion   "3.0"
#define MyAppVerName   "GKK Tools 3.0 - Comparison Tools"
#define MyAppPublisher "Gregory A. Green"
#define MyAppCopyright "Copyright ©2005-2015 Gregory A. Green"
#define MyDefGroupName "GKK Tools"
#define MyFileName     "E:\My Work\FoxPro\Projects\GKKTools\Comparison\GKKCompare.app"
#define MyOutputName   "GKKComparison"

[Setup]
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppCopyright={#MyAppCopyright}
DefaultGroupName={#MyDefGroupName}
DefaultDirName={reg:HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Visual FoxPro 9.0 Professional - English,InstallLocation}\GKKTools
Uninstallable=1
AllowNoIcons=true
OutputBaseFilename={#MyOutputName}
WindowShowCaption=no
PrivilegesRequired=admin
Compression=lzma
SolidCompression=true
LicenseFile="E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\License.txt"
DirExistsWarning=no

[Types]
Name: Custom; Description: Program Installation; Flags: iscustom

[Components]
Name: Required; Description: Program Files; Flags: fixed; Types: Custom
Name: Required\PRG; Description: {#MyAppName}; Flags: fixed; Types: Custom
Name: Required\ACX; Description: ActiveX Support Files; Flags: fixed; Types: Custom
Name: Required\DOC; Description: GKK Tools Documentation; Flags: fixed; Types: Custom
Name: Required\FON; Description: Support TrueType Font; Flags: fixed; Types: Custom
Name: Custom; Description: Support Files; Types: Custom
Name: Custom\XML; Description: Microsoft® XML Core Services (MSXML); Types: Custom

[Files]
Source: {#MyFileName}; DestDir: {app}; Flags: overwritereadonly; Components: Required\PRG
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\ActiveX\cmax40.dll"; DestDir: {cf}\WinMain\CodeMax 4.0; Flags: sharedfile regserver overwritereadonly ignoreversion; Components: Required\ACX
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\Editor User Guide.pdf"; DestDir: {app}; Components: Required\DOC
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\GKKArial.TTF"; DestDir: {fonts}; FontInstall: GKKArial; Flags: ignoreversion; Components: Required\FON
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\GKKCompare.fll"; DestDir: {app}; Flags: overwritereadonly; Components: Required\PRG
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\msxml4sxs32.msi"; DestDir: {tmp}; Components: Custom\XML
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\msxml4sys32.msi"; DestDir: {tmp}; Components: Custom\XML

[Registry]
Root: HKCU; Subkey: Software\GKK Industries; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: Software\GKK Industries\GKK Tools; ValueType: string; ValueName: GKKCompare; ValueData: {app}; Components: ; Flags: uninsdeletekeyifempty deletekey uninsdeletevalue deletevalue noerror

[Run]
Filename: msiexec.exe; Parameters: "/i ""{tmp}\msxml4sxs32.msi"""; Components: Custom\XML; Flags: runminimized; StatusMsg: Installing XML Support
Filename: msiexec.exe; Parameters: "/i ""{tmp}\msxml4sys32.msi"""; Components: Custom\XML; Flags: runminimized; StatusMsg: Installing XML Support

[Icons]
Name: {group}\GKK Tools User Guide; Filename: {app}\Editor User Guide.pdf; Parameters: ; WorkingDir: {app}; IconFilename: ; IconIndex: 0; Flags: createonlyiffileexists
Name: {group}\{cm:UninstallProgram,GKKProjectManager}; Filename: {uninstallexe}
