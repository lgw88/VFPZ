*-************************************************************************************************
*-* Copyright ©2010 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-************************************************************************************************
*-*
*-*  Routine for displaying a message with a timeout
*-*
FUNCTION DisplayMsg
LPARAMETERS tcMessage
DO FORM GKLDisplayMsg WITH 2.5, tcMessage
=INKEY(0.001, 'H')
ENDFUNC