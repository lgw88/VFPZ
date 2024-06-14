*-************************************************************************************************
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-************************************************************************************************
*-*
*-*  Routine for displaying a message with a timeout
*-*
FUNCTION GKCDisplayMsg
LPARAMETERS tcMessage
DO FORM GKCDisplayMsg WITH 1.5,tcMessage
=INKEY(0.001,'H')
ENDFUNC