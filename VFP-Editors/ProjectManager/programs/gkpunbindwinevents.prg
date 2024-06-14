*-***********************************************************************************************
*-* Unbind Win event bound with BindWinEvent()
*-* Allows multiple bindings for single Win Msg 
*-*
FUNCTION GKPUnbindWinEvents
LPARAMETERS thWnd, tnMessage, toEventHandler, tcDelegate
IF PEMSTATUS(_SCREEN,"oEventHandler",5) AND !ISNULL(_Screen.oEventHandler)
	DO CASE
		CASE PCOUNT() = 1
			_Screen.oEventHandler.UnBindEvents(thWnd)

		CASE PCOUNT() = 3
			_Screen.oEventHandler.UnBindEvents(thWnd, tnMessage)

		OTHERWISE
			_Screen.oEventHandler.UnBindEvents(thWnd, tnMessage, toEventHandler, tcDelegate)
	ENDCASE
ENDIF
ENDFUNC