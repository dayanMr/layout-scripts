procedure(ULabel()
let((objs)
objs = geGetSelSet()
foreach(obj objs
 leAttachFig(obj)
 );
 );
 );
 hiSetBindKey("Layout" "<Key>@" "ULabel()")
