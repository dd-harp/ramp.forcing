
#' @title Setup the Blood Hosts Object
#'
#' @description
#'
#' Setup the object to handle
#' other blood hosts -- potential blood hosts
#' that are not hosts for the pathogen
#'
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_blood_host_object = function(xds_obj){
  blood <- list()
  Fbl <- F_zero
  class(Fbl) <- "na"
  blood$F_blood_host<- Fbl
  xds_obj$XY_interface$blood_host_obj <- list()
  xds_obj$XY_interface$blood_host_obj[[1]] <- blood
  class(xds_obj$XY_interface$blood_host_obj) <- "setup"
  xds_obj$XY_interface$other_blood_hosts = list()
  xds_obj$XY_interface$other_blood_hosts[[1]] = rep(0, xds_obj$nPatches)
  return(xds_obj)
}

#' @title Blood Hosts (static)
#' @description For a static model for blood hosts, the function
#' does not update anything.
#' @inheritParams OtherBloodHosts
#' @return an **`xds`** object
#' @keywords internal
#' @export
OtherBloodHosts.static <- function(t, y, xds_obj) {
  return(xds_obj)
}

#' @title Blood Hosts (setup)
#' @description Sets a static value for blood host availability, resets the class
#' to `static`, and triggers an update to the blood feeding model.
#' @inheritParams OtherBloodHosts
#' @return an **`xds`** object
#' @keywords internal
#' @export
OtherBloodHosts.setup <- function(t, y, xds_obj) {
  class(xds_obj$XY_interface$blood_host_obj) <- "static"
  xds_obj$XY_interface <- trigger_setup(xds_obj$XY_interface)
  xds_obj <- blood_hosts_dynamics(t, y, xds_obj)
  return(xds_obj)
}

#' @title Blood Hosts (dynamic)
#' @description Dynamically updates blood host availability.
#' @inheritParams OtherBloodHosts
#' @return an **`xds`** object
#' @keywords internal
#' @export
OtherBloodHosts.dynamic <- function(t, y, xds_obj) {
  return(blood_hosts_dynamics(t, y, xds_obj))
}

#' @title blood_hosts Dynamics
#'
#' @description Compute and update blood host availability on the `XY_interface`.
#'
#' @param t current time
#' @param y the state variable vector
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
blood_hosts_dynamics <- function(t, y, xds_obj){
  for(s in 1:xds_obj$nVectorSpecies){
    F_blood <- xds_obj$XY_interface$blood_host_obj[[s]]$F_blood_host
    V <- get_variables(t, y, F_blood, xds_obj)
    xds_obj$XY_interface$other_blood_hosts[[s]] <- F_blood(t, V)
  }
  return(xds_obj)
}

#' @title Set up blood hosts model
#'
#' @description Setup a model for blood host availability.
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a list to configure `F_blood_host`
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_blood_hosts = function(mod_name, xds_obj, s, options){
  class(mod_name) = mod_name
  UseMethod("setup_blood_hosts", mod_name)
}

#' @title Set up blood hosts model (ts_func)
#'
#' @description Setup a time series function for blood host availability.
#'
#' @inheritParams setup_blood_hosts
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_blood_hosts.ts_func = function(mod_name, xds_obj, s, options){
  class(xds_obj$XY_interface$blood_host_obj) <- 'dynamic'
  class(xds_obj$XY_interface) <- 'dynamic'
  class(xds_obj$terms$beta) <- 'dynamic'
  FF <- make_ts_function(options)
  FF -> xds_obj$XY_interface$blood_host_obj[[s]]$F_blood_hosts
  return(xds_obj)
}

