# Modify baseline values due to vector control

Implements
[Bed_Net_Effect_Sizes](https://dd-harp.github.io/ramp.forcing/reference/Bed_Net_Effect_Sizes.md)
for the Le Menach ITN model of vector control

## Usage

``` r
compute_bednet_effect_sizes_lemenach(
  ix,
  phi,
  ff,
  qq,
  gg,
  tau0_frac = c(0.68/3, 2.32/3),
  rr = 0.56,
  ss = 0.03
)
```

## Arguments

- ix:

  an index over nPatches

- phi:

  ITN coverage

- ff:

  baseline blood feeding rate

- qq:

  baseline human fraction

- gg:

  baseline mosquito mortality rate

- tau0_frac:

  a [numeric](https://rdrr.io/r/base/numeric.html) vector giving the
  proportion of a feeding cycle spent host seeking/bloodfeeding *vs.*
  resting/oviposition

- rr:

  probability of mosquito being repelled upon contact with ITN

- ss:

  probability of mosquito successfully feeding upon contact with ITN

## Value

a **`ramp.xds`** model object

## References

This implements the model for ITN effect sizes from Adummy A (2026).
“Not avalable.” Failed to insert reference with key = LeMenachA2007_ITN
from package = 'ramp.control'. Possible cause — missing REFERENCES.bib
in package 'ramp.control' or 'ramp.control' not installed. .
