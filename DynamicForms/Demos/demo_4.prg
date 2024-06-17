*-- Demo 4 - Binding to a cursor, using attributes in the the markup to add styling
	Close Databases

	Select 0	
	Use Jobs
	loForm = CreateObject('DynamicForm')
	loForm.Caption = 'Dynamic Forms Demo'
	loForm.cHeading = 'Job ' + Jobs.job_num

	loForm.cAlias = 'Jobs'
	loForm.oRenderEngine.nColumnHeight = 400
	
	*lcBodyMarkup = 'job_start | p_o_num | ship_date | ship_info' 

	Text to lcBodyMarkup NoShow
	
		ipkey :enabled => .f. :caption => 'Key Value'|
		job_start |
		p_o_num :caption => 'Notes' :width => 200|
		:class => 'commandbutton' :caption => '...' :width => 20 :row-increment => 0 :margin-left => -10|
		ship_date |
		ship_info3 :class => 'editbox' :width => 500 :height => 200 :anchor => 15 |
		
	EndText
	
	loForm.cBodyMarkup = lcBodyMarkup

	loform.Show()

* DEMO NOTES
*--------------------------------------------------------------------------------------- 
* 1. Add ipkey 											field ipkey |
* 2. Disable ipkey field 						:enabled => .f.
* 3. Add caption to p_o_num field 	:caption => 'PO No.'
* 4. Convert ship_info to edibox 		:class => 'editbox' :width => 500 :height => 200
* Add anchor to editbox							:anchor => 15



