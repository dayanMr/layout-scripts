procedure(getTopcell(lib)
		prog((cvlist cv cell tb topcell)
			cvlist = list()
			foreach(cell ddGetObj(lib)~>cells
				foreach(cv cell~>views
					cvlist = cons(dbOpenCellViewByType(lib cell~>name cv~>name "" "r") cvlist)
					)
				)
			tb = makeTable("tb" nil)
			foreach(cellview cvlist
				foreach(inst cellview~>instances
					tb[inst~>master] = t
					)
				)
			topcell = setof(x cvlist !tb[x])~>cellName
			return(topcell)
	    )
	)

