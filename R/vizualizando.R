ver0 <-
  list.files(paste0("./outputs/norm_inv/pres/"),
             recursive = TRUE,
             pattern = "tif",
             full.names = TRUE
  )
ver0 <- stack(ver0)


ver_1 <- list.files(
  paste0("./outputs/norm_inv/proj/2011_40_126/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
ver_1 <- stack(ver_1)


ver_2 <- list.files(
  paste0("./outputs/norm_inv/proj/2011_40_585/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
ver_2 <- stack(ver_2)


ver_3 <- list.files(
  paste0("./outputs/norm_inv/proj/2071_00_126/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
ver_3 <- stack(ver_3)


ver_4 <- list.files(
  paste0("./outputs/norm_inv/proj/2071_00_585/"),
  pattern = "tif",
  full.names = TRUE,
  recursive = TRUE
)
ver_4 <- stack(ver_4)



plot(ver0[[2]])
plot(ver_1[[2]])
plot(ver_2[[2]])
plot(ver_3[[2]])
plot(ver_4[[2]])
points(occurrence[, 2:3], col = "red")