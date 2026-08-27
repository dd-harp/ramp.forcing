
#' @title Set the temperature
#' @description Set the value of exogenous variables related to
#' temperature
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @keywords internal
#' @export
Temperature <- function(t, xds_obj) {
  UseMethod("Temperature", xds_obj$temperature)
}

#' @title Set no temperature
#' @description The null model for temperature
#' @inheritParams Temperature
#' @return [list]
#' @keywords internal
#' @export
Temperature.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up "no temperature"
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_no_temperature <- function(xds_obj) {
  temperature <- 'none'
  class(temperature) <- 'none'
  xds_obj$temperature <- temperature
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param Tname the name of a model to set up
#' @param xds_obj an **`xds`** object
#' @param Topts a list of options to override defaults
#' @return an **`xds`** object
#' @export
setup_temperature = function(Tname, xds_obj, Topts=list()){
  class(Tname) <- Tname
  UseMethod("setup_temperature", Tname)
}

#' @title Set no temperature
#' @description The null model for temperature
#' @inheritParams Temperature
#' @return [list]
#' @keywords internal
#' @export
Temperature.func <- function(t, xds_obj) {with(xds_obj$temperature,{
  xds_obj$vars$Temperature = meanT*F_season(t)*F_trend(t)
})}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @inheritParams setup_temperature
#' @keywords internal
#' @export
setup_temperature.func = function(Tname, xds_obj, Topts=list()){
  xds_obj <- dynamic_weather(xds_obj)
  xds_obj = setup_temperature_func(xds_obj, Topts())
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @param Topts a list of options to override defaults
#' @param meanT the mean temperature
#' @param F_season the seasonal signal in temperature
#' @param F_trend a temporal trend in temperature
#' @return an **`xds`** object
#' @importFrom ramp.xds F_one
#' @export
setup_temperature_func = function(xds_obj, Topts=list(), meanT=30, F_season=F_one, F_trend=F_one){
   temperature <- list()
   class(temperature) <- 'func'
   temperature$meanT <- meanT
   temperature$F_season <- F_season
   temperature$F_trend <- F_trend
   xds_obj$temperature <- temperature
   return(xds_obj)
}

