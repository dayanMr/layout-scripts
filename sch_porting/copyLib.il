procedure(replaceInstLib(targetLib srcLib destLib)
	let((srcList src destList dest)
		if(ddGetObj(srcLib) && ddGetObj(destLib) then
			foreach(cellName ddGetObj(targetLib)~>cells~>name
				cv = dbOpenCellViewByType(targetLib cellName "schematic" "schematic" "a")
				foreach(inst cv~>instances
					if(inst~>libName==srcLib then
						printf("change %s-%s-%s lib to %s\n" srcLib cellName inst~>name destLib)
						leReplaceAnyInstMaster(inst destLib inst~>cellName nil)
					)
				)
				dbSave(cv)     
				dbClose(cv)
			)
		else
			printf("Please make sure lib %s and %s and %s exist!" targetLib srcLib destLib)		
		)
	)
)


procedure(copyLib(srcLib destLib)
	let((srcList src destList dest)
		if(ddGetObj(srcLib) && ddGetObj(destLib) then
			srcList = gdmCreateSpecList()
			src = gdmCreateSpec(srcLib "" "" "" "CDBA")
			gdmAddSpecToSpecList(src srcList)

			destList = gdmCreateSpecList()
			dest = gdmCreateSpec(destLib "" "" "" "CDBA")
			gdmAddSpecToSpecList(dest destList)

			ccpCopy(srcList destList t 'CCP_EXPAND_ALL nil nil "" "CDBA" 'CCP_UPDATE_FROM_LIBLIST)
			printf("copy lib %s to %s\n done" srcLib destLib)
		else
			printf("Please make sure %s and %s exist!" srcLib destLib)
		)
	)
)


