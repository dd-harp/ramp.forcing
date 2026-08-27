## -----------------------------------------------------------------------------
library(ramp.xds)
library(ramp.forcing)
library(ramp.func)
library(MASS)
library(deSolve)
library(viridisLite)

## -----------------------------------------------------------------------------
#devtools::load_all()

## -----------------------------------------------------------------------------
irs_par <- makepar_F_sharkfin(D=50, uk=1/3, L=180, mx=.9)
Fsf <- make_function(irs_par) 

## ----fig.height=4, fig.width=6, echo=F----------------------------------------
tt <- seq(0, 730, by = 5)
plot(tt, Fsf(tt), type = "l", main="Coverage", ylab = "A Sharkfin Function", xlab = "Time")
segments(40, 0, 40, .9, lty=2, col = grey(0.5))
segments(60, 0, 60, .9, lty=2, col = grey(0.5))
points(50, .45, col = grey(0.5))
points(230, .45, col = grey(0.5))

## -----------------------------------------------------------------------------
#devtools::load_all("~/git/ramp.xds")

## -----------------------------------------------------------------------------
model <- xds_setup(MYname = "SI", Loptions = list(Lambda=40, season_par=makepar_F_sin()))
model <- xds_solve(model, 2000)
model <- last_to_inits(model)
model <- xds_solve(model, 1100)
xds_plot_EIR(model)

## -----------------------------------------------------------------------------
model <- setup_irs(model, coverage_name = "func", coverage_opts=list(trend_par = irs_par, mx=1), effect_sizes_name = "simple")

## -----------------------------------------------------------------------------
show_irs_contact(tt, model)

## -----------------------------------------------------------------------------
model <- xds_solve(model, 1100)
xds_plot_EIR(model)

