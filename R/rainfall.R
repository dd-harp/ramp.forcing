
#' @title Set the rainfall
#' @description Set the value of exogenous variables related to
#' rainfall
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
Rainfall <- function(t, xds_obj) {
  UseMethod("Rainfall", xds_obj$rainfall)
}

#' @title Set no rainfall
#' @description The null model for rainfall
#' @inheritParams Rainfall
#' @return [list]
#' @export
Rainfall.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up "no rainfall"
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
setup_no_rainfall <- function(xds_obj) {
  rainfall <- 'none'
  class(rainfall) <- 'none'
  xds_obj$rainfall <- rainfall
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
setup_rainfall = function(Tname, xds_obj, Topts=list()){
  class(Tname) <- Tname
  UseMethod("setup_rainfall", Tname)
}

#' @title Set no rainfall
#' @description The null model for rainfall
#' @inheritParams Rainfall
#' @return [list]
#' @export
Rainfall.func <- function(t, xds_obj) {with(xds_obj$rainfall,{
  xds_obj$vars$Rainfall = mean*F_season(t)*F_trend(t)
})}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @inheritParams setup_rainfall
#' @export
setup_rainfall.func = function(Tname, xds_obj, Topts=list()){
  xds_obj = setup_rainfall_func(xds_obj, Topts())
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @param Topts a list of options to override defaults
#' @param mean the mean rainfall
#' @param F_season the seasonal signal in rainfall
#' @param F_trend a temporal trend in rainfall
#' @return an **`xds`** object
#' @export
setup_rainfall_func = function(xds_obj, Topts=list(), mean=30, F_season=F_flat, F_trend=F_flat){
  rainfall <- list()
  class(rainfall) <- 'func'
  rainfall$meanT <- mean
  rainfall$F_season <- F_season
  rainfall$F_trend <- F_trend
  xds_obj$rainfall <- rainfall
  return(xds_obj)
}

