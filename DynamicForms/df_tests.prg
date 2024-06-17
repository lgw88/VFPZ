Private loJob, loObject
Private lnPrice, laOptions[1], lnOption

loObject = CreateObject('Empty')
AddProperty(loObject , 'id', '12345')
AddProperty(loObject , 'first_name', 'Joe')
AddProperty(loObject , 'mid_init', 'N.')
AddProperty(loObject , 'last_name', 'Coderman')
AddProperty(loObject , 'ad_type', 'Banner')
AddProperty(loObject , 'notes', 'This man came here and wrote some codez.')
AddProperty(loObject , 'still_here', .f.)
AddProperty(loObject , 'has_laptop', .t.)
AddProperty(loObject , 'bool_1', .t.)
AddProperty(loObject , 'bool_2', .t.)
AddProperty(loObject , 'bool_3', .t.)
AddProperty(loObject , 'weight', 185)

*-- Example of a Private variables that can be bound to also
lnPrice = 107.15
lnOption = 2

*-- Array of options/values to display in the ComboBox defined in cFieldList above (note that it's declared Private above ---
Dimension laOptions[3]
laOptions[1] = 'Banner'
laOptions[2] = 'Placard'
laOptions[3] = 'Name Tag'



Cd h:\work\repos\dynamicForm && Adjust path to you local dev environment as needed
Set Procedure To DynamicForm Additive && Adjust path to you local dev environment as needed

If !Used('Jobs')
	Use Demos\Jobs In 0
EndIf

Select Jobs
Goto top
Scatter Name loJob Memo

Set Procedure To DynamicForm additive

? ' '
? ' '
? ' '

*clear
Do execute_code_test

Do largedemo1 with .f., '.class = "label" .caption = "Thanks!!" | .class = "DF_HorizontalLine"', '', '.class = "DF_CancelButton"'

Do passing_a_container_to_the_render_engine_test
Do attributes_with_numbers_passed_as_strings_test
Do jrn_syntax_test
Do bind_to_all_fields_on_an_alias_test
Do modeless_form_test
Do minheight_and_minwidth_test
Do binding_errors_test
Do largedemo1 with .t.
Do largedemo1 with .f.
Do largedemo1 with .t., '', '', '.class = "DF_CancelButton"'
Do largedemo1 with .t., '.class = "DF_CancelButton"', '', ''


*--------------------------------------------------------------------------------------- 
Procedure passing_a_container_to_the_render_engine_test

	Local loContainer as 'container'
	Local loEngine as 'DynamicFormRenderEngine'
	Local lcBodyMarkup, llResult

	PrintTestName()
	
	loEngine = CreateObject('DynamicFormRenderEngine')

	lcBodyMarkup = "job_num .enabled = .F. | cust_num | status | job_start |"
	loEngine.cFooterMarkup = ''

	loEngine.cBodyMarkup = lcBodyMarkup 
	loEngine.oDataObject = loJob
	loEngine.lLabelsAbove = .t.

	loContainer = CreateObject('container')
	llResult = loEngine.Render(loContainer)

	PrintResult(llResult)
	
Endproc


*--------------------------------------------------------------------------------------- 
Procedure modeless_form_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult

	PrintTestName()

	loForm = CreateObject('DynamicForm')
	lcBodyMarkup = BigFieldList()
	loForm.cBodyMarkup = lcBodyMarkup 
	loForm.cHeading = gcTestName
	loForm.oRenderEngine.lLabelsAbove = .t.
	loForm.oDataObject = loObject && Set the data object that the form fields bind to
	
	llResult = loForm.Render()
	
	loForm.lClearEventsOnClose = .t.
	loForm.Show(0)
	
	Read events

	PrintResult(llResult)
	
Endproc

*--------------------------------------------------------------------------------------- 
Procedure jrn_syntax_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult
	
	PrintTestName()

	loForm = CreateObject('DynamicForm')
	lcBodyMarkup = BigFieldList()
	lcBodyMarkup = Strtran(lcBodyMarkup, ':', '.')
	lcBodyMarkup = Strtran(lcBodyMarkup, '=', '=')
	loForm.cHeading = gcTestName
	loForm.oRenderEngine.lLabelsAbove = .t.
	loForm.oDataObject = loObject && Set the data object that the form fields bind to
	
	llResult = loForm.Render(lcBodyMarkup )
	PrintResult(llResult)
	loForm.Show()
	
	
Endproc
*--------------------------------------------------------------------------------------- 
Procedure attributes_with_numbers_passed_as_strings_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult 
	
	Private lcTest
	
	PrintTestName()
		
	lcTest = ''
	loForm = CreateObject('DynamicForm')

	loForm.cHeading = gcTestName
	loForm.oRenderEngine.lLabelsAbove = .t.

	Text to lcBodyMarkup NoShow
		
			.class = 'label' .caption = 'This next textbox should be pushed down and in very far due to margin-top and  margin-left '
				.width = 500 .height = 100 .wordwrap = .t. |

			lcTest .left = 10 .margin-left = 200 .top = 70 .margin-top = 200 .margin-bottom = 200 |
			
			.class = 'label' .caption = 'This label should be pushed down due to margin-bottom of previous control'
				.width = 500 .height = 100 .wordwrap = .t.
		
	EndText
	
	llResult = loForm.Render(lcBodyMarkup)
	PrintResult(llResult)
	loForm.Show()
	
Endproc

*--------------------------------------------------------------------------------------- 
Procedure bind_to_all_fields_on_an_alias_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult
	
	PrintTestName()

	loForm = CreateObject('DynamicForm')
	loForm.cHeading = gcTestName
	loForm.cAlias = 'Jobs'
	loForm.oRenderEngine.nColumnHeight = 400
	
	llResult = loForm.Render()
	PrintResult(llResult)
	loForm.Show()	

Endproc

*--------------------------------------------------------------------------------------- 
Procedure minheight_and_minwidth_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult
	
	PrintTestName()
	
	loForm = CreateObject('DynamicForm')
	loForm.cHeading = gcTestName
	lcBodyMarkup = 'Month | llProj .Caption = "Projections?"'
	
	Text to lcBodyMarkup Noshow

		.class = 'label' .width = 300 .height = 100 .wordwrap = .t.
				.caption = 'This test tests the MinWidth and MinHeight for the form, so the form should render much larger than
										its normal resize-to-fit-controls behaviour.'

	EndText
	
	loForm.MinHeight = 700
	loForm.MinWidth = 700
	
	llResult = loForm.Render(lcBodyMarkup)
	PrintResult(llResult)
	loForm.Show()
		
Endproc

*--------------------------------------------------------------------------------------- 
Procedure execute_code_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult
	
	PrintTestName()
	
	loForm = CreateObject('DynamicForm')
	
	Text to lcBodyMarkup Noshow

		(MessageBox('Executing some VFP code from the markup syntax.')) |
		.cHeading = (gcTestName) |
		(This.nLastControlBottom = 200) |
		.class = 'label'
			.width = 300
			.height = 100
			.wordwrap = .t.
			.caption = 'This test executes some FoxPro code.' |
		(? Chr(13) + Chr(13) + Chr(13) + 'Did you see a messagebox?') |
		
				
				
	EndText
	
	loForm.MinHeight = 700
	loForm.MinWidth = 700
	
	llResult = loForm.Render(lcBodyMarkup)
	PrintResult(llResult)
	loForm.Show()
		
Endproc

*--------------------------------------------------------------------------------------- 
Procedure binding_errors_test
	
	Local loForm as 'DynamicForm'
	Local lcBodyMarkup, llResult
	Private lcTest
	
	PrintTestName()
	
	loForm = CreateObject('DynamicForm')
	loForm.cHeading = gcTestName
	lcBodyMarkup = 'lnMonth | llProj'
	
	Text to lcBodyMarkup Noshow
		llNotDefined_1 |
		llNotDefined_2 .width = 200 |
		.class = 'label' .width = 300 .height = 100 .wordwrap = .t.
				.caption = ('This markup attempts to bind to private vars which are not defined. There should be' + 
											'two red error boxes on the form.')

	EndText
	
	llResult = loForm.Render(lcBodyMarkup)
	PrintResult(loForm.oRenderEngine.nErrorCount = 2)
	loForm.Show()
		
Endproc



*--------------------------------------------------------------------------------------- 
Procedure LargeDemo1

	Lparameters tlLabelsAbove, tcHeaderMarkup, tcBodymarkup, tcFooterMarkup

	Local loForm as 'DynamicForm'

	PrintTestName()
		
	loForm = CreateObject('DynamicForm')

	loForm.Caption = 'Edit data'
	loForm.oDataObject = loObject && Set the data object that the form fields bind to
	loForm.cHeading = 'cHeading appears here, if set.'

	loForm.oRenderEngine.lLabelsAbove = tlLabelsAbove && Generate label above each control (default is to the left of the control) (default is .F., which meaans "inline with controls")

	*-- Set Header markup -------------------------
	If Vartype(tcHeaderMarkup) = 'C'
		loForm.cHeaderMarkup = tcHeaderMarkup
	Endif

	*-- Set Body markup -------------------------
	If Empty(tcBodymarkup)
		loForm.oRenderEngine.cBodyMarkup =  BigFieldList()
	Else
		loForm.oRenderEngine.cBodyMarkup =  tcBodymarkup
	Endif

	*-- Set Footer markup -------------------------
	If Vartype(tcFooterMarkup) = 'C'
		loForm.cFooterMarkup = tcFooterMarkup
	Endif

	llResult = loForm.Render()

	If llResult = .t.
		?? 'Passed.'
		loForm.Show(1) && 1 = Modal.  If you want to use Modeless, you'll need make a Read Events call here after showing form.
	Else
		?? '*** Failed.***'
		MessageBox(loForm.oRenderEngine.GetErrorsAsString() , 0, 'Notice:')
		loForm.Show(1)
	Endif

	If Vartype(loForm) = 'O' and Lower(loForm.cReturn) = 'save'
	Else
	EndIf

	Release loForm

Endproc



*======================================================================================= 
Procedure BigFieldList

	Local lcBodyMarkup 

		Text to lcBodyMarkup NoShow

			id					.enabled = .f.	
									.fontbold = .t.
									.label.FontBold = .t. |
			
			ad_type 		.class = 'combobox'
									.RowSource = 'laOptions'
									.RowSourceType = 5 
									.top = 150|

			bool_3			.caption = 'You can specify BOLD captions.'
									.FontBold = '.t.'
									.width = '200' 
									.margin-left = 50 |
			
			first_name	|
			mid_init		.row-increment = 0 |
			last_name		.row-increment = 0 |

			notes				.class = 'editbox'
									.width = 400
									.height = 80
									.anchor = 10
									.margin-left = 1
									.margin-top = 1
									.margin-bottom = 1 |
			
			lnPrice			.label.caption = 'List Price'
									.label.alignment = 1	|
									
			weight			.row-increment  = 0
									.label.alignment = 1 |
			
			lnOption		.class = 'optiongroup'
									.caption = 'Color options.'
									.buttoncount = 2
									.width = 200
									.height = 60
									.option1.caption = 'Red with orange stripes'
									.option1.autosize = .t.
									.option2.caption = 'Purple with black dots'
									.option2.autosize = .t. |

			.class = 'label' .caption = 'Thank you for trying DynamicForm.'
											  .autosize = .t.
												.render-if = (Day(Date()) > 0)
												.column = 1

		EndText

	Return lcBodyMarkup 


Endproc
     
     
*--------------------------------------------------------------------------------------- 
Procedure PrintResult(tlResult)

	If tlResult
		?? ' passed.'
	Else
		?? '*** Failed.***'
	Endif	


Endproc

*---------------------------------------------------------------------------------------
Procedure PrintTestName
	
	Public gcTestName

	gcTestName = Lower(GetWordNum(Sys(16, 2), 2))
	
	? gcTestName + '...'

	
Endproc
  