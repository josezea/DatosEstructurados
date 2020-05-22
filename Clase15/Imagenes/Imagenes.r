

# Imagenes 
r <- matrix(runif(9, 0, 1), 3)
g <- matrix(runif(9, 0, 1), 3)
b <- matrix(runif(9, 0, 1), 3)

col <- rgb(r, g, b)
dim(col) <- dim(r)

library(grid)
grid.raster(col, interpolate=FALSE)



library(jpeg)
setwd("C:/Users/Home/Documents/Laboral2020/Konrad Lorenz/Datos Estructurados y No estructurados/Clase15")
cat <- readJPEG("gatos.jpg")
ncol(cat)
# arreglo tridimensional en la dimensión 3 el color

r <- cat[,,1]
g <- cat[,,2]
b <- cat[,,3]

cat.r.pca <- prcomp(r, center = FALSE)
cat.g.pca <- prcomp(g, center = FALSE)
cat.b.pca <- prcomp(b, center = FALSE)

rgb.pca <- list(cat.r.pca, cat.g.pca, cat.b.pca)

secuencia <- round(seq.int(3, round(nrow(cat) - 10), length.out = 10))

prueba <- rgb.pca[[1]]$x[,1:3]  %*% t(rgb.pca[[1]]$rotation[,1:3])
dim(prueba)

componente <- function(j) {
  compressed.img <- j$x[,1:i] %*% t(j$rotation[,1:i])
}


for (i in secuencia) {
  pca.img <- sapply(rgb.pca, function(j) {
    compressed.img <- j$x[,1:i] %*% t(j$rotation[,1:i])
  }, simplify = 'array')
  writeJPEG(pca.img, paste('cat_compressed_', round(i,0), 
                           '_components.jpg', sep = ''))
}