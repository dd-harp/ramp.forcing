## -----------------------------------------------------------------------------
library(ramp.xds)
library(ramp.forcing)
library(ramp.func)
library(MASS)
library(deSolve)
library(viridisLite)

## -----------------------------------------------------------------------------
#devtools::load_all()

## ----fig.height=9, fig.width=7------------------------------------------------
tt <- seq(0, 5*365, by=5)
p1 <- makepar_F_sharkbite(500, 365, dk = 1/100, mx=0.8)
F1 <- make_function(p1)
plot(tt, F1(tt), type = "l", xlab = "Time", ylab = "Effect Size", main = "Response Timeline", ylim = c(0,1))

## ----fig.height=9, fig.width=7------------------------------------------------
par(mfrow = c(2,1))
sis_si_eir <- xds_setup_eir(Xname = "SIS", eir=3/365)
sis_si_eir <- change_shock(sis_si_eir, shock_par=p1)
sis_si_eir <- burnin(sis_si_eir) 
sis_si_eir <- xds_solve(sis_si_eir, 5*365, 5)
xds_plot_EIR(sis_si_eir) -> eir
xds_plot_PR(sis_si_eir)  -> pr

## ----fig.height=9, fig.width=7------------------------------------------------
par(mfrow = c(2,1))
seas0 = makepar_F_sin(bottom = 0.3, pw=2)
sis_si_eir_1 <- xds_setup_eir(Xname = "SIS", eir=3/365)
sis_si_eir_1 <- change_season(seas0, sis_si_eir_1)
sis_si_eir_2 <- xds_setup_eir(Xname = "SIS", eir=3/365)
sis_si_eir_2 <- change_season(seas0, sis_si_eir_2)
sis_si_eir_2 <- change_shock(p1, sis_si_eir_2)
sis_si_eir_1 <- burnin(sis_si_eir_1) 
sis_si_eir_2 <- burnin(sis_si_eir_2) 
sis_si_eir_1 <- xds_solve(sis_si_eir_1, 5*365, 5)
sis_si_eir_2 <- xds_solve(sis_si_eir_2, 5*365, 5)
xds_plot_EIR(sis_si_eir_2) -> eir2
get_EIR(sis_si_eir_1) -> eir1
xds_plot_PR(sis_si_eir_2)  -> pr2
get_PR(sis_si_eir_2) -> pr2 
pr2 <- pr2$pr
get_PR(sis_si_eir_1) -> pr1 
pr1 <- pr1$pr

## ----response timeline panel, fig.height=9, fig.width=9-----------------------
tt=seq(0, 5*365, by = 5)
par(mfcol = c(2,2), mar = c(3,5,2,1))
plot(tt, eir1/eir2, type = "l", ylab = "EIR Ratios")
plot(tt, eir1-eir2, type = "l", ylab = "EIR Differences")
plot(tt, pr1/pr2, type = "l", ylab = "PR ratios")
plot(tt, pr1-pr2, type = "l", ylab = "PR differences")

