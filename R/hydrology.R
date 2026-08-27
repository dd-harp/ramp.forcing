
#' @title Set the hydrology
#' @description Set the value of exogenous variables related to
#' hydrology
#' @param t current simulation time
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
#' @keywords internal
Hydrology <- function(t, xds_obj) {
  UseMethod("Hydrology", xds_obj$hydrology)
}

#' @title Set no hydrology
#' @description The null model for hydrology
#' @inheritParams Hydrology
#' @return [list]
#' @export
#' @keywords internal
Hydrology.none <- function(t, xds_obj) {
  return(xds_obj)
}

#' @title Set up "no hydrology"
#' @param xds_obj an **`xds`** object
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_no_hydrology <- function(xds_obj) {
  hydrology <- list()
  hydrology$name <- 'none'
  class(hydrology) <- 'none'
  xds_obj$hydrology <- hydrology
  return(xds_obj)
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param Hname the name of a model to set up
#' @param xds_obj an **`xds`** object
#' @param setup_no_forcing a list of options to override defaults
#' @return an **`xds`** object
#' @export
#' @keywords internal
setup_hydrology = function(Hname, xds_obj, setup_no_forcing=list()){
  class(Hname) <- Hname
  UseMethod("setup_hydrology", Hname)
}

#' @title Set no hydrology
#' @description The null model for hydrology
#' @inheritParams Hydrology
#' @return [list]
#' @export
#' @keywords internal
Hydrology.func <- function(t, xds_obj) {with(xds_obj$hydrology,{
  xds_obj$vars$water_level = mean*F_season(t)*F_trend(t)
})}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @inheritParams setup_hydrology
#' @export
#' @keywords internal
setup_hydrology.func = function(Hname, xds_obj, setup_no_forcing=list()){
  xds_obj = setup_hydrology_func(xds_obj, setup_no_forcing())
}

#' @title Set up dynamic forcing
#' @description If dynamic forcing has not
#' already been set up, then turn on dynamic
#' forcing and set all the
#' @param xds_obj an **`xds`** object
#' @param setup_no_forcing a list of options to override defaults
#' @param mean the mean water level
#' @param F_season the seasonal signal in hydrology
#' @param F_trend a temporal trend in hydrology
#' @return an **`xds`** object
#' @importFrom ramp.xds F_one
#' @export
#' @keywords internal
setup_hydrology_func = function(xds_obj, setup_no_forcing=list(), mean=30, F_season=F_one, F_trend=F_one){
  hydrology <- list()
  class(hydrology) <- 'func'
  hydrology$mean <- mean
  hydrology$F_season <- F_season
  hydrology$F_trend <- F_trend
  xds_obj$hydrology <- hydrology
  return(xds_obj)
}

