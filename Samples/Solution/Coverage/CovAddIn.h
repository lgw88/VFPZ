* covaddin.h
*Defines
#DEFINE CR CHR(13)+CHR(10)
#DEFINE COV_CLASS_TO_INSTANCE "cov_standard"
#DEFINE COV_CLASS_CLASSLIB "COVERAGE.VCX"
#DEFINE CAPPFILE HOME()+'coverage.app'


******************
#DEFINE	_CODE	1
#DEFINE	_HITS	2
#DEFINE	_FIRST	3
#DEFINE	_AVG	4
#DEFINE	_TOTAL	5
#DEFINE	_SOURCE	6
#DEFINE	_LINE	7
#DEFINE	_METHOD	8
#DEFINE	_CLASS	9
#DEFINE	_FILETYPE	10
#DEFINE	_PLINE	11

*error message defines

#DEFINE FIELD_SRC	"Select a field to search on"
#DEFINE	COULD_NOT_OPEN_OPEN	"Could not open file. Would you like to open yourself?"
#DEFINE PROBLEM_LOG_EXIT	"There was a problem loading the log-Exiting!"
#DEFINE	NOT_VALID_LOG	"This is not a valid Coverage Profile log"
#DEFINE COULD_NOT_OPEN_PROF	"Could not open the Coverage Profiler!-Exiting"
#DEFINE	FILE_NOT_EXIST	"File does not exist-returning"
#DEFINE	CANCELING	"Canceling"
#DEFINE	CANCELING_BAD_LOG	"Could not open the Coverage Profiler!"+CR+"If previous error was for no usable records, "+CR+"run the Coverage Profiler and run this as an addin."+CR+"Exiting"
#DEFINE 	MISSING_COV		"Missing file covaddin.vcx-It must me in the same directory as covperfaddinfs.scx-Exiting!"
#DEFINE	BAD_DBF		"This is not a valid saved coverage performance log! Exiting"
#DEFINE 	NO_LOCATE_FILE		"Can not find the passed in file!-Exiting"
#DEFINE	FILE_IN_USE		"Unable to open-FIle is in use!"
#DEFINE	COVERAGE_STARTED	"Coverage logging started"
#DEFINE	NOT_FOUND	"Not found!"
#DEFINE	DELETE_ITEM	"Remove this filter item?"
#DEFINE	DELETE_ITEM_TITLE	"Delete filter items from list"
#DEFINE	NO_SKIPPED_FILES 	"No source files were skipped"
#DEFINE	COULD_NOT_FIND_METHOD	"Could not find method"