VFP Component Class ctlTip
==========================
An Improved ToolTip Control
---------------------------
The control supports multiple lines of text, allows the balloon-style display feature, and can be set up to be activated automatically (as in a hover event) or on demand.

![](images/pic1.png)

This component is designed to be self-contained, and not dependent on other external files or components beyond the standard FoxPro and Windows APIs.

My thanks and recognition to Carlos Alloatti, G. Shah, Yousfi Benameur, and Microsoft, from who's posts I've gleaned inspiration and methods.

To use:
 
	1. Drop this control on a form and configure its tipStyle property as desired. One instance can support multiple form controls.
	2. Register form controls to use this tip provider via the RegTool method.  For example, from an Init event:  
		Thisform.ctlTip1.RegTool(Thisform.myTextBox, .F., 0, "Enter a value").

There are a couple of pop-up types supported - "standard" and "demand":

	* Standard tips only display upon MouseEnter/hover of the registered control, like a standard tooltip.  This style utilizes the Windows control's internal methods for showing and hiding and thus might prove more permformant and reliable for general use.
	* Demand style causes the control's FoxPro code to mediate showing and hiding tips.  It provides more flexibility in that tips can be configured for MouseEnter and/or GotFocus, or also upon a "demand" call to the ShowTip method.  Placement location can also be prescribed with this style.

Parameters for the **RegTool** function:

	* toTool	Required. The "tool" (form control) object reference that will be registered with the tool tip.  Note: The tip control will add a "uId" (unique ID) property to this object. You can create and assign your own if you wish, but it needs to contain an integer value.
	* tlDemand	Logical indicating whether to use a "demand" tip type (.T. - yes, .F. - no, standard type)
	* tnTipPosn	Numeric position setting: 0-standard, 1-center, 2-screen coordinates (demand style only)
	* tcText	The tip text.  This can be changed later with a call to setTxt.
	* tcTitle	The tip title (only applies to the balloon display style [tipStyle] property).
	* tnIconId  A numeric icon option (balloon style only): 0-none, 1-info, 2-warning, 3-error. Use 4, 5, or 6, respectively, to show large versions of the icon.
	* tnActOpt	A numeric activation option(for demand types only): 0-mouse enter, 1-focus, 2-both, 3-none, on demand showTip() calls only.
	* tnXPosn	Default screen horizontal pixel position to show the tip (demand type only, with tipPosn=2).
	* tnYPosn	Default screen vertical pixel position to show the tip (demand type only, with tipPosn=2).

Text can be changed by either calling RegTool again, or by using the **SetTxt** function:

	* tTool		Subscribing object reference or its assigned uId.
	* tcText
	* tcTitle (optional)
	* tnIconId (optional)
	
Title and icon (affects balloon style only) can be changed by either calling RegTool again, SetTxt, or **SetTitl**:

	* tTool		Subscribing object reference or its assigned uId.
	* tcTitle
	* tnIconId
	
Demand type tips can be shown via **ShowTip**:

	* toTool	Subscribing object reference or its assigned uId.
	* tlTimeout	(optional) Desired timeout in ms.  0 = no timeout.
	* tnXPosn	(optional) Screen horizontal pixel position.
	* tnYPosn   (optional) Screen vertical pixel position.

See the test form, "ctlTipTest.scx" for examples.

Greg Willcockson 3/2020
