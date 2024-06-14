*-***********************************************************************************************
*-*
*-* Copyright ©2015 Gregory A. Green
*-*
*-***********************************************************************************************
*-*
*-*  Procedure for sending an error email
*-*
#IFNDEF gkkmembership
#INCLUDE ..\..\common\includes\gkkdefines.h
#ENDIF
FUNCTION SendErrorEmail
LPARAMETERS tcEmailBody
LOCAL loWinSockEmail, lnNdx, lcId, lcFilePath, llOpened
llOpened = False
loWinSockEmail = NEWOBJECT("WinSockEmail", "GKLWinSockEmail.vcx")
IF VARTYPE(loWinSockEmail) = "O"
	loWinSockEmail.SMTPHost     = GetStringLocal("Setup", "SMTPServer")
	loWinSockEmail.From         = GetStringLocal("Setup", "UserEmail")
	loWinSockEmail.FromName     = GetStringLocal("Setup", "UserName")
	loWinSockEmail.AuthLogin    = GetStringLocal("Setup", "UserId")
	loWinSockEmail.AuthPassword = GetStringLocal("Setup", "UserPW")
	loWinSockEmail.ReplyTo      = GetStringLocal("Setup", "UserEmail")
	loWinSockEmail.ReplyToName  = GetStringLocal("Setup", "UserName")
	loWinSockEmail.To           = GetSetting("ErrorNotificationEmailAddr")
	loWinSockEmail.ToName       = "GKKLibrarian Support"
	loWinSockEmail.Subject      = "GKKLibrarian Error Report"
	loWinSockEmail.MessageHTML  = ""
	loWinSockEmail.Message      = tcEmailBody
	IF loWinSockEmail.Send()
		DisplayMsg("Error Report Email Sent")
	ELSE
		DisplayMsg(loWinSockEmail.Erreur)
	ENDIF
ENDIF
ENDFUNC