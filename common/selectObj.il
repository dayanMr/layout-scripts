procedure(selectObj(opt)
	let((cv box objs metalList)
		cv=geGetEditRep()
		box=enterBox()
		box=list(geWindowToEditPoint(hiGetCurrentWindow() xCoord(box)) geWindowToEditPoint(hiGetCurrentWindow() yCoord(box)))
		objs=dbGetOverlaps(cv box)
		foreach(obj objs
			if(obj~>objType == "stdVia" then
				if(opt == "V2" then
					println(1)
					if(pcreMatchp("M3M2" obj~>viaHeader~>viaDefName) || pcreMatchp("M3_M2" obj~>viaHeader~>viaDefName) then
						geSelectObject(obj)
					  )
				  )
				if(opt == "V1" then
					if(pcreMatchp("M2M1" obj~>viaHeader~>viaDefName) || pcreMatchp("M2_M1" obj~>viaHeader~>viaDefName) then
						geSelectObject(obj)
					  )
				  )
				if(opt == "CT" then
					if(pcreMatchp("M1PO" obj~>viaHeader~>viaDefName) || pcreMatchp("M1_PO" obj~>viaHeader~>viaDefName) then
						geSelectObject(obj)
					);
				  );
			  );
			);
	   );
	);
procedure(selectVia()
		hiDisplayMenu(
			hiCreateSimpleMenu(	
				'selVia
				"selectObj"
				'("V2"
				  "V1"
				  "ct"

				 )
				'("selectObj(\"V2\")"
				  "selectObj(\"V1\")"
				  "selectObj(\"CT\")"
				)
			)
	)
	)
hiSetBindKey("Layout" "<Key>%" "selectVia()")



