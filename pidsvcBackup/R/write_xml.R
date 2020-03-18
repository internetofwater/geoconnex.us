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

    if(grepl("https://geoconnex.us", r$id[1])) {
      r$id <- gsub("https://geoconnex.us", "", r$id)
    }

    conditions <- NULL

    conditions_data <- r[1, grepl("^c[1-9]", names(r))]

    if(!ncol(conditions_data) %% 3 == 0) stop("must pass multiple of 3 columns of conditions")

    if(ncol(conditions_data) > 0) {
      conditions <- lapply(seq_len((ncol(conditions_data)) / 3),
                           function(x, cd) {
                             col <- (x - 1) * 3 + 1
                             c(cd[1, col], cd[1, col + 1], cd[1, col + 2])
                           }, cd = conditions_data)
    }

    make_mapping(r$id, r$target, r$creator, r$description,
                 conditions = conditions)
  }, in_d = in_d)


  attr(out_xml, "xmlns") <- "urn:csiro:xmlns:pidsvc:backup:1.0"

  out_xml <- list(backup = out_xml)

  out_xml <- xml2::as_xml_document(out_xml)

  xml2::write_xml(out_xml, out_f)

  return(invisible(out_f))
}
