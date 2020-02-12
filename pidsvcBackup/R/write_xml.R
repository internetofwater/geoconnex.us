#' write PID Service Backup XML
#' @description Given an input file csv (or geojson when implemented)
#' will write an XML "backup" file suitable for upload to a PID Service.
#' @param in_f character path to input file
#' @param out_f character path to output file
#' @param root character URI of PID service root
#' @return returns out file path invisibly
#' @export
write_xml <- function(in_f, out_f, root = "https://geoconnex.us") {
  in_f <- read.csv(in_f, stringsAsFactors = FALSE)

  out_xml <- lapply(seq_len(nrow(in_f)), function(i, in_f) {

    r <- in_f[i, ]

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
  }, in_f = in_f)

  out <- list(backup = out_xml)
  doc <- xml2::as_xml_document(out)

  xml2::write_xml(doc, out_f)

  return(invisible(out_f))
}
