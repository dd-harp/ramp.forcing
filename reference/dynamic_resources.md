# Set up dynamic resources

Activates dynamic resource computation and initializes the sub-junctions
for blood hosts, habitat dynamics, traps, and sugar with their `none`
(no-op) defaults. Use the individual setup functions (e.g.,
[setup_blood_host_object](https://dd-harp.github.io/ramp.forcing/reference/setup_blood_host_object.md),
[setup_traps_object](https://dd-harp.github.io/ramp.forcing/reference/setup_traps_object.md))
to configure specific ports.

## Usage

``` r
dynamic_resources(xds_obj)
```

## Arguments

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object
