procedure(myToolBar()
	let((act1 act2 act3 act4)
		if(!boundp('tbar) then
		act1 = hiCreateAction(
			?name		'act1
			?iconText	"Loaddrf"
			?callback	"drLoadDrf(\"./display.drf\")"
			)
		act2 = hiCreateAction(
			?name		'act2
			?iconText	"align first"
			?callback	"leHiQuickAlign()"
			)
		act3 = hiCreateAction(
			?name		'act3
			?iconText	"autoVia"
			?callback	"autoVia()"
			)
		act4 = hiCreateAction(
			?name		'act4
			?iconText	"cancelProp"
			?callback	"geiPlInvokePlistAction(\"editorNum0\" \"cancel\")"
			)
		tbar = hiCreateToolbar(
			?name	'tbar
			?title	"Test bar"
			?items	list(act1 act2 act3 act4 )
			)
		)
		tbar
	)
)
procedure(addToolBar(@optional arg(list(nil 'window hiGetCurrentWindow())))
    prog((win)
        win = arg->window
       hiPlaceToolbar(win myToolBar() 'top)
	   hiShowToolbar(myToolBar())
    )
)

deRegUserTriggers("maskLayout"  nil nil 'addToolBar)
deRegUserTriggers("maskLayoutXL"  nil nil 'addToolBar)
	
;viewType = "maskLayoutXL" || "maskLayout"
;when(appInfo = deGetAppInfo(viewType)
procedure(autoVia()
	leHiCreateVia()
	hiiToggleEnterForm()
	le0ViaForm->viaMode->value="Auto"
	le0ViaForm->globalCutClassAuto->value="square"
	hiiToggleEnterForm(le0ViaForm)
	)
procedure(CCSRegProc(args)
	hiRegTimer("CCSSetDefVia(args->window)" 5)
	leHiCreateVia()
	) ;proc
procedure(CCSSetDefVia(window)
	let((cv cstG currCG techId validVias)
		cancelEnterFun('le0ViaForm)
		cv=geGetWindowCellView(window)
		if(envGetVal("layout" "viaConstraintGroup")=="Same as Wire" then
			currCG=envGetVal("layout" "wireConstraintGroup")
		else
			currCG=envGetVal("layout" "viaConstraintGroup")
		) ;if
		techId=techGetTechFile(cv)
			cstG=cstFindConstraintGroupIn(techId currCG)
			validVias=car(setof(x cstG~>objects x~>defName=="validVias"))~>value
			if(member("M2_M1" validVias) then
			;le0ViaForm->viaSingleModeScrollView->viaDefName->value="M2_M1"
			le0ViaForm->viaMode->value="Auto"
			le0ViaForm->globalCutClassAuto->value="square"
		) ;if
	) ;let
) ;procedure
deRegUserTriggers("maskLayout" nil nil 'CCSRegProc)
deRegUserTriggers("maskLayoutXL" nil nil 'CCSRegProc)
;hiSetBindKey("Layout" "<Key>1" "CCSSetDefVia(hiGetCurrentWindow()) leHiCreateVia()")
