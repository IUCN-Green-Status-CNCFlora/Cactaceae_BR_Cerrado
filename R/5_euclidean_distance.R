
# Credits ---------------------------

# Authors: Bruno Vilela, Filipe Augusto Nascimento & Marcos Vinícius Carneiro Vital
# Tittle: Impacts of climate change on small-ranged amphibians of the northern Atlantic Forest
# Oecologia Australis 22(2) 2018
# doi: 10.4257/oeco.2018.2202.03

# Edited by
# Luara Tourinho (https://github.com/luaratourinho)
# Last update: 12 nov 2021



# Required packages -------------------------------------------------------

library(sp)
library(maptools)
library(vegan)
library(geosphere)
library(dismo)
library(letsR)
library(sf)
library(dplyr)
library(tidyverse)
library(raster)

# Species list ------------------------------------------------------------

species_list <- read_csv("./occs/occs_all.csv")

species_list$species <-
  gsub(x = species_list$species,
       pattern = " ",
       replacement = "_")

sp.names <- unique(species_list$species)

# Preparing the data ------------------------------------------------------

# Environment variables
# present
list.var.present <-
  list.files(paste0("./pca/veg_mais_SUs/pres/"),
    recursive = TRUE,
    pattern = "tif",
    full.names = TRUE
  )
predictors <- stack(list.var.present)
names(predictors) <- c(paste0("pc0", 1:7))


# Future
# 2011-2040, i.e. first interest period P1
scenario_1 <- list.files(
  paste0("./pca/veg_mais_SUs/proj/2011_2040/ssp126/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)

scenario_1 <- stack(scenario_1)
names(scenario_1) <- c(paste0("pc0", 1:7))


scenario_2 <- list.files(
  paste0("./pca/veg_mais_SUs/proj/2011_2040/ssp585/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)

scenario_2 <- stack(scenario_2)
names(scenario_2) <- c(paste0("pc0", 1:7))

future_var_P1 <- list(scenario_1, scenario_2)
names(future_var_P1) <- c(126, 585)


#2071-2100, i.e. second interest period P2
scenario_3 <- list.files(
  paste0("./pca/veg_mais_SUs/proj/2071_2100/ssp126/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)

scenario_3 <- stack(scenario_3)
names(scenario_3) <- c(paste0("pc0", 1:7))

scenario_4 <- list.files(
  paste0("./pca/veg_mais_SUs/proj/2071_2100/ssp585/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)

scenario_4 <- stack(scenario_4)
names(scenario_4) <- c(paste0("pc0", 1:7))

future_var_P2 <- list(scenario_3, scenario_4)
names(future_var_P2) <- c(126, 585)


# Standardization of predictors (mean = 0, sd = 2)
valores <- values(predictors)
remove <- is.na(valores[, 1])
valores_P1 <- lapply(future_var_P1, values)
valores_P2 <- lapply(future_var_P2, values)
valores_P1 <-
  lapply(valores_P1, function(x, rem) {
    x[!rem,]
  }, rem = remove)
valores_P2 <-
  lapply(valores_P2, function(x, rem) {
    x[!rem,]
  }, rem = remove)
valores <- valores[!remove,]


#1:n, n is the number of scenarios, here, 1 current and 4 futures
ID <- rep(1:5, each = nrow(valores)) 
complete.table <- rbind(valores,
                        do.call(rbind, valores_P1),
                        do.call(rbind, valores_P2))
decos <-
  apply(complete.table,
        2,
        decostand,
        method = "standardize",
        na.rm = TRUE)

#returning values to raster
values(predictors)[!remove,] <- decos[ID == 1,] 


plot(predictors)
for (i in 1:length(valores_P1)) {
  valores_P1[[i]] <- decos[ID == i + 1,]
}
for (i in 1:length(valores_P2)) {
  valores_P2[[i]] <- decos[ID == i + 5,]
}


# Occurrence records
occurrence <- read.csv(paste0("./occs/occs_all.csv"), header = T)
occurrence <- occurrence[!is.na(raster::extract(raster(predictors, 1), occurrence[, 2:3])),]
plot(raster(predictors, 1))
points(occurrence[, 2:3], col = "red")
plot(raster(predictors, 2))
points(occurrence[, 2:3], col = "red")


# Species
species <- as.factor(occurrence[, 1])
spp <- levels(species)
N_of_occurrences_per_species <- table(species)
# write.table(
#   N_of_occurrences_per_species,
#   file = "Results/N_of_occurrences_per_species.txt",
#   row.names = FALSE,
#   sep = "\t"
# )
reference <- raster::extract(predictors, occurrence[, 2:3])
valores <- values(predictors)



# Euclidean distance ------------------------------------------------------


# Env dist
N_species <- length(spp)
N_occurrences <- nrow(reference)

# Euclidean function
euclidean <- function(x,
                      n_oc = N_occurrences,
                      rem = remove,
                      n_sp = N_species,
                      ref = reference,
                      sp = species,
                      sp2 = spp) {
  s_rem <- nrow(x)
  eu <- matrix(ncol = n_oc, nrow = s_rem)
  for (i in 1:n_oc) {
    eu1 <- (ref[i, 1] - x[, 1]) ^ 2
    eu2 <- (ref[i, 2] - x[, 2]) ^ 2 #repetir para a quantidade de variaveis
    eu[, i] <- sqrt(eu1 + eu2)
  }
  # summarize per species
  result <- matrix(ncol = n_sp, nrow = s_rem)
  colnames(result) <- sp2
  for (i in 1:n_sp) {
    result[, i] <- apply(eu[, sp == sp2[i], drop = F], 1, mean)
  }
  return(result)
}

# Env dist to the present
eu.present <- euclidean(x = decos[ID == 1,]) 


# Plots
for (i in 1:N_species) {
  r <- raster(predictors, 1)
  values(r)[!remove] <- eu.present[, i]
  plot(r, main = colnames(eu.present)[i], col = gray.colors(100))
  points(occurrence[species == colnames(eu.present)[i], 2:3],
         pch = 20,
         col = rgb(1, 0, 0, .3),
         cex = 2)
  writeRaster(
    r,
    filename = paste0('./outputs/pres/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    #suffix = ,
    overwrite = TRUE
  )
}


#######


# Env dist to the future

eu.2011_40_126 <- euclidean(decos[ID == 2,]) 
eu.2011_40_585 <- euclidean(decos[ID == 3,]) 
eu.2071_00_126 <- euclidean(decos[ID == 4,]) 
eu.2071_00_585 <- euclidean(decos[ID == 5,])


for (i in 1:N_species) {
  r_1 <- raster(predictors, 1)
  values(r_1)[!remove] <- eu.2011_40_126[, i]
  plot(r_1, main = colnames(eu.2011_40_126)[i], col = gray.colors(100))
  points(occurrence[species == colnames(eu.2011_40_126)[i], 2:3],
         pch = 20,
         col = rgb(1, 0, 0, .3),
         cex = 2)
  writeRaster(
    r_1,
    filename = paste0('./outputs/proj/2011_40_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )}

for (i in 1:N_species) {
  r_2 <- raster(predictors, 1)
  values(r_2)[!remove] <- eu.2011_40_585[, i]
  plot(r_2, main = colnames(eu.2011_40_585)[i], col = gray.colors(100))
  points(occurrence[species == colnames(eu.2011_40_585)[i], 2:3],
         pch = 20,
         col = rgb(1, 0, 0, .3),
         cex = 2)
  writeRaster(
    r_2,
    filename = paste0('./outputs/proj/2011_40_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    #suffix = ,
    overwrite = TRUE
  )
}

for (i in 1:N_species) {
  r_3 <- raster(predictors, 1)
  values(r_3)[!remove] <- eu.2071_00_126[, i]
  plot(r_3, main = colnames(eu.2071_00_126)[i], col = gray.colors(100))
  points(occurrence[species == colnames(eu.2071_00_126)[i], 2:3],
         pch = 20,
         col = rgb(1, 0, 0, .3),
         cex = 2)
  writeRaster(
    r_3,
    filename = paste0('./outputs/proj/2071_00_126/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    overwrite = TRUE
  )}

for (i in 1:N_species) {
  r_4 <- raster(predictors, 1)
  values(r_4)[!remove] <- eu.2071_00_585[, i]
  plot(r_4, main = colnames(eu.2071_00_585)[i], col = gray.colors(100))
  points(occurrence[species == colnames(eu.2071_00_585)[i], 2:3],
         pch = 20,
         col = rgb(1, 0, 0, .3),
         cex = 2)
  writeRaster(
    r_4,
    filename = paste0('./outputs/proj/2071_00_585/', sp.names[i]),
    format = "GTiff",
    bylayer = TRUE,
    #suffix = ,
    overwrite = TRUE
  )
}


