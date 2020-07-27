---
title: 'qualR: An R package to download Sao Paulo air pollution data'
tags:
  - R
  - air pollution
  - meteorology
  - open data
authors:
  - name: Mario Gavidia-Calderón
    orcid: 0000-0002-7371-1116
    affiliation: '1'
  - name: Maria de Fatima Andrade
    orcid: 0000-0001-5351-8311
    affiliation: '1'
affiliations:
 - name: Institute of Astronomy, Geophysics, and Atmospheric Sciences, University of Sao Paulo, Brazil
   index: 1
date: 20 July 2020
bibliography: paper.bib
---

# Summary
Air quality monitoring networks provide air pollutant concentration for a given
time and space.
We can use this data to monitor the atmosphere for public health reasons.
It can also be used to validate emission control policies and the performance
of air quality models [@Seinfeld2016].

The Sao Paulo State Environmental Agency (CETESB) manages the
Air Quality Station network of the State of Sao Paulo.
It is one of the best air quality monitoring systems in the region
[@Riojas-Rodriguez2016].
This network covers the Metropolitan Area of Sao Paulo (MASP), the biggest megacity in
South America.
Researchers use its data in field and modeling studies, to analyse air
pollution in the MASP [@Andrade2017].
R is a suitable data analysis tool for these studies in MASP,
and its adoption in the air quality modeling community is
steadily increasing [@Gavidia-Calderon2018; @Ibarra-Espinosa2018 ].

The pollutant and meteorological data are publicly available via the
[CETESB QUALAR System](https://cetesb.sp.gov.br/ar/qualar/).
QUALAR allows researchers to download data from the air quality station (AQS) in `.csv`
files, one variable at a time.
This data needs preprocessing before being suitable for analysis.
For example, instrument malfunctions can produce missing dates; time format might
need adjustments, or the decimal separator need to be changed.

Around 80% of time in data analysis is devoted to data preparation [@Dasu2003].
`qualR` streamlines this process producing high-quality data ready for
analysis.
It is built in R [@RCoreTeam2020] and uses functions from the XML[@XML] and
Rcurl [@RCurl] packages.
`qualR` positively impacts research by allowing easy and fast data
manipulation for Sao Paulo air pollution data.

# Statement of need
Currently, the [CETESB QUALAR System](https://cetesb.sp.gov.br/ar/qualar/) is
the only way of accessing the CETESB automatic air quality network.
It requires having account to download one parameter per AQS at a time.
`qualR` streamlines this process, allowing access to multiple parameters from
multiple stations simultaneously.
It also handles missing data by assigning `NA` values, ensuring a complete
dataset.
All `qualR` functions return data frames with a `date` column in POSIXct type.
This ensures compatibility with robust temporal analysis packages like
`openair` [@Carslaw2012].

# Functions and data

`qualR` has four functions:

| Function           | Description                                    |
|--------------------|------------------------------------------------|
| CetesbRetrieve     | Download one parameter from one AQS            |
| CetesbRetrievePol  | Download criteria pollutants from one AQS      |
| CetesbRetrieveMet  | Download meteorological parameters from one AQS|
| CetesbRetrieveAll  | Download criteria pollutants and meteorological parameter from one AQS|            

`qualR` depends on datasets to check for AQS and parameter codes.
The functions above depend on them.  
It also contains a dataset with AQS coordinates for mapping purposes.

| Dataset       | Description                              |
|---------------|------------------------------------------|
| cetesb_aqs    | AQS name and AQS QUALAR code             |
| cetesb_param  | Parameter name and parameter QUALAR code       |
| cetesb_latlon | AQS name code and latitude and longitude |

# Example of use

In this example, we download ozone concentration from the Pinheiros AQS for January
2020:

```R
library(qualR)

# To check Pinheiros code
cetesb_aqs

# To check Ozone code
cetesb_param

user_name <- "johnDoe@supermail.com"
my_password  <- "an_unbreakable_password"
o3_code <- 63
pinheiros_code  <- 99
start_day <- "01/01/2020"
end_day   <- "30/01/2020"

pin_o3 <- CetesbRetrieve(username = user_name,
                         password = my_password,
                         pol_code = o3_code,
                         aqs_code = pinheiros_code,
                         start_date = start_date,
                         end_date = end_day)


```

We can download criteria pollutants from Pinheiros AQS for the same
period using the `CetesbRetrievePol` function. Further, we show how the output
is ready to be used with openair's `summaryPlot` function, the resulting plot
is shown in Figure 1.

```R
library(qualR)
library(openair)

pin_pols <- CetesbRetrievePol(username = user_name,
                              password = my_password,
                              aqs_code = pinheiros_code,
                              start_date = start_date,
                              end_date = end_day)

summaryPlot(pin_pols, period = "months")

```

![Summary plot created using `CetesbRetrievePol` output and openair `summaryPlot` function](summary_plot_pinheiros.svg)

# Acknowledgements

We acknowledge CETESB for providing reliable atmospheric data,
the [LAPAT-IAG](http://www.lapat.iag.usp.br/) team for testing and
reporting issues, and Carlos Gavidia-Calderon for his technical advise.

# References
