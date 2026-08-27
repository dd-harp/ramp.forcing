## -----------------------------------------------------------------------------
library(ramp.xds)
library(ramp.forcing)
library(ramp.func)

## -----------------------------------------------------------------------------
#devtools::load_all()

## -----------------------------------------------------------------------------
skill_set_XH("SIS")$mda

## -----------------------------------------------------------------------------
base_model <- xds_setup_eir(Xname = "SIS", 
                       eir=1/365)
base_model <- change_season(makepar_F_sin(phase=120), base_model)

## ----fig.height=4, fig.width=7------------------------------------------------
base_model <- burnin(base_model) 
base_model <- xds_solve(base_model, 1095,5)
xds_plot_PR(base_model)

## -----------------------------------------------------------------------------
start = c(180, 480)
span = c(10,10)
frac_tot = c(0.9, 0.9)
test = c(FALSE, FALSE) 
mda_model <- setup_mass_treat_events(base_model, start, span, frac_tot, test)

## ----fig.height=4, fig.width=7------------------------------------------------
mda_model <- xds_solve(mda_model, 1095,5)
xds_plot_PR(base_model)
xds_plot_PR(mda_model, add=T, clrs = "darkred")

## ----fig.height=4, fig.width=7------------------------------------------------
tt <- seq(0, 1095, by = 1)
mda_model_1 <- add_mass_treat_events(mda_model, 600, 10, .9, FALSE)
mda_model_1 <- xds_solve(mda_model_1, 1095,5)
show_mda(tt, mda_model_1)

## ----fig.height=4, fig.width=7------------------------------------------------
mda_model_2 <- add_mass_treat_events(base_model, 600, 10, .9, FALSE)
mda_model_2 <- xds_solve(mda_model_2, 1095,5)
show_mda(tt, mda_model_2)

## ----fig.height=4, fig.width=7------------------------------------------------
xds_plot_PR(mda_model_2, clrs="darkblue")
xds_plot_PR(mda_model_1, add=T, clrs = "purple3")
xds_plot_PR(base_model, add=T)
xds_plot_PR(mda_model, add=T, clrs = "darkred")

## ----eval=F-------------------------------------------------------------------
# help(dXHdt.SIS)

## ----fig.height=4, fig.width=7------------------------------------------------
tt <- seq(598, 612, by = .1)
show_mda(tt, mda_model_1)

## -----------------------------------------------------------------------------
mda <- mda_model_1$mda_obj$F_treat
t_frac = 1-exp(-integrate(mda, 595, 615)$val)
approx_equal(.9, t_frac, tol = 1e-6) 

