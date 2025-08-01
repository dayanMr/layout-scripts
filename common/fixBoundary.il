procedure(fixBoundary()
foreach(s geGetEditRep()~>markers
	dbDeleteObject(s)
)
foreach(s geGetEditRep()~>steiners
	dbDeleteObject(s)
)
foreach(s geGetEditRep()~>guides
	dbDeleteObject(s)
)
foreach(x geGetEditRep()~>lpps
	if(x~>layerName=="changedLayer" then
		foreach(shape x~>shapes dbDeleteObject(shape))
	)
)
;foreach(s geGetEditRep()~>shapes
;	if(s~>objType == "textDisplay" then
;		dbDeleteObject(s)
;	  )
;)
)
;foreach(s geGetEditRep()~>shapes
;	if(s~>objType == "label" && s~>lpp == '("text" "drawing") then
;		dbDeleteObject(s)
;	  )
;)

