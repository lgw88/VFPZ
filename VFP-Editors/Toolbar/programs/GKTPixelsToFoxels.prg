************************************************************************************************
* Code from Sergey Berezniker web page
*
************************************************************************************************
* Function to Convert from Foxels to Pixels
*
* Parameters:
*     tnPixels - pixels to convert
*     tlVertical - .F./.T. convert horizontal/vertical coordinates
*     tcFontName, tnFontSize - use specified font/size
*       or current form (active output window) font/size, if not specified
*
* Returns:
*     Foxels value
*
* Convert pixels to foxels
FUNCTION GKTPixelsToFoxels
LPARAMETER tnPixels, tlVertical, tcFontName, tnFontSize
LOCAL lnFoxels
IF PCOUNT() > 2
	lnFoxels = tnPixels/FONTMETRIC(IIF(tlVertical, 1, 6), tcFontName, tnFontSize)
ELSE
	lnFoxels = tnPixels/FONTMETRIC(IIF(tlVertical, 1, 6))
ENDIF
RETURN lnFoxels
ENDFUNC
