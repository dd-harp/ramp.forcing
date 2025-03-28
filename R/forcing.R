
#' @title The `setup` case for exogenous forcing
#' @description Call all the functions to set the
#' values of exogenous variables and then revert
#' the `none` case
#' @param t current simulation time
#' @param pars an **`xds`** object
#' @return an **`xds`** object
#' @export
Forcing.setup = function(t, pars){
  class(pars$forcing) <- 'dynamic'
  pars <- Forcing(t, pars)
  class(pars$forcing) <- 'none'
  return(pars)
}

#' @title Set the values of exogenous variables
#' @description With dynamic forcing, exogenous variables
#' can be set in one of four function calls:
#' - Weather
#' - Hydrology
#' - Shock
#' - Development
#' @param t current simulation time
#' @param pars an **`xds`** object
#' @return an **`xds`** object
#' @export
#' @seealso [dynamic_forcing]
Forcing.dynamic = function(t, pars){
  pars <- Weather(t, pars)
  pars <- Hydrology(t, pars)
  pars <- Shock(t, pars)
  pars <- Development(t, pars)
  return(pars)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param pars an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing = function(pars){
  UseMethod("dynamic_forcing", pars$forcing)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param pars an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing.none = function(pars){
  forcing <- 'dynamic'
  class(forcing) <- 'dynamic'
  pars$forcing <- forcing
  pars <- setup_no_weather(pars)
  pars <- setup_no_hydrology(pars)
  pars <- setup_no_shock(pars)
  pars <- setup_no_development(pars)
  return(pars)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param pars an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing.setup = function(pars){
  return(pars)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param pars an **`xds`** object
#' @return an **`xds`** object
#' @export
dynamic_forcing.dynamic = function(pars){
  return(pars)
}

