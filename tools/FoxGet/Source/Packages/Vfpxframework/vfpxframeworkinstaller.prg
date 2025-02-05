lcPath = addbs(justpath(sys(16)))
set procedure to (forcepath('foxget.prg', fullpath('..\Source\', lcPath)))  additive
loInstaller = createobject('VFPXFrameworkInstaller')
loInstaller.Install()

define class VFPXFrameworkInstaller as FoxGet of FoxGet.prg
	cBaseURL = 'https://raw.githubusercontent.com/VFPX/VFPXFramework/main/'

* Define the files to download. Note that URLs are case-sensitive. Also, we'll
* download directly to the package folder since there's nothing to unzip, and
* we'll add certain files to the project. Since FoxGet does all that, there are
* no custom tasks to perform.

	function Setup
		This.AddFile('ThorUpdater\VFPXFramework.zip')
	endfunc

* Custom installation tasks: copy the files from the extraction folder to the package folder.
* Note that nothing is added to the project.

	function InstallPackage
		local llOK
		llOK = This.CopyExtractedFiles('*.*')
		return llOK
	endfunc
enddefine
