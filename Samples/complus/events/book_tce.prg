#INCLUDE events.h

DEFINE CLASS MyBooks AS Custom

	IMPLEMENTS Ibookpub IN foxbook_pub.bookpub

	PROCEDURE Ibookpub_NewBook(cBookName AS string, nPrice AS currency)
		STRTOFILE(TRANS(DATETIME()) + " (TCE_NewBook) - ";
 			+ cBookName + ", ";
 			+ TRANSFORM(nPrice) + CRLF,;
			LOGFILE,.T.)
	ENDPROC

	PROCEDURE Ibookpub_PriceChange(cBookName AS string, nPrice AS currency)
		STRTOFILE(TRANS(DATETIME()) + " (TCE_PriceChange) - ";
 			+ cBookName + ", ";
 			+ TRANSFORM(nPrice) + CRLF,;
			LOGFILE,.T.)
	ENDPROC

  	PROCEDURE Error(p1,p2,p3)
    	ACTIVATE SCREEN
  		? "Error"
  	ENDPROC
  		
	PROCEDURE InstallSubscription
    	oEventSys = CreateObject("EventSystem.EventSystem")
    	oEventSub = CreateObject("EventSystem.Eventsubscription")

    	* Subscription identifier
    	oEventSub.SubscriptionID=SUBSCRIBEID 
    	oEventSub.SubscriptionName="MyTCESubscription"
          
    	* Event class to subscribe to
    	oEventSub.EventClassID = EVENTCLSID 
    	oEventSub.SubscriberInterface = THIS

    	* Method of the interface to subscribe
    	oEventSub.MethodName = "PriceChange"
    	
		* Store the subscriber into the event system
		oEventSys.Store("EventSystem.EventSubscription",oEventSub)
	ENDPROC

	PROCEDURE UnInstallSubscription
		LOCAL oEventSys,lerrorIndex
		lerrorIndex=0
		oEventSys = CreateObject("EventSystem.EventSystem.1")
		oEventSys.Remove("EventSystem.EventSubscription","SubscriptionID="+SUBSCRIBEID,lerrorIndex)
	ENDPROC
	
ENDDEFINE