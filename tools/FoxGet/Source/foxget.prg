* FoxGet package installer/uninstaller. This must be subclassed to work with a
* specific package.

#define ccCRLF	chr(13) + chr(10)


define class FoxGet as Custom
	oFiles          = NULL
		&& a collection to hold files to download/process
	oProject        = NULL
		&& a reference to the active project
	cWorkingPath    = ''
		&& a temporary path for working files
	cExtractionPath = ''
		&& the path to extract files into
	cPackagesPath   = ''
		&& the path for packages for the project
	cPackageName    = ''
		&& the name of the package to install
	cPackagePath    = ''
		&& the path for the package
	cVersion        = ''
		&& the package version
	cProjectFolder  = ''
		&& the folder for the project
	cLogFile        = ''
		&& the log file
	cBaseURL        = ''
		&& the base URL to download files from
	cInstaller      = ''
		&& the path to the installer PRG


* Initialize the class.

	function Init

* Get a reference to the active project; bug out if there isn't one.

		if type('_vfp.ActiveProject') <> 'O'
			lcMessage = 'No active project'
			messagebox(lcMessage, 16, 'FoxGet')
			This.Log(lcMessage)
			return .F.
		endif type('_vfp.ActiveProject') <> 'O'
		This.oProject = _vfp.ActiveProject

* Create a collection to hold files to download/process.

		This.oFiles = createobject('Collection')

* Define the locations of some folders and set the default package name.

		This.cWorkingPath    = addbs(sys(2023)) + 'FoxGet\'
		This.cExtractionPath = This.cWorkingPath + 'Extraction\'
		This.cPackageName    = strtran(This.Name, 'Installer', '', -1, -1, 1)
		This.cProjectFolder = addbs(justpath(This.oProject.Name))
			&& we use Name not HomeDir since HomeDir could point to an older location
		This.cPackagesPath  = This.cProjectFolder + 'Packages\'
		This.cPackagePath   = This.cPackagesPath + addbs(This.cPackageName)

* Allow the subclass to do its own setup tasks.

		This.Setup()
	endfunc


* Abstract method overridden in a subclass.

	function Setup
	endfunc


* Add a file to the collection of files to download. tcFolder is optional:
* the user's Temp files folder is used if it isn't specified.

	function AddFile(tcURL, tlAddToProject, tcFolder)
		local loFile
		loFile               = createobject('FoxGetFile')
		loFile.cURL          = iif('http' $ tcURL, '', This.cBaseURL) + tcURL
		loFile.lAddToProject = tlAddToProject
		loFile.cLocalFile    = evl(tcFolder, This.cWorkingPath) + This.Decode(justfname(tcURL))
		This.oFiles.Add(loFile)
		return loFile
	endfunc


* Install the package. Custom work (anything other than downloading and extracting
* files, such as copying files from the working or extraction folder to the package
* folder) is done by the InstallPackage method, which is overridden in a subclass.

	function Install
		local lcMessage, ;
			llOK, ;
			loException as Exception, ;
			lcInstaller, ;
			laFiles[1], ;
			lnFiles

* Create our working folder if necessary.

		lcMessage = '===== Installing ' + This.cPackageName
		raiseevent(This, 'Update', lcMessage)
		This.Log(lcMessage)
		llOK = .T.
		if not directory(This.cWorkingPath)
			try
				md (This.cWorkingPath)
			catch to loException
				lcMessage = 'Cannot create ' + This.cWorkingPath + ': ' + ;
					loException.Message
				raiseevent(This, 'Update', lcMessage)
				This.Log(lcMessage)
				llOK = .F.
			endtry
		endif not directory(This.cWorkingPath)
		if not llOK
			return .F.
		endif not llOK

* Create the packages folder if necessary.

		if not directory(This.cPackagesPath)
			try
				md (This.cPackagesPath)
			catch to loException
				lcMessage = 'Error creating packages folder: ' + loException.Message
				raiseevent(This, 'Update', lcMessage)
				This.Log(lcMessage)
				llOK = .F.
			endtry
		endif not directory(This.cPackagesPath)
		if not llOK
			return .F.
		endif not llOK

* Delete the package folder if it exists (there may be obsolete files from an
* earlier install) then create it.

		llOK = This.RemovePackagePath()
		if not llOK
			return .F.
		endif not llOK
		try
			md (This.cPackagePath)
		catch to loException
			lcMessage = 'Error creating package folder ' + This.cPackageName + ': ' + ;
				loException.Message
			raiseevent(This, 'Update', lcMessage)
			This.Log(lcMessage)
			llOK = .F.
		endtry
		if not llOK
			return .F.
		endif not llOK

* Erase the log file.

		This.cLogFile = This.cPackagesPath + 'log.txt'
		try
			erase (This.cLogFile)
		catch
		endtry

* Do the installation.

		llOK = This.DownloadFiles()
		llOK = llOK and This.ExtractFiles()
		llOK = llOK and This.InstallPackage()
		llOK = llOK and This.AddFilesToProject()
		if llOK
			try
				copy file (This.cInstaller) to (This.cPackagePath + justfname(This.cInstaller))
					&& Copy the installer to the package folder so we can uninstall if necessary.
			catch
				llOK = .F.
			endtry
		endif llOK

* Add the files to the repository if there is one.

		lnFiles = This.GetFilesInFolder(This.cPackagePath, @laFiles)
		for lnI = 1 to lnFiles
			This.AddToRepository(laFiles[lnI])
		next lnI
		This.AddToRepository(This.cPackagesPath + 'Packages.xml')

* Update the packages files.

		llOK = llOK and This.UpdatePackages()
		return llOK
	endfunc


* Fill an array with the files in the specified folder and all subdirectories.

	function GetFilesInFolder(tcFolder, taFiles)
		local lcFolder, ;
			laFiles[1], ;
			lnFiles, ;
			lnExisting, ;
			lnI, ;
			laFolders[1], ;
			lnFolders, ;
			lcCurrFolder, ;
			lnReturn
		lcFolder   = addbs(tcFolder)
		lnFiles    = adir(laFiles, lcFolder + '*.*', '', 1)
		lnExisting = alen(taFiles)
		lnExisting = iif(lnExisting = 1, 0, lnExisting)
		if lnExisting + lnFiles > 0
			dimension taFiles[lnExisting + lnFiles]
			for lnI = 1 to lnFiles
				taFiles[lnExisting + lnI] = lcFolder + laFiles[lnI, 1]
			next lnI
			lnFolders = adir(laFolders, lcFolder + '*.*', 'D', 1)
			for lnI = 1 to lnFolders
				lcCurrFolder = laFolders[lnI, 1]
				if 'D' $ laFolders[lnI, 5] and left(lcCurrFolder, 1) <> '.'
					This.GetFilesInFolder(lcFolder + lcCurrFolder, @taFiles)
				endif 'D' $ laFolders[lnI, 5] ...
			next lnI
			lnReturn = alen(taFiles, 1)
		else
			lnReturn = 0
		endif lnExisting + lnFiles > 0
		return lnReturn
	endfunc

* Abstract method overridden in a subclass.

	function InstallPackage
	endfunc


* Deletes the package folder and its contents.

	function RemovePackagePath(tlUpdate)
		local llOK
		if directory(This.cPackagePath)
			if tlUpdate
				raiseevent(This, 'Update', 'Deleting folder ' + This.cPackagePath)
			endif tlUpdate
			llOK = FileOperation(This.cPackagePath, '', 'DELETE')
			if not llOK
				lcMessage = 'Cannot delete package folder ' + This.cPackagePath
				raiseevent(This, 'Update', lcMessage)
				This.Log(lcMessage)
			endif not llOK
		else
			llOK = .T.
		endif directory(This.cPackagePath)
		return llOK
	endfunc


* Download all files.

	function DownloadFiles()
		local loInternet, ;
			loFile, ;
			lcURL, ;
			llReturn
		loInternet = newobject('VFPXInternet', 'VFPXInternet.prg')
		for each loFile in This.oFiles foxobject
			lcURL = loFile.cURL
			This.UpdateAndLog('Downloading file ' + justfname(lcURL))
			llReturn = loInternet.DownloadFile(lcURL, loFile.cLocalFile)
			if not llReturn
				raiseevent(This, 'Update', loInternet.cErrorMessage)
				This.Log(loInternet.cErrorMessage)
				exit
			endif not llReturn
		next loFile
		return llReturn
	endfunc


* Extract all zip files.

	function ExtractFiles()
		local llResult, ;
			loException, ;
			lnFiles, ;
			loFile, ;
			laFiles[1], ;
			lnNewFiles

* Delete all files in the extraction folder: PowerShell Expand-Archive gets
* cranky if the files already exist.

		llResult = .T.
		if directory(This.cExtractionPath)
			llResult = FileOperation(This.cExtractionPath, '', 'DELETE')
			if not llResult
				This.Log('Error deleting files in ' + This.cExtractionPath)
				return .F.
			endif not llResult
		endif directory(This.cExtractionPath)

* Create the extraction folder.

		try
			md (This.cExtractionPath)
		catch to loException
			This.Log('Error creating ' + This.cExtractionPath + ': ' + ;
				loException.Message)
			llResult = .F.
		endtry
		if not llResult
			return .F.
		endif not llResult

* Extract each compressed file.

		lnFiles = 0
		for each loFile in This.oFiles foxobject
			if inlist(upper(justext(loFile.cLocalFile)), 'ZIP', '7Z')
				llResult = This.ExtractFile(loFile.cLocalFile, This.cExtractionPath)
				if llResult
					lnNewFiles = adir(laFiles, addbs(This.cExtractionPath) + '*.*')
					llResult   = lnNewFiles > lnFiles
					if not llResult
						This.Log('Extracting ' + loFile.cLocalFile + ' into ' + This.cExtractionPath + ' failed')
					endif not llResult
				endif llResult
				if llResult
					lnFiles = lnNewFiles
				else
					exit
				endif llResult
			endif inlist(upper(justext(loFile.cLocalFile)) ...
		next lcFile
		return llResult
	endfunc


* Extract a file.

	function ExtractFile(tcSource, tcDestination)
		local loZip, ;
			llResult
		loZip    = newobject('VFPXZip', 'VFPXZip.prg')
		llResult = loZip.Unzip(tcSource, tcDestination)
		if llResult
			This.Log('Extraction complete')
		else
			This.Log('Error extracting from zip: ' + loZip.cErrorMessage)
		endif llResult
		return llResult
	endfunc


* Copy the specified file(s) to the package folder.

	function CopyExtractedFiles(tcSource)
		local llOK, ;
			lcMessage
		llOK = This.CopyFile(This.cExtractionPath + tcSource, This.cPackagePath)
		if llOK
			This.Log('Copying files complete')
		endif llOK
		return llOK
	endfunc


* Copies the specified file to the specified location.

	function CopyFile(tcSource, tcDestination)
		local lcDestination, ;
			lcMessage, ;
			llReturn
		if right(tcDestination, 1) = '\'
			lcDestination = left(tcDestination, len(tcDestination) - 1)
				&& Strip any trailing backslash as it prevents COPY FILE from working.
		else
			lcDestination = tcDestination
		endif right(tcDestination, 1) = '\'
		lcMessage = 'Copying ' + tcSource + ' to ' + lcDestination
		raiseevent(This, 'Update', lcMessage)
		This.Log(lcMessage)
		llReturn = FileOperation(tcSource, lcDestination, 'copy')
		if not llReturn
			lcMessage = lcMessage + ' failed'
			raiseevent(This, 'Update', lcMessage)
			This.Log(lcMessage)
		endif not llReturn
		return llReturn
	endfunc


* Update the packages file.

	function UpdatePackages(tlRemove)
		local lcPackagesFile, ;
			lnSelect, ;
			lcMessage
		lcPackagesFile = This.cPackagesPath + 'packages.xml'
		lnSelect       = select()
		This.Log('Updating packages file')
		create cursor Packages (Name C(60), Version C(20), Date D, RefCount I)
		if file(lcPackagesFile)
			xmltocursor(lcPackagesFile, 'Packages', 512 + 8192)
		endif file(lcPackagesFile)
		locate for upper(Name) = upper(This.cPackageName)
		do case
			case found() and tlRemove
				replace RefCount with RefCount - 1 in Packages
				if Packages.RefCount = 0
					delete in Packages
				endif Packages.RefCount = 0
			case tlRemove
			case not found()
				insert into Packages ;
					values ;
						(This.cPackageName, ;
						This.cVersion, ;
						date(), ;
						1)
			otherwise
				replace Version with This.cVersion, ;
						Date with date(), ;
						RefCount with RefCount + 1 ;
					in Packages
		endcase
		cursortoxml('Packages', lcPackagesFile, 1, 512)
		use in select('Packages')
		select (lnSelect)
	endfunc


* Add the package files to the project.

	function AddFilesToProject()
		local llReturn, ;
			loFile
		llReturn = .T.
		for each loFile in This.oFiles foxobject
			if loFile.lAddToProject
				llReturn = This.AddFileToProject(loFile.cLocalFile)
				if not llReturn
					exit
				endif not llReturn
			endif loFile.lAddToProject
		next loFile
		return llReturn
	endfunc


* Add the specified file to the project. If Project Explorer is open, add it to that.

	function AddFileToProject(tcFile)
		local lcMessage, ;
			lcFile, ;
			loPE, ;
			loFile, ;
			llReturn, ;
			lcMessage
		lcMessage = 'Adding ' + tcFile + ' to project'
		raiseevent(This, 'Update', lcMessage)
		This.Log(lcMessage)
		lcFile = tcFile
		if empty(justpath(lcFile))
			lcFile = This.cPackagePath + lcFile
		endif empty(justpath(lcFile))
		try
			if type('_screen.oProjectExplorers[1].Name') = 'C'
				loPE = _screen.oProjectExplorers[1]
				try
					loFile = loPE.oProject.oProject.Files.Item(justfname(lcFile))
				catch
					loFile = NULL
				endtry
				if vartype(loFile) <> 'O'
					loFile    = loPE.AddItem(lcFile)
					llReturn  = not isnull(loFile)
					lcMessage = 'Project Explorer failed to add file'
				else
					This.Log(loFile.Name + ' is already in the project')
					llReturn = .T.
				endif vartype(loFile) <> 'O'
			else	
				try
					loFile = This.oProject.Files.Item(justfname(lcFile))
				catch
					loFile = NULL
				endtry
				if vartype(loFile) <> 'O'
					loFile = This.oProject.Files.Add(lcFile)
					loFile.Exclude = .F.
				else
					This.Log(loFile.Name + ' is already in the project')
				endif vartype(loFile) <> 'O'
				llReturn = .T.
			endif type('_screen.oProjectExplorers[1].Name') = 'C'
		catch to loException
			lcMessage = loException.Message
		endtry
		if not llReturn
			raiseevent(This, 'Update', 'Adding file to project failed: see log file for details')
			This.Log('Error adding ' + lcFile + ' to project: ' + ;
				lcMessage)
		endif not llReturn
		return llReturn
	endfunc


* Add the specified file to the project repository if there is one.

	function AddToRepository(tcFile)
		local lcCommand, ;
			loAPI, ;
			llReturn, ;
			lnCode
*** TODO: don't add to repository if there isn't one.
		lcCommand = 'git add "' + tcFile + '"'
		loAPI     = newobject('API_AppRun', 'API_AppRun.prg', '', lcCommand, '', 'HID')
		llReturn  = loAPI.LaunchAppAndWait()
		if llReturn
			lnCode   = loAPI.CheckProcessExitCode()
			llReturn = lnCode = 0
			if not llReturn
				This.Log('Adding ' + tcFile + ' to Git failed with error code ' + ;
					transform(lnCode))
			endif not llReturn
		endif llReturn
		return llReturn
	endfunc


* Uninstall the package: remove the files from the project and delete the package folder.

	function Uninstall
		local lcMessage, ;
			llOK, ;
			laFiles[1], ;
			lnFiles
		This.cLogFile = This.cPackagesPath + 'log.txt'
		lcMessage = '===== Uninstalling ' + This.cPackageName
		raiseevent(This, 'Update', lcMessage)
		This.Log(lcMessage)
		llOK = This.RemoveFilesFromProject()
		llOK = llOK and This.UninstallPackage()
		llOK = llOK and This.UpdatePackages(.T.)
*** TODO: do we need to do this? See comment in RemoveFromRepository.
*		lnFiles = This.GetFilesInFolder(This.cPackagePath, @laFiles)
*		for lnI = 1 to lnFiles
*			This.RemoveFromRepository(laFiles[lnI])
*		next lnI
		llOK = llOK and This.RemovePackagePath(.T.)
		return llOK
	endfunc


* Abstract method overridden in a subclass.

	function UninstallPackage
	endfunc


* Remove the package files from the project.

	function RemoveFilesFromProject()
		local llReturn, ;
			loFile
		llReturn = .T.
		for each loFile in This.oFiles foxobject
			if loFile.lAddToProject
				llReturn = This.RemoveFileFromProject(loFile.cLocalFile)
				if not llReturn
					exit
				endif not llReturn
			endif loFile.lAddToProject
		next loFile
		return llReturn
	endfunc


* Remove the specified file from the project. If Project Explorer is open, remove it from that.

	function RemoveFileFromProject(tcFile)
		local lcMessage, ;
			lcFile, ;
			llReturn, ;
			loFile
		lcMessage = 'Removing ' + tcFile + ' from project'
		raiseevent(This, 'Update', lcMessage)
		This.Log(lcMessage)
		lcFile = tcFile
		if empty(justpath(lcFile))
			lcFile = This.cPackagePath + lcFile
		endif empty(justpath(lcFile))
		try
			if type('_screen.oProjectExplorers[1].Name') = 'C' and ;
				_screen.oProjectExplorers[1].SelectNodeForFile(lcFile)
				llReturn = _screen.oProjectExplorers[1].RemoveItem(.T.)
			else
				try
					loFile = This.oProject.Files.Item(lcFile)
				catch
					loFile = NULL
				endtry
				if vartype(loFile) = 'O'
					loFile.Remove()
				else
					This.Log(lcFile + ' is not in the project so it was not removed')
				endif vartype(loFile) = 'O'
				llReturn = .T.
			endif type('_screen.oProjectExplorers[1].Name') = 'C' ...
		catch to loException
			raiseevent(This, 'Update', 'Removing file from project failed: see log file for details')
			This.Log('Error removing ' + lcFile + ' from project: ' + ;
				loException.Message)
		endtry
		return llReturn
	endfunc


* Remove the specified file from the project repository if there is one.

	function RemoveFromRepository(tcFile)
*** TODO: do we need this: when we commit, the files will just be missing, which is fine.
	endfunc


* Decode an HTML-encoded filename.

	function Decode(tcFile)
		local lcFile
		lcFile = strtran(tcFile, '%20', '')
			&& PowerShell Extract-Archive can't handle spaces in filenames so
			&& we'll strip them out
		return lcFile
	endfunc


* This method is here so we can use RAISEEVENT to tell anything listening what's
* happening.

	function Update(tcMessage)
	endfunc


* Do both log and update.

	function UpdateAndLog(tcMessage)
		This.Log(tcMessage)
		raiseevent(This, 'Update', tcMessage)
	endfunc

* Write to the log file.
	
	function Log(tcMessage)
		strtofile(tcMessage + ccCRLF, This.cLogFile, .T.)
	endfunc
enddefine

define class FoxGetFile as Custom
	cURL          = ''
	cLocalFile    = ''
	lAddToProject = .F.
enddefine
  