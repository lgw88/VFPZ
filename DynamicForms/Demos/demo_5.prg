*-- Demo 4 - Binding to a cursor, using attributes in the the markup to add styling
	Close Databases

	Select 0	
	Use Jobs
	loForm = CreateObject('DynamicForm')
	loForm.Caption = 'Dynamic Forms Demo'
	loForm.cHeading = 'Job ' + Jobs.job_num

	loForm.cAlias = 'Jobs'
	
	loForm.oRenderEngine.lLabelsAbove =.f.
	
	Text to lcBodyMarkup NoShow
	
		ipkey
			:enabled => .f.
			:caption => 'Key Value'
			:label-fontbold => .t. |

		job_start |

		p_o_num
			:row-increment => 0 |

		ship_date
			:row-increment => 0 |

		ship_info
			:class => 'editbox'
			:width => 500
			:height => 200
			:anchor => 15 |

	EndText
	
	loForm.cBodyMarkup = lcBodyMarkup

	loform.Show()


* DEMO NOTES
*--------------------------------------------------------------------------------------- 
* 1. :row-increment => 0
* 2. loForm.oRenderEngine.lLabelsABove =.t.
