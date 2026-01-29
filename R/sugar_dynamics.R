# Methods to set up variables describing exogenous forcing by sugar

#' @title Set the values of exogenous variables describing sugar
#' @description This method dispatches on the type of `xds_obj$SUGAR`.
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @noRd
#' @export
SugarDynamics <- function(t, xds_obj) {
  UseMethod("SugarDynamics", xds_obj$SUGAR)
}

#' @title Set the values of exogenous variables describing sugar
#' @description Implements [SugarDynamics] for the static model of sugar (do nothing)
#' @inheritParams SugarDynamics
#' @return an **`xds`** object
#' @noRd
#' @export
SugarDynamics.static <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Make parameters for the static model for sugar (do nothing)
#' @param xds_obj an **`xds`** object
#' @param Sugar describes sugar availability
#' @return an **`xds`** object
#' @export
setup_sugar_static <- function(xds_obj, Sugar=0) {
  SUGAR <- list()
  class(SUGAR) <- 'static'
  xds_obj$SUGAR <- SUGAR
  xds_obj$vars$Sugar = Sugar
  return(xds_obj)
}


