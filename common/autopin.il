procedure(customCmd()
		let(()
			hiCreateStringField( 
						?name (quote cmdstring) 
						?prompt "cmd" 
						?callback nil 
						?editable t
						 list(cmdStr)) 
procedure(ExCustomCmd str) 
	case( str ("aip" abAddPinToFloatingWire(?direction "input")) ("aop" (abAddPinToFloatingWire ?direction "output")) ("aiop" (abAddPinToFloatingWire ?direction "inputOutput")))) 
			hiCreateAppForm(
				?name (quote customCmdIn) 
				?formTitle "custom command" 
				?fields 
	 			 list(hiCreateStringField(
					 ?name (quote cmdString) 
					 ?prompt "command" 
					 ?callback "ExCustomCmd(customCmdIn~>cmdString~>value)" 
					 ?buttonLayout ('OKCancel)
					 ) 
procedure(abAddPinToFloatingWire(@key (direction "inputOutput") 
									(pinUsage "schematic") 
									(wires geGetSelSet())) 
			let(netName cvId pinUnderneath pinOptions pinMasterInfo offsheet pinMaster wireUnderneath) 
			 (setq offsheet (cadr (assoc pinUsage (car schPinMasters)))) (setq pinOptions 
		foreach(mapcar(usageInfo pinInfo) (car schPinMasters) (cddr (assoc direction schPinMasters)) (cons (car usageInfo) pinInfo))) (setq pinMasterInfo (cdr (assoc pinUsage pinOptions))) 
			 (if pinMasterInfo then (setq pinMaster (dbOpenCellViewByType (car pinMasterInfo) (cadr pinMasterInfo) (caddr pinMasterInfo))) (unless pinMaster (error "Could not open pin master %L\n" pinMasterInfo)) else (error "Could not find pin master for direction %L usage %L\n" direction pinUsage)) (setq cvId (getSGq (car wires) cellView)) (foreach wire wires (when (or (equal (getSGq wire objType) "line") (equal (getSGq wire objType) "path")) (setq netName (getSGq (getSGq wire net) name)) (if netName then (foreach point (getSGq wire points) (setq pinUnderneath (dbShapeQuery cvId "pin" (list point point))) (setq wireUnderneath (setof shapeUnderneath (dbShapeQuery cvId "wire" (list point point) 0 0) (nequal shapeUnderneath wire))) (unless (or pinUnderneath wireUnderneath) (schCreatePin cvId pinMaster netName direction offsheet point "R0"))) else (warn "Selected wire does not have net name yet\n")))) (dbClose pinMaster) t)) 
