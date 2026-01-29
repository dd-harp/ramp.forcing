# **`ramp.forcing`** - Forcing for [**`ramp.xds`**](https://dd-harp.github.io/ramp.xds/)  

## Installation 

**`ramp.forcing`** is a code library that extends [**`ramp.xds`.**](https://dd-harp.github.io/ramp.xds/) It aims to hold a large set of models for exogenous forcing by weather and other variables. 

To install the latest version of **`ramp.xds`** from GitHub, run the following lines of code in an R session.

```
library(devtools)
devtools::install_github("dd-harp/ramp.xds")
```

To install the latest version of **`ramp.forcing`** from Github, run the following line in an R session: 
```
devtools::install_github("dd-harp/ramp.forcing")
```

## What is RAMP?

RAMP -- **R**obust **A**nalytics for **M**alaria **P**olicy -- is a bespoke inferential system for malaria decision support and adaptive malaria control. A core goal for RAMP is to characterize, quantify, and propagate uncertainty in conventional analysis and through simulation-based analytics.

## What is **`ramp.xds`**?

**`ramp.xds`** is an R software package that supports nimble model building for simulation-based analytics and malaria research. It was designed to help research scientists and policy analysts set up, analyze, solve, and apply dynamical systems models describing the epidemiology, spatial transmission dynamics, and control of malaria and other mosquito-transmitted pathogens. The software also supports nimble model building and analysis for mosquito ecology, with the capability to handle forcing by weather and other exogenous variables. 

The software was designed around a rigorous mathematical framework for modular model building, described in [Spatial Dynamics of Malaria Transmission](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1010684) (Wu SL, *et al.* 2023. PLoS Computational Biology)^[Wu SL, Henry JM, Citron DT, Mbabazi Ssebuliba D, Nakakawa Nsumba J, Sánchez C. HM, et al. (2023) Spatial dynamics of malaria transmission. PLoS Comput Biol 19(6): e1010684. https://doi.org/10.1371/journal.pcbi.1010684]. The mathematical framework has now been extended to cover *exogenous forcing* by weather and vector control. 

## What is **`ramp.forcing`**?

**`ramp.forcing`** is a code library to build models with exogenous forcing, extending the functionality of **`ramp.xds`.** These packages are part of a suite of R packages developed to support RAMP: 

1. **`ramp.xds`** handles setup, solving, plotting, and some analysis. 
It was developed to build and solve dynamical systems models for the epidemiology, transmission dynamics, and control of malaria and other mosquito-transmitted pathogens based on a well-defined mathematical framework.
It includes a basic set of models -- enough to design, verify, and demonstrate the basic features of modular software. 

2. [**`ramp.library`**](https://dd-harp.github.io/ramp.library/) is an extended library of models -- stable code that has been tested and verified. It includes a large set of model families published in peer review that are not included in **`ramp.xds`** The ability to reuse code reduces the costs of replicating studies. Through this library, **`ramp.xds`** also supports nimble model building and analytics for other mosquito-borne pathogens. 

3. [**`ramp.control`**](https://dd-harp.github.io/ramp.control/) is a collection of disease control models for **`ramp.xds`** 

4. [**`ramp.forcing`**](https://dd-harp.github.io/ramp.forcing/) is a collection of utilities to model exogenous forcing in models for **`ramp.xds`** 

5. [**`ramp.demog`**](ramp.demog.html) is is a supplementary code library for **`ramp.xds`** that handles human demography and stratification, including vital dynamics and age structure.

6. [**`ramp.work`**](https://dd-harp.github.io/ramp.work/) includes algorithms to apply the framework, include code to fit models to data and to do constrained optimization 

