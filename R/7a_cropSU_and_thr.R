# Required packages -------------------------------------------------------

library(dplyr)
library(tidyverse)
library("spatialEco")
library(raster)
library(rgdal)


# Species names -----------------------------------------------------------

species_list <- read_csv("./occs/occs_all.csv")

species_list$species <-
  gsub(x = species_list$species,
       pattern = " ",
       replacement = "_")

sp.names <- unique(species_list$species)


# Reading SUs -------------------------------------------------------------

list.SUs <-
  list.files(
    paste0("./SUs"),
    recursive = TRUE,
    pattern = "*.shp",
    full.names = TRUE
  )
SUs <- lapply(list.SUs, readOGR)



# CURRENT -----------------------------------------------------------------

# Reading rasters ---------------------------------------------------------

list.var.present <-
  list.files(
    paste0("./outputs/norm_inv/pres"),
    recursive = TRUE,
    pattern = "tif",
    full.names = TRUE
  )
current <- stack(list.var.present)


# Cropping for SUs extension and applying the threshold -------------------


for (i in 1:dim(current)[3]) {
  
  # Cropping the continuous models
  ED_cont_SU <- crop(current[[i]], SUs[[i]])
  ED_cont_SU_m <- mask(ED_cont_SU, SUs[[i]])
  
  writeRaster(
    ED_cont_SU_m,
    filename = paste0('./outputs/crop/crop_cont/pres/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE)
    
  # Applying a threshold 
    norm_inv_thr = current[[i]]
    norm_inv_thr[norm_inv_thr <= 0.5] <- 0
    norm_inv_thr[norm_inv_thr > 0.5] <- 1
    
    writeRaster(
      norm_inv_thr,
      filename = paste0('./outputs/norm_inv_thr/pres/', sp.names[i]),
      format = "GTiff",
      bylayer = TRUE,
      overwrite = TRUE
    )
    
    # Cropping the binary models 
    norm_inv_thr_SU <- crop(norm_inv_thr, SUs[[i]])
    ED_SU <- mask(norm_inv_thr_SU, SUs[[i]])
    
    writeRaster(
      ED_SU,
      filename = paste0('./outputs/crop/crop_bin/pres/', sp.names[i]),
      format = "GTiff",
      bylayer = TRUE,
      overwrite = TRUE
    )
    
}
