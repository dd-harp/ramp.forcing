# Traps

Junction for mosquito traps affecting blood feeding (`Btraps`) and
oviposition (`Qtraps`). Dynamic implementations are configured via
[setup_traps_object](https://dd-harp.github.io/ramp.forcing/reference/setup_traps_object.md)
and activated by
[dynamic_resources](https://dd-harp.github.io/ramp.forcing/reference/dynamic_resources.md).

## Usage

``` r
Traps(t, y, xds_obj)
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
