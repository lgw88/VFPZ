# My for VFP

**Project Manager**: [Doug Hennig](mailto:dhennig@stonefield.com)

The My library for Visual FoxPro exposes commonly used functionality in a hierarchy that is easy to discover and navigate. Its concept is based on the My namespace in VB.NET.

To install My into Visual FoxPro:

*  Browse to the My folder

*  Run MY.APP

The My folder contains a help file, My.chm, that describes setup and usage of My and includes the reference for the different APIs.

Learn more about My in this Code Magazine article by Doug Hennig:
[http://www.code-magazine.com/Article.aspx?quickid=0703082](http://www.code-magazine.com/Article.aspx?quickid=0703082)

My is part of [Sedna](https://github.com/VFPX/Sedna), a collection of libraries, samples and add-ons to Visual FoxPro 9.0 SP2.

**2015.01.23 Release**  
The following issues were fixed:

* Settings.Load no longer strips leading and trailing spaces from string settings

* My now works properly when SET ANSI is ON

* The Destroy methods of various classes no longer clear any Windows API functions they declare to prevent problems with other classes that also use those functions (thanks to Rick Borup for reporting this issue)

**2011.04.14 Release**  
The following issues were fixed:

* MyBuilderForm: fixed typo in TooltipText for edtList, added TooltipText to edtScript, Init now finds a record for a class without cNameSpace property and not always create a blank cursor

* MyFoxCode: OpenMyTable saves the setting of DELETED and turns it ON, Destroy restores the setting of DELETED

* InstallMy.PRG: GetScriptCode uses SYS(16,1) rather than SYS(16) so it works correctly when called from an app

* Settings: Load and Save now handle date and datetime values as well as empty strings or those greater than 254 bytes long, Add throws an error if the specified property name isn't valid

