****************************************************************
*	First Section: Compile-time constants -- modify as needed  *
****************************************************************

* snippet-keyword: case insensitive, NOT in quotes
#Define Snippet_Keyword 	CT

* delimiter between parameters, IN QUOTES; if empty, only one parameter
#Define Delimiter_Char	 	','

* minimum number of parameters to be accepted
#Define Min_Parameters      1    

* maximum number of parameters to be accepted
#Define Max_Parameters      1




*****************************************************************
*	 Middle Section: Setup and cleanup code:  DO NOT CHANGE!!!  *
*****************************************************************

Lparameters lcParameters, lcKeyWord

Local loParams As Collection
Local lcParams, lnI

Do Case
		* if no parameters passed, this is a request for Help
	Case Pcount() = 0
		Return PublishHelp()

		* Only process our keyword 
	Case Pcount() = 2 And Not Upper ([Snippet_Keyword]) == lcKeyWord
		Return .F. && not mine!

	Otherwise
		lcParams = _oPEMEditor.ExtractSnippetParameters(lcParameters, Delimiter_Char, [Snippet_Keyword], Min_Parameters, Max_Parameters)
		If 'C' = VarType (lcParams)
			Return Process (&lcParams)
		Endif
Endcase


Function CreateHelpResult (lcSyntax, lcSummaryHTML, lcDetailHTML)
	Local loResult As 'Empty'
	loResult = Createobject ('Empty')
	AddProperty (loResult, 'Name', [Snippet_Keyword])
	AddProperty (loResult, 'Syntax', Evl (lcSyntax, ''))
	AddProperty (loResult, 'Summary', Evl (lcSummaryHTML, ''))
	AddProperty (loResult, 'Detail', Evl (lcDetailHTML, ''))
	Return loResult
Endproc




*****************************************************************
****** Last Section: Custom code for this snippet				*
*****************************************************************

#Define CR   Chr(13)
#Define LF   Chr(10)
#Define CRLF Chr(13) + Chr(10)
#Define Tab  Chr(9)

* Put your code here to process the parameters passed; make sure to set parameters appropriately
* Result is one of following:
*   character string -- string to insert into edit window, replacing the snippet there (usual case, by far)
*                       if the characters '^^^' are found, they indicate where the cursor is to be placed
*   .T.              -- handled, but edit window already updated (advanced use)
*   .F.              -- not handled

Function Process
    Lparameters tcParam
    Local lcNewText, lcParam
    
    If tcParam = '='
    	lcParam = Substr(tcParam, 2)
    Else
    	lcParam = ['] + tcParam + [']
    EndIf 
    
    Text to lcNewText textmerge NoShow
Use in (Select (<<lcParam>>)) && Close <<lcParam>>
    EndText
    Return lcNewText
EndFunc



***************************************************************************************************
* Publish the help for this snippet: calls function CreateHelpResult with three parameters:
*    Syntax
*    Summary
*    Full description

* Note that all have these may contain HTML tags
***************************************************************************************************

Function PublishHelp
	Local lcDetailHTML, lcSummaryHTML, lcSyntax
	
	lcSyntax = [Alias]

	Text To lcSummaryHTML Noshow
        Close a table, if open
    EndText
	
	Text To lcDetailHTML Noshow
		Close a table.  
		
		<br><br>
		If 'Alias' is to be interpreted as a variable name, precede it with '='. 
		<br><br>Examples:<br> CT Customers<br> CT =lcAlias
    EndText

	Return CreateHelpResult (lcSyntax, lcSummaryHTML, lcDetailHTML)
Endproc

