************************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*
************************************************************************************************
* Function to get the scroll bar width
*
FUNCTION GKKGetScrollBarWidth
LOCAL lnColWidth, lnScrollWidth
#DEFINE SM_CXHSCROLL 21   && Return width of the horizontal scrollbar in pixels
#DEFINE SM_CXVSCROLL  2   && Return width of the vertical scrollbar in pixels
RETURN apiGetSystemMetrics(SM_CXVSCROLL) + 3
ENDFUNC