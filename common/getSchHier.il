procedure(getSchHier( @optional (cv geGetEditCellView()))
		let((libnameList  cellnameList  libname cellname)
		libnameList = list()
		cellnameList = list()
		schHier = outfile("schHier.txt")
		foreach(inst cv~>instanceMasters
			libname = inst ~>libName
			libnameList = cons(libname libnameList)
			cellname = inst~>cellName
			cellnameList = cons(cellname cellnameList)
			unless(!inst || member(cellname cellnameList)
				cvId = dbOpenCellViewByType(libname cellname "schematic" "" r)
				getSchHier(cvId)
				);
			);
		fprintf(schHier "%L/n" libnameList)
		fprintf(schHier "%L/n" cellnameList)
		)
	)



			
