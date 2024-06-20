*-- This program instantiates a Report Listener.
*--
*-- It uses the Listener classes found in the _ReportListener class library
*-- which is located in VFP's FFC directory.
*-- 
*-- If you have a set of your own Report Listeners, just modify this code to run
*-- YOUR Report Listeners instead of the FFC versions.
*--
*-- Be sure to include the FFC\_ReportListener class library (or your own) in the project.

LPARAMETERS tnType, toListener

LOCAL	lcClass

DO CASE 

	CASE INLIST(m.tnType, 0, 1, 2, 3)
		*-- 0=Print
		*-- 1=Preview
		*-- 2=Render Page by Page (no output)
		*-- 3=Render all Pages at once (no output)
		m.lcClass= 'FXListener'

	CASE m.tnType = 4 && XML
		m.lcClass= 'XMLListener'

	CASE m.tnType = 5 && HTML
		m.lcClass= 'HTMLListener'

	OTHERWISE && Just use the base listener
		lcClass = ''

ENDCASE

IF EMPTY(m.lcClass)
	toListener = CREATEOBJECT('ReportListener')
ELSE
	toListener = NEWOBJECT(m.lcClass, HOME() + 'FFC\_ReportListener')
ENDIF 
toListener.ListenerType = m.tnType
