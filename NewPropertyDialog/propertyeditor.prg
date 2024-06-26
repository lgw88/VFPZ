lparameters tuEditorName, ;
	tcProperty
sys(2030, 1)
local laLevels[1], ;
	lnLevels, ;
	lcDirectory, ;
	lcLibrary, ;
	loEditor

* Determine the directory we're running in.

lnLevels    = astackinfo(laLevels)
lcDirectory = addbs(justpath(laLevels[lnLevels, 4]))

* Create the specified editor, handling the cases where it isn't specified or
* isn't registered.

do case
	case not vartype(tuEditorName) $ 'CN' or empty(tuEditorName)
		messagebox('Must specify editor name.', 48, 'Property Editor')
		return
	case not OpenEditorsTable(lcDirectory)
		return
	case (vartype(tuEditorName) = 'C' and ;
		seek(upper(tuEditorName), 'PropertyEditors', 'Name')) or ;
		(vartype(tuEditorName) = 'N' and ;
		seek(tuEditorName, 'PropertyEditors', 'ID'))
		lcLibrary = textmerge(PropertyEditors.Library)
		if not file(lcLibrary)
			lcLibrary = forcepath(lcLibrary, lcDirectory)
		endif not file(lcLibrary)
		if file(lcLibrary)
			loEditor = newobject(PropertyEditors.Class, lcLibrary)
		else
			messagebox('The library specified for ' + ;
				transform(tuEditorName) + ' cannot be located.', 48, ;
				'Property Editor')
			return
		endif file(lcLibrary)
	otherwise
		messagebox(transform(tuEditorName) + ' is not a registered editor.', ;
			48, 'Property Editor')
		return
endcase
use in PropertyEditors

* If a property name was specified (for example, for an editor that can work
* with several properties), set the cProperty property of the editor to it.

if vartype(tcProperty) = 'C' and not empty(tcProperty)
	loEditor.cProperty = tcProperty
endif vartype(tcProperty) = 'C' ...

* Tell the editor to do its thing.

loEditor.EditProperty()

* Try to open the PropertyEditors table in the same directory as this PRG is.

function OpenEditorsTable(tcDirectory)
do case
	case used('PropertyEditors')
	case not file(tcDirectory + 'PropertyEditors.dbf')
		messagebox('PropertyEditors.dbf could not be located.', 48, ;
			'Property Editor')
	otherwise
		try
			use (tcDirectory + 'PropertyEditors') in 0 again shared
		catch to loException
			messagebox('The following error occurred while trying to open ' + ;
				'PropertyEditors.dbf:' + chr(13) + chr(13) + ;
				loException.Message, 48, 'Property Editor')
		endtry
endcase
return used('PropertyEditors')
