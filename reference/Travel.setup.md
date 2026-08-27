# Travel (setup)

Resets the `travel_obj` class to `static`, triggers a setup update to
the blood feeding model, and then calls
[travel_dynamics](https://dd-harp.github.io/ramp.forcing/reference/travel_dynamics.md)
once.

## Usage

``` r
# S3 method for class 'setup'
Travel(t, y, xds_obj)
```

## Arguments

- t:

  current simulation time

- y:

  variables

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object
