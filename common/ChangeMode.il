procedure(changemode()
prog(()
cond(
(geGetEditCellView()~>mode=="a"
    _leChangeEditMode("r")
)
(geGetEditCellView()~>mode=="r"    
    _leChangeEditMode("a")
)
)

return(nil)


);
);

hiSetBindKey("Layout" "Super<Key>q" "changemode()")

procedure(changemode1()
prog(()
cond(
(geGetEditCellView()~>mode=="a"
    _schHiChangeEditMode("r")
)
(geGetEditCellView()~>mode=="r"    
    _schHiChangeEditMode("a")
)
)

return(nil)


);
);
hiSetBindKey("Schematics" "Ctrl<Key>q" "changemode1()")





