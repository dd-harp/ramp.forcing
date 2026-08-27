# Setup the Visitor Sub-Object

Setup the port sub-object to handle visitor dynamics. Initialises
`visitor_obj` on the `XY_interface` and sets static (zero) defaults for
`F_visitors` and `F_vis_kappa`.

## Usage

``` r
setup_visitor_object(xds_obj)
```

## Arguments

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object

## Note

The parameters `visitors` and `vis_kappa` are initialised by
[ramp.xds::setup_importation_object](https://dd-harp.github.io/ramp.xds/reference/setup_importation_object.html);
this function only sets up the port machinery.
