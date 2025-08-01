procedure(myDeletsclkfile()
		let((Path TechName)
			TechName = techGetTechFile(gcv())~>libName
			
			if(pcreMatchp("hlmc40lp" TechName) then
				Path = strcat("/home/projects/HLMC40EF/layout/" gcv()~>libName "/" gcv()~>cellName "/" "layout/"))
			if(pcreMatchp("hlmc55ef" TechName) then
				Path = strcat("/home/projects/HLMC55EF/lay/" gcv()~>libName "/" gcv()~>cellName "/" "layout/"))
			if(pcreMatchp("FG50_33_Lib" TechName)
				Path = strcat("/home/projects/XMCFG50_33/lay/" gcv()~>libName "/" gcv()~>cellName "/" "layout/"))
			if(pcreMatchp("hlmc28hkcp" TechName)
				Path = strcat("/home/projects/HLMC28HKCP/lay/" gcv()~>libName "/" gcv()~>cellName "/" "layout/"))

			if(isDir(Path) then
				shell(strcat("rm -rf " Path "layout.oa.cdslck* "))
					hiDisplayAppDBox(
    					?name 'TipsForm
    					?dboxBanner "Finish"
    					?buttonLayout 'Close
    					?dboxText "layout delete clk finish"
						)

				else
					hiDisplayAppDBox(
    						?name 'TipsForm
    						?dboxBanner "Error"
    						?buttonLayout 'Close
    						?dboxText "layout clk not exist! ! !"
							)

	
					warn("%L is not exist" Path)
			  )
		   )
)

