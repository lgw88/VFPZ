*-- Custom Dialog box --------------

loForm = CreateObject('DynamicForm')

Text to lcBodyMarkup

	.class = 'label'
	.caption = 'Do you want to try Dynamic Forms?'
	.FontSize = 14
	.FontName = 'Arial'
	.AutoSize = .t. 
	.margin-bottom = 15 |
	
	.class = 'DF_ResultButton'
	.caption = '\<Yes' |


	.class = 'DF_ResultButton'
	.caption = '\<No'
	.row-increment = 0 |

	.class = 'DF_ResultButton'
	.caption = '\<Cancel'
	.row-increment = 0 |
	
EndText

loForm.oRenderEngine.nControlLeft = 35
loForm.MinHeight = 100

loForm.Caption = 'Please consider this:'
loForm.cHeaderMarkup = ''
loForm.cBodyMarkup = lcBodyMarkup
loForm.cFooterMarkup = ''

loform.Show()

Do Case

	Case loForm.cReturn = 'Yes'
	 *...
	 
	Case loForm.cReturn = 'No'
	 *...
	 
	Case loForm.cReturn = 'Cancel'
	 *...
	 
Endcase


