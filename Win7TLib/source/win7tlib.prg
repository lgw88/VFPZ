************************************************************************************
* Windows 7 Taskbar Library for VFP (Win7TLib)
************************************************************************************
* Purpose: To allow full access and integration of all features of the Windows 7
*		   taskbar to the VFP application developer with minimal effort.
*
* Original Author: Steve Ellenoff
* Copyright 2010
* Contact: sellenoff@hotmail.com
*
* NOTE TO PROGRAMMERS: Please follow all coding conventions. If you make any
* changes to the library, please contact me for inclusion into the official 
* source.
*
* 5/10/2010: The project is now a VFPx Project and is subject to it's license.
* Please refer to the included file: vfpx_license.txt for full details or visit
* http://vfpx.codeplex.com/license for the latest copy.
************************************************************************************

*************************************************************************************************************
* 								CODING CONVENTIONS
*************************************************************************************************************
* 1) Keep all code related #DEFINE at the top of the PRG file.
*
* 2) Use #DEFINE within class definitions to help describe methods that are related.
* 	 ( This is only necessary in classes with a lot of methods )
*
* 3) Internal Class Methods & Properties:
* -Must be declared PROTECTED 
* -Must begin with an _ character.
* -Internal Properties should be listed AFTER ALL PUBLIC PROPERTIES
*
* -Internal Methods should be listed BEFORE ALL PUBLIC METHODS
*  	Exceptions are: #4 & #5 below AND if you are using #DEFINE sections, you can 
*   put the internal methods at the top of the section.
*
* -List all protected properties together in one line ( or more if necessary )
* -Put property comments on the initializtion line, not the PROTECTED line
*
* 4) Property Assignment methods should be listed first, before any other methods.
*
* 5) INIT & DESTROY Methods must be listed first and in that order
*    in the class method definitions ( except for 4 above )
* 
* 6) _SETUP & _CLEANUP() must be listed directly after INIT & DESTROY() and in that order.
*
* 7) Please keep consistent headers for all methods.
*
* 8) Comments on properties should use &&, rather than listed above.
*
* 9) All property comments using && should be tabbed to fall in the same vertical line for easier reading.
* 
*10) All classes should include sections where public, internal, and end of properties sections are.
*************************************************************************************************************

****************************************************************************************************************
** NOTES:
****************************************************************************************************************
** THE INFAMOUS MDI/TDI BUG (RIP) **
**
** 8/30/2010 - In the midst of a major rewrite of callback handling, I decided to remove the "redundancy"
** of having both the proxy window classes and the preview class registering for and handling the thumbnail
** and live preview windows messages ( in the _W32API_Message_Handler() methods of those classes respectively.
** Since preview needed the functionality when no proxy window was required ( ie, when mode is not MDI/TDI ), I 
** logically removed the code from the Proxy Window classes, and let the Preview class have the exclusive code
** for this functionality. WHAT A MISTAKE!! During the MDI recode, I would occasionally see that the thumbnail 
** image would no longer draw. Investigating further showed that the Draw Thumbnail message was not being sent
** by WINDOWS!! I could not replicate the problem with any sustained frequency. When the problem did happen, though,
** ALL OF WINDOWS CUSTOM THUMBAIL SUPPORT DIED FOR ALL APPLICATIONS!! Only a reboot, or a Log Off/ Log On, would
** restore the situation.
**
** Thank G-d, that during the TDI recoding, the problem became much more frequent. In fact, at one point, the code
** was so bad, I was getting C5 bombs pretty much every time I exited the application. I found the source of the C5
** and was thrilled to regain a stable shutdown enviroment, but the pesky thumbnail problem remained. Luckily, as I 
** said, it was much easier to replicate, often occuring right after I shutdown the app, and re-ran it, although at
** times, it could occur while the program was still running.. It was like, all of the sudden something justed 
** blew away the windows thumbnail handler internally, and it would no longer ask any applications to provide a image.
** When this would happen, the exe's icon would appear in the thumbnail window.
**
** After 50 grueling hours and lots of thoughts of throwing away the code entirely, I managed to restore law and order
** by realizing that when the Proxy Windows handled the Thumbnail and Live Preview windows messages themselves, everything
** worked fine every time. Restoring the old code base confirmed it. Thus, I restored the handlers to the Proxy Window
** classes, and setup code in the Preview classes to ignore registering for custom drawing when running in Proxy
** situations ( ie, MDI/TDI ). The code has been extremely stable ever since, and boy am I relieved! 


****************************************************************************************************************
** TODO SECTION:
****************************************************************************************************************
*todo: convert evaluate() calls to use get_obj_from_string
*todo: add error handling, and asserts.. there's currently minimal handling atm.
*todo: handle case where user wants to specify an internal icon file for a shelllink - must extract the icon to a temp file, and use that as the setting, rather than what user passes.
*todo: solve or improve MDI custom drawing so that when the window is minimized or clipped it still looks ok.
*	   clipping can be handled so that we obtain the clip region and clip the preview image to it.
*	   minimizing is harder, since it will require trapping when the window ( or it's parent ) is minimized
* 	   and right before, capturing a snapshot and caching it. yuck!

**Win7TLib Defines**
**(These can be changed by the developer to modify library settings)**
#DEFINE WIN7TLIB_USE_DEFINE_FOR_LOCATION	.T.
#DEFINE TBM_DEFAULT_LOCATION				"_VFP.Win7TLib.TaskbarManager"
#DEFINE WIN7TLIB_LIBNAME					"Win7TLIB"

********************************************************
**** 		DO NOT MODIFY THE DEFINITIONS BElOW		****
********************************************************

**Win32API Defines**
#DEFINE GWL_WNDPROC 						-4
#DEFINE WM_COMMAND 							0x111
#DEFINE WM_DWMSENDICONICTHUMBNAIL			0x323
#DEFINE WM_DWMSENDICONICLIVEPREVIEWBITMAP	0x326
#DEFINE WM_SYSCOMMAND						0x112
#DEFINE WM_ACTIVATE							0x06
#DEFINE WM_CLOSE							0x10
#DEFINE GA_ROOT								0x02
#DEFINE THBN_CLICKED						0x1800

**Show Command Values for IShellLink::SetShowCmd Method
#DEFINE SW_SHOWNORMAL       				1
#DEFINE SW_SHOWMAXIMIZED    				3
#DEFINE SW_SHOWMINNOACTIVE  				7

**Other Defines**
#DEFINE MAX_APPID_SIZE						128

************************************************************************************
* Base Windows 7 Taskbar Library Class
************************************************************************************
* Provides common functionality across all objects used in the library
************************************************************************************
DEFINE CLASS Win7TLIB_Base AS Custom
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _lDllLoaded
	_lDllLoaded = .F.					&& Flag to indicate if the Win7TLib dll was loaded	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DEBUGOUT "Destroying Object: " + THIS.Name
	ENDFUNC
	
	***********************************************
	* IsDLL_Loaded
	***********************************************
	* Returns .T. if the Win7TLib.DLL was 
	* successfully loaded. All code that wishes to
	* make a call into the DLL should first check 
	* by calling this function or the property if 
	* the code is internal to the class.
	************************************************
	FUNCTION IsDLL_Loaded()
		RETURN THIS._lDllLoaded
	ENDFUNC

	***********************************************
	* MakeWideString
	***********************************************
	* Converts the passed string into a wide char
	* string suitable for passing to the 
	* Win7TLib DLL since all string functions are
	* expected to be WideChar, while VFP uses
	* Double Byte Chars..
	************************************************
	FUNCTION MakeWideString(tcString)
		RETURN STRCONV(ALLTRIM(tcString)+CHR(0),5)
	ENDFUNC
	
	***********************************************
	* MakeVFPString
	***********************************************
	* Converts a WideString received from the 
	* Win7TLib DLL back into a string suitable for 
	* VFP to handle since all string functions are
	* expected to be WideChar in the DLL, while VFP 
	* uses Double Byte Chars..
	************************************************
	FUNCTION MakeVFPString(tcWString)
		LOCAL lcStr
		*Convert from Wide Char back to double byte char
		lcStr = ALLTRIM(STRCONV(tcWString,6))
		*Remove any CHR(0) left over..
		lcStr = STRTRAN(lcStr,CHR(0),"")
		RETURN lcStr
	ENDFUNC	
	
	***********************************************
	* LoadImage
	***********************************************
	* Attempts to load the given image file 
	* (ico,bmp,jpg,ect..) and returns a picture 
	* object. The Handle property of the image can
	* be used for both VFP internal use and as 
	* passed to the Win7TLib DLL functions.
	*
	* The file name can refer to both an embedded
	* image in the EXE or an external file.
	*
	* Returns NULL if unable to load the image.
	************************************************
	FUNCTION LoadImage(tcFile)
		LOCAL loPic, loEX
		loPic = NULL
		TRY
			*LoadPicture can load both an embedded image or an external file
			loPic = LOADPICTURE(tcFile)
		*Catch error #1, File Not Found
		CATCH TO loEX WHEN loEX.ErrorNo = 1
		ENDTRY
		RETURN loPic
	ENDFUNC
	
	********************************************
	* IsWindows7
	********************************************	
	* Returns .T. if the OS is Windows 7
	********************************************
	FUNCTION IsWindows7()
		*Windows 7 is 6.01
		RETURN VAL(OS(3)) == 6 AND VAL(OS(4)) > 0
	ENDFUNC
	
	************************************************************************************************************************************************************
	* Get_Object_From_StringName()
	************************************************************************************************************************************************************
	* Attempts to return an object reference to the object specified by the given string name.
	* Returns NULL on failure. You can pass an optional base object if the string does not include
	* the base itself.
	*
	* Example #1: loTBM = THIS.Get_Object_From_StringName("_VFP.Win7TLib.TaskBarManager")
	* Example #2: loHelper = THIS.Get_Object_From_StringName("TBHelper",THISFORM)
	************************************************************************************************************************************************************
	FUNCTION Get_Object_From_StringName(tcObj,toBase)
		LOCAL loObj, llError, lcObj
		loObj = NULL
		*Extra safety
		IF EMPTY(tcObj)
			RETURN NULL
		ENDIF
		*Try to get an object from it
		*todo: this try catch doesn't cleanly handle errors like i wanted.
		TRY
			lcObj = IIF(VARTYPE(toBase)="O","toBase.","")+tcObj
			loObj = EVALUATE(lcObj)
			*Catch OLE error code: Unknown Name or Property Not Found
		CATCH TO loEX WHEN loEX.ErrorNo = 1426 OR loEX.ErrorNo = 1734 OR loEX.ErrorNo = 1925
			IF loEX.ErrorNo = 1426
				IF !LEFT(loEX.Details,8)=="80020006"
					THROW loEX
				ENDIF
			ENDIF
		ENDTRY 
		RETURN loObj
	ENDFUNC
	
ENDDEFINE

************************************************************************************
* Windows 7 Taskbar Library List Class
************************************************************************************
* A custom Collection class used to store all lists in the Win7TLib classes
************************************************************************************
DEFINE CLASS Win7TLIB_List AS Collection
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DEBUGOUT "Destroying Object: " + THIS.Name
	ENDFUNC

	****************************************************
	* AddItem
	****************************************************
	* Adds the object to the collection using the given
	* key value which can be numeric or character.
	****************************************************
	FUNCTION AddItem(tKey, toObj)
		LOCAL loEX, lcKey
		lcKey = TRANSFORM(tKey)
		THIS.Add(toObj,lcKey)
	ENDFUNC
	
	***************************************************************
	* RemoveItem
	***************************************************************
	* Removes the Item specified by the given key from
	* the collection. The key value can be numeric or character.
	***************************************************************
	FUNCTION RemoveItem(tKey)
		LOCAL loEX, lcKey
		lcKey = TRANSFORM(tKey)
		* Remove the Item from the collection
		TRY
			THIS.Remove(lcKey)
		*Catch error #2061, item not found in collection
		CATCH TO loEX WHEN loEX.ErrorNo = 2061
		ENDTRY
	ENDFUNC	
	
	***************************************************************
	* ClearList
	***************************************************************
	* Removes all items from the list
	***************************************************************
	FUNCTION ClearList()
		DO WHILE THIS.Count > 0
			THIS.Remove(1)
		ENDDO
	ENDFUNC

	***************************************************************
	* GetItem
	***************************************************************
	* Returns an Object from the List matching the given key.
	* The key value can be numeric or character. NULL is returned
	* if the key does not match any item in the list.
	***************************************************************
	FUNCTION GetItem(tKey)
		LOCAL loEX, lcKey, loObj
		lcKey = TRANSFORM(tKey)
		loObj = NULL
		TRY
			loObj = THIS.Item(lcKey)
		*Catch error #2061, item not found in collection
		CATCH TO loEX WHEN loEX.ErrorNo = 2061
		ENDTRY
		RETURN loObj
	ENDFUNC		
	

	***************************************************************
	* GetItem_FromIndex
	***************************************************************
	* Returns an Object from the List matching a given index.
	* NULL is returned if the index does not match any item 
	* in the list.
	***************************************************************
	FUNCTION GetItem_FromIndex(tnIndex)
		LOCAL loEX, loObj
		loObj = NULL
		TRY
			loObj = THIS.Item(tnIndex)
		*Catch error #2061, item not found in collection
		CATCH TO loEX WHEN loEX.ErrorNo = 2061
		ENDTRY
		RETURN loObj
	ENDFUNC			
ENDDEFINE

**************************************************************************************
* Taskbar_Library_Settings 
**************************************************************************************
* A class used to specify settings for the library. Your application MUST subclass
* this class and name it Win7TLib_Application_Settings. In the subclass you can
* set any custom library settings you need, or simply create an empty class definition
* to use all defaults.
*
* The default Taskbar Manager Location indicates where the Taskbar Manager instance will
* be installed when your app is running. 
* The default value is: _VFP.Win7TLib.TaskbarManager
*
* If you wish to change this, simply set the cTaskManager_Location property in your
* subclass to something else, ie: cTaskbarManager_Location = "_SCREEN.TBM"
***************************************************************************************
DEFINE CLASS Taskbar_Library_Settings AS Win7TLIB_Base
	***********************
 	* PUBLIC PROPERTIES   *
	***********************	
		cAppID = ""											&& Application ID to use when communicating with the Windows 7 Taskbar
		cDLLPath = ""										&& Path to the DLL file. Blank means use the .exe location.
		cDefaultFormMode = "VFP"							&& Default Form Mode for the library.
		cTaskbarManager_Location = TBM_DEFAULT_LOCATION		&& Location where the application will create the taskbar manager.
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************	
	* END OF PROPERTIES   *
	***********************
ENDDEFINE

**************************************************************************************
* Taskbar_Library_Helper 
**************************************************************************************
* A class used to assist in the library
***************************************************************************************
DEFINE CLASS Taskbar_Library_Helper AS Win7TLIB_Base
	***********************
 	* PUBLIC PROPERTIES   *
	***********************	
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************	
	* END OF PROPERTIES   *
	***********************
	
	************************************************************************************************************************************************************
	* _Get_Library_Settings()
	************************************************************************************************************************************************************
	* Returns an object reference to an instance of the library settings class.
	* All applications MUST define the class name: Win7TLib_Application_Settings, as a subclass of
	* Taskbar_Library_Settings since that is the only classname the library will look for when trying to access
	* settings.
	************************************************************************************************************************************************************
	PROTECTED FUNCTION _Get_Library_Settings()
		LOCAL lcSettingsClass, loSettings, loEX
		loSettings = NULL
		lcSettingsClass = "Win7TLib_Application_Settings"
		TRY
			loSettings = CREATEOBJECT(lcSettingsClass)
		*Trap Class Definition Not Found Error
		CATCH TO loEX WHEN loEX.ErrorNo = 1733
		ENDTRY
		RETURN loSettings			
	ENDFUNC	
	
	************************************************************************************************************************************************************
	* _Add_Object_To_Location()
	***********************************************************************************************************************************************************
	* Given a string location, attempts to create all the necesssary objects to create the location, and
	* populate the last object with the passed object.
	*
	* Example of a string location is: "_VFP.Win7TLib.TaskBarManager"
	*
	* The base object, ie the left most object in the string, must exist, only the sub property 
	* object are created. They are created as CUSTOM classes. They are meant to be used simply 
	* as a placeholder. The final property is made equal to the the object passed.
	************************************************************************************************************************************************************
	PROTECTED FUNCTION _Add_Object_To_Location(tcLoc, toObj)
		** Step 1: Grab Base object
		** Step 2: 1st base must exist - bail otherwise.
		** Step 3: If no other properties, we're done.
		** Step 4: Grab next Property
		** Step 5: See if Property exists in the base
		** Step 6: Add it if it does not
		** Step 7: Set property to be the new base
		** Step 8: Go to step 4 until done.
		LOCAL lcLoc, lcBase, loBase, lcProp, loProp
		lcLoc = tcLoc
		*Get the Base
		lnPos = AT(".",lcLoc)
		*Yes - pull the left-most property as the base
		IF lnPos > 0
			lcBase = LEFT(lcLoc,lnPos-1)
			lcLoc = SUBSTR(lcLoc,lnPos+1)
		*No - we've got the last property
		ELSE
			lcBase = lcLoc
			lcLoc = ""
		ENDIF
		*Get the base object
		loBase = THIS.Get_Object_From_StringName(lcBase)
		*No object retrieved, must abort!
		IF ISNULL(loBase)
			RETURN .F.
		ENDIF
		DO WHILE !EMPTY(lcLoc)
			*Do we have any more properties to pull?
			lnPos = AT(".",lcLoc)
			*Yes - pull the left-most property as the base
			IF lnPos > 0
				lcProp = LEFT(lcLoc,lnPos-1)
				lcLoc = SUBSTR(lcLoc,lnPos+1)
			*No - we've got the last property
			ELSE
				lcProp = lcLoc
				lcLoc = ""
			ENDIF
			*Add property to base name
			lcBase = lcBase + IIF(EMPTY(lcProp),"","." + lcProp)
			*See if it exists
			loProp = THIS.Get_Object_From_StringName(lcBase)
			*Add if it does not exist
			IF ISNULL(loProp)
				LOCAL loEX, llFailed
				TRY
					LOCAL loC
					*If we have an object, use it..
					IF EMPTY(lcLoc)
						loC = toObj
					*No object, so create a custom object
					ELSE
						loC = CREATEOBJECT("Custom")
					ENDIF
					*Add the property to the base and set it's value to the object
					DEBUGOUT "Adding Property: " + lcProp + " to " + STRTRAN(lcBase,"."+lcProp,"")
					ADDPROPERTY(loBase,lcProp,loC)
					*Retrieve new property as object
					loProp = THIS.Get_Object_From_StringName(lcBase)
					IF !ISNULL(loProp)
						*Set the Name to match the property
						loProp.Name = lcProp
						*Set custom comment so code knows this object was added by the library
						loProp.comment = WIN7TLIB_LIBNAME
					ELSE
						llFailed = .T.
					ENDIF
				CATCH TO loEX
					llFailed = .T.
				ENDTRY
				IF llFailed
					RETURN .F.
				ENDIF
			ENDIF
			*Set new base & new Base Name
			loBase = loProp
		ENDDO
	ENDFUNC

	************************************************************************************************************************************************************
	* _Destroy_Object_Location()
	************************************************************************************************************************************************************
	* Given a string location, attempts to delete all the objects referenced in the location string.
	* Example of a string location is: "_VFP.Win7TLib.TaskBarManager"
	* It will only delete objects that were added by the Create_Object_Location() call by checking
	* the comments field of the added objects.
	************************************************************************************************************************************************************
	PROTECTED FUNCTION _Remove_Object_From_Location(tcLoc)
		** Step 1: Grab right most property object
		** Step 2: If does not exist we're done
		** Step 3: Remove It if it was custom added
		** Step 4: Repeat to 1 until done
		LOCAL lcLoc, lcBase, loBase, lcProp, loProp, llFailed
		lcLoc = tcLoc
		DO WHILE !EMPTY(lcLoc)
			*Do we have any more properties to pull?
			lnPos = RAT(".",lcLoc)
			*Yes - pull the right-most property as the base
			IF lnPos > 0
				lcProp = RIGHT(lcLoc,LEN(lcLoc)-lnPos)
				lcLoc = LEFT(lcLoc,lnPos-1)
			*No - we're done
			ELSE
				EXIT
			ENDIF
			*Base is the remaining location
			lcBase = lcLoc
			*Grab Base Object reference
			loBase = THIS.Get_Object_From_StringName(lcBase)
			*Add property to base name to get the property
			lcBase = lcBase + IIF(EMPTY(lcProp),"","." + lcProp)
			*Grab Property Object reference
			loProp = THIS.Get_Object_From_StringName(lcBase)
			*Remove it if it exists and was an object we custom added.
			IF !ISNULL(loBase) AND !ISNULL(loProp) AND loProp.Comment == WIN7TLIB_LIBNAME
				LOCAL loEX, llFailed, lcCmd
				*Clear reference since we're now removing the property
				loProp = NULL
				TRY
					*Clear the reference so VFP releases the memory
					lcCmd = lcBase + " = NULL"
					DEBUGOUT lcCmd
					EXECSCRIPT(lcCmd)
					*Remove the Property
					DEBUGOUT "Removing property: " + lcProp + " from " + STRTRAN(lcBase,"."+lcProp,"")
					REMOVEPROPERTY(loBase,lcProp)
				CATCH TO loEX
					THROW loEX
					llFailed = .T.
				ENDTRY
			ENDIF
		ENDDO
		RETURN !llFailed
	ENDFUNC
	
	************************************************************************************************************************************************************
	* Get_Taskbar_Manager()
	************************************************************************************************************************************************************
	* Returns an object reference to the current taskbar manager instance.
	* 
	* There is only ever one instance of the manager ( singleton ), but the user can customize it's location, 
	* so this function is necessary to provide a transparent means to always get an object reference.
	* 
	* The class finds the manager by instantiating the library settings class and 
	* using the location specified there. 
	************************************************************************************************************************************************************
	FUNCTION Get_Taskbar_Manager()	
		LOCAL loTBM, loSettings, lcLocation, loEX AS Exception
		loTBM = NULL
		*Get an instance of the settings object ( this will either be customized or default settings )
		loSettings = THIS._Get_Library_Settings()
		IF VARTYPE(loSettings)="O" AND !ISNULL(loSettings)
			*Pull the taskbar manager's location from the settings class
			lcLocation = loSettings.cTaskbarManager_Location
			*Grab Taskbar Object reference
			loTBM = THIS.Get_Object_From_StringName(lcLocation)
		ENDIF
		RETURN loTBM
	ENDFUNC	
	
	************************************************************************************************************************************************************
	* Initialize_Library
	************************************************************************************************************************************************************
	* Performs all the work of initializing the library. See code comments for details
	************************************************************************************************************************************************************
	FUNCTION Initialize_Library()
		LOCAL loSettings
		*Create the settings object		
		loSettings = THIS._Get_Library_Settings()
		IF !(VARTYPE(loSettings)="O" AND !ISNULL(loSettings))
			RETURN .F.
		ENDIF
		
		*todo: add win7tlib_visual.vcx if necessary to SET CLASSLIB ADDITIVE

		*Pull settings		
		LOCAL loTBM, lcAppID, lcDLLPath, lcMode, lcLoc, loLoc, llAddVFPTaskbar
		WITH loSettings
			lcAppID = .cAppID
			lcDLLPath = .cDLLPath 
			lcMode = .cDefaultFormMode 
			lcLoc = .cTaskbarManager_Location 
		ENDWITH
		
		*Determine if library should create an instance of a taskbar class for the _VFP main window
		IF !EMPTY(lcMode)
			DO CASE
				** VFP mode assumes VFP window will be the main UI
				CASE UPPER(lcMode) = "VFP"
					llAddVFPTaskbar = .T.
				** The rest assume that forms will operate on their own instance of the taskbar class.
				CASE UPPER(lcMode) = "MDI"
					llAddVFPTaskbar = .F.
				CASE UPPER(lcMode) = "TOP"
					llAddVFPTaskbar = .F.
				CASE UPPER(lcMode) = "TDI"
					llAddVFPTaskbar = .F.
			ENDCASE
		ENDIF				

		******************************		
		* Add Taskbar Manager to VFP *
		******************************
		*Parameters:
		* 	1) Path to DLL (optional)
		*	2) Logical for creation of a Taskbar automatically for the VFP Main Window
		*    		.F. = Do not create Taskbar for main VFP window ( Default option )
		* 			.T. = Create a Taskbar Instance for the main VFP Window
		loTBM = CREATEOBJECT("Taskbar_Manager", lcDLLPath, llAddVFPTaskbar)
		IF !(VARTYPE(loTBM)="O" AND !ISNULL(loTBM))
			RETURN .F.
		ENDIF
		
		****************************************
		* Add Taskbar Manager to its location  *
		****************************************
		IF !THIS._Add_Object_To_Location(lcLoc,loTBM)
			RETURN .F.
		ENDIF

		***************************
		*** SET APPLICATION ID  ***
		***************************
		*Set the Application ID when not running code as a PRG ( since then it's too late )
		IF !_VFP.Visible
			loTBM.SetApplicationID(lcAppID)
		ENDIF

		********************************
		*** SET OTHER PROPERTIES ID  ***
		********************************
		IF !EMPTY(lcMode)
			loTBM.cFormMode=lcMode
		ENDIF

	ENDFUNC	
	
	************************************************************************************************************************************************************
	* UnInitialize_Library
	************************************************************************************************************************************************************
	* Performs all the work of uninitializing the library. See code comments for details
	************************************************************************************************************************************************************
	FUNCTION UnInitialize_Library()
		LOCAL loSettings, lcLoc, loLoc
		*Create the settings object
		loSettings = THIS._Get_Library_Settings()
		IF !(VARTYPE(loSettings)="O" AND !ISNULL(loSettings))
			RETURN .F.
		ENDIF
		
		*We must ensure all forms are closed before releasing the Taskbar Manager from Memory
		*since the form's may contain an object reference to a taskbar class, which the manager
		*is also referring to. If the manager clears before the form, the calls in the form's
		*taskbar object destroy will attempt to cleanup and will fail causing errors.
		LOCAL loForm
		FOR EACH loForm IN _VFP.Forms FOXOBJECT
			loForm.Release()
		ENDFOR

		****************************************
		* Remove the Object from it's Location
		****************************************
		lcLoc = loSettings.cTaskbarManager_Location 
		THIS._Remove_Object_From_Location(lcLoc)
	ENDFUNC	
		
ENDDEFINE


************************************************************************************
* Taskbar Manager Class
************************************************************************************
* A singleton class which manages all instances of the Taskbar_Class on behalf of 
* each VFP form that wishes to work with the Windows 7 Taskbar
************************************************************************************
DEFINE CLASS Taskbar_Manager AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	cDLLPath = ""									&& Optional path to the DLL file ( useful for testing the DLL )
	cFormMode = ""									&& Form Mode to use when registering form's for a taskbar. Values can be: VFP, TOP, MDI, TDI
	cTaskbar_TOP_Class = "Taskbar_TOP_Class"		&& Taskbar Classes to instantiate ( Users can subclass and override these properties )
	cTaskbar_MDI_Class = "Taskbar_MDI_Class"
	cTaskbar_TDI_Class = "Taskbar_TDI_Class"
	cTaskbar_TAB_Class = "Taskbar_TDI_Tab_Class"	
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT TaskbarList AS Win7TLIB_List 		&& List of the Taskbar Instances
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _lAppIDSet
	_lAppIDSet = .F.								&& Flags if the Application ID has been set by this class.
	***********************
	* END OF PROPERTIES   *
	***********************

	**********************************
	**********************************
	* Setup/Cleanup Related  Section *
	**********************************
	**********************************
	#DEFINE TB_MANAGER_SETUP_AND_CLEANUP_RELATED	
	
	****************************************************
	* INIT
	****************************************************
	* Parms: String Path to DLL (optional)
	*		 Logical for auto registration of the
	*		 Main VFP Window ( Default is not to register )
	****************************************************
	FUNCTION INIT(tcDLLPath,tlAutoRegisterMainVFPWindow)
		*Set the DLL Path if it was passed.
		THIS.cDLLPATH = EVL(tcDLLPath,"")
		*Always allow the object to initialze regardless of _Setup result
		*RETURN THIS._SETUP(tlDoNotRegisterMainVFPWindow)
		THIS._SETUP(tlAutoRegisterMainVFPWindow)
	ENDFUNC

	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS._CLEANUP()
		DEBUGOUT "Finished destroying: " + THIS.Name
	ENDFUNC

	***********************************************
	* _SETUP
	***********************************************
	* Internal method to perform any class related
	* setup required for the object. This method is
	* called automatically from the INIT() event.
	************************************************
	PROTECTED FUNCTION _SETUP(tlAutoRegisterMainVFPWindow)
		LOCAL llOK
		llOK = .T.

		*************************************
		*Setup the DLL if we're on Windows 7*
		*************************************
		*If not on Win7, the _lDllLoaded Property does not get set, and all
		*code in the classes will ignore any calls to the DLL loaded functions.
		*This allows the library to be compiled into a program and be called without
		*errors on older Windows versions.
		IF THIS.IsWindows7()		
			llOK = THIS._SetupDLL()
		ENDIF
		IF llOK		
			*Register the Main VFP Window unless asked not to.
			IF tlAutoRegisterMainVFPWindow
				*NOTE: We always register it as Top Level, since that's all it can ever be!
				THIS.Register_TopLevel_Form(_VFP)
			ENDIF
		ENDIF
		RETURN llOK
	ENDFUNC

	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		*Remove all Taskbars ( MUST COME BEFORE CLEANUPDLL() )
		THIS._RemoveAllTaskbars()
		*Cleanup the DLL
		RETURN THIS._CleanupDLL()
	ENDFUNC
	
	********************************************
	* _SetupDLL 
	********************************************	
	* Declares all the DLL functions we need
	********************************************	
	** TODO: Add alias to all functions, ie, Win7Tlib_ and then the funciton name.
	** This should ensure there are no conflicts with function names in user code.
	PROTECTED FUNCTION _SetupDLL()
		LOCAL llFailed, loEX
		TRY
			*Set path to the DLL
			IF !EMPTY(THIS.cDLLPath)
				SET PATH TO (THIS.cDLLPath) ADDITIVE
			ENDIF
		
			********************************
			** Generic Win32 API Declares **
			********************************			
			DECLARE INTEGER GetWindowLong IN user32 INTEGER hWnd, INTEGER nIndex 
	       	DECLARE INTEGER CallWindowProc IN user32 LONG lpPrevWndFunc, LONG hWnd, LONG Msg, INTEGER wParam, INTEGER lParam
			DECLARE INTEGER RegisterWindowMessage IN user32 STRING lpString
			DECLARE Sleep IN WIN32API Integer milliseconds
			DECLARE Integer GetAncestor IN User32 Integer hWnd, Integer Flags
			DECLARE DestroyIcon IN User32 Integer hIcon
			DECLARE Integer CopyIcon IN User32 Integer hIcon

			**********************
			**Win7TLib Declares **
			**********************
			
			* Mainetnance *
			DECLARE SetupDLL IN Win7TLib.dll
			DECLARE CleanupDLL IN Win7TLib.dll
			
			* Application ID Related *
			DECLARE Integer SetApplicationID IN Win7TLib.dll String appid
			DECLARE Integer GetApplicationID IN Win7TLib.dll String @appid

			* Window ID Related *
			DECLARE Integer SetWindowID IN Win7TLib.dll Integer hwnd, String wid
			DECLARE Integer GetWindowID IN Win7TLib.dll Integer hwnd, String @wid
			DECLARE ClearWindowID IN Win7TLib.dll Integer hwnd
			*
			* Jumplist related *
			DECLARE CreateJumpList IN Win7TLib.dll Integer hwnd
			DECLARE DeleteJumpList IN Win7TLib.dll Integer hwnd
			DECLARE SetJumpListProps IN Win7TLib.dll Integer hWnd, String appid, Integer inc_r, Integer inc_f, Integer ff, Integer inc_c, Integer inc_u
			DECLARE AddUserTaskItem IN Win7TLib.dll ;
					Integer hWnd, Integer id, Integer nType, ;
					String cArguments, String cIconLocation, String cPath, String cTitle, String cWorkingDir, ;
					Integer nShowCmd, Integer nIconIndex
			DECLARE AddCustomCategory IN Win7TLib.dll Integer hWnd, Integer id, String cTitle
			DECLARE AddCustomCategoryItem IN Win7TLib.dll ;
					Integer hWnd, Integer catid, Integer id, Integer nType, ;
					String cArguments, String cIconLocation, String cPath, String cTitle, String cWorkingDir, ;
					Integer nShowCmd, Integer nIconIndex
			DECLARE AddToRecentDocs IN Win7TLib.dll String filename
			DECLARE ClearRecentDocs IN Win7TLib.dll
			
			* Taskbar Button Icon related *
			DECLARE Integer SetTaskbarIcon IN Win7TLib.dll Integer hwnd, Integer hicon, String descr
			DECLARE Integer ClearTaskbarIcon IN Win7TLib.dll Integer hwnd
			
			* Taskbar Button Progress related *
			DECLARE SetProgressState IN Win7TLib.dll Integer hwnd, Integer state
			DECLARE SetProgressValue IN Win7TLib.dll Integer hwnd, Integer val, Integer nmax
			
			* Taskbar Button Flash related *
			DECLARE FlashTaskbarButton IN Win7TLib.dll Integer hwnd, Integer num
						
			* Toolbar related *
			DECLARE SetToolbarTooltip IN Win7TLib.dll Integer hWnd, String tip
			DECLARE Integer SetToolbarButton IN Win7TLib.dll Integer hWnd, Integer num, Integer hIcon, String tooltip, Integer enabled, Integer visible, Integer clickclose, Integer Spacer
			DECLARE CreateToolbar IN Win7TLib.dll Integer hwnd			
			DECLARE UpdateToolbar IN Win7TLib.dll Integer hwnd						
			
			* Thumbnail Clipping Related *
			DECLARE Integer SetThumbnailClip IN Win7TLib.dll Integer hwnd, Integer x, Integer y, Integer w, Integer h
			DECLARE Integer ClearThumbnailClip IN Win7TLib.dll Integer hwnd
			
			* Custom Drawing Registration Related *
			DECLARE RegisterForCustomThumbnail IN Win7TLib.dll Integer hwnd
			DECLARE UnRegisterForCustomThumbnail IN Win7TLib.dll Integer hwnd
			DECLARE RegisterTab IN Win7TLib.dll Integer hwndProxy, Integer hwndMain
			DECLARE SetActiveTab IN Win7TLib.dll Integer hwndProxy, Integer hwndMain
			
			* Thumbnail Custom Image Related *
			DECLARE SetThumbnailImage IN Win7TLib.dll Integer hwnd, Integer hbitmap, Integer w, Integer h
			DECLARE CreateThumbnailImage IN Win7TLib.dll Integer hWndSrc, Integer hWndProxy, Integer tw, Integer th
			DECLARE CreateClippedThumbnailImage IN Win7TLib.dll Integer hWndSrc, Integer hWndProxy, Integer tw, Integer th, Integer cx, Integer cy, Integer cw, Integer ch
			DECLARE RefreshThumbnails IN Win7TLib.dll Integer hwnd			
			
			* LivePreview ( Aero Peek ) Custom Drawing Related *
			DECLARE SetLivePreviewImage IN Win7TLib.dll Integer hWndSrc, Integer hwndProxy, Integer hbitmap, Integer sl, Integer st, Integer IsProxy
			DECLARE CreateLivePreviewImage IN Win7TLib.dll Integer hWndSrc, Integer hWndProxy, Integer sl, Integer st
			
			* Registry & File Type Related *
			DECLARE Integer IsFileTypeRegistered IN Win7TLib.dll String pszProgID, String pszExt, Integer check_specific_user
			DECLARE Integer IsProgIDRegistered IN Win7TLib.dll String pszProgID, Integer check_specific_user
			DECLARE Integer RegisterFileType IN Win7TLib.dll String pszProgID, String pszExt, Integer check_specific_user, String pszAppID, String pszDesc, String pszIconFile
			DECLARE Integer UnRegisterFileType IN Win7TLib.dll String pszProgID, String pszExt, Integer check_specific_user
			DECLARE Integer DeleteFileType IN Win7TLib.dll String pszProgID, String pszExt, Integer check_specific_user
			
			* Call the DLL Setup function
			SetupDLL()
			
			* Flag that the DLL Loaded
			THIS._lDllLoaded = .T.
			
		CATCH TO loEX
			llFailed = .T.
			* Flag that the DLL did not load
			THIS._lDllLoaded = .F.
		ENDTRY
		RETURN !llFailed
	ENDFUNC
	
	********************************************	
	* _CleanupDLL
	********************************************	
	* Removes all resources used by the DLL 
	********************************************	
	PROTECTED FUNCTION _CleanupDLL()
		*Make sure we call the DLL Clean up function first.
		IF THIS._lDllLoaded
			CleanupDLL()
		ENDIF
		*TODO: Add just the dll names in comma separated list here
		CLEAR DLLS 
	ENDFUNC

	**************************
	**************************	
	* Application ID Related *
	**************************
	**************************
	#DEFINE TB_MANAGER_APPID_RELATED
		
	********************************************
	* SetApplication ID
	********************************************
	* Set the Application ID specific string
	* NOTE: For this to work, it MUST be called BEFORE the VFP screen is visible.
	* Thus, use a CONFIG.FPW: SCREEN=OFF setting with your APP, set this property,
	* then if you wish, make the _VFP screen visible.
	********************************************	
	FUNCTION SetApplicationID(tcID)
		LOCAL lcID, llOK
		*Make sure there are no spaces, as they are not allowed
		lcID = STRTRAN(tcID," ","")
		*Strip chars past the max size allowed.
		lcID = LEFT(lcID,MAX_APPID_SIZE)
		*Convert from Double Byte to Wide Char for the DLL
		lcID = THIS.MakeWideString(lcID)
		*Let the DLL function call do the rest
		IF THIS._lDllLoaded
			llOK = (SetApplicationID(lcID) > 0)
		ENDIF
		*Flag if set successfully.
		THIS._lAppIDSet = llOK
		RETURN llOK
	ENDFUNC
	
	********************************************
	* GetApplicationID
	********************************************	
	* Retrieve the Application ID specific string (
	* It must have been previously set by this 
	* class for the call to work. This is due to
	* the Win32API call causing an exception
	* otherwise.
	********************************************		
	FUNCTION GetApplicationID()
		LOCAL lcID, llOK
		*Get the ID from the DLL function call if the app id was set.
		IF THIS._lAppIDSet
			*ID can be 128 characters ( we add 1 for the null string )
			lcID = REPLICATE(CHR(0),MAX_APPID_SIZE+1)
			IF THIS._lDllLoaded
				llOK = (GetApplicationID(@lcID) > 0)
			ENDIF
		ENDIF
		IF llOK
			*Convert from Wide Char back to Double Byte for VFP
			lcID = THIS.MakeVFPString(lcID)
		ELSE
			lcID = ""
		ENDIF
		RETURN lcID
	ENDFUNC
	
	*************************
	*************************
	* Taskbar Class Related *
	*************************
	*************************
	#DEFINE TB_MANAGER_TASKBAR_RELATED	
	
	***********************************************
	* _AddNewTaskbar
	***********************************************
	* Internal method to add a new taskbar instance
	* to the manager's list of taskbar objects for
	* the hWnd specified.
	************************************************
	PROTECTED FUNCTION _AddNewTaskbar(tcType,toForm,tInitParm)
		LOCAL loT, lcClass
		DO CASE
			*MDI Form
			CASE UPPER(ALLTRIM(tcType))=="MDI"
				lcClass = THIS.cTaskbar_MDI_Class 
			*TDI Form
			CASE UPPER(ALLTRIM(tcType))=="TDI"
				lcClass = THIS.cTaskbar_TDI_Class
			*TAB Form
			CASE UPPER(ALLTRIM(tcType))=="TAB"
				lcClass = THIS.cTaskbar_TAB_Class
			*Top Level
			OTHERWISE
				lcClass = THIS.cTaskbar_TOP_Class 
		ENDCASE	
		*Create Taskbar Object
		loT = CREATEOBJECT(lcClass,toForm,THIS._lDllLoaded,tInitParm)
		*Add to collection using the HWND as the key
		THIS.TaskbarList.AddItem(toForm.hWnd,loT)
		RETURN loT
	ENDFUNC
	
	***********************************************
	* _RemoveTaskbar
	***********************************************
	* Internal method to remove a taskbar instance
	* from the manager's list of taskbar objects for
	* the hWnd specified.
	************************************************
	PROTECTED FUNCTION _RemoveTaskbar(tnHWND)
		THIS.TaskbarList.RemoveItem(tnHWND)
	ENDFUNC	
	
	***********************************************
	* _RemoveAllTaskbars
	***********************************************
	* Internal method to clear the entire list of 
	* taskbar objects.
	************************************************
	PROTECTED FUNCTION _RemoveAllTaskbars()
		THIS.TaskbarList.ClearList()
	ENDFUNC			
	
	***********************************************
	* _Register_Form_Common
	***********************************************
	* Internal method which does all the common
	* work related to registering a form with an 
	* instance of a Taskbar class. Returns the
	* new Taskbar object
	************************************************
	PROTECTED FUNCTION _Register_Form_Common(tcMode,toForm,tInitParm)
		LOCAL loT
		loT = THIS._AddNewTaskbar(tcMode,toForm,tInitParm)
		*Call After Create "Event"
		loT.On_After_Created(toForm)
		RETURN loT	
	ENDFUNC
	

	***********************************************
	* Register_Form
	***********************************************
	* Registers a VFP form with the manager and 
	* creates a taskbar class instance for it internally.
	*
	* This method uses the cFormMode property to determine which
	* type of taskbar class will be created. The 
	* cFormMode property will typically set during
	* the Library initialization, or shortly thereafter.
	*
	* Pass the Form Object to register and any 
	* single additional Init parameter necessary
	************************************************
	FUNCTION Register_Form(toForm,tInitParm)
		RETURN THIS._Register_Form_Common(THIS.cFormMode,toForm,tInitParm)
	ENDFUNC	
	
	***********************************************
	* Register_TopLevel_Form
	***********************************************
	* All Top Level VFP form's must call this method first.
	*
	* A Top Level Form means ShowWindow = 2 in the property sheet.
	* 
	* The method creates an instance of a Taskbar class and returns
	* an object reference to it, which the Form can store for later.
	* Alternatly, the VFP form can always get a reference using the
	* GetTaskbar() method. 
	************************************************
	FUNCTION Register_TopLevel_Form(toForm,tInitParm)
		RETURN THIS._Register_Form_Common("TOP",toForm,tInitParm)
	ENDFUNC
	
	***********************************************
	* Register_MDI_Form
	***********************************************
	* All MDI VFP form's must call this method first.
	*
	* An MDI Form means ShowWindow <> 2 in the property sheet.
	* 
	* The method creates an instance of a Taskbar class and returns
	* an object reference to it, which the Form can store for later.
	* Alternatly, the VFP form can always get a reference using the
	* GetTaskbar() method. 
	************************************************
	FUNCTION Register_MDI_Form(toForm,tInitParm)
		RETURN THIS._Register_Form_Common("MDI",toForm,tInitParm)
	ENDFUNC		
	
	***********************************************
	* Register_TDI_Form
	***********************************************
	* All TDI VFP form's must call this method first.
	*
	* A TDI Form is the same as an MDI form but also has a Pageframe
	* (Tabbed Document Interface)
	* 
	* The method creates an instance of a Taskbar class and returns
	* an object reference to it, which the Form can store for later.
	* Alternatly, the VFP form can always get a reference using the
	* GetTaskbar() method. 
	************************************************
	FUNCTION Register_TDI_Form(toForm,tInitParm)
		RETURN THIS._Register_Form_Common("TDI",toForm,tInitParm)
	ENDFUNC	
	
	***********************************************
	* Register_TDI_Tab_Form
	***********************************************
	* All TDI Tab form's must call this method.
	*
	* A TDI Tab Form is a VFP form that is working as a 
	* replacement pageframe "tab".
	* 
	* The method creates an instance of a Taskbar class and returns
	* an object reference to it, which the Form can store for later.
	* Alternatly, the VFP form can always get a reference using the
	* GetTaskbar() method. 
	************************************************
	FUNCTION Register_TDI_Tab_Form(toForm,tInitParm)
		RETURN THIS._Register_Form_Common("TAB",toForm,tInitParm)
	ENDFUNC		
	
	***********************************************
	* UnRegister_Form
	***********************************************
	* Call when the Form no longer needs to work with
	* a taskbar class.
	************************************************
	FUNCTION UnRegister_Form(toForm)
		DEBUGOUT "** - UnRegister_Form called @ " + TRANSFORM(DATETIME())
		THIS._RemoveTaskbar(toForm.hWnd)
	ENDFUNC	
	
	***********************************************
	* UnRegister_TDI_Tab_Form
	***********************************************
	* Called by the TDI Class to unregister it's
	* tab forms, although it can't get access to the
	* form object anymore (it's destroyed), so it 
	* will use the hWnd key.
	************************************************
	FUNCTION UnRegister_TDI_Tab_Form(tnHWND)
		DEBUGOUT "** - UnRegister_TAB_Form called @ " + TRANSFORM(DATETIME())	
		THIS._RemoveTaskbar(tnHWND)
	ENDFUNC	
	
	***********************************************
	* GetTaskbar
	***********************************************
	* Returns an object reference of the Taskbar Class
	* registered for the form passed as an object.
	* You can also pass just the hWnd value.
	************************************************
	FUNCTION GetTaskbar(toForm)
		LOCAL lnHWND, loT, loEX
		*Did we get a valid form object? If so, grab it's hWnd
		IF VARTYPE(toForm)="O" AND !ISNULL(toForm) AND PEMSTATUS(toForm,"hWnd",5)
			lnHWND = toForm.hWnd
		ELSE
			*Did we get an Hwnd Value passed in?
			IF VARTYPE(toForm)="N" AND toForm > 0
				lnHWND = toForm
			ENDIF
		ENDIF
		*Retrieve the Taskbar registered to this hWnd
		IF lnHWND > 0
			loT = THIS.TaskbarList.GetItem(lnHWND)
		ENDIF
		RETURN loT
	ENDFUNC
	
	****************
	****************
	* Form Related *
	****************
	****************
	#DEFINE TB_MANAGER_FORM_RELATED	
	
	***********************************************
	* GetFormCount
	***********************************************
	* Returns the # of forms still open in VFP
	* 
	* This function ensures to skip any proxy 
	* windows that may be open
	************************************************
	FUNCTION GetFormCount()
		LOCAL loForm, lnCount
		lnCount = 0
		FOR EACH loForm IN _VFP.Forms FOXOBJECT
			*todo: add even more stringent checking?
			*Skip Proxy Forms since they: 
			*1) Are Invisible
			*2) Have Height & Width of 1.
			IF loForm.Visible AND loForm.Height > 1 AND loForm.Width > 1
				lnCount = lnCount + 1 
			ENDIF
		ENDFOR
		RETURN lnCount
	ENDFUNC		
	
	***********************************************
	* GetForm_From_hWnd
	***********************************************
	* Returns a VFP Form Object from the given 
	* hWnd number or NULL if not found
	************************************************
	* NOTE: Cannot use FOR EACH loForm here for some odd reason.
	* See code in Toolbar Win32 message handler. What would happen is the
	* local loForm variable there would reset to .F. upon the 2nd call to this function!!
	FUNCTION GetForm_From_hWnd(tnHWND)
		LOCAL loForm, lnLoop
*		FOR EACH loForm IN _VFP.Forms		
*		FOR EACH loForm IN _VFP.Forms FOXOBJECT
		FOR lnLoop = 1 TO _VFP.Forms.Count
			loForm = _VFP.Forms(lnLoop)
			*Does the hWnd Match?
			IF loForm.hWnd == tnHWND
				RETURN loForm
			ENDIF
		ENDFOR
		*If not found, see if it's the VFP window
		IF _VFP.hWnd == tnHWND
			loForm = _VFP
		ENDIF
		RETURN loForm
	ENDFUNC			
	
ENDDEFINE

********************************************************************************************
* Taskbar TOP LEVEL FORM Class
********************************************************************************************
* Manages all communications with the Windows 7 Taskbar on behalf of a Top Level VFP Form
*
* In VFP this translates to a form that lives outside the main VFP window with a 
* ShowWindow setting of 2.
*********************************************************************************************
*todo: consider making hWnd protected and add gethwnd() method
DEFINE CLASS Taskbar_TOP_Class AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	hWnd = 0 										&& HWND of the VFP form registered to this Taskbar Instance ( Must Be A Top-Level Window )
	cHelperObj = ""									&& Name of the helper object 
	nHelperForm_hWnd = 0							&& HWND of the form on which the Helper Object lives.
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT TaskbarButton AS Taskbar_Button		&& A Single Instance of a Taskbar Button Class
	ADD OBJECT Preview AS Taskbar_Preview			&& A Single Instance of a Taskbar Preview Class
	ADD OBJECT JumpList AS Taskbar_Jumplist			&& A Single Instance of a Tasjbar JumpList Class
	ADD OBJECT Toolbar AS Taskbar_Toolbar			&& A Single Instance of a Taskbar Toolbar Class
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _cMode
	_cMode = "TOP"									&& Mode of the taskbar ( cannot be changed )
	***********************
	* END OF PROPERTIES   *
	***********************
	
	********************************************************
	* INIT
	********************************************************
	* Parms: Form Object to link with this Taskbar Instance
	*		 Logical if the DLL Was Loaded
	*		 Any other single init parameter of any type
	********************************************************
	FUNCTION INIT(toForm, tlDllLoaded, tInitParm)
		*Set the DLL Loaded Property	
		THIS._lDllLoaded = tlDllLoaded
		RETURN THIS._SETUP(toForm, tInitParm)
	ENDFUNC

	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		RETURN THIS._CLEANUP()
	ENDFUNC

	***********************************************
	* _SETUP
	***********************************************
	* Internal method to perform any class related
	* setup required for the object. This method is
	* called automatically from the INIT() event.
	************************************************
	PROTECTED FUNCTION _SETUP(toForm, tInitParm)
		*Has to be top-level form ( _VFP doesn't have ShowWindow property so skip the check )
		IF toForm.hWnd <> _VFP.hWnd AND !toForm.ShowWindow = 2
			ERROR "Form sent to Taskbar Class must be a Top-Level form with ShowWindow = 2 setting"
			RETURN .F.
		ENDIF
		*Store the VFP Window Handle
		THIS.hWnd = toForm.hWnd
		*Store the helper object name
		THIS.cHelperObj = EVL(tInitParm,"")
	ENDFUNC

	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		*Clear the WindowID ( since the DLL leaks resources, otherwise )
		THIS.ClearWindowID()
	ENDFUNC

	*********************
	*********************	
	* Window ID Related *
	*********************
	*********************
		
	********************************************	
	* SetWindowID
	********************************************		
	* Set a VFP window's ID for the Taskbar
	********************************************		
	FUNCTION SetWindowID(tcID)
		LOCAL lcID
		*Make sure there are no spaces, as they are not allowed
		lcID = STRTRAN(tcID," ","")
		*Strip chars past the max size allowed.
		lcID = LEFT(lcID,MAX_APPID_SIZE)
		*Convert from Double Byte to Wide Char for the DLL
		lcID = THIS.MakeWideString(lcID)
		IF THIS._lDllLoaded
			SetWindowID(THIS.hWnd,lcID) 
		ENDIF
	ENDFUNC
	
	********************************************
	* GetWindowID
	********************************************	
	* Retrieve the Window ID specific string
	********************************************		
	FUNCTION GetWindowID()
		LOCAL lcID, llOK
		*ID can be 128 characters ( we add 1 for the null string )
		lcID = REPLICATE(CHR(0),MAX_APPID_SIZE+1)
		IF THIS._lDllLoaded
			llOK = (GetWindowID(THIS.hWnd,@lcID) > 0)
		ENDIF
		IF llOK
			*Convert from Wide Char back to Double Byte for VFP
			lcID = THIS.MakeVFPString(lcID)
		ELSE
			lcID = ""
		ENDIF
		RETURN lcID
	ENDFUNC	

	********************************************	
	* ClearWindowID
	********************************************	
	* Clear a VFP window's ID for the Taskbar, 
	* which then group's the window with the 
	* ApplicationID
	********************************************		
	FUNCTION ClearWindowID()
		*Let the DLL function call do the work
		IF THIS._lDllLoaded
			ClearWindowID(THIS.hWnd) 
		ENDIF
	ENDFUNC	

	********************************************	
	* GetCurrentAppID
	********************************************	
	* Returns the current AppID string for this
	* class / for the application.
	* Returns Empty String if AppID was not
	* explicitly defined.
	********************************************		
	FUNCTION GetCurrentAppID()
		LOCAL lcAppID
		*First try the Window ID()
		lcAppID = THIS.GetWindowID()
		*If not set, return the Application ID for the
		*entire process.
		IF EMPTY(lcAppID)
			LOCAL loTBM
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				lcAppID = loTBM.GetApplicationID()
			ENDIF
		ENDIF
		RETURN lcAppID
	ENDFUNC
	
	**********************************************
	* GethWnd
	**********************************************
	* Returns the HWND associated with this class.
	* This method is necessary since subclasses
	* will need to provide differing hWnds ie for
	* proxy windows, for example.
	**********************************************
	FUNCTION GethWnd()
		RETURN THIS.hWnd
	ENDFUNC
	

	**********************************************
	* SetHelperObj
	**********************************************
	* Set the Helper Object's Name & hWnd Property
	* This allows other objects to find the helper
	* object reference later without having to 
	* store the object reference directly.
	**********************************************
	FUNCTION SetHelperObj(tcName,tnhWnd)
		WITH THIS
			.cHelperObj = tcName
			.nHelperForm_hWnd = tnhWnd
		ENDWITH
	ENDFUNC
		
	**********************************************************
	* On_After_Created
	**********************************************************
	* This method gets called after the taskbar object has 
	* been created by the manager and has been added to it's
	* list of taskbar objects.
	*
	* The Form Object that is registered to the Taskbar gets 
	* passed in case method needs to access it's properties.
	**********************************************************
	FUNCTION On_After_Created(toForm)
	ENDFUNC
	
	**********************************************
	* GetMode
	**********************************************
	* Returns the mode of the Taskbar
	**********************************************
	FUNCTION GetMode()
		RETURN THIS._cMode
	ENDFUNC	
	
ENDDEFINE

************************************************************************************
* Taskbar MDI Class
************************************************************************************
* Manages all communications with the Windows 7 Taskbar on behalf of a MDI VFP Form
*
* MDI =  Multiple Document Interface
*
* In VFP this translates to a form that lives within the main VFP window with a 
* ShowWindow setting of 0 OR a form that lives within another TOP LEVEL form with a
* ShowWindow setting of 1.
* 
* NOTE: The MDIForm property can be set either .T. or .F., it doesn't matter to the
* class.
************************************************************************************
DEFINE CLASS Taskbar_MDI_Class AS Taskbar_TOP_Class 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	cProxyFormClass = "Taskbar_Proxy_MDI_Window"	&& Class to use as the Proxy Window ( subclass can override this )
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	nProxySrchWnd = 0								&& Proxy Source hWnd
	oProxyWindow = NULL								&& Object reference to the Proxy Window to keep it in memory
	nProxyWindowhWnd = 0							&& Proxy Window hWnd ( for easier reference )
	***********************	
	* INTERNAL PROPERTIES *
	***********************		
	_cMode = "MDI"									&& Mode of the taskbar ( cannot be changed )	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	***********************************************
	* _SETUP
	***********************************************
	* Internal method to perform any class related
	* setup required for the object. This method is
	* called automatically from the INIT() event.
	************************************************
	PROTECTED FUNCTION _SETUP(toForm, tInitParm)
		LOCAL loParent
		*Cannot be a top-level form!
		IF toForm.ShowWindow = 2
			ERROR "Form sent to Taskbar Class must not be a Top-Level form with ShowWindow = 2 setting"
			RETURN .F.
		ENDIF
		*Store proxy source hWnd
		THIS.nProxySrchWnd  = toForm.hWnd
		*Find the top level parent window
		loParent = THIS.GetTopParentForm(toForm)
		IF VARTYPE(loParent)="O" AND !ISNULL(loParent)
			*Use parent's hWnd to talk with the taskbar, since the MDI is not a top level form.
			THIS.hWnd = loParent.hWnd
		ELSE
			ERROR "Unable to find parent form for form: " + toForm.Caption
			RETURN .F.
		ENDIF
		*Store the helper object name
		THIS.cHelperObj = EVL(tInitParm,"")
	ENDFUNC
	
	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		THIS._CloseProxyWindow()
	ENDFUNC

	*********************************************************
	* _CreateProxyWindow
	*********************************************************
	* Creates a Proxy Window and adds an object reference of
	* it to the class for access later.
	*********************************************************
	PROTECTED FUNCTION _CreateProxyWindow(toForm)
		LOCAL loPF
		loPF = CREATEOBJECT(THIS.cProxyFormClass,THIS._lDllLoaded)
		IF VARTYPE(loPF)=="O" AND !ISNULL(loPF)
			LOCAL lnProxySrchWnd
			
			*Get the Proxy Form Source Window Handle ( this is the VFP MDI Form )
			lnProxySrchWnd = toForm.hWnd
			*Store it to the Proxy Window Form Object
			loPF.nProxySrchWnd = lnProxySrchWnd 
			
			*Set the Caption to equal the form passed
			loPF.Caption = toForm.Caption
			*Set the Icon to equal the form passed
			loPF.Icon = toForm.Icon

			*Store object reference to the proxy window
			THIS.oProxyWindow = loPF
			*Store hWnd also
			THIS.nProxyWindowHwnd = loPF.hWnd

			*Setup a BindEvent when the MDI form's caption changes to keep 
			*the proxy window caption the same. The event code must trigger first (last parm = 1)
			=BINDEVENT(toForm,"Caption",loPF,"UpdateCaption",1)
			*Setup a BindEvent when the MDI form changes it's icon
			=BINDEVENT(toForm,"Icon",loPF,"UpdateFormIcon",1)
			*Setup a BindEvent when the MDI form paints itself to update thumbnails
			=BINDEVENT(toForm,"Paint",loPF,"UpdateThumbnail",1)
			
			*Register as a Tab Window using the DLL.
			*This allows the window to have it's own Grouping in the Taskbar.
			*Furthermore, it prevents the "main" window from getting a Preview Window.
			*We send the Proxy Window hwnd, and use the Top Level window Handle as the Main Window for Grouping
			IF THIS._lDllLoaded			
				RegisterTab(loPF.hWnd,THIS.hWnd)
			ENDIF
			
			*Register for Custom Drawing
			THIS.Preview.Register_Custom_Drawing()
		ENDIF
	ENDFUNC		

	***********************************************
	* _CloseProxyWindow
	***********************************************
	* Internal method to remove the proxy window 
	* instance from the class.
	* 
	* Once the proxy window object reference has 
	* been removed it should go out of scope and 
	* be destroyed automatically by VFP.
	************************************************
	PROTECTED FUNCTION _CloseProxyWindow()
		THIS.oProxyWindow = NULL
	ENDFUNC	
	
	***************************************************	
	* GethWnd
	***************************************************	
	* Returns the HWND associated with this class.
	* This method is necessary since subclasses
	* will need to provide differing hWnds ie for
	* proxy windows, for example.
	***************************************************	
	* OVERRIDE DEFAULT: Provides the Proxy Window hWnd
	***************************************************	
	FUNCTION GethWnd()
		RETURN THIS.nProxyWindowHwnd 
	ENDFUNC		
	
	**********************************************************
	* GetParentForm
	**********************************************************
	* Finds the form's parent form object from the passed form 
	* object and returns the object reference to it, or NULL.
	* 
	* This would be the _SCREEN form when a VFP is running 
	* inside VFP, or the Top Level VFP Form hosting the form.
	**********************************************************
	FUNCTION GetParentForm(toForm AS Form)
		LOCAL loParent
		loParent = NULL

		*ShowWindow = 0 is ALWAYS the _SCREEN window
		IF toForm.ShowWindow = 0
			loParent = _SCREEN
		*We'll need to have windows find the ROOT window
		ELSE
			IF THIS._lDllLoaded
				LOCAL lnRoothWnd
				lnRoothWnd = GetAncestor(toForm.hWnd,GA_ROOT)
				IF lnRoothWnd > 0
					LOCAL loTBM
					IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
						loParent = loTBM.GetForm_From_hWnd(lnRoothWnd)
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		RETURN loParent
	ENDFUNC
	
	**********************************************************
	* GetTopParentForm
	**********************************************************
	* Finds the top level form parent of the passed form 
	* object. This is _VFP when a form is running inside of it.
	* Otherwise, it's a Top Level VFP form hosting the form.
	* Returns the top parent form object reference or NULL if
	* it could not find it.
	**********************************************************
	FUNCTION GetTopParentForm(toForm AS Form)
		LOCAL loParent
		loParent = NULL

		*ShowWindow = 0 is ALWAYS the VFP window
		IF toForm.ShowWindow = 0
			loParent = _VFP
		*We'll need to have windows find the ROOT window
		ELSE
			loParent = THIS.GetParentForm(toForm)
		ENDIF
		RETURN loParent
	ENDFUNC	
	
	**********************************************************
	* On_After_Created
	**********************************************************
	* This method gets called after the taskbar object has 
	* been created by the manager and has been added to it's
	* list of taskbar objects.
	*
	* The Form Object that is registered to the Taskbar gets 
	* passed in case method needs to access it's properties.
	**********************************************************
	FUNCTION On_After_Created(toForm)
		* Create a proxy window since DWM cannot communicate
		* with non-top-level forms.
		THIS._CreateProxyWindow(toForm)
	ENDFUNC	
	
	*******************************************************
	* SetClipping
	*******************************************************
	* Set's the Thumbnail Preview Clipping Region from the
	* given parameters.
	*
	* X & Y are the coordinates where to start clipping
	* W & H are the width & height of the clipping region.
	*******************************************************
	* OVERRIDE DEFAULT: Accounts for the Proxy Window
	***************************************************	
	FUNCTION Preview.SetClipping(tnX, tnY, tnW, tnH)
		IF THIS.Parent.IsDLL_Loaded()
			*Store the values 
			THIS.SetClipInfo(tnX, tnY, tnW, tnH)
			
			*Force thumbnails to refresh
			RefreshThumbnails(THIS.Parent.nProxyWindowhWnd)
		ENDIF
	ENDFUNC		
	
	**************************************************
	* SetLivePreviewImage
	**************************************************
	* Same as SetThumbnail Image above but relates
	* to the LivePreview ( Aero Peek ) window/image.
	* Unlike the Thumbnail, no width & height are
	* sent by windows.
	***************************************************
	* OVERRIDE DEFAULT: Accounts for the Proxy Window
	***************************************************	
	FUNCTION Preview.SetLivePreviewImage(tnHandle)
		IF THIS.Parent.IsDLL_Loaded()			
			LOCAL loTBM, loForm, lnLeft, lnTop, lnTitleBarHeight, lnBorderWidth, lnBorderHeight, lnLA, lnTA, lnWA, lnHA
			*Get Taskbar Manager Object
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				
				*Get Proxy Source Form Object
				loForm = loTBM.GetForm_From_hWnd(THIS.Parent.nProxySrchWnd)
				IF VARTYPE(loForm)="O" AND !ISNULL(loForm)
					*Get the form's Left & Top offset adjustments relative to the VFP Window
					THIS.Utils.GetScreen_TopLeft_Offset(@lnLA, @lnTA)

					*Get Padding Sizes for the Form
					THIS.Utils.GetForm_PaddingSizes(loForm, @lnTitleBarHeight, @lnBorderWidth, @lnBorderHeight)

					*Width & Height adjustments to account for border & title heights
					*NOTE: It's strange that you only take into account 1x the border, not 2x.
					lnWA = (1 * lnBorderWidth)
					lnHA = (1 * lnBorderHeight) + lnTitleBarHeight				

					*Adjust Form's properties with the new offsets
					lnLeft = loForm.Left + lnLA + lnWA
					lnTop = loForm.Top + lnTA + lnHA

					*Adjust for borders & title bar
					SetLivePreviewImage(THIS.Parent.nProxySrchWnd,THIS.Parent.nProxyWindowhWnd,tnHandle,lnLeft,lnTop,1)
				ENDIF
			ENDIF
		ENDIF
	ENDFUNC	
	
	****************************************************
	* CreateThumbnailImage
	****************************************************
	* Pass the handle to the form and an optional
	* proxy form handle, and the method will have
	* the DLL create a thumbnail image automatically
	* of what the form's screen looks like.
	*
	* This is only needed for MDI forms, since in
	* all other cases, windows does this automatically.
	****************************************************
	* OVERRIDE DEFAULT: Accounts for the Proxy Window
	****************************************************
	FUNCTION Preview.CreateThumbnailImage(tnW,tnH)
		*Call DLL to create a thumbnail image of the proxy src window
		IF THIS.Parent.IsDLL_Loaded()			
			LOCAL lnSrc, lnProxy
			*Pull Source & Proxy hWnd 
			lnSrc = THIS.Parent.nProxySrchWnd
			lnProxy = THIS.Parent.nProxyWindowhWnd
			*Call differing methods if clipping is on
			IF THIS.IsClipping()
				LOCAL lnX, lnY, lnW, lnH
				*Retrieve current clipping data
				THIS.GetClipInfo(@lnX,@lnY,@lnW,@lnH)
				*Call the clipping version of the DLL
				CreateClippedThumbnailImage(lnSrc, lnProxy, tnW, tnH, lnX, lnY, lnW, lnH)
			ELSE			
				*Call the non-clipping version of the DLL
				*todo
				CreateThumbnailImage(lnSrc, lnProxy, tnW, tnH)
			ENDIF

		ENDIF
	ENDFUNC	
	
	*****************************************************
	* CreateLivePreviewImage
	*****************************************************
	* Pass the handle to the form and an optional
	* proxy form handle, and the method will have
	* the DLL create a live preview image automatically
	* of what the form's screen looks like.
	*
	* This is only needed for MDI forms, since in
	* all other cases, windows does this automatically.
	*****************************************************
	* OVERRIDE DEFAULT: Accounts for the Proxy Window
	*****************************************************
	FUNCTION Preview.CreateLivePreviewImage()
		IF THIS.Parent.IsDLL_Loaded()			
			LOCAL loTBM, loForm, lnLeft, lnTop, lnLA, lnTA

			*Get Taskbar Manager Object
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				
				*Get Proxy Source Form Object
				loForm = loTBM.GetForm_From_hWnd(THIS.Parent.nProxySrchWnd)
				IF VARTYPE(loForm)="O" AND !ISNULL(loForm)

					*Get the form's Left & Top offset adjustments relative to the VFP Window
					THIS.Utils.GetScreen_TopLeft_Offset(@lnLA, @lnTA)

					*Adjust Form's properties with the new offsets
					lnLeft = loForm.Left + lnLA
					lnTop = loForm.Top + lnTA

					*Adjust for borders & title bar
					CreateLivePreviewImage(THIS.Parent.nProxySrchWnd,THIS.Parent.nProxyWindowhWnd,lnLeft,lnTop)
				ENDIF
			ENDIF
		ENDIF
	ENDFUNC		
	
	*****************************************************
	* UnRegister_Custom_Drawing
	*****************************************************
	* Unregisters the Taskbar from Custom Drawing,
	* which reverts back to default taskbar image
	* generation for Thumbnails & Live Preview
	* ( Aero Peek) images.
	*****************************************************
	* OVERRIDE DEFAULT: Accounts for the Proxy Window
	*****************************************************
	FUNCTION Preview.UnRegister_Custom_Drawing(tlShutdown)
		*If shutting down, call the parent class to truly
		*un-register from custom drawing..
		IF tlShutdown
			DODEFAULT()
		*Not shutting down, so we need to simply remove the
		*custom image files, which means we'll still keep
		*custom drawing the previews using the mdi default code
		ELSE
			WITH THIS
				.cThumbnailImage = ""
				.cLivePreviewImage = ""
			ENDWITH
		ENDIF
	ENDFUNC			

ENDDEFINE

************************************************************************************
* Taskbar TDI Class
************************************************************************************
* Manages all communications with the Windows 7 Taskbar on behalf of a TDI VFP Form
*
* TDI = Tabbed Document Interface
*
* In VFP this translates to a form that lives within the main VFP window with a 
* ShowWindow setting of 0 OR a form that lives within another TOP LEVEL form with a
* ShowWindow setting of 1 and has a Pageframe within it.
* 
* So far only the Top Level Version has been tested.
* todo: the implementation is not complete yet, but it is demo-able.
************************************************************************************
DEFINE CLASS Taskbar_TDI_Class AS Taskbar_TOP_Class
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT TabhWndList AS Win7TLIB_List 		&& List of the Registered Tab Class hWnd values
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	_cMode = "TDI"									&& Mode of the taskbar ( cannot be changed )	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		THIS._UnRegister_All_Tabs()
	ENDFUNC
	
	****************************************************
	* _UnRegister_All_Tabs
	****************************************************
	* Internal method which unregisters all taskbar
	* classes associated with each tab that this class
	* registered initially.
	****************************************************
	PROTECTED FUNCTION _UnRegister_All_Tabs()
		LOCAL lnHWND
		LOCAL loTBM
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			FOR EACH lnHWND IN THIS.TabhWndList FOXOBJECT
				loTBM.UnRegister_TDI_Tab_Form(lnHWND)
			ENDFOR
		ENDIF
	ENDFUNC
	
	*******************************************************
	* Register_Tab_Form
	*******************************************************
	* Register's a Form (acting as a Tab in a pageframe )
	* with this class so that it can create and manage a
	* taskbar instance for the tab form. Doing so 
	* allows each "page" of the pageframe to have it's
	* own thumbnail & live preview images
	*******************************************************
	FUNCTION Register_Tab_Form(toForm,tnNum)	
		LOCAL loT
		loT = NULL
		LOCAL loTBM
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			*Create the Taskbar class for this form
			loT = loTBM.Register_TDI_Tab_Form(toForm,tnNum)
			*Set the Helper Property
			loT.cHelperObj = THIS.cHelperObj
			*Store our Helper Form HWnd
			loT.nHelperForm_hWnd = THIS.nHelperForm_hWnd 
			* Add to the list
			THIS.TabhWndList.AddItem(THIS.TabhWndList.Count+1,toForm.hWnd)
		ENDIF
		*Return the object
		RETURN loT
	ENDFUNC
	
	*******************************************************
	* UnRegister_Tab_Form
	*******************************************************
	* UnRegister's a Form (acting as a Tab in a pageframe )
	*******************************************************
	FUNCTION UnRegister_Tab_Form(toForm)	
		LOCAL loTBM
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			loTBM.UnRegister_TDI_Tab_Form(toForm.hWnd)
		ENDIF
	ENDFUNC	
	
	*********************************************************
	* GetTabTaskbar
	*********************************************************
	* Returns the Taskbar Object associated with the 
	* tab # specified or NULL if not found.
	*********************************************************
	FUNCTION GetTabTaskbar(tnNum)
		LOCAL loT, loTBM
		loT = NULL
		*Get Taskbar Manager Object
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			LOCAL lnHWND
			* Get the hWnd corresponding to the tab #
			lnHWND = THIS.TabhWndList.GetItem_FromIndex(tnNum)
			* Now get the taskbar object registered to this hWnd
			IF lnHWND > 0
				loT = loTBM.GetTaskbar(lnHWND)
			ENDIF
		ENDIF
		*Return the object
		RETURN loT
	ENDFUNC
	
	*********************************************************
	* SetActiveTab
	*********************************************************
	* Calls the SetActiveTab() method of the tab associated
	* with the tab # specified.
	*********************************************************
	FUNCTION SetActiveTab(tnNum)
		LOCAL loT
		*Get the Taskbar object for the given tab #
		loT = THIS.GetTabTaskbar(tnNum)
		*Call its SetActiveTab() method 
		IF VARTYPE(loT)="O" AND !ISNULL(loT)
			loT.SetActiveTab()
		ENDIF
	ENDFUNC

ENDDEFINE


************************************************************************************
* Taskbar TDI Tab Class
************************************************************************************
* Manages all communications with the Windows 7 Taskbar on behalf of a TDI Tabbed
* VFP Form. This is a VFP form that is acting like a Tab in a Pageframe, ie, 
* we're faking the effect.
*
* TDI = Tabbed Document Interface
*
* In VFP this translates to a form that has the ShowWindow = 1 setting, ie
* a form that lives inside a Top-Level form.
*
* todo: the implementation is not complete yet, but it is demo-able.
************************************************************************************
DEFINE CLASS Taskbar_TDI_Tab_Class AS Taskbar_MDI_Class 
	***********************	
	* PUBLIC PROPERTIES   *
	***********************	
	cProxyFormClass = "Taskbar_Proxy_TDI_Window"	&& OVERRIDE DEFAULT
	nTabNum = 0										&& Tab # for the form registered to this class.
	***********************		
	* INTERNAL PROPERTIES *
	***********************	
	_cMode = "TDI"									&& Mode of the taskbar ( cannot be changed )	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	***********************************************
	* _SETUP
	***********************************************
	* Internal method to perform any class related
	* setup required for the object. This method is
	* called automatically from the INIT() event.
	************************************************
	PROTECTED FUNCTION _SETUP(toForm, tInitParm)
		IF !DODEFAULT(toForm, tInitParm)
			RETURN .F.
		ENDIF
		*Init Parameter is the Tab #
		THIS.nTabNum = EVL(tInitParm,0)
	ENDFUNC
	
	*********************************************************
	* _CreateProxyWindow
	*********************************************************
	* Creates a Proxy Window and adds an object reference of
	* it to the class for access later.
	* ADD TO DEFAULT HANDLING
	*********************************************************
	PROTECTED FUNCTION _CreateProxyWindow(toForm)
		LOCAL loPF
		*The parent class will setup the proxy window
		DODEFAULT(toForm)
		*Set Proxy Window's Tab #		
		loPF = THIS.oProxyWindow
		IF VARTYPE(loPF)="O" AND !ISNULL(loPF)
			loPF.nTabNum = THIS.nTabNum
		ENDIF
	ENDFUNC			

	*********************************************************
	* SetActiveTab
	*********************************************************
	* Inform's Windows 7 that this tab is now activate.
	* As a result, the Preview Window for this tab will
	* get a colored border around it as a visual cue for
	* the user.
	*********************************************************
	FUNCTION SetActiveTab()
		IF THIS.IsDLL_Loaded()			
			SetActiveTab(THIS.nProxyWindowHwnd, THIS.hWnd)
		ENDIF		
	ENDFUNC
	
	*****************************************************
	* CreateLivePreviewImage
	*****************************************************
	* Pass the handle to the form and an optional
	* proxy form handle, and the method will have
	* the DLL create a live preview image automatically
	* of what the form's screen looks like.
	*
	* This is only needed for MDI forms, since in
	* all other cases, windows does this automatically.
	*****************************************************
	* OVERRIDE DEFAULT: Accounts for the Proxy Window
	*****************************************************
	FUNCTION Preview.CreateLivePreviewImage()
		IF THIS.Parent.IsDLL_Loaded()			
			LOCAL loTBM, loForm, lnLeft, lnTop, lnLA, lnTA

			*Get Taskbar Manager Object
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				
				*Get Proxy Source Form Object
				loForm = loTBM.GetForm_From_hWnd(THIS.Parent.nProxySrchWnd)
				IF VARTYPE(loForm)="O" AND !ISNULL(loForm)

					*No need for adjustments ( unlike the MDI case )
					lnLeft = loForm.Left
					lnTop = loForm.Top

					*Adjust for borders & title bar
					CreateLivePreviewImage(THIS.Parent.nProxySrchWnd,THIS.Parent.nProxyWindowhWnd,lnLeft,lnTop)
				ENDIF
			ENDIF
		ENDIF
	ENDFUNC		
	
ENDDEFINE



************************************************************************************
* Taskbar Button Class
************************************************************************************
* Manages all aspects of the Windows 7 Taskbar Button / Icon
* The button is what you see in the Taskbar when the app is running.
************************************************************************************
DEFINE CLASS Taskbar_Button AS Win7TLIB_Base 
	***********************
 	* PUBLIC PROPERTIES   *
	***********************	 	
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		RETURN THIS._CLEANUP()
	ENDFUNC
	
	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		THIS.ClearProgress()
		THIS.ClearOverlayIcon()
	ENDFUNC
	
	*******************************************************
	* Flash
	*******************************************************
	* Flashes the Taskbar Button the specified # of times
	*******************************************************
	FUNCTION Flash(tnTimes)
		IF THIS.Parent.IsDLL_Loaded()	
			FlashTaskbarButton(THIS.Parent.hWnd,tnTimes)
		ENDIF
	ENDFUNC
	
	*********************************************************
	* SetProgressStyle
	*********************************************************
	* Set's the style of the Taskbar Button's Progress State.
	* See MSDN for info on what these styles mean
	* 
	* Valid Parameters for Style are:
	*
	*	Indeterminate
	*	Normal
	*	Error
	*	Paused
	*
	*********************************************************
	FUNCTION SetProgressStyle(tcStyle)
		LOCAL lnVal, lcStyle
		lnVal = 0
		lcStyle = UPPER(ALLTRIM(tcStyle))
		DO CASE
			CASE lcStyle == "INDETERMINATE"
				lnVal = 1
			CASE lcStyle == "NORMAL"
				lnVal = 2
			CASE lcStyle == "ERROR"
				lnVal = 4
			CASE lcStyle == "PAUSED"
				lnVal = 8
		ENDCASE
		IF THIS.Parent.IsDLL_Loaded()			
			SetProgressState(THIS.Parent.hWnd,lnVal)	
		ENDIF
	ENDFUNC
	
	*******************************************************
	* SetProgressValue
	*******************************************************
	* Set's the Progress bar value of the Taskbar Button
	* to the value specified out of the maximum value 
	* specified
	*******************************************************
	FUNCTION SetProgressValue(tnVal, tnMaxVal)
		IF THIS.Parent.IsDLL_Loaded()		
			SetProgressValue(THIS.Parent.hWnd, tnVal, tnMaxVal)	
		ENDIF
	ENDFUNC	

	*******************************************************
	* ClearProgress
	*******************************************************
	* Removes the Progress state from the Taskbar Button
	*******************************************************
	FUNCTION ClearProgress()
		IF THIS.Parent.IsDLL_Loaded()		
			SetProgressState(THIS.Parent.hWnd,0)	
		ENDIF
	ENDFUNC
	
	*******************************************************
	* SetOverlayIcon
	*******************************************************
	* Set's the Taskbar Button's Overlay icon to the 
	* specified icon file name and optional description
	* string
	*******************************************************
	FUNCTION SetOverlayIcon(tcIcon, tcDescr)
		LOCAL lcDescr, lnHandle, loImage
		*Prepare Description if given
		lcDescr = ""
		IF VARTYPE(tcDescr)="C"
			*Prepare the Description string
			lcDescr = IIF(EMPTY(ALLTRIM(tcDescr)),"",THIS.MakeWideString(tcDescr))
		ENDIF
		
		*Convert Icon Name into Handle
		loImage = THIS.LoadImage(tcIcon)
		IF !(VARTYPE(loImage)=="O" AND !ISNULL(loImage))
			RETURN .F.
		ENDIF
		lnHandle = loImage.Handle
		
		*Set the Taskbar Icon 
		IF THIS.Parent.IsDLL_Loaded()	
			*Don't include description if it's missing
			IF EMPTY(ALLTRIM(lcDescr))
				SetTaskbarIcon(THIS.Parent.hWnd, lnHandle, 0)
			ELSE
				SetTaskbarIcon(THIS.Parent.hWnd, lnHandle, lcDescr)
			ENDIF
		ENDIF
	ENDFUNC	
	
	*******************************************************
	* ClearOverlayIcon
	*******************************************************
	* Clears/Removes the Taskbar Button Overlay Icon
	*******************************************************
	FUNCTION ClearOverlayIcon()
		IF THIS.Parent.IsDLL_Loaded()		
			ClearTaskbarIcon(THIS.Parent.hWnd)	
		ENDIF
	ENDFUNC	

ENDDEFINE

************************************************************************************
* Taskbar Preview Class
************************************************************************************
* Manages all Windows 7 Taskbar Preview related functions, ie..
* Thumbnail View and Live Preview ( Aero Peek ) view
************************************************************************************
DEFINE CLASS Taskbar_Preview AS Win7TLIB_Base
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	cThumbnailImage = ""						&& File name of an image to use for custom Thumbnail Preview
	cLivePreviewImage = ""						&& File name of an image to use for custom Live Preview
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT Utils AS Taskbar_Preview_Utils	&& Utility class which provides some helper functions
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _hOrigProc, _lClip, _nClipX, _nClipY, _nClipW, _nClipH
	_hOrigProc = 0								&& VFP Original Window Procedure Handler	
	_lClip = .F.								&& Flag to indicate if the thumbnail image is clipped
	_nClipX = 0									&& Clipping X value
	_nClipY = 0									&& Clipping Y value
	_nClipW = 0									&& Clipping Width value
	_nClipH = 0									&& Clipping Height value		
	***********************
	* END OF PROPERTIES   *
	***********************
	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS._CLEANUP()
	ENDFUNC
	
	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		*UnRegister for custom drawing 
		THIS.UnRegister_Custom_Drawing(.T.)			&& .T. = shutting down
		*Clear any clipping
		THIS.ClearClipping()
	ENDFUNC
	
	***********************************************
	* Setup_Win32API_Messages
	***********************************************
	* Uses BindEvents() to intercept and process
	* Taskbar related Win32API messages
	************************************************
	PROTECTED FUNCTION _Setup_Win32API_Messages()
		IF THIS.Parent.IsDLL_Loaded()
			LOCAL lnHWND
			lnHWND = THIS.Parent.GethWnd()			

			*Find the original VFP Window Proc Handler and store for later use
			THIS._hOrigProc = GetWindowLong(lnHWND, GWL_WNDPROC) 

			*Bind to each message #
			IF lnHWND > 0
				=BINDEVENT(lnHWND, WM_DWMSENDICONICTHUMBNAIL, THIS, "_W32API_Msg_Handler", 4) 
				=BINDEVENT(lnHWND, WM_DWMSENDICONICLIVEPREVIEWBITMAP, THIS, "_W32API_Msg_Handler", 4) 	
			ENDIF
		ENDIF
	ENDFUNC
	
	***********************************************
	* Remove_Win32API_Messages
	***********************************************
	* Removes all Win32API messages previously bound
	************************************************
	PROTECTED FUNCTION _Remove_Win32API_Messages()
		IF THIS.Parent.IsDLL_Loaded()
			LOCAL lnHWND
			lnHWND = THIS.Parent.GethWnd()
			IF lnHWND > 0
				*Unbind all Win32 API messages from this form that we set up
				UNBINDEVENTS(lnHWND, WM_DWMSENDICONICTHUMBNAIL)
				UNBINDEVENTS(lnHWND, WM_DWMSENDICONICLIVEPREVIEWBITMAP)		
			ENDIF
		ENDIF
	ENDFUNC
	
	
	*********************************************************
	* _GetHelperObjects
	*********************************************************
	* Returns object references for:
	* 1) The Source Form associated with the passed hWnd value
	* 2) The Helper Object sitting on the Helper Form
	*
	* All variables must be called by Reference. 
	* Returns .T. only if all objects successfully created.
	*********************************************************
	PROTECTED FUNCTION _GetHelperObjects(hWnd, toForm, toHelper)
		LOCAL llOK, loTBM, loHelperForm
		*Grab Taskbar Manager Object
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			*Grab the Form object registered to this hWnd
			toForm = loTBM.GetForm_From_hWnd(hWnd)
			llOK = VARTYPE(toForm)="O" AND !ISNULL(toForm)
		ENDIF
		*Ok to continue?
		IF llOK
			*Grab the Helper Form Object
			loHelperForm = loTBM.GetForm_From_hWnd(THIS.Parent.nHelperForm_hWnd)
			llOK = VARTYPE(loHelperForm)="O" AND !ISNULL(loHelperForm)			
		ENDIF
		*Ok to continue?
		IF llOK
			* Grab the Helper Object Name for the form from the Taskbar class
			toHelper = THIS.Get_Object_From_StringName(THIS.Parent.cHelperObj,loHelperForm)
			llOK = VARTYPE(toHelper)="O" AND !ISNULL(toHelper)			
		ENDIF	
		RETURN llOK
	ENDFUNC	
	
	********************************************	
	* W32API_Msg_Handler
	********************************************	
	* Process several Win32 API Messages 
	********************************************	
	*NOTE: Don't bother to check .IsDLL_Loaded() since we don't set up bind events if that fails so this code won't be called
	*todo: should I set autoyield .F. here, and restore once code is done?
	PROTECTED FUNCTION _W32API_Msg_Handler(hWnd, Msg, wParam, lParam)
		LOCAL loForm, loHelper
		*Grab Form & Helper Objects
		IF THIS._GetHelperObjects(hWnd, @loForm, @loHelper)

				*Process all Win32API Messages here
				DO CASE
					*Draw Custom Thumbnail Preview Message
					CASE Msg = WM_DWMSENDICONICTHUMBNAIL
						LOCAL lnW,lnH
						*Parse wParam as HIWORD() and LOWORD() to retrieve the width & height of the Thumbar window
						lnH = BITAND(lParam,0xffff)
						lnW = (BITAND(lParam,0xffff*0x10000))/0x10000

						*Call the Call Back Handler Method if it exists
						IF PEMSTATUS(loHelper,"ON_THUMBNAIL_DRAW",5)
							loHelper.On_ThumbNail_Draw(THIS,loForm,lnW,lnH)
						ENDIF
						*Return 0 to signify we handled the message
						RETURN 0
						

					*Draw Custom Live Preview Message
					CASE Msg = WM_DWMSENDICONICLIVEPREVIEWBITMAP
						*Call the Call Back Handler Method if it exists				
						IF PEMSTATUS(loHelper,"ON_LIVEPREVIEW_DRAW",5)
							loHelper.On_LivePreview_Draw(THIS,loForm)
						ENDIF
						*Return 0 to signify we handled the message					
						RETURN 0
				ENDCASE
		ENDIF
		*Let VFP Handle all Win32API messages
		RETURN CallWindowProc(THIS._hOrigProc, hWnd, Msg, wParam, lParam)
	ENDFUNC	
	
	*******************************************************
	* IsClipping
	*******************************************************
	* Returns .T. if the Thumbnail window is being clipped.
	*******************************************************
	FUNCTION IsClipping()
		RETURN THIS._lClip 
	ENDFUNC	

	*******************************************************
	* SetClipInfo
	*******************************************************
	* Set's the clipping information for the class
	*******************************************************
	FUNCTION SetClipInfo(tnX, tnY, tnW, tnH)
		*Set Flag
		THIS._lClip = .T.
		*Clear values	
		THIS._nClipX = tnX
		THIS._nClipY = tnY
		THIS._nClipW = tnW
		THIS._nClipH = tnH
	ENDFUNC
	
	*******************************************************
	* GetClipInfo
	*******************************************************
	* Returns's the clipping information for the class.
	* Parameters must be passed by reference.
	*******************************************************
	FUNCTION GetClipInfo(tnX, tnY, tnW, tnH)
		tnX = THIS._nClipX
		tnY = THIS._nClipY
		tnW = THIS._nClipW
		tnH = THIS._nClipH
	ENDFUNC
	
	*******************************************************
	* ClearClipInfo
	*******************************************************
	* Clear's all Clipping data from the class
	*******************************************************
	FUNCTION ClearClipInfo()
		*Reset Flag
		THIS._lClip = .F.
		*Clear values	
		THIS._nClipX = 0
		THIS._nClipY = 0
		THIS._nClipW = 0
		THIS._nClipH = 0
	ENDFUNC	
	
	*******************************************************
	* SetClipping
	*******************************************************
	* Set's the Thumbnail Preview Clipping Region from the
	* given parameters.
	*
	* X & Y are the coordinates where to start clipping
	* W & H are the width & height of the clipping region.
	*******************************************************
	FUNCTION SetClipping(tnX, tnY, tnW, tnH)
		*Store the values 
		THIS.SetClipInfo(tnX, tnY, tnW, tnH)
		*Call Dll to do the work
		IF THIS.Parent.IsDLL_Loaded()		
			SetThumbnailClip(THIS.Parent.GethWnd(), tnX, tnY, tnW, tnH)
		ENDIF
	ENDFUNC	

	*******************************************************
	* ClearClipping
	*******************************************************
	* Clear's the Thumbnail Preview Clipping Region
	*******************************************************
	FUNCTION ClearClipping()
		*Clear the values 
		THIS.ClearClipInfo()
		*Call Dll to do the work
		IF THIS.Parent.IsDLL_Loaded()	
			ClearThumbnailClip(THIS.Parent.GethWnd())
		ENDIF
	ENDFUNC
	
	********************************************************
	* Register_Custom_Drawing
	********************************************************
	* Register's the Taskbar to custom draw it's 
	* preview Thumbnail & Live Preview ( Aero Peek) images.
	* You can pass it the name of a callback handler
	* class if you wish to override the default 
	* handler behavior.
	*
	* NOTE: This method does nothing when running in 
	* MDI & TDI modes, as a Proxy window handles those
	* functions.
	* (See notes at top of library about former MDI & TDI)
	********************************************************
	FUNCTION Register_Custom_Drawing(tcCallBackHandler)
		LOCAL lcMode
		lcMode = THIS.Parent.GetMode()
		*Skip if MDI or TDI mode
		IF !(lcMode=="MDI" OR lcMode=="TDI")
			*Register with the DLL
			IF THIS.Parent.IsDLL_Loaded()	
				RegisterForCustomThumbnail(THIS.Parent.GethWnd())
				*Setup Win32 API messages
				THIS._Setup_Win32API_Messages()
				*Force any cached images to be cleared
				THIS.RefreshPreviews()
			ENDIF
		ENDIF
	ENDFUNC	
	
	***********************************************
	* UnRegister_Custom_Drawing
	***********************************************
	* Unregisters the Taskbar from Custom Drawing,
	* which reverts back to default taskbar image
	* generation for Thumbnails & Live Preview
	* ( Aero Peek) images.
	*
	* NOTE: This method does nothing when running in 
	* MDI & TDI modes, as a Proxy window handles those
	* functions.
	* (See notes at top of library about former MDI & TDI)	
	************************************************
	FUNCTION UnRegister_Custom_Drawing(tlShutdown)
		LOCAL lcMode
		lcMode = THIS.Parent.GetMode()
		*Skip if MDI or TDI mode	
		IF !(lcMode=="MDI" OR lcMode=="TDI")
			IF THIS.Parent.IsDLL_Loaded()	
				*Unregister with the DLL
				UnRegisterForCustomThumbnail(THIS.Parent.GethWnd())
				*Remove Win32 API Message handling
				THIS._Remove_Win32API_Messages()
			ENDIF
		ENDIF
	ENDFUNC		
	
	***********************************************
	* RefreshPreviews
	***********************************************
	* Forces Windows to eliminate any cached 
	* images for the Thumbnail ( and maybe 
	* Live Peek, I'm not sure ). Windows will the
	* request your application to draw new images
	* when the user wishes to display the Preview
	* window.
	************************************************
	FUNCTION RefreshPreviews()
		IF THIS.Parent.IsDLL_Loaded()		
			RefreshThumbnails(THIS.Parent.GethWnd())
		ENDIF
	ENDFUNC

	***********************************************
	* SetThumbnailImage
	***********************************************
	* Pass the handle to an Image ( obtained from
	* LOADPICTURE(), and Windows will use it 
	* as the custom Thumbnail image in the Preview
	* window. The width & height must also be 
	* specified. These are provided to your app
	* from the callback handler, and must be 
	* respected.
	************************************************
	FUNCTION SetThumbnailImage(tnHandle,tnW,tnH)
		IF THIS.Parent.IsDLL_Loaded()		
			SetThumbnailImage(THIS.Parent.GethWnd(),tnHandle,tnW,tnH)
		ENDIF
	ENDFUNC
	
	****************************************************
	* CreateThumbnailImage
	****************************************************
	* Pass the handle to the form and an optional
	* proxy form handle, and the method will have
	* the DLL create a thumbnail image automatically
	* of what the form's screen looks like.
	*
	* This is only needed for MDI forms, since in
	* all other cases, windows does this automatically.
	****************************************************
	FUNCTION CreateThumbnailImage(tnW,tnH)
		IF THIS.Parent.IsDLL_Loaded()			
			*Call DLL to create a thumbnail image of the proxy src window
			CreateThumbnailImage(THIS.Parent.GethWnd(), THIS.Parent.GethWnd(), lnW, lnH)
		ENDIF
	ENDFUNC

	***********************************************
	* SetLivePreviewImage
	***********************************************
	* Same as SetThumbnail Image above but relates
	* to the LivePreview ( Aero Peek ) window/image.
	* Unlike the Thumbnail, no width & height are
	* sent by windows.
	************************************************
	FUNCTION SetLivePreviewImage(tnHandle)
		IF THIS.Parent.IsDLL_Loaded()			
			SetLivePreviewImage(THIS.Parent.GethWnd(),THIS.Parent.GethWnd(),tnHandle,0,0,0)
		ENDIF
	ENDFUNC
ENDDEFINE

************************************************************************************
* Taskbar Preview Utility Class
************************************************************************************
* Provides some utility functions for the Taskbar Preview class
************************************************************************************
DEFINE CLASS Taskbar_Preview_Utils AS Win7TLIB_Base
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************

	************************************************************************************************************************************************************
	* GetForm_PaddingSizes
	************************************************************************************************************************************************************
	* Calculates the Titlebar Height, BorderWidth, and BorderHeight for a given form object.
	* Parameters need to be passed by reference so their values can be returned.
	************************************************************************************************************************************************************
	FUNCTION GetForm_PaddingSizes(toForm, tnTitleBarHeight, tnBorderWidth, tnBorderHeight)
		LOCAL llTitleBar, lnBS
		*Determine if VFP Main window has a Title Bar
		llTitleBar = (toForm.TitleBar==1)
		*Get the Height of the Title Bar
		tnTitleBarHeight = IIF(llTitleBar,SYSMETRIC(9),0)
		*Get BorderStyle of the VFP Window
		lnBS = toForm.BorderStyle
		*Get Width of Border of the VFP Window
		tnBorderWidth = ICASE(lnBS=0,0,lnBS=1,SYSMETRIC(10),lnBS=2,SYSMETRIC(12),SYSMETRIC(3))
		*Get Height of Border of the VFP Window
		tnBorderHeight = ICASE(lnBS=0,0,lnBS=1,SYSMETRIC(11),lnBS=2,SYSMETRIC(13),SYSMETRIC(4))
	ENDFUNC

	************************************************************************************************************************************************************
	* GetScreen_TopLeft_Offset
	************************************************************************************************************************************************************
	* Calculates the offset adjustments for Left & Top properties of a form contained inside the VFP Window relative to
	* the VFP Main Window Client area. The form's Top & Left properties are relative to the SCREEN client area,
	* which itself is adjusted based on borderwidth and titlebar styles. 
	*
	* Parameters need to be passed by reference so their values can be returned.
	************************************************************************************************************************************************************
	*todo: make this part of a toolbar_utils class and then add that as an object to the toolbar singleton
	FUNCTION GetScreen_TopLeft_Offset(tnLeft, tnTop)
		LOCAL lnVT, lnST, lnVL, lnSL, lnSW_Adjust, lnSH_Adjust
		LOCAL lnTitleBarHeight, lnBorderWidth, lnBorderHeight

		*Grab Top values for _VFP and _SCREEN
		lnVT = _VFP.Top
		lnST = _SCREEN.Top
		*Grab Left values for _VFP and _SCREEN
		lnVL = _VFP.Left
		lnSL = _SCREEN.Left

		*Subtract the differences to get relative offsets to each other
		lnSH_Adjust = lnST-lnVT
		lnSW_Adjust = lnSL-lnVL
		
		*Get Padding Sizes for the _SCREEN 
		THIS.GetForm_PaddingSizes(_SCREEN, @lnTitleBarHeight, @lnBorderWidth, @lnBorderHeight)

		*Calculate the Left Offset for a form relative to the vfp client window
		tnLeft = lnSW_Adjust-lnBorderWidth

		*Calculate the Top Offset for a form relative to the vfp client window
		tnTop = lnSH_Adjust-(lnTitleBarHeight+lnBorderHeight)
	ENDFUNC

	************************************************************************************************************************************************************
	* GetForm_ClippingData
	************************************************************************************************************************************************************
	* Calculates the Clipping Data ( Left, Top, Width, Height ) for the given Form object contained within
	* the _SCREEN object. Using this data, the Thumbnail Preview window can clip the VFP window so that 
	* only the given Form is visible in the preview window.
	*
	* Parameters need to be passed by reference so their values can be returned.
	************************************************************************************************************************************************************
	*todo: make this part of a toolbar_utils class and then add that as an object to the toolbar singleton
	FUNCTION GetForm_ClippingData(toForm, tnLeft, tnTop, tnWidth, tnHeight)
		LOCAL lnLeft_Offset, lnTop_Offset, lnTitleBarHeight, lnBorderWidth, lnBorderHeight,;
			  lnLA, lnTA, lnWA, lnHA, lcMode
			  
		*Special case for Top Level Form
		IF toForm.ShowWindow = 2
			tnTop = 0
			tnLeft = 0
			tnWidth = toForm.Width
			tnHeight = toForm.Height
			RETURN
		ENDIF
		
		*Start with the form's actual properties
		tnTop = toForm.Top
		tnLeft = toForm.Left
		tnWidth = toForm.Width
		tnHeight = toForm.Height
		
		*Get the form's Left & Top offset adjustments relative to the VFP Window
		THIS.GetScreen_TopLeft_Offset(@lnLA, @lnTA)

		*Get Padding Sizes for the Form
		THIS.GetForm_PaddingSizes(toForm, @lnTitleBarHeight, @lnBorderWidth, @lnBorderHeight)

		*Width & Height adjustments to account for border & title heights
		lnWA = (2 * lnBorderWidth)
		lnHA = (2 * lnBorderHeight) + lnTitleBarHeight

		*Top & Left must account for Offset adjustments
		tnTop = tnTop + lnTA
		tnLeft = tnLeft + lnLA
		
		*If MDI - top & left are zero
		lcMode = THIS.Parent.Parent.GetMode()
		IF lcMode=="MDI"
			tnTop = 0
			tnLeft = 0
		ENDIF

		*Width & Height must account for starting top & left position 
		tnWidth = tnWidth + lnWA + tnLeft
		tnHeight = tnHeight + lnHA + tnTop
		
	ENDFUNC


ENDDEFINE

************************************************************************************
* Taskbar JumpList Class
************************************************************************************
* Manages all Windows 7 Taskbar Jump List related functions
************************************************************************************
DEFINE CLASS Taskbar_Jumplist AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	lInclude_Recent = .F.								&& Include Recent Category in the Jump List
	lInclude_Frequent = .F.								&& Include Frequent Category in the Jump List
	lFrequent_First = .F.								&& Show the Frequent Section First in the Jump List ( otherwise Recent is First )
	lInclude_CustomCategories = .F.						&& Include Custom Categories in the Jump List
	lInclude_UserTasks = .F.							&& Include User Tasks in the Jump List
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT CustomCategories AS Win7TLIB_List		&& List of Custom Categories Objects
	ADD OBJECT UserTaskItems AS Win7TLIB_List 			&& List of User Task Items Objects
	ADD OBJECT FileTypeReg AS Jumplist_FileTypeReg 		&& A Single Instance of a File Type Registration Class
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************

	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS._ClearLists()
	ENDFUNC
	
	***********************************************
	* ClearLists
	***********************************************
	* Internal method to clear all list data from
	* the class. These are Custom Category Lists,
	* and User Tasks Lists.
	************************************************
	PROTECTED FUNCTION _ClearLists()
		THIS.ClearCustomCategories()
		THIS.ClearUserTasks()
	ENDFUNC

	***********************************************
	* _ItemObject_To_Vars
	***********************************************
	* Internal method to convert a Jump List Item
	* object into appropriate variables ( passed by
	* reference ) in preparation to be sent to DLL
	* Jumplist functions.
	************************************************
	*NOTE: All vars passed by reference so we can update their values	
	PROTECTED FUNCTION _ItemObject_To_Vars(toItem, tnType, tcArgs, tcIconLoc, ;
								 tcPath, tcTitle, tcWorkDir, tnShowCmd, tnIconIndex )

		LOCAL llSeparator

		*Give all strings a wide char default empty value since the DLL needs to pass these regardless
		tcPath = THIS.MakeWideString("")
		tcTitle = THIS.MakeWideString("")
		tcArgs = THIS.MakeWideString("")
		tcIconLoc = THIS.MakeWideString("")
		tcWorkDir = THIS.MakeWideString("")
		*Give all numerics a default value
		tnShowCmd = 0
		tnIconIndex = 0
		
		*Now parse the Item and make the appropriate assignments		
		WITH toItem
			*Is item a separator?	
			llSeparator = .lIsSeparator
			*Skip these for separators
			IF llSeparator
				tnType = 1
			ELSE
				tnType = 2	&& Type is an Item (or a Link modified below)
				tcPath = THIS.MakeWideString(.cAppPath)
				tcTitle = THIS.MakeWideString(.cTitle)
				*Skip these unless links
				IF .lIsLink
					tnType = 3	&& Type is a Link
					tcArgs = THIS.MakeWideString(.cArguments)
					tcIconLoc = THIS.MakeWideString(.cIconPath)
					tcWorkDir = THIS.MakeWideString(.cWorkingDir)
					tnShowCmd = .GetShowCmd()
					tnIconIndex = .nIconIndex 
				ENDIF
			ENDIF
		ENDWITH
	ENDFUNC
	
	******************************
	**     JUMP LIST RELATED    **
	******************************
	#DEFINE JMP_JUMP_LIST_RELATED

	***********************************************
	* CreateJumpList
	***********************************************
	* This method should be called once your app.
	* has finalized all settings and is ready to 
	* create the jumplist and have it committed.
	*
	* You can call this method multiple times without
	* needing to call DeleteJumpList first. Any changes
	* you make to the data will be updated.
	************************************************
	FUNCTION CreateJumpList()
		LOCAL lnHWND, lcAppID, lnInc_R, lnInc_F, lnFF, lnInc_C, lnInc_U
		
		*Grab the hWnd to use
		lnHWND = THIS.Parent.hWnd
		
		* Step 1 - Process Jump List properties ( must come first )
		lcAppID = THIS.MakeWideString(THIS.Parent.GetCurrentAppID())
		lnInc_R = IIF(THIS.lInclude_Recent,1,0)
		lnInc_F = IIF(THIS.lInclude_Frequent,1,0)
		lnFF	= IIF(THIS.lFrequent_First,1,0)
		lnInc_C = IIF(THIS.lInclude_CustomCategories,1,0)
		lnInc_U = IIF(THIS.lInclude_UserTasks,1,0)

		* Send Jump List Properties Data to the DLL
		IF THIS.Parent.IsDLL_Loaded()	
			SetJumpListProps(lnHWND,lcAppID,lnInc_R, lnInc_F, lnFF, lnInc_C, lnInc_U)
		ENDIF

		* Declare needed local vars
		LOCAL loCategory, loItem
		LOCAL lnType, lnCatID, lnID, lnShowCmd, lnIconIndex
		LOCAL lcTitle, lcArgs, lcIconLoc, lcPath, lcTitle, lcWorkDir
			  
		* Step 2 - Process User Tasks ( if they are to be included )
		IF THIS.lInclude_UserTasks
			lnID = 0
			*Loop through each item in the User Tasks Collection
			FOR EACH loItem IN THIS.UserTaskItems FOXOBJECT
				*Increment Item ID
				lnID = lnID + 1 
				* Convert the Object into variables
				THIS._ItemObject_To_Vars(loItem, @lnType, @lcArgs, @lcIconLoc, ;
								@lcPath, @lcTitle, @lcWorkDir, @lnShowCmd, @lnIconIndex )
				IF THIS.Parent.IsDLL_Loaded()									
					* Pass all the info to the DLL
					AddUserTaskItem(lnHWND, lnID, lnType, lcArgs, lcIconLoc, ;
									lcPath, lcTitle, lcWorkDir, lnShowCmd, lnIconIndex )
				ENDIF
			ENDFOR
		ENDIF
		
		* Step 3 - Process Custom Categories ( if they are to be included )
		IF THIS.lInclude_CustomCategories 
			lnCatID = 0
			*Loop through each category in the Custom Categories Collection
			FOR EACH loCategory IN THIS.CustomCategories FOXOBJECT
				*Increment Category ID						
				lnCatID = lnCatID + 1 
				lcTitle = THIS.MakeWideString(loCategory.cTitle)
				
				IF THIS.Parent.IsDLL_Loaded()	
					* Tell the DLL to create a new category
					* NOTE: Must do this BEFORE adding *any* Category Item Data
					AddCustomCategory(lnHWND,lnCatID,lcTitle)		
				ENDIF
				
				lnID = 0
				*Loop through each item in the category section				
				FOR EACH loItem IN loCategory.JumpListItems FOXOBJECT
					*Increment Item ID				
					lnID = lnID + 1 
					* Convert the Object into variables
					THIS._ItemObject_To_Vars(loItem, @lnType, @lcArgs, @lcIconLoc, ;
								@lcPath, @lcTitle, @lcWorkDir, @lnShowCmd, @lnIconIndex )
					IF THIS.Parent.IsDLL_Loaded()									
						* Pass all the info to the DLL					
						AddCustomCategoryItem (lnHWND, lnCatID, lnID, lnType, lcArgs, lcIconLoc, ;
												lcPath, lcTitle, lcWorkDir, lnShowCmd, lnIconIndex )
					ENDIF
				ENDFOR
			ENDFOR
		ENDIF
		
		IF THIS.Parent.IsDLL_Loaded()	
			* Step 4 - Tell the DLL we are finished / Go ahead and create the jump list!
			CreateJumpList(lnHWND) 
		ENDIF
	ENDFUNC
	
	***********************************************
	* UpdateJumpList
	***********************************************
	* Call to update the JumpList, although this
	* method really is just a convenience, since it
	* does notthing more than CreateJumpList anyway.
	************************************************
	FUNCTION UpdateJumpList()
		THIS.CreateJumpList()
	ENDFUNC
	
	***********************************************
	* DeleteJumpList
	***********************************************
	* This method deletes the JumpList data both
	* internally to this class, as well as from 
	* Windows.
	*
	* After being called, the default Windows 
	* generated JumpList will be displayed in 
	* the Taskbar.
	************************************************
	FUNCTION DeleteJumpList()
		THIS._ClearLists()
		IF THIS.Parent.IsDLL_Loaded()			
			DeleteJumpList(THIS.Parent.hWnd) 
		ENDIF
	ENDFUNC
	
	***********************
	**     RECENT LIST 	 **
	***********************
	#DEFINE JMP_RECENT_LIST_RELATED
	
	***********************************************
	* AddToRecentList
	***********************************************
	* Adds the specified file & path information 
	* to the Recent Destinations list manually.
	* 
	* The Recent Destination list is typically
	* managed by Windows when the Application 
	* opens a registered file type either by:
	* 1) Double Clicking in explorer
	* 2) Using common dialogs ( like GETFILE() in VFP ).
	*
	* This method is the programmatic way to get a file
	* listed if the above two methods won't suffice.
	* NOTE: The application must be registered to handle
	* the file type passed for this function to work.
	* Also, it will silently fail if the file name
	* is not valid. Requires a full path & file name.
	************************************************
	FUNCTION AddToRecentList(tcFile)
		LOCAL lcFile
		lcFile = THIS.MakeWideString(tcFile)
		IF THIS.Parent.IsDLL_Loaded()			
			RETURN AddToRecentDocs(lcFile)
		ENDIF
	ENDFUNC
	***********************************************
	* ClearRecentList
	***********************************************
	* Removes all data from the Recent Destinations
	* List.
	*
	* Despite MSDN documentation to the contrary, 
	* this function does not work!
	* todo: find an alternative if possible.
	************************************************
	FUNCTION ClearRecentList()
		IF THIS.Parent.IsDLL_Loaded()			
			RETURN ClearRecentDocs()
		ENDIF
	ENDFUNC	

	***********************
	**     USER TASKS 	 **
	***********************
	#DEFINE JMP_USER_TASKS_RELATED
		
	***********************************************
	* AddUserTask
	***********************************************
	* Adds a JumpList Item Object to the User Tasks List.
	* Must be passed a JumpList_Link object, as
	* the User Tasks does not support JumpList_Items
	* as far as I can tell.
	************************************************
	FUNCTION AddUserTask(toItem)
		LOCAL lnCount
		lnCount = THIS.UserTaskItems.Count + 1
		*Add to collection using the ItemCount as the key
		THIS.UserTaskItems.AddItem(lnCount, toItem)
	ENDFUNC
	
	***********************************************
	* ClearUserTasks
	***********************************************
	* Removes all User Task Items from the list.
	************************************************
	FUNCTION ClearUserTasks()
		*Remove all custom categories
		THIS.UserTaskItems.ClearList()
	ENDFUNC	

	***********************
	** CUSTOM CATEGORIES **	
	***********************
	#DEFINE JMP_CUSTOM_CATEGORIES_RELATED
	
	***********************************************
	* AddCustomCategory
	***********************************************
	* Adds a Custom Category object to the list of 
	* Custom Category objects. Each object represents
	* a custom category to be defined in the app's
	* jumplist.
	************************************************
	FUNCTION AddCustomCategory(toCategory)
		LOCAL lnCount
		lnCount = THIS.CustomCategories.Count + 1
		*Add to collection using the ItemCount as the key
		THIS.CustomCategories.AddItem(lnCount, toCategory)
	ENDFUNC
	
	***********************************************
	* ClearCustomCategories
	***********************************************
	* Clears / Removes all Custom Category objects 
	* from the list of Custom Categories.
	************************************************
	FUNCTION ClearCustomCategories()
		THIS.CustomCategories.ClearList()
	ENDFUNC
ENDDEFINE

************************************************************************************
* Taskbar JumpList Custom Category
************************************************************************************
* Represents a single JumpList Custom Category, which has a Title, and a list of
* JumpList Items.
************************************************************************************
DEFINE CLASS Jumplist_Custom_Category AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	cTitle = ""									&& Title of the Custom Category
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT JumpListItems AS Win7TLIB_List 	&& A list of JumpList Items Objects
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************

	********************************************************
	* INIT
	********************************************************
	* Parms: Title of the Custom Category (optional)
	********************************************************
	FUNCTION INIT(tcTitle)
		IF VARTYPE(tcTitle)="C"
			THIS.cTitle = tcTitle
		ENDIF
	ENDFUNC

	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS.ClearJumpListItems()
	ENDFUNC
	
	***********************************************
	* AddJumpListItem
	***********************************************
	* Adds a JumpList Item object to the list of
	* JumpList Items.
	* Passed object can be either a JumpList_Link object, 
	* or a JumpList_Item object, since custom categories
	* support both types.
	************************************************
	FUNCTION AddJumpListItem(toItem)
		LOCAL lnCount
		lnCount = THIS.JumpListItems.Count + 1
		*Add to collection using the ItemCount as the key
		THIS.JumpListItems.AddItem(lnCount, toItem)
	ENDFUNC
	
	***********************************************
	* ClearJumpListItems
	***********************************************
	* Clears / Removes all JumpList objects from the
	* JumpList items list.
	************************************************
	FUNCTION ClearJumpListItems()
		THIS.JumpListItems.ClearList()
	ENDFUNC	
	
ENDDEFINE

************************************************************************************
* Taskbar JumpList Item Base Object
************************************************************************************
* Represents a basic JumpList Item object ( do not instantiate directly )
*
* NOTE: We make the 3 properties read only by overriding the ASSIGN methods here.
* Thus, each subclass can specify the property as needed in the definition, but it
* cannot be modified at run time by the user.
************************************************************************************
DEFINE CLASS Jumplist_Base_Item AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	lIsSeparator = .F.							&& Is the object a seperator?
	lIsItem = .F.								&& Is the object an item?
	lIsLink = .F.								&& Is the object a link?
	***********************		
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************

	***********************************************
	* ASSIGN METHOD: lIsSeparator
	***********************************************
	* Force the property to be read only!
	***********************************************
	FUNCTION lIsSeparator_ASSIGN(tlValue)
	ENDFUNC
	
	***********************************************
	* ASSIGN METHOD: lIsItem
	***********************************************
	* Force the property to be read only!
	***********************************************
	FUNCTION lIsItem_ASSIGN(tlValue)
	ENDFUNC
	
	***********************************************
	* ASSIGN METHOD: lIsLink
	***********************************************
	* Force the property to be read only!
	***********************************************
	FUNCTION lIsLink_ASSIGN(tlValue)
	ENDFUNC	
	
ENDDEFINE

************************************************************************************
* Taskbar JumpList Separator Item
************************************************************************************
* Represents a JumpList Separator Item object. This is simply a line drawn between
* items in the JumpList. 
*
* It is only valid in the User Tasks section, however, the library overcomes this
* limitation by creating an empty custom category instead.
* Therefore, your application can create this class and pass it into the custom 
* categories list as desired.
************************************************************************************
DEFINE CLASS Jumplist_Separator AS Jumplist_Base_Item 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	lIsSeparator = .T.							&& OVERRIDE DEFAULT VALUE
	***********************		
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************
ENDDEFINE

************************************************************************************
* Taskbar JumpList Item
************************************************************************************
* Represents a JumpList Item object
*
* An item in the Jumplist is really just a windows shortcut to a specific file which
* is presumably registered to be opened by this application. For example, a .DOC file
* would be a JumpList Item for Micrsoft Word. If your application registers to handle
* the DOC file type as well, then you can use this class to represent a specific
* DOC file to open from your JumpList.
************************************************************************************
DEFINE CLASS Jumplist_Item AS Jumplist_Base_Item 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	lIsItem = .T.							&& OVERRIDE DEFAULT VALUE
	cAppPath = ""							&& Full path & filename to the application
	cTitle = ""								&& Title of the Shortcut as displayed in the Jump List
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************

	***********************************************
	* ASSIGN METHOD: cAppPath
	***********************************************
	* Default the Title Property from cAppPath
	* if not already specified.
	***********************************************
	FUNCTION cAppPath_ASSIGN(tcVal)
		THIS.cAppPath = tcVal
		IF EMPTY(ALLTRIM(THIS.cTitle))
			THIS.cTitle = JUSTFNAME(tcVal)
		ENDIF
	ENDFUNC
	
	********************************************************
	* INIT
	********************************************************
	* Parms: Path to the Item ( optional )
	*		 Title of the Item ( optional )
	********************************************************
	FUNCTION INIT(tcAppPath, tcTitle)
		IF VARTYPE(tcAppPath)="C"
			THIS.cAppPath = tcAppPath
		ENDIF
		IF VARTYPE(tcTitle)="C"
			THIS.cTitle = tcTitle
		ENDIF
	ENDFUNC
ENDDEFINE

************************************************************************************
* Taskbar JumpList Link Item
************************************************************************************
* Represents a JumpList Link object
*
* A link item in the Jumplist is really just a windows shortcut. Anything you can
* do with a normal shortcut, can be done here also. Creating this object and adding
* it to either your User Task section or Custom Category section will allow any
* application to open from your JumpList, and with the given command line arguments.
*
* todo: create a subclass that can be used to trigger functionality in the running
* application by opening a stub .exe and passing windows messages to the running 
* instance. This is how Windows Messanger, for example, can change status from the
* jumplist while the app is running.
************************************************************************************
*NOTE: cShowCmd does not appear to work, perhaps a bug in the IShellLink code or a misunderstanding on my part?
DEFINE CLASS Jumplist_Link AS Jumplist_Item 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	lIsLink = .T.							&& OVERRIDE DEFAULT VALUE
	cIconPath = ""							&& Full path to icon file ( if using a custom one )
	nIconIndex = 0							&& Numeric index value of the icon resource to load from cIconPath
	cWorkingDir = ""						&& Specifies the working directory for the shortcut
	cArguments = ""							&& Command line arguments for the shortcut
	cShowCmd = ""							&& How the Shortcut window should be launched ( allowed values: NORMAL,MINIMIZED,MAXIMIZED )
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	***********************************************
	* GetShowCmd
	***********************************************
	*Convet the Show Command String into appropriate
	*Win32API numeric value
	************************************************
	FUNCTION GetShowCmd()
		LOCAL lcSC, lnVal
		lcSC = UPPER(ALLTRIM(THIS.cShowCmd))
		DO CASE
			*Normal
			CASE lcSC == "NORMAL"
				lnVal = SW_SHOWNORMAL
			*Minimized
			CASE lcSC == "MINIMIZED"
				lnVal = SW_SHOWMINNOACTIVE
			*Maximized
			CASE lcSC == "MAXIMIZED"
				lnVal = SW_SHOWMAXIMIZED
			*??
			OTHERWISE
				lnVal = SW_SHOWNORMAL
		ENDCASE
		RETURN lnVal
	ENDFUNC
ENDDEFINE

************************************************************************************
* Taskbar Jumplist_FileType Registration Class
************************************************************************************
* Handles registering file type operations on behalf of the application for
* allowing JumpList_Items to be displayed on the Jumplist, and subsequently being
* opened by the application.
************************************************************************************
DEFINE CLASS Jumplist_FileTypeReg AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	cProgID = ""						&& ProgID to use when registering file types ( Note: the final progid used will end with the file extension )
	cFailedMsg = ""						&& Contains Failure Msg from the last operation
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	*****************************************************
	* _PrepVars
	*****************************************************
	* Prepares the ProgID, File Type Extension and 
	* Current User variables to be passed to the 
	* DLL Functions.
	*
	* Parms are passed by reference so the values can
	* be modified here. Aborts if no ProgID can be found.
	******************************************************
	PROTECTED FUNCTION _PrepVars(tcProgID, tcExt, tlCurrentUser)
		*Pull ProgID
		tcProgID = THIS._GetProgID()
		*Abort if none!
		IF EMPTY(tcProgID)
			THIS.cFailedMsg = "No ProgID was specified and one could not be generated automatically!"		
			RETURN .F.
		ENDIF
		*Add period to beginning
		IF LEFT(tcExt,1)<>"."
			tcExt = "."+tcExt
		ENDIF
		*Add the File Extension as the last part of the ProgID
		tcProgID = tcProgID + tcExt

		*Convert to Wide Char
		tcProgID = THIS.MakeWideString(tcProgID)
		tcExt = THIS.MakeWideString(tcExt)			
		*Convert logical to numeric
		tlCurrentUser = IIF(tlCurrentUser,1,0)
	ENDFUNC
	
	***********************************************
	* _GetProgID
	***********************************************
	* Returns a ProgID suitable for using to when
	* registering for file type handling. 
	* 
	* The function will return a ProgID if it was
	* specified in the cProgID property, otherwise
	* it will attempt to create it from the APPID.
	************************************************
	PROTECTED FUNCTION _GetProgID()
		LOCAL lcProgID
		lcProgID = ""
		*If ProgID wasn't specified, use AppID and add .ProgID text to the end.
		IF EMPTY(THIS.cProgID)
			LOCAL loTBM
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				lcProgID = loTBM.GetApplicationID()
			ENDIF
			IF !EMPTY(lcProgID)
				lcProgID = lcProgID + ".ProgID"
			ENDIF
		ELSE
			lcProgID = THIS.cProgID
		ENDIF
		RETURN ALLTRIM(lcProgID)
	ENDFUNC
	
	***********************************************
	* _ProcResultCode
	***********************************************
	* Processes the numeric result code from several
	* of the DLL File Type functions, and if the
	* result code indicates failure, tries to 
	* populate the cFailedMsg property with a meaningful
	* error message.
	************************************************
	PROTECTED FUNCTION _ProcResultCode(tnResult)
		LOCAL llOK
		*Result code of 0 means the function worked.
		llOK = (tnResult == 0)
		IF llOK
			*Clear Failed msg
			THIS.cFailedMsg = ""
		ELSE
			*Set Failed Msg ( -1 = Access Denied, others = ? )
			THIS.cFailedMsg = IIF(tnResult=-1,"Access Denied! Try running as Administrator!","Error code: " + TRANSFORM(tnResult))
		ENDIF
		RETURN llOK
	ENDFUNC	

	********************************************************************************
	* RegisterFileType
	********************************************************************************
	* Register's the application to be a viewer of the specified file extension.
	* This applies whether the file extension already exists or is brand new.
	* An example would be registering a TXT file, so that your application can
	* open a TXT file when passed a file name with the TXT extension.
	* This is useful here, only for purposes of having a JumpList Item.
	* 
	* The tlCurrentUser flag indicates if the registration 
	* should occur only for the current logged in user, or for all users on 
	* the machine. All users, typically requires Admin Priveleges, while 
	* current user, does not.
	* 
	* The Description and Icon File(optional) specify what will be displayed when the user
	* selects the properties option from a JumpList_Item by right clicking and selecting
	* properties from the context menu.
	*
	* The function fails if no AppID was previously set by the code via the 
	* Taskbar Manager class, since without this, Windows cannot associate your 
	* application instance to the registered progid.
	********************************************************************************
	FUNCTION RegisterFileType(tcType, tlCurrentUser, tcDescription, tcIconFile)
		LOCAL lcProgID, llOK, lcAppID, lnResult
		STORE "" TO lcProgID
		*Prepare the Variables for sending to the DLL ( also retrieves progid )
		IF !THIS._PrepVars(@lcProgID, @tcType, @tlCurrentUser)
			RETURN .F.
		ENDIF
		*Get the current AppID
		LOCAL loTBM
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			lcAppID = loTBM.GetApplicationID()
		ENDIF
		IF EMPTY(lcAppID)
			THIS.cFailedMsg = "No AppID was specified!"
			RETURN .F.
		ENDIF
		*Convert strings for the DLL
		lcAppID = THIS.MakeWideString(lcAppID)
		tcDescription = THIS.MakeWideString(tcDescription)
		tcIconFile = THIS.MakeWideString(tcIconFile)
		*DLL will do the work
		IF THIS.Parent.Parent.IsDLL_Loaded()
			lnResult = RegisterFileType(lcProgID, tcType, tlCurrentUser, lcAppID, tcDescription, tcIconFile)
			*Process the result code
			llOK = THIS._ProcResultCode(lnResult)
		ELSE
			THIS.cFailedMsg = "DLL Not Loaded"
		ENDIF		
		RETURN llOK
	ENDFUNC
	

	*********************************************************************************
	* UnRegisterFileType
	*********************************************************************************
	* Removes the registration data so that the application will no longer be
	* considered a viewer of the specified file type (extension).
	* This applies whether the file extension already exists or is brand new.
	* 
	* The tlCurrentUser flag indicates if the previous registration 
	* was only for the current logged in user, or for all users on 
	* the machine. All users, typically requires Admin Priveleges, while 
	* current user, does not.
	*
	*  This function does not remove the file extension from the system.
	*  Use DeleteFileType() to completely remove a file extension from the system.
	*********************************************************************************
	FUNCTION UnRegisterFileType(tcType,tlCurrentUser)
		LOCAL lcProgID, llOK, lnResult
		STORE "" TO lcProgID
		*Prepare the Variables for sending to the DLL ( also retrieves progid )		
		IF !THIS._PrepVars(@lcProgID, @tcType, @tlCurrentUser)
			RETURN .F.
		ENDIF
		*DLL will do the work		
		IF THIS.Parent.Parent.IsDLL_Loaded()
			lnResult = UnRegisterFileType(lcProgID, tcType, tlCurrentUser)
			*Process the result code			
			llOK = THIS._ProcResultCode(lnResult)
		ELSE
			THIS.cFailedMsg = "DLL Not Loaded"
		ENDIF		
		RETURN llOK
	ENDFUNC
	
	********************************************************************
	* DeleteFileType
	********************************************************************
	* Deletes a File Type Registration entirely from the registry.
	* This is only useful when you are uninstalling your application
	* which created it's own, unique file type extension for itself.
	*
	* The function will fail if other programs are registered to view 
	* the file type as a failsafe in case the user specified the wrong
	* extension, or did not realize it was being used by another app.
	********************************************************************	
*** todo: not tested of fully implemented in the DLL yet.
*!*		FUNCTION DeleteFileType(tcType,tlCurrentUser)
*!*			LOCAL lcProgID, llOK, lnResult
*!*			STORE "" TO lcProgID
*!*			IF !THIS._PrepVars(@lcProgID, @tcType, @tlCurrentUser)
*!*				RETURN .F.
*!*			ENDIF
*!*			IF THIS.Parent.Parent.IsDLL_Loaded()
*!*				lnResult = DeleteFileType(lcProgID, tcType, tlCurrentUser)
*!*				llOK = THIS._ProcResultCode(lnResult)
*!*			ELSE
*!*				THIS.cFailedMsg = "DLL Not Loaded"
*!*			ENDIF		
*!*			RETURN llOK
*!*		ENDFUNC
	
	**************************************************************
	* IsFileTypeRegistered
	**************************************************************
	* Returns .T. if the specified file type extension
	* is currently registered to be viewed by this
	* application ( based on the ProgID ).
	*
	* The tlCurrentUser flag indicates if the registration 
	* is for the current logged in user, or for all users on 
	* the machine. 
	**************************************************************
	FUNCTION IsFileTypeRegistered(tcType, tlCurrentUser)
		LOCAL llReg, lcProgID
		STORE "" TO lcProgID
		*Prepare the Variables for sending to the DLL ( also retrieves progid )		
		IF !THIS._PrepVars(@lcProgID, @tcType, @tlCurrentUser)
			RETURN .F.
		ENDIF
		*DLL will do the work		
		IF THIS.Parent.Parent.IsDLL_Loaded()
			llReg = (IsFileTypeRegistered(lcProgID,tcType,tlCurrentUser) == 1)
		ENDIF		
		RETURN llReg
	ENDFUNC
	**
	
	**************************************************************
	* IsProgIDRegistered
	**************************************************************
	* Return's true if this application is registered to handle viewing
	* the specified file type. Although it sounds similar to the
	* IsFileTypeRegistered() method above, this function checks a different
	* part of the Windows Registry. It looks for the ProgID entry in the 
	* registry, rather than anything directly related to the File Type.
	* The FileType association is made by linking to this entry via the 
	* ProgID.
	**************************************************************	
	FUNCTION IsProgIDRegistered(tcType, tlCurrentUser)
		LOCAL llReg, lcProgID
		STORE "" TO lcProgID
		*Prepare the Variables for sending to the DLL ( also retrieves progid )		
		IF !THIS._PrepVars(@lcProgID, @tcType, @tlCurrentUser)
			RETURN .F.
		ENDIF
		*DLL will do the work		
		IF THIS.Parent.Parent.IsDLL_Loaded()
			llReg = (IsProgIDRegistered(lcProgID,tlCurrentUser) == 1)
		ENDIF		
		RETURN llReg
	ENDFUNC
	**	
ENDDEFINE



************************************************************************************
* Taskbar Toolbar Class
************************************************************************************
* Represents and manages all aspects of the Windows 7 Taskbar Toolbar. This is the
* toolbar area that lives at the very bottom of the Preview Window. 
************************************************************************************
DEFINE CLASS Taskbar_Toolbar AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	nButtonCount = 0									&& # of buttons in the toolbar
	cToolbarText = ""									&& Text displayed in the toolbar area
	***********************	
	* PUBLIC OBJECTS      *
	***********************	
	ADD OBJECT ButtonList AS Win7TLIB_List 				&& List of Toolbar Buttons
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _lCreated, _hOrigProc
	_lCreated = .F.										&& Flag if the toolbar was created by the DLL	
	_hOrigProc = 0										&& VFP Original Window Procedure Handler
	***********************
	* END OF PROPERTIES   *
	***********************
	
	***********************************************
	* ASSIGN METHOD: cToolbarText
	***********************************************
	* Automatically update the toolbar tip window
	* when this property changes
	***********************************************
	FUNCTION cToolbarText_ASSIGN(tcVal)
		THIS.cToolbarText = tcVal
		THIS._SetToolbarTooltip(tcVal)
	ENDFUNC
	
	***********************************************
	* ASSIGN METHOD: nButtonCount
	***********************************************
	* When this property changes:
	* 1) Clear the ButtonList
	* 2) Create new button objects based on this count
	* 3) Add them to the Button List
	***********************************************
	FUNCTION nButtonCount_ASSIGN(tnVal)
		*Assign the button count
		THIS.nButtonCount = tnVal
		*Clear the button list
		LOCAL loButton, lnLoop
		THIS._ClearButtonList()
		*Create a button object and add to the list up to the button count
		lnLoop = 0
		DO WHILE lnLoop < tnVal
			lnLoop = lnLoop + 1 
			loButton = CREATEOBJECT("Taskbar_Toolbar_Button",THIS.Parent.IsDLL_Loaded())
			IF VARTYPE(loButton)="O" AND !ISNULL(loButton)
				THIS.ButtonList.AddItem(lnLoop,loButton)
			ENDIF
		ENDDO
	ENDFUNC
	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS._CLEANUP()
	ENDFUNC
	
	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		*Remove Win32 API Message handling
		THIS._Remove_Win32API_Messages()
		*Clear the button list
		THIS._ClearButtonList()
	ENDFUNC
	
	***********************************************
	* _CreateToolbar
	***********************************************
	* Internal method used to initiate creating the
	* toolbar. This can only occur once, since the
	* toolbar cannot be removed once created, thus
	* there's no need to call this method again.
	************************************************
	PROTECTED FUNCTION _CreateToolbar()
		*Only do this one time, since a toolbar can only be created once, and never
		*removed.
		IF !THIS._lCreated
			*Set Flag
			THIS._lCreated = .T.
			*Setup the Bar
			THIS._ManageToolbar(.T.)
			*Setup Win32 API messages
			THIS._Setup_Win32API_Messages()
		ENDIF
	ENDFUNC
	
	***********************************************
	* _ManageToolbar
	***********************************************
	* Internal method which manages both the creation
	* and updating of the toolbar, depending on the 
	* flag sent to the method.
	************************************************
	PROTECTED FUNCTION _ManageToolbar(tlCreate)
		*Pull HWND to use for the Toolbar
		LOCAL lnHWND
		lnHWND = THIS.Parent.GethWnd()
		
		*Load all icons for the buttons list
		THIS._LoadIcons()	
		
		*Set the toolbar tooltip text
		THIS._SetToolbarTooltip(THIS.cToolbarText)

		*Parse properties of each button object
		LOCAL loB, lnNum, lnIcon, lcTip, lnE, lnV, lnC, lnS
		lnNum = 0
		FOR EACH loB IN THIS.ButtonList FOXOBJECT
			lnNum = lnNum + 1
			lnIcon = loB.GetIconHandle()
			lcTip = THIS.MakeWideString(loB.cToolTip)
			lnE = IIF(loB.lEnabled,1,0)
			lnV = IIF(loB.lVisible,1,0)
			lnC = IIF(loB.lCloseOnClick,1,0)
			lnS = IIF(loB.lSpacer,1,0)

			IF THIS.Parent.IsDLL_Loaded()				
				*Set the button data to the DLL for processing later.
				SetToolbarButton(lnHWND,lnNum,lnIcon,lcTip,lnE,lnV,lnC,lnS)
			ENDIF
		ENDFOR
		******************************
		** Have the DLL do the work **
		******************************
		IF THIS.Parent.IsDLL_Loaded()			
			IF tlCreate
				*Call the DLL to create the toolbar
				CreateToolbar(lnHWND)
			ELSE
				*Call the DLL to update the toolbar
				UpdateToolbar(lnHWND)
			ENDIF
		ENDIF
	ENDFUNC
	
	***********************************************
	* _SetToolbarTooltip
	***********************************************
	* Internal method which sets the tooltip string
	* of the Toolbar ( hovers above the Preview 
	* Window ). Sending a blank string will clear
	* the tooltip. This method will not do anything
	* if the toolbar has not yet been created.
	************************************************
	*NOTE: We ALLOW a blank string here since it's used to clear the Toolbar Text
	PROTECTED FUNCTION _SetToolbarTooltip(tcVal)
		*Don't run if the toolbar has not been created
		IF THIS._lCreated
			LOCAL lcTip
			lcTip = THIS.MakeWideString(tcVal)
			IF THIS.Parent.IsDLL_Loaded()				
				SetToolbarTooltip(THIS.Parent.GethWnd(),lcTip)
			ENDIF
		ENDIF
	ENDFUNC
	
	***********************************************
	* _ClearButtonList
	***********************************************
	* Internal method to remove all button objects
	* from the button list.
	************************************************
	PROTECTED FUNCTION _ClearButtonList()
		THIS.ButtonList.ClearList()
	ENDFUNC
	
	***********************************************
	* _LoadIcons
	***********************************************
	* Internal method which causes each button object
	* in the ButtonList to load it's associated image
	* from it's internal icon file name.
	************************************************
	PROTECTED FUNCTION _LoadIcons()
		LOCAL loB, lcIcon
		FOR EACH loB IN THIS.ButtonList FOXOBJECT
			loB.LoadIcon()
		ENDFOR
	ENDFUNC
	
	***********************************************
	* Setup_Win32API_Messages
	***********************************************
	* Uses BindEvents() to intercept and process
	* Toolbar related Win32API messages
	************************************************
	PROTECTED FUNCTION _Setup_Win32API_Messages()
		IF THIS.Parent.IsDLL_Loaded()
				
			*Find the original VFP Window Proc Handler and store for later use
			THIS._hOrigProc = GetWindowLong(THIS.Parent.GethWnd(), GWL_WNDPROC) 

			*Bind to each message #
			=BINDEVENT(THIS.Parent.GethWnd(), WM_COMMAND, THIS, "_W32API_Msg_Handler", 4) 
		ENDIF
	ENDFUNC
	
	***********************************************
	* Remove_Win32API_Messages
	***********************************************
	* Removes all Win32API messages previously bound
	************************************************
	PROTECTED FUNCTION _Remove_Win32API_Messages()
		IF THIS.Parent.IsDLL_Loaded()		
			*Unbind all Win32 API messages from this form that we set up
			UNBINDEVENTS(THIS.Parent.GethWnd(),WM_COMMAND)
		ENDIF
	ENDFUNC
		
	
	*****************************************************
	* W32API_Msg_Handler
	*****************************************************
	* Process Win32 API Messages related to the toolbar
	*****************************************************
	*todo: should I set autoyield .F. here, and restore once code is done?
	PROTECTED FUNCTION _W32API_Msg_Handler(hWnd, Msg, wParam, lParam)
		LOCAL loTBM, loForm, loHelper, loHelperForm
		STORE NULL TO loTBM, loForm, loHelper, loHelperForm
		
		*Grab Taskbar Manager Object
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
		
			*Grab the Form object registered to this hWnd
			loForm = loTBM.GetForm_From_hWnd(hWnd)
		
			*Grab the Helper Form Object
			loHelperForm = loTBM.GetForm_From_hWnd(THIS.Parent.nHelperForm_hWnd)
			*NOTE: There was a bug in GetForm_From_hWnd() which would "somehow" reset the value
			*of loForm from the line above, upon completion of 2nd call to it above. 
			*Fixed by removing the FOR EACH loForm call, but I don't understand why!
			*I think it's a vfp bug.
			*todo: see if I can get someone like Christof to replicate and explain it.
		ENDIF

		* Grab the Helper Object Name for the form from the Taskbar class
		IF VARTYPE(loHelperForm)="O" AND !ISNULL(loHelperForm)
			loHelper = THIS.Get_Object_From_StringName(THIS.Parent.cHelperObj,loHelperForm)
		ENDIF

		*Did we get vaid objects?
		IF VARTYPE(loForm)="O" AND !ISNULL(loForm) AND ;
	  	   VARTYPE(loHelper)="O" AND !ISNULL(loHelper)
	
			*Process all Win32API Messages here
			DO CASE

				CASE Msg = WM_COMMAND
				
					LOCAL lnID, lnEvent
					*Parse wParam as HIWORD() and LOWORD()
					lnID = BITAND(wParam,0xffff)
					lnEvent = (BITAND(wParam,0xffff*0x10000))/0x10000

					*Ignore unless we got the THBN_CLICKED message
					IF lnEvent == THBN_CLICKED
					
						*Call the Call Back Handler Method if it exists
						IF PEMSTATUS(loHelper,"ON_TOOLBAR_BUTTON_CLICK",5)
							loHelper.On_ToolBar_Button_Click(THIS,loForm,lnID)
						ENDIF
						
						*Flag that we handled the message
						RETURN 0
					ENDIF
			ENDCASE
		ELSE
		*todo: throw error here?
		ENDIF
		*Let VFP Handle all Win32API messages
		RETURN CallWindowProc(THIS._hOrigProc, hWnd, Msg, wParam, lParam)
	ENDFUNC		
	
	***********************************************
	* GetButton
	***********************************************
	* Returns a button object from the Button List
	* based on the numeric key given or NULL if
	* not found.
	************************************************
	FUNCTION GetButton(tnWhich)
		RETURN THIS.ButtonList.GetItem(tnWhich)
	ENDFUNC

	***********************************************
	* UpdateToolbar
	***********************************************
	* A double duty method used to both create or
	* update the toolbar. The function knows which
	* to call based on whether the create flag was
	* already set. This provides convenience to the
	* app developer who doesn't need to manage this.
	* This is important since Windows does not allow
	* creating the toolbar more than once, and does
	* not allow removing it, so updating is the only
	* choice once the toolbar has been created.
	************************************************
	FUNCTION UpdateToolbar()
		*If we've not yet created the toolbar, do it now!
		IF !THIS._lCreated
			THIS._CreateToolbar()
		ELSE
			THIS._ManageToolbar(.F.)
		ENDIF
	ENDFUNC	
	
	**************************************************
	* ClearToolbar
	**************************************************
	* Effectively clears all buttons from the toolbar.
	* All internal data is also cleared. Since Windows
	* does not allow removal of the toolbar, we can 
	* fake it, by setting button count to 0, which 
	* essentially updates the toolbar with all hidden
	* buttons.
	***************************************************
	FUNCTION ClearToolbar()
		WITH THIS
			.nButtonCount = 0
			.cToolbarText = ""
			.UpdateToolbar()	
		ENDWITH
	ENDFUNC		

ENDDEFINE

************************************************************************************
* Taskbar Toolbar Button Class
************************************************************************************
* Represents a toolbar button object that lives in the Toolbar of the Preview Window
************************************************************************************
DEFINE CLASS Taskbar_Toolbar_Button AS Win7TLIB_Base 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	cIcon = ""								&& Name of the icon to use with the button
	cTooltip = ""							&& Tooltip of the button bar
	lEnabled = .T.							&& Is button enabled?
	lVisible = .T.							&& Is button visible?
	lSpacer = .F.							&& Is button a spacer, ie act as a space between others?
	lCloseOnClick = .T.						&& Should the button click close the flyout window?
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _nHandle						&& Handle to the loaded icon
	_nHandle = 0
	***********************
	* END OF PROPERTIES   *
	***********************
	
	***********************************************
	* ASSIGN METHOD: cIcon
	***********************************************
	* Clear any pre-existing Icon Handle when this
	* property changes.
	***********************************************
	FUNCTION cIcon_ASSIGN(tcVal)
		THIS.cIcon = tcVal
		*Clear any pre-existing handle
		THIS.ClearIconHandle()
	ENDFUNC
	
	***********************************************
	* ASSIGN METHOD: lSpacer
	***********************************************
	* If this propery was just set, clear all the
	* other properties that are not relevant to a
	* Spacer (icon, tooltip, enabled, visible, etc)
	***********************************************
	FUNCTION lSpacer_ASSIGN(tlVal)
		THIS.lSpacer = tlVal
		*If button object was just assigned as a spacer, clear all props.
		IF tlVal
			WITH THIS
				.ClearIconHandle()
				STORE "" TO .cIcon, .cTooltip
				STORE .F. TO .lEnabled, .lVisible, .lCloseOnClick
			ENDWITH
		ENDIF
	ENDFUNC	
	
	********************************************************
	* INIT
	********************************************************
	* Parms: Logical if the DLL Was Loaded
	********************************************************
	FUNCTION INIT(tlDllLoaded)
		THIS._lDllLoaded = tlDllLoaded
	ENDFUNC

	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS.ClearIconHandle()
	ENDFUNC	
	
	***********************************************
	* ClearIconHandle
	***********************************************
	* Clears the internal icon handle property
	* so that the windows resource data will be 
	* released from memory.
	************************************************
	FUNCTION ClearIconHandle()
		IF THIS._lDllLoaded AND THIS._nHandle > 0
			DestroyIcon(THIS._nHandle)
		ENDIF
		THIS._nHandle = 0
	ENDFUNC
	
	************************************************
	* LoadIcon
	************************************************
	* Loads the icon ( previously specified in the
	* cIcon property and stores the handle to the
	* image. A copy is actually made due to a bug
	* in the LOADPICTURE() handling. As a result,
	* ClearIconHandle() must be called to release
	* the memory used by the handle, as this is 
	* something VFP will not automatically do, 
	* unlike when using LOADPICTURE() which VFP
	* will do automatically.
	************************************************
	FUNCTION LoadIcon()
		*Clear the handle first
		THIS.ClearIconHandle()
		*Load icon image and store handle
		LOCAL loIcon, lnCopy
		IF !EMPTY(ALLTRIM(THIS.cIcon))
			IF THIS._lDllLoaded
				loIcon = THIS.LoadImage(THIS.cIcon)
				IF VARTYPE(loIcon)="O" AND !ISNULL(loIcon)
					*Create a copy since for some reason, once LOADPICTURE() is called again, the previous handle is killed.
					lnCopy = CopyIcon(loIcon.Handle)
					IF VARTYPE(loIcon)="O" AND !ISNULL(loIcon)
						THIS._nHandle = lnCopy
					ELSE
						ERROR "Failed to copy icon from loaded image: " + THIS.cIcon
					ENDIF
				ELSE
					ERROR "Failed to load icon from image: " + THIS.cIcon
				ENDIF
			ENDIF
		ENDIF
	ENDFUNC
	
	***********************************************
	* GetIconHandle
	***********************************************
	* Returns the protected Icon Image handle
	************************************************
	FUNCTION GetIconHandle()
		RETURN THIS._nHandle
	ENDFUNC
	
	***********************************************
	* CopyButton
	***********************************************
	* Copies the important properties of the source
	* button object to the destination object.
	************************************************
	*todo: verify both objects are from the button class
	* to ensure the properties exist or just verify the 
	* properties exist! :)
	FUNCTION CopyButton(toSrc,toDst)
		IF VARTYPE(toSrc)="O" AND !ISNULL(toSrc) AND ;
		   VARTYPE(toDst)="O" AND !ISNULL(toDst)
		   *Copy the properties from the Source Button Object into the Destination Button Object
		   toDst.cIcon = toSrc.cIcon
		   toDst.cTooltip = toSrc.cTooltip 
		   toDst.lEnabled = toSrc.lEnabled 
		   toDst.lVisible = toSrc.lVisible 
		   toDst.lSpacer = toSrc.lSpacer 
		   toDst.lCloseOnClick = toSrc.lCloseOnClick 
		ENDIF
	ENDFUNC
ENDDEFINE

************************************************************************************
* Taskbar Proxy MDI Window Class
************************************************************************************
* An Invisible VFP Top Level Form used to act as a Proxy Window for setting 
* Custom Thumbnail & Live Preview Functionality for all Non-Top-Level forms in VFP,
* that are running in MDI Taskbar mode.
* 
* This is done since the DWM of Windows 7 can only communicate to top-level Windows.
* This class handles all DWM callback messages and generates the preview image data.
*
* This class should not be used directly by the application. It is created and
* managed by the MDI & TDI Taskbar classes.
************************************************************************************
DEFINE CLASS Taskbar_Proxy_MDI_Window AS Form
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	ShowWindow = 2						&& Top-Level Form
	Height = 1							&& Make size small
	Width = 1							&& Make size small
	Visible = .F.						&& Make invisible, we don't want to see it!
	nProxySrchWnd = 0					&& The hWnd of the VFP form for which this class is a proxy
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _hOrigProc, _lDllLoaded
	_hOrigProc = 0						&& VFP Original Window Procedure Handler	
	_lDllLoaded = .F.					&& Flag to indicate if the Win7TLib dll was loaded
	***********************
	* END OF PROPERTIES   *
	***********************

	***************************************************************
	* INIT
	***************************************************************
	* Parms: Logical if the DLL Was Loaded
	* 
	* Summary: Bind to several Win32 API Messages for this form.
	***************************************************************
	FUNCTION INIT(tlDllLoaded)	
		*Set the flag
		THIS._lDllLoaded = tlDllLoaded
		*Bind Events
		IF THIS._lDllLoaded	
			*Find the original VFP Window Proc Handler and store for later use
			THIS._hOrigProc = GetWindowLong(THIS.hWnd, GWL_WNDPROC) 
			*****************************
			*Bind to each message #
			*****************************		
			*	Draw Thumbnail Message	*
			=BINDEVENT(THIS.HWnd, WM_DWMSENDICONICTHUMBNAIL, THIS, "_W32API_Msg_Handler", 4) 
			*	Draw LivePreview Message	*
			=BINDEVENT(THIS.hWnd, WM_DWMSENDICONICLIVEPREVIEWBITMAP, THIS, "_W32API_Msg_Handler", 4) 
			*	Activate Message - Will occur when the user clicks on the Preview Window	*
			=BINDEVENT(THIS.hWnd, WM_ACTIVATE, THIS, "_W32API_Msg_Handler", 4) 
			*	Close Message - Will occur when the user closes the Preview Window	*
			=BINDEVENT(THIS.hWnd, WM_CLOSE, THIS, "_W32API_Msg_Handler", 4) 
		ENDIF			
	ENDFUNC
	
	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		IF THIS._lDllLoaded	
			*Unbind all Win32 API messages from this form
			UNBINDEVENTS(THIS.HWnd)
		ENDIF
		*todo: how do I unbindevents what the toolbar createproxy() method did?
		DEBUGOUT "Destroying Proxy Form: " + THIS.Name
	ENDFUNC
	
	*********************************************************
	* _GetHelperObjects
	*********************************************************
	* Returns object references for:
	* 1) The Proxy Source Form that is usiing this Proxy Window
	* 2) The Parent Form which contains the Proxy Source Form
	* 3) The Helper Object sitting on the Proxy Source Form
	* 4) The Preview Object of the Taskbar associated with the Source Form
	*
	* All variables must be called by Reference. 
	* Returns .T. only if all objects successfully created.
	*********************************************************
	PROTECTED FUNCTION _GetHelperObjects(toForm, toParentForm, toHelper, toPreview)
		LOCAL llOK, loHelperForm, loTaskbar
		*Grab Proxy Source Form Object
		toForm = THIS.GetProxySrcForm()
		llOK = VARTYPE(toForm)="O" AND !ISNULL(toForm)
		*Ok to contine?
		IF llOK
			*Grab the Taskbar Object which created this proxy window
			LOCAL loTBM
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				loTaskbar = loTBM.TaskbarList.GetItem(THIS.nProxySrchWnd)
			ENDIF
			llOK = VARTYPE(loTaskbar)="O" AND !ISNULL(loTaskbar)
		ENDIF
		*Ok to contine?			
		IF llOK
			*Grab the Preview Object from the Taskbar
			toPreview = loTaskbar.Preview
			llOK = VARTYPE(toPreview)="O" AND !ISNULL(toPreview)			
		ENDIF
		*Ok to contine?			
		IF llOK
			*Grab the Parent Form ( not necessarily the TOP Level Form if this form is running in VFP )
			toParentForm = loTaskbar.GetParentForm(toForm)
			llOK = VARTYPE(toParentForm)="O" AND !ISNULL(toParentForm)
		ENDIF
		*Ok to continue?
		IF llOK
			*Grab the Helper Form Object
			loHelperForm = loTBM.GetForm_From_hWnd(loTaskbar.nHelperForm_hWnd)
			* Grab the Helper Object Name for the form from the Taskbar class
			IF VARTYPE(loHelperForm)="O" AND !ISNULL(loHelperForm)
				toHelper = loTaskbar.Get_Object_From_StringName(loTaskbar.cHelperObj,loHelperForm)
			ENDIF
			llOK = VARTYPE(toHelper)="O" AND !ISNULL(toHelper)
		ENDIF		
		RETURN llOK
	ENDFUNC
	
	*********************************************************
	* W32API_Msg_Handler
	*********************************************************
	* Process Win32 API Messages related to the Proxy Window
	*********************************************************
	*NOTE: Don't bother to check if dll loaded since we 
	* 	   don't set up bind events if that fails so this 
	*      code won't be called	
	*********************************************************
	*todo: should I set autoyield .F. here, and restore once code is done?
	PROTECTED FUNCTION _W32API_Msg_Handler(hWnd, Msg, wParam, lParam)
		LOCAL loForm, loParent, loHelper, loPreview
		
		*Populate helper objects: Taskbar Object, Proxy Src Form, Proxy Src Parent Form
		IF THIS._GetHelperObjects(@loForm, @loParent, @loHelper, @loPreview)
		
			*Process all Win32API Messages here
			DO CASE
*!*					*Draw Custom Thumbnail Preview Message
*!*					CASE Msg = WM_DWMSENDICONICTHUMBNAIL
*!*					
*!*						LOCAL lnW,lnH
*!*						*Parse wParam as HIWORD() and LOWORD() to retrieve the width & height of the Thumbar window
*!*						lnH = BITAND(lParam,0xffff)
*!*						lnW = (BITAND(lParam,0xffff*0x10000))/0x10000	
*!*						*Call DLL to create a thumbnail image of the proxy src window
*!*						CreateThumbnailImage(loForm.hWnd, THIS.hWnd, lnW, lnH)
*!*						*Return 0 to signify we handled the message
*!*						RETURN 0

*!*					*Draw Custom Live Preview Message
*!*					CASE Msg = WM_DWMSENDICONICLIVEPREVIEWBITMAP
*!*						LOCAL lnL, lnT
*!*						*Get offsets for Left & Top properties
*!*						loTaskbar.Preview.Utils.GetScreen_TopLeft_Offset(@lnL,@lnT)
*!*						*Adjust Form's properties with the new offsets
*!*						lnL = loForm.Left + lnL
*!*						lnT = loForm.Top + lnT
*!*						*Ask DLL to generate a peek image and pass adjusted left & top values of the form.
*!*						CreateLivePreviewImage(loForm.hWnd, THIS.hWnd, lnL, lnT)
*!*						*Return 0 to signify we handled the message					
*!*						RETURN 0

				*Draw Custom Thumbnail Preview Message
				CASE Msg = WM_DWMSENDICONICTHUMBNAIL
				
					LOCAL lnW,lnH
					*Parse wParam as HIWORD() and LOWORD() to retrieve the width & height of the Thumbar window
					lnH = BITAND(lParam,0xffff)
					lnW = (BITAND(lParam,0xffff*0x10000))/0x10000	
					
					*Call the Call Back Handler Method if it exists
					IF PEMSTATUS(loHelper,"ON_THUMBNAIL_DRAW",5)
						loHelper.On_ThumbNail_Draw(loPreview,loForm,lnW,lnH)
					ENDIF
					*Return 0 to signify we handled the message
					RETURN 0

				*Draw Custom Live Preview Message
				CASE Msg = WM_DWMSENDICONICLIVEPREVIEWBITMAP
					*Call the Call Back Handler Method if it exists				
					IF PEMSTATUS(loHelper,"ON_LIVEPREVIEW_DRAW",5)
						loHelper.On_LivePreview_Draw(loPreview,loForm)
					ENDIF
					*Return 0 to signify we handled the message					
					RETURN 0

			*Thumbnail Preview Window was Activated		
			CASE Msg = WM_ACTIVATE
			
			*todo: this doesn't restore the window to it's previous state, only the
			* normal state, so if the form was maximized before it was minimized, it 
			* will not return it to maximized state.
			
				*Restore the Parent Window State if Minimized ( must come before MDI restore below )
				IF loParent.WindowState = 1
					loParent.WindowState = 0
				ENDIF
				*Restore the MDI Window State if Minimized ( must come after parent above )
				IF loForm.WindowState = 1
					loForm.WindowState = 0
				ENDIF
				*Activate the form
				loForm.Show()
				*NOTE: Don't return, otherwise, default handling does not work

			*Thumbnail Preview Window was Closed
			*NOTE: QueryUnload() will not trigger this way, so don't put important code there.
			CASE Msg = WM_CLOSE
				*Cause the proxy source form to close
				loForm.Release()
				*Return 0 will prevent the Thumbnail Window from closing when user tries to click.
				*RETURN 0
				*NOTE: Don't return, otherwise, default handling does not work
			ENDCASE
			
		ENDIF
		*Let VFP Handle all Win32API messages
		RETURN CallWindowProc(THIS._hOrigProc, hWnd, Msg, wParam, lParam)
	ENDFUNC
	
	***********************************************
	* GetProxySrcForm
	***********************************************
	* Returns a VFP Form Object from the internally
	* stored Proxy Source window Handle.
	************************************************
	FUNCTION GetProxySrcForm()
		LOCAL loForm, loTBM
		IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
			loForm = loTBM.GetForm_From_hWnd(THIS.nProxySrchWnd)
		ENDIF
		RETURN loForm
	ENDFUNC

	***********************************************
	* UpdateCaption
	***********************************************
	* Called by BindEvents() to ensure the proxy
	* window caption is updated to match the source
	* window caption, since that is what displays
	* in the preview window.
	************************************************
	FUNCTION UpdateCaption()
		LOCAL loForm
		loForm = THIS.GetProxySrcForm()
		IF VARTYPE(loForm)="O" AND !ISNULL(loForm)
			THIS.Caption = loForm.Caption
		ENDIF
	ENDFUNC
	
	***********************************************
	* UpdateFormIcon
	***********************************************
	* Called by BindEvents() to ensure the proxy
	* window icon is updated to match the source
	* window icon, since that is what displays
	* in the preview window.
	************************************************
	FUNCTION UpdateFormIcon()
		LOCAL loForm
		loForm = THIS.GetProxySrcForm()
		IF VARTYPE(loForm)="O" AND !ISNULL(loForm)
			THIS.Icon = loForm.Icon
		ENDIF
	ENDFUNC	
	
	***********************************************
	* UpdateThumbnail
	***********************************************
	* Called by BindEvents() to ensure that when 
	* the proxy source window "paints", this proxy
	* window informs Windows to erase any cached
	* data so that the preview images will be updated.
	************************************************
	FUNCTION UpdateThumbnail()
		LOCAL loParent, loForm, loHelper, loPreview
		*Populate helper objects: Taskbar Object, Proxy Src Form, Proxy Src Parent Form
		IF THIS._GetHelperObjects(@loForm, @loParent, @loHelper, @loPreview)
			*Don't update thumbnails if the proxy source window or it's parent is minimized
			*Also skip if it's got the lockscreen flag set.
			IF loForm.WindowState <> 1 AND loParent.WindowState <> 1 AND loForm.Lockscreen <> .T.
				IF THIS._lDllLoaded				
					RefreshThumbnails(THIS.HWnd)
				ENDIF
			ENDIF
		ENDIF
	ENDFUNC
	
ENDDEFINE

************************************************************************************
* Taskbar Proxy TDI Window Class
************************************************************************************
* An Invisible VFP Top Level Form used to act as a Proxy Window for setting 
* Custom Thumbnail & Live Preview Functionality for all Non-Top-Level forms in VFP,
* that are running in TDI Taskbar mode.
* 
* This is done since the DWM of Windows 7 can only communicate to top-level Windows.
* This class handles all DWM callback messages and generates the preview image data.
*
* This class should not be used directly by the application. It is created and
* managed by the MDI & TDI Taskbar classes.
************************************************************************************
DEFINE CLASS Taskbar_Proxy_TDI_Window AS Taskbar_Proxy_MDI_Window 
	***********************
	* PUBLIC PROPERTIES   *
	***********************	
	nTabNum = 0
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	***********************
	* END OF PROPERTIES   *
	***********************
	
	******************************************************************
	* W32API_Msg_Handler
	******************************************************************
	* Process Win32 API Messages related to the Proxy Window
	******************************************************************
	*NOTE: Don't bother to check if dll loaded since we 
	* 	   don't set up bind events if that fails so this 
	*      code won't be called	
	*
	* OVERRIDE PARENT BEHAVIOR TO ACCOUNT FOR PAGEFRAME HANDLING *
	******************************************************************
	*todo: should I set autoyield .F. here, and restore once code is done?
	PROTECTED FUNCTION _W32API_Msg_Handler(hWnd, Msg, wParam, lParam)
		LOCAL loForm, loParent, loHelper, loPreview
		
		*Populate helper objects: Taskbar Object, Proxy Src Form, Proxy Src Parent Form
		IF THIS._GetHelperObjects(@loForm, @loParent, @loHelper, @loPreview)
		
			*Process all Win32API Messages here
			DO CASE
				*Draw Custom Thumbnail Preview Message
				CASE Msg = WM_DWMSENDICONICTHUMBNAIL
				
					LOCAL lnW,lnH
					*Parse wParam as HIWORD() and LOWORD() to retrieve the width & height of the Thumbar window
					lnH = BITAND(lParam,0xffff)
					lnW = (BITAND(lParam,0xffff*0x10000))/0x10000	
					
					*Call the Call Back Handler Method if it exists
					IF PEMSTATUS(loHelper,"ON_THUMBNAIL_DRAW",5)
						loHelper.On_ThumbNail_Draw(loPreview,loForm,lnW,lnH)
					ENDIF
					*Return 0 to signify we handled the message
					RETURN 0

				*Draw Custom Live Preview Message
				CASE Msg = WM_DWMSENDICONICLIVEPREVIEWBITMAP
					*Call the Call Back Handler Method if it exists				
					IF PEMSTATUS(loHelper,"ON_LIVEPREVIEW_DRAW",5)
						loHelper.On_LivePreview_Draw(loPreview,loForm)
					ENDIF
					*Return 0 to signify we handled the message					
					RETURN 0

			*Thumbnail Preview Window was Activated		
			CASE Msg = WM_ACTIVATE
			*todo: this doesn't restore the window to it's previous state, only the
			* normal state, so if the form was maximized before it was minimized, it 
			* will not return it to maximized state.
				
				*Restore the Parent Window State if Minimized ( must come before MDI restore below )
				*todo: sometimes when the form is restored, it's in the top left corner and very tiny.
				IF loParent.WindowState = 1
					loParent.WindowState = 0
				ENDIF
				
				*Restore the MDI Window State if Minimized ( must come after parent above )
				IF loForm.WindowState = 1
					loForm.WindowState = 0
				ENDIF
				
				*Activate the form itself
				loForm.Show()
				
				*Activate the appropriate PageFrame Tab
				loHelper.ActivateTab(THIS.nTabNum)
				*NOTE: Don't return, otherwise, default handling does not work

			*Thumbnail Preview Window was Closed
			CASE Msg = WM_CLOSE

				*Remove the Tab from the form			
				loHelper.RemoveTab(THIS.nTabNum)
				*NOTE: Don't return, otherwise, default handling does not work

			ENDCASE
		ENDIF
		*Let VFP Handle all Win32API messages
		RETURN CallWindowProc(THIS._hOrigProc, hWnd, Msg, wParam, lParam)
	ENDFUNC
ENDDEFINE


**************************************************************************************
* Taskbar_Helper 
**************************************************************************************
* A simple class used for helping the developer to interact with the Win7TLib library.
* 
* To use, simply issue AddObject() to your form in the Load() method. If you wish to 
* specify the FormMode property pass it as a parameter to this object's init methd, if
* you are not subclassing this class.
* 
* The first responsibility this class has is to register the form it is added to to 
* remove the requirement that the developer manually do it. Of equal importance, the
* class will also unregister the form upon destruction automatically.
*
* The next responsibility is the class's callback handler functions. These functions 
* provided default handling for:
* 1) The event the library triggers when a Taskbar Toolbar button is pressed.
* 2) The event the library triggers when Windows wishes to draw a custom Thumbnail Image
* 3) The event the library triggers when Windows wishes to draw a custom LivePreview Image
*
* In order to customize the default behavior you should subclass this class and specify
* your custom application code in those methods.
*
* This class is used when the developer does not wish to use the Win7TLib_Visual.VCX in
* their application since it mirrors the functionality of the helper class there which
* was created for dropping onto a form for even more convenience.
*
* This class can also be used by adding it to the _VFP object so that you can handle
* callback events without having a form open. When doing this you must pass the object
* name as the 2nd parameter, since the class can't know what object name you used to 
* add it to _VFP.
***************************************************************************************
*todo: test this with _VFP.
DEFINE CLASS Taskbar_Helper AS Win7TLIB_Base 
	***********************
 	* PUBLIC PROPERTIES   *
	***********************	
	cFormMode = ""						&& Form Mode to use when registering form's for a taskbar. Values can be: VFP, TOP, MDI, TDI
	oTaskBar = NULL						&& Object reference to the registered Taskbar Instance
	***********************	
	* INTERNAL PROPERTIES *
	***********************	
	PROTECTED _lVFP, _cObjName
	_lVFP = .F.							&& Indicates if the object was added to the _VFP object.
	_cObjName = ""						&& Holds the name of this object's instance.
	***********************	
	* END OF PROPERTIES   *
	***********************
	
	****************************************************
	* INIT 
	****************************************************
	FUNCTION INIT(tcFormMode,tcObjName)
		RETURN THIS._SETUP(tcFormMode,tcObjName)
	ENDFUNC

	****************************************************
	* DESTROY 
	****************************************************
	FUNCTION DESTROY()
		DODEFAULT()
		THIS._CLEANUP()
	ENDFUNC

	***********************************************
	* _SETUP
	***********************************************
	* Internal method to perform any class related
	* setup required for the object. This method is
	* called automatically from the INIT() event.
	************************************************
	PROTECTED FUNCTION _SETUP(tcFormMode,tcObjName)

		*Get Taskbar Manager Object
		LOCAL loTBM, llNoForm
		IF !Get_Win7TLib_TaskBar_Manager(@loTBM)
			RETURN .F.
		ENDIF

		*Set the mode if passed
		THIS.cFormMode = EVL(tcFormMode,THIS.cFormMode)

		*If mode was not specified, pull from the Taskbar Manager
		IF EMPTY(THIS.cFormMode)
			IF EMPTY(loTBM.cFormMode)
				ERROR "Form Mode was not set in either the Helper Object or the Taskbar Manager"
				RETURN .F.
			ELSE
				THIS.cFormMode = loTBM.cFormMode
			ENDIF
		ENDIF

		*See if the object has a parent Form Object
		IF !(TYPE("THIS.Parent")="O" AND !ISNULL(THIS.Parent) AND UPPER(THIS.Parent.BaseClass)=="FORM")
			llNoForm = .T.
		ENDIF
		*If no parent, assume _VFP is the parent, since there's no way to really know
		*if the object was added to VFP ( well maybe we could scan _VFP's controls collection? )
		IF llNoForm
			THIS._lVFP = .T.
			*Must have an object name
			IF EMPTY(tcObjName)
				ERROR "Must pass object name as part of the Init() call to: " + THIS.Name
				RETURN .F.
			*Record the name for later
			ELSE
				THIS._cObjName = tcObjName
			ENDIF
		ENDIF
			
		*If the mode is VFP or No Parent Form, we get the Taskbar Object Reference for the _VFP Main Window.
		IF UPPER(THIS.cFormMode) == "VFP" OR llNoForm
			THIS.oTaskBar  = loTBM.GetTaskbar(_VFP)
		*Register the Form and Store the Taskbar Object Reference			
		ELSE
			THIS.oTaskBar  = loTBM.Register_Form(THIS.Parent,THIS.Name)
		ENDIF

		*Must be valid 
		IF !(VARTYPE(THIS.oTaskBar)="O" AND !ISNULL(THIS.oTaskbar))
			ERROR "Unable to retrieve Taskbar Object"
			RETURN .F.
		ENDIF
		
		*Register with the Taskbar
		THIS.RegisterHelperObj()
		
	ENDFUNC

	****************************************************
	* _CLEANUP
	****************************************************
	* Internal method to perform any class related
	* cleanup required for the object. This method 
	* is called automatically from the DESTROY() event.
	****************************************************
	PROTECTED FUNCTION _CLEANUP()
		*UnRegister the form when not running in VFP Mode
		IF !(UPPER(THIS.cFormMode) == "VFP")
			LOCAL loTBM, loParent
			IF Get_Win7TLib_TaskBar_Manager(@loTBM,.T.)		&& .T. = suppress error msg
				loParent = THIS._GetParent()
				loTBM.UnRegister_Form(loParent)
			ENDIF
		ENDIF

		*Remove reference ( THIS MUST COME LAST - OTHERWISE THE Taskbar Class releases too soon causing C5 errors! )
		THIS.oTaskbar = NULL
	ENDFUNC
	
	****************************************************
	* _GetParent
	****************************************************
	* Internal method to return the parent object for 
	* this instance of the class. The parent will be
	* a form in most cases, otherwise, it's assumed
	* to be the _VFP object.
	****************************************************
	PROTECTED FUNCTION _GetParent()
		IF THIS._lVFP
			RETURN _VFP
		ELSE
			RETURN THIS.Parent
		ENDIF
	ENDFUNC
	
	
	**********************************************************************
	* RegisterHelperObj
	**********************************************************************
	* Used to have the helper object register with it's Taskbar instance.
	**********************************************************************
	FUNCTION RegisterHelperObj()
		*Setup the Helper Object info
		IF VARTYPE(THIS.oTaskbar)="O" AND !ISNULL(THIS.oTaskBar)
			LOCAL loParent, lnHWND, lcObjName
			*Grab parent object reference
			loParent = THIS._GetParent()
			lnHWND = loParent.hWnd
			*Use this object's name if the name wasn't already given
			lcObjName = EVL(THIS._cObjName,THIS.Name)
			*Register with the Taskbar
			THIS.oTaskbar.SetHelperObj(lcObjName,lnHWND)
		ENDIF
	ENDFUNC
		

	********************************************************************
	* On_Toolbar_Button_Click
	********************************************************************
	* Called when a Toolbar Button was clicked for a registered form.
	*
	* Parameters: 
	* - Object reference to the Toolbar instance the Form's Taskbar Class
	* - Object reference to the registered Form
	* - ID # of the toolbar button pressed
	***********************************************************
	FUNCTION On_Toolbar_Button_Click(toToolBar, toForm, tnID)
		LOCAL lcMsg
		lcMsg = "Form: " + toForm.Caption + CHR(13)+CHR(10)+;
				"Toolbar Button #: " + TRANSFORM(tnID) + " Clicked"

*** todo - there's a bug in the mdi version, where toForm being sent is the proxy window
*** fix the code in toolbar _win32api message and then restore this code.
*!*			*Bring the form forward ( if VFP is the form, there's no Show() )
*!*			IF PEMSTATUS(toForm,"Show",5)
*!*				toForm.Show()
*!*			ENDIF

		=MESSAGEBOX(lcMsg,64,"Note")	
	ENDFUNC
	
	************************************************************************
	* On_Thumbnail_Draw
	************************************************************************
	* Called when Windows wants to draw a custom Thumbnail Image.
	*
	* Parameters: 
	* - Object reference to the Preview instance for the Form's Taskbar Class
	* - Object reference to the registered Form
	* - Width of the Thumbnail Window
	* - Height of the Thumbnail Window
	************************************************************************
	* Return .T. if you've successfully handed the callback message.
	************************************************************************
	FUNCTION On_Thumbnail_Draw(toPreview, toForm, tnW, tnH)
		LOCAL llOK
		IF VARTYPE(toPreview)="O" AND !ISNULL(toPreview)
			LOCAL lcImg
			lcImg = ALLTRIM(toPreview.cThumbnailImage)
			*See if we have a thumbnail image to use
			IF !EMPTY(lcImg)
				LOCAL loImg
				loImg = toPreview.LoadImage(lcImg)
				IF !ISNULL(loImg)
					toPreview.SetThumbnailImage(loImg.Handle,tnW,tnH)
					llOK = .T.
				ENDIF
			*No Image specified, do some default handling if MDI
			ELSE
				IF THIS.cFormMode="MDI" OR THIS.cFormMode = "TDI"
					toPreview.CreateThumbnailImage(tnW,tnH)
				ENDIF
			ENDIF
		ENDIF
		RETURN llOK
	ENDFUNC

	************************************************************************
	* On_LivePreview_Draw
	************************************************************************
	* Called when Windows wants to draw a custom Live Preview Image.
	*
	* Parameters: 
	* - Object reference to the Preview instance for the Form's Taskbar Class
	* - Object reference to the registered Form
	************************************************************************
	* Return .T. if you've successfully handed the callback message.
	************************************************************************
	FUNCTION On_LivePreview_Draw(toPreview, toForm)
		LOCAL llOK
		IF VARTYPE(toPreview)="O" AND !ISNULL(toPreview)
			LOCAL lcImg
			lcImg = ALLTRIM(toPreview.cLivePreviewImage)
			*See if we have a thumbnail image to use
			IF !EMPTY(lcImg)
				LOCAL loImg
				loImg = toPreview.LoadImage(lcImg)
				IF !ISNULL(loImg)
					toPreview.SetLivePreviewImage(loImg.Handle)
					llOK = .T.
				ENDIF
			*No Image specified, do some default handling if MDI
			ELSE
				IF THIS.cFormMode="MDI" OR THIS.cFormMode = "TDI"
					toPreview.CreateLivePreviewImage()
				ENDIF
			ENDIF
		ENDIF
		RETURN llOK
	ENDFUNC

ENDDEFINE

************************************************************************************************************************************************************
************************************************************************************************************************************************************
************************************************************************************************************************************************************
************************************************************************************************************************************************************
** 												WIN7TLIB FUNCTIONS
************************************************************************************************************************************************************
************************************************************************************************************************************************************
************************************************************************************************************************************************************
************************************************************************************************************************************************************
#DEFINE WIN7TLIB_FUNCTIONS

************************************************************************************************************************************************************
* Initialize_Win7TLib()
************************************************************************************************************************************************************
* Does all the necessary initializations for the library. 
* 
* YOUR APPLICATION MUST CALL THIS BEFORE DOING ANYTHING ELSE WITH THE TASKBAR 
************************************************************************************************************************************************************
FUNCTION Initialize_Win7TLib()
	LOCAL loInitHelper, llOK
	DEBUGOUT "** - Initialize_Win7TLib called @ " + TRANSFORM(DATETIME())	
	*Create helper object to do the work	
	loInitHelper = CREATEOBJECT("Taskbar_Library_Helper")
	IF VARTYPE(loInitHelper)="O" AND !ISNULL(loInitHelper)
		llOK = loInitHelper.Initialize_Library()
	ENDIF
	RETURN llOK
ENDFUNC

************************************************************************************************************************************************************
* UnInitialize_Win7TLib()
************************************************************************************************************************************************************
* Performs any cleanup to the library. This function should be called when your application 
* is shutting down, ie, sometime after issuing CLEAR EVENTS
* Be sure to call this BEFORE issuing CLEAR ALL
************************************************************************************************************************************************************
FUNCTION UnInitialize_Win7TLib()
	LOCAL loInitHelper, llOK
	loTBM = NULL
	DEBUGOUT "** - UnInitialize_Win7TLib called @ " + TRANSFORM(DATETIME())
	*Create helper object to do the work	
	loInitHelper = CREATEOBJECT("Taskbar_Library_Helper")
	IF VARTYPE(loInitHelper)="O" AND !ISNULL(loInitHelper)
		llOK = loInitHelper.Uninitialize_Library()
	ENDIF
	RETURN llOK
ENDFUNC

************************************************************************************************************************************************************
* Get_Win7TLib_Taskbar_Manager()
************************************************************************************************************************************************************
* A utility function which returns an object reference to the current taskbar manager instance.
* ( assumes the Initialize_Win7TLib() to create the instance was already called )
* 
* There is only ever one instance of the manager ( singleton ), but the user can customize it's location, 
* so this function is necessary to provide a transparent means to always get an object reference. This
* function is used heavily by the library classes.
*
* It is suggested you use it as well to avoid hardcoding a direct object location of the TBM, but if you 
* never plan on changing the location, you can always just access the TBM directly,
* aka _VFP.Win7TLib.TaskbarManager which is the default location.
*
* NOTE: With the addition of the Taskbar_Helper class ( both visual and non-visual ), your application has 
* rarely a need to ever find the Taskbar Manager object manually, since the helper class does most of the 
* communications with it on your behalf anyway.
*
* SPEED OPTIMIZATION: 
* 	To improve performance for situations where the default location is acceptable for the developer,
*   make sure the define: WIN7TLIB_USE_DEFINE_FOR_LOCATION is set to .T. at the top of this prg. This allows
*   this function to skip the steps of creating an instance of the helper class which then instantiates the 
*   settings class to find the location of the manager. Instead, it looks directly at the specified default
*   location define: TBM_DEFAULT_LOCATION
*
*   You can still change the default location and use the speed optimization, by simply changing the 
*   TBM_DEFAULT_LOCATION definition. The only drawback is that you must recompile the library, and if you are 
*   sharing the library among different projects, this change will affect all applications. That shouldn't really
*   be any problem provided that all applications are using this function to always find the manager.
*
****************************************************************************************************************************************************** 
* 						THIS FUNCTION CAN BE CALLED IN TWO WAYS FOR CONVENIENCE
******************************************************************************************************************************************************
* Option #1: 
* 	Paramaters: None
*
*	Returns: 	Object Reference of the Taskbar Manager Instance
*
*	Example: 	loTBM = Get_Win7TLib_Taskbar_Manager()
*   
*   Notes:		It's your responsibility to check if the object returned
*				is valid and handle errors yourself.
******************************************************************************************************************************************************
* Option #2:
*	Paramaters: A variable passed by Reference to receive the Taskbar Manager Object
*				Logical to suppress generating an Error on Failure 
*					( .T. = suppress, .F. (Default) = generate error )
*
*	Returns: .T. if the function successfully found and populated the variable with the Taskbar Manager Instance.
*	Returns: .F. and optionally generates a user error if the TBM could not be retrieved. Variable will be set to NULL.
*
*	Example: IF !Get_Win7TLib_Taskbar_Manager(@loTBM,.T.)		&& .T. = suppress error generation
*				RETURN .F.
*			 ENDIF
*
*   Notes: The function checks if the object is valid and generates an error if it's not so you don't have to
*		   add that to your code everywhere you wish to work with the Taskbar Manager.
************************************************************************************************************************************************************
FUNCTION Get_Win7TLib_Taskbar_Manager( toTBM, tlSuppressError )
	LOCAL loTBM, loInitHelper
	loTBM = NULL
	
	*If the "USE DEFINE LOCATION" is set, simply pull the object from the DEFAULT_LOCATION definition.
	#IF WIN7TLIB_USE_DEFINE_FOR_LOCATION
		loTBM = EVALUATE(TBM_DEFAULT_LOCATION)
	*Instantiate the library helper class to find a reference to the Taskbar Manager	
	#ELSE
		loInitHelper = CREATEOBJECT("Taskbar_Library_Helper")
		IF VARTYPE(loInitHelper)="O" AND !ISNULL(loInitHelper)
			loTBM = loInitHelper.Get_Taskbar_Manager()
		ENDIF
	#ENDIF
	
	*Option #1 - No Parameter
	IF PCOUNT()<1
		*Simply return the object
		RETURN loTBM
	*Option #2 - Variable passed by reference
	ELSE
		*Check to ensure we retrieved the Taskbar Manager Object
		IF VARTYPE(loTBM)="O" AND !ISNULL(loTBM)
			*Make the assignment
			toTBM = loTBM
			*Flag success
			RETURN .T.
		*Failed
		ELSE
			*Generate an error unless asked to suppress
			IF !tlSuppressError 
				ERROR "Could not retrieve taskbar manager object from Get_Win7TLib_Taskbar_Manager()!"
			ENDIF
			*Flag failure
			RETURN .F.
		ENDIF
	ENDIF
ENDFUNC
