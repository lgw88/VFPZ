rem First unregister
C:\Windows\Microsoft.NET\Framework\v2.0.50727\regasm.exe "C:\Program Files\Microsoft Visual FoxPro 9\Sedna\VistaDialogs4COM\VistaDialogs4COM.dll" /u

rem Now re-register to generate TLB
C:\Windows\Microsoft.NET\Framework\v2.0.50727\regasm.exe "C:\Program Files\Microsoft Visual FoxPro 9\Sedna\VistaDialogs4COM\VistaDialogs4COM.dll" /codebase /tlb

pause
