pcDefinePCell(list(ddGetObj("_LAY") "ring" "layout") 
	((x float 1.0) (y float 1.0) (w float 0.3) (ct boolean t) 
	 (nw boolean t) (hvnw boolean nil) (hvpw boolean nil)
	  (cornerCT boolean t) )
		let((x x0 y y0 w w0 ct ct0 nw nw0 sp sp0 cornerCT cornerCT0
			pcMember pcStretchGroup stretchOffsetX stretchOffsetY
			pcLib pcMaster pcInst pcTerm pcPin
			pcPinName pcNet pcTermNet pcNetName pcTermNetName
			pcMosaicInst pcParameters pcParamProp pcStep pcStepX
			pcStepY pcRepeat pcRepeatX pcRepeatY pcIndexX
			pcIndexY pcLayer pcPurpose pcLabelText pcLabelHeight
			pcPropText pcParamText pcCoords pcPathWidth pcPolygonMargin
		) 
		(pcLib = (pcCellView~>lib)) 
		(pcParameters = ((pcCellView~>parameters)~>value)) 
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "x")))) 
		(x = (pcParamProp~>value))
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "y")))) 
		(y = (pcParamProp~>value))
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "w")))) 
		(w = (pcParamProp~>value))
		(x0 = x)
		(y0 = y)
		(w0 = w)
		if((x0 < 1) then 
			(x0 = 1)
		) 
		if((y0 < 1) then 
			(y0 = 1)
		) 
		if((w0 < 0.3) then 
			(w0 = 0.3)
		) 

		;get ct
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "ct"))))
		(ct= pcParamProp~>value)
		(ct0 = ct)
		if(ct0=="TRUE" then (ct0 = t))
		if(ct0=="FALSE" then (ct0 = nil))
		if(!booleanp(ct0) then ct0=t)

		;get nw
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "nw"))))
		(nw = pcParamProp~>value)
		(nw0 = nw)
		if(nw0=="TRUE" then (nw0 = t))
		if(nw0=="FALSE" then (nw0 = nil))
		if(!booleanp(nw0) then nw0=t)

			;get hvnw
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "hvnw"))))
		(hvnw= pcParamProp~>value)
		(hvnw0 = hvnw)
		if(hvnw0=="TRUE" then (hvnw0 = t))
		if(hvnw0=="FALSE" then (hvnw0 = nil))
		if(!booleanp(hvnw0) then hvnw0=t)
		
		;get hvpw
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "hvpw"))))
		(hvpw= pcParamProp~>value)
		(hvpw0 = hvpw)
		if(hvpw0=="TRUE" then (hvpw0 = t))
		if(hvpw0=="FALSE" then (hvpw0 = nil))
		if(!booleanp(hvpw0) then hvpw0=t)


		
		
		;get cornerCT
		(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "cornerCT"))))
		(cornerCT= pcParamProp~>value)
		(cornerCT0 = cornerCT)
		if(cornerCT0=="TRUE" then (cornerCT0 = t))
		if(cornerCT0=="FALSE" then (cornerCT0 = nil))
		if(!booleanp(cornerCT0) then cornerCT0=t)



		dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell") 
		dbReplaceProp(pcCellView "function" "string" "contact") 

		(pcMaster = dbOpenCellViewByType(pcLib "tap" "layout" "maskLayout")) 
		

		pcInst = dbCreateParamInst(pcCellView pcMaster nil 
			(-(x0/2):(y0/2)) "R0" 1 
			list(	list("ct" "boolean" ct0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" x0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil 
			(-(x0/2):(-(y0/2)-w0)) "R0" 1 		
			list(	list("ct" "boolean" ct0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" x0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil 
			((-(x0/2)):(-y0/2)) "R90" 1 
			list(	list("ct" "boolean" ct0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" y0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil
			(((x0/2)+w0):-(y0/2)) "R90" 1 
			list(	list("ct" "boolean" ct0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" y0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil 
			((-(x0/2)):(y0/2)) "R90" 1 
			list(	list("ct" "boolean" ct0 && cornerCT0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" w0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil 
			((-(x0/2)):(-y0/2-w0)) "R90" 1 		
			list(	list("ct" "boolean" ct0 && cornerCT0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" w0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil 
			(((x0/2)+w0):(y0/2)) "R90" 1 
			list(	list("ct" "boolean" ct0 && cornerCT0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" w0)))
		
		pcInst = dbCreateParamInst(pcCellView pcMaster nil
			(((x0/2)+w0):(-y0/2-w0)) "R90" 1 
			list(	list("ct" "boolean" ct0 && cornerCT0)
				list("w" "float" w0)
				list("m1" "float" w0)
				list("nw" "boolean" nw0)
				list("hvnw" "boolean" hvnw0)
				list("hvpw" "boolean" hvpw0)
				list("l" "float" w0)))
		when(nw0
			;nw
			(pcLayer = 6) 
			(pcPurpose = "drawing") 
			(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(	(-(x0/2+w0+0.6):-(y0/2+w0+0.6)) 
						((x0/2+w0+0.6):(y0/2+w0+0.6)))))
			;sdp
			(pcLayer = 67) 
			(pcPurpose = "drawing") 
			(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(	(-(x0/2-0.22):-(y0/2-0.22)) 
						((x0/2-0.22):(y0/2-0.22)))))
			;LVPL
			(pcLayer = 52) 
			(pcPurpose = "drawing") 
			(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(	(-(x0/2-0.2):-(y0/2-0.18)) 
						((x0/2-0.2):(y0/2-0.18)))))

		)
		when(hvnw0
			;hvnw
			(pcLayer = 9) 
			(pcPurpose = "drawing") 
			(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(	(-(x0/2+w0+0.6):-(y0/2+w0+0.6)) 
						((x0/2+w0+0.6):(y0/2+w0+0.6)))))
			;sdp
			(pcLayer = 67) 
			(pcPurpose = "drawing") 
			(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(	(-(x0/2-0.22):-(y0/2-0.22)) 
						((x0/2-0.22):(y0/2-0.22)))))
		)
		when(hvpw0
			;hvpw
			(pcLayer = 13) 
			(pcPurpose = "drawing") 
			(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(	(-(x0/2+w0+0.6):-(y0/2+w0+0.6)) 
						((x0/2+w0+0.6):(y0/2+w0+0.6)))))
		 			)
	;	when(nw0==nil && hvnw0==nil && hvpw0==nil
	;		;pring
	;		;LVNL
	;		(pcLayer = 51) 
	;		(pcPurpose = "drawing") 
	;		(pcInst = dbCreateRect(pcCellView 
	;				list(pcLayer pcPurpose) 
	;				list(	(-(x0/2-0.2):-(y0/2-0.18)) 
	;					((x0/2-0.2):(y0/2-0.18)))))

	;				)
				t
	)
)
