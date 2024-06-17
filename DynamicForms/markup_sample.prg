Text to lcBodyMarkup NoShow

	id					:enabled => .f.	
							:fontbold => .t.
							:label.FontBold => .t. |
	
	ad_type 		:class => 'combobox'
							:RowSource => 'laOptions'
							:RowSourceType => 5 
							:row-increment => 0 |

	bool_3			:caption => 'You can specify BOLD captions.'
							:FontBold => .t.
							:width => 200 |
	
	first_name	:set-focus => .t. |
	mid_init		:row-increment => 0 |
	last_name		:row-increment => 0 |

	notes				:class => 'editbox'
							:width => 400
							:height => 80
							:anchor => 10 |

	lnPrice			:label.caption => 'List Price'
							:label.alignment => 1 |
							
	weight			:row-increment  => 0
							:label.alignment => 1 |
	
	lnOption		:class => 'optiongroup'
							:caption => 'Color options:'
							:buttoncount => 2
							:width => 200
							:height => 60
							:option1.caption => 'Red with orange stripes'
							:option1.autosize => .t.
							:option2.caption => 'Purple with black dots'
							:option2.autosize => .t. |

	:class => 'label' :caption => 'Thank you for trying DynamicForm.'
									  :autosize => .t.
										:render-if => (Day(Date()) > 1)

EndText

