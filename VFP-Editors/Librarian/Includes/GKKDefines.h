#DEFINE GKKDEFINES .T.

*-*
*-*	VFPxWorkbookXLSX Defines
*-*
#IFNDEF VFPXWORKBOOKXLSX
#INCLUDE ..\..\WorkbookXLSX\VFPxWorkbookXLSX.h
*-*	#INCLUDE ..\..\Common\Includes\VFPxWorkbookXLSX.h
#ENDIF

*-*
*-*	FoxCharts Defines
*-*
#DEFINE FOXCHART_PIE                         1               && Property .ChartType
#DEFINE FOXCHART_DONUT                       2
#DEFINE FOXCHART_BAR                         3
#DEFINE FOXCHART_POINT                       4
#DEFINE FOXCHART_LINE                        5
#DEFINE FOXCHART_AREA                        6
#DEFINE FOXCHART_SINGLEBAR                   7
#DEFINE FOXCHART_MULTIBAR                    8 
#DEFINE FOXCHART_STACKBAR                    9
#DEFINE FOXCHART_STACKAREA                  10
#DEFINE FOXCHART_3DBARS                     11
#DEFINE FOXCHART_HORIZ_SINGLEBAR            12
#DEFINE FOXCHART_HORIZ_MULTIBAR             13
#DEFINE FOXCHART_HORIZ_STACKBAR             14
#DEFINE FOXCHART_HORIZ_FULLSTACK            15
#DEFINE FOXCHART_FULLSTACKAREA              16
#DEFINE FOXCHART_PAIREDBARS                 17
                                            
#DEFINE FOXCHART_BARTYPE_RECT                0               && Property .BarType
#DEFINE FOXCHART_BARTYPE_CYLIND              1
#DEFINE FOXCHART_BARTYPE_TRIANG              2

#DEFINE FOXCHART_BARLEGENDIR_HORZ            0               && Horizontal (default) 
#DEFINE FOXCHART_BARLEGENDIR_VERTTOP2BOT     1               && Vertical (from TOP TO BOTTOM) 
#DEFINE FOXCHART_BARLEGENDIR_VERTBOT2TOP     2               && Vertical (from BOTTOM TO TOP) 

                                            
#DEFINE FOXCHART_BRUSHTYPE_SOLID             1               && Property .BrushType
#DEFINE FOXCHART_BRUSHTYPE_GRAD              2
#DEFINE FOXCHART_BRUSHTYPE_MONO              3
                                            
#DEFINE FOXCHART_COLORTYPE_BASIC             0               && Property .ColorType
#DEFINE FOXCHART_COLORTYPE_CUST              1
#DEFINE FOXCHART_COLORTYPE_RAND              2
#DEFINE FOXCHART_COLORTYPE_GRAD              3
                                            
#DEFINE FOXCHART_FIELDSHAPE_CLSDCIRCLE       1               && Property .Fields().Shape
#DEFINE FOXCHART_FIELDSHAPE_CLSDSQUARE       2
#DEFINE FOXCHART_FIELDSHAPE_CLSDTRIANG       3
#DEFINE FOXCHART_FIELDSHAPE_PLUSSIGN         4
#DEFINE FOXCHART_FIELDSHAPE_STAR             5
#DEFINE FOXCHART_FIELDSHAPE_SQUARE_PLUS      6
#DEFINE FOXCHART_FIELDSHAPE_OPENSQUARE       7
#DEFINE FOXCHART_FIELDSHAPE_OPENCIRCDOT      8
#DEFINE FOXCHART_FIELDSHAPE_LIGHTNING        9
#DEFINE FOXCHART_FIELDSHAPE_MAN             10
#DEFINE FOXCHART_FIELDSHAPE_DOT             11
                                            
#DEFINE FOXCHART_GRAD_SHAPE_DIR_HORZ         0               && Property .GradientShapeDirection
#DEFINE FOXCHART_GRAD_SHAPE_DIR_VERT         1
#DEFINE FOXCHART_GRAD_SHAPE_DIR_DIAG1        2
#DEFINE FOXCHART_GRAD_SHAPE_DIR_DIAG2        3
                                            
#DEFINE FOXCHART_GRAD_TYPE_SIGMABELL         0               && Property .GradientType
#DEFINE FOXCHART_GRAD_TYPE_TRIANGLAR         1
                                            
#DEFINE FOXCHART_LEGEND_POS_NONE             0               && Property .LegendPosition
#DEFINE FOXCHART_LEGEND_POS_VERT_TOP_LEFT    1
#DEFINE FOXCHART_LEGEND_POS_VERT_BOT_LEFT    2
#DEFINE FOXCHART_LEGEND_POS_VERT_TOP_RIGHT   3
#DEFINE FOXCHART_LEGEND_POS_VERT_BOT_RIGHT   4
#DEFINE FOXCHART_LEGEND_POS_HORZ_TOP_LEFT    5
#DEFINE FOXCHART_LEGEND_POS_HORZ_TOP_CENTER  6
#DEFINE FOXCHART_LEGEND_POS_HORZ_TOP_RIGHT   7
#DEFINE FOXCHART_LEGEND_POS_HORZ_BOT_LEFT    8
#DEFINE FOXCHART_LEGEND_POS_HORZ_BOT_CENTER  9
#DEFINE FOXCHART_LEGEND_POS_HORZ_BOT_RIGHT  10

#DEFINE FOXCHART_PIE_DIRECTION_CW            0               && Property .PieDirection
#DEFINE FOXCHART_PIE_DIRECTION_CCW           1

#DEFINE FOXCHART_SCALE_BACKBARTYPE_NONE      0               &&  Property .ScaleBackBarsType
#DEFINE FOXCHART_SCALE_BACKBARTYPE_HORZ      1
#DEFINE FOXCHART_SCALE_BACKBARTYPE_VERT      2
#DEFINE FOXCHART_SCALE_BACKBARTYPE_BOTH      3

#DEFINE FOXCHART_SCALE_BACKLINES_SOLID       0               && Property .ScaleBackLinesDash
#DEFINE FOXCHART_SCALE_BACKLINES_DASH        1
#DEFINE FOXCHART_SCALE_BACKLINES_DOT         2
#DEFINE FOXCHART_SCALE_BACKLINES_DASHDOT     3
#DEFINE FOXCHART_SCALE_BACKLINES_DASHDOTDOT  4

#DEFINE FOXCHART_SCALE_BACKLINETYPE_NONE     0               && Property .ScaleBackLinesType
#DEFINE FOXCHART_SCALE_BACKLINETYPE_HORZ     1
#DEFINE FOXCHART_SCALE_BACKLINETYPE_VERT     2
#DEFINE FOXCHART_SCALE_BACKLINETYPE_BOTH     3

*-*
*-*	Bank Account Types
*-*
#DEFINE BANK_ACCT_CHECKING            "00001"
#DEFINE BANK_ACCT_SAVINGS             "00002"
#DEFINE BANK_ACCT_SIMPLOAN            "00003"
#DEFINE BANK_ACCT_MORTLOAN            "00004"
#DEFINE BANK_ACCT_CDSAVINGS           "00005"
#DEFINE BANK_ACCT_CREDCARD            "00006"

*-*
*-*	Message box return values
*-*
#DEFINE PROFIT_LOSS_INCOME            "1INCOME"
#DEFINE PROFIT_LOSS_OTHINCOME         "2OTHINCOME"
#DEFINE PROFIT_LOSS_INCTOTALS         "3INCTOTALS"
#DEFINE PROFIT_LOSS_INCOMEADJ         "4INCOMEADJ"
#DEFINE PROFIT_LOSS_NETINCOME         "5NETINCOME"
#DEFINE PROFIT_LOSS_EXPENSES          "6EXPENSES"
#DEFINE PROFIT_LOSS_NETPROFIT         "7NETPROFIT"

*-*
*-*	Message box return values
*-*
#DEFINE MSGBOX_CANCEL                  1
#DEFINE MSGBOX_OK                      2
#DEFINE MSGBOX_CLOSE                   3

*-*
*-*	WinSock defines
*-*
#DEFINE CLASSEVERSION                  '1.23'
#DEFINE VFP_VERSION                       INT(VERSION(5)/100)
#DEFINE VFPWINSOCK_TIMEOUT                35                         && timeout d'attente de réponse du serveur // SERVER TIMEOUT IN SECONDS
#DEFINE VFPWINSOCK_SMTP_PORT              25                         && // SMTP SERVER TCP PORT 25 BY DEFAULT
#DEFINE VFPWINSOCK_NNTP_PORT             119                         && // NNTP SERVER TCP PORT 119 BY DEFAULT
#DEFINE C_SCKCONNECTED                     7
#DEFINE VFPWINSOCK_INTERNAL_DELIMITER    ";"                         && internal delimiter for emails, emails names, attachments change from , to ; in v1.23
#DEFINE MSG_ERR_UNABLE_INTIALIZE_WS      "ERR00 : Unable to initialize Winsock on this computer."
#DEFINE MSG_ERR01_MISSING_SMTP_HOST      "ERR01 : Specify the SMTP server in SMTP_HOST property."
#DEFINE MSG_ERR01_MISSING_NNTP_HOST      "ERR01 : Specify the NNTP server in NNTP_HOST property."
#DEFINE MSG_ERR01_MISSING_NNTP_GROUP     "ERR01 : Specify the NNTP Group in NNTP_GROUP property."
#DEFINE MSG_ERR02_MISSING_FROM           "ERR02 : Specify the mail sender in FROM property."
#DEFINE MSG_ERR03_MISSING_TO             "ERR03 : Specify the mail recipient in TO property."
#DEFINE MSG_ERR04_UNREACHABLE_HOST       "ERR04 : Server unreachable."
#DEFINE MSG_ERR05_NOREPLY_HOST           "ERR05 : No response from the server"
#DEFINE MSG_ERR06_FILE_NOFOUND           "ERR06 : attachment file not found."
#DEFINE MSG_ERR07_MHTML_FILE_NOFOUND     "ERR07 : mhtml attachment file not found."
#DEFINE MSG_ERR08_MHTML_FILE_WRONG       "ERR08 : The mhtml file does not seem to be in mhtml format. It does not contain a MIME-Version."
#DEFINE MSG_ERR09_WRONG_RESPONSE         "ERR09 : Expected return was :"
#DEFINE MSG_ERR10_CONNECT_LOST           "ERR10 : XXX connection lost with SMTP server."
#DEFINE MSG_ERR14_SENDDATA_RETRY         "ERR14 : retry send data... Number of Bytes:"
#DEFINE MSG_ERR15_SENDDATA_TIMEOUT       "ERR15 : Timeout error in SendData."
#DEFINE MSG_ERR16_EMAIL_REJECTED         "ERR16 : Email Address Rejected."
#DEFINE MSG_ERR17_MESSAGE_REJECTED       "ERR17 : Message Rejected."
#DEFINE COMPIL_AVEC_COM                  .F.

#DEFINE TIME_ZONE_ID_UNKNOWN             0
#DEFINE TIME_ZONE_ID_STANDARD            1
#DEFINE TIME_ZONE_ID_DAYLIGHT            2

#DEFINE READ_SIZE                        16384
#DEFINE READ_FROM_SERVER_TIMEOUT          1000
#DEFINE AF_INET                              2
#DEFINE SOCK_STREAM                          1
#DEFINE IPPROTO_TCP                          6
#DEFINE IPPROTO_UDP                         17
#DEFINE SOCK_DGRAM                           2
#DEFINE SOCKET_ERROR                        -1
#DEFINE FD_READ                              1
#DEFINE HOSTENT_SIZE                        16
#DEFINE SOL_SOCKET                      0xffff                       && /* options for socket level */
#DEFINE SO_RCVTIMEO                     0x1006                       && /* receive timeout */

*-*
*-*	Service Order line item types
*-*
#DEFINE SERVICE_TYPE_TIME      "T"
#DEFINE SERVICE_TYPE_QTY       "Q"

*-*
*-*	Email Attachment types
*-*
#DEFINE EMAIL_SALES_INVOICES     0
#DEFINE EMAIL_SALES_ORDERS       1
#DEFINE EMAIL_PURCH_ORDERS       2
#DEFINE EMAIL_SERVICE_ORDERS     3
#DEFINE EMAIL_SERVICE_INVOICES   4

*-*
*-*	Comment types
*-*
#DEFINE COMMENT_TYPE_SVC_GROUP  "G"
#DEFINE COMMENT_TYPE_SVC_ORDR   "V"
#DEFINE COMMENT_TYPE_SALE_ORDR  "S"
#DEFINE COMMENT_TYPE_PURC_ORDR  "P"

*-*
*-*	Employee payroll wage types
*-*
#DEFINE WAGE_TYPE_GROSS        "00001"   && Gross pay
#DEFINE WAGE_TYPE_NETP         "0000A"   && Net pay
#DEFINE WAGE_TYPE_FTAX         "00004"   && Federal tax
#DEFINE WAGE_TYPE_STAX         "00005"   && State tax
#DEFINE WAGE_TYPE_LTAX         "00006"   && Local tax
#DEFINE WAGE_TYPE_CTAX         "00007"   && City tax
#DEFINE WAGE_TYPE_EMED         "00003"   && Employee paid Medicare
#DEFINE WAGE_TYPE_ESSN         "00002"   && Employee paid SSN
#DEFINE WAGE_TYPE_RSSN         "00009"   && Employer paid SSN
#DEFINE WAGE_TYPE_RMED         "0000B"   && Employer paid Medicare
#DEFINE WAGE_TYPE_RETRO        "0000E"   && Backpay for pay increase not paid

*-*
*-*	Employee salary types
*-*
#DEFINE SALARY_TYPE_SALARIED      "00001"
#DEFINE SALARY_TYPE_HOURLY        "00002"
#DEFINE SALARY_TYPE_SALARIED_NON  "00003"
#DEFINE SALARY_TYPE_BONUS         "00004"

*-*
*-*	Employee salary types
*-*
#DEFINE PAY_TYPE_WEEKLY           "00001"
#DEFINE PAY_TYPE_BIWEEKLY         "00002"
#DEFINE PAY_TYPE_MONTHLY          "00003"
#DEFINE PAY_TYPE_SEMIMONTHLY      "00004"
#DEFINE PAY_TYPE_DAILY            "00005"

*-*
*-*	Object types for locking
*-*
#DEFINE OBJECT_TYPE_MEMBER        "01"
#DEFINE OBJECT_TYPE_SUPPLIER      "02"
#DEFINE OBJECT_TYPE_DISTRLIST     "03"
#DEFINE OBJECT_TYPE_EMPLOYEE      "04"
#DEFINE OBJECT_TYPE_ORGANIZATION  "05"
#DEFINE OBJECT_TYPE_PEOPLE        "06"
#DEFINE OBJECT_TYPE_PURCH_ORDER   "07"
#DEFINE OBJECT_TYPE_MAT_REQUEST   "08"
#DEFINE OBJECT_TYPE_SALES_ORDER   "09"
#DEFINE OBJECT_TYPE_SVC_ORDER     "10"
#DEFINE OBJECT_TYPE_WAGE_TYPES    "11"
#DEFINE OBJECT_TYPE_SVC_GROUP     "12"
#DEFINE OBJECT_TYPE_SVC_INVOICE   "13"

*-*
*-*	PO and SO status codes
*-*
#DEFINE STATUS_COMPLETED         "00001"
#DEFINE STATUS_OPEN              "00002"
#DEFINE STATUS_PASSDUE           "00003"
#DEFINE STATUS_CANCELED          "00004"
#DEFINE STATUS_SENT              "00005"
#DEFINE STATUS_INVOICERDY        "00006"
#DEFINE STATUS_SENT_TO_MBR       "00007"
#DEFINE STATUS_READY_PAYMT       "00008"
#DEFINE STATUS_PAID              "00009"
#DEFINE STATUS_PARTIAL_PO_INV    "0000A"
#DEFINE STATUS_SO_RDY_PAYMENT    "0000B"
#DEFINE STATUS_PARTIAL_PAYMENT   "0000C"
#DEFINE STATUS_INVOICE_COMPLETE  "0000D"
#DEFINE STATUS_CLOSED            "0000E"

*-*
*-*	Manual material text entry source
*-*
#DEFINE SOURCE_TYPE_DIRECT         "D"
#DEFINE SOURCE_TYPE_SALES          "S"
#DEFINE SOURCE_TYPE_SALESINV       "I"
#DEFINE SOURCE_TYPE_PURCHORD       "P"

*-*
*-*	Export to Excel values
*-*
#DEFINE ACCOUNT_CODE_EXPENSE     "6"
#DEFINE ACCOUNT_CODE_INCOME      "4"
#DEFINE ACCOUNT_CODE_OTHINC      "7"
#DEFINE ACCOUNT_CODE_INCADJ      "5"
#DEFINE ACCOUNT_CODE_LIABIL      "2"
#DEFINE ACCOUNT_CODE_OTHEXP      "8"

*-*
*-*	Export to Account types
*-*
#DEFINE ACCOUNT_TYPE_BANK        "00009"

*-*
*-*	FileSelect Form mode values
*-*
#DEFINE FILESELECT_MODE_CREATE   0
#DEFINE FILESELECT_MODE_SELECT   1

*-*
*-*	Export to Excel values
*-*
#DEFINE XLSALIGN_DEFAULT         0
#DEFINE XLSALIGN_LEFT            1
#DEFINE XLSALIGN_CENTER          2
#DEFINE XLSALIGN_RIGHT           3

#DEFINE XLSCOLOR_WHITE           1
#DEFINE XLSCOLOR_RED             2
#DEFINE XLSCOLOR_GREEN           3
#DEFINE XLSCOLOR_BLUE            4
#DEFINE XLSCOLOR_YELLOW          5
#DEFINE XLSCOLOR_MAGENTA         6
#DEFINE XLSCOLOR_CYAN            7
#DEFINE XLSCOLOR_DARKRED         8
#DEFINE XLSCOLOR_DARKGREEN       9
#DEFINE XLSCOLOR_DARKBLUE       10
#DEFINE XLSCOLOR_OLIVE          11
#DEFINE XLSCOLOR_PURPLE         12
#DEFINE XLSCOLOR_TEAL           13
#DEFINE XLSCOLOR_LTGRAY         14
#DEFINE XLSCOLOR_GRAY           15
#DEFINE XLSCOLOR_BLACK          16
#DEFINE XLSCOLOR_AUTOMATIC      17

*-*
*-*	ListView Active-X Column Alignment values
*-*
#DEFINE LISTVIEW_ALIGN_LEFT    0
#DEFINE LISTVIEW_ALIGN_RIGHT   1
#DEFINE LISTVIEW_ALIGN_CENTER  2

*-*
*-*	Defines for Charity Manager
*-*
#DEFINE PAYROLL_WITH_TIME            "PAYTIME"
#DEFINE PAYROLL_WITHOUT_TIME         "PAYNOTIME"

#DEFINE PAYROLL_GROSS_PAY            "00001"
#DEFINE PAYROLL_NET_PAY              "0000A"
#DEFINE PAYROLL_EMPLR_SSN            "00009"

#DEFINE SUPPLIER_INVOICE             "V"
#DEFINE SALES_INVOICE                "S"

#DEFINE ATTACH_TYPE_SUPPLIER         "00001"

#DEFINE PRIMARY_ADDR_TYPE            "00001"
#DEFINE REMIT_TO_ADDR                "00007"
#DEFINE ORDER_FROM_ADDR              "00008"

#DEFINE CC_TRANSTYPE_RETURN          "R"
#DEFINE CC_TRANSTYPE_PURCH           "C"

#DEFINE PAYEE_TYPE_REIMBURSEMENT     "REIMBURSE"
#DEFINE PAYEE_TYPE_DIRECT            "DIRECT"
#DEFINE PAYEE_TYPE_APPAYMENT         "APPAYMENT"
#DEFINE PAYEE_TYPE_BILLPAYMT         "BILLPAYMT"
#DEFINE PAYEE_TYPE_PAYROLL           "PAYROLL"
#DEFINE PAYEE_TYPE_BANKFEES          "BANKFEES"
#DEFINE PAYEE_TYPE_CREDCARD          "CREDCARD"

#DEFINE PAYEE_TYPE_MEMBER            "01"
#DEFINE PAYEE_TYPE_SUPPLIER          "02"
#DEFINE PAYEE_TYPE_EMPLOYEE          "03"
#DEFINE PAYEE_TYPE_OTHER             "04"
#DEFINE PAYEE_TYPE_MERCHANT          "05"
#DEFINE PAYEE_TYPE_BANKACCT          "06"
#DEFINE PAYEE_TYPE_JOURNAL           "07"
#DEFINE PAYEE_TYPE_DEPOSIT           "08"
#DEFINE PAYEE_TYPE_VOID              "09"
#DEFINE PAYEE_TYPE_WITHDRAW          "10"

#DEFINE INVOICE_TYPE_SERVICE         "00001"
#DEFINE INVOICE_TYPE_SALES           "00002"

#DEFINE TRANSACT_TYPE_ACCTFEES       "0000D"
#DEFINE TRANSACT_TYPE_BILL           "00004"
#DEFINE TRANSACT_TYPE_CONTRIBUTION   "00008"
#DEFINE TRANSACT_TYPE_CONVERSION     "0000U"
#DEFINE TRANSACT_TYPE_CREDCARDCHRG   "0000O"
#DEFINE TRANSACT_TYPE_CREDCARDFEES   "0000Q"
#DEFINE TRANSACT_TYPE_CREDCARDPAYM   "0000P"
#DEFINE TRANSACT_TYPE_CREDCARDRETN   "0000T"
#DEFINE TRANSACT_TYPE_CREDIT         "0000V"
#DEFINE TRANSACT_TYPE_DONATION       "00007"
#DEFINE TRANSACT_TYPE_EXCHANGE       "0000J"
#DEFINE TRANSACT_TYPE_EXPENSES       "0000M"
#DEFINE TRANSACT_TYPE_INVENTCHG      "0000C"
#DEFINE TRANSACT_TYPE_INVPAYMENT     "0000S"
#DEFINE TRANSACT_TYPE_INVPURCH       "0000B"
#DEFINE TRANSACT_TYPE_INVSALE        "0000A"
#DEFINE TRANSACT_TYPE_JOURNENTRY     "0000E"
#DEFINE TRANSACT_TYPE_NEWACCTBAL     "0000N"
#DEFINE TRANSACT_TYPE_OTHERMATERIAL  "0000R"
#DEFINE TRANSACT_TYPE_PAYMENT        "00005"
#DEFINE TRANSACT_TYPE_PAYROLL        "00009"
#DEFINE TRANSACT_TYPE_POINVOICE      "0000G"
#DEFINE TRANSACT_TYPE_REIMBURSEMENT  "00006"
#DEFINE TRANSACT_TYPE_REMITTANCE     "0000F"
#DEFINE TRANSACT_TYPE_RETURN         "0000K"
#DEFINE TRANSACT_TYPE_SOINVOICE      "0000H"
#DEFINE TRANSACT_TYPE_SVCINVOICE     "0000L"

#DEFINE CHECK_NBR_TYPE_MANUAL        "M"
#DEFINE CHECK_NBR_TYPE_PRINT         "P"

#DEFINE BANK_TRANSTYPE_DEPOSIT       "00001"
#DEFINE BANK_TRANSTYPE_CHECK         "00002"
#DEFINE BANK_TRANSTYPE_FEES          "00003"
#DEFINE BANK_TRANSTYPE_WITHDRAW      "00004"
#DEFINE BANK_TRANSTYPE_OPENBAL       "00000"
#DEFINE BANK_TRANSTYPE_CREDCRDCHRG   "00005"
#DEFINE BANK_TRANSTYPE_CREDCRDPAYM   "00006"
#DEFINE BANK_TRANSTYPE_CREDCRDFEES   "00007"
#DEFINE BANK_TRANSTYPE_CREDCRDRETN   "00008"
#DEFINE BANK_TRANSTYPE_EBILLPAY      "00009"

#DEFINE RELATIONSHIP_HUSBAND         "00001"
#DEFINE RELATIONSHIP_WIFE            "00002"
#DEFINE RELATIONSHIP_SELF            "0000C"

#DEFINE MATERIAL_ITEM                "MATL_ITEM"
#DEFINE MATERIAL_PRICE               "MATL_PRICE"

#DEFINE MEMBERTYPE_PEOPLE            "00003"
#DEFINE MEMBERTYPE_ORGANIZATION      "00001"
#DEFINE MEMBERTYPE_SUPPLIER          "SUPPL"

#DEFINE FAMILY_PRIMARY_ID            "00000"

#DEFINE SEARCH_MODE_EDIT             "SEARCH_EDIT"
#DEFINE SEARCH_MODE_DELETE           "SEARCH_DELETE"
#DEFINE SEARCH_MODE_MEMBER           "SEARCH_MEMBER"

#DEFINE EVENT_MAT_DELETE             "EVENT_MAT_DELETE"
#DEFINE EVENT_MAT_ADD                "EVENT_MAT_ADD"
#DEFINE EVENT_MAT_EDIT               "EVENT_MAT_EDIT"

#DEFINE EVENT_MBR_DELETE             "EVENT_MBR_DELETE"
#DEFINE EVENT_MBR_ADD                "EVENT_MBR_ADD"
#DEFINE EVENT_MBR_EDIT               "EVENT_MBR_EDIT"

#DEFINE EVENT_SAL_DELETE             "EVENT_SAL_DELETE"
#DEFINE EVENT_SAL_ADD                "EVENT_SAL_ADD"
#DEFINE EVENT_SAL_EDIT               "EVENT_SAL_EDIT"

#DEFINE EVENT_INV_DELETE             "EVENT_INV_DELETE"
#DEFINE EVENT_INV_ADD                "EVENT_INV_ADD"
#DEFINE EVENT_INV_EDIT               "EVENT_INV_EDIT"

#DEFINE EVENT_PO_DELETE             "EVENT_PO_DELETE"
#DEFINE EVENT_PO_ADD                "EVENT_PO_ADD"
#DEFINE EVENT_PO_EDIT               "EVENT_PO_EDIT"

#DEFINE EVENT_SUP_DELETE             "EVENT_SUP_DELETE"
#DEFINE EVENT_SUP_ADD                "EVENT_SUP_ADD"
#DEFINE EVENT_SUP_EDIT               "EVENT_SUP_EDIT"

#DEFINE EVENT_DTR_DELETE             "EVENT_DTR_DELETE"
#DEFINE EVENT_DTR_ADD                "EVENT_DTR_ADD"
#DEFINE EVENT_DTR_EDIT               "EVENT_DTR_EDIT"

#DEFINE SALES_ORDER                  "SALES_ORDER"

#DEFINE LABEL_REPORT                 "01"
#DEFINE EMAIL_REPORT                 "02"
#DEFINE GENERAL_REPORT               "03"

#DEFINE CONFIG_GROUP                 "A"
#DEFINE CONFIG_SUBGROUP              "B"
#DEFINE CONFIG_DATE                  "C"
#DEFINE CONFIG_RELATIONSHIPS         "D"
#DEFINE CONFIG_AFFLIATIONS           "E"
#DEFINE CONFIG_ADDRESSTYPES          "F"
#DEFINE CONFIG_SVC_TYPES             "G"

#DEFINE MATCH_ICON_ALLMATCHED        1
#DEFINE MATCH_ICON_RECMAPPED         2
#DEFINE MATCH_ICON_ADDED             3
#DEFINE MATCH_ICON_CLEAR             4
#DEFINE MATCH_ICON_MAPPEDTO          5

#DEFINE IMPORT_TYPE_MEMBER_FAMILY    "00003"
#DEFINE IMPORT_TYPE_MEMBER_INDIVL    "00002"
#DEFINE IMPORT_TYPE_MEMBER_ORGANZ    "00001"
#DEFINE IMPORT_TYPE_FINANCIAL        "00005"

#DEFINE OLE_CHECKBOX_SELECTED        CHR(0xFE)
#DEFINE OLE_CHECKBOX_NOT_SELECTED    CHR(0x6F)

#DEFINE ACCOUNT_TYPE_INCOME          "I"
#DEFINE ACCOUNT_TYPE_EXPENSE         "E"

#DEFINE ACCOUNT_GROUP_BANK           "A"
#DEFINE ACCOUNT_GROUP_LIABILITY      "B"
#DEFINE ACCOUNT_GROUP_EQUITY         "F"
#DEFINE ACCOUNT_GROUP_REVENUE        "C"
#DEFINE ACCOUNT_GROUP_GOODS          "D"
#DEFINE ACCOUNT_GROUP_EXPENSES       "E"
#DEFINE ACCOUNT_GROUP_CONVERSION     "G"

#DEFINE ENTRY_TYPE_DEBIT             "D"
#DEFINE ENTRY_TYPE_CREDIT            "C"

*-*
*-*	Label (LBX) objtypes
*-*
#DEFINE LBX_HEADER    1
#DEFINE LBX_DBF       2
#DEFINE LBX_INDEX     3
#DEFINE LBX_RELATION  4
#DEFINE LBX_LABEL     5
#DEFINE LBX_LINE      6
#DEFINE LBX_BOX       7
#DEFINE LBX_GET       8
#DEFINE LBX_BAND      9
#DEFINE LBX_GROUP     10
#DEFINE LBX_PICTURE   17
#DEFINE LBX_VAR       18
#DEFINE LBX_FONT      23
#DEFINE LBX_DATAENV   25
#DEFINE LBX_DERECORD  26


*-*
*-*	Report FRX band objcodes (objtype=9)
*-*
#DEFINE LBX_BAND_TITLE     0
#DEFINE LBX_BAND_PGHEAD    1
#DEFINE LBX_BAND_COLHEAD   2
#DEFINE LBX_BAND_GRPHEAD   3
#DEFINE LBX_BAND_DETAIL    4
#DEFINE LBX_BAND_GRPFOOT   5
#DEFINE LBX_BAND_COLFOOT   6
#DEFINE LBX_BAND_PGFOOT    7
#DEFINE LBX_BAND_SUMMARY   8


*-*
*-*	Internet Explorer AciveX defines
*-*
#DEFINE IE_READYSTATE_COMPLETE             4
#DEFINE IE_SYNCHRONOUS                     0
#DEFINE IE_INTERNET_OPEN_TYPE_PRECONFIG    0
#DEFINE IE_FLAG_ICC_FORCE_CONNECTION       1


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
#DEFINE VK_ENTER                  0x00D
#DEFINE VK_ESCAPE                 0x01B


*-*
*-*	Child semi-modal handling
*-*
#DEFINE RELEASE_SEMIMODAL_FORM       0
#DEFINE SHOW_SEMIMODAL_FORM          1

*-*
*-*	Textbox text alignments
*-*
#DEFINE TEXT_ALIGN_LEFT_CENTERED      0   && Vertically Centered Left 
#DEFINE TEXT_ALIGN_RIGHT_CENTERED     1   && Vertically Centered Right.
#DEFINE TEXT_ALIGN_CENTERED           2   && Centered.
#DEFINE TEXT_ALIGN_TOP_LEFT           4   && TOP Left. Aligns text IN TOP left corner OF the control.
#DEFINE TEXT_ALIGN_TOP_RIGHT          5   && TOP Right. Aligns text IN TOP right corner OF the control.
#DEFINE TEXT_ALIGN_TOP_CENTER         6   && TOP Center. Aligns text at the TOP AND horizontally centered ON the control.
#DEFINE TEXT_ALIGN_BOTTOM_LEFT        7   && BOTTOM Left. Aligns text IN the BOTTOM left corner OF the control. 
#DEFINE TEXT_ALIGN_BOTTOM_RIGHT       8   && BOTTOM Right. Aligns text IN BOTTOM right corner OF the control.
#DEFINE TEXT_ALIGN_BOTTOM_CENTERED    9   && BOTTOM Center.
 
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
*-*	Mouse position/button values for Explorer buttons
*-*
#DEFINE BUTTON_MOUSE_DOWN    1
#DEFINE BUTTON_MOUSE_ENTER   2
#DEFINE BUTTON_MOUSE_LEAVE   3
#DEFINE BUTTON_MOUSE_UP      4

*-*
*-*	API Timer limits
*-*
#DEFINE USER_TIMER_MINIMUM      (10 / 1000)
#DEFINE USER_TIMER_MAXIMUM      (0x7FFFFFFF / 1000)

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
*-*	File attribute constants
*-*
#DEFINE FILE_ATTRIBUTE_READONLY     0x01
#DEFINE FILE_ATTRIBUTE_HIDDEN       0x02
#DEFINE FILE_ATTRIBUTE_SYSTEM       0x04
#DEFINE FILE_ATTRIBUTE_DIRECTORY    0x10
#DEFINE FILE_ATTRIBUTE_ARCHIVE      0x20
#DEFINE FILE_ATTRIBUTE_NORMAL       0x80
#DEFINE FILE_ATTRIBUTE_TEMPORARY    0x0100

*-*
*-*	File I/O constants
*-*
#DEFINE GENERIC_READ              0x80000000
#DEFINE GENERIC_WRITE             0x40000000

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
*-* Grid column defines
*-*
#DEFINE UGCOL_NAME                    -1
#DEFINE UGCOL_VALUE                    0
#DEFINE UGCOL_ACCESS                   1
#DEFINE UGCOL_ASSIGN                   2
#DEFINE UGCOL_VISIBILTY                3
#DEFINE UGCOL_FAVORITES                4
#DEFINE UGCOL_DEFAULT                  5

*-*
*-*	Grid Property groups
*-*
#DEFINE UGPG_DATA                      "D"
#DEFINE UGPG_FORMAT                    "F"
#DEFINE UGPG_LAYOUT                    "L"
#DEFINE UGPG_OTHER                     "O"
#DEFINE UGPG_RUNTIME                   "R"
#DEFINE UGPG_WINDOW                    "W"

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
#DEFINE BULLET_NUMBER           2
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
#DEFINE PFM_STYLE               0x00000400
#DEFINE PFM_BORDER              0x00000800
#DEFINE PFM_SHADING             0x00001000
#DEFINE PFM_LINESPACING			0x00000100
#DEFINE PFM_NUMBERING           0x00000020
#DEFINE PFM_NUMBERINGSTART      0x00008000
#DEFINE PFM_NUMBERINGSTYLE      0x00002000
#DEFINE PFNS_PAREN              0x000
#DEFINE PFNS_PARENS             0x100
#DEFINE PFNS_PERIOD             0x200
#DEFINE PFNS_PLAIN              0x300
#DEFINE PFNS_NONUMBER           0x400
#DEFINE PFN_BULLET              1
#DEFINE PFN_ARABIC              2
#DEFINE PFN_LCLETTER            3
#DEFINE PFN_UCLETTER            4
#DEFINE PFN_LCROMAN             5
#DEFINE PFN_UCROMAN             6

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
