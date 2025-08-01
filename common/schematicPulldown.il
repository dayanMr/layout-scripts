;load "/home/users/dyfeng/project/XMC/AEF570A/il/schSelCreatepin.il"
;load "/home/users/dyfeng/project/XMC/AEF570A/il/countlabel.il"


procedure( schematicPulldownMenu()
  if( boundp( 'schematicPulldownMenu )
     then schematicPulldownMenu
  else
    hiCreatePulldownMenu(
       'schematicPulldownMenu
       "Menu"  
       list(
          hiCreateMenuItem( 
             ?name 'createPinforlabel
             ?itemText "createPinforlabel"
             ?callback  "schSelCreatepin()")
		  hiCreateMenuItem( 
             ?name 'countLabelForSch
             ?itemText "countLabelForSch"
             ?callback  "countLabelForSch()")
	      hiCreateMenuItem( 
             ?name 'getNetConnectInfo
             ?itemText "getNetConnectInfo"
             ?callback  "getNetConnectInfo()")
		 )

		  )

	   )
	)
procedure( myddUserPostInstallTrigger(args)
   hiInsertBannerMenu(
        args->window
        schematicPulldownMenu()
        length( hiGetBannerMenus( args->window))
   )
   ) ; procedure
deRegUserTriggers("schematic" nil nil 'myddUserPostInstallTrigger)

