#IFNDEF GKCDEFINES
#INCLUDE gkcdefines.h
#ENDIF

*-* GKCDeclareAPI

FUNCTION ctlGetOsVersion()
	RETURN VAL(OS(3)) * 1000000 + VAL(OS(4)) * 10000 + VAL(OS(8)) * 100 + VAL(OS(9))
ENDFUNC

*-***********************************************************************************************
*-*	Custom function for SUBSTR based on Win32 pointers (single version)
*-*
FUNCTION apiSUBSTR
	LPARAMETERS tcString, tnBeg, tnLen
	LOCAL lnAddr, lcSubStr
	DO CASE
		CASE VARTYPE(tcString) != "C" .OR. LEN(tcString) = 0
			WAIT WINDOW "apiSUBSTR: Invalid parameters" NOWAIT
			RETURN ""

		CASE PCOUNT() = 2 .AND. VARTYPE(tnBeg) = "N"
			tnLen = LEN(tcString) - tnBeg

		CASE PCOUNT() = 3 .AND. VARTYPE(tnBeg) = "N" .AND. VARTYPE(tnLen) = "N"
			DO CASE
				CASE LEN(tcString) = tnBeg
					tnLen = 1
				CASE LEN(tcString) < tnBeg + tnLen
					tnLen = LEN(tcString) - tnBeg
				CASE LEN(tcString) < tnBeg
					WAIT WINDOW "apiSUBSTR: Invalid parameters (tnBeg is outside of string)" NOWAIT
					RETURN ""
			ENDCASE

		OTHERWISE
			WAIT WINDOW "apiSUBSTR: Invalid parameters" NOWAIT
			RETURN ""
	ENDCASE
*	lnAddr = apiGlobalAlloc(0, LEN(tcString))
	lnAddr = apiHeapAlloc(apiGetProcessHeap(), 0, LEN(tcString))
	SYS(2600, lnAddr, LEN(tcString), tcString)
	lcSubStr = SYS(2600, lnAddr + tnBeg - 1, tnLen)
	apiHeapFree(apiGetProcessHeap(), 0, lnAddr)
*	apiGlobalFree(lnAddr)
	RETURN lcSubStr
ENDFUNC


*-***********************************************************************************************
*-*	Custom function for SUBSTR based on Win32 pointers (multi-call)
*-*
FUNCTION apiSUBSTR_ALLOC
	LPARAMETERS tcString
	LOCAL loException, loString
	IF VARTYPE(tcString) != "C" .OR. LEN(tcString) = 0
		WAIT WINDOW "apiSUBSTR: Invalid parameters" NOWAIT
		RETURN .NULL.
	ENDIF
	TRY
		loString = CREATEOBJECT("Empty")
		ADDPROPERTY(loString, "SizeOf", LEN(tcString))
		ADDPROPERTY(loString, "Handle", apiHeapAlloc(apiGetProcessHeap(), 0, LEN(tcString)))
*		ADDPROPERTY(loString, "Handle", apiGlobalAlloc(0, LEN(tcString)))
		SYS(2600, loString.Handle, LEN(tcString), tcString)

	CATCH TO loException
		loString = .NULL.
		WAIT WINDOW loException.Message NOWAIT
	ENDTRY
	RETURN loString
ENDFUNC


FUNCTION apiSUBSTR_FREE
	LPARAMETERS toString
	LOCAL lcName
	IF VARTYPE(toString) != "O"
		RETURN False
	ENDIF
	apiHeapFree(apiGetProcessHeap(), 0, toString.Handle)
*	apiGlobalFree(toString.Handle)
	toString.Handle = 0
	toString.SizeOf = 0
	RETURN True
ENDFUNC


FUNCTION apiSUBSTR_GET
	LPARAMETERS toString, tnBeg, tnLen
	DO CASE
		CASE VARTYPE(toString) != "O" .OR. !PEMSTATUS(toString,"Handle",5) .OR. toString.Handle = 0
			WAIT WINDOW "apiSUBSTR: Memory not initialized" NOWAIT
			RETURN ""
			
		CASE VARTYPE(toString) != "O" .OR. !PEMSTATUS(toString,"SizeOf",5) .OR. toString.SizeOf = 0
			WAIT WINDOW "apiSUBSTR: Invalid parameters" NOWAIT
			RETURN ""

		CASE PCOUNT() = 2 .AND. VARTYPE(tnBeg) = "N"
			tnLen = toString.SizeOf - tnBeg

		CASE PCOUNT() = 3 .AND. VARTYPE(tnBeg) = "N" .AND. VARTYPE(tnLen) = "N"
			DO CASE
				CASE toString.SizeOf = tnBeg
					tnLen = 1
				CASE toString.SizeOf < tnBeg + tnLen
					tnLen = toString.SizeOf - tnBeg
				CASE toString.SizeOf < tnBeg
					WAIT WINDOW "apiSUBSTR: Invalid parameters (tnBeg is outside of string)" NOWAIT
					RETURN ""
			ENDCASE

		OTHERWISE
			WAIT WINDOW "apiSUBSTR: Invalid parameters" NOWAIT
			RETURN ""
	ENDCASE
	RETURN SYS(2600, toString.Handle + tnBeg - 1, tnLen)
ENDFUNC

*-***********************************************************************************************
*-*	Win32 Functions for rAPIdStructure class
*-*
FUNCTION apiReadMem
	LPARAMETERS outBuffer, inBuffer, Bytes2Copy
	DECLARE INTEGER RtlMoveMemory IN WIN32API AS apiReadMem STRING @outBuffer, INTEGER inBuffer, INTEGER Bytes2Copy
	RETURN apiReadMem(@outBuffer, inBuffer, Bytes2Copy)
ENDFUNC


FUNCTION apiGlobalFree
	LPARAMETERS nHMem
	DECLARE INTEGER GlobalFree IN WIN32API AS apiGlobalFree INTEGER nHMem
	RETURN apiGlobalFree(nHMem)
ENDFUNC


FUNCTION apiGlobalAlloc
	LPARAMETERS nFlags, nBytes
	DECLARE INTEGER GlobalAlloc IN WIN32API AS apiGlobalAlloc INTEGER nFlags, INTEGER nBytes
	RETURN apiGlobalAlloc(nFlags, nBytes)
ENDFUNC


FUNCTION apiWriteMem
	LPARAMETERS outBuffer, inBuffer, Bytes2Write
	DECLARE RtlMoveMemory IN kernel32 AS apiWriteMem INTEGER outBuffer, STRING inBuffer, INTEGER Bytes2Write
	RETURN apiWriteMem(outBuffer, inBuffer, Bytes2Write)
ENDFUNC


FUNCTION apiGlobalSize
	LPARAMETERS nHMem
	DECLARE INTEGER GlobalSize IN WIN32API AS apiGlobalSize INTEGER nHMem
	RETURN apiGlobalSize(nHMem)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 MCI Sound Functions
*-*
FUNCTION apiMciSendString
	LPARAMETERS cMCIString, cRetString, nRetLength, hInstance
	DECLARE INTEGER mciSendString IN WinMM.DLL AS apimciSendString STRING cMCIString, STRING @cRetString, INTEGER nRetLength, INTEGER hInstance
	RETURN apimciSendString(cMCIString, @cRetString, nRetLength, hInstance)
ENDFUNC


FUNCTION apiMciGetErrorString
	LPARAMETERS nErrorno, cBuffer, nBufSize
	DECLARE INTEGER mciGetErrorString IN WINMM.DLL AS apiMciGetErrorString INTEGER nErrorno, STRING @cBuffer, INTEGER nBufSize
	RETURN apiMciGetErrorString(nErrorno, @cBuffer, nBufSize)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 File Functions
*-*
FUNCTION apiSetFileAttributes
	LPARAMETERS tcFileName, tnFileAttributes
	DECLARE LONG SetFileAttributes IN WIN32API AS apiSetFileAttributes STRING tcFileName, LONG tnFileAttributes
	RETURN apiSetFileAttributes(tcFileName, tnFileAttributes)
ENDFUNC


FUNCTION apiGetFileAttributes
	LPARAMETERS tcFileName
	DECLARE LONG GetFileAttributes IN WIN32API AS apiGetFileAttributes STRING tcFileName
	RETURN apiGetFileAttributes(tcFileName)
ENDFUNC


FUNCTION apiLockFile
	LPARAMETERS thFile, tdwFileOffsetLow, tdwFileOffsetHigh, tnNumberOfBytesToLockLow, tnNumberOfBytesToLockHigh
	DECLARE INTEGER LockFile IN kernel32 AS apiLockFile INTEGER hFile, INTEGER dwFileOffsetLow, INTEGER dwFileOffsetHigh, INTEGER nNumberOfBytesToLockLow, INTEGER nNumberOfBytesToLockHigh
	RETURN apiLockFile(thFile, tdwFileOffsetLow, tdwFileOffsetHigh, tnNumberOfBytesToLockLow, tnNumberOfBytesToLockHigh)
ENDFUNC


FUNCTION apiUnlockFile
	LPARAMETERS thFile, tdwFileOffsetLow, tdwFileOffsetHigh, tnNumberOfBytesToUnlockLow, tnNumberOfBytesToUnlockHigh
	DECLARE INTEGER UnlockFile IN kernel32 AS apiUnlockFile INTEGER hFile, INTEGER dwFileOffsetLow, INTEGER dwFileOffsetHigh, INTEGER nNumberOfBytesToUnlockLow, INTEGER nNumberOfBytesToUnlockHigh
	RETURN apiUnlockFile(thFile, tdwFileOffsetLow, tdwFileOffsetHigh, tnNumberOfBytesToUnlockLow, tnNumberOfBytesToUnlockHigh)
ENDFUNC


FUNCTION apiOpenFile
	LPARAMETERS tlpFileName, tlpReOpenBuff, twStyle
	DECLARE INTEGER OpenFile IN kernel32 AS apiOpenFile STRING lpFileName, STRING @lpReOpenBuff, INTEGER wStyle
	RETURN apiOpenFile(tlpFileName, @tlpReOpenBuff, twStyle)
ENDFUNC


FUNCTION apiCloseFile
	LPARAMETERS thObject
	DECLARE INTEGER CloseHandle IN kernel32 AS apiCloseFile INTEGER hObject
	RETURN apiCloseFile(thObject)
ENDFUNC


FUNCTION apiCopyFile
	LPARAMETERS tcSourceFileName, tcDestFileName, tlFailIfExists
	DECLARE Long CopyFile IN Win32API AS apiCopyFile String tcSourceFileName, String tcDestFileName, Long bFailIfExists
	RETURN apiCopyFile(tcSourceFileName, tcDestFileName, tlFailIfExists)
ENDFUNC


FUNCTION apiMoveFile
	LPARAMETERS tcSourceFileName, tcDestFileName
	DECLARE Long MoveFile IN Win32API AS apiMoveFile String SourceFileName, String DestFileName
	RETURN apiMoveFile(tcSourceFileName, tcDestFileName)
ENDFUNC


FUNCTION apiOpenFile
	LPARAMETERS lpFileName, O_lpReOpenBuff, uStyle
	DECLARE LONG OpenFile IN Kernel32 AS apiOpenFile STRING lpFileName, STRING @O_lpReOpenBuff, LONG uStyle
	RETURN apiOpenFile(lpFileName, @O_lpReOpenBuff, uStyle)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Printer Functions
*-*
FUNCTION apiDocumentProperties
	LPARAMETERS lhWnd, lhPrinter, pcPrinterName, lcDevModeOutput, lcDevModeInput, lnMode
	DECLARE INTEGER DocumentProperties IN winspool.drv AS apiDocumentProperties INTEGER lhWnd, INTEGER lhPrinter, STRING pcPrinterName, STRING @lcDevModeOutput, STRING @lcDevModeInput, INTEGER lnMode
	RETURN apiDocumentProperties(lhWnd, lhPrinter, pcPrinterName, @lcDevModeOutput, @lcDevModeInput, lnMode)
ENDFUNC

 
FUNCTION apiDeviceCapabilities
	LPARAMETERS pDevice, pPort, fwCapability, pOutput, pDevMode
	DECLARE Long DeviceCapabilities IN winspool.drv AS apiDeviceCapabilities String pDevice, String pPort, Long fwCapability, String @pOutput, Long pDevMode
	RETURN apiDeviceCapabilities(pDevice, pPort, fwCapability, @pOutput, pDevMode)
ENDFUNC


FUNCTION apiEnumForms
	LPARAMETERS thPrinter, tnLevel, tnForm, tnBuf, tnNeeded, tnReturned
	DECLARE Long EnumForms IN winspool.drv AS apiEnumForms Long hPrinter, Long Level, Long pForm, Long cbBuf, Long @pcbNeeded, Long @ pcReturned
	RETURN apiEnumForms(thPrinter, tnLevel, tnForm, tnBuf, @tnNeeded, @tnReturned)
ENDFUNC
 

FUNCTION apiClosePrinter
	LPARAMETERS lhPrinter
	DECLARE INTEGER ClosePrinter IN winspool.drv AS apiClosePrinter INTEGER lhPrinter
	RETURN apiClosePrinter(lhPrinter)
ENDFUNC


FUNCTION apiOpenPrinter
	LPARAMETERS pcPrinterName, lhPrinter, lnDefault
	DECLARE INTEGER OpenPrinter IN winspool.drv AS apiOpenPrinter STRING pcPrinterName, INTEGER @lhPrinter, INTEGER lnDefault
	RETURN apiOpenPrinter(pcPrinterName, @lhPrinter,lnDefault)
ENDFUNC


FUNCTION apiAddForm
	LPARAMETERS thPrinter, tnLevel, tcForm
	DECLARE Long AddForm IN winspool.drv AS apiAddForm Long hPrinter, Long Level, String @pForm
	RETURN apiAddForm(thPrinter, tnLevel, tcForm)
ENDFUNC

 
FUNCTION apiDeleteForm
	LPARAMETERS thPrinter, tcForm
	DECLARE Long DeleteForm IN winspool.drv AS apiDeleteForm Long hPrinter, String  pFormName 
	RETURN apiDeleteForm(thPrinter, tcForm)
ENDFUNC


FUNCTION apiStartDoc
	LPARAMETERS hdc, lpdi
	DECLARE INTEGER StartDoc IN Win32API AS apiStartDoc INTEGER hdc, STRING lpdi
	RETURN apiStartDoc(hdc, lpdi)
ENDFUNC


FUNCTION apiEndDoc
	LPARAMETERS hdc
	DECLARE INTEGER EndDoc IN Win32API AS apiEndDoc INTEGER hdc
	RETURN apiEndDoc(hdc)
ENDFUNC


FUNCTION apiEndPage
	LPARAMETERS hdc
	DECLARE INTEGER EndPage IN Win32API AS apiEndPage INTEGER hdc
	RETURN apiEndPage(hdc)
ENDFUNC


FUNCTION apiStartPage
	LPARAMETERS hdc
	DECLARE INTEGER StartPage IN Win32API AS apiStartPage INTEGER hdc
	RETURN apiStartPage(hdc)
ENDFUNC


FUNCTION apiAbortDoc
	LPARAMETERS hdc
	DECLARE INTEGER AbortDoc IN Win32API AS apiAbortDoc INTEGER hdc
	RETURN apiAbortDoc(hdc)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Network Functions
*-*
FUNCTION apiCoCreateGuid
	LPARAMETERS tpGUID
	DECLARE INTEGER CoCreateGuid IN 'OLE32.dll' AS apiCoCreateGuid STRING @tpGUID
	RETURN apiCoCreateGuid(@tpGUID)
ENDFUNC


FUNCTION apiStringFromGUID2
	LPARAMETERS trGUID, tpsz, tchMax
	DECLARE INTEGER StringFromGUID2 IN 'OLE32.dll' AS apiStringFromGUID2 STRING trGUID, STRING @tpsz, INTEGER tchMax
	RETURN apiStringFromGUID2(trGUID, @tpsz, tchMax)
ENDFUNC

	
FUNCTION apiUuidCreateSequential
	LPARAMETERS tUuid
	DECLARE INTEGER UuidCreateSequential IN 'RPCRT4.dll' AS apiUuidCreateSequential STRING @tUuid
	RETURN apiUuidCreateSequential(@tUuid)
ENDFUNC


FUNCTION apiUuidFromString
	LPARAMETERS tsStringUuid, tsGuid
	DECLARE LONG UuidFromString IN rpcrt4.DLL AS apiUuidFromString STRING tsStringUuid, STRING @tsUuid
	RETURN apiUuidFromString(tsStringUuid, @tsGuid)
ENDFUNC

*-***********************************************************************************************
*-*	GDI+ Startup Functions
*-*
FUNCTION apiGdiplusStartup
	LPARAMETERS tnToken, pcInput, tnOutput
	DECLARE LONG GdiplusStartup IN GDIPLUS.DLL AS apiGdiplusStartup LONG @nToken, STRING @cInput, LONG @nOutput
	RETURN apiGdiplusStartup(@tnToken, @pcInput, @tnOutput)
ENDFUNC


FUNCTION apiGdiplusShutdown
	LPARAMETERS tnToken
	DECLARE LONG GdiplusShutdown IN GDIPLUS.DLL AS apiGdiplusShutdown LONG nToken
	RETURN apiGdiplusShutdown(tnToken)
ENDFUNC


*-***********************************************************************************************
*-*	Graphics Functions
*-*
FUNCTION apiGdipGetImageGraphicsContext
	LPARAMETERS tnImage, tnGraphics
	DECLARE INTEGER GdipGetImageGraphicsContext IN GDIPLUS.DLL AS apiGdipGetImageGraphicsContext INTEGER nImage, INTEGER @ nGraphics
	RETURN apiGdipGetImageGraphicsContext(tnImage, @tnGraphics)
ENDFUNC


FUNCTION apiGdipCreateFromHDC
	LPARAMETERS hDC, tnGraphics
	DECLARE LONG GdipCreateFromHDC in GdiPlus.DLL AS apiGdipCreateFromHDC Long hDC, Long @tnGraphics
	RETURN apiGdipCreateFromHDC(hDC, @tnGraphics)
ENDFUNC


FUNCTION apiGdipDeleteGraphics
	LPARAMETERS tnImage
	DECLARE INTEGER GdipDeleteGraphics IN GDIPLUS.DLL AS apiGdipDeleteGraphics INTEGER nImage
	RETURN apiGdipDeleteGraphics(tnImage)
ENDFUNC


FUNCTION apiGdipSetTextRenderingHint
	LPARAMETERS tnGraphics, tnTextRenderingHint
	DECLARE INTEGER GdipSetTextRenderingHint IN GDIPLUS.DLL AS apiGdipSetTextRenderingHint INTEGER nGraphics, INTEGER nTextRenderingHint
	RETURN apiGdipSetTextRenderingHint(tnGraphics, tnTextRenderingHint)
ENDFUNC


FUNCTION apiGdipMeasureString
	LPARAMETERS tnGraphics, pcUnicode, tnLength, tnFont, pcLayoutRect, tnStringFormat, pcRectOut, tnChars, tnLines
	DECLARE INTEGER GdipMeasureString IN GDIPLUS.DLL AS apiGdipMeasureString INTEGER nGraphics, STRING cUnicode, INTEGER nLength ,;
		INTEGER nFont, STRING cLayoutRect, INTEGER nStringFormat, STRING @cRectOut, INTEGER @nChars, INTEGER @nLines
	RETURN apiGdipMeasureString(tnGraphics, pcUnicode, tnLength, tnFont, pcLayoutRect, tnStringFormat, @pcRectOut, @tnChars, @tnLines)
ENDFUNC


FUNCTION apiGdipDrawString
	LPARAMETERS tnGraphics, tcWidechar, tnLength, tnFnt, tcRectF, tnStringFormat, tnBrush
	DECLARE INTEGER GdipDrawString IN GDIPLUS.DLL AS apiGdipDrawString INTEGER nGraphics, STRING cWidechar, INTEGER nLength, INTEGER nFnt, STRING @cRectF, INTEGER nStringFormat, INTEGER nBrush
	RETURN apiGdipDrawString(tnGraphics, tcWidechar, tnLength, tnFnt, @tcRectF, tnStringFormat, tnBrush)
ENDFUNC


FUNCTION apiGdipDrawImageRectRect
	LPARAMETERS tnGraphics, tnImage, tnDstX, tnDstY, tnDstWidth, tnDstHeight, tnSrcX, tnSrcY, tnSrcWidth, tnSrcHeight, tnSrcUnit, tnImageAttributes, tnCallback, tnCallbackData
	DECLARE INTEGER GdipDrawImageRectRect IN GDIPLUS.DLL AS apiGdipDrawImageRectRect INTEGER nGraphics, INTEGER nImage, SINGLE nDstX, SINGLE nDstY, SINGLE nDstWidth, SINGLE nDstHeight, ;
		SINGLE nSrcX, SINGLE nSrcY, SINGLE nSrcWidth, SINGLE nSrcHeight, INTEGER nSrcUnit, INTEGER nImageAttributes, INTEGER nCallback, INTEGER nCallbackData
	RETURN apiGdipDrawImageRectRect(tnGraphics, tnImage, tnDstX, tnDstY, tnDstWidth, tnDstHeight, tnSrcX, tnSrcY, tnSrcWidth, tnSrcHeight, tnSrcUnit, tnImageAttributes, tnCallback, tnCallbackData)
ENDFUNC


FUNCTION apiGdipDrawImage
	LPARAMETERS tnGraphics, tnImage, tnX, tnY
	DECLARE INTEGER GdipDrawImage IN GDIPLUS.DLL AS apiGdipDrawImage INTEGER nGraphics, INTEGER nImage, SINGLE nX, SINGLE nY
	RETURN apiGdipDrawImage(tnGraphics, tnImage, tnX, tnY)
ENDFUNC


FUNCTION apiGdipFillRectangle
	LPARAMETERS tnGraphics, tnBrush, tnX, tnY, tnWidth, tnHeight
	DECLARE INTEGER GdipFillRectangle IN GDIPLUS.DLL AS apiGdipFillRectangle INTEGER nGraphics, INTEGER nBrush, SINGLE nX, SINGLE nY, SINGLE nWidth, SINGLE nHeight
	RETURN apiGdipFillRectangle(tnGraphics, tnBrush, tnX, tnY, tnWidth, tnHeight)
ENDFUNC


FUNCTION apiGdipDrawImageRect
	LPARAMETERS tnGraphics, tnImage, tnX, tnY, tnImgWidth, tnImgHeight
	DECLARE INTEGER GdipDrawImageRect IN GDIPLUS.DLL AS apiGdipDrawImageRect INTEGER nGraphics, INTEGER nImage, SINGLE nX, SINGLE nY, SINGLE nImgWidth, SINGLE nImgHeight
	RETURN apiGdipDrawImageRect(tnGraphics, tnImage, tnX, tnY, tnImgWidth, tnImgHeight)
ENDFUNC

	

*-***********************************************************************************************
*-*	Image Functions
*-*
FUNCTION apiGdipCreateBitmapFromScan0
	LPARAMETERS tnWidth, tnHeight, tnStride, tnPixelFormat, tnScan0, tnImage
	DECLARE INTEGER GdipCreateBitmapFromScan0 IN GDIPLUS.DLL AS apiGdipCreateBitmapFromScan0 INTEGER nWidth, INTEGER nHeight, INTEGER nStride, INTEGER nPixelFormat, INTEGER nScan0, INTEGER @ nImage
	RETURN apiGdipCreateBitmapFromScan0(tnWidth, tnHeight, tnStride, tnPixelFormat, tnScan0, @tnImage)
ENDFUNC


FUNCTION apiGdipDrawImageRectI
	LPARAMETERS pGraphics, pImage, nX, nY, nWidth, nHeight
	Declare Long GdipDrawImageRectI in GdiPlus.dll AS apiGdipDrawImageRectI Long pGraphics, Long pImage, Integer nX, Integer nY, Integer nWidth, Integer nHeight
	RETURN apiGdipDrawImageRectI(pGraphics, pImage, nX, nY, nWidth, nHeight)
ENDFUNC


FUNCTION apiGdipDrawImageI
	LPARAMETERS pGraphics, pImage, nX, nY
	Declare Long GdipDrawImageI in GdiPlus.DLL AS apiGdipDrawImageI Long pGraphics, Long pImage, Integer nX, Integer nY
	RETURN apiGdipDrawImageI(pGraphics, pImage, nX, nY)
ENDFUNC


FUNCTION apiGdipLoadImageFromFile
	LPARAMETERS pcFilename, tnImage
	DECLARE INTEGER GdipLoadImageFromFile IN GDIPLUS.DLL AS apiGdipLoadImageFromFile STRING cFilename, INTEGER @ nImage
	RETURN apiGdipLoadImageFromFile(pcFilename, @tnImage)
ENDFUNC


FUNCTION apiGdipSaveImageToFile
	LPARAMETERS tnImage, pcFileName, pcClsIdEncoder, tnEncoderParams
	DECLARE LONG GdipSaveImageToFile IN GDIPLUS.DLL AS apiGdipSaveImageToFile LONG nImage, STRING cFileName, STRING cClsIdEncoder, LONG nEncoderParams
	RETURN apiGdipSaveImageToFile(tnImage, pcFileName, pcClsIdEncoder, tnEncoderParams)
ENDFUNC


FUNCTION apiGdipDisposeImage
	LPARAMETERS tnImage
	DECLARE INTEGER GdipDisposeImage IN GDIPLUS.DLL AS apiGdipDisposeImage INTEGER nImage
	RETURN apiGdipDisposeImage(tnImage)
ENDFUNC


FUNCTION apiGdipBitmapGetPixel
	LPARAMETERS tnBitmap, tnX, tnY, tnArgB
	DECLARE INTEGER GdipBitmapGetPixel IN GDIPLUS.DLL AS apiGdipBitmapGetPixel INTEGER nBitmap, INTEGER nX, INTEGER nY, INTEGER @ nArgB
	RETURN apiGdipBitmapGetPixel(tnBitmap, tnX, tnY, @tnArgB)
ENDFUNC


FUNCTION apiGdipGetImageWidth
	LPARAMETERS tnImage, tnWidth
	DECLARE INTEGER GdipGetImageWidth IN GDIPLUS.DLL AS apiGdipGetImageWidth INTEGER nImage, INTEGER @ nWidth
	RETURN apiGdipGetImageWidth(tnImage, @tnWidth)
ENDFUNC


FUNCTION apiGdipGetImageHeight
	LPARAMETERS tnImage, tnHeight
	DECLARE INTEGER GdipGetImageHeight IN GDIPLUS.DLL AS apiGdipGetImageHeight INTEGER nImage, INTEGER @ nHeight
	RETURN apiGdipGetImageHeight(tnImage, @tnHeight)
ENDFUNC


FUNCTION apiGdipCreateHBITMAPFromBitmap
	LPARAMETERS tnImage, tnHeight, nARGB
	Declare Long GdipCreateHBITMAPFromBitmap in GdiPlus.dll AS apiGdipCreateHBITMAPFromBitmap Long pImage, Long @O_hBitmap, Long nARGB
	RETURN apiGdipCreateHBITMAPFromBitmap(tnImage, @tnHeight, nARGB)
ENDFUNC


FUNCTION apiGdipGetImagePixelFormat
	LPARAMETERS pImage, nPixelFormat
	Declare Long GdipGetImagePixelFormat in GdiPlus.dll AS apiGdipGetImagePixelFormat Long pImage, Long @nPixelFormat
	RETURN apiGdipGetImagePixelFormat(pImage, @nPixelFormat)
ENDFUNC


*-***********************************************************************************************
*-*	Image Attributes Functions
*-*
FUNCTION apiGdipCreateImageAttributes
	LPARAMETERS tnImageAttr
	DECLARE INTEGER GdipCreateImageAttributes IN GDIPLUS.DLL AS apiGdipCreateImageAttributes INTEGER @nImageAttr
	RETURN apiGdipCreateImageAttributes(@tnImageAttr)
ENDFUNC


FUNCTION apiGdipSetImageAttributesRemapTable
	LPARAMETERS tnImageAttr, tnColorAdjustType, tnEnableFlag, tnMapSize, pcColorMap
	DECLARE INTEGER GdipSetImageAttributesRemapTable IN GDIPLUS.DLL AS apiGdipSetImageAttributesRemapTable INTEGER nImageAttr, INTEGER nColorAdjustType, INTEGER nEnableFlag, INTEGER nMapSize, STRING cColorMap
	RETURN apiGdipSetImageAttributesRemapTable(tnImageAttr, tnColorAdjustType, tnEnableFlag, tnMapSize, pcColorMap)
ENDFUNC


FUNCTION apiGdipSetImageAttributesColorMatrix
	LPARAMETERS tnImageAttr, tnType, tnEnableFlag, pcColorMatrix, tnGrayMatrix, tnFlags
	DECLARE LONG GdipSetImageAttributesColorMatrix IN GDIPLUS.DLL AS apiGdipSetImageAttributesColorMatrix LONG nImageAttr, LONG nType, LONG nEnableFlag, STRING cColorMatrix, LONG nGrayMatrix, LONG nFlags
	RETURN apiGdipSetImageAttributesColorMatrix(tnImageAttr, tnType, tnEnableFlag, pcColorMatrix, tnGrayMatrix, tnFlags)
ENDFUNC


FUNCTION apiGdipDisposeImageAttributes
	LPARAMETERS tnImageAttr
	DECLARE INTEGER GdipDisposeImageAttributes IN GDIPLUS.DLL AS apiGdipDisposeImageAttributes INTEGER nImageAttr
	RETURN apiGdipDisposeImageAttributes(tnImageAttr)
ENDFUNC



*-***********************************************************************************************
*-*	GDI String Format Functions
*-*
FUNCTION apiGdipCreateStringFormat
	LPARAMETERS tnFormatAttributes, tnLanguage, tnFmt
	DECLARE INTEGER GdipCreateStringFormat IN GDIPLUS.DLL AS apiGdipCreateStringFormat INTEGER nFormatAttributes, INTEGER nLanguage, INTEGER @nFmt
	RETURN apiGdipCreateStringFormat(tnFormatAttributes, tnLanguage, @tnFmt)
ENDFUNC


FUNCTION apiGdipDeleteStringFormat
	LPARAMETERS tnStringFormat
	DECLARE INTEGER GdipDeleteStringFormat IN GDIPLUS.DLL AS apiGdipDeleteStringFormat INTEGER nStringFormat
	RETURN apiGdipDeleteStringFormat(tnStringFormat)
ENDFUNC


FUNCTION apiGdipSetStringFormatHotkeyPrefix
	LPARAMETERS tnGraphics, tnHotkeyPrefix
	DECLARE INTEGER GdipSetStringFormatHotkeyPrefix IN GDIPLUS.DLL AS apiGdipSetStringFormatHotkeyPrefix INTEGER nGraphics, INTEGER nHotkeyPrefix
	RETURN apiGdipSetStringFormatHotkeyPrefix(tnGraphics, tnHotkeyPrefix)
ENDFUNC


FUNCTION apiGdipStringFormatGetGenericTypographic
	LPARAMETERS tnHandle
	DECLARE INTEGER GdipStringFormatGetGenericTypographic IN GDIPLUS.DLL AS apiGdipStringFormatGetGenericTypographic INTEGER @nHandle
	RETURN apiGdipStringFormatGetGenericTypographic(@tnHandle)
ENDFUNC



*-***********************************************************************************************
*-*	GDI Fonts Functions
*-*
FUNCTION apiGdipCreateFont
	LPARAMETERS tnFontFamily, tnEmSize, tnFontStyle, tnUnit, tnFont
	DECLARE INTEGER GdipCreateFont IN GDIPLUS.DLL AS apiGdipCreateFont INTEGER nFontFamily, SINGLE nEmSize, INTEGER nFontStyle, INTEGER nUnit, INTEGER @nFont
	RETURN apiGdipCreateFont(tnFontFamily, tnEmSize, tnFontStyle, tnUnit, @tnFont)
ENDFUNC


FUNCTION apiGdipCreateFontFamilyFromName
	LPARAMETERS pcFamilyName, tnFontCollection, tnFontFamily
	DECLARE INTEGER GdipCreateFontFamilyFromName IN GDIPLUS.DLL AS apiGdipCreateFontFamilyFromName STRING cFamilyName, INTEGER nFontCollection, INTEGER @nFontFamily
	RETURN apiGdipCreateFontFamilyFromName(pcFamilyName, tnFontCollection, @tnFontFamily)
ENDFUNC


FUNCTION apiGdipDeleteFont
	LPARAMETERS tnFont
	DECLARE INTEGER GdipDeleteFont IN GDIPLUS.DLL AS apiGdipDeleteFont INTEGER nFont
	RETURN apiGdipDeleteFont(tnFont)
ENDFUNC


FUNCTION apiGdipDeleteFontFamily
	LPARAMETERS tnFontFamily
	DECLARE INTEGER GdipDeleteFontFamily IN GDIPLUS.DLL AS apiGdipDeleteFontFamily INTEGER nFontFamily
	RETURN apiGdipDeleteFontFamily(tnFontFamily)
ENDFUNC


*-***********************************************************************************************
*-*	GDI Brushes Functions
*-*
FUNCTION apiGdipCreateSolidFill
	LPARAMETERS tnColor, tnBrush
	DECLARE INTEGER GdipCreateSolidFill IN GDIPLUS.DLL AS apiGdipCreateSolidFill INTEGER nColor, INTEGER @nBrush
	RETURN apiGdipCreateSolidFill(tnColor, @tnBrush)
ENDFUNC


FUNCTION apiGdipCreateLineBrushI
	LPARAMETERS pcPoint1, pcPoint2, tnColor1, tnColor2, tnMode, tnWrapMode, tnLineGradient
	DECLARE LONG GdipCreateLineBrushI IN GDIPLUS.DLL AS apiGdipCreateLineBrushI STRING cPoint1, STRING cPoint2, LONG nColor1, LONG nColor2, LONG nMode, LONG nWrapMode, LONG @nLineGradient
	RETURN apiGdipCreateLineBrushI(pcPoint1, pcPoint2, tnColor1, tnColor2, tnMode, tnWrapMode, @tnLineGradient)
ENDFUNC


FUNCTION apiGdipCreateLineBrushFromRect
	LPARAMETERS tnRect, tnColor1, tnColor2, tnMode, tnWrapMd, tnLineGradient
	DECLARE LONG GdipCreateLineBrushFromRect IN GDIPLUS.DLL AS apiGdipCreateLineBrushFromRect STRING @nRect, LONG nColor1, LONG nColor2, LONG nMode, LONG nWrapMode, LONG @nLineGradient
	RETURN apiGdipCreateLineBrushFromRect(@tnRect, tnColor1, tnColor2, tnMode, tnWrapMd, @tnLineGradient)
ENDFUNC


FUNCTION apiGdipCreateLineBrushFromRectI
	LPARAMETERS tnRect, tnColor1, tnColor2, tnMode, tnWrapMode, tnLineGradient
	DECLARE LONG GdipCreateLineBrushFromRectI IN GDIPLUS.DLL AS apiGdipCreateLineBrushFromRectI STRING @nRect, LONG nColor1, LONG nColor2, LONG nMode, LONG nWrapMode, LONG @nLineGradient
	RETURN apiGdipCreateLineBrushFromRectI(@tnRect, tnColor1, tnColor2, tnMode, tnWrapMode, @tnLineGradient)
ENDFUNC


FUNCTION apiGdipSetLinePresetBlend
	LPARAMETERS tnBrush, tnBlend, pcPositions, tnCount
	DECLARE LONG GdipSetLinePresetBlend IN GDIPLUS.DLL AS apiGdipSetLinePresetBlend LONG nBrush, STRING nBlend, STRING cPositions, LONG nCount
	RETURN apiGdipSetLinePresetBlend(tnBrush, tnBlend, pcPositions, tnCount)
ENDFUNC


FUNCTION apiGdipDeleteBrush
	LPARAMETERS tnBrush
	DECLARE INTEGER GdipDeleteBrush IN GDIPLUS.DLL AS apiGdipDeleteBrush INTEGER nBrush
	RETURN apiGdipDeleteBrush(tnBrush)
ENDFUNC

  
FUNCTION apiGdipCreatePath
	LPARAMETERS tnBrushMode, tnPath
	DECLARE LONG GdipCreatePath IN GDIPLUS.DLL AS apiGdipCreatePath LONG nBrushMode, LONG @nPath
	RETURN apiGdipCreatePath(tnBrushMode, @tnPath)
ENDFUNC


FUNCTION apiGdipAddPathRectangle
	LPARAMETERS tnPath, tnX, tnY, tnWidth, tnHeight
	DECLARE LONG GdipAddPathRectangle IN GDIPLUS.DLL AS apiGdipAddPathRectangle LONG nPath, SINGLE nX, SINGLE nY, SINGLE nWidth, SINGLE nHeight 
	RETURN apiGdipAddPathRectangle(tnPath, tnX, tnY, tnWidth, tnHeight)
ENDFUNC


FUNCTION apiGdipCreatePathGradientFromPath
	LPARAMETERS tnPath, tnPolyGradient
	DECLARE LONG GdipCreatePathGradientFromPath IN GDIPLUS.DLL AS apiGdipCreatePathGradientFromPath LONG nPath, LONG @nPolyGradient
	RETURN apiGdipCreatePathGradientFromPath(tnPath, @tnPolyGradient)
ENDFUNC


FUNCTION apiGdipSetPathGradientCenterColor
	LPARAMETERS tnBrush, tnColors
	DECLARE LONG GdipSetPathGradientCenterColor IN GDIPLUS.DLL AS apiGdipSetPathGradientCenterColor LONG nBrush, LONG nColors
	RETURN apiGdipSetPathGradientCenterColor(tnBrush, tnColors)
ENDFUNC


FUNCTION apiGdipSetPathGradientSurroundColorsWithCount
	LPARAMETERS tnBrush, tnArgb, tnCount
	DECLARE LONG GdipSetPathGradientSurroundColorsWithCount IN GDIPLUS.DLL AS apiGdipSetPathGradientSurroundColorsWithCount LONG nBrush, LONG @nArgb, LONG @nCount
	RETURN apiGdipSetPathGradientSurroundColorsWithCount(tnBrush, @tnArgb, @tnCount)
ENDFUNC


FUNCTION apiGdipDeletePath
	LPARAMETERS tnPath
	DECLARE LONG GdipDeletePath IN GDIPLUS.DLL AS apiGdipDeletePath LONG nPath
	RETURN apiGdipDeletePath(tnPath)
ENDFUNC


*-***********************************************************************************************
*-*	OwnerDrawn Menu Functions
*-*
FUNCTION apiCreateMenu
	DECLARE LONG CreateMenu IN User32 AS apiCreateMenu
	RETURN apiCreateMenu()
ENDFUNC


FUNCTION apiDrawMenuBar
	LPARAMETERS thWndMenu
	DECLARE LONG DrawMenuBar IN User32 AS apiDrawMenuBar LONG hWndMenu
	RETURN apiDrawMenuBar(thWndMenu)
ENDFUNC


FUNCTION apiGetMenu
	LPARAMETERS thWndMenu
	DECLARE LONG GetMenu IN User32 AS apiGetMenu LONG hWndMenu
	RETURN apiGetMenu(thWndMenu)
ENDFUNC


FUNCTION apiGetSystemMenu
	LPARAMETERS thWndMain, tbRevert
	DECLARE LONG GetSystemMenu IN User32 AS apiGetSystemMenu LONG hWndMain, LONG bRevert
	RETURN apiGetSystemMenu(thWndMain, tbRevert)
ENDFUNC


FUNCTION apiSetMenu
	LPARAMETERS thWndMenu, thMenu
	DECLARE LONG SetMenu IN User32 AS apiSetMenu LONG hWndMenu, LONG hMenu
	RETURN apiSetMenu(thWndMenu, thMenu)
ENDFUNC


FUNCTION apiCreatePopupMenu
	DECLARE LONG CreatePopupMenu IN User32 AS apiCreatePopupMenu
	RETURN apiCreatePopupMenu()
ENDFUNC


FUNCTION apiIsMenu
	LPARAMETERS thMenu
	DECLARE LONG IsMenu IN User32 AS apiIsMenu LONG hMenu
	RETURN apiIsMenu(thMenu)
ENDFUNC


FUNCTION apiDestroyMenu
	LPARAMETERS thMenu
	DECLARE LONG DestroyMenu IN User32 AS apiDestroyMenu LONG hMenu
	RETURN apiDestroyMenu(thMenu)
ENDFUNC


FUNCTION apiAppendMenu
	LPARAMETERS thMenu, tuFlags, tuIDNewItem, tlpNewItem
	DECLARE LONG AppendMenu IN User32 AS apiAppendMenu LONG hMenu, LONG uFlags, LONG uIDNewItem, LONG lpNewItem
	RETURN apiAppendMenu(thMenu, tuFlags, tuIDNewItem, tlpNewItem)
ENDFUNC


FUNCTION apiModifyMenu
	LPARAMETERS thMenu, tnPosID, tnFlags, tnNewID, tlpNewID
	DECLARE SHORT ModifyMenu IN User32 AS apiModifyMenu LONG hMenu, LONG nPosID, LONG nFlags, LONG nNewID, STRING lpNewID
	RETURN apiModifyMenu(thMenu, tnPosID, tnFlags, tnNewID, tlpNewID)
ENDFUNC


FUNCTION apiEnableMenuItem
	LPARAMETERS thMenu, tnItemID, tnFlags
	DECLARE LONG EnableMenuItem IN User32 AS apiEnableMenuItem LONG hMenu, LONG nItemID, LONG nFlags
	RETURN apiEnableMenuItem(thMenu, tnItemID, tnFlags)
ENDFUNC


FUNCTION apiGetMenuInfo
	LPARAMETERS thMenu, tlpcMI
	DECLARE LONG GetMenuInfo IN User32 AS apiGetMenuInfo LONG hMenu, STRING @lpcMI
	RETURN apiGetMenuInfo(thMenu, @tlpcMI)
ENDFUNC


FUNCTION apiSetMenuInfo
	LPARAMETERS thMenu, tlpcMI
	DECLARE LONG SetMenuInfo IN User32 AS apiSetMenuInfo LONG hMenu, STRING @lpcMI
	RETURN apiSetMenuInfo(thMenu, @tlpcMI)
ENDFUNC


FUNCTION apiGetMenuBarInfo
	LPARAMETERS tnhWnd, tidObject, tidItem, tlpMBI
	DECLARE LONG GetMenuBarInfo IN User32 AS apiGetMenuBarInfo LONG nhWnd, LONG idObject, LONG idItem, STRING @lpMBI
	RETURN apiGetMenuBarInfo(tnhWnd, tidObject, tidItem, @tlpMBI)
ENDFUNC


FUNCTION apiGetMenuString
	LPARAMETERS thMenu, tuIDItem, tlpString, tnMaxCount, tuFlag
	DECLARE INTEGER GetMenuString IN User32 AS apiGetMenuString LONG hMenu, LONG uIDItem, STRING @lpString, INTEGER nMaxCount, LONG uFlag
	RETURN apiGetMenuString(thMenu, tuIDItem, @tlpString, tnMaxCount, tuFlag)
ENDFUNC


FUNCTION apiGetMenuItemRect
	LPARAMETERS thWndMenu, thMenu, tnItem, tlpItemRect
	DECLARE SHORT GetMenuItemRect IN User32 AS apiGetMenuItemRect LONG hWndMenu, LONG hMenu, LONG nItem, STRING @lpItemRect
	RETURN apiGetMenuItemRect(thWndMenu, thMenu, tnItem, @tlpItemRect)
ENDFUNC


FUNCTION apiGetMenuItemCount
	LPARAMETERS thMenu
	DECLARE INTEGER GetMenuItemCount IN User32 AS apiGetMenuItemCount LONG hMenu
	RETURN apiGetMenuItemCount(thMenu)
ENDFUNC


FUNCTION apiGetMenuItemID
	LPARAMETERS thMenu, tnPosID
	DECLARE LONG GetMenuItemID IN User32 AS apiGetMenuItemID LONG hMenu, LONG nPosID
	RETURN apiGetMenuItemID(thMenu, tnPosID)
ENDFUNC


FUNCTION apiGetMenuItemInfo
	LPARAMETERS thMenu, tuItem, tfByPosition, tlpMII
	DECLARE LONG GetMenuItemInfo IN User32 AS apiGetMenuItemInfo LONG hMenu, LONG uItem, LONG fByPosition, STRING @lpMII
	RETURN apiGetMenuItemInfo(thMenu, tuItem, tfByPosition, @tlpMII)
ENDFUNC


FUNCTION apiSetMenuItemInfo
	LPARAMETERS thMenu, tuItem, tfByPosition, tlpMII
	DECLARE SHORT SetMenuItemInfo IN User32 AS apiSetMenuItemInfo LONG hMenu, LONG uItem, LONG fByPosition, STRING lpMII
	RETURN apiSetMenuItemInfo(thMenu, tuItem, tfByPosition, tlpMII)
ENDFUNC


FUNCTION apiMenuItemFromPoint
	LPARAMETERS tnhWnd, thMenu, tnX, tnY
	DECLARE INTEGER MenuItemFromPoint IN User32 AS apiMenuItemFromPoint LONG nhWnd, LONG hMenu, LONG nX, LONG nY
	RETURN apiMenuItemFromPoint(tnhWnd, thMenu, tnX, tnY)
ENDFUNC


FUNCTION apiGetMenuPosFromID
	LPARAMETERS thMenu, tnID
	DECLARE LONG GetMenuPosFromID IN ShlwApi AS apiGetMenuPosFromID LONG hMenu, LONG nID
	RETURN apiGetMenuPosFromID(thMenu, tnID)
ENDFUNC


FUNCTION apiTrackPopupMenu
	LPARAMETERS thMenu, tuFlags, tnX, tnY, tnReserved, tnhWnd, tprcRect
	DECLARE LONG TrackPopupMenu IN User32 AS apiTrackPopupMenu LONG hMenu, LONG uFlags, INTEGER x, INTEGER y, INTEGER nReserved, LONG nhWnd, LONG prcRect
	RETURN apiTrackPopupMenu(thMenu, tuFlags, tnX, tnY, tnReserved, tnhWnd, tprcRect)
ENDFUNC


FUNCTION apiLoadImage
	LPARAMETERS thInst, tlpszName, tuType, tcxDesired, tcyDesired, tfuLoad
	DECLARE LONG LoadImage IN User32 AS apiLoadImage LONG hInst, STRING lpszName, LONG uType, INTEGER cxDesired, INTEGER cyDesired, LONG fuLoad
	RETURN apiLoadImage(thInst, tlpszName, tuType, tcxDesired, tcyDesired, tfuLoad)
ENDFUNC


FUNCTION apiGetCursorPos
	LPARAMETERS tlpPoint
	DECLARE LONG GetCursorPos IN User32 AS apiGetCursorPos STRING @lpPoint
	RETURN apiGetCursorPos(tlpPoint)
ENDFUNC


FUNCTION apiGetClientRect
	LPARAMETERS tnhWnd, tlpRect
	DECLARE LONG GetClientRect IN User32 AS apiGetClientRect LONG nhWnd, STRING @lpRect
	RETURN apiGetClientRect(tnhWnd, @tlpRect)
ENDFUNC


FUNCTION apiGetDC
	LPARAMETERS tnhWnd
	DECLARE LONG GetDC IN User32 AS apiGetDC LONG nhWnd
	RETURN apiGetDC(tnhWnd)
ENDFUNC


FUNCTION apiCreateCompatibleDC
	LPARAMETERS thDC
	DECLARE LONG CreateCompatibleDC IN GDI32 AS apiCreateCompatibleDC LONG hDC
	RETURN apiCreateCompatibleDC(thDC)
ENDFUNC


FUNCTION apiCreateCompatibleBitmap
	LPARAMETERS thDC, tnWidth, tnHeight
	DECLARE LONG CreateCompatibleBitmap IN GDI32 AS apiCreateCompatibleBitmap LONG hDC, LONG nWidth, LONG nHeight
	RETURN apiCreateCompatibleBitmap(thDC, tnWidth, tnHeight)
ENDFUNC


FUNCTION apiSelectObject
	LPARAMETERS thDC, thObject
	DECLARE LONG SelectObject IN GDI32 AS apiSelectObject LONG hDC, LONG hObject
	RETURN apiSelectObject(thDC, thObject)
ENDFUNC


FUNCTION apiGetObject
	LPARAMETERS hGDIobj, nBufLen, thObject
	DECLARE INTEGER GetObject in GDI32 AS apiGetObject Long hGDIobj, Integer nBufLen, String @thObject
	RETURN apiGetObject(hGDIobj, nBufLen, @thObject)
ENDFUNC


FUNCTION apiReleaseDC
	LPARAMETERS tnhWnd, thDC
	DECLARE INTEGER ReleaseDC IN User32 AS apiReleaseDC LONG nhWnd, LONG hDC
	RETURN apiReleaseDC(tnhWnd, thDC)
ENDFUNC


FUNCTION apiCreateDC
	LPARAMETERS tpDriverName, tpDeviceName, tpOutput, tcDevMode
	DECLARE INTEGER CreateDC IN Win32API AS apiCreateDC STRING tpDriverName, STRING tpDeviceName, STRING tpOutput, STRING tcDevMode
	RETURN apiCreateDC(tpDriverName, tpDeviceName, tpOutput, tcDevMode)
ENDFUNC


FUNCTION apiDeleteDC
	LPARAMETERS thDC
	DECLARE LONG DeleteDC IN GDI32 AS apiDeleteDC LONG hDC
	RETURN apiDeleteDC(thDC)
ENDFUNC


FUNCTION apiDeleteObject
	LPARAMETERS thDC
	DECLARE LONG DeleteObject IN GDI32 AS apiDeleteObject LONG hDC
	RETURN apiDeleteObject(thDC)
ENDFUNC


FUNCTION apiGetDeviceCaps
	LPARAMETERS thDC, tnIndex
	DECLARE INTEGER GetDeviceCaps IN GDI32 AS apiGetDeviceCaps LONG hDC, INTEGER nIndex
	RETURN apiGetDeviceCaps(thDC, tnIndex)
ENDFUNC


FUNCTION apiGetSysColorBrush
	LPARAMETERS tnIndex
	DECLARE LONG GetSysColorBrush IN User32 AS apiGetSysColorBrush INTEGER nIndex
	RETURN apiGetSysColorBrush(tnIndex)
ENDFUNC


FUNCTION apiSetBkColor
	LPARAMETERS thDC, tcrColor
	DECLARE LONG SetBkColor IN GDI32 AS apiSetBkColor LONG hDC, LONG crColor
	RETURN apiSetBkColor(thDC, tcrColor)
ENDFUNC


FUNCTION apiCreateSolidBrush
	LPARAMETERS tcrColor
	DECLARE LONG CreateSolidBrush IN GDI32 AS apiCreateSolidBrush LONG crColor
	RETURN apiCreateSolidBrush(tcrColor)
ENDFUNC


FUNCTION apiSetBkMode
	LPARAMETERS thDC, tiBkMode
	DECLARE INTEGER SetBkMode IN GDI32 AS apiSetBkMode LONG hDC, INTEGER iBkMode
	RETURN apiSetBkMode(thDC, tiBkMode)
ENDFUNC


FUNCTION apiGetStockObject
	LPARAMETERS tfnObject
	DECLARE LONG GetStockObject IN GDI32 AS apiGetStockObject INTEGER fnObject
	RETURN apiGetStockObject(tfnObject)
ENDFUNC


FUNCTION apiCreatePatternBrush
	LPARAMETERS thBmp
	DECLARE LONG CreatePatternBrush IN GDI32 AS apiCreatePatternBrush LONG hBmp
	RETURN apiCreatePatternBrush(thBmp)
ENDFUNC


FUNCTION apiGdiSetBatchLimit
	LPARAMETERS tdwLimit
	DECLARE LONG GdiSetBatchLimit IN GDI32 AS apiGdiSetBatchLimit LONG dwLimit
	RETURN apiGdiSetBatchLimit(tdwLimit)
ENDFUNC


FUNCTION apiGetTextExtentPoint32
	LPARAMETERS thDC, tcString, tnStrLen, tpSize
	DECLARE LONG GetTextExtentPoint32 IN GDI32 AS apiGetTextExtentPoint32 LONG hDC, STRING cString, INTEGER nStrLen, STRING @pSize
	RETURN apiGetTextExtentPoint32(thDC, tcString, tnStrLen, @tpSize)
ENDFUNC


FUNCTION apiFillRect
	LPARAMETERS thDC, tlpRect, thBrush
	DECLARE INTEGER FillRect IN User32 AS apiFillRect LONG hDC, STRING @lpRect, LONG hBrush
	RETURN apiFillRect(thDC, @tlpRect, thBrush)
ENDFUNC


FUNCTION apiDrawText
	LPARAMETERS thDC, tlpString, tnCount, tlpRect, tuFormat
	DECLARE INTEGER DrawText IN User32 AS apiDrawText LONG hDC, STRING lpString, INTEGER nCount, STRING @lpRect, LONG uFormat
	RETURN apiDrawText(thDC, tlpString, tnCount, @tlpRect, tuFormat)
ENDFUNC


FUNCTION apiExtTextOut
	LPARAMETERS thDC, tnX, tnY, tfuOptions, tlsRect, tcText, tnTextLen, tlpaDx
	DECLARE LONG ExtTextOut IN GDI32 AS apiExtTextOut LONG hDC, INTEGER nX, INTEGER nY, LONG fuOptions, STRING @lsRect, STRING cText, LONG nTextLen, STRING @lpaDx
	RETURN apiExtTextOut(thDC, tnX, tnY, tfuOptions, @tlsRect, tcText, tnTextLen, @tlpaDx)
ENDFUNC


FUNCTION apiDrawEdge
	LPARAMETERS thDC, tlpRect, tnEdgeType, tnBorderType
	DECLARE LONG DrawEdge IN User32 AS apiDrawEdge LONG hDC, STRING @lpRect, LONG nEdgeType, LONG nBorderType
	RETURN apiDrawEdge(thDC, @tlpRect, tnEdgeType, tnBorderType)
ENDFUNC


FUNCTION apiCreatePen
	LPARAMETERS tfnPenStyle, tnWidth, tcrColor
	DECLARE LONG CreatePen IN GDI32 AS apiCreatePen INTEGER fnPenStyle, INTEGER nWidth, LONG crColor
	RETURN apiCreatePen(tfnPenStyle, tnWidth, tcrColor)
ENDFUNC


FUNCTION apiExtCreatePen
	LPARAMETERS dwPenStyle, dwWidth, lplb, dwStyleCount, lpStyle
	DECLARE INTEGER ExtCreatePen IN Win32API AS apiExtCreatePen INTEGER dwPenStyle, INTEGER dwWidth, STRING lplb, INTEGER dwStyleCount, STRING lpStyle
	RETURN apiExtCreatePen(dwPenStyle, dwWidth, lplb, dwStyleCount, lpStyle)
ENDFUNC


FUNCTION apiMoveToEx
	LPARAMETERS thDC, tnX, tnY, tlpPoint
	DECLARE LONG MoveToEx IN GDI32 AS apiMoveToEx LONG hDC, INTEGER nX, INTEGER nY, STRING @lpPoint
	RETURN apiMoveToEx(thDC, tnX, tnY, tlpPoint)
ENDFUNC


FUNCTION apiLineTo
	LPARAMETERS thDC, tnEndX, tnEndY
	DECLARE LONG LineTo IN GDI32 AS apiLineTo LONG hDC, INTEGER nEndX, INTEGER nEndY
	RETURN apiLineTo(thDC, tnEndX, tnEndY)
ENDFUNC


FUNCTION apiRectangle
	LPARAMETERS thDC, tnLeftRect, tnTopRect, tnRightRect, tnBottomRect
	DECLARE LONG Rectangle IN GDI32 AS apiRectangle LONG hDC, INTEGER nLeftRect, INTEGER nTopRect, INTEGER nRightRect, INTEGER nBottomRect
	RETURN apiRectangle(thDC, tnLeftRect, tnTopRect, tnRightRect, tnBottomRect)
ENDFUNC


FUNCTION apiRoundRect
	LPARAMETERS thDC, tnLeftRect, tnTopRect, tnRightRect, tnBottomRect, tnWidthCurve, tnHeightCurve
	DECLARE LONG RoundRect IN GDI32 AS apiRoundRect LONG hDC, INTEGER nLeftRect, INTEGER nTopRect, INTEGER nRightRect, INTEGER nBottomRect, INTEGER nWidthCurve, INTEGER nHeightCurve
	RETURN apiRoundRect(thDC, tnLeftRect, tnTopRect, tnRightRect, tnBottomRect, tnWidthCurve, tnHeightCurve)
ENDFUNC


FUNCTION apiSetRect
	LPARAMETERS tlpRect, tnLeft, tnTop, tnRight, tnBottom
	DECLARE LONG SetRect IN User32 AS apiSetRect STRING @lpRect, INTEGER nLeft, INTEGER nTop, INTEGER nRight, INTEGER nBottom
	RETURN apiSetRect(tlpRect, tnLeft, tnTop, tnRight, tnBottom)
ENDFUNC


FUNCTION apiGradientFill
	LPARAMETERS thDC, tpVertex, tdwNumVertex, tpMesh, tdwNumMesh, tdwMode
	DECLARE LONG GradientFill IN MsImg32 AS apiGradientFill LONG hDC, STRING pVertex, LONG dwNumVertex, STRING pMesh, LONG dwNumMesh, LONG dwMode
	RETURN apiGradientFill(thDC, tpVertex, tdwNumVertex, tpMesh, tdwNumMesh, tdwMode)
ENDFUNC


FUNCTION apiGetPixel
	LPARAMETERS thDC, tnXPos, tnYPos
	DECLARE LONG GetPixel IN GDI32 AS apiGetPixel LONG hDC, INTEGER nXPos, INTEGER nYPos
	RETURN apiGetPixel(thDC, tnXPos, tnYPos)
ENDFUNC


FUNCTION apiSetPixelV
	LPARAMETERS thDC, tnXPos, tnYPos, tnColor
	DECLARE LONG SetPixelV IN GDI32 AS apiSetPixelV LONG hDC, INTEGER nXPos, INTEGER nYPos, LONG nColor
	RETURN apiSetPixelV(thDC, tnXPos, tnYPos, tnColor)
ENDFUNC


FUNCTION apiTransparentBlt
	LPARAMETERS thdcDest, tnXDest, tnYDest, tnWidthDest, thHeightDest, thdcSrc, tnXSrc, tnYSrc, tnWidthSrc, tnHeightSrc, tcrTransparent
	DECLARE LONG TransparentBlt IN MsImg32 AS apiTransparentBlt LONG hdcDest, INTEGER nXDest, INTEGER nYDest, INTEGER nWidthDest, INTEGER hHeightDest, LONG hdcSrc, INTEGER nXSrc, INTEGER nYSrc, INTEGER nWidthSrc, INTEGER nHeightSrc, LONG crTransparent
	RETURN apiTransparentBlt(thdcDest, tnXDest, tnYDest, tnWidthDest, thHeightDest, thdcSrc, tnXSrc, tnYSrc, tnWidthSrc, tnHeightSrc, tcrTransparent)
ENDFUNC


FUNCTION apiBitBlt
	LPARAMETERS thdcDest, tnXDest, tnYDest, tnWidthDest, thHeightDest, thdcSrc, tnXSrc, tnYSrc, tdwRop
	DECLARE LONG BitBlt IN GDI32 AS apiBitBlt LONG hdcDest, INTEGER nXDest, INTEGER nYDest, INTEGER nWidthDest, INTEGER hHeightDest, LONG hdcSrc, INTEGER nXSrc, INTEGER nYSrc, LONG dwRop
	RETURN apiBitBlt(thdcDest, tnXDest, tnYDest, tnWidthDest, thHeightDest, thdcSrc, tnXSrc, tnYSrc, tdwRop)
ENDFUNC


FUNCTION apiAlphaBlend
	LPARAMETERS thdcDest, tnXDest, tnYDest, tnWidthDest, tnHeightDest, thdcSrc, tnXSrc, tnYSrc, tnWidthSrc, tnHeightSrc, tblendFunction
	DECLARE LONG AlphaBlend IN MsImg32 AS apiAlphaBlend LONG hdcDest, INTEGER nXDest, INTEGER nYDest, INTEGER nWidthDest, INTEGER nHeightDest, INTEGER hdcSrc, INTEGER nXSrc, INTEGER nYSrc, INTEGER nWidthSrc, INTEGER nHeightSrc, INTEGER blendFunction
	RETURN apiAlphaBlend(thdcDest, tnXDest, tnYDest, tnWidthDest, tnHeightDest, thdcSrc, tnXSrc, tnYSrc, tnWidthSrc, tnHeightSrc, tblendFunction)
ENDFUNC


FUNCTION apiCreateFontIndirect
	LPARAMETERS tlpLogFont
	DECLARE LONG CreateFontIndirect IN GDI32 AS apiCreateFontIndirect STRING lpLogFont
	RETURN apiCreateFontIndirect(tlpLogFont)
ENDFUNC


FUNCTION apiClientToScreen
	LPARAMETERS tnhWnd, tlpPoint
	DECLARE LONG ClientToScreen IN User32 AS apiClientToScreen LONG nhWnd, STRING @lpPoint
	RETURN apiClientToScreen(tnhWnd, @tlpPoint)
ENDFUNC


FUNCTION apiScreenToClient
	LPARAMETERS tnhWnd, tlpPoint
	DECLARE LONG ScreenToClient IN User32 AS apiScreenToClient LONG nhWnd, STRING @lpPoint
	RETURN apiScreenToClient(tnhWnd, @tlpPoint)
ENDFUNC


FUNCTION apiMapWindowPoints
	LPARAMETERS thWndFrom, thWndTo, tcPoints, tnPointCounts
	DECLARE INTEGER MapWindowPoints IN User32 AS apiMapWindowPoints LONG hWndFrom, LONG hWndTo, STRING @cPoints, LONG nPointCounts
	RETURN apiMapWindowPoints(thWndFrom, thWndTo, @tcPoints, tnPointCounts)
ENDFUNC


FUNCTION apiPtInRect
	LPARAMETERS tlpRect, tnX, tnY
	DECLARE LONG PtInRect IN User32 AS apiPtInRect STRING @lpRect, LONG nX, LONG nY
	RETURN apiPtInRect(@tlpRect, tnX, tnY)
ENDFUNC


FUNCTION apiSetCursor
	LPARAMETERS thCursor
	DECLARE LONG SetCursor IN User32 AS apiSetCursor LONG hCursor
	RETURN apiSetCursor(thCursor)
ENDFUNC


FUNCTION apiLoadCursor
	LPARAMETERS thInstance, tnCursorID
	DECLARE LONG LoadCursor IN User32 AS apiLoadCursor LONG hInstance, LONG nCursorID
	RETURN apiLoadCursor(thInstance, tnCursorID)
ENDFUNC


FUNCTION apiMulDiv
	LPARAMETERS tnNumber, tnNumerator, tnDenominator
	DECLARE INTEGER MulDiv IN Kernel32 AS apiMulDiv INTEGER nNumber, INTEGER nNumerator, INTEGER nDenominator
	RETURN apiMulDiv(tnNumber, tnNumerator, tnDenominator)
ENDFUNC


FUNCTION apiCreateRoundRectRgn
	LPARAMETERS tnLeftRect, tnTopRect, tnRightRect, tnBottomRect, tnWidthEllipse, tnHeightEllipse
	DECLARE LONG CreateRoundRectRgn IN GDI32 AS apiCreateRoundRectRgn INTEGER nLeftRect, INTEGER nTopRect, INTEGER nRightRect, INTEGER nBottomRect, INTEGER nWidthEllipse, INTEGER nHeightEllipse
	RETURN apiCreateRoundRectRgn(tnLeftRect, tnTopRect, tnRightRect, tnBottomRect, tnWidthEllipse, tnHeightEllipse)
ENDFUNC


FUNCTION apiSelectClipRgn
	LPARAMETERS thDC, thRegion
	DECLARE INTEGER SelectClipRgn IN GDI32 AS apiSelectClipRgn LONG hDC, LONG hRegion
	RETURN apiSelectClipRgn(thDC, thRegion)
ENDFUNC


FUNCTION apiIsThemeActive
	DECLARE LONG IsThemeActive IN uxTheme AS apiIsThemeActive
	RETURN apiIsThemeActive()
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Registry Functions
*-*
FUNCTION apiRegOpenKey
	LPARAMETERS tnHKey, tcSubKey, tnHandle
	DECLARE INTEGER RegOpenKey IN Win32API AS apiRegOpenKey INTEGER tnHKey, STRING tcSubKey, INTEGER @tnHandle
	RETURN apiRegOpenKey(tnHKey, tcSubKey, @tnHandle)
ENDFUNC


FUNCTION apiRegEnumValue
	LPARAMETERS tnHKey, tnIndex, tpszValueName, tpdwSize, twReserved, tpdwType, tpbData, tpcbData
	DECLARE INTEGER RegEnumValue IN Win32API AS apiRegEnumValue INTEGER tnHKey, INTEGER tnIndex, STRING @tpszValueName, INTEGER @tpdwSize, INTEGER twReserved, INTEGER @tpdwType, STRING @tpbData, INTEGER @tpcbData
	RETURN apiRegEnumValue(tnHKey, tnIndex, @tpszValueName, @tpdwSize, twReserved, @tpdwType, @tpbData, @tpcbData)
ENDFUNC


FUNCTION apiRegCloseKey
	LPARAMETERS tnHKey
	DECLARE INTEGER RegCloseKey IN Win32API AS apiRegCloseKey INTEGER tnHKey
	RETURN apiRegCloseKey(tnHKey)
ENDFUNC


FUNCTION apiRegQueryValueEx
	LPARAMETERS tnHKey, tpszValueName, twReserved, tpdwType, tpbData, tpcbData
	DECLARE INTEGER RegQueryValueEx IN Win32API AS apiRegQueryValueEx INTEGER tnHKey, STRING tpszValueName, INTEGER twReserved, INTEGER @tpdwType, STRING @tpbData, INTEGER @tpcbData
	RETURN apiRegQueryValueEx(tnHKey, tpszValueName, twReserved, @tpdwType, @tpbData, @tpcbData)
ENDFUNC


FUNCTION apiRegCreateKey
	LPARAMETERS tnHKey, tcSubKey, tnHandle
	DECLARE Integer RegCreateKey IN Win32API AS apiRegCreateKey INTEGER tnHKey, STRING tcSubKey, INTEGER @tnHandle
	RETURN apiRegCreateKey(tnHKey, tcSubKey, @tnHandle)
ENDFUNC


FUNCTION apiRegDeleteValue
	LPARAMETERS tnHKEY, tcEntry
	DECLARE INTEGER RegDeleteValue IN Win32API AS apiRegDeleteValueINTEGER tnHKEY, STRING tcEntry
	RETURN apiRegDeleteValue(tnHKEY, tcEntry)
ENDFUNC


FUNCTION apiRegSetValueEx
	LPARAMETERS tnHKey, tpszEntry, twReserved, tdwType, tpbData, tcbData
	DECLARE INTEGER RegSetValueEx IN Win32API AS apiRegSetValueEx INTEGER tnHKey, STRING tpszEntry, INTEGER twReserved, INTEGER tdwType, STRING tpbData, INTEGER tcbData
	RETURN apiRegSetValueEx(tnHKey, tpszEntry, twReserved, tdwType, tpbData, tcbData)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Icon Functions
*-*
FUNCTION apiExtractIconEx
	LPARAMETERS tFile, iconIndex, tIconLarge, tIconSmall, tnIcons
	DECLARE LONG ExtractIconEx IN shell32 AS apiExtractIconEx STRING @tFile, LONG iconIndex, LONG @tIconLarge, LONG @tIconSmall, LONG tnIcons
	RETURN apiExtractIconEx(@tFile, iconIndex, @tIconLarge, @tIconSmall, tnIcons)
ENDFUNC


FUNCTION apiDestroyIcon
	LPARAMETERS hIcon
	DECLARE SHORT DestroyIcon IN user32 AS apiDestroyIcon INTEGER hIcon
	RETURN apiDestroyIcon(hIcon)
ENDFUNC


FUNCTION apiExtractAssociatedIcon
	LPARAMETERS thInst, tpIconPath, tpiIcon
	DECLARE INTEGER ExtractAssociatedIcon IN shell32 AS apiExtractAssociatedIcon INTEGER thInst, STRING @tpIconPath, INTEGER @tpiIcon
	RETURN apiExtractAssociatedIcon(thInst, @tpIconPath, @tpiIcon)
ENDFUNC


FUNCTION apiOleCreatePictureIndirect
	LPARAMETERS tPicDesc, tRefIID, tfPictureOwnsHandle, tIPic
	DECLARE LONG OleCreatePictureIndirect IN oleaut32 AS apiOleCreatePictureIndirect STRING @tPicDesc, STRING @tRefIID, LONG tfPictureOwnsHandle, OBJECT @tIPic
	RETURN apiOleCreatePictureIndirect(tPicDesc, @tRefIID, tfPictureOwnsHandle, @tIPic)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 General Functions
*-*
FUNCTION apiSHGetSpecialFolderPath
	LPARAMETERS hwndOwner, lpszPath, nFolder, ifCreate
	DECLARE INTEGER SHGetSpecialFolderPath IN Shell32.DLL AS apiSHGetSpecialFolderPath INTEGER hwndOwner, STRING @lpszPath, INTEGER nFolder, INTEGER ifCreate
	RETURN apiSHGetSpecialFolderPath(m.hwndOwner, @m.lpszPath, m.nFolder, m.ifCreate)
ENDFUNC


Function apiGetProcAddress
	Lparameters hModule, lpProcName
	Declare Integer GetProcAddress In win32api As apiGetProcAddress Integer hModule, String  lpProcName
	Return apiGetProcAddress(m.hModule, m.lpProcName)
Endfunc


Function apiFreeLibrary
	Lparameters hLibModule
	Declare Integer FreeLibrary In win32api As apiFreeLibrary Integer hLibModule
	Return apiFreeLibrary(m.hLibModule)
Endfunc


Function apiGetCaretPos
	Lparameters lpPoint
	Declare Integer GetCaretPos In win32api As apiGetCaretPos String  @lpPoint
	Return apiGetCaretPos(@m.lpPoint)
Endfunc


Function apiCloseHandle
	Lparameters hObject
	Declare Integer CloseHandle In win32api As apiCloseHandle Integer hObject
	Return apiCloseHandle(m.hObject)
Endfunc


Function apiReadFile
	Lparameters hFile, lpBuffer, nNumberOfBytesToRead, lpNumberOfBytesRead, lpOverlapped
	Declare Integer ReadFile In win32api As apiReadFile Integer hFile, String  @lpBuffer, Integer nNumberOfBytesToRead, Integer @lpNumberOfBytesRead, Integer lpOverlapped
	Return apiReadFile(m.hFile, @m.lpBuffer, m.nNumberOfBytesToRead, @m.lpNumberOfBytesRead, m.lpOverlapped)
Endfunc


Function apiFileTimeToSystemTime
	Lparameters lpFileTime, lpSystemTime
	Declare Integer FileTimeToSystemTime In win32api As apiFileTimeToSystemTime Integer lpFileTime, Integer lpSystemTime
	Return apiFileTimeToSystemTime(m.lpFileTime, m.lpSystemTime)
Endfunc


Function apiCreateFile
	Lparameters lpFileName, dwDesiredAccess, dwShareMode, lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile
	Declare Integer CreateFile In win32api As apiCreateFile String  lpFileName, Integer dwDesiredAccess, Integer dwShareMode, Integer lpSecurityAttributes, Integer dwCreationDisposition, Integer dwFlagsAndAttributes, Integer hTemplateFile
	Return apiCreateFile(m.lpFileName, m.dwDesiredAccess, m.dwShareMode, m.lpSecurityAttributes, m.dwCreationDisposition, m.dwFlagsAndAttributes, m.hTemplateFile)
Endfunc


Function apiSetFilePointerEx
	Lparameters hFile, iDistanceToMoveLow, iDistanceToMoveHigh, lpNewFilePointer, dwMoveMethod
	Declare Integer SetFilePointerEx In win32api As apiSetFilePointerEx Integer hFile, Integer iDistanceToMoveLow, Integer iDistanceToMoveHigh, String  @lpNewFilePointer, Integer dwMoveMethod
	Return apiSetFilePointerEx(m.hFile, m.iDistanceToMoveLow, m.iDistanceToMoveHigh, @m.lpNewFilePointer, m.dwMoveMethod)
Endfunc


Function apiGetFileSizeEx
	Lparameters hFile, lpFileSize
	Declare Integer GetFileSizeEx In win32api As apiGetFileSizeEx Integer hFile, String  @lpFileSize
	Return apiGetFileSizeEx(m.hFile, @m.lpFileSize)
Endfunc


Function apiWriteFile
	Lparameters hFile, lpBuffer, nNumberOfBytesToWrite, lpNumberOfBytesWritten, lpOverlapped
	Declare Integer WriteFile In win32api As apiWriteFile ;
		Integer hFile, ;
		String  lpBuffer, ;
		Integer nNumberOfBytesToWrite, ;
		Integer @lpNumberOfBytesWritten, ;
		Integer lpOverlapped
	Return apiWriteFile(m.hFile, m.lpBuffer, m.nNumberOfBytesToWrite, @m.lpNumberOfBytesWritten, m.lpOverlapped)
Endfunc


Function apiSendMessage
	Lparameters nhWnd, Msg, wParam, Lparam
	*!* 2008-04-18 Changed to wrap SendMessage with a string lParam
	*!* and SendMessage with an integer lParam
	If Vartype(m.lParam) = "C" Then
		Return apiSendMessageString(m.nhWnd, m.Msg, m.wParam, @m.lParam)
	Else
		Return apiSendMessageInteger(m.nhWnd, m.Msg, m.wParam, m.lParam)
	Endif
Endfunc


Function apiSendMessageInteger
	Lparameters nhWnd, Msg, wParam, Lparam
	Declare Integer SendMessage In win32api As apiSendMessageInteger ;
		Integer nhWnd, ;
		Integer Msg, ;
		Integer wParam, ;
		Integer Lparam
	Return apiSendMessageInteger(m.nhWnd, m.Msg, m.wParam, m.lParam)
Endfunc


Function apiSendMessageString
	Lparameters nhWnd, Msg, wParam, Lparam
	Declare Integer SendMessage In win32api As apiSendMessageString ;
		Integer nhWnd, ;
		Integer Msg, ;
		Integer wParam, ;
		String  @Lparam
	Return apiSendMessageString(m.nhWnd, m.Msg, m.wParam, @m.lParam)
Endfunc


Function apiGetDateFormat
	Lparameters Locale, dwFlags, lpDate, lpFormat, lpDateStr, cchDate
	Declare Integer GetDateFormat In win32api As apiGetDateFormat ;
		Integer Locale, ;
		Integer dwFlags, ;
		String  lpDate, ;
		String  lpFormat, ;
		String  @lpDateStr, ;
		Integer cchDate
	Return apiGetDateFormat(m.Locale, m.dwFlags, m.lpDate, m.lpFormat, @m.lpDateStr, m.cchDate)
Endfunc


Function apiUuidCreate
	Lparameters Uuid
	Declare Integer UuidCreate In rpcrt4 As apiUuidCreate ;
		String  @Uuid
	Return apiUuidCreate(@m.Uuid)
Endfunc


Function apiUuidCreateNil
	Lparameters Nil_Uuid
	Declare Integer UuidCreateNil In rpcrt4 As apiUuidCreateNil ;
		String  @Nil_Uuid
	Return apiUuidCreate(@m.Nil_Uuid)
Endfunc


Function apiUuidToString
	Lparameters Uuid, StringUuid
	Declare Integer UuidToString In rpcrt4 As apiUuidToString ;
		String  Uuid, ;
		Integer @StringUuid
	Return apiUuidToString(m.Uuid, @m.StringUuid)
Endfunc


Function apiGetParent
	Lparameters nhWnd
	Declare Integer GetParent In win32api As apiGetParent;
		Integer nhWnd
	Return apiGetParent(m.nhWnd)
Endfunc


Function apiGetScrollPos
	Lparameters nWnd, nBar
	Declare Integer GetScrollPos In win32api As apiGetScrollPos ;
		Integer nhWnd, ;
		Integer nBar
	Return apiGetScrollPos(m.nWnd, m.nBar)
Endfunc


Function apiShowScrollBar
	Lparameters nhWnd, wBar, bShow
	Declare Integer ShowScrollBar In win32api As apiShowScrollBar ;
		Integer nhWnd, ;
		Integer wBar, ;
		Integer bShow
	Return apiShowScrollBar(m.nhWnd, m.wBar, m.bShow)
Endfunc


Function apiEnableWindow
	Lparameters nhWnd, bEnable
	Declare Integer EnableWindow In win32api As apiEnableWindow ;
		Integer nhWnd, ;
		Integer bEnable
	Return apiEnableWindow(m.nhWnd, m.bEnable)
Endfunc


Function apiSetScrollInfo
	Lparameters nhWnd, fnBar, lpsi, fRedraw
	Declare Integer SetScrollInfo In win32api As apiSetScrollInfo ;
		Integer nhWnd, ;
		Integer fnBar, ;
		Integer lpsi, ;
		Integer fRedraw
	Return apiSetScrollInfo(m.nhWnd, m.fnBar, m.lpsi, m.fRedraw)
Endfunc


Function apiCreateWindowEx
	Lparameters dwExStyle, lpClassName, lpWindowName, dwStyle, nx, ny, nWidth, nHeight, nHwndParent, hMenu, hInstance, lpParam
	Declare Integer CreateWindowEx In win32api As apiCreateWindowEx ;
		Integer dwExStyle, ;
		String  lpClassName, ;
		String  lpWindowName, ;
		Integer dwStyle, ;
		Integer nx, ;
		Integer ny, ;
		Integer nWidth, ;
		Integer nHeight, ;
		Integer nHwndParent, ;
		Integer hMenu, ;
		Integer hInstance, ;
		Integer lpParam
	Return apiCreateWindowEx(m.dwExStyle, m.lpClassName, m.lpWindowName, m.dwStyle, m.nx, m.ny, m.nWidth, m.nHeight, m.nHwndParent, m.hMenu, m.hInstance, m.lpParam)
Endfunc


Function apiSetWindowTheme
	Lparameters nhWnd, pszSubAppName, pszSubIdList
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer SetWindowTheme In uxtheme As apiSetWindowTheme ;
			Integer nhWnd, ;
			String  pszSubAppName, ;
			String  pszSubIdList
		Return  apiSetWindowTheme(m.nhWnd, m.pszSubAppName, m.pszSubIdList)
	Else
		Return 0
	Endif
Endfunc


Function apiGetScrollRange
	Lparameters nhWnd, nBar, lpMinPos, lpMaxPos
	Declare Integer GetScrollRange In win32api As apiGetScrollRange ;
		Integer nhWnd, ;
		Integer nBar, ;
		Integer @lpMinPos, ;
		Integer @lpMaxPos
	Return apiGetScrollRange(m.nhWnd, m.nBar, @m.lpMinPos, @m.lpMaxPos)
Endfunc


Function apiOpenThemeData
	Lparameters nhWnd, pszClassList
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer OpenThemeData In uxtheme As apiOpenThemeData ;
			Integer nhWnd, ;
			String  pszClassList
		Return apiOpenThemeData(m.nhWnd, m.pszClassList)
	Else
		Return 0
	Endif
Endfunc


Function apiGetThemeColor
	Lparameters hTheme, iPartId , iStateId , iPropId, pColor
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer GetThemeColor In uxtheme As apiGetThemeColor ;
			Integer hTheme, ;
			Integer iPartId, ;
			Integer iStateId, ;
			Integer iPropId, ;
			Integer @pColor
		Return apiGetThemeColor(m.hTheme, m.iPartId , m.iStateId , m.iPropId , @m.pColor )
	Else
		Return ERROR_INVALID_FUNCTION
	Endif
Endfunc


Function apiCloseThemeData
	Lparameters hTheme
	If ctlGetOsVersion() >= NTDDI_WINXP
		Declare Integer CloseThemeData In uxtheme As apiCloseThemeData ;
			Integer hTheme
		Return apiCloseThemeData(m.hTheme)
	Else
		Return 0
	Endif
Endfunc


Function apiGetTickCount()
	Declare Integer GetTickCount In win32api As apiGetTickCount
	Return apiGetTickCount()
Endfunc


Function apiSetWindowRgn
	Lparameters nhWnd, hRgn, bRedraw
	Declare Integer SetWindowRgn In win32api As apiSetWindowRgn ;
		Integer nhWnd, ;
		Integer hRgn, ;
		Integer bRedraw
	Return apiSetWindowRgn(m.nhWnd, m.hRgn, m.bRedraw)
Endfunc


Function apiCreateRectRgn
	Lparameters x1, y1, x2, y2
	Declare Integer CreateRectRgn In win32api As apiCreateRectRgn ;
		Integer x1, ;
		Integer y1, ;
		Integer x2, ;
		Integer y2
	Return apiCreateRectRgn(m.x1, m.y1, m.x2, m.y2)
Endfunc


Function apiDestroyWindow
	Lparameters nhWnd
	Declare Integer DestroyWindow In win32api As apiDestroyWindow ;
		Integer nhWnd
	Return apiDestroyWindow(m.nhWnd)
Endfunc


Function apiGetActiveWindow()
	Declare Integer GetActiveWindow In win32api As apiGetActiveWindow
	Return apiGetActiveWindow()
Endfunc


Function apiLoadString
	Lparameters hInstance, uID, lpBuffer, nBufferMax
	Declare Integer LoadString In win32api As apiLoadString ;
		Integer hInstance, ;
		Integer uID, ;
		String  lpBuffer, ;
		Integer nBufferMax
	Return apiLoadString(m.hInstance, m.uID, @m.lpBuffer, m.nBufferMax)
Endfunc


Function apiGetModuleHandle
	Lparameters lpModule
	Declare Integer GetModuleHandle In win32api As apiGetModuleHandle ;
		String  lpModule
	Return apiGetModuleHandle(m.lpModule)
Endfunc


Function apiGetLocaleInfo
	Lparameters Locale, LCType, lpLCData, cchData
	Declare Integer GetLocaleInfo In win32api As apiGetLocaleInfo;
		Integer Locale, ;
		Integer LCType, ;
		String  @lpLCData, ;
		Integer cchData
	Return apiGetLocaleInfo(m.Locale, m.LCType, @m.lpLCData, m.cchData)
Endfunc


Function apiGetProcessHeap()
	Declare Integer GetProcessHeap In win32api As apiGetProcessHeap
	Return apiGetProcessHeap()
Endfunc


Function apiSetFocus
	Lparameters nhWnd
	Declare Integer SetFocus In win32api As apiSetFocus ;
		Integer nhWnd
	Return apiSetFocus(m.nhWnd)
Endfunc


Function apiSetParent
	Lparameters nHwndChild, nHwndNewParent
	Declare Integer SetParent In win32api As apiSetParent ;
		Integer nHwndChild, ;
		Integer nHwndNewParent
	Return apiSetParent(m.nHwndChild, m.nHwndNewParent)
Endfunc


Function apiRealGetWindowClass
	Lparameters nhWnd, pszType, cchType
	Declare Integer RealGetWindowClass In win32api As apiRealGetWindowClass ;
		Integer nhWnd, ;
		String  @pszType, ;
		Integer cchType
	Return apiRealGetWindowClass(m.nhWnd, @m.pszType, m.cchType)
Endfunc


Function apiIsWindow
	Lparameters nhWnd
	Declare Integer IsWindow In win32api As apiIsWindow ;
		Integer nhWnd
	Return apiIsWindow(m.nhWnd)
Endfunc


Function apiGetDoubleClickTime()
	Declare Integer GetDoubleClickTime In win32api As apiGetDoubleClickTime
	Return apiGetDoubleClickTime()
Endfunc


Function apiRedrawWindow
	Lparameters nhWnd, lprcUpdate, hrgnUpdate, uFlags
	Declare Integer RedrawWindow In win32api As apiRedrawWindow ;
		Integer nhWnd, ;
		String  lprcUpdate, ;
		Integer hrgnUpdate, ;
		Integer uflags
	Return apiRedrawWindow(m.nhWnd, m.lprcUpdate, m.hrgnUpdate, m.uFlags)
Endfunc


Function apiInitCommonControlsEx
	Lparameters lpInitCtrls
	Declare Integer InitCommonControlsEx In comctl32 As apiInitCommonControlsEx ;
		String  lpInitCtrls
	Return apiInitCommonControlsEx(m.lpInitCtrls)
Endfunc


Function apiLoadLibrary
	Lparameters lpLibFileName
	Declare Integer LoadLibrary In win32api As apiLoadLibrary String lpLibFileName
	Return apiLoadLibrary(m.lpLibFileName)
Endfunc


FUNCTION apiSystemParametersInfo
	LPARAMETERS uiAction, uiParam, pvParam, nUpdateWinIn
	DECLARE LONG SystemParametersInfo IN User32 AS apiSystemParametersInfo LONG uiAction, LONG uiParam, LONG @O_pvParam, LONG nUpdateWinIni
	RETURN apiSystemParametersInfo(uiAction, uiParam, @pvParam, nUpdateWinIn)
ENDFUNC


FUNCTION apiCreateFont
	LPARAMETERS nHeight, nWidth, nEscapement, nOrientation, nWeight, nItalic, nUnderline, nStrikeOut, nCharSet, nOutputPrecision, nClipPrecision, nQuality, nPitchAndFamily, cFace
	DECLARE INTEGER CreateFont in Win32API AS apiCreateFont INTEGER nHeight, INTEGER nWidth, INTEGER nEscapement, INTEGER nOrientation, INTEGER nWeight, INTEGER nItalic, INTEGER nUnderline, INTEGER nStrikeOut, INTEGER nCharSet, INTEGER nOutputPrecision, INTEGER nClipPrecision, INTEGER nQuality, INTEGER nPitchAndFamily, STRING  cFace
	RETURN apiCreateFont(nHeight, nWidth, nEscapement, nOrientation, nWeight, nItalic, nUnderline, nStrikeOut, nCharSet, nOutputPrecision, nClipPrecision, nQuality, nPitchAndFamily, cFace)
ENDFUNC


FUNCTION apiPostMessage
	LPARAMETERS nhWnd, uMsg, wParam, lParam
	DECLARE LONG PostMessage IN User32 AS apiPostMessage LONG nhWnd, LONG uMsg, LONG wParam, LONG lParam
	RETURN apiPostMessage(nhWnd, uMsg, wParam, lParam)
ENDFUNC


FUNCTION apiGetLastError
	DECLARE INTEGER GetLastError IN kernel32 AS apiGetLastError
	RETURN apiGetLastError()
ENDFUNC


FUNCTION apiLockWindowUpdate
	LPARAMETERS tnHandle
	DECLARE INTEGER LockWindowUpdate IN WIN32API AS apiLockWindowUpdate INTEGER nHandle
	RETURN apiLockWindowUpdate(tnHandle)
ENDFUNC


FUNCTION apiFindExecutable
	LPARAMETERS lpFile, lpDirectory, lpResult
	DECLARE INTEGER FindExecutable IN Shell32 AS apiFindExecutable STRING @lpFile, STRING @lpDirectory, STRING @lpResult
	RETURN apiFindExecutable(@lpFile, @lpDirectory, @lpResult)
ENDFUNC


FUNCTION apiSHGetFileInfo
	LPARAMETERS tpszPath, tdwFileAttributes, tSHFILEINFO, tcbFileInfo, tuFlags
	DECLARE LONG SHGetFileInfo IN shell32 AS apiSHGetFileInfo STRING tpszPath, LONG tdwFileAttributes, STRING @tSHFILEINFO, INTEGER tcbFileInfo, INTEGER tuFlags
	RETURN apiSHGetFileInfo(tpszPath, tdwFileAttributes, @tSHFILEINFO, tcbFileInfo, tuFlags)
ENDFUNC


FUNCTION apiGetComputerName
	LPARAMETERS tcBuffer, tnSize
	DECLARE INTEGER GetComputerName IN kernel32 AS apiGetComputerName STRING @tcBuffer, INTEGER @tnSize
	RETURN apiGetComputerName(@tcBuffer, @tnSize)
ENDFUNC


FUNCTION apiGetVolumeInformation
	LPARAMETERS tpRootPathName, tpVolNameBuf, tnVolNameSz, tpVolSerialNum, tpMaxCompLen, tpFileSysFlags, tpFileSysNameBuf, tnFileSysNameSz
	DECLARE INTEGER GetVolumeInformation IN WIN32API AS apiGetVolumeInformation STRING @tpRootPathName, STRING @tpVolNameBuf, INTEGER tnVolNameSz, INTEGER @tpVolSerialNum, INTEGER @tpMaxCompLen, INTEGER @tpFileSysFlags, STRING @tpFileSysNameBuf, INTEGER tnFileSysNameSz
	RETURN apiGetVolumeInformation(@tpRootPathName, @tpVolNameBuf, tnVolNameSz, @tpVolSerialNum, @tpMaxCompLen, @tpFileSysFlags, @tpFileSysNameBuf, tnFileSysNameSz)
ENDFUNC


FUNCTION apiGetShortPathName
	LPARAMETERS tcLongName, tcShortName, tnSizeOf
	DECLARE LONG GetShortPathName IN Win32API AS apiGetShortPathName STRING tcLongName, STRING @tcShortName, LONG tnSizeOf
	RETURN apiGetShortPathName(tcLongName,@tcShortName,tnSizeOf)
ENDFUNC


FUNCTION apiBringWindowToTop
	LPARAMETERS thWnd
	DECLARE INTEGER BringWindowToTop IN Win32API AS apiBringWindowToTop INTEGER thWnd
	RETURN apiBringWindowToTop(thWnd)
ENDFUNC


FUNCTION apiShellExecute
	LPARAMETERS tnhWnd, tlpAction, tlpFile, tlpParams, tlpDirectory, tnShowCmd
	DECLARE INTEGER ShellExecute IN Shell32 AS apiShellExecute LONG nhWnd, STRING lpAction, STRING lpFile, STRING lpParams, STRING lpDirectory, INTEGER nShowCmd
	RETURN apiShellExecute(tnhWnd, tlpAction, tlpFile, tlpParams, tlpDirectory, tnShowCmd)
ENDFUNC


FUNCTION apiGetKeyState
	LPARAMETERS tKeyCode
	DECLARE SHORT GetKeyState IN User32 AS apiGetKeyState INTEGER KeyCode
	RETURN apiGetKeyState(tKeyCode)
ENDFUNC


FUNCTION apiGetAsyncKeyState
	LPARAMETERS tKeyCode
	DECLARE SHORT GetAsyncKeyState IN User32 AS apiGetAsyncKeyState INTEGER KeyCode
	RETURN apiGetAsyncKeyState(tKeyCode)
ENDFUNC


FUNCTION apiGetKeyboardState 
	LPARAMETERS tcKeyCodes
	DECLARE INTEGER GetKeyboardState IN user32 AS apiGetKeyboardState STRING @lpKeyState
	RETURN apiGetKeyboardState(@tcKeyCodes)
ENDFUNC


FUNCTION apiKillTimer
	LPARAMETERS tnhWnd, tnIDEvent
	DECLARE LONG KillTimer IN User32 AS apiKillTimer LONG nhWnd, LONG nIDEvent
	RETURN apiKillTimer(tnhWnd, tnIDEvent)
ENDFUNC


FUNCTION apiSetTimer
	LPARAMETERS tnhWnd, tnIDEvent, tuElapse, tlpTimerFunc
	DECLARE LONG SetTimer IN User32 AS apiSetTimer LONG nhWnd, LONG nIDEvent, LONG uElapse, LONG pTimerFunc
	RETURN apiSetTimer(tnhWnd, tnIDEvent, tuElapse, tlpTimerFunc)
ENDFUNC


FUNCTION apiGetSystemDirectory
	LPARAMETERS tpBuffer,tnSize
	DECLARE INTEGER GetSystemDirectory IN kernel32 AS apiGetSystemDirectory STRING @pBuffer, INTEGER nSize
	RETURN apiGetSystemDirectory(@tpBuffer,tnSize)
ENDFUNC


FUNCTION apiGetSystemMetrics
	LPARAMETERS tnIndex
	DECLARE INTEGER GetSystemMetrics IN User32 AS apiGetSystemMetrics INTEGER nIndex
	RETURN apiGetSystemMetrics(tnIndex)
ENDFUNC


FUNCTION apiGetSysColor
	LPARAMETERS tnIndex
	DECLARE LONG GetSysColor IN User32 AS apiGetSysColor INTEGER nIndex
	RETURN apiGetSysColor(tnIndex)
ENDFUNC


FUNCTION apiSetTextColor
	LPARAMETERS thDC, tcrColor
	DECLARE LONG SetTextColor IN GDI32 AS apiSetTextColor LONG hDC, LONG crColor
	RETURN apiSetTextColor(thDC, tcrColor)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Window Functions
*-*
FUNCTION apiMoveWindow
	LPARAMETERS thWnd, tnX, tnY, tnWidth, tnHeight, tbRepaint
	DECLARE LONG MoveWindow IN User32 AS apiMoveWindow LONG hWnd, INTEGER nX, INTEGER nY, INTEGER nWidth, INTEGER nHeight, LONG bRepaint
	RETURN apiMoveWindow(thWnd, tnX, tnY, tnWidth, tnHeight, tbRepaint)
ENDFUNC


FUNCTION apiSetWindowPos
	LPARAMETERS tnhWnd, thWndInsertAfter, tnX, tnY, tnWidth, tnHeight, tuFlags
	DECLARE LONG SetWindowPos IN User32 AS apiSetWindowPos LONG nhWnd, LONG hWndInsertAfter, INTEGER nX, INTEGER nY, INTEGER nWidth, INTEGER nHeight, LONG uFlags
	RETURN apiSetWindowPos(tnhWnd, thWndInsertAfter, tnX, tnY, tnWidth, tnHeight, tuFlags)
ENDFUNC


FUNCTION apiWindowFromPoint
	LPARAMETERS tnX, tnY
	DECLARE LONG WindowFromPoint IN User32 AS apiWindowFromPoint LONG nX, LONG nY
	RETURN apiWindowFromPoint(tnX, tnY)
ENDFUNC


FUNCTION apiGetDesktopWindow
	DECLARE INTEGER GetDesktopWindow IN user32 AS apiGetDesktopWindow
	RETURN apiGetDesktopWindow()
ENDFUNC


FUNCTION apiGetWindowDC
	LPARAMETERS tnhWnd
	DECLARE LONG GetWindowDC IN User32 AS apiGetWindowDC LONG nhWnd
	RETURN apiGetWindowDC(tnhWnd)
ENDFUNC


FUNCTION apiSetWindowLong
	LPARAMETERS tnhWnd, tnIndex, tdwNewLong
	DECLARE INTEGER SetWindowLong IN user32 AS apiSetWindowLong INTEGER hWnd, INTEGER nIndex, INTEGER dwNewLong
	RETURN apiSetWindowLong(tnhWnd, tnIndex, tdwNewLong)
ENDFUNC


FUNCTION apiCallWindowProc
	LPARAMETERS tlpPrevWndFunc, tnhWnd, tuMsg, twParam, tlParam
	DECLARE LONG CallWindowProc IN User32 AS apiCallWindowProc LONG lpPrevWndFunc, LONG nhWnd, LONG uMsg, LONG wParam, LONG lParam
	RETURN apiCallWindowProc(tlpPrevWndFunc, tnhWnd, tuMsg, twParam, tlParam)
ENDFUNC


FUNCTION apiGetWindowLong
	LPARAMETERS tnhWnd, tnIndex
	DECLARE LONG GetWindowLong IN User32 AS apiGetWindowLong LONG nhWnd, INTEGER nIndex
	RETURN apiGetWindowLong(tnhWnd, tnIndex)
ENDFUNC


FUNCTION apiGetWindow
	LPARAMETERS tnhWnd, twFlag
	DECLARE INTEGER GetWindow IN user32 AS apiGetWindow INTEGER hwnd, INTEGER wFlag
	RETURN apiGetWindow(tnhWnd, twFlag)
ENDFUNC


FUNCTION apiGetWindowText
	LPARAMETERS thWnd, tpString, tcCh
	DECLARE INTEGER GetWindowText IN user32 AS apiGetWindowText INTEGER thWnd, STRING @tpString, INTEGER tcCh
	RETURN apiGetWindowText(thWnd, @tpString, tcCh)
ENDFUNC


FUNCTION apiShowWindow
	LPARAMETERS tnhWnd, tnCmdShow
	DECLARE INTEGER ShowWindow IN win32api AS apiShowWindow INTEGER nhWnd, INTEGER nCmdShow
	RETURN apiShowWindow(tnhWnd, tnCmdShow)
ENDFUNC


FUNCTION apiIsIconic
	LPARAMETERS thWnd
	DECLARE INTEGER IsIconic IN user32 AS apiIsIconic INTEGER thWnd
	RETURN apiIsIconic(thWnd)
ENDFUNC


FUNCTION apiGetWindowRect
	LPARAMETERS tnhWnd, tlpRect
	DECLARE LONG GetWindowRect IN User32 AS apiGetWindowRect LONG nhWnd, STRING @lpRect
	RETURN apiGetWindowRect(tnhWnd, @tlpRect)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Memory Functions
*-*
FUNCTION apiHeapFree
	LPARAMETERS thHeap, tdwFlags, tlpHeap
	DECLARE LONG HeapFree IN Kernel32 AS apiHeapFree LONG hHeap, LONG dwFlags, LONG lpHeap
	RETURN apiHeapFree(thHeap, tdwFlags, tlpHeap)
ENDFUNC


FUNCTION apiHeapAlloc
	LPARAMETERS thHeap, tdwFlags, tdwBytes
	DECLARE LONG HeapAlloc IN Kernel32 AS apiHeapAlloc LONG hHeap, LONG dwFlags, LONG dwBytes
	RETURN apiHeapAlloc(thHeap, tdwFlags, tdwBytes)
ENDFUNC


FUNCTION apiHeapDestroy
	LPARAMETERS thHeap
	DECLARE LONG HeapDestroy IN Kernel32 AS apiHeapDestroy LONG hHeap
	RETURN apiHeapDestroy(thHeap)
ENDFUNC


FUNCTION apiHeapCreate
	LPARAMETERS tflOptions, tdwInitialSize, tdwMaximumSize
	DECLARE LONG HeapCreate IN Kernel32 AS apiHeapCreate LONG flOptions, LONG dwInitialSize, LONG dwMaximumSize
	RETURN apiHeapCreate(tflOptions, tdwInitialSize, tdwMaximumSize)
ENDFUNC


FUNCTION apiHeapSize
	LPARAMETERS thHeap, tnAlloc, tnAddr
	DECLARE INTEGER HeapSize IN Win32Api AS apiHeapSize INTEGER thHeap, INTEGER tnAlloc, INTEGER tnAddr
	RETURN apiHeapSize(thHeap, tnAlloc, tnAddr)
ENDFUNC


FUNCTION apilstrlen
	LPARAMETERS tlpString
	DECLARE INTEGER lstrlen IN Kernel32 AS apilstrlen LONG lpString
	RETURN apilstrlen(tlpString)
ENDFUNC


FUNCTION apilstrlenW
	LPARAMETERS tlpString
	DECLARE INTEGER lstrlenW IN Kernel32 AS apilstrlenW LONG lpString
	RETURN apilstrlenW(tlpString)
ENDFUNC


*-***********************************************************************************************
*-*	Win32 Network Functions
*-*
FUNCTION apiGetUserName
	LPARAMETERS tpBuffer, tnSize
	DECLARE INTEGER GetUserName IN advapi32.dll AS apiGetUserName STRING lpBuffer, INTEGER @nSize
	RETURN apiGetUserName(tpBuffer, @tnSize)
ENDFUNC


*-***********************************************************************************************
*-*	Functions used by OwnerDrawn Menu Class
*-*
FUNCTION CopyMem
	LPARAMETERS lpDest, lpSource, nLength
	DECLARE RtlMoveMemory IN Kernel32 AS CopyMem String @O_lpDest, Long lpSource, Long nLength
	RETURN CopyMem(@lpDest, lpSource, nLength)
ENDFUNC


FUNCTION CopyMem2Num
	LPARAMETERS lpDest, lpSource, nLength
	DECLARE RtlMoveMemory IN Kernel32 AS CopyMem2Num Long @O_lpDest, Long lpSource, Long nLength
	RETURN CopyMem2Num(@lpDest, lpSource, nLength)
ENDFUNC


FUNCTION Copy2Mem
	LPARAMETERS lpDest, lpSource, nLength
	DECLARE RtlMoveMemory IN Kernel32 AS Copy2Mem Long lpDest, String @lpSource, Long nLength
	RETURN Copy2Mem(lpDest, @lpSource, nLength)
ENDFUNC


FUNCTION CopyNum2Mem
	LPARAMETERS lpDest, lpSource, nLength
	DECLARE RtlMoveMemory IN Kernel32 AS CopyNum2Mem Long lpDest, Long @lpSource, Long nLength
	RETURN CopyNum2Mem(lpDest, @lpSource, nLength)
ENDFUNC


FUNCTION GetStrLen
	LPARAMETERS lpString
	DECLARE Integer lstrlen IN Kernel32 AS GetStrLen Long lpString
	RETURN GetStrLen(lpString)
ENDFUNC

	
FUNCTION SystemParametersInfoStr
	LPARAMETERS uiAction, uiParam, pvParam, nUpdateWinIni
	DECLARE Long SystemParametersInfo IN User32 AS SystemParametersInfoStr Long uiAction, Long uiParam, String @O_pvParam, Long nUpdateWinIni
	RETURN SystemParametersInfoStr(uiAction, uiParam, @pvParam, nUpdateWinIni)
ENDFUNC

	
FUNCTION PostMessageStr
	LPARAMETERS nhWnd, uMsg, wParam, lParam
	DECLARE Long PostMessage IN User32 AS PostMessageStr Long nhWnd, Long uMsg, Long wParam, String lParam
	RETURN PostMessageStr(nhWnd, uMsg, wParam, lParam)
ENDFUNC
