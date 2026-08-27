# Visitors (setup)

Resets the `visitor_obj` class to `static` and then calls
[visitor_dynamics](https://dd-harp.github.io/ramp.forcing/reference/visitor_dynamics.md)
once.

## Usage

``` r
# S3 method for class 'setup'
Visitors(t, y, xds_obj)
```

## Arguments

- t:

  current time

- y:

  the state variable vector

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object
