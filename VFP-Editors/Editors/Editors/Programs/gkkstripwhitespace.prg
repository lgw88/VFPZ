*-***********************************************************************************************
*-* Copyright ©2005-2016 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-*
*-***********************************************************************************************
*-* Routine for removing excess whitespace from a code line
*-*
FUNCTION GKKStripWhitespace
LPARAMETERS tcLine
tcLine = ALLTRIM(tcLine,1," ",CHR(9))
DO WHILE ATC(CHR(9),tcLine) > 0
	tcLine = CHRTRAN(tcLine,CHR(9)," ")
ENDDO
DO WHILE ATC("  ",tcLine) > 0
	tcLine = STRTRAN(tcLine,"  "," ")
ENDDO
RETURN tcLine
ENDFUNC