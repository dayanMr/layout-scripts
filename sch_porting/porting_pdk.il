procedure(porting_PDK(targetLib)
	let((targetCellList targetSchCV)
		targetCellList=ddGetObj(targetLib)~>cells~>name
		foreach(targetCell targetCellList
			when(targetSchCV  = dbOpenCellViewByType(targetLib targetCell "schematic" "schematic" "a")
				foreach(targetInst targetSchCV~>instances
					when(targetInst~>libName=="PDK_Src_Lib"

						newCellName = case(targetInst~>cellName
							("p18" "p33")
							("n18" "n33")
							("nt18" "nt33")
							("nwdio18" "nwdio33")
							("pdio18" "pdio33")
							("pnp18a25" "pnp33a25")
							("p18_mis" "p33_mis")
							("n18_mis" "n33_mis")
							(t targetInst~>cellName)
						)
						checkMosWL(targetInst)
						printf("change %s-%s-%s-%s to %s-%s\n" targetLib targetCell targetInst~>baseName targetInst~>cellName "FG50_33_Lib" newCellName)
						leReplaceAnyInstMaster(targetInst "PDK_dest_Lib" newCellName nil)
						changeModelName(targetInst)
						;doCallBack(targetInst)
						cdfgData = cdfGetInstCDF(targetInst)
						PasCdfFormInit(cdfgData)
						cdfUpdateInstParam(targetInst)
					)
				)		
				dbSave(targetSchCV)     
				dbClose(targetSchCV)

			)
		)
	)
)

procedure(doCallBack(inst)
	let((instCdf)
		when(instCdf = cdfGetInstCDF(inst)
			foreach(param instCdf~>parameters
				when(param~>callback evalstring(param~>callback))
			)
			cdfUpdateInstParam(inst)
		)
	)
)

procedure(checkMosWL(inst)
	let((ol nl ofw nfw)
		when((inst~>cellName=="n18" || inst~>cellName=="n18_mis") && strToNum(inst~>l)<330n
			nl = 330n
		)
		when((inst~>cellName=="p18" || inst~>cellName=="p18_mis") && strToNum(inst~>l)<300n
			nl = 300n
		)
		when(nl
			ofw = strToNum(inst~>fw) 
			ol = strToNum(inst~>l)
			sprintf(nfw "%.8f" nl/ol*ofw)
			nfw = strToNum(nfw)
			inst~>fw = nfw
			inst~>l = nl
			printf("change %s-%s-%s finger width from %g to %g\n" inst~>cellView~>libName inst~>cellView~>cellName inst~>baseName ofw nfw)
			printf("change %s-%s-%s length from %g to %g\n" inst~>cellView~>libName inst~>cellView~>cellName inst~>baseName ol nl)		
		)
	)
)

procedure(changeModelName(inst)
	let((modelList cdfObj)
	cdfObj = cdfGetInstCDF(inst)
	modelList = '("nt18" "nwdio18" "pdio18" "pnp18a25")
	if(member(cdfObj~>model~>value modelList) then
		println(inst~>cellName)
		cdfGetInstCDF(inst)~>model~>value = 
			case(cdfGetInstCDF(inst)~>model~>value
			("nt18" "nt33")
			("nwdio18" "nwdio33")
			("pdio18" "pdio33")
			("pnp18a25" "pnp33a25")
			)
	)
	)
)

procedure(strToNum(in)
	let(()
		if(stringp(in) then
			evalstring(in)
		else
			in
		)

	)
)
