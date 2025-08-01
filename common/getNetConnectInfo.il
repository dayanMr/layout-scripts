procedure(getNetConnectInfo()
let((nets objs cv checkedList fpath f count tb netInfo)
	objs = geGetSelSet()
	cv = geGetEditRep()
	nets = list()
	count = 0
	foreach(obj objs 
		if(obj->net then
			nets = append1(nets obj->net)
		)
	)
	if(length(nets)==0 then 
		nets = cv->nets
	)
	tb = makeTable("tb" nil)
	checkedList = list()
	fpath = strcat("~/netConnectInfo/" cv->cellName ".txt")
	unless(isDir("~/netCOnnectInfo") sh("mkdir -p ~/netConnectInfo"))
	f = outfile(fpath "w")
	foreach(net nets
		if(not(member(net checkedList)) then
			if(net->numBits>1 then
				foreach(signal net->signals
					;fprintf(f "%A\n" getNetTerms(signal net->pins))
					netInfo = getNetTerms(signal net->pins)
					checkedList = append1(checkedList signal)
					count+=1
				)
			else
				;fprintf(f "%A\n" getNetTerms(net net->pins))
				netInfo = getNetTerms(net net->pins)
				checkedList = append1(checkedList net)
				count+=1
			)
			if(tb[cadr(netInfo)] then
				tb[cadr(netInfo)] = append1(tb[cadr(netInfo)] car(netInfo))
			else
				tb[cadr(netInfo)] = list(car(netInfo))
			)
		)
	)
	
	foreach(tt tb->?
		fprintf(f "%s\n" tt)
		foreach(ll tb[tt]
			fprintf(f "\t%s\n" ll)
		)
		fprintf(f "\n")
	)
	fprintf(f "%A" count)
	close(f)
	view(fpath)
)
)

procedure(getNetTerms(net outMark)
let((term res s)
	res = list()
	foreach(mem net->memInstTerms
		term = car(mem)
		s = strcat(term->inst->baseName "-" term->inst->cellName)
		when(not(member(s res))
			res = append1(res s)
		)
	)	
	res = sort(res nil)
	res = buildString(res)
	when(outMark
		;res = append1(res "*OUT*" )	
		res = strcat(res " *OUT*")
	)
	list(net->name res)
)
)



