#include "import.h"

* This is the stub which you should copy (place the modified version in
* your Wizard's directory), rename, and modify to call your wizard.

parameters cOutFileVarName, p2, p3, p4, p5, p6, p7, p8, p9

if .not. C_DEBUG
	release window trace
	release window debug
endif

private cClassLib

m.cClassLib = set('classlib')

* Modify here to reference your wizard's .vcx.
set classlib to import

public oWizard

* The name "oWizard" is used in automated testing and should *NOT* be changed.

oWizard = createobj('ImportWizard', m.cOutFileVarName, m.p2, m.p3, m.p4, ;
	m.p5, m.p6, m.p7, m.p8, m.p9)

if type('oWizard') = 'O' .and. .not. isnull(oWizard)
	oEngine.aEnvironment[17,1] = m.cClassLib
	oWizard.Show
endif
if type('oWizard') = 'O' .and. .not. isnull(oWizard)
	* It must be modeless, so leave it alone
else
	release oWizard
endif

*- make sure classes are removed from memory
CLEAR CLASS importWizard
CLEAR CLASS wiztemplate

RETURN