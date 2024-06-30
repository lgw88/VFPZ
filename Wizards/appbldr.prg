* appbldr.prg
LPARAMETER p1,p2,p3,p4,p5,p6,p7,p8,p9
LOCAL loProj, loBldr, lcExt

* Get object reference to Project Hook class if any
IF TYPE("_VFP.ACTIVEPROJECT") = "O"
	loProj = _VFP.ACTIVEPROJECT.ProjectHook
ENDIF


* If you are using an Application Framework other than the standard Visual FoxPro one, 
* you can add your own program below to specify your own custom Application Builder. An
* example is included for use with sample Microsoft Transaction Server project hook 
* available from the VFP web site.

DO CASE
CASE VARTYPE(loProj) # "O"
	* No associated Project Hook class
	DO FORM (HOME()+"WIZARDS\APPBLDR.SCX") WITH p1,p2,p3,p4,p5,p6,p7,p8,p9
CASE TYPE("loProj.cBuilder")="C" AND FILE(loProj.cBuilder)
	* Builder is specified with Project Hook custom property cBuilder
	lcExt = UPPER(JUSTEXT(loProj.cBuilder))
	DO CASE
	CASE lcExt = "SCX"
		DO FORM (loProj.cBuilder) WITH p1,p2,p3,p4,p5,p6,p7,p8,p9
	CASE INLIST(lcExt,"PRG","APP","EXE","FXP")
		DO (loProj.cBuilder) WITH p1,p2,p3,p4,p5,p6,p7,p8,p9
	OTHERWISE
		* Default Project Builder
		DO FORM (HOME()+"WIZARDS\APPBLDR.SCX") WITH p1,p2,p3,p4,p5,p6,p7,p8,p9	
	ENDCASE
CASE ATC("MTSADMIN",loProj.Class)#0
	* Using special MTS Project Hook class
	loBldr = NewObject("AddPackage",HOME()+"WIZARDS\MTSADMIN.VCX")
	IF VARTYPE(loBldr)="O"
		loBldr.Show()
	ENDIF
OTHERWISE
	* Default Project Builder
	DO FORM (HOME()+"WIZARDS\APPBLDR.SCX") WITH p1,p2,p3,p4,p5,p6,p7,p8,p9
ENDCASE
