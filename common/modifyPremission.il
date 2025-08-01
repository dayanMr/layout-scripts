procedure(modifyPremission(opt)
		let((Path techname)
			techname = techGetTechFile(gcv())~>libName
			if(pcreMatchp("hlmc40lp" techname) then
				Path = strcat("/home/projects/HLMC40EF/layout/" gcv()~>libName "/" gcv()~>cellName)
			  )
			if(pcreMatchp("hlmc55ef" techname) then
				Path = strcat("/home/projects/HLMC55EF/lay/" gcv()~>libName "/" gcv()~>cellName)
			  )
			if(pcreMatchp("FG50_33_Lib" techname)
				Path = strcat("/home/projects/XMCFG50_33/lay/" gcv()~>libName "/" gcv()~>cellName)
			  )
			if(pcreMatchp("hlmc28hkcp" techname)
				Path = strcat("/home/projects/HLMC28HKCP/lay/" gcv()~>libName "/" gcv()~>cellName)
			  )
			println(Path)
			if(isDir(Path) then
				shell(strcat("chmod -R " opt " " Path))
					hiDisplayAppDBox(
    					?name 'TipsForm
    					?dboxBanner "Finish"
    					?buttonLayout 'Close
    					?dboxText "layout premission finish"
						)
				else
					hiDisplayAppDBox(
    					?name 'TipsForm
    					?dboxBanner "Error"
    					?buttonLayout 'Close
    					?dboxText "layout path not exist !!!"
						)
				warn("%L is not exist" Path)
			  )
		   )
		)
;procedure(finishWindow()
;		hiDisplayMenu(
;			hiCreateSimpleMenu(
;				'menu
;				""
;				list("finish\n"
;					 "finish\n"
;					 "finish\n"
;					)
;				list("")
;				)
;			)
;		)
;procedure(ERRORWindow()
;		hiDisplayMenu(
;			hiCreateSimpleMenu(
;				'menu
;				""
;				list("ERROR\n"
;					 "ERROR\n"
;					 "ERROR\n"
;					)
;				list("")
;				)
;			)
;		)
;

