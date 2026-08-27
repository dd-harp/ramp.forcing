# Dynamic Resources

Compute availability of resources affecting adult mosquito bionomics:
blood hosts, aquatic habitats, traps, and sugar. This is the dynamic
implementation of the
[ramp.xds::Resources](https://dd-harp.github.io/ramp.xds/reference/Resources.html)
junction.

- [OtherBloodHosts](https://dd-harp.github.io/ramp.forcing/reference/OtherBloodHosts.md)
  availability of alternative blood hosts

- [HabitatDynamics](https://dd-harp.github.io/ramp.forcing/reference/HabitatDynamics.md)
  to modify habitat search weights

- [Traps](https://dd-harp.github.io/ramp.forcing/reference/Traps.md) to
  compute availability of oviposition traps

- [Sugar](https://dd-harp.github.io/ramp.forcing/reference/Sugar.md)
  availability of sugar

## Usage

``` r
# S3 method for class 'dynamic'
Resources(t, y, xds_obj)
```

## Arguments

- t:

  the time

- y:

  the state variables

- xds_obj:

  an **`xds`** model object

## Value

an **`xds`** object

## See also

[dynamic_resources](https://dd-harp.github.io/ramp.forcing/reference/dynamic_resources.md)
