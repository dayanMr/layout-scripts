procedure(getLibCell()
		let((schLib schCell layLib layCell )
			if(!boundp('getLibCellForm) then 
				schLib = hiCreateStringField(
  					?name      'schLib
  					?prompt    "schLibrary"
  					?defValue  "ags251a_sch"
					)
				schCell = hiCreateStringField(
 					 ?name      'schCell
  					 ?prompt    "schCellName"
					 ?defValue  "sonos_logic"
					)
				layLib = hiCreateStringField(
  					?name      'layLib
  					?prompt    "layLibrary"
  					?defValue  "SMURF28HK64M_LAY"
					)
				layCell = hiCreateStringField(
 					 ?name      'layCell
  					 ?prompt    "layCellName"
					 ?defValue  "sonos_logic"
					)

				getLibCellForm = hiCreateAppForm(
 					 ?name      'getLibCellForm
 					 ?formTitle "libCELLForm"
					 ?callback  "checkLogicPins()"
					 ?buttonLayout list('OKCancel list('About "aboutAuthor()"))
  					 ?fields    list(
               			 list( schLib  20:10  500:10 87 )
                		 list( schCell 20:40  500:10 87 )
                		 list( layCell 20:70  500:10 87 )
                		 list( layLib  20:100 500:10 87 )
						 )
				);end-create form
				);if
				hiDisplayForm('getLibCellForm)
			);let
		);proc

	
procedure(checkLogicPins()
	let((op of schName layName schlib laylib schCv layCv schlist laylist i n tb dp)
		schName= getLibCellForm ->schCell ->value
		layName= getLibCellForm ->layCell ->value
		schlib= getLibCellForm->schLib->value
		laylib=getLibCellForm->layLib->value
		println(schName)
		println(layName)
		println(schlib)
		println(laylib )
		op = "~/checkLogicPins.txt"

		of = outfile(op)

		schCv = dbOpenCellViewByType(schlib schName "schematic" "" "r")
		layCv = dbOpenCellViewByType(laylib layName "layout" "" "r")
		schlist = sort(schCv~>sigNames nil)
		laylist = getLayoutLabels(layCv)

		fprintf(of "-------------schpins\n")
		fprintf(of "%A\n" schlist)
		fprintf(of "-------------laypins\n")
		fprintf(of "%A\n" laylist)
		fprintf(of "-------------layout pin not in schematic\n")
		i = 0
		tb =makeTable("tb" 0)
		foreach(lp laylist
			if(member(lp schlist)==nil then
				println(lp)
				fprintf(of "%s\n" lp)
			  )
				i = i +1
		 		tb[lp] = tb[lp] +1
			   )
		
				;print(tb~>??)
				dp = setof(x tb~>? tb[x]>1)
				;dp = artUnique(dp)
			fprintf(of "\n  \n" )
			fprintf(of "---------------layout double pin\n")
			fprintf(of "-------%A------\n" dp)
		fprintf(of "\n  \n" )
		fprintf(of "---------------layout total pin\n")
		fprintf(of "-------%A------\n" i)
		fprintf(of "-------------schematic pin not in layout\n")
		n = 0
		foreach(sp schlist
			if(member(sp laylist)==nil then
				fprintf(of "%s\n" sp)			
			)
			n = n +1
		)
		fprintf(of "---------------schematic total pin\n")
		fprintf(of "-------%A--------\n" n)

		close(of)
	view("~/checkLogicPins.txt")
	)
)
procedure(getLayoutLabels(cv)
	let((res layTextLayers)		
		layTextLayers = '("M1" "M2" "M3" "M1TXT" "M2TXT" "M3TXT" "M4" "M5")
		res = '()
		foreach(shape cv~>shapes
			if(member(car(shape~>lpp) layTextLayers) then
				if(shape->objType=="label" then
					res = cons((shape~>theLabel) res)	
				)
				if(shape->objType=="textDisplay" then
					res = cons((shape~>parent~>net~>name) res)	
				)
			)
		)
	res
	)
)


hiSetBindKey("Layout" "Ctrl<key>4" "getLibCell()") 
		;view(\"~/checkLogicPins.txt\") ")

;checkLogicPins()
;shell("gvim checkLogicPins.txt ")
;view("~/checkLogicPins.txt")
