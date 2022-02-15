# Required packages -------------------------------------------------------

library(dplyr)
library(tidyverse)
library("spatialEco")
library(raster)
library(rgdal)
library(ggplot2)


# Species names -----------------------------------------------------------

species_list <- read_csv("./occs/occs_all.csv")

species_list$species <-
  gsub(x = species_list$species,
       pattern = " ",
       replacement = "_")

target_species <- unique(species_list$species)


# 2071_00_126 -------------------------------------------------------------

# Reading rasters ---------------------------------------------------------

# continuous models
list.var.SU.cont <-list.files(
  paste0("./outputs/crop/crop_cont/proj/2071_00_126"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)

# Plot --------------------------------------------------------------------

# Continuous

# number_ticks <- function(n) {
#   function(limits)
#     pretty(limits, n)
# }

v <- list()

for (i in 1:10) {
  SUs_sp <-raster(list.var.SU.cont[[i]])
  map.p <- rasterToPoints(SUs_sp)
  df <- data.frame(map.p)
  colnames(df) <- c("Longitude", "Latitude", "Distância Euclidiana")
  
  v[[i]] <- ggplot(data = df, aes(y = Latitude, x = Longitude)) +
    geom_raster(aes(fill = `Distância Euclidiana`)) + theme_bw() +
    coord_equal() +
    theme(
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16, angle = 90),
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "right",
      legend.title = element_blank(),
      legend.key = element_blank()
    ) +
    scico::scale_fill_scico(palette = "lajolla") +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_blank()) + 
    theme(legend.justification = c(0.5, 0),
          legend.position = c(1.2, 0.05),
          legend.text = element_text(size=15)) +
    labs(title = paste0(target_species[i], "\n")) +
    theme(plot.title = element_text(
      lineheight = .8,
      face = "italic",
      size = 20
    )) +
    # scale_y_continuous(labels = scales::number_format(accuracy = 1),
    #                    breaks = number_ticks(2))
    coord_equal()+
    scale_x_continuous(n.breaks = 2) +
    scale_y_continuous(n.breaks = 3)
  
}


v[[1]]

for(i in 1:10) {
  ggsave(
    v[[i]],
    file = paste0('./Figures/2071_00_126_cont/', target_species[[i]], ".tiff"),
    height = 30,
    width = 30,
    units = "cm"
  )
  
}

# Reading rasters ---------------------------------------------------------

# binary models 
list.var.SU.bin <-
  list.files(
    paste0('./outputs/crop/crop_bin/proj/2071_00_126'),
    recursive = TRUE,
    pattern = "tif",
    full.names = TRUE
  )

# Plot --------------------------------------------------------------------

# Binary

z <- list()

for (i in 1:10) {
  SUs_sp <-raster(list.var.SU.bin[[i]])
  map.p <- rasterToPoints(SUs_sp)
  df <- data.frame(map.p)
  colnames(df) <- c("Longitude", "Latitude", "Distância Euclidiana")
  
  z[[i]] <- ggplot(data = df, aes(y = Latitude, x = Longitude)) +
    geom_raster(aes(fill = `Distância Euclidiana`)) + theme_bw() +
    coord_equal() +
    theme(
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16, angle = 90),
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "right",
      legend.title = element_blank(),
      legend.key = element_blank()
    ) +
    scico::scale_fill_scico(palette = "lajolla") +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_blank()) + 
    theme(legend.justification = c(0.5, 0),
          legend.position = c(1.2, 0.05),
          legend.text = element_text(size=15)) +
    labs(title = paste0(target_species[i], "\n")) +
    theme(plot.title = element_text(
      lineheight = .8,
      face = "italic",
      size = 20
    )) +
    # scale_y_continuous(labels = scales::number_format(accuracy = 1),
    #                    breaks = number_ticks(2))
    coord_equal()+
    scale_x_continuous(n.breaks = 2) +
    scale_y_continuous(n.breaks = 3)
  
}


z[[1]]

for(i in 1:10) {
  ggsave(
    z[[i]],
    file = paste0('./Figures/2071_00_126_bin/', target_species[[i]], ".tiff"),
    height = 30,
    width = 30,
    units = "cm"
  )
  
}


# 2071_00_585 -------------------------------------------------------------

# Reading rasters ---------------------------------------------------------

# continuous models
list.var.SU.cont <-list.files(
  paste0("./outputs/crop/crop_cont/proj/2071_00_585"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)

# Plot --------------------------------------------------------------------

# Continuous

# number_ticks <- function(n) {
#   function(limits)
#     pretty(limits, n)
# }

m <- list()

for (i in 1:10) {
  SUs_sp <-raster(list.var.SU.cont[[i]])
  map.p <- rasterToPoints(SUs_sp)
  df <- data.frame(map.p)
  colnames(df) <- c("Longitude", "Latitude", "Distância Euclidiana")
  
  m[[i]] <- ggplot(data = df, aes(y = Latitude, x = Longitude)) +
    geom_raster(aes(fill = `Distância Euclidiana`)) + theme_bw() +
    coord_equal() +
    theme(
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16, angle = 90),
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "right",
      legend.title = element_blank(),
      legend.key = element_blank()
    ) +
    scico::scale_fill_scico(palette = "lajolla") +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_blank()) + 
    theme(legend.justification = c(0.5, 0),
          legend.position = c(1.2, 0.05),
          legend.text = element_text(size=15)) +
    labs(title = paste0(target_species[i], "\n")) +
    theme(plot.title = element_text(
      lineheight = .8,
      face = "italic",
      size = 20
    )) +
    # scale_y_continuous(labels = scales::number_format(accuracy = 1),
    #                    breaks = number_ticks(2))
    coord_equal()+
    scale_x_continuous(n.breaks = 2) +
    scale_y_continuous(n.breaks = 3)
  
}


m[[1]]

for(i in 1:10) {
  ggsave(
    m[[i]],
    file = paste0('./Figures/2071_00_585_cont/', target_species[[i]], ".tiff"),
    height = 30,
    width = 30,
    units = "cm"
  )
  
}

# Reading rasters ---------------------------------------------------------

# binary models 
list.var.SU.bin <-
  list.files(
    paste0('./outputs/crop/crop_bin/proj/2071_00_585'),
    recursive = TRUE,
    pattern = "tif",
    full.names = TRUE
  )

# Plot --------------------------------------------------------------------

# Binary

l <- list()

for (i in 1:10) {
  SUs_sp <-raster(list.var.SU.bin[[i]])
  map.p <- rasterToPoints(SUs_sp)
  df <- data.frame(map.p)
  colnames(df) <- c("Longitude", "Latitude", "Distância Euclidiana")
  
  l[[i]] <- ggplot(data = df, aes(y = Latitude, x = Longitude)) +
    geom_raster(aes(fill = `Distância Euclidiana`)) + theme_bw() +
    coord_equal() +
    theme(
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16, angle = 90),
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "right",
      legend.title = element_blank(),
      legend.key = element_blank()
    ) +
    scico::scale_fill_scico(palette = "lajolla") +
    theme(axis.title.y = element_blank(),
          axis.title.x = element_blank()) + 
    theme(legend.justification = c(0.5, 0),
          legend.position = c(1.2, 0.05),
          legend.text = element_text(size=15)) +
    labs(title = paste0(target_species[i], "\n")) +
    theme(plot.title = element_text(
      lineheight = .8,
      face = "italic",
      size = 20
    )) +
    # scale_y_continuous(labels = scales::number_format(accuracy = 1),
    #                    breaks = number_ticks(2))
    coord_equal()+
    scale_x_continuous(n.breaks = 2) +
    scale_y_continuous(n.breaks = 3)
  
}


l[[1]]

for(i in 1:10) {
  ggsave(
    l[[i]],
    file = paste0('./Figures/2071_00_585_bin/', target_species[[i]], ".tiff"),
    height = 30,
    width = 30,
    units = "cm"
  )
  
}
