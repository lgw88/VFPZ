all :   clean foxisapi.dll

foxisapi.dll :
	@set INCLUDE=$(INCLUDE);$(MSVCDIR)\INCLUDE;$(MSVCDIR)\ATL\INCLUDE;$(MSVCDIR)\MFC\INCLUDE;$(PRODLOC)\include;$(PRODLOC)\import\x86\include;$(PATH_H);$(PATH_GENH);$(PRODLOC)\include;$(PRODLOC)\import\include\w32
	@set LIB=$(LIB);$(MSVCDIR)\LIB;$(MSVCDIR)\MFC\LIB;$(PRODLOC);$(PRODLOC)\import\lib\w32;$(MSVCDIR)\ATLMFC\lib
	$(MAKE) /nologo /f foxisapi.mak "CFG=foxisapi - Win32 Release"


clean :
	$(MAKE) /nologo /f foxisapi.mak clean "CFG=foxisapi - Win32 Release"

