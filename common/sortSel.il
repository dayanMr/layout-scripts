procedure(sortSel()
	let((nets listEven listOdd )
	nets=geGetSelSet()
	nets=leMergeShapes(nets)
	if(leftEdge(car(nets)~>bBox)!=leftEdge(cadr(nets)~>bBox) && bottomEdge(car(nets)~>bBox)==bottomEdge(cadr(nets)~>bBox) then
		nets=sort(nets lambda((a b) leftEdge(a~>bBox)<leftEdge(b~>bBox)));vertical nets, left to right
		);
	if(leftEdge(car(nets)~>bBox)==leftEdge(cadr(nets)~>bBox) && bottomEdge(car(nets)~>bBox)!=bottomEdge(cadr(nets)~>bBox) then
		nets=sort(nets lambda((a b) bottomEdge(a~>bBox)<bottomEdge(b~>bBox)))	;horizontal nets, bottom to top
		);
		listEven=setof(x nets evenp(length(member(x reverse(nets)))))
		listOdd=setof(x nets oddp(length(member(x reverse(nets)))))

		if(remove(nil geGetSelSetFigPoint(car(listOdd)))=='(t)	then
				foreach(i listEven
					geDeselectFig(i)
					)
			else
				foreach(i listOdd
					geDeselectFig(i)
					)
		else
				foreach(i listOdd
					geDeselectFig(i)
					)
			else
				foreach(i listEven
					geDeselectFig(i)
					)
		);if
	);let
);procedure
hiSetBindKey("Layout" "Ctrl<Key>x" "sortSel()")
