procedure(CreateLabelXL_()
	let((cv objs origin name group label)
			objs = geGetSelSet()
			cv = geGetEditCellView()
			when(not(objs) objs = cv~>instances)
			foreach(obj objs
				origin = centerBox(obj~>bBox)
				name = obj~>name
				label = dbCreateLabel(cv list("text" "drawing") origin name "centerCenter" "R90" "roman" 0.5)
				group =obj~>figGroup
			if(group &&label then
				dbAddFigToFigGroup(group label))
				leAttachFig(label obj)

			);foreach
	);let
);proc

;;procedure(CreateLabelXL()
;;hiDisplayMenu(hiCreateSimpleMenu(
;;  			 'menu
;;  			 "Do you want to change?"
;;  			 '( "Yes" "No" )
;;   			 '("CreateLabelXL_()" "nil"))
;;)
;;)
;;hiSetBindKey("Layout" "<Key>F1" "CreateLabelXL()")
