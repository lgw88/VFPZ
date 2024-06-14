FUNCTION GKPGetMACAddress
LOCAL llpGUID,lrGUID
lpGUID = REPLICATE(CHR(0), 16)
lrGUID = REPLICATE(CHR(0), 80)
IF "5." $ OS() && 2000/XP
	IF apiUuidCreateSequential(@lpGUID) = 0 .AND. apiStringFromGUID2(lpGUID, @lrGUID, 40) # 0
		lcMacAddress = SUBSTR(STRCONV(LEFT(lrGUID,76),6),26,12)
	ELSE
		lcMacAddress = ""
	ENDIF
ELSE
	IF apiCoCreateGuid(@lpGUID) = 0 .AND. apiStringFromGUID2(lpGUID, @lrGUID, 40) # 0
		lcMacAddress = SUBSTR(STRCONV(LEFT(lrGUID, 76), 6), 26, 12)
	ELSE
		lcMacAddress = ""
	ENDIF
ENDIF
RETURN lcMacAddress
ENDFUNC