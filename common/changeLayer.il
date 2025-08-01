procedure( ChangeLayer()
           let( ( ToMetal )
                ToMetal = leGetEntryLayer()
                leReplace(geGetEditCellView(getCurrentWindow()) geGetSelSet() list(list("layer" nil ToMetal)))
              );let
         );proc
hiSetBindKey("Layout" "Super<Key>`" "ChangeLayer()" )
