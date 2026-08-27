# Set up dynamic forcing

If dynamic forcing has not already been set up, then turn on dynamic
forcing and set all the

## Usage

``` r
setup_temperature_func(
  xds_obj,
  Topts = list(),
  meanT = 30,
  F_season = F_one,
  F_trend = F_one
)
```

## Arguments

- xds_obj:

  an **`xds`** object

- Topts:

  a list of options to override defaults

- meanT:

  the mean temperature

- F_season:

  the seasonal signal in temperature

- F_trend:

  a temporal trend in temperature

## Value

an **`xds`** object
