procedure(countLabel(@optional (objs geGetSelSet()) (cv geGetEditCellView()))
		let((out  name)
			when(not(objs) objs = cv~>instances)
			out = outfile("schLabel.txt")
			foreach(obj objs
				if(obj~>objType == "inst" then 
					if(obj~>pin then 
						name = obj~>pin~>term~>name
						fprintf(out "%s\n" name)
				  		)
					)
				)
			close(out)
			)
		)
