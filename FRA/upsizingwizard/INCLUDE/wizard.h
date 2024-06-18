#define C_DEBUG .F. 

#define C_VERS3B_LOC		"Les assistants n�cessitent VFP3.0 minimum" && "The Wizards require Visual FoxPro 3.0b or higher."
#define C_BUILD3B			690       && minimum 3.0b build to check for

#define DEFAULTTITLE_LOC	"Assistant Migration" && "Upsizing Wizard"

#define NODISABLE_LOC		"Cette �tape ne peut pas �tre d�sactiv�e." && "The current step cannot be disabled."

#define NOPROCESS_LOC		"Aucun process d�fini." && "No process defined."

#define MESSAGE_LOC			"Assistant Migration" && "Upsizing Wizard"

#define ERRORTITLE_LOC		"Assistant Migration" && "Upsizing Wizard"

#define ERRORMESSAGE_LOC ;
	"Erreur n�" + alltrim(str(m.nError)) + " dans " + m.cMethod + ;
	" (" + alltrim(str(m.nLine)) + "): " + m.cMessage && "Error #" + alltrim(str(m.nError)) + " in " + m.cMethod + ;
	" (" + alltrim(str(m.nLine)) + "): " + m.cMessage

* The result of the above message will look like this:
*
*		Error #1 in WIZTEMPLATE.INIT (14): File does not exist.

#define MB_ICONEXCLAMATION		48
#define MB_ABORTRETRYIGNORE		2
#define MB_OK					0
#DEFINE MB_YESNO                4       && Yes and No buttons
#DEFINE IDYES           		6       && Yes button pressed

#define THERMCOMPLETE_LOC	"Termin�" && "Complete."

#DEFINE NUM_AFIELDS  18   				&& number of columns in AFIELDS array
#DEFINE DT_MEMO  	"M"
#DEFINE DT_GENERAL  "G"
#DEFINE DT_BLOB		"W"

* The following string is used to form a message when
* _LOGFILE cannot be created or opened. The message will
* look like one of these two examples:
*
*	FCREATE("test1.log") failed. Event logging disabled.
*	FOPEN("test1.log", 2) failed. Event logging disabled.

#define LOGFILEERROR_LOC	" a �chou�. Journal des �venements d�sactiv�." && " failed. Event logging disabled."

#DEFINE C_MAXFIELDS_LOC "Le nombre maximum de champs � trier est " && "The maximum number of fields to sort by is "

#DEFINE C_FREETABLE_LOC	"Tables Libres" && "Free Tables"

#DEFINE BMP_LOCAL		"dblview.bmp"
#DEFINE BMP_REMOTE		"dbrview.bmp"
#DEFINE BMP_TABLE		"dbtable.bmp"

#DEFINE C_READONLY_LOC		"Fichier en lecture seule, non utilisable par l'assistant. Veuillez en s�lectionner un autre." && "File is read-only and not allowed by this wizard/builder. Please select another."
#DEFINE C_READ2_LOC			"Fichier d�j� ouvert en mode exclusif" && "File is used exclusively by another."

#DEFINE E_BADDBCTABLE_LOC	"La table que vous avez choisie n'est pas rattach�e correctement � son DBC. Ceci peut �tre corrig� par la commande VALIDATE DATABASE RECOVER." && "The table selected does not have a valid backlink to its DBC. "+;
							"You can fix this with the VALIDATE DATABASE RECOVER command."

#DEFINE C_TPROMPT_LOC		"Choisissez le fichier � ouvrir:" && "Select file to open:"
#DEFINE C_READ3_LOC			"Ce fichier est utilis� par l'Assistant. Merci d'en choisir un autre." && "File is in use by Wizard. Select another."
#DEFINE C_READ4_LOC			"Ce DBF est rattach� � un DBC. Veuiilez s�lectionner la table depuis le DBC conteneur." && "The DBF is part of a DBC. Select table from DBC container."

#define C_BADALIAS_LOC [Un alias dont le nom est dans cette liste "THIS, THISFORM, THISFORMSET, OWIZARD, OENGINE" est ouvert. Les assistants sont incompatibles avec ces noms d'alias. Fermer ces fichiers et continuer?] && 'An alias in the list "THIS, THISFORM, THISFORMSET, OWIZARD, OENGINE" is ' + ;
	'in use. These aliases conflict with the wizards. Close the file(s) and continue?'

#define ALERTTITLE_LOC		"Assistant Migration" && "Upsizing Wizard"

#define C_WINONLY_LOC     "Les assistants n�cessitentles versions Windows ou Macintosh de  Visual FoxPro " && "The Wizards require Visual FoxPro for Windows or Visual FoxPro for Macintosh."

* This message is displayed if the user enters the name of a file 
* that does not exist in WizEngine.WizLocFile()
#define E_FILENOTFOUND_LOC "Ficheir introuvable." && "File not found."


* These are the countries and regions to enable DBCS:  Japan, Korea, PRC, Taiwan
#DEFINE DBCS_LOC "81 82 86 88"

*- these are the problem characters, Mac-style
#DEFINE C_BADCHARS_MAC CHR(129) + CHR(130) + CHR(131) + CHR(132) + CHR(133) + CHR(134) + CHR(135) + CHR(136) + ;
	CHR(137) + CHR(138) + CHR(139) + CHR(140) + CHR(142) + CHR(143) + CHR(144) + CHR(145) + ;
	CHR(146) + CHR(147) + CHR(148) + CHR(149) + CHR(150) + CHR(151) + CHR(152) + CHR(153) + ;
	CHR(154) + CHR(160) + CHR(161) + CHR(162) + CHR(163) + CHR(164) + CHR(165) + CHR(47) + ;
	CHR(92) + CHR(44) + CHR(45) + CHR(61) + CHR(58) + CHR(59) + CHR(123) + CHR(125) + ;
	CHR(91) + CHR(93) + CHR(33) + CHR(64) + CHR(35) + CHR(36) + CHR(37) + CHR(94) + ;
	CHR(38) + CHR(42) + CHR(46) + CHR(60) + CHR(62) + CHR(40) + CHR(41) + CHR(63) + ;
	CHR(43) + CHR(124) + CHR(128) + CHR(155) + CHR(156) + CHR(157) + CHR(158) + CHR(159) + ;
	CHR(166) + CHR(167) + CHR(168) + CHR(169) + CHR(170) + CHR(171) + CHR(172) + CHR(173) + ;
	CHR(174) + CHR(175) + CHR(176) + CHR(177) + CHR(178) + CHR(179) + CHR(180) + CHR(181) + ;
	CHR(182) + CHR(183) + CHR(184) + CHR(185) + CHR(186) + CHR(187) + CHR(188) + CHR(189) + ;
	CHR(190) + CHR(191) + CHR(192) + CHR(193) + CHR(194) + CHR(195) + CHR(196) + CHR(197) + ;
	CHR(198) + CHR(199) + CHR(200) + CHR(201) + CHR(202) + CHR(203) + CHR(204) + CHR(205) + ;
	CHR(206) + CHR(207) + CHR(208) + CHR(209) + CHR(210) + CHR(211) + CHR(212) + CHR(213) + ;
	CHR(214) + CHR(215) + CHR(216) + CHR(217) + CHR(218) + CHR(219) + CHR(220) + CHR(221) + ;
	CHR(222) + CHR(223) + CHR(224) + CHR(225) + CHR(226) + CHR(227) + CHR(228) + CHR(229) + ;
	CHR(230) + CHR(231) + CHR(232) + CHR(233) + CHR(234) + CHR(235) + CHR(236) + CHR(237) + ;
	CHR(238) + CHR(239) + CHR(240) + CHR(241) + CHR(242) + CHR(243) + CHR(244) + CHR(245) + ;
	CHR(246) + CHR(247) + CHR(248) + CHR(249) + CHR(250) + CHR(251) + CHR(252) + CHR(253) + ;
	CHR(254) + CHR(34) + CHR(39) + CHR(32)


*- for setting FoxTools in Wizards
#DEFINE EN_FOXTOOLS_LOC		"L'assistant n�cessite " && "The Setup Wizard requires "
#DEFINE EN_FXTVER_LOC		"Cet assistant n�cessite la version 3.00 ou sup�rieure de " && "This Wizard requires version 3.00 or higher of "
#DEFINE C_WINLIBRARY		"FT3.DLL"							&& latest version of foxtools.fll
#DEFINE C_MACPPCLIBRARY		"FXTOOL30.CFM"						&& latest version of foxtools (code fragment version)
#DEFINE C_MAC68KLIBRARY		"FXTOOL30.ASLM"						&& latest version of foxtools (shared library manager version)

#DEFINE C_MACPPC_TAG_LOC	"POWER MAC"							&& in the VERS(1) return string

#DEFINE C_NOTAG_LOC 		"Vous ne pouvez pas combiner des rep�res d'index et des champs." && "You cannot combine index tags and fields."
#DEFINE TAGDELIM	 " *"

* Registry strings for looking up scrollbox color
#DEFINE HKEY_CURRENT_USER           -2147483647  && BITSET(0,31)+1
#DEFINE CONTROL_KEY					"Control Panel\Colors"
#DEFINE SCROLLBAR_KEY				"Scrollbar"
#DEFINE SHADOW_KEY					"ButtonShadow"


************************************************

* localisation FR de l'interface utilisateur upswiz.vcx

#DEFINE VCX_CMDBACK_CAPTION_LOC "<Pr�c�dent"
#DEFINE VCX_CMDNEXT_CAPTION_LOC "Suivant>"
#DEFINE VCX_CMDHELP_CAPTION_LOC "Aide"
#DEFINE VCX_CMDCANCEL_CAPTION_LOC "Annuler"
#DEFINE VCX_CMDFINISH_CAPTION_LOC "Terminer"
#DEFINE VCX_CMDOPEN_CAPTION_LOC "\<Ouvrir..."

#DEFINE VCX_STEP2_LOC "Etape 2 - Choix de la Connexion au Serveur Cible"
#DEFINE VCX_STEP3_LOC "Etape 3 - Choix de la Base de donn�es de Destination"
#DEFINE VCX_STEP4_LOC "Etape 4 - Choix des Tables et Correspondance des Types de Donn�es des Champs"
#DEFINE VCX_STEP5_LOC "Etape 5 - Options"
#DEFINE VCX_STEP6_LOC "Etape 6 - Fin"

#DEFINE VCX_GETTINGDATABASES_LOC "Obtention des Bases de donn�es en cours..."
#DEFINE VCX_GETSQLSERVERINFO_LOC "Interrogation du Serveur SQL en cours..."

#define VCX_STEPDONE_NOTABLES_LOC "La base de donn�es s�lectionn�e ne contient aucune table � migrer."

**
* page 1
#DEFINE VCX_PGE1WIZLABEL1_CAPTION_LOC "Base de \<Donn�es � migrer:"

* page 2
#DEFINE VCX_PGE2_OPTUSEDATBASECONN_LOC "Utiliser une connex\<ion d'un database"  
#DEFINE VCX_PGE2_OPTODBCTYPE_OPT1_LOC "Utiliser un DS\<N" 
#DEFINE VCX_PGE2_OPTODBCTYPE_OPT2_LOC "\<G�n�rer une cha�ne de connection SQL" 
#DEFINE VCX_PGE2_OPTODBCTYPE_OPT3_LOC "Utilise\<r une cha�ne de connexion" 
#DEFINE VCX_PGE2_LBLCONN_LOC "\<Connexion"
#DEFINE VCX_PGE2_LBLDSNUID_LOC "Utilisat\<eur" 
#DEFINE VCX_PGE2_LBLDSNPW_LOC "M. de \<Passe"
#DEFINE VCX_PGE2_LBLSERVERS_LOC "\<Serveur"
#DEFINE VCX_PGE2_LBLSERVERUID_LOC "Utilisat\<eur"
#DEFINE VCX_PGE2_LBLSERVERPWD_LOC "Mot de P\<asse"
#DEFINE VCX_PGE2_CHKUSETC_LOC "U\<tiliser l'authentification Windows"

* page 3
#DEFINE VCX_PGE3_OPGNEWEXIST_OPT1 "E\<xistante"
#DEFINE VCX_PGE3_OPGNEWEXIST_OPT2 "Nou\<velle"

* page 4
#DEFINE VCX_PGE4_LBL1_LOC "Voulez vous modifier la correspondance par d�faut entre les types de donn�es locales et ceux sur le serveur?"
#DEFINE VCX_PGE4_CMDSELECTALL_LOC   "\<Toutes les Tables"
#DEFINE VCX_PGE4_CMDDESELECTALL_LOC "\<Aucune Table"
#DEFINE VCX_PGE4_CHKVIEWS_LOC "Vues"
#DEFINE VCX_PGE4_CHKTSTAMPADD_CAPTION_LOC "Tous"
#DEFINE VCX_PGE4_CHKTSTAMPADD_TTIP_LOC "Ajoute une colonne TimeStamp � toutes les tables"
#DEFINE VCX_PGE4_CHKIDENTADD_CAPTION_LOC "Tous"
#DEFINE VCX_PGE4_CHKIDENTADD_TTIP_LOC "Ajoute une colonne Identity � toutes les tables"
#DEFINE VCX_PGE4_CMDRESET_LOC "\<D�faut"
#DEFINE VCX_PGE4_GRCFLDNAME_LOC "Champ"
#DEFINE VCX_PGE4_GRCTYPE_LOC "Type FoxPro"
#DEFINE VCX_PGE4_GRCRMTTYPE_LOC "Type SQL"
#DEFINE VCX_PGE4_GRCRMTLENGTH_LOC "Largeur"
#DEFINE VCX_PGE4_GRCRMTPREC_LOC "Pr�cision"

* page 5
#DEFINE VCX_PGE5_CMDADVANCED_LOC "\<Avanc�..."
#DEFINE VCX_PGE5_WIZLBL1_LOC " Attributs de tables � migrer: " 
#DEFINE VCX_PGE5_WIZLBL2_LOC " Modifications � apporter localement: "
#DEFINE VCX_PGE5_WIZLBL3_LOC "Etendue des Null"
#DEFINE VCX_PGE5_BASELBL1_LOC " Option de transfert des donn�es: "
#DEFINE VCX_PGE5_LBLREPORT_LOC " Options du Rapport: "
#DEFINE VCX_PGE5_LBLREPDIR_LOC "dans D\<ossier"
#DEFINE VCX_PGE5_CHKINDEXES_LOC "\<Index"
#DEFINE VCX_PGE5_CHKDEFAULTS_LOC "Val. \<D�faut"
#DEFINE VCX_PGE5_CHKRELATIONS_LOC "\<Relations"
#DEFINE VCX_PGE5_CHKVALIDATION_LOC "R�gles de \<Validation"
#DEFINE VCX_PGE5_CHKSTRUCTUREONLY_LOC "\<Structure seule, sans donn�es"
#DEFINE VCX_PGE5_CHKEXPORTDRI_LOC "Utiliser les R\<I d�claratives"
#DEFINE VCX_PGE5_CHKREMOTIZEVIEWS_LOC "Rediriger les vues locales en vues dis\<tantes"
#DEFINE VCX_PGE5_CHKTABLETOVIEW_LOC "Cr�er des v\<ues distantes sur les tables"
#DEFINE VCX_PGE5_CHKSAVEPWD_LOC "Enregistrer le \<mot de passe avec les vues"
#DEFINE VCX_PGE5_CHKBULKINSERT_LOC "Utiliser le \<Bulk Insert pour transf�rer les donn�es"
#DEFINE VCX_PGE5_CHKBLANKDATES_LOC "Migrer les dates vides en \<NULL"
#DEFINE VCX_PGE5_CHKREPORT_LOC "Cr�er un ra\<pport de migration"

* page 6
#DEFINE VCX_PGE6_LBL2_LOC "Tout est pr�t pour la migration. Choisissez une option et cliquez sur Terminer" 
#DEFINE VCX_PGE6_UPSIZE_LOC "\<Migrer"
#DEFINE VCX_PGE6_SAVE_LOC "Enregistrer le script \<SQL"
#DEFINE VCX_PGE6_UPSIZEANDSAVE_LOC "Migrer \<et enregistrer le script SQL"


* Options Avanc�es
#DEFINE VCX_ADVOPT_LOC "Options d'Exportation Avanc�es"
#DEFINE VCX_ADVOPT_CHKCLUSTERED_LOC "Cr�er un Index \<Clustered sur la Cl� Primaire"
#DEFINE VCX_ADVOPT_CHKDROPTABLES_LOC "Supprimer les tables \<locales"
#DEFINE VCX_ADVOPT_LBLDEFAULTREMOTEVIEWNAME_LOC "Nom des \<vues distantes par d�faut"
#DEFINE VCX_ADVOPT_OPT1_LOC "\<Pr�fixe"
#DEFINE VCX_ADVOPT_OPT2_LOC "\<Suffixe"
#DEFINE VCX_ADVOPT_OPT3_LOC "\<Aucun (m�me nom que la table locale)"

* exportoptions (page 5)
#DEFINE VCX_CBONULL_GENERAL_LOC [Tous les champs "General"]
#DEFINE VCX_CBONULL_GENERAL_AND_MEMO_LOC [Tous les champs "General" et "Memo"]
#DEFINE VCX_CBONULL_ALL_LOC [Tous les champs]
#DEFINE VCX_CBONULL_DEFAULT_LOC [Valeurs par d�faut]

* General fields override,General and memo fields override,All fields override,Default settings
#define VCX_CBONULL_ROWSOURCE_LOC ;
VCX_CBONULL_GENERAL_LOC + ',' +;
VCX_CBONULL_GENERAL_AND_MEMO_LOC + ',' +;
VCX_CBONULL_ALL_LOC + ',' +;
VCX_CBONULL_DEFAULT_LOC

