procedure(createAllIOShape(cv)
	let((ioType)
		foreach(shape cv~>shapes			
			if(shape~>pin then
				pinX1 = xCoord(nth(0 shape~>bBox))
				pinX2 = xCoord(nth(1 shape~>bBox))
				pinY1 = yCoord(nth(0 shape~>bBox))
				pinY2 = yCoord(nth(1 shape~>bBox))
				pinMP =  (pinX1+pinX2)/2:(pinY1+pinY2)/2
				ioType = shape~>pin~>term~>direction	
				foreach(line cv~>shapes
					if(line~>objType=="line" then
						;printf("%A %A\n" pinMP line~>bBox)
						pinMPX = xCoord(pinMP)
						pinMPY = yCoord(pinMP)
						lineX1 = xCoord(nth(0 line~>bBox))
						lineX2 = xCoord(nth(1 line~>bBox))
						lineY1 = yCoord(nth(0 line~>bBox))
						lineY2 = yCoord(nth(1 line~>bBox))
						if(	pointInBox(lineX1 lineY1 pinX1 pinX2 pinY1 pinY2)||
							pointInBox(lineX2 lineY2 pinX1 pinX2 pinY1 pinY2) then
							;printf("%A %A \n" pin shape)
							lineMP = (lineX1+lineX2)/2:(lineY1+lineY2)/2
							direction = cond(
								(and(pinMPX==xCoord(lineMP) pinMPY>yCoord(lineMP)) "top")
								(and(pinMPX==xCoord(lineMP) pinMPY<yCoord(lineMP)) "bottom")
								(and(pinMPY==yCoord(lineMP) pinMPX<xCoord(lineMP)) "left")
								(and(pinMPY==yCoord(lineMP) pinMPX>xCoord(lineMP)) "right")
							)
							printf("%A %A %A %A\n" shape~>pin~>term~>name lineMP direction ioType)			
							createIOShape(cv lineMP direction ioType)
						)
					)
				)		
			)			
		)
	)
)

procedure(pointInBox(pointX pointY boxX1 boxX2 boxY1 boxY2)
	let(()
		and(or(and(pointX>=boxX1 pointX<=boxX2) and(pointX<=boxX1 pointX>=boxX2))
			or(and(pointY>=boxY1 pointY<=boxY2) and(pointY<=boxY1 pointY>=boxY2)))
	)
)

procedure(createIOShape(cv position direction ioType)
	let((midPoint)
		x = car(position)
		y = cadr(position)
		l1 = 0.025
		l2 = 0.05
		points = cond(
			(and(direction=="top" ioType=="input") list(x:y-l2 x+l1:y x-l1:y))
			(and(direction=="bottom" ioType=="input") list(x:y+l2 x+l1:y x-l1:y))
			(and(direction=="left" ioType=="input") list(x+l2:y x:y+l1 x:y-l1))
			(and(direction=="right" ioType=="input") list(x-l2:y x:y+l1 x:y-l1))
			(and(direction=="top" ioType=="output") list(x:y+l2 x+l1:y x-l1:y))
			(and(direction=="bottom" ioType=="output") list(x:y-l2 x+l1:y x-l1:y))
			(and(direction=="left" ioType=="output") list(x-l2:y x:y-l1 x:y+l1))
			(and(direction=="right" ioType=="output") list(x+l2:y x:y-l1 x:y+l1))
			(and(or(direction=="top" direction=="bottom") ioType=="inputOutput") list(x+l1:y x:y+l2 x-l1:y x:y-l2))
			(and(or(direction=="left" direction=="right") ioType=="inputOutput") list(x+l2:y x:y+l1 x-l2:y x:y-l1))
		)	
		println(points)
		obj = dbCreatePolygon(cv list("instance" "label") points)
		obj~>deleteMark = "TRUE"
	)
)

procedure(deleteAllIOShape(cv)
	let(()
		cv = geGetEditRep()
		foreach(shape cv~>shapes
			if(shape~>deleteMark
				dbDeleteObject(shape)
			)
		)
	)
)

procedure(createIOShapeForLib(targetLib)
	let((targetCellList targetCV)
		targetCellList=ddGetObj(targetLib)~>cells~>name
		foreach(targetCell targetCellList
			println(targetCell)
			targetCV = dbOpenCellViewByType(targetLib targetCell "symbol" "schematicSymbol" "a")
			deleteAllIOShape(targetCV)
			createAllIOShape(targetCV)
			dbSave(targetCV)     
			dbClose(targetCV)
		)
	)
)



hiSetBindKey("Symbol" "<Key>6" "createAllIOShape(geGetEditRep())")
hiSetBindKey("Symbol" "shift<Key>6" "deleteAllIOShape(geGetEditRep())")
