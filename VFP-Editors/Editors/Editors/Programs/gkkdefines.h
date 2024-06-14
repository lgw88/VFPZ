#DEFINE GKKDEFINES .T.

*-*
*-*	Method types
*-*
#DEFINE METHOD_TYPE_STOCK      1
#DEFINE METHOD_TYPE_CUSTOM     2
#DEFINE METHOD_TYPE_OBJECT     3
#DEFINE METHOD_TYPE_PROPERTY   4

*-*
*-*	Method/Property Visibility
*-*
#DEFINE VISIBILITY_PUBLIC      1
#DEFINE VISIBILITY_HIDDEN      2
#DEFINE VISIBILITY_PROTECTED   3

*-*
*-*	ListView Active-X Column Alignment values
*-*
#DEFINE LISTVIEW_ALIGN_LEFT    0
#DEFINE LISTVIEW_ALIGN_RIGHT   1
#DEFINE LISTVIEW_ALIGN_CENTER  2

*-*
*-*	Table Browser base node types
*-*
#DEFINE NODE_TYPE_DIR          "_001"
#DEFINE NODE_TYPE_MNU          "_002"
#DEFINE NODE_TYPE_DBC          "_003"
#DEFINE NODE_TYPE_DBF          "_004"
#DEFINE NODE_TYPE_SCX          "_005"
#DEFINE NODE_TYPE_PRJ          "_006"
#DEFINE NODE_TYPE_VCX          "_007"

*-*
*-*	Document View Line Types
*-*
#DEFINE DOCVIEW_DEFINE          1
#DEFINE DOCVIEW_FUNCTION        2
#DEFINE DOCVIEW_PROCEDURE       3
#DEFINE DOCVIEW_CLASSDEF        4
#DEFINE DOCVIEW_CLASSMETH       5

*-*
*-*	Property Grid Constants
*-*
#DEFINE UG_PROPGRID_ALPHASPLIT    1
#DEFINE UG_PROPGRID_GROUPED       2

*-*
*-*	BBGridList Constants
*-*
#DEFINE CHECKBOX_TRUE             CHR(0xFE)
#DEFINE CHECKBOX_FALSE            CHR(0x6F)

*-*
*-*	VFP Control Constants
*-*
#DEFINE VFP_ALIGN_LEFT_CENTER     0
#DEFINE VFP_ALIGN_RIGHT_CENTER    1
#DEFINE VFP_ALIGN_CENTER_CENTER   2
#DEFINE VFP_ALIGN_AUTOMATIC       3
#DEFINE VFP_ALIGN_LEFT_TOP        4     
#DEFINE VFP_ALIGN_RIGHT_TOP       5
#DEFINE VFP_ALIGN_CENTER_TOP      6
#DEFINE VFP_ALIGN_LEFT_BOTTOM     7
#DEFINE VFP_ALIGN_RIGHT_BOTTOM    8
#DEFINE VFP_ALIGN_CENTER_BOTTOM   9

*-*
*-*	Table Designer CodeMax Constants
*-*
#DEFINE TBL_CODE_CREATE        1
#DEFINE TBL_CODE_ALTER         2
#DEFINE TBL_CODE_INDEX         3
#DEFINE TBL_CODE_TBL_PROP      4
#DEFINE TBL_CODE_FLD_PROP      5

*-*
*-*	Image Constants for Treeview
*-*
#DEFINE ICON_TABLE             1
#DEFINE ICON_TEXTFILE          2
#DEFINE ICON_APPS              3
#DEFINE ICON_CODE              4
#DEFINE ICON_DATA              5
#DEFINE ICON_CODE_COMPARE      6
#DEFINE ICON_DBC               7
#DEFINE ICON_FORM              8
#DEFINE ICON_REPORTLABEL       9
#DEFINE ICON_MENU             10
#DEFINE ICON_OTHER            11
#DEFINE ICON_QUERY            12
#DEFINE ICON_REPORT           13
#DEFINE ICON_CLASSLIB         14
#DEFINE ICON_CONNECTIONS      15
#DEFINE ICON_LOCAL_VIEW       17
#DEFINE ICON_REMOTE_VIEW      18
#DEFINE ICON_STORED_PROC      19
#DEFINE ICON_QUERY2           20
#DEFINE ICON_CHKBOX_CHECKED   21
#DEFINE ICON_CHKBOX_UNCHECKED 22
#DEFINE ICON_FIELD            23
#DEFINE ICON_INDEXES          24
#DEFINE ICON_PRIMARY_KEY      25
#DEFINE ICON_TOOLBAR          26
#DEFINE ICON_CHECKBOX         27
#DEFINE ICON_COMBOBOX         28
#DEFINE ICON_COMMANDBUTTON    29
#DEFINE ICON_COMMANDGROUP     30
#DEFINE ICON_CONTAINER        31
#DEFINE ICON_CONTROL          32
#DEFINE ICON_CUSTOM           33
#DEFINE ICON_EDITBOX          34
#DEFINE ICON_FORMSET          35
#DEFINE ICON_GRID             36
#DEFINE ICON_HYERLINK         37
#DEFINE ICON_IMAGE            38
#DEFINE ICON_LABEL            39
#DEFINE ICON_LINE             40
#DEFINE ICON_LISTBOX          41
#DEFINE ICON_OLEBOUNDCONTROL  42
#DEFINE ICON_OLECONTROL       43
#DEFINE ICON_OPTIONGROUP      44
#DEFINE ICON_OPTIONBUTTON     44
#DEFINE ICON_PAGEFRAME        45
#DEFINE ICON_PROJECTHOOK      46
#DEFINE ICON_SEPARATOR        47
#DEFINE ICON_SHAPE            48
#DEFINE ICON_SPINNER          49
#DEFINE ICON_TEXTBOX          50
#DEFINE ICON_TIMER            51
#DEFINE ICON_ACTIVEDOC        52
#DEFINE ICON_PROPERTY         53
#DEFINE ICON_METHOD           54
#DEFINE ICON_EVENT            55
#DEFINE ICON_INCLUDE          56
#DEFINE ICON_PSFORMPAGE       57
#DEFINE ICON_GRID_COLUMN      58
#DEFINE ICON_GRID_HEADER      59
#DEFINE ICON_UNKNOWN          60
#DEFINE ICON_DATAENVIRONMENT  61
#DEFINE ICON_RELATION         62
#DEFINE ICON_PROTECTED_METHOD 63
#DEFINE ICON_HIDDEN_METHOD    64
#DEFINE ICON_COLLECTION       65
#DEFINE ICON_CURSOR           66
#DEFINE ICON_CURSOR_ADAPTER   67
#DEFINE ICON_METHOD_CUSTOM    54   && 68 or 71
#DEFINE ICON_PROTECTED_EVENT  70
#DEFINE ICON_HIDDEN_EVENT     69

*-*
*-*	Snippet file type defines
*-*
#DEFINE SNIPPIT_PRG     1          && Program code (PRG, H)
#DEFINE SNIPPIT_ZIP     2          && Zip files
#DEFINE SNIPPIT_URL     3          && Web URL
#DEFINE SNIPPIT_PDF     4          && PDF files
#DEFINE SNIPPIT_TXT     5          && Text files
#DEFINE SNIPPIT_OTH     6          && General files
#DEFINE SNIPPIT_RTF     7          && Richtext files

*-*
*-*	Special Folder location defines
*-*
#DEFINE CSIDL_FLAG_CREATE               0x8000    && Combine this CSIDL with any of the following CSIDLs to force the creation of the associated folder. 
#DEFINE CSIDL_ADMINTOOLS                0x0030    && The file system directory that is used to store administrative tools for an individual user. The Microsoft Management Console (MMC) will save customized consoles to this directory, and it will roam with the user.
#DEFINE CSIDL_ALTSTARTUP                0x001d    && The file system directory that corresponds to the user's nonlocalized Startup program group.
#DEFINE CSIDL_APPDATA                   0x001a    && The file system directory that serves as a common repository for application-specific data. A typical path is C:\Documents and Settings\username\Application Data. This CSIDL is supported by the redistributable Shfolder.dll for systems that do not have the Microsoft Internet Explorer 4.0 integrated Shell installed.
#DEFINE CSIDL_BITBUCKET                 0x000a    && The virtual folder containing the objects in the user's Recycle Bin.
#DEFINE CSIDL_CDBURN_AREA               0x003b    && The file system directory acting as a staging area for files waiting to be written to CD. A typical path is C:\Documents and Settings\username\Local Settings\Application Data\Microsoft\CD Burning.
#DEFINE CSIDL_COMMON_ADMINTOOLS         0x002f    && The file system directory containing administrative tools for all users of the computer.
#DEFINE CSIDL_COMMON_ALTSTARTUP         0x001e    && The file system directory that corresponds to the nonlocalized Startup program group for all users. Valid only for Microsoft Windows NT systems.
#DEFINE CSIDL_COMMON_APPDATA            0x0023    && The file system directory containing application data for all users. A typical path is C:\Documents and Settings\All Users\Application Data.
#DEFINE CSIDL_COMMON_DESKTOPDIRECTORY   0x0019    && The file system directory that contains files and folders that appear on the desktop for all users. A typical path is C:\Documents and Settings\All Users\Desktop. Valid only for Windows NT systems.
#DEFINE CSIDL_COMMON_DOCUMENTS          0x002e    && The file system directory that contains documents that are common to all users. A typical paths is C:\Documents and Settings\All Users\Documents. Valid for Windows NT systems and Microsoft Windows 95 and Windows 98 systems with Shfolder.dll installed.
#DEFINE CSIDL_COMMON_FAVORITES          0x001f    && The file system directory that serves as a common repository for favorite items common to all users. Valid only for Windows NT systems.
#DEFINE CSIDL_COMMON_MUSIC              0x0035    && The file system directory that serves as a repository for music files common to all users. A typical path is C:\Documents and Settings\All Users\Documents\My Music.
#DEFINE CSIDL_COMMON_PICTURES           0x0036    && The file system directory that serves as a repository for image files common to all users. A typical path is C:\Documents and Settings\All Users\Documents\My Pictures.
#DEFINE CSIDL_COMMON_PROGRAMS           0x0017    && The file system directory that contains the directories for the common program groups that appear on the Start menu for all users. A typical path is C:\Documents and Settings\All Users\Start Menu\Programs. Valid only for Windows NT systems.
#DEFINE CSIDL_COMMON_STARTMENU          0x0016    && The file system directory that contains the programs and folders that appear on the Start menu for all users. A typical path is C:\Documents and Settings\All Users\Start Menu. Valid only for Windows NT systems.
#DEFINE CSIDL_COMMON_STARTUP            0x0018    && The file system directory that contains the programs that appear in the Startup folder for all users. A typical path is C:\Documents and Settings\All Users\Start Menu\Programs\Startup. Valid only for Windows NT systems.
#DEFINE CSIDL_COMMON_TEMPLATES          0x002d    && The file system directory that contains the templates that are available to all users. A typical path is C:\Documents and Settings\All Users\Templates. Valid only for Windows NT systems.
#DEFINE CSIDL_COMMON_VIDEO              0x0037    && The file system directory that serves as a repository for video files common to all users. A typical path is C:\Documents and Settings\All Users\Documents\My Videos.
#DEFINE CSIDL_CONTROLS                  0x0003    && The virtual folder containing icons for the Control Panel applications.
#DEFINE CSIDL_COOKIES                   0x0021    && The file system directory that serves as a common repository for Internet cookies. A typical path is C:\Documents and Settings\username\Cookies.
#DEFINE CSIDL_DESKTOP                   0x0000    && The virtual folder representing the Windows desktop, the root of the namespace.
#DEFINE CSIDL_DESKTOPDIRECTORY          0x0010    && The file system directory used to physically store file objects on the desktop (not to be confused with the desktop folder itself). A typical path is C:\Documents and Settings\username\Desktop.
#DEFINE CSIDL_DRIVES                    0x0011    && The virtual folder representing My Computer, containing everything on the local computer: storage devices, printers, and Control Panel. The folder may also contain mapped network drives.
#DEFINE CSIDL_FAVORITES                 0x0006    && The file system directory that serves as a common repository for the user's favorite items. A typical path is C:\Documents and Settings\username\Favorites.
#DEFINE CSIDL_FONTS                     0x0014    && A virtual folder containing fonts. A typical path is C:\Windows\Fonts.
#DEFINE CSIDL_HISTORY                   0x0022    && The file system directory that serves as a common repository for Internet history items.
#DEFINE CSIDL_INTERNET                  0x0001    && A virtual folder representing the Internet.
#DEFINE CSIDL_INTERNET_CACHE            0x0020    && The file system directory that serves as a common repository for temporary Internet files. A typical path is C:\Documents and Settings\username\Local Settings\Temporary Internet Files.
#DEFINE CSIDL_LOCAL_APPDATA             0x001c    && The file system directory that serves as a data repository for local (nonroaming) applications. A typical path is C:\Documents and Settings\username\Local Settings\Application Data.
#DEFINE CSIDL_MYDOCUMENTS               0x000c    && The virtual folder representing the My Documents desktop item.
#DEFINE CSIDL_MYMUSIC                   0x000d    && The file system directory that serves as a common repository for music files. A typical path is C:\Documents and Settings\User\My Documents\My Music.
#DEFINE CSIDL_MYPICTURES                0x0027    && The file system directory that serves as a common repository for image files. A typical path is C:\Documents and Settings\username\My Documents\My Pictures.
#DEFINE CSIDL_MYVIDEO                   0x000e    && The file system directory that serves as a common repository for video files. A typical path is C:\Documents and Settings\username\My Documents\My Videos.
#DEFINE CSIDL_NETHOOD                   0x0013    && A file system directory containing the link objects that may exist in the My Network Places virtual folder. It is not the same as CSIDL_NETWORK, which represents the network namespace root. A typical path is C:\Documents and Settings\username\NetHood.
#DEFINE CSIDL_NETWORK                   0x0012    && A virtual folder representing Network Neighborhood, the root of the network namespace hierarchy.
#DEFINE CSIDL_PERSONAL                  0x0005    && The virtual folder representing the My Documents desktop item. This is equivalent to CSIDL_MYDOCUMENTS. 
#DEFINE CSIDL_PRINTERS                  0x0004    && The virtual folder containing installed printers.
#DEFINE CSIDL_PRINTHOOD                 0x001b    && The file system directory that contains the link objects that can exist in the Printers virtual folder. A typical path is C:\Documents and Settings\username\PrintHood.
#DEFINE CSIDL_PROFILE                   0x0028    && The user's profile folder. A typical path is C:\Documents and Settings\username. Applications should not create files or folders at this level; they should put their data under the locations referred to by CSIDL_APPDATA or CSIDL_LOCAL_APPDATA.
#DEFINE CSIDL_PROFILES                  0x003e    && The file system directory containing user profile folders. A typical path is C:\Documents and Settings.
#DEFINE CSIDL_PROGRAM_FILES             0x0026    && The Program Files folder. A typical path is C:\Program Files.
#DEFINE CSIDL_PROGRAM_FILES_COMMON      0x002b    && A folder for components that are shared across applications. A typical path is C:\Program Files\Common. Valid only for Windows NT, Windows 2000, and Windows XP systems. Not valid for Windows Millennium Edition (Windows Me).
#DEFINE CSIDL_PROGRAMS                  0x0002    && The file system directory that contains the user's program groups (which are themselves file system directories). A typical path is C:\Documents and Settings\username\Start Menu\Programs. 
#DEFINE CSIDL_RECENT                    0x0008    && The file system directory that contains shortcuts to the user's most recently used documents. A typical path is C:\Documents and Settings\username\My Recent Documents. To create a shortcut in this folder, use SHAddToRecentDocs. In addition to creating the shortcut, this function updates the Shell's list of recent documents and adds the shortcut to the My Recent Documents submenu of the Start menu.
#DEFINE CSIDL_SENDTO                    0x0009    && The file system directory that contains Send To menu items. A typical path is C:\Documents and Settings\username\SendTo.
#DEFINE CSIDL_STARTMENU                 0x000b    && The file system directory containing Start menu items. A typical path is C:\Documents and Settings\username\Start Menu.
#DEFINE CSIDL_STARTUP                   0x0007    && The file system directory that corresponds to the user's Startup program group. The system starts these programs whenever any user logs onto Windows NT or starts Windows 95. A typical path is C:\Documents and Settings\username\Start Menu\Programs\Startup.
#DEFINE CSIDL_SYSTEM                    0x0025    && The Windows System folder. A typical path is C:\Windows\System32.
#DEFINE CSIDL_TEMPLATES                 0x0015    && The file system directory that serves as a common repository for document templates. A typical path is C:\Documents and Settings\username\Templates.
#DEFINE CSIDL_WINDOWS                   0x0024    && The Windows directory or SYSROOT. This corresponds to the %windir% or %SYSTEMROOT% environment variables. A typical path is C:\Windows.

*-*
*-*	Toolbar Dock Positions
*-*
#DEFINE TOOL_NOTDOCKED  -1     && Undocks the toolbar or form.
#DEFINE TOOL_TOP         0     && Positions the toolbar or form at the top of the main Visual FoxPro window.
#DEFINE TOOL_LEFT        1     && Positions the toolbar or form at the left side of the main Visual FoxPro window.
#DEFINE TOOL_RIGHT       2     && Positions the toolbar or form at the right side of the main Visual FoxPro window.
#DEFINE TOOL_BOTTOM      3     && Positions the toolbar or form at the bottom of the main Visual FoxPro window.

*-*
*-*	Menu types
*-*
#DEFINE MNU_TYPE_UNDEFINED      0
#DEFINE MNU_TYPE_STANDARD       1
#DEFINE MNU_TYPE_SHORTCUT       2

*-*
*-*	Information Sheet constants
*-*
#DEFINE INFOSHEET_BOOKMARKS     1                 && 0 for InfoDisplay class
#DEFINE INFOSHEET_ERRORS        2                 && 1 for InfoDisplay class
#DEFINE INFOSHEET_WHEREUSED     3                 && 2 for InfoDisplay class

*-*
*-*	API Timer limits
*-*
#DEFINE USER_TIMER_MINIMUM      10
#DEFINE USER_TIMER_MAXIMUM      0x7FFFFFFF

*-*
*-* Mouse pointer constants
*-*
#DEFINE MOUSE_DEFAULT           0
#DEFINE MOUSE_ARROW             1
#DEFINE MOUSE_CROSSHAIR         2
#DEFINE MOUSE_IBEAM             3
#DEFINE MOUSE_ICON_POINTER      4
#DEFINE MOUSE_SIZE_POINTER      5
#DEFINE MOUSE_SIZE_NE_SW        6
#DEFINE MOUSE_SIZE_N_S          7
#DEFINE MOUSE_SIZE_NW_SE        8
#DEFINE MOUSE_SIZE_W_E          9
#DEFINE MOUSE_UP_ARROW          10
#DEFINE MOUSE_HOURGLASS         11
#DEFINE MOUSE_NO_DROP           12
#DEFINE MOUSE_HIDE_POINTER      13
#DEFINE MOUSE_ARROW2            14
#DEFINE MOUSE_CUSTOM            99

*-*
*-* OLE Drag and Drop:  Drop Effects
*-*
#DEFINE DROPEFFECT_NONE       0
#DEFINE DROPEFFECT_COPY       1
#DEFINE DROPEFFECT_MOVE       2
#DEFINE DROPEFFECT_LINK       4

*-*
*-* OLE Drag and Drop:  Drop Modes
*-*
#DEFINE DROP_DISABLED         0
#DEFINE DROP_ENABLED          1
#DEFINE DROP_PASSTOCONTAINER  2

*-*
*-* OLE Drag and Drop:  OLEDropHasData settings
*-*
#DEFINE DROPHASDATA_VFPDETERMINE  -1
#DEFINE DROPHASDATA_NOTUSEFUL      0
#DEFINE DROPHASDATA_USEFUL         1

*-*
*-* Clipboard formats (Global)
*-*
#DEFINE CF_TEXT               1      && Text
#DEFINE CF_BITMAP             2      && Bitmap
#DEFINE CF_METAFILEPICT       3      && Handle of a metafile picture format
#DEFINE CF_SYLK               4      && Microsoft Symbolic Link format
#DEFINE CF_DIF                5      && Software Arts' Data Interchange Format
#DEFINE CF_TIFF               6      && Tagged-image file format
#DEFINE CF_OEMTEXT            7      && Text format containing characters in the OEM character set
#DEFINE CF_DIB                8      && Device-independent bitmap
#DEFINE CF_PALETTE            9      && Handle of a color palette
#DEFINE CF_PENDATA            10     && Data for the pen extensions to the Microsoft Windows for Pen Computing
#DEFINE CF_RIFF               11     && Represents complex audio data
#DEFINE CF_WAVE               12     && Audio data in one of the standard wave formats
#DEFINE CF_UNICODETEXT        13     && Windows NT only: Unicode text format
#DEFINE CF_ENHMETAFILE        14     && A handle of an enhanced metafile
#DEFINE CF_FILES              15     && A list of files
#DEFINE CF_HDROP              15     && A list of files
#DEFINE CF_LOCALE             16     && A handle to the locale identifier
#DEFINE CF_MAX                17

*-*
*-* Other Miscellaneous Clipboard formats
*-*
#DEFINE CFSTR_HYPERLINK       "Hyperlink"               && A Hyperlink
#DEFINE CFSTR_BIFF            "Biff"                    && Microsoft Excel version 2.x
#DEFINE CFSTR_BIFF3           "Biff3"                   && Microsoft Excel version 3.0
#DEFINE CFSTR_BIFF4           "Biff4"                   && Microsoft Excel version 4.0
#DEFINE CFSTR_BIFF5           "Biff5"                   && Microsoft Excel version 5.0
#DEFINE CFSTR_BIFF7           "Biff7"                   && Microsoft Excel version 7.0
#DEFINE CFSTR_BIFF8           "Biff8"                   && Microsoft Excel version 8.0
#DEFINE CFSTR_XLTABLE         "XlTable"                 && Microsoft Excel fast table format.
#DEFINE CFSTR_CSV             "CSV"                     && Comma separated values
#DEFINE CFSTR_WK1             "Wk1"                     && Lotus 1-2-3 Release 2.01 and Release 2.2 format
#DEFINE CFSTR_URL             "UniformResourceLocator"  && URL

#DEFINE CFSTR_RTF             "Rich Text Format"
#DEFINE CFSTR_RTFNOOBJS       "Rich Text Format Without Objects"
#DEFINE CFSTR_RETEXTOBJ       "RichEdit Text and Objects"

*-*
*-* Clipboard formats (Private to VFP)
*-*
#DEFINE CFSTR_OLEVARIANTARRAY "OLE Variant Array"       && VFP array
#DEFINE CFSTR_OLEVARIANT      "OLE Variant"             && Data in variant form
#DEFINE CFSTR_VFPSOURCEOBJECT "VFP Source Object"       && A reference to the VFP source object

*-*
*-* DragMode
*-*
#DEFINE DRAG_MANUAL           0      && 0 - Manual
#DEFINE DRAG_AUTOMATIC        1      && 1 - Automatic

*-*
*-* DragOver
*-*
#DEFINE DRAG_ENTER            0
#DEFINE DRAG_LEAVE            1
#DEFINE DRAG_OVER             2

*-*
*-* Drag (controls)
*-*
#DEFINE DRAG_CANCEL           0
#DEFINE DRAG_BEGIN            1
#DEFINE DRAG_END              2

*-*
*-* Windows Version constants
*-*
#DEFINE NTDDI_WIN7        0x06010000      && Windows 7
#DEFINE NTDDI_WS08        0x06000100      && Windows Server 2008
#DEFINE NTDDI_VISTASP1    0x06000100      && Windows Vista with SP1
#DEFINE NTDDI_VISTA       0x06000000      && Windows Vista
#DEFINE NTDDI_WS03SP2     0x05020200      && Windows Server 2003 with SP2
#DEFINE NTDDI_WS03SP1     0x05020100      && Windows Server 2003 with SP1
#DEFINE NTDDI_WS03        0x05020000      && Windows Server 2003
#DEFINE NTDDI_WINXPSP3    0x05010300      && Windows XP with SP3
#DEFINE NTDDI_WINXPSP2    0x05010200      && Windows XP with SP2
#DEFINE NTDDI_WINXPSP1    0x05010100      && Windows XP with SP1
#DEFINE NTDDI_WINXP       0x05010000      && Windows XP
#DEFINE NTDDI_WIN2KSP4    0x05000400      && Windows 2000 with SP4
#DEFINE NTDDI_WIN2KSP3    0x05000300      && Windows 2000 with SP3
#DEFINE NTDDI_WIN2KSP2    0x05000200      && Windows 2000 with SP2
#DEFINE NTDDI_WIN2KSP1    0x05000100      && Windows 2000 with SP1
#DEFINE NTDDI_WIN2K       0x05000000      && Windows 2000

*-*
*-* Other Win32 constants
*-*
#DEFINE ERROR_INVALID_FUNCTION      1

*-*
*-*	WMHandler Constants
*-*
#DEFINE WMHANDLER_CREATE            "Create"
#DEFINE WMHANDLER_EDIT              "Edit"
#DEFINE WMHANDLER_RUN               "Run"
#DEFINE WMHANDLER_NOFORMHDL         -2
#DEFINE WMHANDLER_UNKNFORMHDL       -1

*-*
*-*	File attribute constants
*-*
#DEFINE FILE_ATTRIBUTE_READONLY     0x01
#DEFINE FILE_ATTRIBUTE_HIDDEN       0x02
#DEFINE FILE_ATTRIBUTE_SYSTEM       0x04
#DEFINE FILE_ATTRIBUTE_DIRECTORY    0x10
#DEFINE FILE_ATTRIBUTE_ARCHIVE      0x20
#DEFINE FILE_ATTRIBUTE_NORMAL       0x80
#DEFINE FILE_ATTRIBUTE_TEMPORARY    0x0100

#DEFINE MAX_PATH                    260

*-*
*-*	File I/O constants
*-*
#DEFINE GENERIC_READ              0x80000000
#DEFINE GENERIC_WRITE             0x40000000

*-*
*-*	Virtual Keyboard codes for GetKeyState
*-*
#DEFINE VK_CONTROL                0x11
#DEFINE VK_SHIFT                  0x10
#DEFINE VK_UP                     0x26
#DEFINE VK_DOWN                   0x28
#DEFINE VK_RIGHT                  0x27
#DEFINE VK_LEFT                   0x25
#DEFINE VK_RETURN                 0x0D
#DEFINE VK_TAB                    0x09
#DEFINE VK_SPACE                  0x20
#DEFINE VK_DELETE                 0x2E
#DEFINE VK_BACK                   0x08

*-*
*-* OLE Drag-n-drop constants
*-*
#DEFINE OLE_DRAG_ENTER             0
#DEFINE OLE_DRAG_LEAVE             1
#DEFINE OLE_DRAG_OVER              2
#DEFINE OLE_DROPHASDATA_NOTUSEFUL  0
#DEFINE OLE_DROPHASDATA_USEFUL     1
#DEFINE OLE_DROPEFFECT_LINK        4

*-*
*-* Property storage constants
*-*
#DEFINE PROP_PADDING_CHAR      CHR(1)   && Padding char used for properties with length > 255 characters
#DEFINE PROP_PADDING_SIZE         517   && Size of the padding area for properties with length > 255 characters
#DEFINE PROP_LEN_SIZE               8   && Size of the length structure for properties with length > 255 characters

*-*
*-*	MS RichText constants
*-*
#DEFINE WM_USER	                0x400
#DEFINE EM_SETZOOM             (WM_USER + 225)
#DEFINE EM_GETCHARFORMAT       (WM_USER + 58)
#DEFINE EM_SETCHARFORMAT       (WM_USER + 68)
#DEFINE EM_GETPARAFORMAT       (WM_USER + 61)
#DEFINE EM_SETPARAFORMAT       (WM_USER + 71)
#DEFINE EM_REDO                (WM_USER + 84)
#DEFINE EM_CANREDO             (WM_USER + 85)
#DEFINE EM_UNDO                 0x000000C7
#DEFINE EM_CANUNDO              0x000000C6
#DEFINE CFE_PROTECTED           16
#DEFINE SCF_DEFAULT             0
#DEFINE SCF_SELECTION           1
#DEFINE SCF_WORD                2
#DEFINE CFM_BACKCOLOR           0x04000000
#DEFINE CFM_PROTECTED           16
#DEFINE LF_FACESIZE             0x00000032
#DEFINE PFM_STARTINDENT			0x00000001
#DEFINE PFM_RIGHTINDENT			0x00000002
#DEFINE PFM_OFFSET				0x00000004
#DEFINE PFM_ALIGNMENT			0x00000008
#DEFINE PFM_OFFSETINDENT		0x80000000
#DEFINE PFM_TABSTOPS			0x00000010
#DEFINE PFM_SPACEBEFORE			0x00000040
#DEFINE PFM_SPACEAFTER			0x00000080
#DEFINE PFM_LINESPACING			0x00000100

*-*
*-*	MS FlexGrid constants
*-*
#DEFINE flexAlignLeftTop       0        && The cell content is aligned left, top. 
#DEFINE flexAlignLeftCenter    1        && Default for strings. The cell content is aligned left, center. 
#DEFINE flexAlignLeftBottom    2        && The cell content is aligned left, bottom. 
#DEFINE flexAlignCenterTop     3        && The cell content is aligned center, top. 
#DEFINE flexAlignCenterCenter  4        && The cell content is aligned center, center. 
#DEFINE flexAlignCenterBottom  5        && The cell content is aligned center, bottom. 
#DEFINE flexAlignRightTop      6        && The cell content is aligned right, top. 
#DEFINE flexAlignRightCenter   7        && Default for numbers. The cell content is aligned right, center. 
#DEFINE flexAlignRightBottom   8        && The cell content is aligned right, bottom. 
#DEFINE flexAlignGeneral       9        && The cell content is of general alignment. This is "left, center" for strings and "right, center" for numbers. 
#DEFINE flexResizeNone         0        && Default. The user cannot resize WITH the mouse. 
#DEFINE flexResizeColumns      1        && The user can resize columns using the mouse. 
#DEFINE flexResizeRows         2        && The user can resize rows using the mouse. 
#DEFINE flexResizeBoth         3        && The user can resize columns AND rows using the mouse. 

*-*
*-*	Database support
*-*
#DEFINE _DBC_DataBase          PADR("Database",10)
#DEFINE _DBC_Table             PADR("Table",10)
#DEFINE _DBCID_Path            1
#DEFINE _DBC_ObjectNotFound   -1
#DEFINE _DBC_ObjectFound       0

*-*
*-*	Support
*-*
#DEFINE CR                     CHR(13)
#DEFINE LF                     CHR(10)
#DEFINE CRLF                   CR+LF
#DEFINE TAB                    CHR(9)
#DEFINE CHKBOX_CHECKED         CHR(0xFE)
#DEFINE CHKBOX_UNCHECKED       CHR(0x6F)
#DEFINE False                  .F.
#DEFINE True                   .T.

*-*
*-*	Code comparison line colors
*-*
#DEFINE LINEMATCH              RGB(255,255,255)          && Line background: White
#DEFINE LINESIMILAR            RGB(255,255,164)          && Line background: Yellow
#DEFINE LINEMISSING            RGB(230,230,230)          && Line background: Red
#DEFINE LINEDIFFERENT          RGB(255,202,202)          && Line background: Gray

*-*
*-* CodeMax image defines
*-*
#DEFINE cmImgClass             0
#DEFINE cmImgConstant          1
#DEFINE cmImgDelegate          2
#DEFINE cmImgEnum              3
#DEFINE cmImgEnumMember        4
#DEFINE cmImgEvent             5
#DEFINE cmImgException         6
#DEFINE cmImgField             7
#DEFINE cmImgInterface         8
#DEFINE cmImgMacro             9
#DEFINE cmImgMap              10
#DEFINE cmImgMapItem          11
#DEFINE cmImgMethod           12
#DEFINE cmImgObject            4
#DEFINE cmImgOverload         13
#DEFINE cmImgModule           14
#DEFINE cmImgNamespace        15
#DEFINE cmImgOperator         16
#DEFINE cmImgProperty         17
#DEFINE cmImgStruct           18
#DEFINE cmImgTemplate         19
#DEFINE cmImgTypedef          20
#DEFINE cmImgType             21
#DEFINE cmImgUnion            22
#DEFINE cmImgVariable         23
#DEFINE cmImgValueType        24
#DEFINE cmImgIntrinsic        25

*-*
*-* CodeMax margin image defines (starting bit position in ItemData)
*-*
#DEFINE cmMarginImageBookMark     0
#DEFINE cmMarginImageChangeMark   1

*-*
*-*	CodeMax defines
*-*
#DEFINE cmNotifyDel          0x2
#DEFINE cmParseDirForward      0
#DEFINE cmParseDirBackward     1

*-*
*-*	CodeMax hotkey scan codes
*-*
#DEFINE CM_HOTKEY_ALT             4
#DEFINE CM_HOTKEY_CTRL            2
#DEFINE CM_HOTKEY_SHIFT           1
#DEFINE CM_HOTKEY_F1              CHR(0x70)
#DEFINE CM_HOTKEY_LEFTARR         CHR(34)
#DEFINE CM_HOTKEY_RIGHTARR        CHR(33)
#DEFINE CM_HOTKEY_NONE            0

*-*
*-*	CodeMax keyscan codes
*-*
#DEFINE CM_KEYCODE_NONE            0
#DEFINE CM_KEYCODE_SHIFT           1
#DEFINE CM_KEYCODE_CONTROL         2
#DEFINE CM_KEYCODE_ALT             4
#DEFINE CM_KEYCODE_SPACE           32
#DEFINE CM_KEYCODE_BKSP            8
#DEFINE CM_KEYCODE_TAB             9
#DEFINE CM_KEYCODE_ENTER           13
#DEFINE CM_KEYCODE_F1              112
#DEFINE CM_KEYCODE_F2              113
#DEFINE CM_KEYCODE_F3              114
#DEFINE CM_KEYCODE_F4              115
#DEFINE CM_KEYCODE_F5              116
#DEFINE CM_KEYCODE_F6              117
#DEFINE CM_KEYCODE_F7              118
#DEFINE CM_KEYCODE_F8              119
#DEFINE CM_KEYCODE_F9              120
#DEFINE CM_KEYCODE_F10             121
#DEFINE CM_KEYCODE_F11             122
#DEFINE CM_KEYCODE_F12             123
#DEFINE CM_KEYCODE_LEFTARR         37
#DEFINE CM_KEYCODE_UPARR           38
#DEFINE CM_KEYCODE_RIGHTARR        39
#DEFINE CM_KEYCODE_DOWNARR         40
#DEFINE CM_KEYCODE_SINGLEQUOTE     222
#DEFINE CM_KEYCODE_SEMICOLON       186
#DEFINE CM_KEYCODE_PLUS            107
#DEFINE CM_KEYCODE_MINUS           109
#DEFINE CM_KEYCODE_LEFTBRACKET     219
#DEFINE CM_KEYCODE_LEFTPARENTHIS   57
#DEFINE CM_KEYCODE_RIGHTBRACKET    221
#DEFINE CM_KEYCODE_FWDSLASH        191
#DEFINE CM_KEYCODE_BACKSLASH       220
#DEFINE CM_KEYCODE_COMMA           188
#DEFINE CM_KEYCODE_PERIOD          190
#DEFINE CM_KEYCODE_INSERT          45
#DEFINE CM_KEYCODE_DELETE          46
#DEFINE CM_KEYCODE_PAGEUP          33
#DEFINE CM_KEYCODE_PAGEDOWN        34
#DEFINE CM_KEYCODE_HOME            36
#DEFINE CM_KEYCODE_END             35
#DEFINE CM_KEYCODE_DASH            189
#DEFINE CM_KEYCODE_EQUAL           187
#DEFINE CM_KEYCODE_X               88

#DEFINE cmClrWindow                     0                && window background color
#DEFINE cmClrLeftMargin                 1                && left margin background color
#DEFINE cmClrBookmark                   2                && bookmark foreground color
#DEFINE cmClrBookmarkBk                 3                && bookmark background color
#DEFINE cmClrLineNumber                 4                && line number foreground color
#DEFINE cmClrLineNumberBk               5                && line number background color
#DEFINE cmClrHDividerLines              6                && line number divider line color
#DEFINE cmClrVDividerLines              7                && left margin separator line color
#DEFINE cmClrBraceHighlight             8                && Brace foreground color
#DEFINE cmClrBraceHighlightBk           9                && Brace background color
                                         
#DEFINE cmFontNormal                    0                && normal font
#DEFINE cmFontBold                      1                && bold font
#DEFINE cmFontItalic                    2                && italic font
#DEFINE cmFontBoldItalic                3                && bold + italic font
#DEFINE cmFontUnderline                 4                && normal + underlined font
                                         
#DEFINE cmIndentOff                     0
#DEFINE cmIndentScope                   1
#DEFINE cmIndentPrevLine                2
                                        
#DEFINE cmPrnPromptDlg                  0x000            && display the print common dialog
#DEFINE cmPrnDefaultPrn                 0x001            && use default printer (no print dialog displayed)
#DEFINE cmPrnHDC                        0x002            && use HDC provided
#DEFINE cmPrnRichFonts                  0x004            && use bold, italics, underline, etc. when appropriate
#DEFINE cmPrnColor                      0x008            && print in color
#DEFINE cmPrnPageNums                   0x010            && print 'page # of #' at the bottom of the page
#DEFINE cmPrnDateTime                   0x020            && print date and time at top of the page
#DEFINE cmPrnBorderThin                 0x040            && surround text with a thin border
#DEFINE cmPrnBorderThick                0x080            && surround text with a thick border
#DEFINE cmPrnBorderDouble               0x100            && surround text with two thin borders
#DEFINE cmPrnSelection                  0x200            && print the selection rather than entire edit contents

*-*
*-*	CodeMax command defines
*-*
#DEFINE cmCmdAppendNextCut                210            &&  Adds the next cut text to end of the Clipboard
#DEFINE cmCmdBeginUndo                    225            &&  Starts an undo transaction
#DEFINE cmCmdBookmarkClearAll             207            &&  Clears all bookmarks in the window
#DEFINE cmCmdBookmarkJumpToFirst          208            &&  Moves to the first line containing a bookmark
#DEFINE cmCmdBookmarkJumpToLast           209            &&  Moves to the last line containing a bookmark
#DEFINE cmCmdBookmarkNext                 206            &&  Moves to the line containing the next bookmark
#DEFINE cmCmdBookmarkPrev                 205            &&  Moves to the line containing the previous bookmark
#DEFINE cmCmdBookmarkToggle               204            &&  Toggles a bookmark for the current line on and off
#DEFINE cmCmdCaseSensitiveOff             237            &&  Turns off case sensitive searching
#DEFINE cmCmdCaseSensitiveOn              236            &&  Turns on case sensitive searching
#DEFINE cmCmdCharLeft                     203            &&  Moves the cursor one character to the left
#DEFINE cmCmdCharLeftExtend               202            &&  Extends the selection one character to the left
#DEFINE cmCmdCharLeftExtendCol            251            &&  Extends the column selection one character to the left
#DEFINE cmCmdCharRight                    201            &&  Moves the cursor one character to the right
#DEFINE cmCmdCharRightExtend              200            &&  Extends the selection one character to the right
#DEFINE cmCmdCharRightExtendCol           252            &&  Extends the column selection one character to the left
#DEFINE cmCmdCharTranspose                199            &&  Swap characters around the insertion point
#DEFINE cmCmdChooseCmd                    246            &&  Prompts for and then executes a selected command
#DEFINE cmCmdClearSelection               229            &&  Empties the selection
#DEFINE cmCmdCommentSelection             265            &&  Adds a comment around the selected text
#DEFINE cmCmdCommitMember                 261            &&  Choose the currently selected item in a memberlist popup
#DEFINE cmCmdCompleteWord                 260            &&  Auto-complete word from list of available members
#DEFINE cmCmdCopy                         198            &&  Copies the selection to the Clipboard
#DEFINE cmCmdCut                          197            &&  Cuts the selection and puts it on the Clipboard
#DEFINE cmCmdCutSelection                 196            &&  Cuts the selection and puts it on the Clipboard
#DEFINE cmCmdDelete                       195            &&  Deletes the selection
#DEFINE cmCmdDeleteBack                   194            &&  Deletes the selection or if there is no selection the character to the left of the cursor
#DEFINE cmCmdDeleteBlankLines             193            &&  Deletes the blank lines adjacent to the cursor
#DEFINE cmCmdDeleteHorizontalSpace        192            &&  Deletes the spaces and tabs around the cursor
#DEFINE cmCmdDocumentEnd                  191            &&  Moves to the end of the file
#DEFINE cmCmdDocumentEndExtend            190            &&  Extends the selection to the end of the file
#DEFINE cmCmdDocumentStart                189            &&  Moves to the beginning of the file
#DEFINE cmCmdDocumentStartExtend          188            &&  Extends the selection to the beginning of the file
#DEFINE cmCmdEnd                          184            &&  Moves to the end of the current line bottom of the text window or end of the file
#DEFINE cmCmdEndExtend                    264            &&  Extends the selection to the end of the line
#DEFINE cmCmdEndUndo                      226            &&  Ends an undo transaction
#DEFINE cmCmdFind                         178            &&  Finds the specified text
#DEFINE cmCmdFindMarkAll                  177            &&  Finds the specified text and sets a bookmark at the found locations
#DEFINE cmCmdFindNext                     176            &&  Finds the next occurrence of the specified text
#DEFINE cmCmdFindNextWord                 175            &&  Finds the next occurrence of the selected text
#DEFINE cmCmdFindPrev                     174            &&  Finds the previous occurrence of the specified text
#DEFINE cmCmdFindPrevWord                 173            &&  Finds the previous occurrence of the selected text
#DEFINE cmCmdFindReplace                  169            &&  Displays the find & replace dialog box
#DEFINE cmCmdGotoIndentation              167            &&  Moves to the end of the indentation
#DEFINE cmCmdGotoLine                     168            &&  Moves to a user-specified line.  If –1, a prompt dialog will appear.
#DEFINE cmCmdGotoMatchBrace               166            &&  Finds the matching brace
#DEFINE cmCmdHome                         165            &&  Moves to either the start of the current line or the start of the text on that line
#DEFINE cmCmdHomeExtend                   164            &&  Extends the selection to either the start of the current line or the start of the text on that line
#DEFINE cmCmdIncrementalSearch            257            &&  Search incrementally in forward direction
#DEFINE cmCmdIndentSelection              163            &&  Indents the selected text right one tab stop
#DEFINE cmCmdIndentToPrev                 162            &&  Indents to the position of the next text on the previous line
#DEFINE cmCmdInsertChar                   211            &&  Inserts a character at the current location
#DEFINE cmCmdInsertGUID                   255            &&  Inserts a GUID at the current location
#DEFINE cmCmdLineCut                      161            &&  Deletes the selected lines and places the text on the clipboard
#DEFINE cmCmdLineDelete                   160            &&  Deletes the selected line
#DEFINE cmCmdLineDeleteEndSpace           256            &&  Deletes whitespace at the end of each selected line
#DEFINE cmCmdLineDeleteToEnd              159            &&  Deletes to the end of the current line
#DEFINE cmCmdLineDeleteToStart            158            &&  Deletes to the beginning of the current line
#DEFINE cmCmdLineDown                     157            &&  Moves the cursor down one line
#DEFINE cmCmdLineDownExtend               156            &&  Extends the selection down one line
#DEFINE cmCmdLineDownExtendCol            250            &&  Extends the column selection down one line
#DEFINE cmCmdLineEnd                      155            &&  Moves the cursor to the end of the current line
#DEFINE cmCmdLineEndExtend                154            &&  Extends the selection to the end of the current line
#DEFINE cmCmdLineOpenAbove                153            &&  Opens a new line above the cursor
#DEFINE cmCmdLineOpenBelow                152            &&  Opens a new line below the cursor
#DEFINE cmCmdLineStart                    151            &&  Moves to the start of the current line
#DEFINE cmCmdLineTranspose                150            &&  Swaps current and previous lines
#DEFINE cmCmdLineUp                       149            &&  Moves the cursor up one line
#DEFINE cmCmdLineUpExtend                 148            &&  Extends the selection up one line
#DEFINE cmCmdLineUpExtendCol              249            &&  Extends the column selection up one line
#DEFINE cmCmdListMembers                  259            &&  Display a list of available members
#DEFINE cmCmdLowercaseSelection           147            &&  Makes the selection all lowercase
#DEFINE cmCmdMoveLineDown                 248            &&  Moves the current line down one position
#DEFINE cmCmdMoveLineUp                   247            &&  Moves the current line up one position
#DEFINE cmCmdNewLine                      212            &&  Inserts a new-line character at the current location
#DEFINE cmCmdOvertypeOff                  241            &&  Turns off overtype mode
#DEFINE cmCmdOvertypeOn                   240            &&  Turns on overtype mode
#DEFINE cmCmdPageDown                     146            &&  Moves the cursor down one page
#DEFINE cmCmdPageDownExtend               145            &&  Extends the selection down one page
#DEFINE cmCmdPageUp                       144            &&  Moves the cursor up one page
#DEFINE cmCmdPageUpExtend                 143            &&  Extends the selection up one page
#DEFINE cmCmdParaDown                     142            &&  Moves to the beginning of the next paragraph
#DEFINE cmCmdParameterInfo                262            &&  Display parameter information
#DEFINE cmCmdParaUp                       141            &&  Moves to the beginning of the previous paragraph
#DEFINE cmCmdPaste                        140            &&  Inserts the Clipboard contents at the insertion point
#DEFINE cmCmdPlayMacro1                   214            &&  Plays keystroke macro 1
#DEFINE cmCmdPlayMacro10                  223            &&  Plays keystroke macro 10
#DEFINE cmCmdPlayMacro2                   215            &&  Plays keystroke macro 2
#DEFINE cmCmdPlayMacro3                   216            &&  Plays keystroke macro 3
#DEFINE cmCmdPlayMacro4                   217            &&  Plays keystroke macro 4
#DEFINE cmCmdPlayMacro5                   218            &&  Plays keystroke macro 5
#DEFINE cmCmdPlayMacro6                   219            &&  Plays keystroke macro 6
#DEFINE cmCmdPlayMacro7                   220            &&  Plays keystroke macro 7
#DEFINE cmCmdPlayMacro8                   221            &&  Plays keystroke macro 8
#DEFINE cmCmdPlayMacro9                   222            &&  Plays keystroke macro 9
#DEFINE cmCmdPreserveCaseOff              235            &&  Turns off case preservation when replacing text
#DEFINE cmCmdPreserveCaseOn               234            &&  Turns on case preservation when replacing text
#DEFINE cmCmdProperties                   224            &&  Displays the properties dialog
#DEFINE cmCmdQuickInfo                    263            &&  Display symbol information in a tooltip
#DEFINE cmCmdRecordMacro                  213            &&  Begins/ends keystroke macro-recording
#DEFINE cmCmdRedo                         139            &&  Redoes the previously undone action
#DEFINE cmCmdRedoChanges                  138            &&  Redoes the last action ignoring movement commands
#DEFINE cmCmdRegExpOff                    231            &&  Turns off regular expression searching
#DEFINE cmCmdRegExpOn                     230            &&  Turns on regular expression searching
#DEFINE cmCmdReplace                      170            &&  Replaces the first occurrence of the find text after the current position with the replace text
#DEFINE cmCmdReplaceAllInBuffer           171            &&  Replaces the find text with the replace text in the entire buffer
#DEFINE cmCmdReplaceAllInSelection        172            &&  Replaces the find text with the replace text in the selection
#DEFINE cmCmdReverseIncrementalSearch     258            &&  Search incrementally in reverse direction
#DEFINE cmCmdSelectAll                    137            &&  Selects the entire document
#DEFINE cmCmdSelectLine                   136            &&  Selects lines of text
#DEFINE cmCmdSelectPara                   135            &&  Selects the current paragraph
#DEFINE cmCmdSelectSwapAnchor             134            &&  Swaps the anchor and the cursor in a selection
#DEFINE cmCmdSelectWord                   267            &&  Selects the current word
#DEFINE cmCmdSelExtendOff                 245            &&  Turns off extended selection mode
#DEFINE cmCmdSelExtendOn                  244            &&  Turns on extended selection mode
#DEFINE cmCmdSentenceCut                  133            &&  Deletes the remainder of the sentence
#DEFINE cmCmdSentenceLeft                 132            &&  Moves to the beginning of the previous sentence
#DEFINE cmCmdSentenceRight                131            &&  Moves to the beginning of the next sentence
#DEFINE cmCmdSetFindText                  179            &&  Sets the text to search for in subsequent find commands
#DEFINE cmCmdSetRepeatCount               187            &&  Sets the repeat count for the next command
#DEFINE cmCmdSetReplaceText               180            &&  Sets the text to substitute for the find text in subsequent find & replace commands
#DEFINE cmCmdSortLinesAscending           253            &&  Sort selected lines in ascending alphabetical order
#DEFINE cmCmdSortLinesDescending          254            &&  Sort selected lines in descending alphabetical order
#DEFINE cmCmdTabifySelection              130            &&  Replaces spaces with tabs in the selection
#DEFINE cmCmdToggleCaseSensitive          183            &&  Toggles case sensitive searching on and off
#DEFINE cmCmdToggleOvertype               186            &&  Toggles between inserting and replacing text
#DEFINE cmCmdTogglePreserveCase           181            &&  Toggles intelligent case preservation when replacing text
#DEFINE cmCmdToggleRegExp                 228            &&  Toggles regular expression searching on and off
#DEFINE cmCmdToggleSelExtend              243            &&  Toggles extended selection mode
#DEFINE cmCmdToggleWhitespaceDisplay      185            &&  Shows or hides whitespace indicators
#DEFINE cmCmdToggleWholeWord              182            &&  Toggles whole word searching on and off
#DEFINE cmCmdUncommentSelection           266            &&  Removes the comment surrounding the selected text
#DEFINE cmCmdUndo                         129            &&  Undoes the last action
#DEFINE cmCmdUndoChanges                  128            &&  Undoes the last action ignoring movement commands
#DEFINE cmCmdUnindentSelection            127            &&  Indents the selected text left one tab stop
#DEFINE cmCmdUntabifySelection            126            &&  Replaces tabs with spaces in the selection
#DEFINE cmCmdUppercaseSelection           125            &&  Makes the selection all uppercase
#DEFINE cmCmdWhitespaceDisplayOff         239            &&  Turns off whitespace display
#DEFINE cmCmdWhitespaceDisplayOn          238            &&  Turns on whitespace display
#DEFINE cmCmdWholeWordOff                 233            &&  Turns off whole word searching
#DEFINE cmCmdWholeWordOn                  232            &&  Turns on whole word searching
#DEFINE cmCmdWindowEnd                    124            &&  Moves to the bottom of the text window
#DEFINE cmCmdWindowLeftEdge               123            &&  Moves to the left edge of the text window
#DEFINE cmCmdWindowRightEdge              122            &&  Moves to the right edge of the text window
#DEFINE cmCmdWindowScrollDown             121            &&  Scrolls the file contents down one line
#DEFINE cmCmdWindowScrollLeft             120            &&  Scrolls the window to the left
#DEFINE cmCmdWindowScrollRight            119            &&  Scrolls the window to the right
#DEFINE cmCmdWindowScrollToBottom         118            &&  Scrolls the line to the bottom of the window
#DEFINE cmCmdWindowScrollToCenter         117            &&  Scrolls the line to the center of the window
#DEFINE cmCmdWindowScrollToTop            116            &&  Scrolls the line to the top of the window
#DEFINE cmCmdWindowScrollUp               115            &&  Scrolls the file contents up one line
#DEFINE cmCmdWindowStart                  114            &&  Moves to the top of the text window
#DEFINE cmCmdWordCapitalize               113            &&  Makes the first character uppercase
#DEFINE cmCmdWordDeleteToEnd              112            &&  Deletes a word to the right
#DEFINE cmCmdWordDeleteToStart            111            &&  Deletes a word to the left
#DEFINE cmCmdWordEndLeft                  109            &&  Moves backward to the end of the previous word
#DEFINE cmCmdWordEndLeftExtend            110            &&  Extends the selection backward to the end of the previous word
#DEFINE cmCmdWordEndRight                 104            &&  Moves forward to the end of the next word
#DEFINE cmCmdWordEndRightExtend           105            &&  Extends the selection forward to the start of the next word
#DEFINE cmCmdWordLeft                     108            &&  Moves backward to the start of the previous word
#DEFINE cmCmdWordLeftExtend               107            &&  Extends the selection backward to the start of the previous word
#DEFINE cmCmdWordLowerCase                106            &&  Makes the current word lowercase
#DEFINE cmCmdWordRight                    103            &&  Moves forward to the start of the next word
#DEFINE cmCmdWordRightExtend              102            &&  Extends the selection forward to the start of the next word
#DEFINE cmCmdWordTranspose                101            &&  Swaps the current and previous words
#DEFINE cmCmdWordUppercase                100            &&  Makes the current word uppercase

*-*
*-*	CodeMax.Control.HitTest() return codes
*-*
#DEFINE cmNowhere                         0              &&  Not over the CodeMax control 
#DEFINE cmHSplitter                       1              &&  Over the horizontal splitter bar 
#DEFINE cmVSplitter                       2              &&  Over the vertical splitter bar 
#DEFINE cmHVSplitter                      3              &&  Over the intersection of the horizontal and vertical splitter bar 
#DEFINE cmEditSpace                       4              &&  Over the buffer contents (code) 
#DEFINE cmHScrollBar                      5              &&  Over the horizontal scrollbar 
#DEFINE cmVScrollBar                      6              &&  Over the vertical scrollbar 
#DEFINE cmSizeBox                         7              &&  Over the sizebox visible when both scrollbars are visible 
#DEFINE cmLeftMargin                      8              &&  Over the left margin area 

*-*
*-*	Project group types for display in treeview
*-*
#DEFINE PRJGRP_WRK             1
#DEFINE PRJGRP_FRM             2
#DEFINE PRJGRP_CLS             3
#DEFINE PRJGRP_COD             4
#DEFINE PRJGRP_DAT             5
#DEFINE PRJGRP_RPT             6
#DEFINE PRJGRP_OTH             7

*-*
*-*	Project file types
*-*
#DEFINE PRJTYPE_APPLIC       "Z"
#DEFINE PRJTYPE_ASSOCTBL     "t"
#DEFINE PRJTYPE_CLS          "C"
#DEFINE PRJTYPE_DBC	         "d"
#DEFINE PRJTYPE_FILE         "x"
#DEFINE PRJTYPE_FORM         "K"
#DEFINE PRJTYPE_HEADER       "H"
#DEFINE PRJTYPE_ICON         "i"
#DEFINE PRJTYPE_LABEL        "B"
#DEFINE PRJTYPE_LIBRARY      "L"
#DEFINE PRJTYPE_MENU         "M"
#DEFINE PRJTYPE_PRJHOOK      "W"
#DEFINE PRJTYPE_PROGRAM      "P"
#DEFINE PRJTYPE_QUERY        "Q"
#DEFINE PRJTYPE_REPORT       "R"
#DEFINE PRJTYPE_TABLE        "D"
#DEFINE PRJTYPE_TEXT         "T"
#DEFINE PRJTYPE_VCX          "V"
#DEFINE PRJTYPE_VFPPROJ      "Y"
#DEFINE PRJTYPE_REMOTEVIEW   "A"
#DEFINE PRJTYPE_LOCALVIEW    "L"
#DEFINE PRJTYPE_DBCTABLE     "G"
#DEFINE PRJTYPE_DBCCONNECT   "C"
#DEFINE PRJTYPE_METHOD       "E"
#DEFINE PRJTYPE_CLASSDEF     "1"
#DEFINE PRJTYPE_CLASSPROP    "2"
#DEFINE PRJTYPE_OBJECT       "O"
#DEFINE PRJTYPE_INCLUDE      "F"

#DEFINE DEFINE_KEYWORD       "J"

*-*
*-*	Object types in cursor
*-*
#DEFINE OBJTYPE_FORM         0    && Form base object
#DEFINE OBJTYPE_CLAS         0    && Class base object
#DEFINE OBJTYPE_INCL         2    && Include file
#DEFINE OBJTYPE_METH         4    && Form method
#DEFINE OBJTYPE_FINH         6    && Form inherited method
#DEFINE OBJTYPE_PROP         8    && Property method (access/assign)
#DEFINE OBJTYPE_DATA        10    && Dataenvironment
#DEFINE OBJTYPE_DMET        11    && Dataenvironment method
#DEFINE OBJTYPE_ADPT        12    && Cursor Adapter
#DEFINE OBJTYPE_AMTH        13    && Cursor Adapter method
#DEFINE OBJTYPE_CURS        14    && Cursor
#DEFINE OBJTYPE_CMET        15    && Cursor method
#DEFINE OBJTYPE_RELA        16    && Relation
#DEFINE OBJTYPE_RMET        17    && Relation method
#DEFINE OBJTYPE_CTRL        18    && Control object
#DEFINE OBJTYPE_GRID        19    && Grid objects
#DEFINE OBJTYPE_MBRC        20    && Memberclass code reference
#DEFINE OBJTYPE_TMET        21    && Control object method
#DEFINE OBJTYPE_CPRP        22    && Control Property method (access/assign)
#DEFINE OBJTYPE_IMET        23    && Control object inherited method
#DEFINE OBJTYPE_UNKN        24    && Added missing object due to not loading VCX

*-*
*-*	Project Object sub-types displayed in treeview
*-*
#DEFINE TVW_DBC     "d00"         && Database name
#DEFINE TVW_DGP     "TH0"         && Table header
#DEFINE TVW_DBF     "TD0"         && Table name
#DEFINE TVW_TFD     "TDF"         && Table field name
#DEFINE TVW_TNX     "TDN"         && Table index name
#DEFINE TVW_LGP     "LH0"         && Local view header
#DEFINE TVW_LGP     "LH0"         && Local view header
#DEFINE TVW_VEW     "LL0"         && Local view name
#DEFINE TVW_VFD     "LLF"         && Local view field name
#DEFINE TVW_RGP     "RH0"         && Remote view header
#DEFINE TVW_REW     "RR0"         && Remote view name
#DEFINE TVW_RFD     "RRF"         && Remote view field name
#DEFINE TVW_GCN     "CH0"         && Connection header
#DEFINE TVW_CON     "CC0"         && Connection name
#DEFINE TVW_GSP     "SH0"         && Stored procedure header
#DEFINE TVW_SPR     "SS0"         && Stored procedure name
#DEFINE TVW_VLB     "V00"         && Visual class library
#DEFINE TVW_VCL     "VV0"         && Visual class in library

#DEFINE TVW_NODE_DBF "DD0"        && Free Table node
#DEFINE TVW_NODE_DBC "dd0"        && Database node
#DEFINE TVW_NODE_DCF "dTD"        && Database table node

#DEFINE TVW_FIRST       0         && First node at same level in relative
#DEFINE TVW_LAST        1         && Last node at same level in relative
#DEFINE TVW_NEXT        2         && Placed after the node in relative
#DEFINE TVW_PREVIOUS    3         && Placed before the node in relative
#DEFINE TVW_CHILD       4         && Next child node of the node in relative

*-*
*-*	File types
*-*
#DEFINE _DBC_LOCAL_VIEW     "LOCAL_VIEW"
#DEFINE _DBC_REMOTE_VIEW    "REMOTE_VIEW"

*-*
*-*	Defines for Ownerdrawn Menu colors
*-*
#DEFINE COLOR_ACTIVECAPTION               2
#DEFINE COLOR_INACTIVECAPTION             3
#DEFINE COLOR_MENU                        4
#DEFINE COLOR_WINDOW                      5
#DEFINE COLOR_MENUTEXT                    7
#DEFINE COLOR_HIGHLIGHT                  13
#DEFINE COLOR_HIGHLIGHTTEXT              14
#DEFINE COLOR_BTNFACE                    15
#DEFINE COLOR_BTNSHADOW                  16
#DEFINE COLOR_BTNHIGHLIGHT               20
#DEFINE COLOR_3DDKSHADOW                 21
#DEFINE COLOR_GRADIENTACTIVECAPTION      27
#DEFINE COLOR_GRADIENTINACTIVECAPTION    28
#DEFINE COLOR_MENUHILIGHT                29
#DEFINE COLOR_MENUBAR                    30

*-*
*-**************************************************
*-* Ultimate Grid 97 ActiveX
*-* Dundas Software Ltd. 1994-1998
*-* 
*-* Standard Defines
*-**************************************************
*-* Cell Properties, used by IsPropertySet(), etc
*-*
#DEFINE UGCELL_TEXT_SET                1
#DEFINE UGCELL_STRING_SET              1
#DEFINE UGCELL_MASK_SET                2
#DEFINE UGCELL_LABEL_SET               4
#DEFINE UGCELL_DATATYPE_SET            8
#DEFINE UGCELL_PARAM_SET              16
#DEFINE UGCELL_CELLTYPE_SET           32
#DEFINE UGCELL_CELLTYPEEX_SET         64
#DEFINE UGCELL_TEXTCOLOR_SET         128
#DEFINE UGCELL_BACKCOLOR_SET         256
#DEFINE UGCELL_HTEXTCOLOR_SET        512
#DEFINE UGCELL_HBACKCOLOR_SET       1024
#DEFINE UGCELL_BORDERSTYLE_SET      2048
#DEFINE UGCELL_BORDER_SET           2048
#DEFINE UGCELL_BORDERCOLOR_SET      4096
#DEFINE UGCELL_FONT_SET             8192
#DEFINE UGCELL_BITMAP_SET          16384
#DEFINE UGCELL_ALIGNMENT_SET       32768
#DEFINE UGCELL_EXTRAMEMORY_SET     65536
#DEFINE UGCELL_JOIN_SET           131072
#DEFINE UGCELL_FORMAT_SET        2097152
#DEFINE UGCELL_NOTUSED           4194304
#DEFINE UGCELL_STYLE_SET         8388608
#DEFINE UGCELL_READONLY_SET     16777216
#DEFINE UGCELL_NUMBERDEC_SET    33554432

*-*
*-* cell data types
*-*
#DEFINE UGCELLDATA_STRING              1
#DEFINE UGCELLDATA_NUMBER              2
#DEFINE UGCELLDATA_BOOL                3
#DEFINE UGCELLDATA_TIME                4
#DEFINE UGCELLDATA_CURRENCY            5

*-*
*-* Grid Sections - used by menu commands, etc
*-*
#DEFINE UG_GRID                        1
#DEFINE UG_TOPHEADING                  2
#DEFINE UG_SIDEHEADING                 3
#DEFINE UG_CORNERBUTTON                4
#DEFINE UG_HSCROLL                     5
#DEFINE UG_VSCROLL                     6
#DEFINE UG_TAB                         7

*-*
*-* movement defines
*-*
#DEFINE UG_LINEUP                      0
#DEFINE UG_LINEDOWN                    1
#DEFINE UG_PAGEUP                      2
#DEFINE UG_PAGEDOWN                    3
#DEFINE UG_TOP                         4
#DEFINE UG_BOTTOM                      5

*-*
*-* data types
*-*
#DEFINE UG_NODATA                     -1
#DEFINE UG_TEXTDATA                    0
#DEFINE UG_BOOLDATA                    1
#DEFINE UG_NUMBERDATA                  2
#DEFINE UG_DATEDATA                    3
#DEFINE UG_TIMEDATA                    4

*-*
*-* scrolling
*-*
#DEFINE UG_SCROLLNORMAL                0
#DEFINE UG_SCROLLTRACKING              1
#DEFINE UG_SCROLLJOYSTICK              2

*-*
*-* alignment defines
*-*
#DEFINE UG_ALIGNLEFT                   1
#DEFINE UG_ALIGNRIGHT                  2
#DEFINE UG_ALIGNCENTER                 4
#DEFINE UG_ALIGNTOP                    8
#DEFINE UG_ALIGNBOTTOM                16
#DEFINE UG_ALIGNVCENTER               32

*-*
*-* border style defines
*-*
#DEFINE UG_BDR_LTHIN                   1
#DEFINE UG_BDR_TTHIN                   2
#DEFINE UG_BDR_RTHIN                   4
#DEFINE UG_BDR_BTHIN                   8
#DEFINE UG_BDR_LMEDIUM                16
#DEFINE UG_BDR_TMEDIUM                32
#DEFINE UG_BDR_RMEDIUM                64
#DEFINE UG_BDR_BMEDIUM               128
#DEFINE UG_BDR_LTHICK                256
#DEFINE UG_BDR_TTHICK                512
#DEFINE UG_BDR_RTHICK               1024
#DEFINE UG_BDR_BTHICK               2048
#DEFINE UG_BDR_RECESSED             4096
#DEFINE UG_BDR_RAISED               8192

*-*
*-* sorting
*-*
#DEFINE UG_SORT_ASCENDING              1
#DEFINE UG_SORT_DESCENDING             2

*-*
*-* finding
*-*
#DEFINE UG_FIND_PARTIAL                1
#DEFINE UG_FIND_CASEINSENSITIVE        2
#DEFINE UG_FIND_UP                     4
#DEFINE UG_FIND_ALLCOLUMNS             8

*-*
*-* best fit defines
*-*
#DEFINE UG_BESTFIT_TOPHEADINGS         1 
#DEFINE UG_BESTFIT_AVERAGE             2

*-*
*-* printing defines
*-*
#DEFINE UG_PRINT_TOPHEADING            1
#DEFINE UG_PRINT_SIDEHEADING           2
#DEFINE UG_PRINT_LEFTMARGIN            3
#DEFINE UG_PRINT_TOPMARGIN             4
#DEFINE UG_PRINT_RIGHTMARGIN           5
#DEFINE UG_PRINT_BOTTOMMARGIN          6

*-*
*-* Normal CellType Value - most other cell types
*-* also use these values, so bits 1-8 are reserved generally reserved
*-*
#DEFINE UGCT_NORMAL                    0

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_NORMALSINGLELINE          1
#DEFINE UGCT_NORMALMULTILINE           2
#DEFINE UGCT_NORMALELLIPSIS            4
#DEFINE UGCT_NORMALLABELTEXT           8

*-*
*-* Droplist CellType Value
*-*
#DEFINE UGCT_DROPLIST                  1

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_DROPLISTHIDEBUTTON      512

*-*
*-* Droplist OnCellType notifications
*-*
#DEFINE UGCT_DROPLISTSTART           100
*#DEFINE UGCT_DROPLISTSELECT         101
#DEFINE UGCT_DROPLISTSELECT          103

*-*
*-* CheckBox CellType Value
*-*
#DEFINE UGCT_CHECKBOX                  2

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_CHECKBOXFLAT              0
#DEFINE UGCT_CHECKBOXCROSS             0
#DEFINE UGCT_CHECKBOX3DRECESS        256
#DEFINE UGCT_CHECKBOX3DRAISED        512
#DEFINE UGCT_CHECKBOXCHECKMARK      4096

*-*
*-* CheckBox OnCellType notifications
*-*
#DEFINE UGCT_CHECKBOXSET              53

*-*
*-* Arrow CellType Value
*-*
#DEFINE UGCT_ARROW                     3

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_ARROWRIGHT               16
#DEFINE UGCT_ARROWLEFT                32
#DEFINE UGCT_ARROWDRIGHT              64
#DEFINE UGCT_ARROWDLEFT              128

*-*
*-* SpinButton CellType Value
*-*
#DEFINE UGCT_SLIDER                    4

*-*
*-* Advanced Progress Bar CellType Value
*-*
#DEFINE UGCT_ADVANCEDPROGRESS          5

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_PROGRESS_NORMAL           0
#DEFINE UGCT_PROGRESS_ALERT            1
#DEFINE UGCT_PROGRESS_RAINBOW        256

*-*
*-* Advanced Progress Bar starting positions
*-*
#DEFINE UGCT_PROGRESS_TOP              1                   && paint from top to bottom
#DEFINE UGCT_PROGRESS_LEFT             2                   && paint from left to right (default)
#DEFINE UGCT_PROGRESS_RIGHT            3                   && paint from right to left
#DEFINE UGCT_PROGRESS_BOTTOM           4                   && paint from bottom to top

*-*
*-* AutoFont CellType Value
*-*
#DEFINE UGCT_AUTOFONT                  6

*-*
*-* PieChart CellType Value
*-*
#DEFINE UGCT_PIECHART                  7

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_PIECHARTSEPARATE         16
#DEFINE UGCT_PIECHARTPERCENT          32
#DEFINE UGCT_PIECHARTDATA             64

*-*
*-* Multi-Font CellType Value
*-*
#DEFINE UGCT_MULTIFONT                 8

*-*
*-* RadioButton CellType Value
*-*
#DEFINE UGCT_RADIOBUTTON               9

*-*
*-* EllipsisButton CellType Value
*-*
#DEFINE UGCT_ELLIPSIS                 10

*-*
*-* EllipsisButton OnCellType notifications
*-*
#DEFINE UGCT_ELLIPSISBUTTONCLICK     100

*-*
*-* Sort Arrow CellType Value
*-*
#DEFINE UGCT_SORTARROW                11

*-*
*-* Sort Arrow OnCellType notifications
*-*
#DEFINE UGCT_SORTARROWUP              16
#DEFINE UGCT_SORTARROWDOWN            32

*-*
*-* Progress Bar CellType Value
*-*
#DEFINE UGCT_PROGRESSBAR              12

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_PROGRESSBARLABEL          1

*-*
*-* SpinButton CellType Value
*-*
#DEFINE UGCT_SPINBUTTON               13

*-*
*-* Spinbutton OnCellType notifications
*-*
#DEFINE UGCT_SPINBUTTONUP             16
#DEFINE UGCT_SPINBUTTONDOWN           17

*-*
*-* Button CellType Value
*-*
#DEFINE UGCT_BUTTON                   14

*-*
*-* CellTypeEx Values
*-*
#DEFINE UGCT_BUTTONNOFOCUS            16

*-*
*-* Button OnCellType notifications
*-*
#DEFINE UGCT_BUTTONCLICK               1
#DEFINE UGCT_BUTTONDOWN                2
#DEFINE UGCT_BUTTONUP                  3 

*-*
*-* Property Grid column defines
*-*
#DEFINE UGCOL_NAME                    -1
#DEFINE UGCOL_VALUE                    0
#DEFINE UGCOL_ACCESS                   1
#DEFINE UGCOL_ASSIGN                   2
#DEFINE UGCOL_VISIBILTY                3
#DEFINE UGCOL_FAVORITES                4
#DEFINE UGCOL_DEFAULT                  5

*-*
*-*	Table column values for TableGrid
*-*
#DEFINE UGCOL_FIELDNAME       1
#DEFINE UGCOL_FIELDTYPE       2
#DEFINE UGCOL_FIELDWIDTH      3
#DEFINE UGCOL_FIELDDEC        4
#DEFINE UGCOL_FIELDDEF        5
#DEFINE UGCOL_FIELDNULL       6

*-*
*-*	Table column values for IndexGrid
*-*
#DEFINE UGCOL_INDEXORDER      1
#DEFINE UGCOL_INDEXNAME       2
#DEFINE UGCOL_INDEXTYPE       3
#DEFINE UGCOL_INDEXEXPR       4
#DEFINE UGCOL_INDEXFILTER     5
#DEFINE UGCOL_INDEXUNIQUE     6
#DEFINE UGCOL_INDEXCOLLATE    7

*-*
*-*	Grid Property favorite indicator
*-*
#DEFINE UG_NOT_FAVORITE                 0
#DEFINE UG_LOC_FAVORITE                 1
#DEFINE UG_GBL_FAVORITE                 2

*-*
*-*	Grid Property groups
*-*
#DEFINE UGPG_FAVORITE                  "A"     && V
#DEFINE UGPG_CUSTOM                    "C"     && C
#DEFINE UGPG_LAYOUT                    "E"     && L
#DEFINE UGPG_FORMAT                    "G"     && F
#DEFINE UGPG_WINDOW                    "I"     && W
#DEFINE UGPG_DATA                      "K"     && D
#DEFINE UGPG_OTHER                     "L"     && O
#DEFINE UGPG_RUNTIME                   "N"     && R
#DEFINE UGPG_UNKNOWN                   "P"     && Z

*-*
*-*	Grid Property types
*-*
#DEFINE UGPT_ANCHOR                    "P"
#DEFINE UGPT_BOOL                      "B"
#DEFINE UGPT_CENUM                     "E"
#DEFINE UGPT_COLOR                     "C"
#DEFINE UGPT_DATE                      "D"
#DEFINE UGPT_DATETIME                  "T"
#DEFINE UGPT_EXPR                      "R"
#DEFINE UGPT_FLOAT                     "A"
#DEFINE UGPT_FONTINFO                  "O"
#DEFINE UGPT_FONTNAME                  "F"
#DEFINE UGPT_FUNCTION                  "G"
#DEFINE UGPT_GETFILE                   "J"
#DEFINE UGPT_GRAPHIC                   "K"
#DEFINE UGPT_INTEGER                   "I"
#DEFINE UGPT_LOV                       "L"
#DEFINE UGPT_USERLOV                   "5"
#DEFINE UGPT_MEMBER                    "H"
#DEFINE UGPT_NAME                      "Q"
#DEFINE UGPT_NENUM                     "M"
#DEFINE UGPT_NOEDIT                    "N"
#DEFINE UGPT_SPINNER                   "S"
#DEFINE UGPT_TEXT                      "X"
#DEFINE UGPT_ALIAS                     "U"
#DEFINE UGPT_ORDER                     "V"
#DEFINE UGPT_INITALIAS                 "W"
#DEFINE UGPT_FILTER                    "Y"
#DEFINE UGPT_GRIDPROP                  "Z"
#DEFINE UGPT_CURRCTRL                  "1"
#DEFINE UGPT_COLUMNORDER               "2"
#DEFINE UGPT_CTRLSRC                   "3"
#DEFINE UGPT_TABINDEX                  "4"

*-*
*-* Windows Constants
*-*
*-* Common Stuff
*-*
#DEFINE BROADCAST_QUERY_DENY	0x424D5144  && Return this value to deny a query.("BMQD")
#DEFINE GWL_WNDPROC				(-4)

*-*
*-* GA Flags
*-*
#DEFINE GA_PARENT     			0x0001 
#DEFINE GA_ROOT       			0x0002 
#DEFINE GA_ROOTOWNER  			0x0003 

*-*
*-* Windows messages
*-*
#DEFINE WM_NULL					0x0000
#DEFINE WM_CREATE				0x0001
#DEFINE WM_DESTROY				0x0002
#DEFINE WM_MOVE					0x0003
#DEFINE WM_SIZE					0x0005
#DEFINE WM_ACTIVATE				0x0006
#DEFINE WM_SETFOCUS				0x0007
#DEFINE WM_KILLFOCUS			0x0008
#DEFINE WM_ENABLE				0x000A
#DEFINE WM_SETREDRAW			0x000B
#DEFINE WM_SETTEXT				0x000C
#DEFINE WM_GETTEXT				0x000D
#DEFINE WM_GETTEXTLENGTH		0x000E
#DEFINE WM_PAINT				0x000F
#DEFINE WM_CLOSE				0x0010
#DEFINE WM_QUERYENDSESSION		0x0011
#DEFINE WM_QUIT					0x0012
#DEFINE WM_QUERYOPEN			0x0013
#DEFINE WM_ERASEBKGND			0x0014
#DEFINE WM_SYSCOLORCHANGE		0x0015
#DEFINE WM_ENDSESSION			0x0016
#DEFINE WM_SHOWWINDOW			0x0018
#DEFINE WM_WININICHANGE			0x001A
#DEFINE WM_DEVMODECHANGE		0x001B
#DEFINE WM_ACTIVATEAPP			0x001C
#DEFINE WM_FONTCHANGE			0x001D
#DEFINE WM_TIMECHANGE			0x001E
#DEFINE WM_CANCELMODE			0x001F
#DEFINE WM_SETCURSOR			0x0020
#DEFINE WM_MOUSEACTIVATE		0x0021
#DEFINE WM_CHILDACTIVATE		0x0022
#DEFINE WM_QUEUESYNC			0x0023
#DEFINE WM_GETMINMAXINFO		0x0024
#DEFINE WM_PAINTICON			0x0026
#DEFINE WM_ICONERASEBKGND		0x0027
#DEFINE WM_NEXTDLGCTL			0x0028
#DEFINE WM_SPOOLERSTATUS		0x002A
#DEFINE WM_DRAWITEM				0x002B
#DEFINE WM_MEASUREITEM			0x002C
#DEFINE WM_DELETEITEM			0x002D
#DEFINE WM_VKEYTOITEM			0x002E
#DEFINE WM_CHARTOITEM			0x002F
#DEFINE WM_SETFONT				0x0030
#DEFINE WM_GETFONT				0x0031
#DEFINE WM_SETHOTKEY			0x0032
#DEFINE WM_GETHOTKEY			0x0033
#DEFINE WM_QUERYDRAGICON		0x0037
#DEFINE WM_COMPAREITEM			0x0039
#DEFINE WM_COMPACTING			0x0041
#DEFINE WM_WINDOWPOSCHANGING	0x0046
#DEFINE WM_WINDOWPOSCHANGED		0x0047
#DEFINE WM_POWER				0x0048
#DEFINE WM_COPYDATA				0x004A
#DEFINE WM_CANCELJOURNAL		0x004B
#DEFINE WM_NCCREATE				0x0081
#DEFINE WM_NCDESTROY			0x0082
#DEFINE WM_NCCALCSIZE			0x0083
#DEFINE WM_NCHITTEST			0x0084
#DEFINE WM_NCPAINT				0x0085
#DEFINE WM_NCACTIVATE			0x0086
#DEFINE WM_GETDLGCODE			0x0087
#DEFINE WM_NCMOUSEMOVE			0x00A0
#DEFINE WM_NCLBUTTONDOWN		0x00A1
#DEFINE WM_NCLBUTTONUP			0x00A2
#DEFINE WM_NCLBUTTONDBLCLK		0x00A3
#DEFINE WM_NCRBUTTONDOWN		0x00A4
#DEFINE WM_NCRBUTTONUP			0x00A5
#DEFINE WM_NCRBUTTONDBLCLK		0x00A6
#DEFINE WM_NCMBUTTONDOWN		0x00A7
#DEFINE WM_NCMBUTTONUP			0x00A8
#DEFINE WM_NCMBUTTONDBLCLK		0x00A9
#DEFINE WM_KEYFIRST				0x0100
#DEFINE WM_KEYDOWN				0x0100
#DEFINE WM_KEYUP				0x0101
#DEFINE WM_CHAR					0x0102
#DEFINE WM_DEADCHAR				0x0103
#DEFINE WM_SYSKEYDOWN			0x0104
#DEFINE WM_SYSKEYUP				0x0105
#DEFINE WM_SYSCHAR				0x0106
#DEFINE WM_SYSDEADCHAR			0x0107
#DEFINE WM_KEYLAST				0x0108
#DEFINE WM_INITDIALOG			0x0110
#DEFINE WM_COMMAND				0x0111
#DEFINE WM_SYSCOMMAND			0x0112
#DEFINE WM_TIMER				0x0113
#DEFINE WM_HSCROLL				0x0114
#DEFINE WM_VSCROLL				0x0115
#DEFINE WM_INITMENU				0x0116
#DEFINE WM_INITMENUPOPUP		0x0117
#DEFINE WM_MENUSELECT			0x011F
#DEFINE WM_MENUCHAR				0x0120
#DEFINE WM_ENTERIDLE			0x0121
#DEFINE WM_CTLCOLORMSGBOX		0x0132
#DEFINE WM_CTLCOLOREDIT			0x0133
#DEFINE WM_CTLCOLORLISTBOX		0x0134
#DEFINE WM_CTLCOLORBTN			0x0135
#DEFINE WM_CTLCOLORDLG			0x0136
#DEFINE WM_CTLCOLORSCROLLBAR	0x0137
#DEFINE WM_CTLCOLORSTATIC		0x0138
#DEFINE WM_MOUSEFIRST			0x0200
#DEFINE WM_MOUSEMOVE			0x0200
#DEFINE WM_LBUTTONDOWN			0x0201
#DEFINE WM_LBUTTONUP			0x0202
#DEFINE WM_LBUTTONDBLCLK		0x0203
#DEFINE WM_RBUTTONDOWN			0x0204
#DEFINE WM_RBUTTONUP			0x0205
#DEFINE WM_RBUTTONDBLCLK		0x0206
#DEFINE WM_MBUTTONDOWN			0x0207
#DEFINE WM_MBUTTONUP			0x0208
#DEFINE WM_MBUTTONDBLCLK		0x0209
#DEFINE WM_MOUSELAST			0x0209
#DEFINE WM_PARENTNOTIFY			0x0210
#DEFINE WM_ENTERMENULOOP		0x0211
#DEFINE WM_EXITMENULOOP			0x0212
#DEFINE WM_POWERBROADCAST		0x0218
#DEFINE WM_DEVICECHANGE			0x0219
#DEFINE WM_MDICREATE			0x0220
#DEFINE WM_MDIDESTROY			0x0221
#DEFINE WM_MDIACTIVATE			0x0222
#DEFINE WM_MDIRESTORE			0x0223
#DEFINE WM_MDINEXT				0x0224
#DEFINE WM_MDIMAXIMIZE			0x0225
#DEFINE WM_MDITILE				0x0226
#DEFINE WM_MDICASCADE			0x0227
#DEFINE WM_MDIICONARRANGE		0x0228
#DEFINE WM_MDIGETACTIVE			0x0229
#DEFINE WM_MDISETMENU			0x0230
#DEFINE WM_DROPFILES			0x0233
#DEFINE WM_MDIREFRESHMENU		0x0234
#DEFINE WM_CUT					0x0300
#DEFINE WM_COPY					0x0301
#DEFINE WM_PASTE				0x0302
#DEFINE WM_CLEAR				0x0303
#DEFINE WM_UNDO					0x0304
#DEFINE WM_RENDERFORMAT			0x0305
#DEFINE WM_RENDERALLFORMATS		0x0306
#DEFINE WM_DESTROYCLIPBOARD		0x0307
#DEFINE WM_DRAWCLIPBOARD		0x0308
#DEFINE WM_PAINTCLIPBOARD		0x0309
#DEFINE WM_VSCROLLCLIPBOARD		0x030A
#DEFINE WM_SIZECLIPBOARD		0x030B
#DEFINE WM_ASKCBFORMATNAME		0x030C
#DEFINE WM_CHANGECBCHAIN		0x030D
#DEFINE WM_HSCROLLCLIPBOARD		0x030E
#DEFINE WM_QUERYNEWPALETTE		0x030F
#DEFINE WM_PALETTEISCHANGING	0x0310
#DEFINE WM_PALETTECHANGED		0x0311
#DEFINE WM_HOTKEY				0x0312
#DEFINE WM_THEMECHANGED			0x031A
#DEFINE WM_PENWINFIRST			0x0380
#DEFINE WM_PENWINLAST			0x038F

*-*
*-* WM_ACTIVATE state values
*-*
#DEFINE WA_INACTIVE				0
#DEFINE WA_ACTIVE				1
#DEFINE WA_CLICKACTIVE			2

*-*
*-* Shell notification fSources
*-*
#DEFINE SHCNRF_INTERRUPTLEVEL	    0x0001
#DEFINE SHCNRF_SHELLLEVEL		    0x0002
#DEFINE SHCNRF_RECURSIVEINTERRUPT	0x1000
#DEFINE SHCNRF_NEWDELIVERY		    0x8000

*-*
*-* Device and Media Events
*-*
#DEFINE WM_USER_SHNOTIFY          WM_USER+10
#DEFINE SHCNE_RENAMEITEM          0x00000001
#DEFINE SHCNE_CREATE              0x00000002
#DEFINE SHCNE_DELETE              0x00000004
#DEFINE SHCNE_MKDIR               0x00000008
#DEFINE SHCNE_RMDIR               0x00000010
#DEFINE SHCNE_MEDIAINSERTED       0x00000020
#DEFINE SHCNE_MEDIAREMOVED        0x00000040
#DEFINE SHCNE_DRIVEREMOVED        0x00000080
#DEFINE SHCNE_DRIVEADD            0x00000100
#DEFINE SHCNE_NETSHARE            0x00000200
#DEFINE SHCNE_NETUNSHARE          0x00000400
#DEFINE SHCNE_ATTRIBUTES          0x00000800
#DEFINE SHCNE_UPDATEDIR           0x00001000
#DEFINE SHCNE_UPDATEITEM          0x00002000
#DEFINE SHCNE_SERVERDISCONNECT    0x00004000
#DEFINE SHCNE_UPDATEIMAGE         0x00008000
#DEFINE SHCNE_DRIVEADDGUI         0x00010000
#DEFINE SHCNE_RENAMEFOLDER        0x00020000
#DEFINE SHCNE_FREESPACE           0x00040000
#DEFINE SHCNE_ASSOCCHANGED	      0x08000000
 
#DEFINE SHCNE_DISKEVENTS          0x0002381F
#DEFINE SHCNE_GLOBALEVENTS        0x0C0581E0 
#DEFINE SHCNE_ALLEVENTS           0x7FFFFFFF
#DEFINE SHCNE_INTERRUPT           0x80000000 

*-* #DEFINE CSIDL_DESKTOP                   0x0000        &&// <desktop>
*-* #DEFINE CSIDL_INTERNET                  0x0001        &&// Internet Explorer (icon on desktop)
*-* #DEFINE CSIDL_PROGRAMS                  0x0002        &&// Start Menu\Programs
*-* #DEFINE CSIDL_CONTROLS                  0x0003        &&// My Computer\Control Panel
*-* #DEFINE CSIDL_PRINTERS                  0x0004        &&// My Computer\Printers
*-* #DEFINE CSIDL_PERSONAL                  0x0005        &&// My Documents
*-* #DEFINE CSIDL_FAVORITES                 0x0006        &&// <user name>\Favorites
*-* #DEFINE CSIDL_STARTUP                   0x0007        &&// Start Menu\Programs\Startup
*-* #DEFINE CSIDL_RECENT                    0x0008        &&// <user name>\Recent
*-* #DEFINE CSIDL_SENDTO                    0x0009        &&// <user name>\SendTo
*-* #DEFINE CSIDL_BITBUCKET                 0x000a        &&// <desktop>\Recycle Bin
*-* #DEFINE CSIDL_STARTMENU                 0x000b        &&// <user name>\Start Menu
*-* #DEFINE CSIDL_MYDOCUMENTS               0x000c        &&// logical "My Documents" desktop icon
*-* #DEFINE CSIDL_MYMUSIC                   0x000d        &&// "My Music" folder
*-* #DEFINE CSIDL_MYVIDEO                   0x000e        &&// "My Videos" folder

#DEFINE WM_DEVICECHANGE         	    0x0219
#DEFINE DBT_DEVNODES_CHANGED            0x0007
#DEFINE DBT_DEVICEARRIVAL               0x8000  &&// system detected a new device
#DEFINE DBT_DEVICEQUERYREMOVE           0x8001  &&// wants to remove, may fail
#DEFINE DBT_DEVICEQUERYREMOVEFAILED     0x8002  &&// removal aborted
#DEFINE DBT_DEVICEREMOVEPENDING         0x8003  &&// about to remove, still avail.
#DEFINE DBT_DEVICEREMOVECOMPLETE        0x8004  &&// device is gone
#DEFINE DBT_DEVTYP_OEM                  0x00000000  &&// oem-defined device type
#DEFINE DBT_DEVTYP_DEVNODE              0x00000001  &&// devnode number
#DEFINE DBT_DEVTYP_VOLUME               0x00000002  &&// logical volume
#DEFINE DBT_DEVTYP_PORT                 0x00000003  &&// serial, parallel
#DEFINE DBT_DEVTYP_NET                  0x00000004  &&// network resource 
 
*-*
*-* Power Events
*-*
#DEFINE PBT_APMQUERYSUSPEND             0x0000
#DEFINE PBT_APMQUERYSTANDBY             0x0001
#DEFINE PBT_APMQUERYSUSPENDFAILED       0x0002
#DEFINE PBT_APMQUERYSTANDBYFAILED       0x0003
#DEFINE PBT_APMSUSPEND                  0x0004
#DEFINE PBT_APMSTANDBY                  0x0005
#DEFINE PBT_APMRESUMECRITICAL           0x0006
#DEFINE PBT_APMRESUMESUSPEND            0x0007
#DEFINE PBT_APMRESUMESTANDBY            0x0008
#DEFINE PBTF_APMRESUMEFROMFAILURE       0x00000001
#DEFINE PBT_APMBATTERYLOW               0x0009
#DEFINE PBT_APMPOWERSTATUSCHANGE        0x000A
#DEFINE PBT_APMOEMEVENT                 0x000B
#DEFINE PBT_APMRESUMEAUTOMATIC          0x0012

#DEFINE HWND_TOP        (0)
#DEFINE HWND_BOTTOM     (1)
#DEFINE HWND_TOPMOST    (0xffffffff)
#DEFINE HWND_NOTOPMOST  (0xfffffffe)

*-*
*-*	Window Styles
*-*
#DEFINE WS_OVERLAPPED       0x00000000
#DEFINE WS_POPUP            0x80000000
#DEFINE WS_CHILD            0x40000000
#DEFINE WS_MINIMIZE         0x20000000
#DEFINE WS_VISIBLE          0x10000000
#DEFINE WS_DISABLED         0x08000000
#DEFINE WS_CLIPSIBLINGS     0x04000000
#DEFINE WS_CLIPCHILDREN     0x02000000
#DEFINE WS_MAXIMIZE         0x01000000
#DEFINE WS_CAPTION          0x00C00000    
#DEFINE WS_BORDER           0x00800000
#DEFINE WS_DLGFRAME         0x00400000
#DEFINE WS_VSCROLL          0x00200000
#DEFINE WS_HSCROLL          0x00100000
#DEFINE WS_SYSMENU          0x00080000
#DEFINE WS_THICKFRAME       0x00040000
#DEFINE WS_GROUP            0x00020000
#DEFINE WS_TABSTOP          0x00010000
#DEFINE WS_MINIMIZEBOX      0x00020000
#DEFINE WS_MAXIMIZEBOX      0x00010000
#DEFINE WS_TILED            WS_OVERLAPPED
#DEFINE WS_ICONIC           WS_MINIMIZE
#DEFINE WS_SIZEBOX          WS_THICKFRAME
#DEFINE WS_TILEDWINDOW      WS_OVERLAPPEDWINDOW

*-*
*-* Show Window Constants
*-*
#DEFINE SW_FORCEMINIMIZE  		11 
#DEFINE SW_HIDE  				0 
#DEFINE SW_MAXIMIZE  			3 
#DEFINE SW_MINIMIZE  			6 
#DEFINE SW_RESTORE  			9 
#DEFINE SW_SHOW  				5 
#DEFINE SW_SHOWDEFAULT  		10 
#DEFINE SW_SHOWMAXIMIZED  		3 
#DEFINE SW_SHOWMINIMIZED  		2 
#DEFINE SW_SHOWMINNOACTIVE  	7 
#DEFINE SW_SHOWNA  				8 
#DEFINE SW_SHOWNOACTIVATE  		4 
#DEFINE SW_SHOWNORMAL  			1 
                                                 
*-*
*-*	Monitor Constants
*-*
#DEFINE SM_CMONITORS            80                         && Number of monitors
#DEFINE SM_CXHSCROLL            21                         && Width of the horizontal scrollbar in pixels
#DEFINE SM_CXVSCROLL             2                         && Width of the vertical scrollbar in pixels
#DEFINE SM_CXVIRTUALSCREEN      78                         && Width of all monitors combined

*-*
*-*	Extended Window Styles
*-*
#DEFINE WS_EX_DLGMODALFRAME     0x00000001
#DEFINE WS_EX_NOPARENTNOTIFY    0x00000004
#DEFINE WS_EX_TOPMOST           0x00000008
#DEFINE WS_EX_ACCEPTFILES       0x00000010
#DEFINE WS_EX_TRANSPARENT       0x00000020
#DEFINE WS_EX_MDICHILD          0x00000040
#DEFINE WS_EX_TOOLWINDOW        0x00000080
#DEFINE WS_EX_WINDOWEDGE        0x00000100
#DEFINE WS_EX_CLIENTEDGE        0x00000200
#DEFINE WS_EX_CONTEXTHELP       0x00000400

#DEFINE WS_EX_RIGHT             0x00001000
#DEFINE WS_EX_LEFT              0x00000000
#DEFINE WS_EX_RTLREADING        0x00002000
#DEFINE WS_EX_LTRREADING        0x00000000
#DEFINE WS_EX_LEFTSCROLLBAR     0x00004000
#DEFINE WS_EX_RIGHTSCROLLBAR    0x00000000

#DEFINE WS_EX_CONTROLPARENT     0x00010000
#DEFINE WS_EX_STATICEDGE        0x00020000
#DEFINE WS_EX_APPWINDOW         0x00040000
#DEFINE WS_EX_LAYERED           0x00080000

#DEFINE WS_EX_OVERLAPPEDWINDOW  (WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE)
#DEFINE WS_EX_PALETTEWINDOW     (WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST)

#DEFINE GWL_EXSTYLE          -20

*-*
*-*	DBC Low Level function defines
*-*
*!*	<pdm_sc_yes/>
*!*	<pdm_dd_yes/>

* Type of objects
#DEFINE _DBC_DataBase    PADR("Database",10)
#DEFINE _DBC_Table       PADR("Table",10)
#DEFINE _DBC_Field       PADR("Field",10)
#DEFINE _DBC_Index       PADR("Index",10)
#DEFINE _DBC_Relation    PADR("Relation",10)
#DEFINE _DBC_Connection  PADR("Connection",10)
#DEFINE _DBC_View        PADR("View",10)


* Properties ID
#DEFINE _DBCID_Path                 1
#DEFINE _DBCID_SubType              2
#DEFINE _DBCID_Comment              7
#DEFINE _DBCID_RuleExpression       9
#DEFINE _DBCID_RuleText            10
#DEFINE _DBCID_DefaultValue        11
#DEFINE _DBCID_ParameterList       12
#DEFINE _DBCID_ChildTag            13
#DEFINE _DBCID_InsertTrigger       14
#DEFINE _DBCID_UpdateTrigger       15
#DEFINE _DBCID_DeleteTrigger       16
#DEFINE _DBCID_Prim_Cand           17
#DEFINE _DBCID_ParentTable         18
#DEFINE _DBCID_ParentTag           19
#DEFINE _DBCID_PrimaryKey          20
#DEFINE _DBCID_Version             24
#DEFINE _DBCID_BatchUpdateCount    28
#DEFINE _DBCID_DataSource          29
#DEFINE _DBCID_ConnectName         32
#DEFINE _DBCID_UpdateName          35
#DEFINE _DBCID_FetchMemo           36
#DEFINE _DBCID_FetchSize           37
#DEFINE _DBCID_KeyField            38
#DEFINE _DBCID_MaxRecords          39
#DEFINE _DBCID_ShareConnection     40
#DEFINE _DBCID_SourceType          41
#DEFINE _DBCID_SQL                 42
#DEFINE _DBCID_Tables              43
#DEFINE _DBCID_SendUpdates         44
#DEFINE _DBCID_Updatable           45
#DEFINE _DBCID_UpdateType          46
#DEFINE _DBCID_UseMemoSize         47
#DEFINE _DBCID_WhereType           48
#DEFINE _DBCID_DisplayClass        50
#DEFINE _DBCID_DisplayClassLibrary 51
#DEFINE _DBCID_Format              55
#DEFINE _DBCID_InputMask           54
#DEFINE _DBCID_Caption             56
#DEFINE _DBCID_Asynchronous        64
#DEFINE _DBCID_BatchMode           65
#DEFINE _DBCID_ConnectString       66
#DEFINE _DBCID_ConnectTimeout      67
#DEFINE _DBCID_DispLogin           68
#DEFINE _DBCID_DispWarnings        69
#DEFINE _DBCID_IdleTimeout         70
#DEFINE _DBCID_QueryTimeout        71
#DEFINE _DBCID_Password            72
#DEFINE _DBCID_Transactions        73
#DEFINE _DBCID_UserID              74
#DEFINE _DBCID_WaitTime            75
#DEFINE _DBCID_TimeStamp           76
#DEFINE _DBCID_DataType            77
#DEFINE _DBCID_PacketSize          78
#DEFINE _DBCID_Database            79
#DEFINE _DBCID_Prepared            80
#DEFINE _DBCID_CompareMemo         81
#DEFINE _DBCID_FetchAsNeeded       82
#DEFINE _DBCID_Offline             83
*                                   84
*                                   85
#DEFINE _DBCID_DBCEvents               86
#DEFINE _DBCID_DBCEventFileName        87
#DEFINE _DBCID_AllowSimultaneousFetch  88
#DEFINE _DBCID_DisconnectRollback      89

                                   
* Table types
#DEFINE _DBF_FoxBASE     0x02 && FoxBASE
#DEFINE _DBF_FB_dBIII_NM 0x03 && FoxBASE+/dBASE III PLUS, no memo
#DEFINE _DBF_VFP         0x30 && Visual FoxPro
#DEFINE _DBF_dBIVSQLT_NM 0x43 && dBASE IV SQL table files, no memo
#DEFINE _DBF_dbIVSQLS_NM 0x63 && dBASE IV SQL system files, no memo
#DEFINE _DBF_FB_dBIII_M  0x83 && FoxBASE+/dBASE III PLUS, with memo
#DEFINE _DBF_dBIV_M      0x8B && dBASE IV with memo
#DEFINE _DBF_dBIVSQLT_M  0xCB && dBASE IV SQL table files, with memo
#DEFINE _DBF_FP2X        0xF5 && FoxPro 2.x (or earlier) with memo
#DEFINE _DBF_FoxBASE0    0xFB && FoxBASE


* Stored procedures type
#DEFINE _DBC_SP_Source   PADR("StoredProceduresSource",128)
#DEFINE _DBC_SP_FXP      PADR("StoredProceduresObject",128)
#DEFINE _DBC_SP_TSource  0
#DEFINE _DBC_SP_TFXP     1


* Errors
#DEFINE _DBC_ObjectNotType  -2
#DEFINE _DBC_ObjectNotFound -1
#DEFINE _DBC_ObjectFound     0

#DEFINE _DBC_ErrParamFailed         -103 && Wrong any parameter
#DEFINE _DBC_ErrNotOpenLowLevelFile -102 && I can not open file
#DEFINE _DBC_ErrOther               -100 && Any bug
#DEFINE _DBC_ErrOK                   0   && OK
