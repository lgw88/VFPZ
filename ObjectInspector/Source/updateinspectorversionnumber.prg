#Define VersionFile         		'InspectorVersion.h'
#Define UpdaterVersionFile  	  	'..\InspectorEditorVersionFile.txt'

#Define CRLF                		Chr(13) + Chr(10)

Local laLines[1], lcNewText, lcNewVersion, lcText, lcUpdateVersionFile, lcVersion, lnI

Alines(laLines, Filetostr(VersionFile))
lcVersion = Inputbox('New Version: ', '', Substr(laLines(1), 3))
If Empty(lcVersion)
	Return
Endif

*********************************************************
lcNewVersion = [Object Inspector ] + Alltrim(lcVersion) + [ - ] + SpellDate()

lcNewText = '* ' + lcVersion
lcNewText = lcNewText + CRLF + ''
lcNewText = lcNewText + CRLF + '#Define cnVersion           ' + Alltrim(lcVersion)
lcNewText = lcNewText + CRLF + '#Define cdVersionDate       ' + SpellDate()
lcNewText = lcNewText + CRLF + '#Define	ccInspectorVERSION  [' + lcNewVersion + ']'

Erase (VersionFile)
Strtofile(lcNewText, VersionFile, 0)

*********************************************************
TEXT to lcText NoShow TextMerge
Lparameters toUpdateInfo

With toUpdateInfo
	.AvailableVersion	= '<<lcNewVersion>>'
	.SourceFileUrl		= 'http://foxpro.mattslay.com/JRN/ObjectInspector/Inspector.zip'
Endwith

Execscript (_Screen.cThorDispatcher, 'Result=', toUpdateInfo)
Return toUpdateInfo

ENDTEXT

Erase (UpdaterVersionFile)
Strtofile(lcText, UpdaterVersionFile, 0)
*********************************************************

Return lcNewVersion
