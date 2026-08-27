# Importation (dynamic)

Dynamic method for the `Importation` junction. Calls
[Travel](https://dd-harp.github.io/ramp.forcing/reference/Travel.md) and
[Visitors](https://dd-harp.github.io/ramp.forcing/reference/Visitors.md)
to update time at home, travel EIR, visitor availability, and visitor
infectiousness.

## Usage

``` r
# S3 method for class 'dynamic'
Importation(t, y, xds_obj)
```

## Arguments

- t:

  current simulation time

- y:

  state vector

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object
