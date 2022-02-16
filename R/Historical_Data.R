## Historical Data (1850) - For Former State Green Status protocol
## CMIP6- MPI-ESM1-2-LR (Germany) | Temporal range:1850-01-01 to 1850-12-31 | Sub-region extraction:North -12.98°, West -53.16°, South -38.53°, East -23.53°


## Library
library(dismo)
library(ncdf4)
library(raster)
library(purrr)


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


###########################

bios_resample <- raster::resample(bios, raster_base, method = "ngb")
plot(bios_resample)

raster_base <- raster::raster("data-raw/crop_CHELSA_bio1_1981-2010_V.2.1.tif")
plot(raster_base)


bios_resample <- raster::resample(bios, raster_base, method = "bilinear")
plot(bios_resample)

b <- paste0(names(bios_resample@data),".tif")

writeRaster(bios_resample, filename = b, bylayer=TRUE)

################## Not Run

layers_list <- purrr::map(1:19, ~raster(bios, layer = .))

purrr::map2(layers_list, names(bios), writeRaster)


