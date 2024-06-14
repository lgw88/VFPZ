*-***********************************************************************************************
*-* Copyright ©2010 Gregory A. Green
*-*
*-* THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY. ALL
*-* IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR PURPOSE ARE HEREBY DISCLAIMED.
*-***********************************************************************************************
*-* Routine for Getting the file icon for a given base class
*-*
FUNCTION GKKGetClassBMP
LPARAMETERS tcBaseClass
LOCAL lcBaseClass
lcBaseClass = UPPER(ALLTRIM(tcBaseClass))
DO CASE
	CASE lcBaseClass == "DATAENVIRONMENT"
	CASE lcBaseClass == "CURSORADAPTER"
	CASE lcBaseClass == "CURSOR"
	CASE lcBaseClass == "ACTIVEDOC"
	CASE lcBaseClass == "CHECKBOX"
	CASE lcBaseClass == "COMBOBOX"
	CASE lcBaseClass == "COMMANDBUTTON"
	CASE lcBaseClass == "COMMANDGROUP"
	CASE lcBaseClass == "COLUMN"
	CASE lcBaseClass == "COLLECTION"
	CASE lcBaseClass == "CONTAINER"
	CASE lcBaseClass == "CONTROL"
	CASE lcBaseClass == "CUSTOM"
	CASE lcBaseClass == "EDITBOX"
	CASE lcBaseClass == "FORM"
	CASE lcBaseClass == "FORMSET"
	CASE lcBaseClass == "GRID"
	CASE lcBaseClass == "HEADER"
	CASE lcBaseClass == "HYPERLINK"
	CASE lcBaseClass == "IMAGE"
	CASE lcBaseClass == "LABEL"
	CASE lcBaseClass == "LINE"
	CASE lcBaseClass == "LISTBOX"
	CASE lcBaseClass == "OPTIONBUTTON"
	CASE lcBaseClass == "OPTIONGROUP"
	CASE lcBaseClass == "OLEBOUNDCONTROL"
	CASE lcBaseClass == "OLECONTROL"
	CASE lcBaseClass == "PAGE"
	CASE lcBaseClass == "PAGEFRAME"
	CASE lcBaseClass == "PROJECTHOOK"
	CASE lcBaseClass == "RELATION"
	CASE lcBaseClass == "SEPARATOR"
	CASE lcBaseClass == "SHAPE"
	CASE lcBaseClass == "SPINNER"
	CASE lcBaseClass == "TEXTBOX"
	CASE lcBaseClass == "TIMER"
	CASE lcBaseClass == "TOOLBAR"
	OTHERWISE
		lcBaseClass = "CUSTOM"
ENDCASE
RETURN "GKK" + lcBaseClass + ".BMP"
ENDFUNC