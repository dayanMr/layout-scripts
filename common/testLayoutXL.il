procedure(testLayoutXL()
		let((status)
			status = deGetViewType(getCurrentWindow())
			if(status == "maskLayoutXL" then 
				leHiEditInPlace())
			if(status == "maskLayout" then 
				hiDisplayAppDBox(
    				?name 'TipsForm
    				?dboxBanner "NOTE"
    				?buttonLayout 'OKCancel
					?callback "leHiEditInPlace() nil"
    				?dboxText "this is Layout L"
			)
		)
	)
)
hiSetBindKey("Layout" "<Key>X" "testLayoutXL()")

procedure(testLayoutXL2()
		let((status)
			status = deGetViewType(getCurrentWindow())
			if(status == "maskLayoutXL" then 
				leHiDescend())
			if(status == "maskLayout" then 
				hiDisplayAppDBox(
    				?name 'TipsForm
    				?dboxBanner "NOTE"
    				?buttonLayout 'OKCancel
					?callback "leHiDescend() nil"
    				?dboxText "this is Layout L"
			)
		)
	)
)
hiSetBindKey("Layout" "Shift<Key>X" "testLayoutXL2()")
