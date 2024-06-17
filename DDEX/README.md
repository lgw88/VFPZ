# DDEX for VFP
This is the Visual FoxPro DDEX (Data Designer EXtension) Provider for Visual Studio 2005.

DDEX allows Visual Studio to work better with Visual FoxPro data sources. It exposes VFP metadata to the data designers within Visual Studio, thus enabling common design tasks like dragging and dropping tables from Server Explorer to Visual Studio designers. Before using, the DDEXProvider must be installed. DDEX requires Visual Studio 2005 to be installed. Note that it does NOT work with Visual Studio 2008 or later versions, although it does come with source code so that could be changed.

The version released with Sedna included a license key that expired in March 2008, meaning you couldn't use it if you installed it after that date. On March 4, 2009, Microsoft released an updated version that has a non-expiring license key. This version also simplifies installation.

After installing this updated version, you must run RegDDEX to register the VFP DDEX Provider with Visual Studio 2005.

**NOTE:** RegDDEX must be run as an Adminstrator. Start the Windows Command Prompt as Administrator.

To register the DDEXProvider:

*  Change the folder to 'DDEXProvider' under the Sedna folder

*  Run RegDDEX

To unregister the DDEXProvider

*  Change the folder to 'DDEXProvider' under the Sedna folder

*  Run RegDDEX /u

Once registered, Visual FoxPro will appear as one of the data source types that can be selected in the Connection Dialog of Visual Studio.

DDEX for VFP is part of [Sedna](https://github.com/VFPX/Sedna), a collection of libraries, samples and add-ons to Visual FoxPro 9.0 SP2.
