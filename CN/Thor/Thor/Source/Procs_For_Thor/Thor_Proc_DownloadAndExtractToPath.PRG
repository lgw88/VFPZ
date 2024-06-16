Lparameters tcSourceFileURL, tcInstallPath, tlShowCopyErrorDialog, tcAppName

#Define ERROR_DOWNLOADING_FILE	-1
#Define ERROR_EXTRACTING_FILE	-2
#Define ERROR_INSTALLING_FILES	-3

Local lcDownloadDestinationFile, lcDownloadPath, lcTempName, llReturn, lnReturn

*--- Download the file to temp folder ---------------------------
_Screen.AddProperty ('cThorLastZipFile', '')

lcDownloadPath			  = Sys(2023) && Store ZIP file to user's Temp folder
lcTempName				  = 'Thor_ToolInstaller_' + Evl (tcAppName, 'X') + Sys(2015)
lcDownloadDestinationFile = Addbs (lcDownloadPath) + lcTempName + '.zip' && create a random name for the ZIP file

llReturn = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadFileFromURL', tcSourceFileURL, lcDownloadDestinationFile)

If Not llReturn
	Return Execscript (_Screen.cThorDispatcher, 'Result=', ERROR_DOWNLOADING_FILE)
Endif

_Screen.AddProperty ('cThorLastZipFile', lcDownloadDestinationFile)

*-- Extract to temp folder and then to target install folder ----------
lnReturn = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_ExtractToPath'  ;
	  , lcDownloadDestinationFile, lcTempName, tcAppName, tcInstallPath, tlShowCopyErrorDialog)

Return Execscript (_Screen.cThorDispatcher, 'Result=', lnReturn)
