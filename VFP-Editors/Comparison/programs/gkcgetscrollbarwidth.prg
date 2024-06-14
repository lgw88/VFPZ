**
FUNCTION GKCGetScrollBarWidth
LOCAL lnColWidth, lnScrollWidth
#DEFINE SM_CXHSCROLL 21   && Return width of the horizontal scrollbar in pixels
#DEFINE SM_CXVSCROLL  2   && Return width of the vertical scrollbar in pixels
RETURN apiGetSystemMetrics(SM_CXVSCROLL) + 3
ENDFUNC