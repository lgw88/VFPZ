clear all
clear program

* Find the relative path to the files in the ReportBuilder source folder.

lcSource = home() + 'Tools\XSource\VFPSource\ReportBuilder\'
lcPath   = sys(2014, lcSource, 'FRXTabs.vcx')

* Fix the path for the include file in FRXTabs.H

lcCode = filetostr('FRXTabs.H')
lcLine = strextract(lcCode, '', chr(13))
lcCode = strtran(lcCode, lcLine, "#include '" + lcSource + "FRXBuilder.H'")
strtofile(lcCode, 'FRXTabs.H')

* Fix the paths for class libraries and include files in FRXTabs.VCX.

use FRXTabs.VCX
replace CLASSLOC with lower(forcepath(CLASSLOC, lcPath)) ;
	for not empty(CLASSLOC) and not 'frxtabs.vcx' $ CLASSLOC
use
compile classlib FRXTabs
