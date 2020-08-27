library(tidyverse)
library(whisker)
library(sf)
library(nhdplusTools)
library(mapedit)
library(xml2)

# Start by retrieving list of HUC12 codes, which are used as part of multiple regex redirects
# nhdplusTools::download_wbd(outdir= "wbd", url = "https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/WBD/National/GDB/WBD_National_GDB.zip")
# hu12 <- sf::read_sf("wbd/WBD_National_GDB.gdb", "WBDHU12")
# hu12 <- hu12$huc12
# write.csv(hu12,"hu12.csv")
# unlink("wbd",recursive=TRUE)

hu12 <- read_csv("hu12.csv") %>% select(x)

### Collate all csv
csv <- 
  list.files(path="../namespaces",full.names = TRUE,pattern=".csv",recursive=TRUE) %>%
  map_df(~read_csv(.,col_types=cols(.default="c"))) %>% select(id)
      

### List regex PIDs geospatial file locations
regexlist <- list(
             "https://www.hydroshare.org/resource/5f665b7b82d74476930712f7e423a0d2/data/contents/wade_sites.gpkg", # WaDE
             "https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/hu10.gpkg", # HUC 10
             "https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/ref_gages.gpkg", # Reference Gages
             "http://wells.newmexicowaterdata.org/collections/nmbgmr_wells/items?f=json&limit=1000000", # NMWDI NMBGMR Wells
             "http://wells.newmexicowaterdata.org/collections/ose_wells/items?f=json&limit=10000000" # NMWDI OSE Wells
              ) 

#read, select only uris, and combine
regex <- lapply(
  regexlist,
  function(x)
  { 
    y <- 
      st_read(x) %>% 
      st_drop_geometry() %>% 
      select(uri)
  }
) %>% 
  map_dfr(~.)

### Make uri lists for HUC12-based regex redirects

huc12s <- list(
  "https://geoconnex.us/nhdplusv2/huc12/", # NLDI HUC12
  "https://geoconnex.us/epa/hmw/" # EPA HMW pages
) %>%
  paste0(.,hu12$x) %>%
  as.data.frame()

### Collate all
csv$uri <- csv$id
huc12s$uri<-huc12s$.

sitelist <- list(
  csv,
  huc12s,
  regex
)


sites <- (bind_rows(sitelist)%>%select(uri))
sites <- sites$uri

### Write sitemap xml
nodes <- '
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
 {{#s}}
   <url>
      <loc>{{{loc}}}</loc>
   </url>
 {{/s}}
</urlset>
'

map_sites <- function(sites) {
  list(
    loc=sites
  )
}

site_nodes <- lapply(sites, map_sites)
site_nodes <- split(site_nodes,ceiling(seq_along(site_nodes)/50000))

for (i in 1:length(site_nodes)){
  s <- site_nodes[[i]]
  sitemap <- whisker.render(nodes)
  write_lines(sitemap,paste0("xml/sitemap",i,".xml"))
}


## Write sitemap index

index <- '
<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
 {{#s}}
   <sitemap>
      <loc>{{{loc}}}</loc>
   </sitemap>
 {{/s}}
</sitemapindex>
'

map_sitemaps <- function(maps) {
  list(
    loc=maps
  )
}

maps <- list.files(path="../sitemap/xml",pattern=".xml",recursive=TRUE)
maps <- paste0("https://geoconnex.us/sitemaps/",maps)
map_nodes <- lapply(maps, map_sitemaps)

s <- map_nodes
sitemapindex <- whisker.render(index)
write_lines(sitemapindex,paste0("sitemapindex.xml"))
