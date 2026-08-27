
#' @title Dynamic Resources
#'
#' @description Compute availability of resources affecting adult mosquito
#' bionomics: blood hosts, aquatic habitats, traps, and sugar.
#' This is the dynamic implementation of the [ramp.xds::Resources] junction.
#'
#' + [OtherBloodHosts] availability of alternative blood hosts
#' + [HabitatDynamics] to modify habitat search weights
#' + [Traps] to compute availability of oviposition traps
#' + [Sugar] availability of sugar
#'
#' @param t the time
#' @param y the state variables
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
#' @seealso [dynamic_resources]
Resources.dynamic = function(t, y, xds_obj){
  xds_obj <- OtherBloodHosts(t, y, xds_obj)
  xds_obj <- HabitatDynamics(t, y, xds_obj)
  xds_obj <- Traps(t, y, xds_obj)
  xds_obj <- Sugar(t, y, xds_obj)
  return(xds_obj)
}

#' @title Set up dynamic resources
#'
#' @description Activates dynamic resource computation and initializes
#' the sub-junctions for blood hosts, habitat dynamics, traps, and sugar
#' with their `none` (no-op) defaults. Use the individual setup functions
#' (e.g., [setup_blood_host_object], [setup_traps_object]) to configure
#' specific ports.
#'
#' @param xds_obj an **`xds`** model object
#' @return an **`xds`** object
#' @keywords internal
#' @export
dynamic_resources = function(xds_obj){
  UseMethod("dynamic_resources", xds_obj$resources_obj)
}

#' @title Set up dynamic resources (none -> dynamic)
#' @description Transitions from the default `none` class to `dynamic`,
#' and initializes the sub-junction objects with `none` (no-op) defaults.
#' @param xds_obj an **`xds`** model object
#' @return an **`xds`** object
#' @keywords internal
#' @export
dynamic_resources.none = function(xds_obj){
  resources <- 'dynamic'
  class(resources) <- 'dynamic'
  xds_obj$resources_obj <- resources
  xds_obj <- setup_blood_host_object(xds_obj)
  xds_obj <- setup_habitat_object(xds_obj)
  xds_obj <- setup_traps_object(xds_obj)
  xds_obj <- setup_sugar_object(xds_obj)
  return(xds_obj)
}

#' @title Set up dynamic resources (already dynamic)
#' @description No-op when resources are already dynamic.
#' @param xds_obj an **`xds`** model object
#' @keywords internal
#' @return an **`xds`** object
#' @export
dynamic_resources.dynamic = function(xds_obj){
  return(xds_obj)
}

