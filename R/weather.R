# generic methods for exogenous forcing by weather

#' @title Set the values of exogenous variables describing weather
#' @description This method dispatches on the type of `xds_obj$weather`.
#' @param t current simulation time
#' @param xds_obj a [list]
#' @keywords internal
#' @return [list]
#' @export
Weather <- function(t, xds_obj) {
  UseMethod("Weather", xds_obj$weather)
}

#' @title Methods for exogenous variables describing weather
#' @description Implements a null weather model
#' @inheritParams Weather
#' @keywords internal
#' @return [list]
#' @export
Weather.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up the no_forcing model for weather
#' @param xds_obj a [list]
#' @return [list]
#' @export
setup_no_weather <- function(xds_obj) {
  weather <- 'none'
  class(weather) <- 'none'
  xds_obj$weather <- weather
  return(xds_obj)
}

#' @title Set up dynamic weather
#' @description If dynamic weather has not
#' already been set up, then turn on dynamic
#' weather and set up all its null models
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @keywords internal
#' @export
dynamic_weather = function(xds_obj){
  UseMethod("dynamic_weather", xds_obj$weather)
}

#' @title Set up dynamic weather
#' @description If dynamic weather has not
#' already been set up, then turn on dynamic
#' weather and set all the
#' @param xds_obj an **`xds`** object
#' @keywords internal
#' @return an **`xds`** object
#' @export
dynamic_weather.none = function(xds_obj){
  # turn on dynamic forcing
  xds_obj <- dynamic_forcing(xds_obj)
  weather <- 'dynamic'
  class(weather) <- 'dynamic'
  xds_obj$weather <- weather
  xds_obj <- setup_no_temperature(xds_obj)
  xds_obj <- setup_no_rainfall(xds_obj)
  xds_obj <- setup_no_humidity(xds_obj)
  return(xds_obj)
}

#' @title Set up dynamic weather
#' @description If dynamic weather has not
#' already been set up, then turn on dynamic
#' weather and set all the
#' @param xds_obj an **`xds`** object
#' @keywords internal
#' @return an **`xds`** object
#' @export
dynamic_weather.setup = function(xds_obj){
  return(xds_obj)
}

#' @title Set up dynamic weather
#' @description If dynamic weather has not
#' already been set up, then turn on dynamic
#' weather and set all the
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @keywords internal
#' @export
dynamic_weather.dynamic = function(xds_obj){
  return(xds_obj)
}

#' @title Methods for exogenous variables describing weather
#' @description Implements exogenous forcing by [Weather]
#' @inheritParams Weather
#' @return an **`xds`** object
#' @keywords internal
#' @export
Weather.dynamic <- function(t, xds_obj) {
  xds_obj = Temperature(t, xds_obj)
  xds_obj = Rainfall(t, xds_obj)
  xds_obj = Humidity(t, xds_obj)
  return(xds_obj)
}

