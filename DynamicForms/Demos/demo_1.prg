*-- Demo 1 - Binding to a cursor, showing ALL fields
	Close Databases

	If Used('Jobs')
		Use in Jobs
	Endif

	Select 0
	Use Jobs
	loForm = CreateObject('DynamicForm')
	loForm.Caption = 'Dynamic Forms Demo'
	loForm.cHeading = 'Job ' + Jobs.job_num

	loForm.cAlias = 'Jobs'
	
	loForm.oRenderEngine.nColumnHeight = 400

	loform.Show()

	If Vartype(loForm) = 'O'
		loForm.Release()
	EndIf
