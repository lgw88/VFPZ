SET SAFETY OFF

CREATE CURSOR Tmp (ID I autoinc , Txt C(10))
insert into Tmp (Txt) Values ("1234")
insert into Tmp (Txt) Values ("2345")
insert into Tmp (Txt) Values ("3456")

lcR = SYS(2023)+"Tmp"
CREATE REPORT (lcR) FROM Tmp

lcTmp = "FAX"
SET PRINTER TO NAME &lcTmp
REPORT FORM (lcR) TO PRINTER

lcTmp = ["OKi 5560SC"]
SET PRINTER TO NAME &lcTmp
REPORT FORM (lcR) TO PRINTER

