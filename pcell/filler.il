pcDefinePCell(list(ddGetObj("AEF_LAY") "filler" "layout") 
    ((l float 0.18) 
	(ct boolean t)
	(row int 1)
	(boldM1 boolean t))
     
    let((l l0 l0offset  ct ct0 ct0offest row row0 boldM1 M10
	    stretchP1offset stretchN stretchN2 stretchN2offset pcMember
	    pcStretchGroup stretchOffsetX stretchOffsetY pcLib pcMaster
	    pcInst pcTerm pcPin pcPinName pcNet
	    pcTermNet pcNetName pcTermNetName pcMosaicInst pcParameters
	    pcParamProp pcStep pcStepX pcStepY pcRepeat
	    pcRepeatX pcRepeatY pcIndexX pcIndexY pcLayer
	    pcPurpose pcLabelText pcLabelHeight pcPropText pcParamText
	    pcCoords pcPathWidth pcPolygonMargin
	) 

	(pcLib = (pcCellView~>lib)) 
	(pcParameters = ((pcCellView~>parameters)~>value)) 

	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "l")))) 
	(l = (pcParamProp~>value))

	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "ct"))))
	(ct= pcParamProp~>value)

	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "row")))) 
	(row = (pcParamProp~>value))

	
	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "boldM1")))) 
	(boldM1 = (pcParamProp~>value))



	;l
	(l0 = l) 
	if((l0 < 0.18) then 
	    (l0 = 0.18)
	) 
	(l0offset = (l0 - 0.18))

	;ct
	(ct0 = ct)
	if(ct0=="TRUE" then (ct0 = t))
	if(ct0=="FALSE" then (ct0 = nil))
	if(!booleanp(ct0) then ct0=t)
	
	;M1
	(M10 = boldM1)
	if(M10=="TRUE" then (M10 = t))
	if(M10=="FALSE" then (M10 = nil))
	if(!booleanp(M10) then M10=t)

	;row
	(row0 = row) 
	if(floatp(row0) then 
	    (row0 = ceiling(row0))
	) 

		
	dbReplaceProp(pcCellView "pin#" "int" 1) 
	dbReplaceProp(pcCellView "_pcCompiledCounter" "int" 51404) 
	dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell") 
	dbReplaceProp(pcCellView "function" "string" "contact")
	dbReplaceProp(pcCellView "lastSavedExtractCounter" "int" 390) 


	(pcStepX = 0.18) 
	(pcStepY = 7.28) 
	(pcRepeatX = fix((l-0.18)/ 0.18))
	(pcRepeatY = row0)
	(pcIndexX = 0)
	(pcIndexY = 0)
	(yoffset = 3.64)

	;create prboudary
	(pcBoundary = dbCreatePRBoundary(pcCellView 
		list((0.0:0.0) 
			(0.0:(yoffset*row0)) 
			((0.18 + l0offset):(yoffset*row0)) 
			((0.18 + l0offset):0.0)
		) 
		list("EDGE_1" "EDGE_2" "EDGE_3" "EDGE_4")
	)) 


	;ct
	for(pcIndexY 0 (fix pcRepeatY)
		if(ct0 then
		;ct
		for(pcIndexX 0 fix(pcRepeatX)
		(pcLayer = 50)
		(pcPurpose = "drawing")
		(pcInst = dbCreateRect(pcCellView 
			list(pcLayer pcPurpose) 
			list(((0.05 + (pcIndexX * pcStepX)):(-0.04+yoffset*pcIndexY)) 
			((0.13 + (pcIndexX * pcStepX)):(0.04+yoffset*pcIndexY))
			)))
		)
		)
		
		;m1 drawing
		(pcLayer = 61) 
		(pcPurpose = "drawing")
		(pcInst = dbCreateRect(pcCellView 
			list(pcLayer pcPurpose) 
			list((0.0:(-0.11+yoffset*pcIndexY)) 
				((0.18 + l0offset):(0.11+yoffset*pcIndexY))
		)))
		;boldm1 drawing
		if(M10 then
		(pcLayer = 61) 
		(pcPurpose = "drawing")
		(pcInst = dbCreateRect(pcCellView 
			list(pcLayer pcPurpose) 
			list((0.0:(-0.22+yoffset*pcIndexY)) 
				((0.18 + l0offset):(0.22+yoffset*pcIndexY))
		))))



		;m1 text
		(pcLayer = "M1TXT") 
		(pcPurpose = "drawing")
		(pcLabelHeight = 0.1) 
		if(mod(pcIndexY 2)==0 then
			(pcLabelText = "gnd!") 
			(pcInst = dbCreateLabel(pcCellView 
				list(pcLayer pcPurpose) 
				(0.09:(yoffset*pcIndexY)) pcLabelText "centerCenter"
				"R270" "roman" pcLabelHeight
			)) 
			setSGq(pcInst "normalLabel" labelType) 
		else
			(pcLabelText = "vdd!") 
			(pcInst = dbCreateLabel(pcCellView 
				list(pcLayer pcPurpose) 
				(0.09:(yoffset*pcIndexY)) pcLabelText "centerCenter"
				"R270" "roman" pcLabelHeight
			)) 
			setSGq(pcInst "normalLabel" labelType)
		)

		;aa
		(pcLayer = 10) 
		(pcPurpose = "drawing") 
		(pcInst = dbCreateRect(pcCellView 
			list(pcLayer pcPurpose) 
			list((0.0:(-0.11+yoffset*pcIndexY)) 
				((0.18 + l0offset):(0.11+yoffset*pcIndexY))
		))) 


		;nw
		(pcLayer = 14) 
		(pcPurpose = "drawing") 
		if(mod(pcIndexY 2)==1 then		
			(pcInst = dbCreateRect(pcCellView 
				list(pcLayer pcPurpose) 
				list((-0.4:(1.77+yoffset*fix(pcIndexY-1))) 
					((0.58 + l0offset):(4.15+yoffset*fix(pcIndexY-1)))
			)))
			if(pcIndexY != pcRepeatY then		
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((-0.4:(1.77+yoffset*fix(pcIndexY-1))) 
						((0.58 + l0offset):(5.51+yoffset*fix(pcIndexY-1)))
				)))
			)
		) 


		if(mod(pcIndexY 2)==0 then		
			if(pcIndexY!=pcRepeatY then	
				(pcLayer = 43)
				(pcPurpose = "drawing")
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((0.0:(1.85+yoffset*pcIndexY)) 
						((0.18 + l0offset):(3.33+yoffset*pcIndexY))
				))) 
				;SP
				(pcLayer = 38)
				(pcPurpose = "drawing")
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((0.0:(1.85+yoffset*pcIndexY)) 
						((0.18 + l0offset):(3.33+yoffset*pcIndexY))
				))) 
				;PLL

				(pcLayer = 35) 
				(pcPurpose = "drawing")
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((-0.18:(0.32+yoffset*pcIndexY)) 
						((0.36 + l0offset):(1.4+yoffset*pcIndexY))
				)))
				;nll 
				(pcLayer = 43) 
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((-0.2:(-0.31+yoffset*pcIndexY)) 
						((0.38 + l0offset):(0.31+yoffset*pcIndexY))
				)))
				;sp
				)
		else
			if(pcIndexY!=pcRepeatY then		
				(pcLayer = 43)
				(pcPurpose = "drawing")
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((0.0:(0.31+yoffset*pcIndexY)) 
						((0.18 + l0offset):(1.79+yoffset*pcIndexY))
				))) 
				;SP
				(pcLayer = 38)
				(pcPurpose = "drawing")
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((0.0:(0.31+yoffset*pcIndexY)) 
						((0.18 + l0offset):(1.79+yoffset*pcIndexY))
				))) 
				;PLL

				(pcLayer = 35) 
				(pcPurpose = "drawing")
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((-0.18:(2.24+yoffset*pcIndexY)) 
						((0.36 + l0offset):(3.32+yoffset*pcIndexY))
				)))
				;nll 
				(pcLayer = 43) 
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list((-0.2:(3.33+yoffset*pcIndexY)) 
						((0.38 + l0offset):(3.95+yoffset*pcIndexY))
				)))
				;sp
				)
			)

		)

		
	;------------------------------------------------------
		   
		t   
    )
)
