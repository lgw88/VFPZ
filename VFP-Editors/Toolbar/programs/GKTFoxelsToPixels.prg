************************************************************************************************
* Code from Sergey Berezniker web page
*
************************************************************************************************
* Function to Convert from Foxels to Pixels
*
* Parameters:
*     tnFoxels - foxels to convert
*     tlVertical - .F./.T. convert horizontal/vertical coordinates
*     tcFontName, tnFontSize - use specified font/size
*       or current form (active output window) font/size, if not specified
*
* Returns:
*     Pixels value
*
* Convert foxels to pixels
FUNCTION GKTFoxelsToPixels 
LPARAMETER tnFoxels, tlVertical, tcFontName, tnFontSize
LOCAL lnPixels
IF PCOUNT() > 2
	lnPixels = tnFoxels * FONTMETRIC(IIF(tlVertical, 1, 6), tcFontName, tnFontSize)
ELSE
	lnpixels = tnFoxels * FONTMETRIC(IIF(tlVertical, 1, 6))
ENDIF	
RETURN lnPixels 
ENDFUNC