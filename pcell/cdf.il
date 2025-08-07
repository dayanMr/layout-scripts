
let( (LIBRARY CELL libId cellId cdfId)
    LIBRARY = "_LAY"
    CELL = "nmos_decap"
    unless( cellId = ddGetObj(LIBRARY CELL) 
        error("Could not get cell %s." CELL) )
    when( cdfId = cdfGetBaseCellCDF( cellId)
        cdfDeleteCDF(cdfId) )
        cdfId = cdfCreateBaseCellCDF(cellId)

;;parameter
cdfCreateParam( cdfId
        ?name		"w"
        ?prompt		"w"
        ?defValue		"1u"
        ?type		"string"
       ?display		"t"
        ?editable		"t"
        ?callback		"decapCB( 'w )"
)
cdfCreateParam( cdfId
        ?name		"l"
        ?prompt		"l"
        ?defValue		"1u"
        ?type		"string"
        ?display		"t"
        ?editable		"t"
        ?callback		"decapCB( 'l )"
)
cdfCreateParam( cdfId
        ?name		"row"
        ?prompt		"row"
        ?defValue		1
        ?type		"int"
        ?display		"t"
        ?editable		"t"
        ?callback		"decapCB( 'row )"
)
cdfCreateParam( cdfId
        ?name		"col"
        ?prompt		"col"
        ?defValue		1
        ?type		"int"
        ?display		"t"
        ?editable		"t"
        ?callback		"decapCB( 'col )"
)
  cdfSaveCDF( cdfId )
) ;end let



 
