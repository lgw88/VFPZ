# ClassBrowserX

ClassBrowserX is an improvement to the normal VFP Class Browser (you use ClassBrowserX instead of VFP Class Browser). ClassBrowserX makes a working PRG (or HTML) from every form, class or project. Instead of using the normal Class Browser that generates only a content (or list) of each form, class or project as a PRG form, ClassBrowserX generates a working PRG that works exactly the same as the original form, class, or project.

At the moment ClassBrowserX has one significant deficiency: it can’t recognize all ActiveX controls from the form (class, project).

ClassBrowserX recognizes an ActiveX control from an original object (form, class, or project) so that its CLSID value is read (decrypted) from a binary OLE field and then based on that CLSID value, its OleClass value (like MSComctlLib.ListViewCtrl.2 ) is read from the Windows registry and used in the generated PRG code.

The problem is how to find an offset of where to find the CLSID value from the OLE field. Through trial and error I’ve figure out tree offsets for where to find the CLSID value but there are some (lots?) of ActiveX controls that don’t have CLSID values at those offsets. If you know how to read a binary formed OLE field from a form, class or project file, then you can help finalize ClassBrowserX for the Fox Community!

This source code is under the MS license. Please read the BrowserX_License.txt

## How to?

A) If you want to overwrite BROWSER.APP

Rename BrowserX.app to Browser.app and add it to the VFP HOME() directory

OR

B) If you don't want to overwrite old BROWSER.APP
- either copy BrowserX.app to the VFP HOME() directory and start VFP then from menu 
  Tools | Options | File Locations | Change Class Browser file type to point BrowserX.app
- or 
	* make a new directory f.ex under the VFP HOME() directory like BrowserX
	* copy this BrowserX.APP to that directory
	* Start Tools | Options | File Locations from the VFP MENU
	* change Class Browser file locations to point above BrowserX directory 
                 * and to BrowserX.app

Then you may exit and start VFP again and start using ClassBrowserX

## Help text from the BrowserX.PRG

The "mode" determines how BrowserX.prg works. By default, it behaves the same as the native Class Browser. However, you can hold down a combination of the Shift, Ctrl, and Alt keys when clicking the Export button to set the mode:

* 1 = SHIFT
* 2 = CTRL
* 4 = ALT

So, holding down Shift and Ctrl would be mode 3.

Here are the settings:

* 0 = Old MS way. Doesn't support controls in container which is inside of another container. No dataenvironment support.

* NEW MODES 2, 3, 4 and 5:
    * Controls in container are supported. 
    * Methods are supported.
    * ActiveXs are suported (Imagelist is still problem child)
    * Dataenvironment is supported
    * Right mouse click works also with all new modes.
    * Few bugs fixed (see the following code)

* 2 = If class contains controls OR method code (VFP base or subclassed), or even no method or subcontrols it is always subclassed.
    * Properties and method codes are added to the DEFINE CLASS...ENDDEFINE. All subcontrols are also subclassed
    * Controls that cannot be defined WITH ADD OBJECT are defined PARENT OBJECT m.lcInitName method. m.lcInitName is usually "init" (these bad behaving objects are Pageframes (Pages) and grids (columns and headers). These objects are defined in m.lcAddInitContainers.
    * Mode 2 is launched when Ctrl is down and "view class code" button is clicked.

* 3 = Same as 2 but Controls that cannot be defined WITH ADD OBJECT are defined between oForm1.NEWOBJECT - oForm1.SHOW(). Mode 3 is launched when Shift + Ctrl is down and "view class code" button is clicked.
 
    * 14/02/2006 modes 4 and 5 redefined.

* 4 = If class contains controls OR method code (VFP base or subclass), it is subclassed. Method code is added to the DEFINE CLASS...ENDDEFINE
    * All controls are subclassed except those which haven't methods or subcontrols (empty containers). Controls that cannot be defined WITH ADD OBJECT are defined PARENT OBJECT m.lcInitName method m.lcInitName is usually "init" (these bad behaving objects are  Pageframes (Pages) and grids (columns and headers). These objects are defined in m.lcAddInitContainers.

    * Mode 4 is launched when Alt is down and "view class code" button is clicked.

* 5 = Same as 4 but Controls that cannot be defined WITH ADD OBJECT are defined between oForm1.NEWOBJECT - oForm1.SHOW()
    * Mode5 is launched when Shift + ALt is down and "view class code" button is clicked.

Arto Toikka
ID 445262
09.00.0000.3504

P.S. This works also with VFP8 and can be made to work with earlier VFP versions too.
If you are interested to use it with VFP7 or earlier please search for the text VFP6 VFP6 VFP6 from the browser.prg