
Private lcName , lnAge, llInput

lcName = 'John Smith'
lnAge = 0
llInput = .f.

Set Proc To 'DynamicForm' Additive 
loForm = CreateObject('DynamicForm')

*-- You can set any form property, engine property, or
*-- host container property in normal code, or in markup
*-- as shown below.
loForm.Caption = 'Dynamic Form Example'
loForm.MinWidth = 400
loForm.MinHeight = 300

*-- Notice these same properties can be set in markup too:
Text to lcBodyMarkup NoShow
	
		.cHeading = 'Dynamic Form has new features.'
		.cSaveButtonCaption = 'OK'
		.cCancelButtonCaption = 'No thanks'
		.lLabelsAbove = .t. 
		
		.form-caption = 'Dynamic Form Example'
		.form-minwidth = 400
		.form-minheight = 300

		.container-margin-top = 10
		.container-margin-bottom = 10
		.container-margin-left = 10 
		.container-margin-right = 10
		.container-borderwidth = 2
		.container-bordercolor = (Rgb(200,200,200))
		.container-backcolor = (Rgb(180,208,233)) |

	    lcName .caption = 'Name' .width = 200 |

		lnAge	.caption = 'Age' .width = 50 |
		
		llInput .caption = 'Share data with others?' .width = 200 |
		
EndText

loForm.Render(lcBodyMarkup)

loForm.Show()

*	If Vartype(loForm) = 'O'
*		lcReturn = loForm.cReturn
*		loform.Release()

*		? lcName
*		? lnAge
*		? llHavingFunAtSWFox
*		
*		?lcReturn

*	Endif


*		:class = 'commandbutton' :caption = 'OK' :left = 60 :margin-top = 80 :height = 30|
*		:class = 'commandbutton' :caption = 'Cancel' :row-increment = 0 :height = 30 |
		
		

* :width = '50' :margin-top = 50 :centered = .t.











*"How do I define properties/methods in the form that's created?"

*The answer to this is that you should never use the DynamciForm class directly in your app, rather, you should cub-class it into you own class and extend it from there as needed.
	

*-- Define my own sub-class of DynamicForm --------------
Define Class MyDynamicForm as DynamicForm

     nMyNewNumeric = 1
     cMyNewString = ''
     oMyNewObject = .null.
     *Width = 500
     *Height = 200
     MinWidth = 350
     MinHeight = 200
     

	*--Override the default RenderEngine with my own subclass -------------------- 
	Procedure Init

		DoDefault()
		
		This.oRenderEngine = CreateObject('MyDynamicFormRenderEngine')

	Endproc

	*--------------------------------------------------------------------------------------- 
	Procedure MyNewProc

	   Lparameters tcParam1

	   Return 

	EndProc

EndDefine


*-- Define my own sub-class of DynamicFormRenderEnginer --------------
Define Class MyDynamicFormRenderEngine as DynamicFormRenderEngine

	   nMyNewNumeric = 1
     cMyNewString = ''
     oMyNewObject = .null.

     Procedure MyNewRednerProc
           Lparameters tnParam1
           Return
     EndProc

Enddefine



