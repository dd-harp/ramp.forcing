
#' @title Forcing with Trivial Modules
#'
#' @description
#'
#' Trivial modules were developed for each one
#' of the three dynamical components, making it
#' possible to develop studies of some focal process
#' with known inputs: a *trace function* approach.
#'
#' Three trivial modules and EIR forcing
#' construct trace functions as composed time series. The
#' value of a forced variable \eqn{x(t)} is computed
#' as a product of four configurable elements:
#' + \eqn{\bar x}: a mean value
#' + \eqn{S(t)}: a seasonal pattern
#' + \eqn{T(t)}: a trend
#' + \eqn{K(t)}: a shock
#'
#' \deqn{x(t) = \bar x \times S(t) \times T(t) \times K(t)}
#'
#' In the trivial modules, the functions are specified by
#' passing parameters generated for [ramp.func::make_function].
#'
#' + `season_par` is passed to [ramp.func::make_function] to compile \eqn{S(t)} or `F_season`
#' + `trend_par` is passed to [ramp.func::make_function] to compile \eqn{T(t)} or `F_trend`
#' + `shock_par` is passed to [ramp.func::make_function] to compile \eqn{K(t)} or `F_shock`
#'
#' A trace function library is found in the satellite package `ramp.func`
#'
#' @name xds_info_trivial_forcing
NULL
