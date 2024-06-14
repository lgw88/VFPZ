*=======================================================
* Returns a readable string version of a Fox system 
* timestamp, using current date settings
*=======================================================
FUNCTION GKKGetFoxTimeStamp
LPARAMETER tiStamp 
LOCAL lnYearoffset,lcYear,lcMonth,lcDay,lcHour,lcMinute,lcSecond
IF EMPTY(tiStamp) OR TYPE("tiStamp") # "N"  
   RETURN ""
ENDIF
lnYearoffset = BITRSHIFT(tiStamp,25)
lcYear   = STR(1980 + lnYearoffset)
lcMonth  = STR(BITRSHIFT(tiStamp,21) % 2^4)
lcDay    = STR(BITRSHIFT(tiStamp,16) % 2^5)
lcHour   = STR(BITRSHIFT(tiStamp,11) % 2^5)
lcMinute = STR(BITRSHIFT(tiStamp,5) % 2^6)
lcSecond = STR(BITLSHIFT(tiStamp%2^5,1))
RETURN TTOC({^&lcYear./&lcMonth./&lcDay. &lcHour.:&lcMinute.:&lcSecond.})	
ENDFUNC