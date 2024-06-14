************************************************************************************************
* Based on Microsoft Knowledge Base Articles 94927, 210590
*
* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL 
* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*
************************************************************************************************
* Function to Convert from Pixels to Twips
*
* Parameters:  
*     pnPixels       Value to convert to twips
*     pcDirection    Screen direction; 'H' for horizontal and 'V' for vertical
*
* Returns:
*     Twips value
*
FUNCTION GKTPixelsToTwips
LPARAMETERS tnPixels, tcDirection
LOCAL lhDeviceHdl, lnPixelsPerInch
#DEFINE LOGPIXELSX  88
#DEFINE LOGPIXELSY  90
lhDeviceHdl = GetDC(0)
DO CASE
	CASE tcDirection = "H"        && Horizontal
		lnPixelsPerInch = GetDeviceCaps(lhDeviceHdl,LOGPIXELSX)
	CASE tcDirection = "V"        && Vertical
		lnPixelsPerInch = GetDeviceCaps(lhDeviceHdl,LOGPIXELSY)
ENDCASE
lhDeviceHdl = ReleaseDC(0,lhDeviceHdl)
RETURN tnPixels * 1440 / lnPixelsPerInch
ENDFUNC