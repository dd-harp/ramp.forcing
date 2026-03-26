
#' @title Set the humidity
#' @description Set the value of exogenous variables related to
#' humidity
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
Humidity <- function(t, xds_obj) {
  UseMethod("Humidity", xds_obj$humidity)
}

#' @title Set no humidity
#' @description The null model for humidity
#' @inheritParams Humidity
#' @return [list]
#' @export
Humidity.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up "no humidity"
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
setup_no_humidity <- function(xds_obj) {
  humidity <- 'none'
  class(humidity) <- 'none'
  xds_obj$humidity <- humidity
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param name the name of a model to set up
#' @param xds_obj an **`xds`** object
#' @param Topts a list of options to override defaults
#' @return an **`xds`** object
#' @export
setup_humidity = function(name, xds_obj, Topts=list()){
  class(name) <- name
  UseMethod("setup_humidity", name)
}

#' @title Set no humidity
#' @description The null model for humidity
#' @inheritParams Humidity
#' @return [list]
#' @export
Humidity.func <- function(t, xds_obj) {with(xds_obj$humidity,{
  xds_obj$vars$Humidity = mean*F_season(t)*F_trend(t)
})}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @inheritParams setup_humidity
#' @export
setup_humidity.func = function(name, xds_obj, Topts=list()){
  xds_obj = setup_humidity_func(xds_obj, Topts())
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @param Topts a list of options to override defaults
#' @param mean the mean humidity
#' @param F_season the seasonal signal in humidity
#' @param F_trend a temporal trend in humidity
#' @return an **`xds`** object
#' @export
setup_humidity_func = function(xds_obj, Topts=list(), mean = 80, F_season=F_flat, F_trend=F_flat){
  humidity <- list()
  class(humidity) <- 'func'
  humidity$meanT <- mean
  humidity$F_season <- F_season
  humidity$F_trend <- F_trend
  xds_obj$humidity <- humidity
  return(xds_obj)
}

