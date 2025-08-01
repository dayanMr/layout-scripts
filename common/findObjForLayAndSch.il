procedure(findObjForLayAndSch()
	let(()
		;if(!boundp(`laySchLibMappingList) || laySchLibMappingList==nil || length(laySchLibMappingList)<=0 then
		;	error("please set library mapping")
		;)
		if(geGetEditRep() && geGetEditRep()->cellViewType=="maskLayout" then
			findLayObjInSch(geGetEditRep())
			selNetForLay()
		)
		if(geGetEditRep() && geGetEditRep()->cellViewType=="schematic" then
			findSchObjInLay(geGetEditRep())
		)
	)
)

;---------------------------------------------------------------------------------------------------------------------
procedure(findLayObjInSch(layCellView)
	let((schWindow schCellView objs)
		objs = geGetSelSet()
		
		schWindow = openLaySchCellView()
		schCellView = schWindow->cellView
		geDeselectAll(schWindow)
		foreach(obj objs
			selLayObjInSch(layCellView schCellView obj)	
		)
	)
)


procedure(selLayObjInSch(layCellView schCellView obj)
	let((instName netName)
		if(obj->objType=="mosaic" || obj->objType=="inst" then 
			instName=obj->name
			instName = car(parseString(instName "."))
			instName = car(parseString(instName "|"))
		)
		if(obj->objType=="path" || obj->objType=="pathSeg"
		|| obj->objType=="rect" || obj->objType=="polygon"
		then 
			if(netName && length(parseString(netName "|"))>1 then 
				instName = car(parseString(netName "|"))
			else 
				netName = obj->net->name
			)
		)
		if(netName then
			geSelectFigs(findWireInSch(schCellView netName)) 
		)
		if(instName then
			geSelectFigs(findInstInSch(schCellView instName))
		)
	)
)

procedure(findWireInSch(schCellView netName)
	let((net figs)
		net = car(setof(net schCellView->nets net->name==netName)) 
		figs = net->figs
	)
)

procedure(findInstInSch(schCellView instName)
	let((insts)
		insts = setof(inst schCellView->instances inst->name == instName) 
	)
)

;-----------------------------------------------------------------------------
procedure(findSchObjInLay(schCellView)
	let((layWindow layCellView objs)
		objs = geGetSelSet()
		
		layWindow = openLaySchCellView()
		layCellView = layWindow->cellView
		geDeselectAll(layWindow)
		foreach(obj objs
			selSchObjInLay(layCellView schCellView obj)	
		)
	)
)

procedure(selSchObjInLay(layCellView schCellView obj)
	let((instName netName)
		if(obj->objType=="inst" then 
			instName=obj->name
		)
		if(obj->net then 
			netName = obj->net->name
		)
		if(netName then
			geSelectFigs(findPathInLay(layCellView netName)) 
		)
		if(instName then
			geSelectFigs(findInstInLay(layCellView instName))
		)
	)
)

procedure(findPathInLay(layCellView netName)
	let((shapes vias)
		shapes = setof(shape layCellView->shapes shape->net->name==netName)
		vias = setof(via layCellView->vias via->net->name==netName)
		append(shapes vias)
	)
)

procedure(findInstInLay(layCellView instName)
	let((objs)
		objs = append(layCellView->instances layCellView->mosaics) 
		objs = setof(obj objs 
				car(parseString(obj->name "|"))==instName ||
				car(parseString(obj->name "."))==instName )
		println(objs)
		objs
	)
)

procedure(selNetForLay()
	let((cv objs netNames)
		cv = geGetEditRep()
		objs = geGetSelSet()
		netNames = mapcar('(lambda (obj) (obj->net->name)) objs)
		foreach(netName netNames
			if(netName 
				geSelectFigs(findPathInLay(cv netName))
			)
		)
	)
)

hiSetBindKey("Schematics" "<Key>F12" "findObjForLayAndSch()")
hiSetBindKey("Layout" "<Key>F12" "findObjForLayAndSch()")
;hiSetBindKey("Layout" "<Key>F11" "selNetForLay()")
