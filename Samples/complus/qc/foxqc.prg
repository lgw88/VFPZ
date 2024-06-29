#INCLUDE foxqc.h

DEFINE CLASS pizza AS session OLEPUBLIC

PROTECTED cOutputString
cOutputString=""
Toppings = ""
Toppings_COMATTRIB = 0x200000

PROCEDURE OrderPizza(cCustomer AS string, nOrdAmount AS long) AS VOID
LOCAL lcStr
TEXT TO lcStr TEXTMERGE NOSHOW
Thank you for your Pizza Order!
	Order: <<THIS.Toppings>>
	Customer: <<cCustomer>>
	Ammount: <<TRANSFORM(nOrdAmount,"@$99.99")>>
ENDTEXT
THIS.cOutputString = lcStr
ENDPROC

PROCEDURE OutputTxtFile() AS VOID
	STRTOFILE(THIS.cOutputString,OUTPUTFILE,.T.)
ENDPROC

PROCEDURE mydocmd(cCmd as string) AS VOID
	&cCmd
ENDPROC

PROCEDURE ERROR(nError, cMethod, nLine)
LOCAL lcStr
TEXT TO lcStr TEXTMERGE NOSHOW
Error in QC Test Client...
 Error: <<TRANSFORM(nError)>>
 Method: <<TRANSFORM(cMethod)>>
 Line: <<TRANSFORM(nLine)>>
 Message: <<TRANSFORM(MESSAGE())>>
ENDTEXT
STRTOFILE(lcStr+CRLF,ERRLOGFILE,.T.)
RETURN
ENDPROC

ENDDEFINE