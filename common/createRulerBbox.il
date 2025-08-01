procedure(createRulerBbox()
	let( (cv objs xlist ylist box path pathSegList)
		cv = geGetEditCellView()
		objs = geGetSelSet(cv)
		pathSegList = list()
		foreach(obj objs
		case( obj~>objType
			(("rect" "inst")
				box = obj~>bBox
				xlist = list(lowerLeft(box) list(xCoord(upperRight(box)) yCoord(lowerLeft(box))))
				ylist = list(lowerLeft(box) list(xCoord(lowerLeft(box))  yCoord(upperRight(box))))
				leCreateRuler( cv xlist )
				leCreateRuler( cv ylist )
			)
			(( "path")
				leCreateRuler( cv obj~>points )
			)
			(( "polygon")
			 	;leMergeShapes(obj)
				;leConvertShapeToPathSeg(obj)
				path = leConvertPolygonToPath(obj)
				leCreateRuler( cv path~>points )
			)
			(( "pathSeg")
			    xlist = list(obj~>beginPt obj~>endPt)
				leCreateRuler( cv xlist )
			)
			   
			(t
				hiDisplayModelessDBox( 
					'form " Error Window " "No Select object (rect/inst/path)" "" "" )
			)
			)
		)
	)
)

