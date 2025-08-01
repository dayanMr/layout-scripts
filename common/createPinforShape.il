procedure(rect2pin()
	let((objs netname cv netId poly t_layer lpp coordinate label shapeList)
	objs = geGetSelSet()
	objs = leMergeShapes(objs)
	cv = geGetEditCellView()
	shapeList = list("path" "pathSeg" "rect" "polygon")
	foreach(obj objs
	when(member(obj->objType shapeList)
        netId = obj->net
        when( netId == nil
        	netname = mycreatePinforShapeForm->pinName->value
        	netId = dbFindNetByName(cv netname)  
           if(!netId then netId = dbCreateNet(cv netname))
           ;println(netId) 
        ) 
		if(obj~>objType == "path" then
			poly = leConvertShapeToPolygon(obj)
		)
		if(obj~>objType == "pathSeg" then
			poly = leConvertShapeToPolygon(obj)
			when(obj dbDeleteObject(obj))
		)
		if(obj~>objType == "rect" || obj~>objType == "polygon" then
			poly = obj
		)
        dbCreatePin(netId poly)
	)	
	)
	)
)
procedure(createPinforShapeForm()
		let((pinName)
	if(!boundp('mycreatePinforShapeForm) then
		pinName = hiCreateStringField(
			?name 'pinName
			?prompt "pinName"
			?defValue "A"
		)

		mycreatePinforShapeForm = hiCreateAppForm(
			?name 'mycreatePinforShapeForm
			?formTitle "PIN NAME"
			?callback "rect2pin()"
			?buttonLayout list('OKCancel)
			?fields list(pinName)
		);hiCreateAppForm

	);if
	hiDisplayForm(mycreatePinforShapeForm)
	)
);procedure

hiSetBindKey("Layout" "<Key>F11" "createPinforShapeForm")	

