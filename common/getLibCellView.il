procedure(getLibCellView()
		let((Lib Cell View )
			if(!boundp('myForm) then 

				Lib = ddHiCreateLibraryComboField(
  					?name      'myLib
  					?prompt    "Library"
  					?callback  "hiGetCurrentForm()~>myCell~>items=ddGetObj(hiGetCurrentForm()~>myLib~>value)~>cells~>name"
					)

				Cell = hiCreateComboField(
 					 ?name      'myCell
  					 ?prompt    "Cell"
					 ?callback  "hiGetCurrentForm()~>myView~>items=ddGetObj(hiGetCurrentForm()~>myLib~>value hiGetCurrentForm()~>myCell~>value)~>views~>name"
					)

				View = hiCreateComboField(
  					?name      'myView
  					?prompt    "View"      
					)

				myForm = hiCreateAppForm(
 					 ?name      'myForm
 					 ?formTitle "My Form"
  					 ?fields    list(
               			 list( Lib  20:10  317:10 57 )
                		list( Cell 20:40  317:10 57 )
                		list( View 20:70  317:10 57 )
                		)
				);end-create form
				);if
				hiDisplayForm('myForm)
			);let
		);proc
