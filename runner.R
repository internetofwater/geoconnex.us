library(tidyverse)
library(pidsvcBackup)
library(httr)


gather_explicit <-  


explicit <- do.call("bind_rows",
                    lapply(list.files(
                       path="./namespaces",
                       pattern=".csv",
                       recursive=TRUE,
                       full.names=TRUE),
                       FUN=function(files){read_csv(files, col_types = cols(.default = "c"))}
                    )
            )

explicit$X1<-NULL
                    
            

regex <- list.files(path="./namespaces",
                    pattern=".xml",
                    recursive=TRUE,
                    full.names=TRUE
                    )



