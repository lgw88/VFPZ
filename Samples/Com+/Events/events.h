
* ==============================
* Strings
* ==============================
#DEFINE CRLF 			CHR(13) + CHR(10)
#DEFINE NOLOGFILE_LOC	"No log file available."
#DEFINE RUNFROMBOOKSLONLY_LOC	"This form must be run from BOOKS.SCX form."
#DEFINE BADNEWBOOK_LOC	"You must enter book title or valid price."
#DEFINE PROCESS_LOC		"Please be patient while processing order..."
#DEFINE SETUPTCE_LOC	"You do not have Transient Events installed. Would you like to run form to do this?"
#DEFINE NODLL_LOC		"The foxbook_pub.dll file does not appear to exist. Please build DLL from foxbook_pub project."


* ==============================
* Persistent Event Constants
* ==============================
#DEFINE LOGFILE 		"c:\booksub1.txt"


* ==============================
* Transient Event Constants
* ==============================
#DEFINE BOOKTYPELIB		"foxbook_pub.dll"

** Any arbitrary ProgID and CLSID that Event system creates for triggering events
#DEFINE PUBPROGID		"Books.Publisher"
#DEFINE EVENTCLSID		"{599F3071-384E-11D2-871F-00C04F990088}"
#DEFINE SUBSCRIBEID		"{A2800FBC-3D33-11d2-8722-00C04F990089}"
