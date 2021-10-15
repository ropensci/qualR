# qualR 0.9.5

## Changes
- `CetesbRetrive` function is now depreciated. Use `CetesbRetrieveParam` instead.
- `CetesbRetrieveAll` is now called `CetesbRetrieveMetPol`

## New Features
- [Monitor Ar Program air quality network](https://www.rio.rj.gov.br/web/smac/monitorar-rio1) is included.  Download meteorological parameters and air pollution from Rio de Janeiro city are now available through `MonitorArRetrieve` functions.
- All functions has verbose option to print query summary.
- All functions can export downloaded data to `.csv` files.
- Units added in parameters datasets `cetesb_param`and `monitor_ar_param`.

## Bug Fixes
- Now `qualR` uses `httr` instead of `RCurl` package to fix SSL23_SERVER_HELLO error on Windows.


# qualR 0.9.1

## Features
- Initial version
- Download one parameter from one air quality station with `CetesbRetrieve` funcion.
- Download criteria pollutants from one air quality station with `CetesbRetrievePol` funcion.
- Download meteorological parameters from one air quality station with `CetesbRetrieveMet` funcion.
- Download criteria pollutants anf meteorological parameters from one air quality station with `CetesbRetrieveAll` funcion.
