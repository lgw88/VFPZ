#define MyAppName      "GKK Tools - Project Manager"
#define MyAppVersion   "3.0"
#define MyAppVerName   "GKK Tools 3.0 - Project Manager"
#define MyAppPublisher "Gregory A. Green"
#define MyAppCopyright "Copyright ©2005-2014 Gregory A. Green"
#define MyDefGroupName "GKK Tools"
#define MyFileName     "E:\My Work\FoxPro\Projects\GKKTools\ProjectManager\GKKProjectManager.app"
#define MyOutputName   "GKKProjectManager"

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
Compression=lzma/ultra64
SolidCompression=true
LicenseFile="E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\License.txt"
DirExistsWarning=no

[Types]
Name: Custom; Description: Program Installation; Flags: iscustom

[Components]
Name: Required; Description: Program Files; Flags: fixed; Types: Custom
Name: Required\ACX; Description: ActiveX Support Files; Flags: fixed; Types: Custom
Name: Required\PRG; Description: {#MyAppName}; Flags: fixed; Types: Custom
Name: Required\FON; Description: Support TrueType Font; Flags: fixed; Types: Custom

[Files]
Source: {#MyFileName}; DestDir: {app}; Flags: overwritereadonly; Components: Required\PRG
Source: "E:\My Work\C_Source\CodeMax 4.0.0.12\bin\cmax40.dll"; DestDir: {cf}\WinMain\CodeMax 4.0; Flags: sharedfile regserver overwritereadonly ignoreversion; Components: Required\ACX
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\GKKArial.TTF"; DestDir: {fonts}; FontInstall: GKKArial; Flags: ignoreversion; Components: Required\FON
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\usdict.CDX"; DestDir: {app}; Components: Required\PRG
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\usdict.dbf"; DestDir: {app}; Components: Required\PRG
Source: "E:\My Work\FoxPro\Projects\GKKTools\Setup\Support\gkkconvert.fll"; DestDir: {app}; Components: Required\PRG

[Registry]
Root: HKCU; Subkey: Software\GKK Industries; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: Software\GKK Industries\GKK Tools; ValueType: string; ValueName: GKKProjectManager; ValueData: {app}; Components: ; Flags: uninsdeletekeyifempty deletekey uninsdeletevalue deletevalue noerror

[Icons]
Name: {group}\{cm:UninstallProgram,GKKProjectManager}; Filename: {uninstallexe}
