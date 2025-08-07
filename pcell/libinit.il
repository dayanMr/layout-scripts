printf("Loading _LAY/cdf.il ... ")
;load "/home/projects//layout/_LAY/cdf.il"
let((ddObj)
	ddObj = ddGetObj("_LAY", nil, nil, "cdf.il", nil, "r")
	;when(ddObj
	;	errset(load(ddGetObjReadPath(ddObj)))
	;)
)

procedure( decapCB(param)
  let( (cdfId w l row col)
     cdfId = cdfgData
    caseq( param
      ( w
	
          w = cdfId->w->value
	when(stringp(w) w=cdfParseFloatString(w))
	      when(w && w<1u 
	          cdfId->w->value = cdfId->w->defValue
          )
      )
     ( l
          l = cdfId->l->value
	when(stringp(l) l=cdfParseFloatString(l))
	      when(l && l<1u 
	          cdfId->l->value = cdfId->l->defValue
          )
      )
     ( row
          row = cdfId->row->value
	      when(row && row<1 
	          cdfId->row->value = cdfId->row->defValue
          )
      )
     ( col
          col = cdfId->col->value
	      when(col && col<1 
	          cdfId->col->value = cdfId->col->defValue
          )
      )
    ) ;end caseq
  ) ;end let
) ;end procedure
