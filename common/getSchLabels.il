procedure(getSchLabels()
	let((selSet of pattern outputPath)
		outputPath = "./schLabels"
		selSet = geGetSelSet()
		of = outfile(outputPath)
		foreach(sel selSet
			if(sel~>purpose=="pin" then
				str = sel~>theLabel
				fprintf(of "%s\n" str)
			)
		)
		close(of)
	)
)
hiSetBindKey("Schematics" "<Key>-" "getSchLabels()")
