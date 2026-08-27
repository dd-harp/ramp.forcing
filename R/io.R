
#' readRDS for `xds` Objects
#'
#' @description
#' Read the `xds` object using `readRDS` and rebuild the forcing functions
#'
#' @param filename the file name
#'
#' @return an **`xds`** object
#' @export
#' @keywords internal
readXDS = function(filename){
  xds_obj <- readRDS(filename)
  for(s in 1:xds_obj$nVectorSpecies)
    xds_obj <- rebuild_forcing_functions(xds_obj, s)
  return(xds_obj)
}
