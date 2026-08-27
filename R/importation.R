
#' @title Importation (dynamic)
#'
#' @description Dynamic method for the `Importation` junction. Calls
#' [Travel] and [Visitors] to update time at home, travel EIR,
#' visitor availability, and visitor infectiousness.
#'
#' @inheritParams ramp.xds::Importation
#' @return an **`xds`** object
#' @keywords internal
#' @export
Importation.dynamic = function(t, y, xds_obj){
  xds_obj <- Travel(t, y, xds_obj)
  xds_obj <- Visitors(t, y, xds_obj)
  return(xds_obj)
}

#' @title Activate Dynamic Importation
#'
#' @description Activate dynamic importation by upgrading the
#' `importation_obj` to class `dynamic` and setting up the
#' travel and visitor sub-objects.
#'
#' @param xds_obj an **`xds`** model object
#'
#' @return an **`xds`** object
#' @export
dynamic_importation = function(xds_obj){
  UseMethod("dynamic_importation", xds_obj$importation_obj)
}

#' @title Activate Dynamic Importation (none)
#'
#' @description Upgrades the `importation_obj` from class `none` to
#' class `dynamic` and initialises the travel and visitor sub-objects.
#'
#' @inheritParams dynamic_importation
#' @return an **`xds`** object
#' @keywords internal
#' @export
dynamic_importation.none = function(xds_obj){
  importation <- list()
  class(importation) <- 'dynamic'
  importation$name <- "Junction: Importation"
  xds_obj$importation_obj <- importation
  xds_obj <- setup_travel_object(xds_obj)
  xds_obj <- setup_visitor_object(xds_obj)
  return(xds_obj)
}

#' @title Activate Dynamic Importation (dynamic)
#'
#' @description No-op: the `importation_obj` is already dynamic.
#'
#' @inheritParams dynamic_importation
#' @return an **`xds`** object
#' @keywords internal
#' @export
dynamic_importation.dynamic = function(xds_obj){
  return(xds_obj)
}
