# Methods to set up variables describing exogenous forcing by other blood hosts

#' @title Set the values of exogenous variables describing other blood hosts
#' @description This method dispatches on the type of `xds_obj$OTHER_BLOOD`.
#' @param t current simulation time
#' @param xds_obj a [list]
#' @return [list]
#' @export
OtherBloodHosts <- function(t, xds_obj) {
  UseMethod("OtherBloodHosts", xds_obj$OTHER_BLOOD)
}

#' @title Set the values of exogenous variables describing other blood hosts
#' @description Implements [OtherBloodHosts] for the static model of other_blood_hosts (do nothing)
#' @inheritParams OtherBloodHosts
#' @return [list]
#' @export
OtherBloodHosts.static <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Make parameters for the static model for other blood hosts (do nothing)
#' @param xds_obj a [list]
#' @param Other the availability of other blood hosts
#' @return [list]
#' @export
setup_other_blood_hosts_static <- function(xds_obj, Other=0) {
  OTHER_BLOOD <- list()
  class(OTHER_BLOOD) <- 'static'
  xds_obj$vars$Other[[1]] = Other
  xds_obj$OTHER_BLOOD <- OTHER_BLOOD
  return(xds_obj)
}

