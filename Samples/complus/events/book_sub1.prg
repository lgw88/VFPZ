#INCLUDE events.h

DEFINE CLASS booksub1 AS session OLEPUBLIC

	IMPLEMENT Ibookpub IN foxbook_pub.bookpub
	
	PROCEDURE Ibookpub_NewBook(cBookName AS string, nPrice AS currency)
		STRTOFILE(TRANS(DATETIME()) + " (" + PROGRAM() + ") - ";
 			+ cBookName + ", ";
 			+ TRANSFORM(nPrice) + CRLF,;
			LOGFILE,.T.)
	ENDPROC

	PROCEDURE Ibookpub_PriceChange(cBookName AS string, nPrice AS currency)
		STRTOFILE(TRANS(DATETIME()) + " (" + PROGRAM() + ") - ";
 			+ cBookName + ", ";
 			+ TRANSFORM(nPrice) + CRLF,;
			LOGFILE,.T.)
	ENDPROC

ENDDEFINE
