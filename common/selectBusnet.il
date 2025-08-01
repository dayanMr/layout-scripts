procedure(selectBusnet(opt)
	let((cv box objs metalList)
		cv=geGetEditRep()
		box=enterBox()
		box=list(geWindowToEditPoint(hiGetCurrentWindow() xCoord(box)) geWindowToEditPoint(hiGetCurrentWindow() yCoord(box)))
		lpp = leGetEntryLayer()
		objs=dbGetOverlaps(cv box)
		foreach(obj objs
			if(opt then
				if(obj~>objType == "path" || "polygon" || "pathSeg" || "rect" then
					if(obj~>lpp == lpp then
						geSelectObject(obj)
					);if
				);if
			else
				geDeselectObject(obj)
			  );if
			);foreach
	);let
);proc


hiSetBindKey("Layout" "<Key>KP_9" "selectBusnet(t)")
hiSetBindKey("Layout" "<Key>KP_8" "selectBusnet(nil)")
