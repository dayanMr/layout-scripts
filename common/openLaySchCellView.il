procedure(openLaySchCellView()
prog((cellName libName cellViewType curWindow windowList createWindow)
	cellName = geGetEditRep()~>cellName
	libName = geGetEditRep()~>libName
	cellViewType = geGetEditRep()~>cellViewType
	curWindow = getCurrentWindow()
	if(libNameTable && libNameTable[libName] then
		libName = libNameTable[libName]
	)

	if(cellViewType=="schematic" then 
		cellViewType="layout" 
		rexCompile("_SCH")
		libName = rexReplace(libName "_LAY" 0)
	else 
		cellViewType="schematic"
		rexCompile("_LAY")
		libName = rexReplace(libName "_SCH" 0)
	)
	windowList = hiGetWindowList()
	foreach(window windowList
		when(window->cellView->cellName==cellName &&
			window->cellView->libName==libName &&
			window->cellView->cellViewType==cellViewType &&
			hiSetWindowFocus(window)
			hiSetWindowFocus(curWindow)
			return(window)
		)
	)
	when(dbOpenCellViewByType(libName cellName cellViewType nil "r")
		createWindow = deOpen(list(nil 'libName libName 'cellName cellName 'viewName cellViewType) list(2:29 960:1029)  "r" )
		;hiSetWindowFocus(curWindow)
		while(countSchWindow()>5
			closeFirstSchWindow()
		)
		return(createWindow)

	)
)
)

procedure(countSchWindow()
let((windowList ret ) 
	windowList = hiGetWindowList()
	
	ret = 0
	foreach(window windowList
		if(window->cellView->cellViewType=="schematic" then
			ret=ret+1
		  )
		)
	ret
)
)

procedure(closeFirstSchWindow()
prog((windowList) 
	windowList = hiGetWindowList()
			printf("%A\n" windowList)
	foreach(window windowList
		when(window->cellView->cellViewType=="schematic" && windowp(window)
			hiCloseWindow(window->sessionWindow)
			return()
		)
	)
)
)

;hiSetBindKey("Layout" "<Key>F12" "openLaySchCellView()")
;hiSetBindKey("Schematics" "<Key>F12" "openLaySchCellView()")

;list(2:20 960:1060)
