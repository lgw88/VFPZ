* Created: 02/16/12 07:21:19 AM
Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to
*   tell Thor about itself.

If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' = Lower (lxParam1.Class)

	With lxParam1

		* Required
		.Prompt		   = 'Enhanced Cut' && used when tool appears in a menu
		Text to .Description NoShow
Like normal cut (Ctrl-X), but deletes the current line if nothing is highlighted.
		EndText

		* Optional
		.StatusBarText = .Description
		.Summary       = .Description

		* For public tools, such as PEM Editor, etc.
		.Source		   = 'Thor Repository'
		.Sort		   = 60 
		.Category      = 'Code|Enhanced Cut/Copy'
		.Link          = 'http://vfpx.codeplex.com/wikipage?title=PEMEditor%20Tools%20Enhanced%20Cut'
		.VideoLink     = ''
		.CanRunAtStartUp = .F.
	Endwith

	Return lxParam1
Endif

Do ToolCode

Return


****************************************************************
****************************************************************
* Normal processing for this tool begins here.                  
Procedure ToolCode
   	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_PEME_EnhancedCutCopy', 'Cut')
EndProc 
