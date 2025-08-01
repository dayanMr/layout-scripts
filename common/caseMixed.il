
defun(checkNamingConventions (cv ruleObject)
    let((obj label netTable signals sigTable)
      sigTable=makeTable('sigTable nil)
      netTable=makeTable('netTable nil)
      foreach(sig cv~>signals
          sigTable[lowerCase(sig~>name)]=cons(sig sigTable[lowerCase(sig~>name)])
      );foreach
      foreach(tableEntry sigTable
          signals=sigTable[tableEntry]
          when(cdr(signals)
              foreach(sig signals
                  foreach(memNet sig~>memNets
                      netTable[car(memNet)]=signals
                  )
              )
          );when
       );foreach
       foreach(net netTable
           cond(
                (net~>term~>pins
                     obj=car(net~>term~>pins~>fig))
                (obj=car(exists(shape net~>figs
                     shape~>objType=="label"))
                     t
                )
                (obj=car(exists(shape net~>figs
                     shape~>objType="line" || shape~>objType=="path"))
                     t
                )
                (t
                     obj=cv
                )
        );cond
         schReportCheckFailure(
             ?object obj
             ?checkRule ruleObject
             ?short "Net differing only in case"
             ?message sprintf(nil "Net %L cannot differ only in case from others: %L" net~>name netTable[net]~>name)
         )
     );foreach
   );let
);defun

schRegisterCheckGroup(?name 'CustomChecks ?title "Ucun custom") 
schRegisterCheckRule(
        ?title "Naming conventions"
        ?name 'namingConventions
        ?groupName 'CustomChecks
        ?severity `error
        ?checkCB 'checkNamingConventions
)


