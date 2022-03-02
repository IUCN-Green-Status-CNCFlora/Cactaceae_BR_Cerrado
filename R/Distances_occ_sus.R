#### Distances concurrences and SUs

library(dplyr)
library(sf)
library(readr)
library(purrr)
library(geosphere)



all_csv <- list.files("data/in_occurrences",pattern = ".csv", full.names = T) |> 
  map(~read_csv(.)) |> 
  purrr::map(~distm(.)) 
  
  
  


