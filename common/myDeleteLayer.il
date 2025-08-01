procedure(myDeleteLayer()
	prog((cv box objs lpp tmp)
		cv=geGetEditRep()
		box=enterBox()
		box=list(geWindowToEditPoint(hiGetCurrentWindow() xCoord(box)) geWindowToEditPoint(hiGetCurrentWindow() yCoord(box)))
		lpp = deleteLayerForm-> LayLayer -> value
		tmp = deleteLayerForm-> LayLayerRadioField -> value 
		print(lpp)
		print(tmp)

		objs=dbGetOverlaps(cv box)
		foreach(obj objs
			if(strcat(car(obj~>lpp) " " cadr(obj~>lpp)) == lpp then
				print("t1")
				case(tmp 
					("delete"  dbDeleteObject(obj))
					("select"  geSelectObject(obj))
		  			)
			)
		)
	)
	)

hiSetBindKey("Layout" "<Key>KP_0" "myDeleteLayerForm()")

procedure(myDeleteLayerForm()
	let((fieldLabel LayLayerRadioField LayLayerField)
		if(!boundp('deleteLayerForm) then
			fieldLabel=hiCreateLabel(
				?name 'FieldLabel
				?labelText "Layer"
				)
			LayLayerRadioField=hiCreateRadioField(
				?name  'LayLayerRadioField
				?choices '("delete" "select") 
				?prompt "LayLayerRadioField" 
				?value "delete" 
				?defValue "delete" 
				)
			LayLayerField=leCreateLayerField(
				 'LayLayer
				 ?prependChoices "Use Current Entry Layer"
			 	 ?maxVisibleItems 20
			 	 ?techFile techGetTechFile(geGetEditCellView()) 
			 	 ?syncedPaletteWindow hiGetCurrentWindow() 
	 		)
			deleteLayerForm=hiCreateAppForm(
				 ?name 'deleteLayerForm
				 ?formTitle "deleteLayerForm"
				 ?callback "myDeleteLayer()"
				 ?buttonLayout list('OKCancel)
				 ?fields list(
							list(fieldLabel 10:10 500:10 87)
							list(LayLayerField 50:50 500:10 87)
							list(LayLayerRadioField 100:100 800:10 87)
							)
			)
		)
	hiDisplayForm(deleteLayerForm)

	)
)

