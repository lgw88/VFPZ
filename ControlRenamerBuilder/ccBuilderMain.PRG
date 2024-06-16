*==============================================================================
* Program:				CCBUILDERMAIN.PRG
* Purpose:				Register Control Renamer Builder
* Copyright:			(c) 2005 Tamar E. Granor, Ph.D.
* Last revision:		05/02/05
* Notes:				You may freely distribute this builder
*                       as long as this header is retained.
*==============================================================================
* Main program for Control Renamer Builder

* Accept parameters passed by the builder system
LPARAMETERS uP1, uP2, uP3, uP4, uP5, uP6, ;
            uP7, uP8, uP9, uP10, uP11, uP12
           
#DEFINE ccMain	"CCBUILDERMAIN"

LOCAL nOldSelect

* Self-register if called directly
IF PROGRAM(0) = ccMain
	nOldSelect = SELECT()
	SELECT 0
	USE HOME() + "Wizards\Builder" AGAIN
	LOCATE FOR Name = "Control Renamer Builder"
	IF NOT FOUND()
		m.Name = "Control Renamer Builder"
		m.Descript = "Change the names of controls"
		m.Type = "ALL"
		m.Program = SYS(16)
		INSERT INTO Builder FROM MEMVAR 
	ENDIF
	USE IN Builder
	SELECT (nOldSelect)
ENDIF

* Run the builder
DO FORM ADDBS(JUSTPATH(SYS(16))) + "RenameControls"

RETURN
