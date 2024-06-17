*-- Demo 3 - Binding to a cursor, showing only selected fields using Markup Syntax
	Close Databases

	Select 0	
	Use Jobs
	loForm = CreateObject('DynamicForm')
	loForm.Caption = 'Dynamic Forms Demo'
	loForm.cHeading = 'Job ' + Jobs.job_num

	loForm.cAlias = 'Jobs'
	loForm.oRenderEngine.nColumnHeight = 400

	*-- Build custom list of fields
	lcBodyMarkup = 'job_start | p_o_num | ship_date | ship_info' 

	loForm.cBodyMarkup = lcBodyMarkup
	
	loForm.oRenderEngine.lLabelsabove = .t.

	loform.Show()

