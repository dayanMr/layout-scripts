procedure(countLabelForSch(@optional (objs geGetSelSet()) (cv geGetEditCellView()))
		let((out i label)
			out = outfile("schLabel.txt")
			i = 0
			nets = nil
			foreach(obj objs
				if(obj~>net then 
					nets = append1(nets obj~>net)
				  );if
				);foreach
			if(length(nets) == 0 then nets = cv~>nets)
			foreach(net nets
				if(net->numBits >= 1 then
					foreach(signal net->signals
						i+=1
						fprintf(out "%s\n"  signal~>name)

				  		)
					)
				)
			close(out)
			if(type(i) == 'fixnum || 'flonum then i = artMakeString(i))
			text = strcat("total label is " i)
			hiDisplayAppDBox(
    			?name 'TipsForm
    			?dboxBanner "Warning"
    			?buttonLayout 'Close
    			?dboxText  text
				)
		   )
)


