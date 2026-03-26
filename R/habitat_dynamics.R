# Methods to set up variables describing exogenous forcing by habitat_dynamics

#' @title Habitat Dynamics and Searching
#' @description Set the values of habitat search weights and other exogenous variables describing habitat_dynamics. This method dispatches on the type of `xds_obj$HABITAT_DYNAMICS`.
#' @param t current simulation time
#' @param xds_obj a [list]
#' @return [list]
#' @export
HabitatDynamics <- function(t, xds_obj) {
  UseMethod("HabitatDynamics", xds_obj$HABITAT_DYNAMICS)
}

#' @title Set the values of habitat search weights and other exogenous variables describing habitat_dynamics
#' @description Implements [HabitatDynamics] for the static model of habitat_dynamics (do nothing)
#' @inheritParams HabitatDynamics
#' @return [list]
#' @export
HabitatDynamics.static <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Setup the egg laying object
#' @description Sets up the egg-deposition matrix calU for the s^th species
#' @param xds_obj the model object
#' @return a [list] vector
#' @export
setup_habitat_dynamics_static = function(xds_obj){
  up <- list()
  class(up) <- "static"
  xds_obj$HABITAT_DYNAMICS <- up
  return(xds_obj)
}
