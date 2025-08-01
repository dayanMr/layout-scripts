procedure(ycSaveAllSch(libName)
	prog((lib cells openCell)
		lib = ddGetObj(libName)
		cells = lib~>cells
		foreach(cell cells
			if(openCell = car(errset(dbOpenCellViewByType(libName cell~>name "schematic" "" "a"))) then
				if(dbSave(openCell)
					printf("%s : Save Done\n" cell~>name)
					printf("%s : Save Fail\n" cell~>name)
				)
				schCheck(openCell)
				dbClose(openCell)
			)
		)
		)
