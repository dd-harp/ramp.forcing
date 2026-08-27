#' @title Traps
#'
#' @description Junction for mosquito traps affecting blood feeding
#' (`Btraps`) and oviposition (`Qtraps`). Dynamic implementations
#' are configured via [setup_traps_object] and activated by [dynamic_resources].
#'
#' @param t current simulation time
#' @param y state variables
#' @param xds_obj an **`xds`** model object
#' @return an **`xds`** object
#' @keywords internal
#' @export
Traps = function(t, y, xds_obj){
  UseMethod("Traps", xds_obj$resources_obj$traps_obj)
}

#' @title Traps (none)
#' @description The default no-op for Traps. Trap availability
#' (`Qtraps`, `Btraps`) retains its static zero-initialized default.
#' @inheritParams Traps
#' @return an **`xds`** object
#' @keywords internal
#' @export
Traps.none = function(t, y, xds_obj){
  return(xds_obj)
}

#' @title Setup the traps junction object
#' @description Initializes `resources_obj$traps_obj` with class `none`,
#' ready for dynamic trap configuration.
#' Called by [dynamic_resources].
#' @param xds_obj an **`xds`** model object
#' @return an **`xds`** object
#' @keywords internal
#' @export
setup_traps_object = function(xds_obj){
  traps <- list()
  class(traps) <- 'none'
  traps$name <- "Junction: Mosquito Traps"
  traps$ports <- "Ports: Ovitraps, Blood Traps, Sugar Baited Traps"
  xds_obj$ML_interface$Qtraps = list()
  xds_obj$ML_interface$Qtraps[[1]] <- rep(0, xds_obj$nPatches)
  xds_obj$XY_interface$Btraps = list()
  xds_obj$XY_interface$Btraps[[1]] <- rep(0, xds_obj$nPatches)
  xds_obj$resources_obj$traps_obj <- traps
  return(xds_obj)
}
