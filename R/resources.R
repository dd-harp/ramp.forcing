
#' @title Modify resources and resource availability
#' @description Implements [Resources] for the static model of resources
#' @inheritParams Resources
#' @return none
#' @export
Resources.setup <- function(t, pars) {

  pars = Visiting(t, pars)
  pars = OtherBloodHosts(t, pars)
  pars = HabitatDynamics(t, pars)
  pars = SugarDynamics(t, pars)
  pars = AvailableSugar(pars)

  class(pars$RESOURCES) <- "static"

  return(pars)
}

#' @title Methods for resources
#' @description Implements [Resources]
#' @inheritParams Resources
#' @return [list]
#' @export
Resources.forced <- function(t, pars) {

  pars = OtherBloodHosts(t, pars)
  pars = SugarDynamics(t, pars)
  pars <- AvailableSugar(pars)

  return(pars)
}

#' @title Set up parameters for the static model for resource availability
#' @param pars a [list]
#' @return none
#' @export
setup_resources_forced <- function(pars){
  RESOURCES <- list()
  class(RESOURCES) <- 'forced'
  pars$RESOURCES <- RESOURCES

  pars <- setup_visitors_static(pars)
  pars <- setup_other_blood_hosts_static(pars)
  pars <- setup_habitat_dynamics_static(pars)
  pars <- setup_sugar_static(pars)

  return(pars)
}


#' @title Modify resources and resource availability
#' @description Implements [Resources] for the static model of resources
#' @inheritParams Resources
#' @return none
#' @export
Resources.setup <- function(t, pars) {

  pars = Visiting(t, pars)
  pars = OtherBloodHosts(t, pars)
  pars = HabitatDynamics(t, pars)
  pars = SugarDynamics(t, pars)
  pars = AvailableSugar(pars)

  class(pars$RESOURCES) <- "static"

  return(pars)
}
