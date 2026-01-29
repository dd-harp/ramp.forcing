
#' @title Modify resources and resource availability
#' @description Implements [Resources] for the static model of resources
#' @inheritParams ramp.xds::Resources
#' @return an **`xds`** object
#' @noRd
#' @export
Resources.setup <- function(t, xds_obj) {

  xds_obj = Visiting(t, xds_obj)
  xds_obj = OtherBloodHosts(t, xds_obj)
  xds_obj = HabitatDynamics(t, xds_obj)
  xds_obj = SugarDynamics(t, xds_obj)
  xds_obj = AvailableSugar(xds_obj)

  class(xds_obj$RESOURCES) <- "static"

  return(xds_obj)
}

#' @title Methods for resources
#' @description Implements [Resources]
#' @inheritParams ramp.xds::Resources
#' @return an **`xds`** object
#' @noRd
#' @export
Resources.forced <- function(t, xds_obj) {

  xds_obj = OtherBloodHosts(t, xds_obj)
  xds_obj = SugarDynamics(t, xds_obj)
  xds_obj <- AvailableSugar(xds_obj)

  return(xds_obj)
}

#' @title Set up parameters for the static model for resource availability
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @noRd
#' @export
setup_resources_forced <- function(xds_obj){
  RESOURCES <- list()
  class(RESOURCES) <- 'forced'
  xds_obj$RESOURCES <- RESOURCES

  xds_obj <- setup_visitors_static(xds_obj)
  xds_obj <- setup_other_blood_hosts_static(xds_obj)
  xds_obj <- setup_habitat_dynamics_static(xds_obj)
  xds_obj <- setup_sugar_static(xds_obj)

  return(xds_obj)
}

