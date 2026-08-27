# Set up dynamic forcing

If dynamic forcing has not already been set up, then turn on dynamic
forcing and set all the

## Usage

``` r
setup_hydrology_func(
  xds_obj,
  setup_no_forcing = list(),
  mean = 30,
  F_season = F_one,
  F_trend = F_one
)
```

## Arguments

- xds_obj:

  an **`xds`** object

- setup_no_forcing:

  a list of options to override defaults

- mean:

  the mean water level

- F_season:

  the seasonal signal in hydrology

- F_trend:

  a temporal trend in hydrology

## Value

an **`xds`** object
