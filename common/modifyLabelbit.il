procedure(modifyLabelbit(opt @optional (objs geGetSelSet()))
		prog((cv label temp temp1 NumBit )
			if(not(objs) then return(nil))
			cv = geGetEditCellView()
			if(cv~>cellViewType != "maskLayout" then return(nil))
			if(cv~>viewName != "layout" then return(nil))
			foreach(obj objs
				when(obj~>objType == "label"
					label = obj~>theLabel
					when(pcreMatchp("<" label) && pcreMatchp(">" label)
						temp = parseString(label "<")
						;println(temp)
						temp1 = parseString(cadr(temp) ">")
						;println(temp1)
						NumBit = evalstring(car(temp1)) + opt
						NumBit =sprintf(nil "%d" NumBit )
						obj~>theLabel = strcat(car(temp) "<" NumBit ">")
						)
					)
				)
			)
		)
procedure(modifyLabelbit_()
		hiDisplayMenu(
			hiCreateSimpleMenu(	
				'modifyLabelBIT
				"modifyLabelBit"
				'("PLUS"
				  "MINUS"
				 )
				'("modifyLabelbit(1)"
				  "modifyLabelbit(-1)"
				)
			)
	)
	)
hiSetBindKey("Layout" "Shift<Key>J" "modifyLabelbit_()")
hiSetBindKey("Layout" "Ctrl<Key>J" "modifyLabelbitForm()")

procedure(modifyLabelbit2(@optional (objs geGetSelSet()))
		prog((cv label temp temp1 NumBit opt)
			if(not(objs) then return(nil))
			cv = geGetEditCellView()
			if(cv~>cellViewType != "maskLayout" then return(nil))
			if(cv~>viewName != "layout" then return(nil))
			opt = bitForm -> bitString ->value
			foreach(obj objs
				when(obj~>objType == "label"
					label = obj~>theLabel
					when(pcreMatchp("<" label) && pcreMatchp(">" label)
						temp = parseString(label "<")
						;println(temp)
						temp1 = parseString(cadr(temp) ">")
						;println(temp1)
						NumBit = evalstring(car(temp1)) + opt
						NumBit =sprintf(nil "%d" NumBit )
						obj~>theLabel = strcat(car(temp) "<" NumBit ">")
						)
					)
				)
			)
		)


procedure(modifyLabelbitForm()
		let((bitString)
			if(!boundp('bitForm) then
				bitString = hiCreateIntField(
					?name 'bitString
					?prompt "bit number"
					?value  1
					?defValue 1
					)
				bitForm = hiCreateAppForm(
					?name 'bitForm
					?formTitle "bitForm"
					?callback "modifyLabelbit2()"
					?buttonLayout list('OKCancel)
					?fields list(bitString)
					);hiCreateAppForm
			  );if
			hiDisplayForm(bitForm)
			)
		)

