
#DEFINE TEST	1
* This is the startup program 

CD JUSTPATH(SYS(16))
olderror=ON("error")
x=1
y=1
USE demo IN 0
USE demochild IN 0
ON ERROR errh()
insert into demochild values("12","12")
insert into demochild values("1","1")
oform=NEWOBJECT('frmotherlib',"demo2.vcx")
REPORT FORM report1 PREVIEW nowait
RELEASE WINDOWS Report Designer 
DO demo.mpr
SET SYSMENU TO default
DO demoquery.qpr

USE IN demo
USE IN demochild

ON ERROR &olderror
FUNCTION errh
WAIT WINDOW MESSAGE() TIMEOUT 1
PROCEDURE sub1
cstr=''
FOR xx=1 TO 100
	cstr=cstr+TRANSFORM(xx)
ENDFOR 
