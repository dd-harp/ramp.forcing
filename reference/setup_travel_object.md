# Setup the Travel Sub-Object

Setup the port sub-object to handle travel dynamics. Initialises
`travel_obj` on the `XY_interface` and sets static (zero) defaults for
`F_travel` and `F_travel_eir`.

## Usage

``` r
setup_travel_object(xds_obj)
```

## Arguments

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object

## Note

The parameters `time_at_home` and `travel_EIR` are initialised by
[ramp.xds::setup_importation_object](https://dd-harp.github.io/ramp.xds/reference/setup_importation_object.html);
this function only sets up the port machinery.
