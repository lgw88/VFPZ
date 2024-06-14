************************************************************************************************
* Written by:  Gregory A. Green
************************************************************************************************
*
*  Routine for displaying a user information dialog box
*
FUNCTION GKKWMSGBOX
LPARAMETERS pcMessage,pcTitle,pnButtons,pcIcon
LOCAL lnButton
IF TYPE('pcIcon') = 'L'
	pcIcon = 'EXCLAIM'
ENDIF
lnButton = 0
DO FORM GKKMsgBox WITH pcMessage,pcTitle,pnButtons,pcIcon TO lnButton
RETURN lnButton
ENDFUNC