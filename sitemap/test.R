regex <- regex %>% mapedit:::combine_list_of_sf(~st_read(.,as_tibble=TRUE))

require(whisker)
require(httr)
tpl <- '
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
 {{#links}}
   <url>
      <loc>{{{loc}}}</loc>
   </url>
 {{/links}}
</urlset>
'

links <- c("http://r-statistics.com", "http://www.r-statistics.com/on/r/", "http://www.r-statistics.com/on/ubuntu/")


map_links <- function(l) {
 # tmp <- GET(l)
 # d <- tmp$headers[['last-modified']]
  
  list(loc=l)
}

links <- lapply(links, map_links)

cat(whisker.render(tpl))