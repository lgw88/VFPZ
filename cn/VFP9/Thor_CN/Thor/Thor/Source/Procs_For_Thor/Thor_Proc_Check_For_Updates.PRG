Local laFiles[1], lcToolFolder, lcUpdateFolder, llAutoRun, lnFileCount, lnI, lnReturn


#Define UpdaterURL 'http://vfpxrepository.com/dl/thorupdate/Updater_PRGs/Updates.zip'

WritetoCFULog( [开始 CFU - ]  + Transform(Datetime()))

If Not Execscript (_Screen.cThorDispatcher, 'Thor_Proc_CheckInternetConnection')
	Messagebox ( [没有找到互联网连接！] , 16,  [没有互联网连接] , 0)
	Return .F.
Endif

WritetoCFULog( [检查 Thor 更新] , .T.)

If Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadAndInstallUpdates', .T.) >= 0

	lcToolFolder   = Execscript (_Screen.cThorDispatcher, 'Tool Folder=')
	WritetoCFULog( [正在删除 FXP 文件...] )
	EraseFXPFiles (lcToolFolder)
	WritetoCFULog( [正在从 Thor Procs 文件夹删除 Thor FXP 文件...] )
	EraseFXPFiles (lcToolFolder + 'Procs')
	WritetoCFULog( [正在从 Thor MyTools 文件夹删除 Thor FXP 文件...] )
	EraseFXPFiles (lcToolFolder + 'My Tools')

	lcUpdateFolder = Addbs (lcToolFolder) + 'Updates\'
	lnFileCount	   = Adir (laFiles, lcUpdateFolder + '*.PRG')
	WritetoCFULog( [正在处理 (]  + transform(lnFileCount) +  [) Thor 更新程序...] )

	For lnI = 1 To lnFileCount
		If Not Upper (laFiles[lnI, 1]) == Upper ('Thor_Update_Thor.PRG')
			Erase (lcUpdateFolder + laFiles[lnI, 1])
		Endif
	Endfor
	*** Download the zip of Updaters, and install them
	lnReturn = Execscript (_Screen.cThorDispatcher	;
		  , 'Thor_Proc_DownloadAndExtractToPath'	;
		  , UpdaterURL + '?=' + Sys(2015)			;
		  , lcToolFolder							;
		  , .T.										;
		  , 'Updates')

	*** Check if called from RunThor, meaning it is from AutoRun
	llAutoRun = .F.
	For lnI = 1 To Program (-1)
		llAutoRun = llAutoRun Or 'RUNTHOR' $ Upper (Sys(16, lnI))
	Endfor

	WritetoCFULog( [检查所有其他 APPs 更新] , .T.)
	
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadAndInstallUpdates', .F., llAutoRun)

	Execscript (_Screen.cThorDispatcher, 'Run')

Endif

Execscript (_Screen.cThorDispatcher, 'Thor_Tool_ThorInternalThorNews',  [检查更新] )

Wait Clear

Return


Procedure EraseFXPFiles (tcFolder)
	Local lcFolder, lnCount, lnI, loException
	lcFolder = Addbs (tcFolder)
	lnCount	 = Adir (laFiles, lcFolder + '*.FXP')
	For lnI = 1 To lnCount
		Try
			Erase (lcFolder + laFiles[lnI, 1])
		Catch To loException

		Endtry
	Endfor
Endproc


Procedure WritetoCFULog(tcText, tlDivider)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WritetoCFULog(', tcText, tlDivider)
EndProc 
