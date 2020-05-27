# qualR

The goal of qualR is to facilitate the download of air pollutants and meteorological
information from [CETESB QUALAR system](https://qualar.cetesb.sp.gov.br/qualar/home.do).
This information is often used for air quality model evaluation and
air pollution data analysis in Sao Paulo State, which are usually perform in R.

## Installation

First, you need to install `devtools`:
```R
install.packages("devtools")
```

Then, you can install qualR by:

```R
devtools::install_github("quishqa/qualR")
```

## How to use


`qualR` have 4 functions:
*  `CetesbRetrieve`: Download one parameter from one air quality station (AQS).
*  `CetesbRetrievePol`: Download criteria pollutants from one AQS.
*  `CetesbRetrieveMet`: Download meteorological parameters from one AQS.
*  `CetesbRetrieveMetPol`: Download meteorological parameters and criteria pollutants
from one AQS.

To run these functions, you need to have an account and to know the station and parameter codes. To check those parameters you can do:

```R
library(qualR)

# To see all the AQS with their codes
cetesb_aqs

# To see all parameters with their codes
cetesb_param

```

These functions return a data frame, with a `date` column in POSIXct, which allows you
to use other packages as [openair](https://davidcarslaw.github.io/openair/).


### Downloading one parameter from one AQS

If you want to download Ozone information from Pinheiros AQS, from January first to January 7th, you can do:

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code
cetesb_param # TO check Ozone pol_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
o3_code <- 63
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_o3 <- CetesbRetrieve(my_user_name,
                         my_password,
                         o3_code,
                         pin_code,
                         start_date,
                         end_date)

```


### Downloading criteria pollutants from one AQS


We use `CetesbRetrievePol`. This function already have the parameter codes for O<sub>3</sub>, NO, NO<sub>2</sub>, CO, PM<sub>10</sub> and PM<sub>2.5</sub>. So, it doesn't require `pol_code`, only `aqs_code`. CO is in ppm, the other pollutants are in ug/m<sup>3</sup>.
In this example, we download all these pollutants from Pinheiros AQS.

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_pol <- CetesbRetrievePol(my_user_name,
                             my_password,
                             pin_code,
                             start_date,
                             end_date)

```

### Downloading meteorological parameters from one AQS


We use `CetesbRetrieveMet`. This function already has the parameter codes for Temperature (&deg;C), Relative Humidity (%), Wind Speed (m/s) and wind Direction (&deg;), and Pressure (hPa). So, it doesn't require `pol_code`, only `aqs_code`.
In this example, we download all these parameters from Pinheiros AQS. Remember that CETESB uses 777 and 888 values in wind direction to indicate calm wind and no data, they appear in the final data frame.

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_met <- CetesbRetrieveMet(my_user_name,
                             my_password,
                             pin_code,
                             start_date,
                             end_date)

```
### Downloading meteorological and criteria pollutant from one AQS


This is the equivalent to run `CetesbRetrieveMet` and `CetesbRetrievePol` at the same time, and
It will return all the data in one data frame.


```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
pin_code <- 99
start_date <- "01/01/2020"
end_date <- "07/01/2020"

pin_all <- CetesbRetrieveAll(my_user_name,
                             my_password,
                             pin_code,
                             start_date,
                             end_date)
```

### One more example

Now, we want to download all the information from Ibirapuera AQS, and then export that data in `.csv` to be read by other software.

```R
library(qualR)

cetesb_aqs # To check Pinheiros aqs_code

my_user_name <- "john.doe@mymail.com"
my_password <- "drowssap"
ibi_code <- 83
start_date <- "01/01/2020"
end_date <- "07/01/2020"

ibi_all <- CetesbRetrieveAll(my_user_name,
                             my_password,
                             ibi_code,
                             start_date,
                             end_date)

# To export the data frame we use write.table()
write.table(ibi_all, "ibi_all.csv", sep = ",", row.names = F)
```

## Caveat emptor

* CETESB QUALAR system describes midnight as 24:00, for that reason the first hour
will be `NA`, because the data in CETESB starts at 01:00, and in `qualR` from 00:00.
For that reason, consider download one day before your study period.
* To pad-out with `NA` when there is a missing date, `qualR` "tricks" the date
information, an assume it's on **UTC** (when in reality it's on **"America/Sao_Paulo"** time).
This avoids problems with merging data frames and also with Daylight saving time (DST) issues. Beware of this,when dealing with study periods that include **DST**. It always a good idea, to double check by retrieving the suspicious date from CETESB QUALAR system.


## Acknowledgments

Thanks to [CETESB](https://cetesb.sp.gov.br/ar/) for make public this atmospheric data.

## Last but not least

I hope this package will help you on your research!
