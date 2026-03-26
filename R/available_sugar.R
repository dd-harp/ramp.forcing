
#' @title Update the availability of sugar
#' @description This method dispatches on the type of `xds_obj$SUGAR`.
#' @param xds_obj an [list]
#' @return a [list]
#' @export
AvailableSugar <- function(xds_obj) {
  UseMethod("AvailableSugar", xds_obj$SUGAR)
}

#' @title Compute total availability of sugar
#' @description Computes the availability of sugar for the static model (do nothing)
#' @param xds_obj a [list]
#' @return a [numeric] vector of length `nPatches`
#' @export
AvailableSugar.static <- function(xds_obj){
  return(xds_obj)
}

#' @title Compute total availability of sugar
#' @description Computes the availability of sugar
#' @param xds_obj a [list]
#' @return a [numeric] vector of length `nPatches`
#' @export
AvailableSugar.forced <- function(xds_obj){
  xds_obj$S = xds_obj$nectar + xds_obj$sugar_baits
  return(xds_obj)
}
