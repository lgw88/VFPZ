
DEFINE CLASS bookpub AS session OLEPUBLIC

	PROCEDURE NewBook(cBookName AS string, nPrice AS currency)
	ENDPROC

	PROCEDURE PriceChange(cBookName AS string, nPrice AS currency)
	ENDPROC

ENDDEFINE