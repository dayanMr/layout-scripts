repeatStartMark = nil
logFilePath = hiGetLogFileName() 
repeatLogFile = "~/project/XMC/AEF570A/skill/repeatLogFile.txt"
repeatCMD = list()
procedure(getRepeatCMD()
let((infi line)
	if(repeatStartMark then
		;find last \i getRepeatCMD() in CDS.log
		shell(strcat("python /home/users/qyang/project/XMC/AEF570A/skill/readLogFile.py " logFilePath " " repeatLogFile))
		infi = infile(repeatLogFile)
		repeatCMD = list()
		while(line = gets(nil infi)
			repeatCMD = append1(repeatCMD line)
		)
		
		;printf("-------\n")
		;printf("%s\n" repeatCMD)
		;printf("-------\n")
		repeatStartMark = nil
		print("end record cmd\n")
	else	
		repeatStartMark = t
		print("start record cmd\n")
	)
)
)

procedure(doRepeatCMD()
let(()
	if(length(repeatCMD)>0 then
		foreach(cmd repeatCMD
			evalstring(cmd)
		)
	)
)
)

hiSetBindKey("Layout" "<Key>4" "getRepeatCMD()")
hiSetBindKey("Layout" "Shift<Key>4" "doRepeatCMD()")
