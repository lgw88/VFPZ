#INCLUDE foxqc.h

* Call Queued Component
LOCAL lcOrder,lcCat,t1
DELETE FILE OUTPUTFILE
lcCat = CreateObject("COMAdmin.COMAdminCatalog")
lcCat.Connect(QC_MACHINE)
lcCat.StartApplication(FOXQC_APP)
* lcOrder = NewObject("Foxqc.Pizza")
lcOrder = GetObject("queue:/new:FoxQC.Pizza")
lcOrder.Toppings = "Mushrooms, Onions, and Pepperoni"
lcOrder.OrderPizza("Fred Jones",13.95)
lcOrder.OutputTxtFile()
lcCat.ShutdownApplication(FOXQC_APP)
RELEASE lcCat,lcOrder

* Note: there may be a short delay since call is
* made asynchronously.
T1 = SECONDS()
DO WHILE !FILE(OUTPUTFILE)
	INKEY(1)
	IF SECONDS()-t1 > 10
		* likely something failed
		RETURN
	ENDIF
ENDDO
MODIFY FILE OUTPUTFILE
