
#' @title Setup the Visitor Sub-Object
#'
#' @description Setup the port sub-object to handle visitor dynamics.
#' Initialises `visitor_obj` on the `XY_interface` and sets static
#' (zero) defaults for `F_visitors` and `F_vis_kappa`.
#'
#' @note The parameters `visitors` and `vis_kappa` are initialised by
#' [ramp.xds::setup_importation_object]; this function only sets up the
#' port machinery.
#'
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_visitor_object = function(xds_obj){
  vis <- list()
  class(vis) <- "setup"
  FtV <- F_zero
  class(FtV) <- "list"
  vis$F_visitors <- FtV
  vis$F_vis_kappa <- FtV
  xds_obj$XY_interface$visitor_obj <- list()
  class(xds_obj$XY_interface$visitor_obj) <- "setup"
  xds_obj$XY_interface$visitor_obj[[1]] <- vis
  return(xds_obj)
}

#' @title Visitors
#'
#' @description Dispatches on `class(xds_obj$XY_interface$visitor_obj)`
#' to update visitor availability and visitor infectiousness.
#'
#' @param t current time
#' @param y the state variable vector
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
Visitors <- function(t, y, xds_obj) {
  UseMethod("Visitors", xds_obj$XY_interface$visitor_obj)
}

#' @title Visitors (static)
#'
#' @description For a static visitors model, the function
#' does not update anything.
#'
#' @inheritParams Visitors
#' @return an **`xds`** object
#' @keywords internal
#' @export
Visitors.static <- function(t, y, xds_obj) {
  return(xds_obj)
}

#' @title Visitors (setup)
#'
#' @description Resets the `visitor_obj` class to `static` and
#' then calls [visitor_dynamics] once.
#'
#' @inheritParams Visitors
#' @return an **`xds`** object
#' @keywords internal
#' @export
Visitors.setup <- function(t, y, xds_obj) {
  class(xds_obj$XY_interface$visitor_obj) <- "static"
  class(xds_obj$XY_interface) <- "setup"
  xds_obj <- visitor_dynamics(t, y, xds_obj)
  return(xds_obj)
}

#' @title Visitors (dynamic)
#'
#' @description Dynamically updates visitor availability and
#' visitor infectiousness.
#'
#' @inheritParams Visitors
#' @return an **`xds`** object
#' @keywords internal
#' @export
Visitors.dynamic <- function(t, y, xds_obj) {
  xds_obj <- visitor_dynamics(t, y, xds_obj)
  return(xds_obj)
}

#' @title Visitor Dynamics
#'
#' @description Computes and updates `visitors` (availability) and
#' `vis_kappa` (infectiousness) on the `XY_interface`.
#'
#' @param t current time
#' @param y the state variable vector
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
visitor_dynamics <- function(t, y, xds_obj){
  for(s in 1:xds_obj$nHostSpecies){
    F_vis <- xds_obj$XY_interface$visitor_obj[[s]]$F_visitors
    V <- get_variables(t, y, F_vis, xds_obj)
    xds_obj$XY_interface$visitors[[s]] <- F_vis(t, V)

    F_vkap <- xds_obj$XY_interface$visitor_obj[[s]]$F_vis_kappa
    V <- get_variables(t, y, F_vkap, xds_obj)
    xds_obj$XY_interface$vis_kappa[[s]] <- F_vkap(t, V)
  }
  return(xds_obj)
}

#' @title Set up the visitors model
#'
#' @description Setup a model for visitor availability.
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a named list to setup `F_visitors`
#'
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_F_visitors = function(mod_name, xds_obj, s, options){
  class(mod_name) = mod_name
  UseMethod("setup_F_visitors", mod_name)
}

#' @title Set up visitor availability as a time series function
#'
#' @description Setup a time series function for visitor availability.
#'
#' @inheritParams setup_F_visitors
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_F_visitors.ts_func = function(mod_name, xds_obj, s, options){
  class(xds_obj$XY_interface$visitor_obj) <- 'dynamic'
  class(xds_obj$XY_interface) <- 'dynamic'
  class(xds_obj$beta) <- 'dynamic'
  Fv <- make_ts_function(options)
  Fv -> xds_obj$XY_interface$visitor_obj[[s]]$F_visitors
  return(xds_obj)
}

#' @title Set up the visitor infectiousness model
#'
#' @description Setup a model for the net infectiousness of visitors.
#'
#' @param mod_name the model name
#' @param xds_obj an **`xds`** model object
#' @param s the vector species index
#' @param options a list to configure `F_vis_kappa`
#'
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_F_vis_kappa = function(mod_name, xds_obj, s, options){
  class(mod_name) = mod_name
  UseMethod("setup_F_vis_kappa", mod_name)
}

#' @title Set up visitor infectiousness as a time series function
#'
#' @description Setup a time series function for the net infectiousness
#' of visitors.
#'
#' @inheritParams setup_F_vis_kappa
#'
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_F_vis_kappa.ts_func = function(mod_name, xds_obj, s, options){
  class(xds_obj$XY_interface$visitor_obj) <- 'dynamic'
  class(xds_obj$XY_interface) <- 'dynamic'
  class(xds_obj$beta) <- 'dynamic'
  Fv <- make_ts_function(options)
  Fv -> xds_obj$XY_interface$visitor_obj[[s]]$F_vis_kappa
  return(xds_obj)
}
