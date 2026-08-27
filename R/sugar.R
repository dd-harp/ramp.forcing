#' @title Sugar
#'
#' @description Junction for sugar availability affecting adult mosquito
#' survival. Dynamic implementations are configured via [setup_sugar_object]
#' and activated by [dynamic_resources].
#'
#' @param t current simulation time
#' @param y dependent variables vector
#' @param xds_obj an **`xds`** model object
#' @return an **`xds`** object
#' @keywords internal
#' @export
Sugar = function(t, y, xds_obj){
  UseMethod("Sugar", xds_obj$resources_obj$sugar_obj)
}

#' @title Sugar (none)
#' @description The default no-op for Sugar. Sugar availability
#' retains its static default.
#' @inheritParams Sugar
#' @return an **`xds`** object
#' @keywords internal
#' @export
Sugar.none = function(t, y, xds_obj){
  return(xds_obj)
}

#' @title Setup the sugar junction object
#' @description Initializes `resources_obj$sugar_obj` with class `none`,
#' ready for dynamic sugar configuration.
#' Called by [dynamic_resources].
#' @param xds_obj an **`xds`** model object
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_sugar_object = function(xds_obj){
  sugar <- list()
  class(sugar) <- 'none'
  sugar$name <- "Junction: Natural Sugar Dynamics"
  sugar$ports <- "Sugar Availability, Sugar Baits"
  xds_obj$resources_obj$sugar_obj <- sugar
  return(xds_obj)
}
