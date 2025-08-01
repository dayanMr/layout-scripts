procedure(AUTOvia()
	let((TechFile CGroupId MyViaOptions window NEWVIAS VisibleList VISIBLElist MaxLayNum MinLayNum )
		TechFile = techGetTechFile(geGetEditRep())
		CGroupId = cstFindConstraintGroupIn(TechFile "virtuosoDefaultSetup")
		MyViaOptions = viaGetViaOptions(CGroupId)
		Window = deGetCellView()
		NEWVIAS=viaGenerateViasAtPoint(Window hiGetPoint(hiGetCurrentWindow()) MyViaOptions)
		VisibleList=nil
		VISIBLElist=nil
		foreach(SVIA NEWVIAS
			VisibleList = append(VisibleList setof(x SVIA~>viaHeader~>master~>shapes~>lpp leIsLayerVisible(x)==t))  
			);foreach  
		foreach(x VisibleList
		unless(member(x VISIBLElist)
			VISIBLElist= append1(VISIBLElist x)
			);unless
		);foreach
		MaxLayNum=0
		MinLayNum=100
		foreach(y VISIBLElist 
			MaxLayNum=max(MaxLayNum MetalLayerNumber(car(y)))
			MinLayNum=min(MinLayNum MetalLayerNumber(car(y)))
		);foreach  find min visible layerNum & max visible layerNum
		for(i 0 length(NEWVIAS)-1
			if(setof(x nth(i NEWVIAS)~>viaHeader~>master~>shapes~>layerName MetalLayerNumber(x)<MinLayNum||MetalLayerNumber(x)>MaxLayNum)
				then dbDeleteObject(nth(i NEWVIAS)) 
		);if
		);for
		);let
);proc

procedure(MetalLayerNumber( MetalLayerName )
	let((MetalList MetalNum)
		MetalList=list("M1" "M2" "M3" )
		for(i 1 length(MetalList)
		if(nth(i-1 MetalList)== MetalLayerName
			then
			MetalNum=i);if
		);for
	MetalNum
	);let
);proc

hiSetBindKey("Layout" "Shift<Key>O" "AUTOvia()")
