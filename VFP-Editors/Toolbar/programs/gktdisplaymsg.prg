*-************************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2010 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-************************************************************************************************
*-*
*-*  Routine for displaying a message with a timeout
*-*
FUNCTION GKTDisplayMsg
LPARAMETERS tcMessage
DO FORM GKTDisplayMsg WITH 1.5,tcMessage
=INKEY(0.001,'H')
ENDFUNC