* LGW 1788469@qq.com
? "Setup VFP"
SET SAFETY OFF
PRIVATE pcP1,pcP2
LOCAL lcF,lnC,lnI
LOCAL laF[1]
LOCAL laD[1]

TEXT TO lcF NOSHOW
*.dll
*.app
*.prg
ENDTEXT


pcP1 = Home(0)
lnL = VAL(Version(3))
DO CASE
CASE lnL = 7	&& Russian
	pcP2 = pcP1 + "RUS\"
	? "Russian "
CASE lnL = 33	&& French
	pcP2 = pcP1 + "FRA\"
	? "French "
*!*	CASE lnL = 34	&& Spanish
*!*	CASE lnL = 42	&& Czech
*!*	CASE lnL = 49	&& German
*!*	CASE lnL = 82	&& Korean
CASE lnL = 86	&& Simplified Chinese
	pcP2 = pcP1 + "CN\"
	? "ÖÐÎÄ "
*!*	CASE lnL = 88	&& Traditional Chinese
OTHERWISE	&& English
	pcP2 = pcP1 + "EN\"
	? "English"
ENDCASE

ALINES(laF,lcF)
FOR EACH lcF IN laF
	IF "*"$lcF
		lnC = ADIR(laD,pcP2 + lcF)
		FOR lnI=1 TO lnC
			Setup_Copy( laD[lnI,1] )
		ENDFOR
	ELSE
		Setup_Copy( lcF )
	ENDIF
ENDFOR

****************************************************
* Remove the Setup.prg command from Config.fpw
lcM = FILETOSTR(HOME(0)+"Config.fpw")
lcT = STREXTRACT(lcM, [Command=DO "] , ["] ,1,5)
IF "setup.prg"$LOWER(lcT)
	STRTOFILE(STRTRAN(lcM,lcT,""),HOME(0)+"Config.fpw")
ENDIF
****************************************************
* Copy File
PROCEDURE Setup_Copy
LPARAMETERS tcF
IF FILE(pcP2+tcF)
	TRY
		Copy FILE  (pcP2+tcF) TO (pcP1+tcF)
	CATCH
		? tcF + "¿½±´Ê§°Ü"
	ENDTRY
ENDIF
