# qualR: An R package to download São Paulo and Rio de Janeiro air pollution data
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/quishqa/qualR?branch=master&svg=true)](https://ci.appveyor.com/project/quishqa/qualR)  [![Coverage Status](https://img.shields.io/codecov/c/github/quishqa/qualR/master.svg)](https://codecov.io/github/quishqa/qualR?branch=master) [![DOI](https://zenodo.org/badge/267442363.svg)](https://zenodo.org/badge/latestdoi/267442363) [![](https://badges.ropensci.org/474_status.svg)](https://github.com/ropensci/software-review/issues/474)



The goal of `qualR` is to facilitate the download of air pollutants and meteorological
information from [CETESB QUALAR System](https://qualar.cetesb.sp.gov.br/qualar/home.do) for São Paulo, and [MonitorAr Program](https://www.data.rio/datasets/dados-hor%C3%A1rios-do-monitoramento-da-qualidade-do-ar-monitorar), for Rio de Janeiro.
This information is often used for air pollution data analysis and for air quality model evaluation.

`qualR` functions return completed data frames (missing hours padded out with `NA`),
 with a `date` column in `POSIXct` for temporal aggregation and for compatibility with [`openair` package ](https://github.com/davidcarslaw/openair).
 `qualR` improves air pollution research by easily producing ready-to-use datasets, by facilitating exploratory data analysis, and by fostering reproducibility.

## Installation

First, you need to install `devtools`:
```R
install.packages("devtools")
```

Then, you can install `qualR` by:

```R
devtools::install_github("ropensci/qualR")
```

Or, you can install it directly using:
```R
install.packages("qualR", repos="https//ropensci.r-universe.dev")
```
## How to use


`qualR` have the following functions:

 * `cetesb_retrieve_param`: Download a list of different parameter from one air quality station (AQS) from CETESB QUALAR System.
 * `cetesb_retrieve_pol`: Download criteria pollutants from one AQS from CETESB QUALAR System.
 * `cetesb_retrieve_met`: Download meteorological parameters from one AQS from CETESB QUALAR System.
 * `cetesb_retrieve_met_pol`: Download meteorological parameters and criteria pollutants from one AQS from CETESB QUALAR System.
 * `monitor_ar_retrieve_param`: Download a list of different parameters from MonitorAr - Rio program.
 * `monitor_ar_retrieve_pol`: Download criteria pollutants from one AQS from MonitorAr - Rio program.
 * `monitor_ar_retrieve_met`: Download meteorological parameters from one AQS from MonitorAr - Rio program.
 * `monitor_ar_retrieve_met_pol`: Download meteorological parameters and criteria pollutants from one AQS from MonitorAr - Rio Program.


These functions return a data frame, with a `date` column in POSIXct, which allows you
to use other packages for data analysis, such as [openair](https://davidcarslaw.github.io/openair/).


To download the information for São Paulo, you first need to have an account in [CETESB QUALAR system](https://qualar.cetesb.sp.gov.br/qualar/home.do).
[Here](https://seguranca.cetesb.sp.gov.br/Home/CadastrarUsuario), you can sign up to CETESB QUALAR system.
MonitorAr doesn't require an account.

Then you have to know the AQS and parameter codes (i.e. pollutant or meteorological data) to use these functions.
Currently, `cetesb_retrieve` family functions also accept the parameter abbreviation (i.e "O3" instead of 63), and the complete name of the AQS (i.e "Pinheiros" instead of 99) as inputs.
To check those parameters you can check the following datasets:

```R
library(qualR)

# To see all CETESB AQS names with their codes and lat lon
cetesb_aqs

# To see all CETESB AQS parameters with their codes and abbreviation
cetesb_param

# To see all MonitorAr-Rio AQS names with their codes and lat and lon
monitor_ar_aqs

# To see all MonitorAr-Rio parameters with their codes
monitor_ar_param

```

## Using `qualR` to download CETESB data

#### Downloading multiple parameter from one AQS

If you want to download Ozone information from Pinheiros AQS, from January first to January 7th, you can do:

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code
cetesb_param # To check Ozone pol_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_o3 <- cetesb_retrieve_param(my_user_name,
                              my_password,
                              "O3",
                              pin_code, # It could also be "Pinheiros"
                              start_date,
                              end_date)

```
(Note: Previous `cetesb_retrieve` function now is depreciated use `cetesb_retrieve_param` instead)

Maybe you just need a couple of parameters.
For example, if you want to download ozone and wind speed and direction from Pinheiros AQS,
you can do the following:

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
start_date <- "01/01/2020"
end_date <- "07/01/2020"

cetesb_param # To check ozone, wind speed and wind direction abbreviations

pin_o3_ws_wd <- cetesb_retrieve_param(my_user_name,
                                    my_password,
                                    c("O3", "VV", "VD"),
                                    "Pinheiros",
                                    start_date = "01/01/2020",
                                    end_date = "07/01/2020")

```

#### Downloading criteria pollutants from one AQS

We use `cetesb_retrieve_pol`. This function already have the parameter codes for O<sub>3</sub>, NO, NO<sub>2</sub>,  NO<sub>X</sub>, CO, PM<sub>10</sub> and PM<sub>2.5</sub>. So, it doesn't require `pol_code`, only `aqs_code`. CO is in ppm and  NO<sub>X</sub> is in ppb, the other pollutants are in &mu;g/m<sup>3</sup>.
In this example, we download all these pollutants from Pinheiros AQS.

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_pol <- cetesb_retrieve_pol(my_user_name,
                             my_password,
                             pin_code, # It could also be "Pinheiros"
                             start_date,
                             end_date)

```

#### Downloading meteorological parameters from one AQS

We use `cetesb_retrieve_met`. This function already has the parameter codes for Temperature (&deg;C), Relative Humidity (%), Wind Speed (m/s) and wind Direction (&deg;), and Pressure (hPa). So, it doesn't require `pol_code`, only `aqs_code`.
In this example, we download all these parameters from Pinheiros AQS. Remember that CETESB uses 777 and 888 values in wind direction to indicate calm wind and no data, these values appear in the final data frame.

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_met <- cetesb_retrieve_met(my_user_name,
                             my_password,
                             pin_code, # It could also be Pinheiros
                             start_date,
                             end_date)

```
#### Downloading meteorological and criteria pollutant from one AQS

This is the equivalent to run `cetesb_retrieve_met` and `cetesb_retrieve_pol` at the same time, and
It will return all the data in one data frame.

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_all <- cetesb_retrieve_met_pol(my_user_name,
                                my_password,
                                pin_code,
                                start_date,
                                end_date)
```
#### Some other examples

##### To `.csv`

Now, We want to download all the information from Ibirapuera AQS, and then export
this data in `.csv` to be read by other software.
`qualR` functions have the argument `to_csv`, which by default has a `FALSE` value.
So, if you want to export the data to `csv`, you just need to change it to `TRUE`.

The csv file have the following file name: `{aqs_name}_{pol}_{start_date}_{end_date}.csv`.
For the functions that retrieve more than one parameter the file name is:
`{aqs_name}_{TYPE}_{start_date}_{end_date}.csv`, where `TYPE` is "POL", "MET", or "MET_POL".

```R
library(qualR)

cetesb_aqs # To check Ibirapuera aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
ibi_code <- 83
start_date <- "01/01/2020"
end_date <- "07/01/2020"

ibi_all <- cetesb_retrieve_met_pol(my_user_name,
                                my_password,
                                ibi_code,
                                start_date,
                                end_date,
                                to_csv = TRUE)

```

In this case, we will get the file `Ibirapuera_MET_POL_01-01-2020_07-01-2020.csv`.

##### A variable from all CETESB AQS

Sometimes, to check the spatial distribution of air pollutants, you need to download a pollutant from all the AQS.
In this example, we download a year of Ozone from all CETESB AQS.

```R
library(qualR)

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
o3_code <- 63
start_date <- "01/01/2019"
end_date <- "31/12/2019"

# All_o3 is a list with a data frame per AQS
all_o3 <- lapply(cetesb_aqs$code, cetesb_retrieve_param,
                 username = my_user_name,
                 password = my_password,
                 parameters = "O3",
                 start_date = start_date,
                 end_date = end_date)

# If you want  to export all in csv
all_o3_csv <- do.call(rbind, all_o3)
write.table(all_o3_csv, "all_o3_csv.csv", sep = ",", row.names = F)

```

##### AQS latitudes and longitudes

Maybe you need to make a map of the AQS you used in your study.
Now, we added latitude and longitude in degrees in the `cetesb_aqs` dataset:

```R
library(qualR)

# To see all the AQS latitude and longitude
cetesb_aqs
```

Here are some examples to make some plots:
* [A  pollutant concentration point map.](https://randroll.wordpress.com/2020/06/18/a-point-concentration-map-with-r/)
* [An AQS location map.](https://randroll.wordpress.com/2019/10/28/heatmaps-in-r-an-example-using-ozone-concentrations/)
* [An AQS location map using shapefiles.](https://randroll.wordpress.com/2018/04/18/making-a-simple-map-with-r/)

##### A better way to save your credentials

It is not so safe to write your user and password when you are coding,
it is even more dangerous when we have to share our scripts.
For this reason, it is a better practice (and safer) to save your credentials (i.e. user and password) in your **global environment**.

An easier way to do it is by using `usethis` package.
So, first install it by:

```R
install.packages("usethis")
```

Then use the function `edit_r_environ()`.
It will show a new file called `.Renviron`, where you'll define your user and password.

```R
library(usethis)

edit_r_environ()
```

It will open `.Renviron` file, there you define your credentials:
```R
QUALAR_USER="john.doe@mymail.com"
QUALAR_PASS="drowssap"
```
Save it, and the changes will work after restart R.
To call them, you use `Sys.getenv()`.

So now, if we replicate the previous example *Downloading multiple parameter from one AQS*, it will be something like this:

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code
cetesb_param # To check Ozone pol_code

o3_code <- 63
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_o3 <- cetesb_retrieve_param(Sys.getenv("QUALAR_USER"), # calling your user
                              Sys.getenv("QUALAR_PASS"),  # calling your passord  
                              o3_code,
                              pin_code,
                              start_date,
                              end_date)
```

This idea came from this [awesome post](https://towardsdatascience.com/ten-time-saving-r-hacks-b411add26b96).


## Using `qualR` to download MonitorAr - Rio data

#### Downloading one parameter from one AQS

Here we will download Ozone information from Iraja AQS for all February 2019 by using `monitor_ar_retrieve_param` function.

```R
library(qualR)
monitor_ar_aqs # To check Iraja AQS code
monitor_ar_param # To check Ozone code

start_date <- "01/02/2019"
end_date <- "01/03/2019"
aqs_code <- "IR"
param <- "O3"

ir_o3 <- monitor_ar_retrieve_param(date_start, date_end, aqs_code, param)

```

#### Downloading multiple parameters from one AQS

`monitor_ar_retrieve_param` is similar to `cetesb_retrieve_param`, so it allows us to download multiple parameters.
Here, we will download Ozone, Nitric oxide, Nitrogen dioxide, wind speed and direction.

```R
library(qualR)
monitor_ar_aqs # To check Iraja AQS code
monitor_ar_param # To check parameter codes

date_start <- "01/02/2019"
date_end <- "01/03/2019"
aqs_code <- "IR"
params <- c("O3", "NO", "NO2", "Dir_Vento", "Vel_Vento")


ir_data <- monitor_ar_retrieve_param(date_start, date_end, aqs_code, params)
```


## Caveat emptor

* CETESB QUALAR system describes midnight as 24:00,
and the first hour of each day starts at 1:00. `qualR` transform it to get the time in 00-23 hour notation, for that reason you'll get `NA` at 00:00 of your first downloaded day. So, consider download one day before your study period.
* To pad-out with `NA` when there is a missing date, `qualR` "tricks" the date
information, an assume it's on **UTC** (when in reality it's on **"America/Sao_Paulo"** time).
This avoids problems with merging data frames and also with Daylight saving time (DST) issues.
 Beware of this,when dealing with study periods that include **DST**.
 It always a good idea, to double check by retrieving the suspicious date from CETESB QUALAR system.
* Take into account that in CETESB data, the hourly averaged is the mean **until the  hour**.
That is, a concentration value for **22:00 is the mean from 21:01 to 22:00**.
* Currently, MonitorAr only has data until March, 2021.

## Code of Conduct

Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/).
By contributing to this project, you agree to abide by its terms.

## Acknowledgments

Thanks to [CETESB](https://cetesb.sp.gov.br/ar/) and to [MonitorAr Program](https://www.rio.rj.gov.br/web/smac/monitorar-rio1) for make public this atmospheric data.

This work was supported by the Wellcome Trust [grant number 216087/Z/19/Z].
We acknowledge the programs CAPES (Coordenadoria de Aperfeiçoamento de Pessoal de Nível Superior), CNPq (Conselho Nacional de Desenvolvimento Científico e Tecnológico), FAPESP (2016/18438-0 - Fundação de Amparo à Pesquisa do Estado do São Paulo).

Finally, we want to thanks to the [LAPAT-IAG team](http://www.lapat.iag.usp.br/) for test and help to improve `qualR`.

## Last but not least

I hope this package will help you on your research!
