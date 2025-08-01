procedure((
let((libName lib cells cvList lvtCellNameList hvtCellNameList
    lvts hvts refShape shapes nw
    )
    libName = "oc8051"
    lib     = ddGetObj(libName)
    cells   = lib~>cells
    cvList  = mapcar(lambda((x) dbOpenCellViewByType(libName x~>name "layout" nil "r")) cells)
    lvtCellNameList = setof(x cvList member(list("Plvt" "drawing") x~>shapes~>lpp))~>cellName
    hvtCellNameList = setof(x cvList member(list("Phvt" "drawing") x~>shapes~>lpp))~>cellName
    mapcar('dbClose cvList)
    
    lvts = mapcar(lambda((x) dbOpenCellViewByType(libName x "layout" nil "a")) lvtCellNameList)
    hvts = mapcar(lambda((x) dbOpenCellViewByType(libName x "layout" nil "a")) hvtCellNameList)
    
    foreach(cv lvts
        printf("cellName: %s\n" cv~>cellName)
        refShape = setof(x cv~>shapes x~>lpp == list("Plvt" "drawing"))
        shapes = cv~>shapes
        if(nw = setof(x shapes x~>layerName == "Nwell")
        then
            dbLayerAnd(cv    list("Plvt" "drawing") refShape nw)
            dbLayerAndNot(cv list("Nlvt" "drawing") refShape nw)
            mapcar('dbDeleteObject refShape)
        else
            refShape~>lpp = list("Nlvt" "drawing")
        )
        dbSave(cv)
        dbClose(cv)
    )
    foreach(cv hvts
        printf("cellName: %s\n" cv~>cellName)
        refShape = setof(x cv~>shapes x~>lpp == list("Phvt" "drawing"))
        shapes = cv~>shapes
        if(nw = setof(x shapes x~>layerName == "Nwell")
        then
            dbLayerAnd(cv    list("Phvt" "drawing") refShape nw)
            dbLayerAndNot(cv list("Nhvt" "drawing") refShape nw)
            mapcar('dbDeleteObject refShape)
        else
            refShape~>lpp = list("Nhvt" "drawing")
        )
        dbSave(cv)
        dbClose(cv)
    )
)



