#' write PID Service Backup XML
#' @description Given an input file csv (or geojson when implemented)
#' will write an XML "backup" file suitable for upload to a PID Service.
#' @param in_f character path to input file
#' @param out_f character path to output file
#' @param root character URI of PID service root
#' @return returns out file path invisibly
#' @export
write_xml <- function(in_f, out_f, root = "https://geoconnex.us") {
  in_d <- try(read.csv(in_f, stringsAsFactors = FALSE), silent = TRUE)
  if(is(in_d, "try-error")) in_d <- try(sf::read_sf(in_f), silent = TRUE)

  if(is(in_d, "try-error")) stop("must pass a file compatible with read.csv or sf::read_sf")

  if(is(in_d, "sf")) in_d <- sf::st_drop_geometry(in_d)

  out_xml <- lapply(seq_len(nrow(in_d)), function(i, in_d) {

    r <- in_d[i, ]

    if(grepl("https://geoconnex.us", r[1, 1])) {
      r[1, 1] <- gsub("https://geoconnex.us", "", r[1, 1])
    }

    conditions <- NULL

    if(ncol(r) > 4) {
      conditions <- lapply(seq_len((ncol(r) - 4) / 3),
                           function(x, r) {
                             col <- 5 + (x - 1) * 3
                             c(r[1, col], r[1, col + 1], r[1, col + 2])
                           }, r = r)
    }

    make_mapping(r[1, 1], r[1, 2], r[1, 3], r[1, 4],
                 conditions = conditions)
  }, in_d = in_d)


  attr(out_xml, "xmlns") <- "urn:csiro:xmlns:pidsvc:backup:1.0"

  out_xml <- list(backup = out_xml)

  out_xml <- xml2::as_xml_document(out_xml)

  xml2::write_xml(out_xml, out_f)

  return(invisible(out_f))
}
