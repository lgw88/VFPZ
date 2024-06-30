# VistaDialogs4COM

The VistaDialogs4COM is a collection of COM-visible classes that wrap the functionality provided by the Microsoft VistaBridgeLibrary. VistaDialogs4COM provides Visual FoxPro developers access to the Windows Vista TaskDialog and Common Dialogs.

A sample VFP project demonstrating use of different features of VistaDialogs4COM is also included.

The VistaDialogs4COM folder contains the following:

* VistaDialogs4COM.dll: DLL for the COM components that wrap VistaBridgeLibrary.

* VistaDialogs4COM: Folder containing the VB.NET source code for VistaDialogs4COM

* VFP Sample: Folder containing a VFP sample project that illustrates the use VistaDialogs4COM

A few additional notes on VistaDialogs4COM:

* VistaLibrary4COM requires Windows Vista. The API used are not available on earlier versions of Windows. The VFP Sample folder contains images that show the different dialogs and how they differ from the corresponding dialogs in earlier versions.

* Register.BAT registers VistaDialogs4COM. Edit the paths in Register.BAT as necessary. Also note that you must run Register.BAT as administrator (right-click the file and choose Run as Administrator) since registering COM components requires administrative privileges.

VistaDialogs4COM is part of [Sedna](https://github.com/VFPX/Sedna), a collection of libraries, samples and add-ons to Visual FoxPro 9.0 SP2.