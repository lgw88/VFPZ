* This test shows how collections can be serialized using the correct property name.

if not file('nfJsonCreate.prg')
	set path to ..\
endif not file('nfJsonCreate.prg')

loItem = createobject('Sample')
lcJSON = nfJSONCreate(loItem, .T.)
messagebox(lcJSON, 0, 'JSON Using Collection Tag Name')
lcJSON = nfJSONCreate(loItem, .T., , , , .T.)
messagebox(lcJSON, 0, 'JSON Using Correct Property Name')

define class Sample as Custom
	Date   = date()
	ID     = 12345
	Movies = NULL

	function Init
		This.Movies = createobject('Collection')
		This.Movies.Add('Star Wars')
		This.Movies.Add('The Empire Strikes Back')
		This.Movies.Add('Return of the Jedi')
	endfunc
enddefine
