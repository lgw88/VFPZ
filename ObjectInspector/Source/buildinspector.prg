Local laStack[1], lcApp, lcFolder, lcFullAppName, lcNewVersion

Astackinfo (laStack)
lcApp	 = laStack[1, 2]
lcFolder = Addbs (Justpath (lcApp))

lcNewVersion = UpdateInspectorVersionNumber()

lcFullAppName = lcFolder + '..\Inspector.app'
Build App (lcFullAppName) From ('Inspector.PJX') recompile

Execscript (_Screen.cThorDispatcher, 'Thor_Proc_GenerateSCCFilesOnProject', Fullpath ('Inspector.PJX'))

