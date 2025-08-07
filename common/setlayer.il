procedure(setvisible()
	let((fg55layers hllayers hl55layers fg33layers tfmapping cv tech tfnamelayer)
		fg55layers=list("M1 drawing" "M2 drawing" "M3 drawing" "ALPA drawing" "V1 drawing" "V2 drawing" "M1TXT drawing" 
				"M2TXT drawing" "M3TXT drawing" "ALPATXT drawing" "text drawing" )
		hllayers = list("instance drawing" "AA drawing" "PO drawing" "CT drawing" "M1 drawing" "M1 text" "M2 drawing" "M2 text" 
				"M3 drawing" "M3 text" "T4M2 text" "T4M2 drawing" "V1 drawing" "V2 drawing" "T4V2 drawing" "ALPAD drawing" "ALPAD text" 
    				"RDL drawing" "RDL text" "RV drawing" "TEXT text")
		hl28layers = list("instance drawing" "AA drawing" "PO drawing" "PO deviceassist" "CT drawing" "M1 drawing" "M1 text" "M2 drawing" "M2 text" "M4 drawing" "M4 text" "M5 drawing" "M5 text"
				"M3 drawing" "M3 text" "T4M2 drawing" "V1 drawing" "V2 drawing"  "TEXT text")
		hl55layers = list("instance drawing" "AA drawing" "PO drawing" "CT drawing" "M1 drawing" "M1 text" "M2 drawing" "M2 text" 
				"M3 drawing" "M3 text" "T4M2 drawing" "V1 drawing" "V2 drawing" "T4V2 drawing" "ALPAD drawing" "ALPAD text" 
    				"RDL drawing" "RDL text" "RV drawing" "TEXT text")
		fg33layers = list("M1 drawing" "M2 drawing" "M3 drawing" "ALPA drawing" "PA drawing" "V1 drawing" "V2 drawing" "M1TXT drawing" 
				"M2TXT drawing" "M3TXT drawing" "ALPATXT drawing" "text drawing" )
		tfmapping = makeTable("tfmapping")
		tfmapping["hlmc"] = hllayers
		tfmapping["tsmc"] = hl28layers
		tfmapping["smic"] = fg55layers
		tfmapping["umc"] = hl55layers
		tfmapping["xmc"] = fg33layers
	cv = geGetEditCellView(getCurrentWindow())
	tech = techGetTechFile(cv)
	tfname = tech~>libName
	layers = tfmapping[tfname] 
	if(layers then 
		pteSetNoneVisible(?panel "Layers")
		foreach(layer layers
			pteSetVisible(layer t "Layers")
	  	);foreach	
	)
	)
)

hiSetBindKey("Layout" "<key>v" "setvisible()")
hiSetBindKey("Layout" "Shift<key>v" "pteSetNoneVisible(?panel \"Layers\")")
hiSetBindKey("Layout" "Ctrl<key>v" "pteSetAllVisible(?panel \"Layers\")")


