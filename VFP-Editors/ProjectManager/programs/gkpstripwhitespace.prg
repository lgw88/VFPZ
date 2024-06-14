*-***********************************************************************************************
*-* Written by:  Gregory A. Green
*-*              980 Windmill Parkway
*-*              Evans, GA  30809
*-*              (706) 651-1640
*-*
*-* Copyright ©2009 Gregory A. Green
*-*
*-***********************************************************************************************
*-* Routine for removing excess whitespace from a code line
*-*
FUNCTION GKPStripWhitespace
LPARAMETERS pcLine
pcLine = ALLTRIM(pcLine,1," ",CHR(9))
DO WHILE ATC(CHR(9),pcLine) > 0
	pcLine = CHRTRAN(pcLine,CHR(9)," ")
ENDDO
DO WHILE ATC("  ",pcLine) > 0
	pcLine = STRTRAN(pcLine,"  "," ")
ENDDO
RETURN pcLine
ENDFUNC