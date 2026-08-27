# HabitatDynamics (setup)

Transitions habitat_obj from `setup` to `static` class on the first
call, triggering computation of egg-laying matrices.

## Usage

``` r
# S3 method for class 'setup'
HabitatDynamics(t, y, xds_obj)
```

## Arguments

- t:

  current simulation time

- y:

  state variables

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object
