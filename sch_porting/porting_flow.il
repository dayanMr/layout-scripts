load "./replacePDKLib.il"
load "./copyLib.il"

copyLib("scr_SCH" "dest_SCH")
copyLib("scr_component" "dest_component")
replaceInstLib("dest_SCH" "scr_SCH" "dest_SCH")
replaceInstLib("dest_SCH" "scr_component" "dest_component")
porting_PDK("dest_SCH")
