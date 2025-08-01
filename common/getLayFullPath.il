procedure(getLayFullPath()
	let((tb objs cv)
    	procedure(search(objs)
			let(()
				foreach(obj objs
    				if(tbNotExists(tb obj) || !tb[obj] then
                        tb[obj] = t
						search(searchViaToShape(cv obj))
						search(searchViaToVia(cv obj))
						search(searchShapeToVia(cv obj))
						search(searchShapeToShape(cv obj))                        
					)
				)
			)
		)
		tb = makeTable("tb")
		objs = geGetSelSet()
		cv = geGetEditRep()
		search(objs)
		geSelectFigs(tb->?)
	)
)

procedure(tbNotExists(tb obj)
    let(()
	    !(exists(key tb->? obj==key) != nil)
    )
)

procedure(searchViaToVia(cv obj)
	let((viasInBox res)
        res = list() 
        if(isStdVia(obj) then 
            viasInBox = leSearchHierarchy(cv obj->bBox 0 "via" nil)              
            foreach(via viasInBox       
                if(via!=obj && isViaConnected(obj via) then
                    res = append1(res via) 
                )                
            )                        
        )        
        res
	)
)

procedure(isViaConnected(via1 via2)
    prog((v1Box v2Box)
        foreach(via1L list(dbGetViaLayer(via1 "layer1") dbGetViaLayer(via1 "layer2"))
            foreach(via2L list(dbGetViaLayer(via2 "layer1") dbGetViaLayer(via2 "layer2"))
                if(via1L == via2L then
                    v1Box = getViaMetalBox(cv via1 list(via1L "drawing"))                      
                    v2Box = getViaMetalBox(cv via2 list(via2L "drawing"))
                    if(isBoxTouch(v1Box v2Box) then 
                        return(t)
                    )
                )                  
            )        
        )
        return(nil)
    )
)

procedure(boxToPTArray(box)
    let((res p1 p2)
        if(isBox(box) then
            p1 = car(box)
            p2 = cadr(box)
            res = list(list(p1 list(xCoord(p2) yCoord(p1)) p2 list(xCoord(p1) yCoord(p2))))
        )
    )
)

procedure(isBox(l)
    let(()
        nil!=l && listp(l) && length(l)==2 
        && listp(car(l)) && listp(cadr(l)) 
        && length(car(l))==2 && length(cadr(l))==2
    )
)

procedure(isBoxTouch(box1 box2)
    let((b1l b1r b2l b2r b1b b1t b2b b2t)
        b1l = min(leftEdge(box1) rightEdge(box1))
        b1r = max(leftEdge(box1) rightEdge(box1))
        b2l = min(leftEdge(box2) rightEdge(box2))
        b2r = max(leftEdge(box2) rightEdge(box2))
        b1b = min(topEdge(box1) bottomEdge(box1))
        b1t = max(topEdge(box1) bottomEdge(box1))
        b2b = min(topEdge(box1) bottomEdge(box1))
        b2t = max(topEdge(box1) bottomEdge(box1))
        (isBox(box1) && isBox(box2)) &&
        (b1l<=b2r && b1l>=b2l && b1b<=b2t && b1b>=b2b) ||
        (b2l<=b1r && b2l>=b1l && b2b<=b1t && b2b>=b1b) 
    )
)

procedure(getPathPolygonBoxList(cv obj)
	let((res)
		abeInit(geGetEditRep())
		abeRes = abeLayerFromShapes(list(obj))
		tileIter = abeTileIterator( abeRes )
		while( 
		    tile = tileIter->next
		    res = append1(res tile->bbox)
		)
		abeDone()
        res
	)
)

procedure(searchShapeToShape(cv obj)
	let((boxes shapes)
        boxes = getShapeBox(cv obj)
        shapes = list()
		foreach(box boxes 
			shapes = append(shapes searchShapeInBox(cv box obj->lpp))
		)
		if(boundp('shapes) && listp(shapes) then
			setof(shape shapes isShapeConnected(cv obj shape))
		)
	)
)

procedure(searchShapeInBox(cv box lpp)
	let((shapes)
		shapes = list()
		shapes = append(shapes leSearchHierarchy(cv box 0 "pathSeg" list(list("layer" "==" lpp))))
        shapes = append(shapes leSearchHierarchy(cv box 0 "path" list(list("layer" "==" lpp))))
		shapes = append(shapes leSearchHierarchy(cv box 0 "rectangle" list(list("layer" "==" lpp))))
    	shapes = append(shapes leSearchHierarchy(cv box 0 "polygon" list(list("layer" "==" lpp))))
	    if(boundp('shapes) && listp(shapes) then
			shapes
		)
	)
)

procedure(isStdVia(obj)
	let(()
		obj!=nil && obj->objType=="stdVia"
	)
)

procedure(isShape(obj)
	let(()
		obj!=nil &&
		obj->objType=="rect" ||
		obj->objType=="path" ||
		obj->objType=="pathSeg" ||
		obj->objType=="polygon" 
	)
)

procedure(isShapeConnected(cv obj1 obj2)
	let((abe1 abe2 abe3 res)
        if(isShape(obj1) && isShape(obj2) then
    		abeInit(cv)
    		abe1 = abeLayerFromShapes(list(obj1))
    		abe2 = abeLayerFromShapes(list(obj2))
    		abe3 = abeNewLayer()
    		abeLayerTouch(abe1 abe2 abe3)
            res = abe3->numTiles > 0
    		abeDone()
            res
        )
	)
)

procedure(searchViaToShape(cv obj)
	let((shapes lpp1 lpp2)
		if(obj->objType=="stdVia" then
			shapes = list()
			lpp1 = list(dbGetViaLayer(obj "layer1") "drawing")
			lpp2 = list(dbGetViaLayer(obj "layer2") "drawing")
          		box1 = getViaMetalBox(cv obj lpp1)
			box2 = getViaMetalBox(cv obj lpp2)
			shapes = append(shapes searchShapeInBox(cv box1 lpp1))
			shapes = append(shapes searchShapeInBox(cv box2 lpp2))
	        )
		if(boundp('shapes) && listp(shapes) then
			shapes
		)
	)
)

procedure(isShapeConnectedToVia(cv shape via)
	let((abe1 abe2 abe3 res lpp viaShapeBox)
	    if(isShape(shape) && isStdVia(via) then
			lpp = nil
			if(dbGetViaLayer(via "layer1") == shape->layerName then
				lpp = list(dbGetViaLayer(via "layer1") "drawing")
			)
			if(dbGetViaLayer(via "layer2") == shape->layerName then
				lpp = list(dbGetViaLayer(via "layer2") "drawing")
			)
			if(lpp then
				viaShapeBox = getViaMetalBox(cv via lpp)
				abeInit(cv)
				abe1 = abeLayerFromShapes(list(shape))
				abe2 = abeNewLayer()
				abeLayerOrPtArray(viaShapeBox abe2)
				abe3 = abeNewLayer()
				abeLayerTouch(abe1 abe2 abe3)
				res = abe3->numTiles > 0
				abeDone()
				res
			)
		)
	)
)

procedure(searchShapeToVia(cv obj)
	let((boxes vias)
        boxes = getShapeBox(cv obj)
        vias = list()
        if(listp(boxes) then
    		foreach(box boxes 
    			vias = append(vias findViaInArea(cv box obj))
    		)   
        )
        ;check if metal of via connected to obj
		if(boundp('vias) && listp(vias) then
            setof(via vias isShapeConnectedToVia(cv obj via))
        	) 
	)
)


procedure(findViaInArea(cv box obj)
	let((viasInArea res )
		res = list()
		;vias
		viasInArea = leSearchHierarchy(cv box 0 "via" nil)
		if(listp(viasInArea) then
			foreach(via viasInArea
				if(dbGetViaLayer(via "layer1") == obj->layerName || 
                    dbGetViaLayer(via "layer2") == obj->layerName then
		 			res = append1(res via) 
				)
			)
		)
		;inst or array
		res
	)
)

procedure(getViaMetalBox(cv via lpp)
	let((shapes box)
		shapes = dbGetOverlaps(cv via->bBox lpp 1)
		foreach(shape shapes
			if(listp(shape) && car(shape) == via then 
				box = car(last(shape))->bBox
				box = dbTransformPointList(box list(via->origin via->orient 1))
			)
		)
		box
	)
)

procedure(getShapeBox(cv obj)
    let((res)
        if(obj->objType=="rect" || obj->objType=="pathSeg" then
            res = list(obj->bBox)
        )
		if(obj->objType=="polygon" || obj->objType=="path" then
			res = getPathPolygonBoxList(cv obj)
		)   
        res    
    )
)
hiSetBindKey("Layout" "<key>T" "getLayFullPath()")


