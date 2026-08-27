# Set the values of exogenous variables

With dynamic forcing, exogenous variables can be set in one of four
function calls:

- Weather

- Hydrology

- Shock

- Development

## Usage

``` r
# S3 method for class 'dynamic'
Forcing(t, xds_obj)
```

## Arguments

- t:

  current simulation time

- xds_obj:

  an **`xds`** object

## Value

an **`xds`** object

## See also

[dynamic_forcing](https://dd-harp.github.io/ramp.forcing/reference/dynamic_forcing.md)
