library("RJSONIO")
library(stringr)

setwd("C:/Users/Home/Documents/Laboral2020/Konrad Lorenz/Datos Estructurados y No estructurados/Clase 9")

isValidJSON("indy.json")
indy <- fromJSON(content = "indy.json")
class(indy)

# Aplanar el contenido


# This strategy first flattens the complex list structure into one vector
indy.vec <- unlist(indy, recursive = TRUE, use.names = TRUE)

# Ejemplo más sencillo
#lista <- list(a = NA, list(b = "TRUE", c = list(FALSE), d = 0L))
# unlist(lista, recursive = T, use.names = T)

sapply(indy[[1]], "[[", "year")

# La idea de extrear el año la aplicaremos de forma más general:

library(plyr)
# Cada uno de los tres componentes de la lista se aplana:
indy.unlist <- sapply(indy[[1]], unlist)
indy.unlist
lapply(indy.unlist, t)
library(plyr)
indy.df <- do.call("rbind.fill", lapply(lapply(indy.unlist, t),
                                  data.frame, stringsAsFactors = FALSE))



