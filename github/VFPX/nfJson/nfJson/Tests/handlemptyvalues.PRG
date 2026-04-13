* This test shows how you can omit properties with empty values or output them as null.

if not file('nfJsonCreate.prg')
	set path to ..\
endif not file('nfJsonCreate.prg')

loItem = createobject('Sample')

dimension laProperties[4, 4]
laProperties[1, 1] = 'Height'
laProperties[1, 2] = 'Sample'	&& applies to Sample only
laProperties[1, 3] = .F.
laProperties[1, 4] = 0			&& output empty value
laProperties[2, 1] = 'Width'
laProperties[2, 2] = 'Sample'	&& applies to Sample only
laProperties[2, 3] = .F.
laProperties[2, 4] = 1			&& output value as null if empty
laProperties[3, 1] = 'Comment'
laProperties[3, 2] = 'Address'	&& applies to Address only
laProperties[3, 3] = .F.
laProperties[3, 4] = 2			&& omit property if value is empty
laProperties[4, 1] = 'Name'		&& needed because we're use "UC" for members flag and Name is changed
laProperties[4, 2] = ''			&& applies to everything
laProperties[4, 3] = .T.

lcJSON = nfJSONCreate(loItem, .T., , , 'UC', , @laProperties)
messagebox(lcJSON, 0, 'JSON Handling Empty Specially')

define class Sample as Custom
	ID      = 0
	Height  = 0
	Width   = 0
	Address = NULL

	function Init
		This.Address = createobject('Address')
	endfunc
enddefine

define class Address as Custom
	Address    = ''
	City       = ''
	Region     = ''
	PostalCode = ''
	Country    = ''
	Comment    = ''
enddefine
