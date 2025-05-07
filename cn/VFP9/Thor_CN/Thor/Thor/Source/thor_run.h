#include Thor_UI.H

#Define  	ccRUN	 			'Run' 

#Define  	ccPOPUPID 			'PopupID=' 

#Define		ccTOOLFOLDER		'Tool Folder='

#Define		ccGETVERSION 		'Version='

#Define		ccTHORENGINE		'Thor Engine='

#Define     ccThorRegister      'Thor Register='

#Define     ccTOOLTEMPLATE      'Thor Template Code=' 

#Define     ccThorClearHotKeys  'Clear HotKeys'

#Define     ccClass  			'Class='

#Define     ccLink  			'Link='

#Define     ccModify  			'Edit='

#Define     ccResult  			'Result='

#Define     ccToolInfo  		'ToolInfo='

#Define     ccDoDefault  		'DoDefault()'

#Define     ccFullPath  		'Full Path='

#Define     ccThorMemberData    '<VFPData><memberdata name="cthordispatcher" display="cThorDispatcher"/><memberdata name="lthordebugmode" display="lThorDebugMode"/></VFPData>'

#IF Version(3) = [86]
	#Define _Thor_Run_AddMenuItems_Forums_loc				[社区]
	#Define _Thor_Run_AddMenuItems_Blogs_loc				[博客]
	#Define _Thor_Run_AddMenuItems_ChangeLogs_loc			[Thor 更新历史]
	#Define _Thor_Run_AddMenuItems_ThorERs_loc				[Thor 错误提交]
	#Define _Thor_Run_AddMenuItems_ThorVideos_loc			[Thor 视频]
#ELSE
	#Define _Thor_Run_AddMenuItems_Forums_loc				[Forums]
	#Define _Thor_Run_AddMenuItems_Blogs_loc				[Blogs]
	#Define _Thor_Run_AddMenuItems_ChangeLogs_loc			[Thor-ChangeLogs]
	#Define _Thor_Run_AddMenuItems_ThorERs_loc				[Thor ERs]
	#Define _Thor_Run_AddMenuItems_ThorVideos_loc			[Thor videos]
#ENDIF