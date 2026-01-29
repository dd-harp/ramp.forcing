# generic methods for parasite / pathogen importation by visitors

#' @title Visiting
#' @description This method dispatches on the type of `xds_obj$VISITORS`.
#' @param t current simulation time
#' @param xds_obj a [list]
#' @return a [list]
#' @noRd
#' @export
Visiting <- function(t, xds_obj) {
  UseMethod("Visiting", xds_obj$VISITORS)
}

#' @title Visiting, a static model
#' @description Implements [Visiting] for the static model (do nothing)
#' @inheritParams Visiting
#' @return a [list]
#' @noRd
#' @export
Visiting.static <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Make parameters for the static model visitors (no visitors)
#' @param xds_obj a [list]
#' @return [list]
#' @noRd
#' @export
setup_visitors_static <- function(xds_obj) {

  VISITORS <- list()
  class(VISITORS) <- "static"
  xds_obj$VISITORS <- VISITORS

  return(xds_obj)
}


#' @title Visiting, the basic model
#' @description Implements [Visiting] for the basic model for Visitors
#' @inheritParams Visiting
#' @return a [list]
#' @noRd
#' @export
Visiting.basic <- function(t, xds_obj) {
  xds_obj$vars$x_visitors =  with(xds_obj$VISITORS, x_scale*xt(t, xds_obj))
  xds_obj$vars$Visiting =  with(xds_obj$VISITORS, V_scale*Vt(t, xds_obj))
  return(xds_obj)
}

#' @title Make parameters and functions for the basic model for visitors
#' @param xds_obj a [list]
#' @param IMopts a [list]
#' @param x_scale a non-negative numeric value to set the mean for x_visitors
#' @param xt a function to change the pattern for x_visitors over time
#' @param V_scale a non-negative numeric value to set the mean availability of Visiting
#' @param Vt a function to set the temporal pattern for availability of Visiting
#' @return [list]
#' @export
setup_visitors_basic <- function(xds_obj, IMopts, x_scale = 0, xt = NULL, V_scale = 0, Vt = NULL) {with(IMopts,{

  xds_obj$VISITORS$x_scale = x_scale
  if(is.null(xt)) xt = function(t, xds_obj){1}
  xds_obj$VISITORS$xt = xt

  xds_obj$VISITORS$V_scale = V_scale
  if(is.null(Vt)) Vt = function(t, xds_obj){1}
  xds_obj$VISITORS$Vt = Vt

  return(xds_obj)
})}
