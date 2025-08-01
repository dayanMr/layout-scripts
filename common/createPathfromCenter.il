procedure(createPathStep( @optional (objs geGetSelSet()) (cv geGetEditCellView()))

		let((step width pitch dire obj box center x_start x_end y_start y_end num yt yb xt xb path1 path2 group )
			step = stepValueForm -> stepValue -> value
			println(step )
			width = stepValueForm -> widthValue -> value
			println(width )
			pitch = stepValueForm -> pitchValue -> value
			println(pitch )
			dire = stepValueForm -> direValue -> value
			println(dire )
			if(dire == "horizontal" then
				foreach(obj objs
					box = obj~>bBox
					center = centerBox(box)
					x_start = leftEdge(box)
					x_end = rightEdge(box)
					y_start = bottomEdge(box)
					y_end = topEdge(box)
					num = int((y_end - y_start)/pitch)
					if(step/2 < num then
						for(i 0 step-1
							yt =  yCoord(center) + i*pitch
							yb =  yCoord(center) - i*pitch
							path1 = dbCreatePath(cv list("M3" "drawing") list(list(x_start yt) list(x_end yt)) width)
							path2 = dbCreatePath(cv list("M3" "drawing") list(list(x_start yb) list(x_end yb)) width)
							group =obj~>figGroup
							if(group && path1 && path2 then
							dbAddFigToFigGroup(group path1)
							dbAddFigToFigGroup(group path2)
							)
							)
					else
						warn("step Value beyond limit of nums")
		   			)
				)
			)
			if(dire == "vertical" then
				foreach(obj objs
					box = obj~>bBox
					center = centerBox(box)
					x_start = leftEdge(box)
					x_end = rightEdge(box)
					y_start = bottomEdge(box)
					y_end = topEdge(box)
					num = int((x_end - x_start)/pitch)
					println(num)
					if(step/2 < num then
						for(i 0 step-1
							xt =  xCoord(center) + i*pitch
							xb =  xCoord(center) - i*pitch
							path1 = dbCreatePath(cv list("M2" "drawing") list(list(xt y_start) list(xt y_end)) width)
							path2 = dbCreatePath(cv list("M2" "drawing") list(list(xb y_start) list(xb y_end)) width)
							group =obj~>figGroup
							if(group && path1 && path2 then
							dbAddFigToFigGroup(group path1)
							dbAddFigToFigGroup(group path2)
						)
						)
					else
						warn("step Value beyond limit of nums")
		   			)
				)
			)

		)
	)

hiSetBindKey("Layout" "<Key>$" "stepAppForm()")
procedure(stepAppForm()
		let((stepvalue widthValue  pitchValue  direValue stepFrom) 
			if(!boundp('stepValueForm) then 
				stepValue =hiCreateIntField(
					?name 'stepValue
					?prompt "stepValue"
					?value 1
					?defValue 1
				)
				widthValue =hiCreateFloatField(
					?name 'widthValue
					?prompt "widthValue"
					?value 0.13
					?defValue 0.13
				)
				pitchValue =hiCreateFloatField(
					?name 'pitchValue
					?prompt "pitchValue"
					?value 0.26
					?defValue 0.26
					)
				direValue = hiCreateRadioField(
					?name 'direValue
					?choices '("vertical" "horizontal")
					?prompt "direValue"
					?value "horizontal"
					?defValue "horizontal"
					
					)

			 stepValueForm = hiCreateAppForm(
					?name	'stepValueForm
					?formTitle	"dyfeng custom stepAppFrom"
					?fields list(stepValue widthValue pitchValue direValue)
					?callback "createPathStep()"
					?buttonLayout list('OKCancel list('About "aboutAuthor()"))
 				)
			)
			hiDisplayForm(stepValueForm)
		)
	)

procedure(aboutAuthor()
	hiDisplayAppDBox(
		?name 'about
		?dboxBanner "About author"
		?dialogType hicInformationDialog
		?buttonLayout 'Close
		?dboxText "create by dyfeng 2023.4.17"	
	)
)




