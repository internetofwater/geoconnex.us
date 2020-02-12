#' Make mapping
#' @param path character fully qualified PID
#' @param target character target of 303 redirect
#' @param creator character email of creator
#' @param type character type of redirect, "1:1"
#' @param description character description to include
#' @param action character action of redirect, "303"
#' @param action_name character name of action, "location"
#' @param conditions list of charactor vectors containing
#' type, match, and value for make_condition
#' @noRd
make_mapping <- function(path, target, creator,
                         description = "",
                         type = "1:1",
                         action = "303",
                         action_name = "location",
                         conditions = NULL) {
  out <- list(mapping = list(path = list(path),
                             type = list(type),
                             description = list(description),
                             creator = list(creator),
                             action = list(type = list(action),
                                           name = list(action_name),
                                           value = list(target))))
  if(!is.null(conditions)) {
    out[["mapping"]][["conditions"]] <- lapply(conditions, function(x) {
      make_condition(x[1], x[2], x[3])
    })
  }

  out

}

#' For query parameters,
#' `"f?=.*&callback?=.*&_?=.*"` "?f=${C:f:1}&callback=${C:callback:1}&_=${C:_:1}"
#' @param type character "Extension" or "QueryString"
#' @param match character e.g. `"^json$"`
#' @param value character full URL to redirect to.
#' @noRd
make_condition <- function(type, match, value,
                              action = "303",
                              action_name = "location") {
  conditions =
    list(condition =
           list(type = list(type),
                match = list(match),
                actions = list(action =
                                 list(type = list(action),
                                      name = list(action_name),
                                      value = list(value)))))
}
