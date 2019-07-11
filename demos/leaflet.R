# load packages
library(dplyr)
library(ggplot2)
library(rjson)
library(jsonlite)
library(leaflet)
library(RCurl)

rm(list=ls())


# Simple demo from https://www.earthdatascience.org/courses/earth-analytics/get-data-using-apis/leaflet-r/

r_birthplace_map <- leaflet() %>%
    addTiles() %>%  # use the default base map which is OpenStreetMap tiles
    addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
r_birthplace_map
