procedure( layerSelEntry()
   	prog((win cv layer)
		win = hiGetCurrentWindow()		
		cv = geGetEditCellView(win)		
		layer = leGetEntryLayer()	
		foreach(shape cv~>shapes
		if(shape~>lpp == layer then
			geSelectObject(shape)	
		)
	)
   )
)
hiSetBindKey("Layout" "<Key>KP_9" "layerSelEntry()")
