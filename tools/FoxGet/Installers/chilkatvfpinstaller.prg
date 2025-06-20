lcPath = addbs(justpath(sys(16)))
set procedure to (forcepath('foxget.prg', fullpath('..\Source\', lcPath)))  additive
loInstaller = createobject('ChilkatVFPInstaller')
loInstaller.Install()

define class ChilkatVFPInstaller as FoxGet of FoxGet.prg
	cBaseURL = 'https://raw.githubusercontent.com/billand88/ChilkatVFP/main/'

* Define the files to download. Note that URLs are case-sensitive. Also, we'll
* download directly to the package folder since there's nothing to unzip, and
* we'll add certain files to the project. Since FoxGet does all that, there are
* no custom tasks to perform.

	function Setup
		This.AddFile('Msgsvc.DBF',     .T., This.cPackagePath)
		This.AddFile('chilkatvfp.h',   .F., This.cPackagePath)
		This.AddFile('chilkatvfp.vct', .F., This.cPackagePath)
		This.AddFile('chilkatvfp.vcx', .T., This.cPackagePath)
		This.AddFile('chilkatvfpeventcallbacks.prg',       .T., This.cPackagePath)
		This.AddFile('chilkatvfpeventcallbacksprev52.prg', .T., This.cPackagePath)
		This.AddFile('chilkatvfpeventcallbacksprev58.prg', .T., This.cPackagePath)
		This.AddFile('chilkatvfpeventcallbacksv58.prg',    .T., This.cPackagePath)
		This.AddFile('chmsgsvc.prg',    .T., This.cPackagePath)
		This.AddFile('foxpro.h',        .T., This.cPackagePath)
		This.AddFile('ichilkatvfp.vct', .F., This.cPackagePath)
		This.AddFile('ichilkatvfp.vcx', .T., This.cPackagePath)
		This.AddFile('msgsvc.cdx',      .T., This.cPackagePath)
		This.AddFile('msgsvc.fpt',      .T., This.cPackagePath)
	endfunc
enddefine
