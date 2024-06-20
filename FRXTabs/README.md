# FRXTabs
**Data-Driven Extension for VFP Report Designer**

Project Manager: [Doug Hennig](mailto:dhennig@stonefield.com)

The VFP Report Designer can be extended by adding new tabs to existing dialogs without modifying any source code; this is done by adding “T” records to the report registry table. However, the only way to make changes to existing tabs is to modify the source and rebuild ReportBuilder.APP.

FRXTabs provides a data-driven mechanism to define each tab in each dialog at runtime. To change a tab, simply subclass the existing one, make any desired changes, and change the record in the registry table to specify the subclass rather than the original. No changes are required to ReportBuilder.APP.

## Using FRXTabs

To use FRXTabs, download it from the downloads page and unzip it into any folder. FRXTabs consists of FRXTabs.VCX/VCT, which contains all of the replacement dialog and tab classes; FRXTabBuilder.DBF/FPT, which is a modified report registry table that specifies FRXTabHandlerForm, a generic dialog included in FRXTabs.VCX, as the handler for most events and has the “T” records that define the pages for every dialog; FRXTabs.H, an #INCLUDE file used by some of the FRXTabs classes; and FixPaths.PRG, discussed next.

Before using FRXTabs, you need to ensure that the paths it uses internally (specifically, the location of the ReportBuilder source code files) are correct for your system. To do so, simply DO FIXPATHS.PRG.

To use FRXTabs as is without doing any customization, use this from the Command window or in your applications:

    do (_reportbuilder) with 3, "FRXTabBuilder.DBF"

However, the real advantage of FRXTabs is the ability to customize the dialogs as you see fit. For example, if you never use the “SET DATE format” and “British date” options in the Format page of the text box properties dialog, wouldn’t it be nice to get rid of them? With FRXTabs, it’s really easy:

* Subclass TabFieldFormat, the class used for the Format page. Let’s call the subclass MyFieldFormat in MyFRXTabs.VCX.
* In MyFieldFormat, set chkSetDate.Visible and chkBritishDate.Visible to .F. Note that there are several copies of those two checkboxes but you can’t see them because the containers in the class are sized quite narrow. You’ll have to find the controls in the Properties window. You may also want to move some other controls to account for the empty space of these two invisible controls.
* Edit the “T” record that has HNDLCLASS = “TabFieldFormat”, setting HNDLCLASS to “MyFieldFormat” and HNDLLIB to “MyFRXTabs.VCX”.
