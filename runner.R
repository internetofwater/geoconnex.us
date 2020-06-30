library(tidyverse)
library(pidsvcBackup)
library(httr)
library(xml2)

batch_size=500
root<-"https://test.geoconnex.us"
root2<-"https://geoconnex.us"

explicit <- do.call("bind_rows",
                    lapply(list.files(
                       path="./namespaces/CHyLD",
                       pattern=".csv",
                       recursive=TRUE,
                       full.names=TRUE),
                       FUN=function(files){read_csv(files, col_types = cols(.default = "c"))}
                    )
            )


explicit <- explicit %>% mutate(grp = floor((row_number()-1)/batch_size))


data_split <- split(explicit, list(explicit$grp))

for (grp in names(data_split)){

  d2 <- data_split[[grp]]
  d2$grp<-NULL
  write_csv(d2,path="temp.csv")
  print(paste0(grp," is csv'd"))
  pidsvcBackup::write_xml(in_f="temp.csv", out_f="temp.xml", root=root2)
  print(paste0(grp," is xml'd"))
  post_pids(in_f="temp.xml", user="iow", password="nieps", root=root)
  print(paste0(grp," is pidsvc'd"))
  unlink("temp.csv")
  unlink("temp.xml")
}




