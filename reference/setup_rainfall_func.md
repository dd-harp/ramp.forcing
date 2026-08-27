# Set up dynamic forcing

If dynamic forcing has not already been set up, then turn on dynamic
forcing and set all the

## Usage

``` r
setup_rainfall_func(
  xds_obj,
  Topts = list(),
  mean = 30,
  F_season = F_one,
  F_trend = F_one
)
```

## Arguments

- xds_obj:

  an **`xds`** object

- Topts:

  a list of options to override defaults

- mean:

  the mean rainfall

- F_season:

  the seasonal signal in rainfall

- F_trend:

  a temporal trend in rainfall

## Value

an **`xds`** object
