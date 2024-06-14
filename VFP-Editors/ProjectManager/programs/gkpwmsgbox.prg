************************************************************************************************
* Written by:  Gregory A. Green
************************************************************************************************
*
*  Routine for displaying a user information dialog box
*
FUNCTION GKPWMSGBOX
LPARAMETERS tcMessage,tcTitle,tnButtons,tcIcon
LOCAL lnButton
IF TYPE('tcIcon') = 'L'
	tcIcon = 'EXCLAIM'
ENDIF
lnButton = 0
DO FORM GKPMsgBox WITH tcMessage,tcTitle,tnButtons,tcIcon TO lnButton
RETURN lnButton
ENDFUNC