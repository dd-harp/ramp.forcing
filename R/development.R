
#' @title Set the development
#' @description Set the value of exogenous variables related to
#' development
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @keywords internal
#' @export
Development <- function(t, xds_obj) {
  UseMethod("Development", xds_obj$development)
}

#' @title Set no development
#' @description The null model for development
#' @inheritParams Development
#' @return [list]
#' @keywords internal
#' @export
Development.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up "no development"
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_no_development <- function(xds_obj) {
  development <- 'none'
  class(development) <- 'none'
  xds_obj$development <- development
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
#' @keywords internal
#' @export
setup_development = function(name, xds_obj, Topts=list()){
  class(name) <- name
  UseMethod("setup_development", name)
}

#' @title Set no development
#' @description The null model for development
#' @inheritParams Development
#' @return [list]
#' @keywords internal
#' @export
Development.func <- function(t, xds_obj) {with(xds_obj$development,{
  xds_obj$vars$housing_quality = mean*F_season(t)*F_trend(t)
})}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @inheritParams setup_development
#' @keywords internal
#' @export
setup_development.func = function(name, xds_obj, Topts=list()){
  xds_obj <- dynamic_forcing(xds_obj)
  xds_obj = setup_development_func(xds_obj, Topts())
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @param Topts a list of options to override defaults
#' @param mean the mean water level
#' @param F_season the seasonal signal in development
#' @param F_trend a temporal trend in development
#' @return an **`xds`** object
#' @importFrom ramp.xds F_one
#' @keywords internal
#' @export
setup_development_func = function(xds_obj, Topts=list(), mean=30, F_season=F_one, F_trend=F_one){
  development <- list()
  class(development) <- 'func'
  development$mean <- mean
  development$F_season <- F_season
  development$F_trend <- F_trend
  xds_obj$development <- development
  return(xds_obj)
}

