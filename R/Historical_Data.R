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

raster_base <- raster::raster("data-raw/altitude_inpe_br.asc")
plot(raster_base)

##

bio_1 <- spatialEco::raster.downscale(raster_base, layers_list[[1]], scatter = F)
plot(bio_1$downscale)
bio1 <- bio_1$downscale / 10
plot(bio1)
writeRaster(bio1, "data/variables/historical_1850/bio1.tif", overwrite = T)


bio2 <- spatialEco::raster.downscale(raster_base, layers_list[[2]], scatter = F)
plot(bio2$downscale)
writeRaster(bio2$downscale, "data/variables/historical_1850/bio2.tif")

bio_3 <- spatialEco::raster.downscale(raster_base, layers_list[[3]], scatter = F)
plot(bio_3$downscale)
bio3 <- bio_3$downscale /10
plot(bio3)
writeRaster(bio3, "data/variables/historical_1850/bio3.tif")


bio4 <- spatialEco::raster.downscale(raster_base, layers_list[[4]], scatter = F)
plot(bio4$downscale)
writeRaster(bio4$downscale, "data/variables/historical_1850/bio4.tif")


bio_5 <- spatialEco::raster.downscale(raster_base, layers_list[[5]], scatter = F)
plot(bio_5$downscale)
bio5 <- bio_5$downscale /10
plot(bio5)
writeRaster(bio5, "data/variables/historical_1850/bio5.tif")


bio_6 <- spatialEco::raster.downscale(raster_base, layers_list[[6]], scatter = F)
plot(bio_6$downscale)
bio6 <- bio_6$downscale /10
plot(bio6)
writeRaster(bio6, "data/variables/historical_1850/bio6.tif")


bio7 <- spatialEco::raster.downscale(raster_base, layers_list[[7]], scatter = F)
plot(bio7$downscale)
writeRaster(bio7$downscale, "data/variables/historical_1850/bio7.tif")


bio_8 <- spatialEco::raster.downscale(raster_base, layers_list[[8]], scatter = F)
plot(bio_8$downscale)
bio8 <- bio_8$downscale /10
plot(bio8)
writeRaster(bio8, "data/variables/historical_1850/bio8.tif")


bio_9 <- spatialEco::raster.downscale(raster_base, layers_list[[9]], scatter = F)
plot(bio_9$downscale)
bio9 <- bio_9$downscale /10
plot(bio9)
writeRaster(bio9, "data/variables/historical_1850/bio9.tif")


bio_10 <- spatialEco::raster.downscale(raster_base, layers_list[[10]], scatter = F)
plot(bio_10$downscale)
bio10 <- bio_10$downscale /10
plot(bio10)
writeRaster(bio10, "data/variables/historical_1850/bio10.tif")


bio_11 <- spatialEco::raster.downscale(raster_base, layers_list[[11]], scatter = F)
plot(bio_11$downscale)
bio11 <- bio_11$downscale /10
plot(bio11)
writeRaster(bio11, "data/variables/historical_1850/bio11.tif")

bio_12 <- spatialEco::raster.downscale(raster_base, layers_list[[12]], scatter = F)
plot(bio_12$downscale)
bio12 <- bio_12$downscale *1000000
plot(bio12)
writeRaster(bio12, "data/variables/historical_1850/bio12.tif")


bio_13 <- spatialEco::raster.downscale(raster_base, layers_list[[13]], scatter = F)
plot(bio_13$downscale)
bio13 <- bio_13$downscale  *1000000
plot(bio13)
writeRaster(bio13, "data/variables/historical_1850/bio13.tif")


bio_14 <- spatialEco::raster.downscale(raster_base, layers_list[[14]], scatter = F)
plot(bio_14$downscale)
bio14 <- bio_14$downscale  *10000000
plot(bio14)
writeRaster(bio14, "data/variables/historical_1850/bio14.tif")

bio_15<- spatialEco::raster.downscale(raster_base, layers_list[[15]], scatter = F)
plot(bio_15$downscale)
bio15 <- bio_15$downscale *10000
plot(bio15)
writeRaster(bio15, "data/variables/historical_1850/bio15.tif")

bio_16 <- spatialEco::raster.downscale(raster_base, layers_list[[16]], scatter = F)
plot(bio_16$downscale)
bio16 <- bio_16$downscale *1000000
plot(bio16)
writeRaster(bio16, "data/variables/historical_1850/bio16.tif")


bio_17<- spatialEco::raster.downscale(raster_base, layers_list[[17]], scatter = F)
plot(bio_17$downscale)
bio17 <- bio_17$downscale  *10000000
plot(bio17)
writeRaster(bio17, "data/variables/historical_1850/bio17.tif")



bio_18 <- spatialEco::raster.downscale(raster_base, layers_list[[18]], scatter = F)
plot(bio_18$downscale)
bio18 <- bio_18$downscale *1000000
plot(bio18)
writeRaster(bio18, "data/variables/historical_1850/bio18.tif")

bio_19 <- spatialEco::raster.downscale(raster_base, layers_list[[19]], scatter = F)
plot(bio_19$downscale)
bio19 <- bio_19$downscale *10000000
plot(bio19)
writeRaster(bio19, "data/variables/historical_1850/bio19.tif")

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



