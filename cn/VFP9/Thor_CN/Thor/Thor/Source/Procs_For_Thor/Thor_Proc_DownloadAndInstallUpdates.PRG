Lparameters tlIsThor, llAutoRun

Local lnReturn
lnReturn = CheckForUpdates_Main (tlIsThor, llAutoRun)

Execscript (_Screen.cThorDispatcher, 'Result=', lnReturn)

Return

***************************************************************
#Define ccUpdateDelimiter      Chr(0)
#Define ccPropertyDelimiter    Chr(1)
#Define ccFieldDelimiter       Chr(2)

#Define ccCR Chr(13)
#Define ccLF Chr(10)

#Define EmptyVerDate			Date(2001,1,1)
#Define DaysForRecentReleases	60
***************************************************************

Procedure CheckForUpdates_Main (tlIsThor, llAutoRun)

	Local lcCol, lcRow, lnCurrentUpdateCount, lnResult, loUpdateList

	WritetoCFULog( [正在获取更新列表] )
	loUpdateList		 = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_GetUpdateList', tlIsThor)
	lnCurrentUpdateCount = loUpdateList.Count

	If lnCurrentUpdateCount = 0
		Return 0
	Endif

	loUpdateList = GetAvailableVersionInfo (loUpdateList)
	Wait Clear
	If 'O' # Vartype (loUpdateList) && failure to get update list?
		WritetoCFULog( [正在中止...找不到更新列表] )
		Return - 1
	Endif

	If tlIsThor
		loUpdateList = SelectFromUpdateList (loUpdateList)
		lnResult	 = CheckIfReadyToGo (loUpdateList)
	Else
		loUpdateList = SelectUpdates (loUpdateList, llAutoRun)
		Use In (Select ('crsr_ThorUpdates'))
		If Type ('loUpdateList') = 'O' And loUpdateList.Count > 0
			lnResult = 1
		Else
			lnResult = 0
		Endif
	Endif

	If lnResult = 1
		loUpdateList = ClearAll (loUpdateList)
		InstallUpdates (loUpdateList)

		Wait Clear
		? [更新完成]

		Execscript (_Screen.cThorDispatcher, 'Thor_Proc_MessageBox',  [更新完成] , 0,  [Thor 更新...] )
		Return 1
	Else
		WritetoCFULog( [正在退出...未选择更新] )
	Endif

	Return lnResult

Endproc


Procedure GetAvailableVersionInfo (toUpdateList)

	Local loUpdateList As 'Collection'
	Local laMembers[1], lcName, lnI, lnJ, loNewVersionInfo, loUpdateInfo

	loUpdateList = Createobject ('Collection')

	For lnI = 1 To toUpdateList.Count
		loUpdateInfo = toUpdateList[lnI]
		If loUpdateInfo.NeverUpdate # 'Y'
			WritetoCFULog( [获取可用的版本信息 ]  + loUpdateInfo.ApplicationName)
			loUpdateInfo = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_GetAvailableVersionInfo', loUpdateInfo)
		Endif
		If loUpdateInfo.ErrorCode = 0
			loUpdateList.Add (loUpdateInfo)
		Endif
	Endfor

	Wait Clear
	Return loUpdateList

Endproc


Procedure SelectFromUpdateList (toUpdateList)

	Local laMembers[1], lcName, lnI, lnJ, loNewVersionInfo, loUpdateInfo, loUpdateList

	loUpdateList = Createobject ('Collection')

	For lnI = 1 To toUpdateList.Count
		loUpdateInfo     = toUpdateList[lnI]
		If Not Empty (loUpdateInfo.SourceFileURL)		;
				And Not loUpdateInfo.AvailableVersion == loUpdateInfo.CurrentVersion
			loUpdateList.Add (loUpdateInfo)
		Endif
	Endfor
	Return loUpdateList

Endproc


Procedure CheckIfReadyToGo (toUpdateList)
	*   Returns:
	*       1 = Doit it!
	*       0 = Nothing to do
	*      -1 = Cancelled
	Local lcMessage, lcNames, lnI, lnResponse, loUpdateInfo

	lcNames = ''
	For lnI = 1 To toUpdateList.Count
		loUpdateInfo = toUpdateList[lnI]
		lcNames		 = lcNames + Chr(13) + Space(8) + loUpdateInfo.ApplicationName + ': ' + loUpdateInfo.AvailableVersion
	Endfor

	If toUpdateList.Count > 0
		lcMessage =  [准备安装 ]  + Transform (toUpdateList.Count) +  [ 更新(s):]  + Chr(13) + lcNames
		lnResponse = Messagebox (lcMessage + Chr(13) + Chr(13) +								;
			   [要执行更新，CLEAR ALL 和 CLOSE ALL 命令必须运行。]  + Chr(13) + Chr(13) + ;
			   [你希望继续？] , 4,  [允许 CLEAR ALL 等？] )
		Return Iif (lnResponse = 6, 1, -1)
	Else
		Return 0
	Endif

Endproc


Procedure SelectUpdates (loUpdateList, llAutoRun)
	Local loResultList As 'Collection'
	Local lcFormFileName, llAnyFound, llResult, lnResult

	llAnyFound = CreateUpdatesCursor (loUpdateList)
	If llAutoRun And Not llAnyFound
		Return
	Endif

	lcFormFileName = Execscript (_Screen.cThorDispatcher, 'Full Path=CheckForUpdates.SCX')
	Do Form (lcFormFileName) To llResult

	If llResult
		Select crsr_ThorUpdates
		loResultList = Createobject ('Collection')
		Scan For UpdateNow
			loResultList.Add (loUpdateList[RecNo])
		Endscan
		Return loResultList
	Endif

Endproc



Procedure CreateUpdatesCursor (toUpdateList)

	Local laLines[1], llAnyFound, lnI, lnLineCount, loVersionInfo
	Create Cursor crsr_ThorUpdates (			;
		  Recno					N(4),			;
		  AppName  				C(40),			;
		  InstalledVersion		C(100),			;
		  InstalledVerNumber	C(100),			;
		  InstalledVerDate		C(20),			;
		  AvailableVersion		C(100),			;
		  AvailableVerNumber	C(100),			;
		  AvailableVerDate		C(20),			;
		  Status                C(40),			;
		  ProjectCreationDate   D,				;
		  UpdateNow           	L,				;
		  NeverUpdate			L,				;
		  NeverUpdateFile		C(250),			;
		  FromMyUpdates			L,				;
		  Notes					M,				;
		  Link                	M,				;
		  LinkPrompt			C(100),			;
		  IsNew		       		L,				;
		  IsCurrent        		L,				;
		  SortKey			    C(100),			;
		  VerDate               D				;
		  )

	llAnyFound = .F.
	
	For lnI = 1 To toUpdateList.Count
		With toUpdateList[lnI]

			Insert Into crsr_ThorUpdates														;
				(Recno, AppName, InstalledVersion,	AvailableVersion, Notes, FromMyUpdates, ProjectCreationDate)		;
				Values																			;
				(lnI, .ApplicationName, .CurrentVersion, .AvailableVersion, .Tag, .FromMyUpdates = 'Y', .ProjectCreationDate)

			loVersionInfo = GetVersionInfo (.CurrentVersion)
			Replace	InstalledVerNumber	With  Alltrim (loVersionInfo.VerNumber) + Iif (loVersionInfo.VerDate <= EmptyVerDate, '', ' (' + Dtoc (loVersionInfo.VerDate) + ')')
			*!* Replace	InstalledVerNumber	With  loVersionInfo.VerNumber		;
			*!* 		InstalledVerDate	With  loVersionInfo.VerDate

			*!* * Removed 10/3/2012 / JRN
			*!* If (Not .CurrentVersion == .AvailableVersion) And Not Empty (.AvailableVersion)
			If Not Empty (.AvailableVersion)
				loVersionInfo = GetVersionInfo (.AvailableVersion)
				Replace	AvailableVerNumber	With  Alltrim (loVersionInfo.VerNumber) + ' (' + Dtoc (loVersionInfo.VerDate) + ')'
				*!* Replace	AvailableVerNumber	With  loVersionInfo.VerNumber		;
				*!* 		AvailableVerDate	With  loVersionInfo.VerDate
			Endif

			Replace	NeverUpdate		 With  .NeverUpdate = 'Y'									;
					UpdateNow		 With  (Not NeverUpdate)									;
					  And (.AvailableVersion > EVL(.CurrentVersion, ' ')						;
					  	or GetLastWord(.AvailableVersion) > GetLastWord('20999999 ' + .CurrentVersion))		;
					  And (.UpdateNowIfNotInstalled = 'Yes' Or Not Empty (.CurrentVersion))		;
					IsNew			 With  .ProjectCreationDate >= Date() - DaysForRecentReleases					;
					IsCurrent		 With  .CurrentVersion == .AvailableVersion					;
					NeverUpdateFile	 With  .NeverUpdateFile										;
					Notes			 With  Transform(.Notes)									;
					Link			 With  Transform(.Link)										;
					LinkPrompt		 With  Transform(Evl (.LinkPrompt, .Link))					;
					VerDate          with  loVersionInfo.VerDate

			Replace	SortKey	 With														;
					  Icase(UpdateNow, 'A',												;
						NeverUpdate, 'Z',												;
						Empty(InstalledVerNumber) And IsNew, 'B',						;
						Empty(InstalledVerNumber) And VerDate > Date() - DaysForRecentReleases, 'D',		;
						IsCurrent, 'C',													;
						'X') +															;
					  Upper(AppName)	
					  
			Replace	Status	 With														;
					  Icase(Left(SortKey, 1) = 'A',  [可用更新] ,					;
						Left(SortKey, 1) = 'B',  [新项目] ,							;
						Left(SortKey, 1) = 'C',  [当前] ,								;
						Left(SortKey, 1) = 'D',  [最近更新] ,						;
						 [没有安装] ) 															
						
			llAnyFound = llAnyFound Or UpdateNow

		Endwith
	Endfor && lnI = 1 to toUpdateList.Count

	Select  *										;
		From crsr_ThorUpdates						;
		Into Cursor crsr_ThorUpdates Readwrite		;
		Order By SortKey
	Goto Top

	Return llAnyFound

Procedure GetVersionInfo (lcVersion)
	Local loResult As 'Empty'
	Local laLines[1], lnLineCount
	loResult = Createobject ('Empty')
	AddProperty (loResult, 'VerNumber', '')
	AddProperty (loResult, 'VerDate', EmptyVerDate)

	If Empty (lcVersion)
		Return loResult
	Endif

	lnLineCount = Alines (laLines, lcVersion, 5, '-')
	Do Case
		Case lnLineCount = 1
			loResult.VerNumber = laLines[1]
		Case lnLineCount = 2
			loResult.VerNumber = laLines[1]
			*	loResult.VerDate   = laLines[2]
		Case lnLineCount = 3
			loResult.VerNumber = laLines[2]
			*	loResult.VerDate   = laLines[3]
		Otherwise
			loResult.VerNumber = laLines[2]
			loResult.VerDate   = laLines[3]
			Try
				loResult.VerDate = Date (Val (Substr (laLines[4], 1, 4)), Val (Substr (laLines[4], 5, 2)), Val (Substr (laLines[4], 7, 2)))
			Catch
			Endtry
	Endcase
	Return loResult
EndProc


Procedure GetLastWord(tcText)
	Return GetWordNum(tcText, GetWordCount(tcText))
EndProc 

**********************************************************************
**********************************************************************

Procedure ClearAll (toUpdateList)

	Local loUpdateList As 'Collection'
	Local laMembers[1], laProperties[1], laUpdates[1], lcName, lcProp, lcUpdateInfo, lnDelim, lnI, lnJ
	Local loUpdate, lxValue

	* saving all custom properties into _Screen._ThorClearAllObject
	* so that they can be restored after the Clear All
	lcUpdateInfo = ''
	For lnI = 1 To toUpdateList.Count
		loUpdate = toUpdateList (lnI)
		Amembers (laMembers, loUpdate)
		For lnJ = 1 To Alen (laMembers)
			lcName  = laMembers[lnj]
			If Pemstatus (loUpdate, lcName, 4)
				lxValue = Getpem (loUpdate, lcName)
				If Type ('lxvalue') = 'C'
					lcUpdateInfo = lcUpdateInfo + lcName + ccFieldDelimiter + lxValue + ccPropertyDelimiter
				Endif
			Endif
		Endfor
		lcUpdateInfo = lcUpdateInfo + ccUpdateDelimiter
	Endfor && lnI = 1 to loUpdateList.Count

	_Screen.AddProperty ('_ThorClearAllObject', lcUpdateInfo)

	Release All

	Clear All
	Clear All
	Clear All
	Clear All
	Clear All
	Clear All

	Close All
	Clear Program

	Inkey (.25) && not sure if this is needed

	Alines (laUpdates, _Screen._ThorClearAllObject, 5, ccUpdateDelimiter)
	loUpdateList = Createobject ('Collection')
	For lnI = 1 To Alen (laUpdates)
		loUpdate = Createobject ('Empty')
		Alines (laProperties, laUpdates[lnI], 5, ccPropertyDelimiter)
		For lnJ = 1 To Alen (laProperties)
			lcProp	= laProperties[lnJ]
			lnDelim	= At (ccFieldDelimiter, lcProp)
			AddProperty (loUpdate, Left (lcProp, lnDelim - 1), Substr (lcProp, lnDelim + 1))
		Endfor
		loUpdateList.Add (loUpdate)
	Endfor && lnI = 1 to Alen(laUpdates)

	Return loUpdateList
Endproc


Procedure InstallUpdates (toUpdateList)
	Local lcAPPFolder, lcAPPName, lcApplicationName, lcDestFolder, lcDestZip, lcDownloadedZip
	Local lcDownloadsFolder, lcExecPhrase, lcInstallationFolder, lcToolFolder, lcUpdatePhrase
	Local lcVersionFile, lnI, lnReturn, loException, loUpdate, ltFileTimeStamp

	WritetoCFULog( [正在下载和安装所选更新] , .T.)
	lcToolFolder	  = Addbs (Execscript (_Screen.cThorDispatcher, 'Tool Folder='))
	lcDownloadsFolder = Addbs (SyS(2023)) + 'Thor Downloads\'
	CreateFolder (lcDownloadsFolder)

	For lnI = 1 To toUpdateList.Count
		loUpdate     = toUpdateList (lnI)

		If loUpdate.Component = 'Yes'
			lcAPPFolder		  = Addbs (lcToolFolder + 'Components')
		Else
			lcAPPFolder		  = Addbs (lcToolFolder + 'Apps')
		Endif

		lcApplicationName = Chrtran (loUpdate.ApplicationName, ' ' + GetInvalidFileNameChars(), '')
		lcDestFolder	  = Addbs (lcDownloadsFolder + lcApplicationName)
		lcDestZip		  = lcDestFolder + Chrtran (loUpdate.AvailableVersion, GetInvalidFileNameChars(), '') + '.Zip'
		CreateFolder (lcDestFolder)

		lcInstallationFolder = loUpdate.InstallationFolder
		If Empty (lcInstallationFolder)
			lcInstallationFolder = lcAPPFolder + lcApplicationName
		Endif
		CreateFolder (lcInstallationFolder)

		ltFileTimeStamp = .F.
		If (Not Empty (loUpdate.AppName))							;
				And (Not Empty (loUpdate.CurrentVersion))			;
				And Not loUpdate.CurrentVersion == loUpdate.AvailableVersion
			lcAPPName = Addbs (lcInstallationFolder) + loUpdate.AppName
			If File (lcAPPName)
				ltFileTimeStamp = Fdate (lcAPPName, 1)
			Endif
		Endif

		_Screen.AddProperty ('cThorLastZipFile', '')

		WritetoCFULog( [下载 ]  + loUpdate.ApplicationName)
		If loUpdate.Component = 'Yes'
			Execscript (_Screen.cThorDispatcher, 'Thor_Proc_BeforeComponentInstall', loUpdate.ApplicationName, lcInstallationFolder)
		Endif

		If Not Empty (loUpdate.SourceFileURL)
			WritetoCFULog( [尝试下载 ]  + loUpdate.SourceFileURL)
			lnReturn = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadAndExtractToPath'		;
				  , loUpdate.SourceFileURL, lcInstallationFolder, 'Y' $ Upper (loUpdate.ShowErrorMessage), loUpdate.ApplicationName)
			If lnReturn < 0 And Pemstatus(loUpdate, 'AltSourceFileURL', 5) And Not Empty(loUpdate.AltSourceFileURL)
				WritetoCFULog( [下载失败; 尝试备用下载 ]  + loUpdate.AltSourceFileURL)
				lnReturn = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadAndExtractToPath'	;
					  , loUpdate.AltSourceFileURL, lcInstallationFolder, 'Y' $ Upper (loUpdate.ShowErrorMessage), loUpdate.ApplicationName)
			Endif
		Else
			lnReturn = Execscript (_Screen.cThorDispatcher, 'Thor_Proc_ExtractToPath'					;
				  , loUpdate.LocalSourceZip, 'Thor_ToolInstaller_' + Evl (loUpdate.ApplicationName, 'X') + Sys(2015) ;
				  , loUpdate.ApplicationName, lcInstallationFolder, 'Y' $ Upper (loUpdate.ShowErrorMessage))
		Endif
		
		WritetoCFULog( [复制压缩文件 ]  + loUpdate.ApplicationName)
		* copy zip to our new Downloads folder
		lcDownloadedZip = _Screen.cThorLastZipFile
		Try
			Delete File (lcDestZip)
			Copy File (lcDownloadedZip) To (lcDestZip)
		Catch
		Endtry

		If Not Empty (ltFileTimeStamp)							;
				And ltFileTimeStamp = Fdate (lcAPPName, 1)		;
				And File (Addbs (lcInstallationFolder) + loUpdate.VersionLocalFilename)
			lnReturn = -999 && failure
		Endif

		If lnReturn > 0
			WritetoCFULog( [安装 ]  + loUpdate.ApplicationName)
			If loUpdate.Component = 'Yes'
				Execscript (_Screen.cThorDispatcher, 'Thor_Proc_AfterComponentInstall', loUpdate.ApplicationName, lcInstallationFolder, lcDownloadedZip)
			Endif

			Try
				Delete File (lcDownloadedZip)
			Catch
			Endtry

			lcUpdatePhrase = loUpdate.RegisterWithThor
			lcUpdatePhrase = Strtran (lcUpdatePhrase, '##InstallFolder##', Addbs (lcInstallationFolder))
			lcUpdatePhrase = Strtran (lcUpdatePhrase, '##LocalVersionFile##', loUpdate.LocalVersionFile)
			lcUpdatePhrase = Strtran (lcUpdatePhrase, '##Version##', Alltrim (Getwordnum (loUpdate.AvailableVersion, 2, '-')))
			lcUpdatePhrase = Strtran (lcUpdatePhrase, '##FullVersionText##', loUpdate.AvailableVersion)
			lcUpdatePhrase = Strtran (lcUpdatePhrase, '##Link##', loUpdate.Link)

			*!* Try
			lcExecPhrase = CreateDefines (loUpdate) + lcUpdatePhrase
			Execscript (lcExecPhrase)
			*!* Catch To loException
			*!*     ShowErrorMsg (loException)
			*!* Endtry

			lcVersionFile = loUpdate.LocalVersionFile
			Erase (lcVersionFile)
			Strtofile (loUpdate.AvailableVersion, lcVersionFile)

			? loUpdate.AvailableVersion +  [ ... 已更新] 
		Else
			?
			?  [********** 失败： ]  + loUpdate.AvailableVersion
			?  [********** 参看 ]  + lcDestZip
			? 
		Endif
	Endfor && lnI = 1 to loUpdateList.Count
Endproc


Procedure ShowErrorMsg
	Lparameters loException

	Messagebox ( [错误： ]  + Transform (loException.ErrorNo)	+ Chr(13) + Chr(13) +		;
		   [信息： ]  + loException.Message					+ Chr(13) + Chr(10) +		;
		   [过程： ]  + loException.Procedure                 	+ Chr(13) + Chr(10) +		;
		   [行： ]  + Transform (loException.Lineno)			+ Chr(13) + Chr(10) +		;
		   [代码： ]  + loException.LineContents												;
		  , 0        + 48,  [错误] )
Endproc


Procedure CreateDefines (loUpdate)
	Local laMembers[1], lcDefines, lcName, lnJ, lxValue
	lcDefines = ''
	Amembers (laMembers, loUpdate)
	For lnJ = 1 To Alen (laMembers)
		lcName	= laMembers[lnj]
		lxValue	= Getpem (loUpdate, lcName)
		If Type ('lxvalue') = 'C' And Not Chr(13) $ lxValue
			lcDefines = lcDefines + '#Define cc' + lcName + ' [' + lxValue + ']' + Chr(13)
		Endif
	Endfor
	Return lcDefines
Endproc


Procedure CreateFolder (lcFolder)
	If Not Directory (lcFolder)
		Mkdir (lcFolder)
	Endif
Endproc

* Following from Sergey
Function GetInvalidFileNameChars()
	Local lcInvalidFileNameChars, lnAsc
	lcInvalidFileNameChars = [*/:<>?|\] + Chr(34)
	For lnAsc = 0 To 31
		lcInvalidFileNameChars = lcInvalidFileNameChars + Chr (lnAsc)
	Endfor
	Return lcInvalidFileNameChars
Endfunc


Procedure WritetoCFULog (tcText, tlDivider)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WriteToCFULog', tcText, tlDivider, 1)
EndProc 
