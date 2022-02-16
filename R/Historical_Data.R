## Historical Data (1850) - For Former State Green Status protocol
## CMIP6- MPI-ESM1-2-LR (Germany) | Temporal range:1850-01-01 to 1850-12-31 | Sub-region extraction:North -12.98°, West -53.16°, South -38.53°, East -23.53°


## Library
library(dismo)
library(ncdf4)
library(raster)
library(spatialEco)

## Precipitation
prec <- raster::brick("data-raw/CMIP6_Historical/PREC/pr_Amon_MPI-ESM1-2-LR_historical_r1i1p1f1_gn_18500116-18501216_v20190710.nc")
plot(prec)

## Daily minimum near-surface air temperature

temp_min <- raster::brick("data-raw/CMIP6_Historical/Daily minimum near-surface air temperature/tasmin_Amon_MPI-ESM1-2-LR_historical_r1i1p1f1_gn_18500116-18501216_v20190710.nc")
plot(temp_min)


## Daily maximum near-surface air temperature

temp_max <- raster::brick("data-raw/CMIP6_Historical/Daily maximum near-surface air temperature/tasmax_Amon_MPI-ESM1-2-LR_historical_r1i1p1f1_gn_18500116-18501216_v20190710.nc")
plot(temp_max)

bios <- dismo::biovars(prec, temp_max, temp_min)
plot(bios)

layers_list <- purrr::map(1:19, ~raster(bios, layer = .))


## 

raster_base <- raster::raster("data-raw/crop_CHELSA_bio1_1981-2010_V.2.1.tif")
plot(raster_base)

##

bio1 <- spatialEco::raster.downscale(raster_base, layers_list[[1]], scatter = T)
plot(bio1$downscale)
writeRaster(bio1$downscale, "data/variables/historical_1850/bio1.tif")


bio2 <- spatialEco::raster.downscale(raster_base, layers_list[[2]], scatter = T)
plot(bio2$downscale)
writeRaster(bio2$downscale, "data/variables/historical_1850/bio2.tif")


bio3 <- spatialEco::raster.downscale(raster_base, layers_list[[3]], scatter = T)
plot(bio3$downscale)
writeRaster(bio3$downscale, "data/variables/historical_1850/bio3.tif")


bio4 <- spatialEco::raster.downscale(raster_base, layers_list[[4]], scatter = T)
plot(bio4$downscale)
writeRaster(bio4$downscale, "data/variables/historical_1850/bio4.tif")


bio5 <- spatialEco::raster.downscale(raster_base, layers_list[[5]], scatter = T)
plot(bio5$downscale)
writeRaster(bio5$downscale, "data/variables/historical_1850/bio5.tif")


bio6 <- spatialEco::raster.downscale(raster_base, layers_list[[6]], scatter = T)
plot(bio6$downscale)
writeRaster(bio6$downscale, "data/variables/historical_1850/bio6.tif")


bio7 <- spatialEco::raster.downscale(raster_base, layers_list[[7]], scatter = T)
plot(bio7$downscale)
writeRaster(bio7$downscale, "data/variables/historical_1850/bio7.tif")


bio8 <- spatialEco::raster.downscale(raster_base, layers_list[[8]], scatter = T)
plot(bio8$downscale)
writeRaster(bio8$downscale, "data/variables/historical_1850/bio8.tif")


bio9 <- spatialEco::raster.downscale(raster_base, layers_list[[9]], scatter = T)
plot(bio9$downscale)
writeRaster(bio9$downscale, "data/variables/historical_1850/bio9.tif")


bio10 <- spatialEco::raster.downscale(raster_base, layers_list[[10]], scatter = T)
plot(bio10$downscale)
writeRaster(bio10$downscale, "data/variables/historical_1850/bio10.tif")


bio11 <- spatialEco::raster.downscale(raster_base, layers_list[[11]], scatter = T)
plot(bio11$downscale)
writeRaster(bio11$downscale, "data/variables/historical_1850/bio11.tif")


bio12 <- spatialEco::raster.downscale(raster_base, layers_list[[12]], scatter = T)
plot(bio12$downscale)
writeRaster(bio12$downscale, "data/variables/historical_1850/bio12.tif")


bio13 <- spatialEco::raster.downscale(raster_base, layers_list[[13]], scatter = T)
plot(bio13$downscale)
writeRaster(bio13$downscale, "data/variables/historical_1850/bio13.tif")


bio14 <- spatialEco::raster.downscale(raster_base, layers_list[[14]], scatter = T)
plot(bio14$downscale)
writeRaster(bio14$downscale, "data/variables/historical_1850/bio14.tif")

bio15<- spatialEco::raster.downscale(raster_base, layers_list[[15]], scatter = T)
plot(bio15$downscale)
writeRaster(bio15$downscale, "data/variables/historical_1850/bio15.tif")

bio16 <- spatialEco::raster.downscale(raster_base, layers_list[[16]], scatter = T)
plot(bio16$downscale)
writeRaster(bio16$downscale, "data/variables/historical_1850/bio16.tif")


bio17<- spatialEco::raster.downscale(raster_base, layers_list[[17]], scatter = T)
plot(bio17$downscale)
writeRaster(bio17$downscale, "data/variables/historical_1850/bio17.tif")


bio18 <- spatialEco::raster.downscale(raster_base, layers_list[[18]], scatter = T)
plot(bio18$downscale)
writeRaster(bio18$downscale, "data/variables/historical_1850/bio18.tif")

bio19 <- spatialEco::raster.downscale(raster_base, layers_list[[19]], scatter = T)
plot(bio19$downscale)
writeRaster(bio19$downscale, "data/variables/historical_1850/bio19.tif")

############################################################################################################################################################################################################################################################################################################################################################################################################################################################
##### Not run

layers_list <- purrr::map(1:19, ~raster(bios, layer = .))

lista_res <- list(raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base,raster_base)

test <- purrr::map2(layers_list, lista_res, raster.downscale)

plot(test[[1]][["downscale"]])
################## Not Run. Just test

bios_resample <- raster::resample(bios, raster_base, method = "ngb")
plot(bios_resample)

bios_resample <- raster::resample(bios, raster_base, method = "bilinear")
plot(bios_resample)

b <- paste0(names(bios_resample@data),".tif")

writeRaster(bios_resample, filename = b, bylayer=TRUE)

################## Not Run. Just test

layers_list <- purrr::map(1:19, ~raster(bios, layer = .))

purrr::map2(layers_list, names(bios), writeRaster)



