procedure(modifyLabelCase()
		let((objs cv lpp point just orient font height parent)
			objs =geGetSelSet()
			foreach(obj objs
				if(obj~>objType == "label" then
					name = obj~>theLabel
					println(name)
					if(obj~>theLabel == lowerCase(name) then
						obj~>theLabel = upperCase(name)
					else
						obj~>theLabel = lowerCase(name) 
					  )
				  )
				if(obj~>objType == "textDisplay" then
					cv = obj->cellView
					lpp = obj->lpp
					point = obj->xy
					name = obj->owner->name
					just = obj->justify
					orient = obj->orient
					font = obj->font
					height = obj->height
					parent = obj->parent
					dbDeleteObject(obj)
					if(name == lowerCase(name) then
						name = upperCase(name)
					else
						name = lowerCase(name)
					  )
					println(name)
					obj = dbCreateLabel(cv lpp point name just orient font height)
					leAttachFig( obj parent )
					)
				)
			)
		)

hiSetBindKey("Layout" "<key>4" "modifyLabelCase()")

procedure(modifyLabelCaseInCV(cv)
	let(()
		foreach(shape cv~>shapes
			if(shape~>objType == "label" then
				if(shape~>theLabel == lowerCase(shape~>theLabel) then
					shape~>theLabel == upperCase(shape~>theLabel) 
					else
					shape~>theLabel == lowerCase(shape~>theLabel)
				  )
			  )
			)
	   )
	)



