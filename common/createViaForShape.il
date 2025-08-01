procedure(createViaForShape()
let((techFile cv constraintGroupId myViaOptions shapes)
techFile = techGetTechFile(ddGetObj("hlmc28hkcp"))
cv = geGetEditRep()
constraintGroupId = cstFindConstraintGroupIn(techFile "virtuosoDefaultExtractorSetup")
myViaOptions = viaGetViaOptions(constraintGroupId)
myViaOptions->automatic->connectShapesOnSameNet = t
myViaOptions->automatic->minNumCuts= 2
myViaOptions->automatic->cutClass = "square"
myViaOptions->constraintGroupSetup->transitions = viaFindTransitions(myViaOptions~>constraintGroupSetup "M6" "M1")
shapes = geGetSelSet()
foreach(shape shapes 
	when(shape->bBox
		viaGenerateViasInArea(cv shape->bBox myViaOptions)
	)
)
)
)
hiSetBindKey("Layout" "<Key>6" "createViaForShape()")
