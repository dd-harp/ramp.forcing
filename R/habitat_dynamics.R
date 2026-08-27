
#' @title Habitat Dynamics
#'
#' @description Junction that modifies search weights for
#' habitats and availability of bad habitat.
#' Activated by [dynamic_resources].
#'
#' @param t current simulation time
#' @param y state variables
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @export
#' @keywords internal
HabitatDynamics <- function(t, y, xds_obj) {
  UseMethod("HabitatDynamics", xds_obj$ML_interface$habitat_obj)
}

#' @title HabitatDynamics (none)
#' @description The default no-op for HabitatDynamics. Habitat search weights
#' and bad habitat availability retain their static defaults.
#' @inheritParams HabitatDynamics
#' @return an **`xds`** object
#' @export
#' @keywords internal
HabitatDynamics.none <- function(t, y, xds_obj) {
  return(xds_obj)
}

#' @title Setup the Habitats Object
#'
#' @description
#' During basic setup, the habitats membership
#' matrix is set up.
#'
#' The `habitat_obj` handles:
#' + dynamically changing habitat weights
#' + availability of bad habitats
#' + with multiple vector species, weights can be assigned to bad habitats
#'
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_habitat_object = function(xds_obj){
  habs <- list()
  class(habs) <- "setup"
  Otv <- F_one
  par_Otv = list(name = "F_one")
  Ztv <- F_one
  par_Ztv = list(name = "F_one")

  habs$F_habitat_weights <- Otv
  habs$F_bad_habitat <- Ztv
  habs$F_bad_hab_wts <- Ztv
  xds_obj$ML_interface$habitat_obj <- list()
  class(xds_obj$ML_interface$habitat_obj) <- "setup"
  xds_obj$ML_interface$habitat_obj[[1]] <- habs
  return(xds_obj)
}

#' @title HabitatDynamics (setup)
#' @description Transitions habitat_obj from `setup` to `static` class on
#' the first call, triggering computation of egg-laying matrices.
#' @inheritParams HabitatDynamics
#' @return an **`xds`** object
#' @export
#' @keywords internal
HabitatDynamics.setup<- function(t, y, xds_obj) {
  class(xds_obj$ML_interface$habitat_obj) <- 'static'
  xds_obj$ML_interface <- trigger_setup(xds_obj$ML_interface)
  return(xds_obj)
}

#' @title HabitatDynamics (static)
#' @description No-op for static habitat weights.
#' @inheritParams HabitatDynamics
#' @return an **`xds`** object
#' @export
#' @keywords internal
HabitatDynamics.static <- function(t, y, xds_obj) {
  return(xds_obj)
}

#' @title HabitatDynamics (dynamic)
#' @description Dynamically updates habitat search weights and bad habitat availability.
#' @inheritParams HabitatDynamics
#' @return an **`xds`** object
#' @export
#' @keywords internal
HabitatDynamics.dynamic <- function(t, y, xds_obj) {
  return(habitat_dynamics(t, y, xds_obj))
}

#' @title Habitat Dynamics (internal)
#'
#' @description Compute and update habitat search weights and bad habitat
#' availability on the `ML_interface`.
#'
#' @param t current time
#' @param y state variables
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @importFrom ramp.xds get_variables
#' @export
#' @keywords internal
habitat_dynamics <- function(t, y, xds_obj){
  for(s in 1:xds_obj$nVectorSpecies){

    F_wts <- xds_obj$ML_interface$habitat_obj[[s]]$F_habitat_weights
    V <- get_variables(t, y, F_wts, xds_obj)
    xds_obj$ML_interface$search_weights[[s]] <- F_wts(t, V)

    F_bad <- xds_obj$ML_interface$habitat_obj[[s]]$F_bad_habitat
    V <- get_variables(t, y, F_bad, xds_obj)
    xds_obj$ML_interface$Qbad <- F_bad(t, V)
  }
  return(xds_obj)
}

#' @title Set up no habitats
#'
#' @description Setup a model for no time spent searching
#' and no exposure while searching
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a named list to configure `F_habitat_weights`
#'
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_F_habitat_weights = function(mod_name, xds_obj, s, options){
  class(mod_name) = mod_name
  UseMethod("setup_F_habitat_weights", mod_name)
}

#' @title Setup Bad Habitat Availability
#'
#' @description Setup a the function model for no time spent searching
#' and no exposure while searching
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a list of setup options (see [ramp.func::make_ts_function])
#'
#' @return an **`xds`** object
#' @importFrom ramp.xds F_one
#' @export
#' @keywords internal
setup_F_habitat_weights.static = function(mod_name, xds_obj, s, options=list()){
  F_habitat_weights <- F_one
  class(F_habitat_weights) = "na"
  xds_obj$ML_interface$habitat_obj[[s]]$F_habitat_weights <- F_habitat_weights
  return(xds_obj)
}

#' @title Setup Bad Habitat Availability
#'
#' @description Setup a the function model for no time spent searching
#' and no exposure while searching
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a list of setup options (see [ramp.func::make_ts_function])
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_F_habitat_weights.ts_func = function(mod_name, xds_obj, s, options=list()){
  class(xds_obj$ML_interface$habitat_obj) <- 'dynamic'
  class(xds_obj$ML_interface) <- 'dynamic'
  class(xds_obj$beta) <- 'dynamic'
  F_wts <- make_ts_function(options, N=xds_obj$nHabitats)
  F_wts -> xds_obj$ML_interface$habitat_obj[[s]]$F_habitat_weights
  return(xds_obj)
}

#' @title Set up no habitats
#'
#' @description Setup a model for no time spent searching
#' and no exposure while searching
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a named list to configure `F_bad_habitat`
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_F_bad_habitat = function(mod_name, xds_obj, s, options){
  class(mod_name) = mod_name
  UseMethod("setup_F_bad_habitat", mod_name)
}

#' @title Setup Bad Habitat Availability
#'
#' @description Setup a the function model for no time spent searching
#' and no exposure while searching
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a list of setup options (see [ramp.func::make_ts_function])
#'
#' @return an **`xds`** object
#' @importFrom ramp.xds F_one
#' @keywords internal
#' @export
setup_F_bad_habitat.static = function(mod_name, xds_obj, s, options=list()){
  F_bad_habitats <- F_one
  class(F_bad_habitats) = "na"
  xds_obj$ML_interface$habitat_obj[[s]]$F_bad_habitats <- F_bad_habitats
  return(xds_obj)
}

#' @title Set up no habitats
#'
#' @description Setup a model for no time spent searching
#' and no exposure while searching
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a list of setup options for [ramp.func::make_ts_function]
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_F_bad_habitat.ts_func = function(mod_name, xds_obj, s, options=list()){
  class(xds_obj$ML_interface$habitat_obj) <- 'dynamic'
  class(xds_obj$ML_interface) <- 'dynamic'
  class(xds_obj$beta) <- 'dynamic'
  F_wts <- make_ts_function(options, N=xds_obj$nHabitats)
  F_wts -> xds_obj$ML_interface$habitat_obj[[s]]$F_bad_habitat
  return(xds_obj)
}
