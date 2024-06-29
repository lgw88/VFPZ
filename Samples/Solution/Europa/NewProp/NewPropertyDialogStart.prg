* Create the code for the MENUHIT script.

#include NewPropertyDialog.H
local lcPath, ;
	lcMenuHitCode, ;
	lcNewPropertyCode, ;
	lnSelect
lcPath = addbs(justpath(sys(16)))

text to lcMenuHitCode noshow
lparameters toParameter
local lnSelect, ;
	lcCode, ;
	llReturn
try
	lnSelect = select()
	select 0
	use (_foxcode) again shared order 1
	if seek('M' + padr(upper(toParameter.MenuItem), len(ABBREV)))
		lcCode = DATA
	endif seek('M' ...
	use
	select (lnSelect)
	if not empty(lcCode)
		llReturn = execscript(lcCode, toParameter)
		if llReturn
			toParameter.ValueType = 'V'
		endif llReturn
	endif not empty(lcCode)
catch
endtry
return llReturn
endtext

* Create the code for the New Method and New Property menu items.

text to lcNewPropertyCode noshow textmerge
lparameters toParameter
local llReturn, ;
	llMethod, ;
	llClass
try
	llMethod = toParameter.MenuItem  = 'New Method...'
	llClass  = toParameter.UserTyped = 'Class'
	release _oNewProperty
	public _oNewProperty
	_oNewProperty = newobject('NewPropertyDialog', 'NewProperty.vcx', ;
		'<<forcepath('NewPropertyDialog.app', lcPath)>>', llMethod, ;
		llClass)
	_oNewProperty.Show()
	llReturn = .T.
catch
endtry
return llReturn
endtext

* Add the records to FOXCODE.

lnSelect = select()
select 0
use (_foxcode) again shared alias FOXCODE order 1
if not seek('SMENUHIT')
	insert into FOXCODE (TYPE, ABBREV, DATA) values ('S', 'MENUHIT', lcMenuHitCode)
endif not seek('SMENUHIT')
if not seek('MNEW PROPERTY...')
	insert into FOXCODE (TYPE, ABBREV, DATA) values ('M', 'NEW PROPERTY...', ;
		lcNewPropertyCode)
endif not seek('MNEW PROPERTY...')
if not seek('MNEW METHOD...')
	insert into FOXCODE (TYPE, ABBREV, DATA) values ('M', 'NEW METHOD...', ;
		lcNewPropertyCode)
endif not seek('MNEW METHOD...')
use
select (lnSelect)
messagebox(ccLOC_DIALOG_REGISTERED, MB_OK + MB_ICONINFORMATION)
