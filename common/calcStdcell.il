procedure(calcStdcell(
			@optional  (objs geGetSelSet())
						(cv geGetEditRep()))
		let((tb cellName)
			if(not(objs) objs = cv~>instances)
			
			tb = makeTable("tb" 0)
			foreach(obj objs
				cellName = obj~>cellName
				tb[cellName] = tb[cellName] +1
				)
			println(tb~>??)
		   )
		)
