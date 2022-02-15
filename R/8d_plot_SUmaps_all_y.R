
# This script depend on the others (8a:c)

library("gridExtra")

for(i in 1:10) {
p_arrange_cont <-
  grid.arrange(p[[i]], h[[i]], j[[i]], v[[i]], m[[i]], nrow = 3)
ggsave(
  p_arrange_cont,
  file = paste0('./Figures/tds_cont/', target_species[[i]], ".tiff"),
  height = 50,
  width = 40,
  units = "cm"
)
}


for(i in 1:10) {
  p_arrange_cont <-
    grid.arrange(q[[i]], k[[i]], u[[i]], z[[i]], l[[i]], nrow = 3)
  ggsave(
    p_arrange_cont,
    file = paste0('./Figures/tds_bin/', target_species[[i]], ".tiff"),
    height = 50,
    width = 40,
    units = "cm"
  )
}


# Micranthocereus_auriazureus i = 6
p_arrange_cont <-
  grid.arrange(p[[6]], h[[6]], j[[6]], v[[6]], m[[6]], nrow = 3)
ggsave(
  p_arrange_cont,
  file = paste0('./Figures/tds_cont/', target_species[[6]], ".tiff"),
  height = 50,
  width = 70,
  units = "cm"
)

# Uebelmannia_buiningii i = 9
p_arrange_cont <-
  grid.arrange(p[[9]], h[[9]], j[[9]], v[[9]], m[[9]], nrow = 3)
ggsave(
  p_arrange_cont,
  file = paste0('./Figures/tds_cont/', target_species[[9]], ".tiff"),
  height = 50,
  width = 70,
  units = "cm"
)

