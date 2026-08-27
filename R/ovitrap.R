# generic methods for oviposition traps

#' @title Methods for oviposition traps
#' @description This method dispatches on the type of `xds_obj$ovitraps`.
#' @param t current simulation time
#' @param xds_obj a [list]
#' @return [list]
#' @export
#' @keywords internal
OviTraps <- function(t, xds_obj) {
  UseMethod("OviTraps", xds_obj$ovitraps)
}

#' @title Methods for oviposition traps
#' @description Implements [OviTraps] for the none model (do nothing)
#' @inheritParams OviTraps
#' @return [list]
#' @export
#' @keywords internal
OviTraps.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up the none model for oviposition traps (do nothing)
#' @param xds_obj a [list]
#' @return [list]
#' @export
#' @keywords internal
setup_no_ovitraps <- function(xds_obj) {
  ovitraps <- list()
  class(ovitraps) <- 'none'
  xds_obj$ovitraps <- ovitraps
  return(xds_obj)
}
