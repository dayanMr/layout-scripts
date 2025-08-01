procedure(openLaySchCellView()
prog((cellName libName cellViewType curWindow windowList)
	cellName = geGetEditRep()~>cellName
	libName = geGetEditRep()~>libName
	cellViewType = geGetEditRep()~>cellViewType
	curWindow = getCurrentWindow()
	if(cellViewType=="schematic" then 
		cellViewType="layout" 
		rexCompile("_SCH")
		libName = rexReplace(libName "_LAY" 0)
	else 
		cellViewType="schematic"
		rexCompile("_LAY")
		libName = rexReplace(libName "_SCH" 0)
	)
when(dbOpenCellViewByType(libName cellName cellViewType nil "r")
		deOpen(list(nil 'libName libName 'cellName cellName 'viewName cellViewType) list(2:29 960:1029)  "r" )
	)
)
)
hiSetBindKey("Layout" "<Key>F12" "openLaySchCellView()")
hiSetBindKey("Schematics" "<Key>F12" "openLaySchCellView()")
