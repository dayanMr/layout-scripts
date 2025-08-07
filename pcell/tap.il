pcDefinePCell(list(ddGetObj("_lay") "tap" "layout") 
	((w float 0.3) (l float 1.0) (ct boolean t) 
	 (nw boolean t) (hvnw boolean nil) (hvpw boolean nil))

	let((l l0 l0offset ct ct0 w w0 m1 m10 pcMember pcStretchGroup
		stretchOffsetX stretchOffsetY pcLib pcMaster pcInst
		pcTerm pcPin pcPinName pcNet pcTermNet
		pcNetName pcTermNetName pcMosaicInst pcParameters pcParamProp
		pcStep pcStepX pcStepY pcRepeat pcRepeatX
		pcRepeatY pcIndexX pcIndexY pcLayer pcPurpose
		pcLabelText pcLabelHeight pcPropText pcParamText pcCoords
		pcPathWidth pcPolygonMargin xoffset yoffset
	) 
	(pcLib = (pcCellView~>lib)) 
	(pcParameters = ((pcCellView~>parameters)~>value)) 

	;get l
	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "l"))))  
	(l = (pcParamProp~>value))
	(l0 = l) 
	if(!numberp(l0) then
		(l0 = 1)
	) 
	if((l0 <= 0) then 
		(l0 = 1)
	) 
	(l0offset = l0)

	;get w
	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "w"))))  
	(w = (pcParamProp~>value))
	(w0 = w) 
	if(!numberp(w0) then
		(w0 = 0.3)
	) 	
	if((w0 <= 0.3) then 
		(w0 = 0.3)
	) 
	;(l0offset = (l0 - 0.18))

	;get m1
	;(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "m1"))))  
	;(m1 = (pcParamProp~>value))
	;(m10 = m1) 
	;if(!numberp(m10) then
	;	(m10 = 0.3)
	;) 	
	;if((m10 <= 0.3) then 
	;	(m10 = 0.3)
	;) 

	

	;get ct
	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "ct"))))
	(ct= pcParamProp~>value)
	(ct0 = ct)
	if(ct0=="TRUE" then (ct0 = t))
	if(ct0=="FALSE" then (ct0 = nil))
	if(!booleanp(ct0) then ct0=t)
	
	;get nw
	(pcParamProp = car(exists(prop pcParameters ((prop~>name) == "nw"))))
	(nw= pcParamProp~>value)
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
	


	
	dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell") 
	dbReplaceProp(pcCellView "function" "string" "contact") 


	;set prop value
	(pcStep = 0) 
	(pcRepeat = 0) 
	(pcStepY = 0.22)
	(pcStepX = 0.22)
	(pcRepeatY = fix((w0 - 0.2)/pcStepY + 1))
	(pcRepeatX = fix((l0 - 0.2) / pcStepX + 1))
	(pcIndexY = 0) 
	(pcIndexX = 0) 
	(xoffset = ((l0-((pcRepeatX-1)*pcStepX+0.09))/2))
	(yoffset = ((w0-((pcRepeatY-1)*pcStepY+0.09))/2))
	;(xoffset = (fix(xoffset*100)/100.0))
	;(yoffset = (fix(yoffset*100)/100.0))


	;aa
	(pcLayer = 1)
	(pcPurpose = "drawing") 
	(pcInst = rodCreateRect(
           	?width   l0
            ?length  w0
			?layer list(pcLayer pcPurpose) 
    	)) 

	rodAssignHandleToParameter(
        	?parameter  "l"
	        ?rodObj pcInst
        	?handleName list("centerRight" "centerLeft")
	        ?displayName  "l"
        	?stretchDir "X"
			?stretchType     "relative"
			?moveOrigin	t
        )
	rodAssignHandleToParameter(
        	?parameter  "w"
	        ?rodObj pcInst
        	?handleName list("upperCenter" "lowerCenter")
	        ?displayName  "w"
        	?stretchDir "Y"
			?stretchType     "relative"
			?moveOrigin	t
        )


	;m1
	(pcLayer = 101) 
	(pcPurpose = "drawing") 
	(pcInst = rodCreateRect(
         	  	?width   l0
                ?length  w0
				?layer list(pcLayer pcPurpose)
				;?origin 0:-(-w0/2)
    	)) 
	;if(nw0 then
	;sdn
	;(pcLayer = 66) 
	;(pcPurpose = "drawing") 
	;(pcInst = 	rodCreateRect(
     ;      		?width   l0+0.4
      ;          ?length  w0+0.4
	;			?layer list(pcLayer pcPurpose) 
	;			?origin -0.2:-0.2
    ;	))
	;)
	if(hvpw0 then

	;sdp
	(pcLayer = 67) 
	(pcPurpose = "drawing") 
	(pcInst = 	rodCreateRect(
           		?width   l0+0.4
                ?length  w0+0.4
				?layer list(pcLayer pcPurpose) 
				?origin -0.2:-0.2
    	))
	)
	unless(nw0 || hvnw0 || hvpw0
	;sdp
	(pcLayer = 67) 
	(pcPurpose = "drawing") 
	(pcInst = 	rodCreateRect(
           		?width   l0+0.4
                ?length  w0+0.4
				?layer list(pcLayer pcPurpose) 
				?origin -0.2:-0.2
				))
	)
	;nw
	if(nw0 then
	(pcLayer = 6) 
	(pcPurpose = "drawing") 
	(pcInst = 	rodCreateRect(
           		?width   l0+1.2
                ?length  w0+1.2
				?layer list(pcLayer pcPurpose) 
				?origin -0.6:-0.6
    	)) 
	)
	;hvnw
	if(hvnw0 then
	(pcLayer = 9) 
	(pcPurpose = "drawing") 
	(pcInst = 	rodCreateRect(
           		?width   l0+1.2
                ?length  w0+1.2
				?layer list(pcLayer pcPurpose) 
				?origin -0.6:-0.6
    	)) 
	)
	;hvpw
	if(hvpw0 then
	(pcLayer = 13) 
	(pcPurpose = "drawing") 
	(pcInst = 	rodCreateRect(
           		?width   l0+1.2
                ?length  w0+1.2
				?layer list(pcLayer pcPurpose) 
				?origin -0.6:-0.6
    	)) 
	)
	

	if(ct0 then
	    ;ct
		(pcLayer = 85) 
		(pcPurpose = "drawing")
		for(pcIndexY 0 fix(pcRepeatY-1)
			for(pcIndexX 0 fix(pcRepeatX-1)
				(pcInst = dbCreateRect(pcCellView 
					list(pcLayer pcPurpose) 
					list(((xoffset + pcIndexX * pcStepX):(yoffset + pcIndexY * pcStepY)) 
					     ((xoffset + pcIndexX * pcStepX + 0.09):(yoffset + pcIndexY * pcStepY+0.09)))
			    )) 
			)
		)
	)
	t
	) 
)
