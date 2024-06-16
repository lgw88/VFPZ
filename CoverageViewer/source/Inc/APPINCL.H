#IF 0                            AppIncl.h

  Purpose:  Define Application-wide constants

Revisions:  November 30, 2012 - Ken Green - Original

     Uses:  FOXPRO.H - VFP's Manifest constants

*****************************************************************************
#ENDIF

* Project Name
#DEFINE APP_NAME        "CvgViewr"

* Character constants
* CR is defined as our CR_LF in WCONNECT.H
#DEFINE CR           CHR(13)
#DEFINE LF           CHR(10)
#DEFINE CR_LF        CHR(13) + CHR(10)
#DEFINE TAB          CHR(9)
#DEFINE FORMFEED     CHR(12)
#DEFINE HEX_FF       CHR(255)
#DEFINE HEX_0        CHR(0)

* Background colors for form messages
#DEFINE WARNCOLOR   RGB(255,255,190)
#DEFINE ERRORCOLOR  RGB(255,210,210)
#DEFINE NORMCOLOR   RGB(179,255,198)
#DEFINE TOOLCOLOR   RGB(255,255,225)

* Standard VFP include file
#INCLUDE "FOXPRO.H"

* Key codes - INKEY() equivalents
#DEFINE KEY_ENTER       13
#DEFINE KEY_HOME        1
#DEFINE KEY_END         6
#DEFINE KEY_PGDN        3
#DEFINE KEY_PGUP        18
#DEFINE KEY_RIGHT       4
#DEFINE KEY_LEFT        19
#DEFINE KEY_UP          5
#DEFINE KEY_DOWN        24
#DEFINE KEY_ESC         27
#DEFINE KEY_SPACE       32
#DEFINE KEY_BACKSPACE   127
#DEFINE KEY_TAB         9
#DEFINE KEY_F1          28
#DEFINE KEY_F2          -1
#DEFINE KEY_F3          -2
#DEFINE KEY_F4          -3
#DEFINE KEY_F5          -4
#DEFINE KEY_F6          -5
#DEFINE KEY_F7          -6
#DEFINE KEY_F8          -7
#DEFINE KEY_F9          -8
#DEFINE KEY_F10         -9
#DEFINE KEY_F11         133
#DEFINE KEY_F12         134

#DEFINE KEY_SHIFT_TAB   15
#DEFINE KEY_CTRL_PGUP   31
#DEFINE KEY_CTRL_PGDN   30

#DEFINE KEY_lc_h        104
#DEFINE KEY_UC_H         72
#DEFINE KEY_lc_m        109
#DEFINE KEY_UC_M         77
#DEFINE KEY_lc_r        114
#DEFINE KEY_UC_R         82
#DEFINE KEY_lc_t        116
#DEFINE KEY_UC_T         84
#DEFINE KEY_lc_y        121
#DEFINE KEY_UC_Y         89

#DEFINE KEY_PLUS         43
#DEFINE KEY_PLUS2        61         && Got from FoxPro Advisor 4/2004, p19
#DEFINE KEY_MINUS        45

* Added keys for ADS apps
#DEFINE K_ESC   27
#DEFINE K_CTRLK 11
#DEFINE ALT_K   37

* GetDir() flags
#DEFINE BIF_RETURNONLYFSDIRS    1
#DEFINE BIF_DONTGOBELOWDOMAIN   2
#DEFINE BIF_RETURNFSANCESTORS   8
#DEFINE BIF_EDITBOX             16
#DEFINE BIF_VALIDATE            32
#DEFINE BIF_NEWDIALOGSTYLE      64
#DEFINE BIF_BROWSEINCLUDEFILES  16384
