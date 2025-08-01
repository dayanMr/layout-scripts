procedure(WindStatus(win)
let((status)
	status=hiGetWindowState(win)
		if(symbolToString(status)=="iconified" then
			action="hiDeiconifyWindow(window(%d))"
		else
			action="hiRaiseWindow(window(%d))"
		)
		sprintf(nil action win~>windowNum)
	)
);proc
procedure(FindWindow()
	hiDisplayMenu(
		hiCreateSimpleMenu(
			'FindWindowPopUpMenu
			"window"
			foreach(mapcar win hiGetWindowList()
				hiGetWindowName(win))
			foreach(mapcar win hiGetWindowList()
				WindStatus(win))
				)
		)
	);proc
hiSetBindKey("Layout" "Ctrl<Btn3Down>" "FindWindow()")
hiSetBindKey("Schematics" "Ctrl<Btn3Down>" "FindWindow()")
