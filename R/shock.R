
#' @title System Shocks
#' @description Set the value of exogenous variables related to
#' systemic shocks
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
#' @keywords internal
Shock <- function(t, xds_obj) {
  UseMethod("Shock", xds_obj$shock)
}

#' @title Set no shock
#' @description The null model for shock
#' @inheritParams Shock
#' @return an **`xds`** object
#' @export
#' @keywords internal
Shock.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up "no shock"
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_no_shock <- function(xds_obj) {
  shock <- 'none'
  class(shock) <- 'none'
  xds_obj$shock <- shock
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param name the name of a model to set up
#' @param xds_obj an **`xds`** object
#' @param opts a list of options to override defaults
#'
#' @keywords internal
#'
#' @return an **`xds`** object
#' @export
setup_shock = function(name, xds_obj, opts=list()){
  class(name) <- name
  UseMethod("setup_shock", name)
}

#' @title Set no shock
#' @description The null model for shock
#' @inheritParams Shock
#'
#' @keywords internal
#'
#' @return an **`xds`** object
#' @export
Shock.func <- function(t, xds_obj) {
  #xds_obj = F_shock(t, xds_obj)
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @inheritParams setup_shock
#'
#' @keywords internal
#'
#' @return an **`xds`** object
#' @export
setup_shock.func = function(name="func", xds_obj, opts=list()){
  xds_obj <- dynamic_forcing(xds_obj)
  xds_obj = setup_shock_func(xds_obj, opts())
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#'
#' @param xds_obj an **`xds`** object
#' @param opts a list of options to override defaults
#' @param eventT the time when a shock occurs
#' @param F_shock the effects of the shock
#'
#' @return an **`xds`** object
#'
#' @keywords internal
#
#' @export
#' @keywords internal
setup_shock_func = function(xds_obj, opts=list(), eventT=365, F_shock=NULL){
  shock <- list()
  class(shock) <- 'func'
  shock$eventT = eventT
  shock$F_shock = F_shock
  xds_obj$shock <- shock
  return(xds_obj)
}

