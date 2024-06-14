************************************************************************************************
* Written by:  Gregory A. Green
*              980 Windmill Parkway
*              Evans, GA  30809
*              (706) 651-1640
*
* Copyright ©2004 Gregory A. Green
*
* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*
************************************************************************************************
* Function to get the scroll bar width
*
FUNCTION GKLGetScrollBarWidth
LOCAL lnColWidth, lnScrollWidth
#DEFINE SM_CXHSCROLL 21   && Return width of the horizontal scrollbar in pixels
#DEFINE SM_CXVSCROLL  2   && Return width of the vertical scrollbar in pixels
RETURN apiGetSystemMetrics(SM_CXVSCROLL) + 3
ENDFUNC