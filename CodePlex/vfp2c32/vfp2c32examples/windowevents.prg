#INCLUDE vfp2c.h

&& BindEventsEx/UnBindEventsEx
&& prerequisites: InitVFP2C32 must have been called with the VFP2C_INIT_CALLBACK flag set
CD (FULLPATH(JUSTPATH(SYS(16))))

SET PROCEDURE TO windowevents ADDITIVE
SET LIBRARY TO vfp2c32.fll ADDITIVE

INITVFP2C32(VFP2C_INIT_CALLBACK)

&& BINDEVENTSEX - extended BINDEVENTS to bind some VFP function to a window message
&& BindEventsEx almost behaves exactly as BINDEVENTS does, the differences are:
&& 1. it returns the pointer to the original window procedure instead of 
&& no meaningful value (so you don't have to call GetWindowLong(yourHwnd,GWL_WNDPROC) )
&& 2. you don't have to bind the message to an object method .. it can also be a public
&& function/procedure
&& 3. you don't have to call CallWindowProc by default, CallWindowProc is automatically called
&& with the original parameters before/after your function is called back
&& this behaviour is controllable through the nFlags parameter
&& 4. you can specify exactly what parameters should be send to your callback function/method
&& and how they should be marshaled
&& 5. you cannot use 0 as the hWnd like in BINDEVENTS to bind to all windows

IF TYPE('loObj') = 'U'

	LOCAL lnProc
	&& bind message to a public function, and pass no parameters to it (lParam & wParam have no meaning for this message anyway)
	lnProc = BINDEVENTSEX(_VFP.hWnd,WM_TIMECHANGE,NULL,'TimeChangeEvent','')
	
	PUBLIC loObj
	loObj = CREATEOBJECT('oApp')
	
ELSE

	UNBINDEVENTSEX(_VFP.hWnd,WM_TIMECHANGE)	
	RELEASE loObj
	
ENDIF

&& to emulate callbacks on an object the 
&& library has to make a copy of the object into a public variable
&& the name of the variable is auto generated by the following scheme:
&& lcVarName = "__VFP2C_WCBO" + IIF(BITAND(nFlags,BINDEVENTSEX_CLASSPROC)>0,"1","0") + "_" + STR(hwnd) + "_" + STR(message)
&& this workaround is necessary cause
&& the FoxPro LCK doesn't provide an API to call functions on an object.
&& don't ask my why such an essential function is not provided .. :(
&& the variable is automatically released when you unbind the message
&& although a copy of the object is made the internal object reference count is not incremented
&& so the public copy doesn't affect your object's lifetime (scope)
&& DISPLAY MEMORY LIKE __VFP2C_WCBO*
&& the only thing you have to consider is that your own variables doesn't conflict with the above naming scheme
&& which is very unlikely.

FUNCTION TimeChangeEvent
	? "Time changed"
ENDFUNC

DEFINE CLASS oApp AS Custom

	nWndProc = 0
	bMenuOpen = .F.

	FUNCTION Init
		DECLARE INTEGER CallWindowProc IN user32.dll INTEGER, INTEGER, INTEGER, INTEGER, INTEGER
		BINDEVENTSEX(_VFP.hWnd,WM_ACTIVATE,THIS,'AppFocusChanged','BOOL(wParam)')
		BINDEVENTSEX(_VFP.hWnd,WM_DEVICECHANGE,THIS,'DeviceChanged','wParam,lParam')
		THIS.nWndProc = BINDEVENTSEX(_VFP.hWnd,WM_APPCOMMAND,THIS,'AppCommand',NULL,BINDEVENTSEX_RETURN_VALUE)
		BINDEVENTSEX(_VFP.hWnd,WM_ENTERMENULOOP,THIS,'OnEnterMenu','BOOL(wParam)')
		BINDEVENTSEX(_VFP.hWnd,WM_EXITMENULOOP,THIS,'OnExitMenu','BOOL(wParam)')
	ENDFUNC
	
	FUNCTION Destroy
		&& unbind events from the window
		UNBINDEVENTSEX(_VFP.hWnd,WM_ACTIVATE)
		UNBINDEVENTSEX(_VFP.hWnd,WM_DEVICECHANGE)
		UNBINDEVENTSEX(_VFP.hWnd,WM_APPCOMMAND)
		UNBINDEVENTSEX(_VFP.hWnd,WM_ENTERMENULOOP)
		UNBINDEVENTSEX(_VFP.hWnd,WM_EXITMENULOOP)
	ENDFUNC

	FUNCTION AppFocusChanged(bFocus)
		IF bFocus
			? "App received focus"
		ELSE
			? "App lost focus"
		ENDIF
	ENDFUNC

	FUNCTION DeviceChanged(wParam,lParam)
	
	ENDFUNC
	
	FUNCTION AppCommand(hHwnd, uMsg, wParam, lParam)
		RETURN CallWindowProc(THIS.nWndProc,hHwnd,uMsg,wParam,lParam)
	ENDFUNC
	
	FUNCTION OnEnterMenu(bPopup)
		THIS.bMenuOpen = .T.
	ENDFUNC

	FUNCTION OnExitMenu(bPopup)
		THIS.bMenuOpen = .F.
	ENDFUNC
	
ENDDEFINE