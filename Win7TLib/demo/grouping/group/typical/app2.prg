SET PATH TO ..\..\..\resources
_VFP.Visible = .T.
ON SHUTDOWN CLEAR EVENTS

DO exit.mpr

_SCREEN.FontSize = 32
?"I am Application #2"
?JUSTFNAME(SYS(16,0))

READ EVENTS

ON SHUTDOWN

IF _VFP.StartMode = 0
	SET SYSMENU TO DEFAULT
ENDIF
