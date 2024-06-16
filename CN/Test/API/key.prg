LOCAL lnHandle
lnHandle = FindWindow(0,'无标题 - 记事本') 
IF lnHandle = 0
	lnHandle=FindWindow(0,'*无标题 - 记事本') 
	IF lnHandle = 0
		runa("C:\Windows\system32\notepad.exe")
		lnHandle = FindWindow(0,'无标题 - 记事本') 
		IF lnHandle = 0
			RETURN
		ENDIF
	ENDIF
ENDIF
ShowWindow(lnHandle,1) 
SetForegroundWindow(lnHandle) 
Keybd_Event(48 , 0, 0, 0) &&发送键盘0
