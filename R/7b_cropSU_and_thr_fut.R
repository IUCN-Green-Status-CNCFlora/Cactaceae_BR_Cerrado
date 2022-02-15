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


# FUTURE ------------------------------------------------------------------

# Reading rasters ---------------------------------------------------------

# 2011-2040

scenario_1 <- list.files(
  paste0("./outputs/norm_inv/proj/2011_40_126"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_1 <- stack(scenario_1)

scenario_2 <- list.files(
  paste0("./outputs/norm_inv/proj/2011_40_585"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_2 <- stack(scenario_2)

# 2071-2100

scenario_3 <- list.files(
  paste0("./outputs/norm_inv/proj/2071_00_126"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_3 <- stack(scenario_3)

scenario_4 <- list.files(
  paste0("./outputs/norm_inv/proj/2071_00_585"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
scenario_4 <- stack(scenario_4)


# Cropping for SUs extension and applying the threshold -------------------

# 2011-2040

# 126

for (i in 1:dim(scenario_1)[3]) {
  
  # Cropping the continuous models
  ED_cont_SU <- crop(scenario_1[[i]], SUs[[i]])
  ED_cont_SU_m <- mask(ED_cont_SU, SUs[[i]])
  
  writeRaster(
    ED_cont_SU_m,
    filename = paste0('./outputs/crop/crop_cont/proj/2011_40_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE)
  
  # Applying a threshold 
  norm_inv_thr = scenario_1[[i]]
  norm_inv_thr[norm_inv_thr <= 0.5] <- 0
  norm_inv_thr[norm_inv_thr > 0.5] <- 1
  
  writeRaster(
    norm_inv_thr,
    filename = paste0('./outputs/norm_inv_thr/proj/2011_40_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
  # Cropping the binary models 
  norm_inv_thr_SU <- crop(norm_inv_thr, SUs[[i]])
  ED_SU <- mask(norm_inv_thr_SU, SUs[[i]])
  
  writeRaster(
    ED_SU,
    filename = paste0('./outputs/crop/crop_bin/proj/2011_40_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}


# 2011-2040

# 585

for (i in 1:dim(scenario_2)[3]) {
  
  # Cropping the continuous models
  ED_cont_SU <- crop(scenario_2[[i]], SUs[[i]])
  ED_cont_SU_m <- mask(ED_cont_SU, SUs[[i]])
  
  writeRaster(
    ED_cont_SU_m,
    filename = paste0('./outputs/crop/crop_cont/proj/2011_40_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE)
  
  # Applying a threshold 
  norm_inv_thr = scenario_2[[i]]
  norm_inv_thr[norm_inv_thr <= 0.5] <- 0
  norm_inv_thr[norm_inv_thr > 0.5] <- 1
  
  writeRaster(
    norm_inv_thr,
    filename = paste0('./outputs/norm_inv_thr/proj/2011_40_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
  # Cropping the binary models 
  norm_inv_thr_SU <- crop(norm_inv_thr, SUs[[i]])
  ED_SU <- mask(norm_inv_thr_SU, SUs[[i]])
  
  writeRaster(
    ED_SU,
    filename = paste0('./outputs/crop/crop_bin/proj/2011_40_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}

# 2071-2100

# 126

for (i in 1:dim(scenario_3)[3]) {
  
  # Cropping the continuous models
  ED_cont_SU <- crop(scenario_3[[i]], SUs[[i]])
  ED_cont_SU_m <- mask(ED_cont_SU, SUs[[i]])
  
  writeRaster(
    ED_cont_SU_m,
    filename = paste0('./outputs/crop/crop_cont/proj/2071_00_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE)
  
  # Applying a threshold 
  norm_inv_thr = scenario_3[[i]]
  norm_inv_thr[norm_inv_thr <= 0.5] <- 0
  norm_inv_thr[norm_inv_thr > 0.5] <- 1
  
  writeRaster(
    norm_inv_thr,
    filename = paste0('./outputs/norm_inv_thr/proj/2071_00_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
  # Cropping the binary models 
  norm_inv_thr_SU <- crop(norm_inv_thr, SUs[[i]])
  ED_SU <- mask(norm_inv_thr_SU, SUs[[i]])
  
  writeRaster(
    ED_SU,
    filename = paste0('./outputs/crop/crop_bin/proj/2071_00_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}

# 2071-2100

# 585

for (i in 1:dim(scenario_4)[3]) {
  
  # Cropping the continuous models
  ED_cont_SU <- crop(scenario_4[[i]], SUs[[i]])
  ED_cont_SU_m <- mask(ED_cont_SU, SUs[[i]])
  
  writeRaster(
    ED_cont_SU_m,
    filename = paste0('./outputs/crop/crop_cont/proj/2071_00_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE)
  
  # Applying a threshold 
  norm_inv_thr = scenario_4[[i]]
  norm_inv_thr[norm_inv_thr <= 0.5] <- 0
  norm_inv_thr[norm_inv_thr > 0.5] <- 1
  
  writeRaster(
    norm_inv_thr,
    filename = paste0('./outputs/norm_inv_thr/proj/2071_00_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
  # Cropping the binary models 
  norm_inv_thr_SU <- crop(norm_inv_thr, SUs[[i]])
  ED_SU <- mask(norm_inv_thr_SU, SUs[[i]])
  
  writeRaster(
    ED_SU,
    filename = paste0('./outputs/crop/crop_bin/proj/2071_00_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )
  
}
