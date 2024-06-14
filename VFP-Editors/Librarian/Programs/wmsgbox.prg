************************************************************************************************
* Written by:  Gregory A. Green
************************************************************************************************
*
*  Routine for displaying a user information dialog box
*
FUNCTION WMSGBOX
LPARAMETERS tcMessage, tcTitle, tnButtons, tcIcon
LOCAL lnButton
DO CASE
	CASE PCOUNT() = 2
		tnButtons = 16
		tcIcon    = 'EXCLAIM'

	CASE PCOUNT() = 3
		tcIcon = 'EXCLAIM'
ENDCASE
lnButton = 0
DO FORM GKLMsgBox WITH tcMessage, tcTitle, tnButtons, tcIcon TO lnButton
RETURN lnButton
ENDFUNC