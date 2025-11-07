Lparameters tnInterval, tlInstallAllUpdates

* Thor - 1.47.02 - January 13, 2024 

ccThorHomeFolder = GetPath()

Local lcTableName, ldLastRunDate, lnSelect

If Not Empty (m.tnInterval) And 'N' = Vartype (m.tnInterval) And m.tnInterval > 0

	* ================================================================================
	lcTableName = ccThorHomeFolder + 'Tables\LastCheckForUpdatesDate.DBF'

	lnSelect = Select()
	Select 0
	If File (m.lcTableName)
		Use (m.lcTableName) Shared Again
	Else
		Create Table (m.lcTableName) Free (LastDate D)
	Endif

	If Reccount() = 0
		Append Blank
	Endif

	Goto Top
	ldLastRunDate = LastDate
	Use

	Select(m.lnSelect)
	* ================================================================================

	If Date() >= m.ldLastRunDate + m.tnInterval
		Do ccThorHomeFolder  + '../Thor.APP' With 'Run', .T. && installs Thor, but without startups
		Execscript (_Screen.cThorDispatcher, 'Thor_Tool_Thor_CheckForUpdates', m.tlInstallAllUpdates)
	Endif
Endif

Do ccThorHomeFolder  + '../Thor.APP' With 'Run', .F. && normal installation of Thor (with startups)

Return
