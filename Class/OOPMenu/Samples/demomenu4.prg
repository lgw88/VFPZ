public oMenu
set path to ..\source
oMenu = newobject('SFMenu', 'SFMenu.vcx', '', 'oMenu')

* Create the File pad.

oMenu.AddPad('SFPad', 'SFMenu.vcx', 'FilePad')
with oMenu.FilePad
	.cCaption       = '\<File'
	.cKey           = 'ALT+F'
	.cStatusBarText = 'Performs file functions'

	.AddBar('SFBar', 'SFMenu.vcx', 'FileNew')
	with .FileNew
		.cCaption        = '\<New...'
		.cKey            = 'CTRL+N'
		.cKeyText        = 'Ctrl+N'
		.cStatusBarText  = 'Create a file'
		.cPictureFile    = 'newxpsmall.bmp'
		.cOnClickCommand = [messagebox('You chose File, New')]
	endwith

	.AddBar('SFBar', 'SFMenu.vcx', 'FileOpen')
	with .FileOpen
		.cCaption        = '\<Open...'
		.cKey            = 'CTRL+O'
		.cKeyText        = 'Ctrl+O'
		.cStatusBarText  = 'Open a file'
		.cPictureFile    = 'openxpsmall.bmp'
		.cOnClickCommand = [messagebox('You chose File, Open')]
	endwith

	.AddBar('SFBar', 'SFMenu.vcx', 'ToolsFrench')
	with .ToolsFrench
		.cCaption        = '\<Change to French'
		.cStatusBarText  = 'Changes the menu to French'
		.cOnClickCommand = [do ChangeToFrench]
	endwith

	.AddSeparatorBar()

	.AddBar('SFBar', 'SFMenu.vcx', 'FileExit')
	with .FileExit
		.cCaption        = 'E\<xit'
		.cStatusBarText  = 'Restore the VFP menu'
		.cOnClickCommand = 'oMenu.Release()'
	endwith
endwith

* Create the Edit pad.

oMenu.AddPad('SFEditPad', 'SFMenu.vcx', 'EditPad')

* Display the menu.

messagebox("This demo shows localizing a menu after it's been created." + ;
	'Choose "Change to French".' + chr(13) + chr(13) + ;
	"After you're done viewing the " + ;
	'menu, choose File, Exit or type oMenu.Release() in the Command window.')
oMenu.Show()
