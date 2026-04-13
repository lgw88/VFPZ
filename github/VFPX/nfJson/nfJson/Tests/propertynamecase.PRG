* This test shows how you can specify the case for property names.

if not file('nfJsonCreate.prg')
	set path to ..\
endif not file('nfJsonCreate.prg')

loItem = createobject('Sample')
loItem.Address.Address    = '123 Main Street'
loItem.Address.City       = 'Anywhere'
loItem.Address.Region     = 'MyRegion'
loItem.Address.Country    = 'Canada'
loItem.Address.PostalCode = 'H0H 0H0'

lcJSON = nfJSONCreate(loItem, .T.)
messagebox(lcJSON, 0, 'JSON Using Default Case')

dimension laProperties[7, 4]
laProperties[1, 1] = 'Date'
laProperties[2, 1] = 'ID'
laProperties[3, 1] = 'Address'
laProperties[4, 1] = 'City'
laProperties[5, 1] = 'Region'
laProperties[6, 1] = 'Country'
laProperties[7, 1] = 'PostalCode'

lcJSON = nfJSONCreate(loItem, .T., , , , , @laProperties)
messagebox(lcJSON, 0, 'JSON Using Specified Property Case')

define class Sample as Custom
	Date    = date()
	ID      = 12345
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
enddefine
