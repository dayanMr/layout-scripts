hiSetBindKey("Layout" "<Key>F9" "zoomform()")

procedure(zoomform() 
  prog((Coord label zoomform_id)
	  if(!boundp('zoomform_id) then 
        Coord = hiCreateListField(
                   ?name 'Coord
                   ?prompt "Coordinate:"
                   ?defValue nil 
        		)
        label = hiCreateLabel( 
                   ?name 'Text
                   ?labelText " Design By dyfeng dyfeng dyfeng , 2020/11/20 "
        		)
       zoomform_id = hiCreateForm(
                 'zoomfor
                 "zoomin_xy"
                 "zoominxy( name->Coord->value)" 
                  list( Coord label) 
                  "" 
                  ""
        		)
	   )
	  hiDisplayForm(zoomform_id)

	);prog
);procedure


procedure(zoominxy(coord11)
prog(( win coord curcmdx curcmdy ll uu )
	win=hiGetCurrentWindow()
	if(coord11==nil then
		return(nil)
	else
		case(length(coord11)
			(2
				if(listp(nth(1 coord11)) == t then
						curcmdx=nth(0 coord11)
						curcmdy=nth(1 coord11)
						;xsign=nth(1 curcmdx)
						ysign=nth(1 curcmdy)
   						if(listp(nth(0 coord11))==t then
  							coord=list(nth(2 curcmdx) nth(2 curcmdy))
						else
       						coord=list(curcmdx nth(2 curcmdy))
						);if
				else   
					curcmdx=nth(0 coord11)
			        curcmdy=nth(1 coord11)
					coord=list(curcmdx curcmdy)
				)
			)
		(3
			curcmdx=nth(1 coord11)
			curcmdz=nth(2 coord11)
			coord=list(curcmdx curcmdz)
			)
		);case
		hiZoomIn(hiGetCurrentWindow() list(0:0 0.2:0.2))
		leZoomToPoint(hiGetCurrentWindow() coord)
		leEditorOptionsForm->options->displayRefPoint->value =  t
		hiFormDone(leEditorOptionsForm)
		leSetRefPoint(geGetWindowRep(win)  coord)
	);if
);prog
);proc

