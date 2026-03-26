
#' @title The `setup` case for exogenous forcing
#' @description Call all the functions to set the
#' values of exogenous variables and then revert
#' the `none` case
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
Forcing.setup = function(t, xds_obj){
  class(xds_obj$forcing_obj) <- 'dynamic'
  xds_obj <- Forcing(t, xds_obj)
  class(xds_obj$forcing_obj) <- 'none'
  return(xds_obj)
}

#' @title Set the values of exogenous variables
#' @description With dynamic forcing, exogenous variables
#' can be set in one of four function calls:
#' - Weather
#' - Hydrology
#' - Shock
#' - Development
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
#' @seealso [dynamic_forcing]
Forcing.dynamic = function(t, xds_obj){
  xds_obj <- Weather(t, xds_obj)
  xds_obj <- Hydrology(t, xds_obj)
  xds_obj <- Shock(t, xds_obj)
  xds_obj <- Development(t, xds_obj)
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing = function(xds_obj){
  UseMethod("dynamic_forcing", xds_obj$forcing_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing.none = function(xds_obj){
  forcing <- 'dynamic'
  class(forcing) <- 'dynamic'
  xds_obj$forcing_obj <- forcing
  xds_obj <- setup_no_weather(xds_obj)
  xds_obj <- setup_no_hydrology(xds_obj)
  xds_obj <- setup_no_shock(xds_obj)
  xds_obj <- setup_no_development(xds_obj)
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing.setup = function(xds_obj){
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing.dynamic = function(xds_obj){
  return(xds_obj)
}

