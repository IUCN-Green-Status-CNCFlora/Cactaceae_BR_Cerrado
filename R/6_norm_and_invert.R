

# Required packages -------------------------------------------------------

library(dplyr)
library(tidyverse)
library("spatialEco")
library(raster)


# Species names -----------------------------------------------------------

species_list <- read_csv("./occs/occs_all.csv")

species_list$species <-
  gsub(x = species_list$species,
       pattern = " ",
       replacement = "_")

sp.names <- unique(species_list$species)



# CURRENT -----------------------------------------------------------------

# Reading rasters ---------------------------------------------------------

list.var.present <-
  list.files(paste0("./outputs/pres"),
             recursive = TRUE,
             pattern = "tif",
             full.names = TRUE
  )
current <- stack(list.var.present)


# Normalizing and inverting scale ---------------------------------------


for(i in 1:dim(current)[3]){
  
  minimo <- min(current[[i]][], na.rm=T)
  maximo <- max(current[[i]][], na.rm=T)
  
  normalizar <- function(x) {
    (x-minimo)/(maximo-minimo)}
  
  norm <- normalizar(current[[i]])
  
  norm_inv <- 
    (((norm - max(norm[], na.rm=T)) * -1) + min(norm[], na.rm=T))
  
  writeRaster(
    norm_inv,
    filename = paste0('./outputs/norm_inv/pres/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}



# FUTURE ------------------------------------------------------------------

# Reading rasters ---------------------------------------------------------

# 2011-2040

scenario_1 <- list.files(
  paste0("./outputs/proj/2011_40_126"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_1 <- stack(scenario_1)

scenario_2 <- list.files(
  paste0("./outputs/proj/2011_40_585"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_2 <- stack(scenario_2)


# 2071-2100

scenario_3 <- list.files(
  paste0("./outputs/proj/2071_00_126"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_3 <- stack(scenario_3)

scenario_4 <- list.files(
  paste0("./outputs/proj/2071_00_585"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_4 <- stack(scenario_4)


# Normalizing and inverting scale ---------------------------------------

# 2011_40_126

for(i in 1:dim(scenario_1)[3]){
  
  minimo <- min(scenario_1[[i]][], na.rm=T)
  maximo <- max(scenario_1[[i]][], na.rm=T)
  
  normalizar <- function(x) {
    (x-minimo)/(maximo-minimo)}
  
  norm <- normalizar(scenario_1[[i]])
  
  norm_inv <- 
    (((norm - max(norm[], na.rm=T)) * -1) + min(norm[], na.rm=T))
  
  writeRaster(
    norm_inv,
    filename = paste0('./outputs/norm_inv/proj/2011_40_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}

# 2011_40_585

for(i in 1:dim(scenario_2)[3]){
  
  minimo <- min(scenario_2[[i]][], na.rm=T)
  maximo <- max(scenario_2[[i]][], na.rm=T)
  
  normalizar <- function(x) {
    (x-minimo)/(maximo-minimo)}
  
  norm <- normalizar(scenario_2[[i]])
  
  norm_inv <- 
    (((norm - max(norm[], na.rm=T)) * -1) + min(norm[], na.rm=T))
  
  writeRaster(
    norm_inv,
    filename = paste0('./outputs/norm_inv/proj/2011_40_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}

# 2071_00_126

for(i in 1:dim(scenario_3)[3]){
  
  minimo <- min(scenario_3[[i]][], na.rm=T)
  maximo <- max(scenario_3[[i]][], na.rm=T)
  
  normalizar <- function(x) {
    (x-minimo)/(maximo-minimo)}
  
  norm <- normalizar(scenario_3[[i]])
  
  norm_inv <- 
    (((norm - max(norm[], na.rm=T)) * -1) + min(norm[], na.rm=T))
  
  writeRaster(
    norm_inv,
    filename = paste0('./outputs/norm_inv/proj/2071_00_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}

# 2071_00_585

for(i in 1:dim(scenario_4)[3]){
  
  minimo <- min(scenario_4[[i]][], na.rm=T)
  maximo <- max(scenario_4[[i]][], na.rm=T)
  
  normalizar <- function(x) {
    (x-minimo)/(maximo-minimo)}
  
  norm <- normalizar(scenario_4[[i]])
  
  norm_inv <- 
    (((norm - max(norm[], na.rm=T)) * -1) + min(norm[], na.rm=T))
  
  writeRaster(
    norm_inv,
    filename = paste0('./outputs/norm_inv/proj/2071_00_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}
