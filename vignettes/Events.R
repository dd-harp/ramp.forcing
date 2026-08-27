## -----------------------------------------------------------------------------
library(ramp.xds)
library(ramp.forcing)
library(ramp.func)
#devtools::load_all()

## ----fig.width=7, fig.height=4.5----------------------------------------------
clrs=viridisLite::turbo(6)
show_bednet_profile(730, 1/500, clr = clrs[4])
show_bednet_profile(100, 1/50, clr = clrs[1], add=T)
show_bednet_profile(365, 1/200, clr = clrs[2], add=T)
show_bednet_profile(500, 1/300, clr = clrs[3], add=T)

