procedure(removeSchWires(@optional (cv nil))
	let((floatMarkerPointsList points centerPoint)
	unless(cv
		cv = geGetWindowCellView()
		)
		schCheck(cv)
		floatMarkerPointsList=setof(x cv~>markers x~>tool == "SRC" && rexMatchp("Floating net" x~>msg))~> points
		when(floatMarkerPointsList
			foreach(points floatMarkerPointsList
					centerPoint=centerBox( list(car(points) caddr(points)))
					schSelectPoint(hiGetCurrentWindow() centerPoint t nil 0)
			when(css() && css()~>objType == "marker"
				dbDeleteObject(css())
				schSelectPoint(hiGetCurrentWindow() centerPoint t nil 0)
				)
				geSelObjectsPartiallySelected( hiGetCurrentWindow())
		   when(css()
				dbDeleteObject(css())
				)
			)
		)
	)
)
removeSchWires()
