*-- Demo 2 - Binding to a cursor, showing all fields, except we'll skip a few.
	Close Databases

	Select 0	
	Use Jobs
	loForm = CreateObject('DynamicForm')
	loForm.Caption = 'Dynamic Forms Demo'	
	loForm.cHeading = 'Job ' + Jobs.job_num

	loForm.cAlias = 'Jobs'
	loForm.oRenderEngine.nColumnHeight = 400

	*-- Skip over certain fields.
	loForm.oRenderEngine.cSkipFields = 'ipkey, mach_cost, mat_cost, total_cost, mat_mkup' 
	
	loform.Show(1, _screen)

