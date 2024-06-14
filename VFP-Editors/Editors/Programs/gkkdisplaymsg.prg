*-************************************************************************************************
*-* Copyright ©2015 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-************************************************************************************************
*-*
*-*  Routine for displaying a message with a timeout
*-*
FUNCTION GKKDisplayMsg
LPARAMETERS tcMessage
DO FORM GKKDisplayMsg WITH 1.5, tcMessage
INKEY(0.001, 'H')
ENDFUNC