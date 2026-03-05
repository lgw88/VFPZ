* _regexp
RETURN CREATEOBJECT([_regexp])

DEFINE CLASS _regexp AS custom
	Height = 25
	Width = 28
	pattern = "*"		&& Contains the pattern (regular expression)
	Name ="_regexp"
	Visible = .T.
	DIMENSION matches[1]		&& Array containing the results of the string test

	PROCEDURE clear		&& Clears all values
		this.pattern = "*"
		this.matches = .f.
	ENDPROC
	PROCEDURE execute		&& Tests the pattern against the string
		LParameters tcStr, tlCaseMatters

		Local loRegEx, loMatch, loMatches, i

		loRegEx = CreateObject("VBScript.RegExp")
		loRegEx.pattern = this.pattern
		loRegEx.ignoreCase = !tlCaseMatters
		loRegEx.global = .T.

		loMatches = loRegEx.execute(tcStr)
		Dimension this.matches[Max(loMatches.count,1),2]
		taMatchInfo = .F.

		i = 1
		For Each loMatch In loMatches
			this.matches[i, 1] = loMatch.firstIndex + 1   && fox strings are not zero-based
			this.matches[i, 2] = loMatch.value
			i = i + 1
		EndFor

		loMatches = .F.
		loRegEx = .F.

		Return i -1
	ENDPROC

ENDDEFINE
