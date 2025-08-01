procedure(schSelCreatepin()
	let((objs cv label inputCVId x y)
		objs = geGetSelSet()
		cv = geGetEditCellView()
		inputCVId = dbOpenCellViewByType( "basic" "ipin" "symbol" "" 'r )
		i = 0
		foreach(obj objs
			if(obj~>objType == "label" then
				label = obj~>theLabel
				coor = obj~>xy
				x = car(coor) + 5.0
				y = cadr(coor)
				pins = schCreatePin(cv inputCVId label	"input" nil x:y "R0")
				print(pins)
				)
			)
		dbClose(inputCVId)
	   )
	)
hiSetBindKey("Schematics" "<Key>0" "schSelCreatepin()")
