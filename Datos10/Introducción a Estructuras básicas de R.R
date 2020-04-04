# Vectores
"hola"
class("hola")
length("hola")
length(5)
length(TRUE)
a <- c(4, 5, 6) # Siempre del mismo tipo
length(a)
a * 10 # Reciclaje
a * c(10, 10, 10)
a + 20
a + c(100, 200)
c(5) == 5
c("hola") == "hola"

######### Listas #####################
lista <- list(5, "hola", list(c(3, 4), 8), c(3, 5))
lista

# Subindices
a <- c(1, 4, 7, 11, 20)
a[2]
a[c(2,5)]

b <- list(4, c("hola", "mundo"), c(3,5))
b[[1]]
b[1]
class(b)
class(b[1])
class(b[[1]])
# b[4,['hola','mundo'],[3,5]]
#b[[0]]
#b[0]

df <-as.data.frame(b)
df

d <- list(ID = c(1,2,3), sexo = c('M', 'F', 'M'))
data.frame(d)
d$ID

df <- data.frame(d)
df[[2]]

######## Familia de funciones apply #########
e <- list(ID = c(1,2,3,4), sexo = c('Masc', 'F', 'M'))
length(c(1,2,3,4))
lapply(e, length)
lapply(e, as.character)
lapply(e, nchar)
nchar(c("Johanna", "Juan"))
f <- list(ID = c(1,2,3,4), sexo = c(10, 4, 6))
lapply(df, mean)
lapply(df, length)
data.frame(ID=1:3, y=c(7, 9, 8))
g <- list(1:3, data.frame(ID=1:3, y=c(7, 9, 8)))
g
4 == 6 # Boolenos

##################### Filtros sobre vectores, listas y dataframes
y <- c(1, 10, 20, 50, 100, 400, 450, 200)
# Seleccionar los valores mayores o iguales a 100
y >= 100
y[y >= 100] # Booleano seleccionar elementos
y[c(5,6,7,8)] # Índices en los corchetes cuadrados
y[c(F,F,F,F,T,T,T,T)] # En la práctica no se usa, vectores booleanos
y[y >= 50 & y<= 200]
# Enteros Negativos: Quitar elementos 
y[-c(1,4)]
# 1, 3, y 5 de derecha  a izquiera
n <- length(y)
posic <- c(1,3,5) # posiciones de derecha a izquierda
posic <- posic - 1
n-posic # 8 6 y 4
y[n-posic]
y[c(8, 6, 4)]
z <- y[n-(c(1,3,5)-1)]
y[sort(n-(c(1,3,5)-1))]
# Filtros con dataframes
data(iris)
datos = iris
dim(datos)
# Seleccionar la tercera fila y la segunda columna
datos[3,2]
datos$Species
datos$Species == "setosa"
# Las desaparecí
datos_setosa <- datos[datos$Species == "setosa", 1:4]
#Species == "setosa"
datos_setosa <- datos[datos$Species == "setosa",  ] # Poner todas las columnas (nada despues de la coma)

# Longitud del petalo igual a 1.4
datos[datos$Petal.Length == 1.4,  ]
# Longitud del petalo mayor a 1.4 y que longitud del sepalo = 5
 datos[datos$Petal.Length > 1.4 & datos$Sepal.Length == 5,  ]
# dplyr: filter(datos, Petal.Length > 1.4 & Sepal.Length == 5)
# data.table: datos[Petal.Length > 1.4 & Sepal.Length == 5,,]

 ######### Selección de elementos de la lista ################
lista <- list(a = 1:5, b = 8)
lista[[2]]
lista$b

################### Aggregaciones ######################
ingreso <- c(5, 3, 2, 4, 6, 1)
sexo <- c('M', 'F', 'M', 'M', 'F', 'F')
tapply(ingreso, sexo, FUN = mean)
tapply(ingreso, sexo, FUN = quantile)
tapply(iris$Sepal.Length, iris$Species, FUN = mean)
aggregate(Sepal.Length ~ Species, data = iris, FUN = mean)
c("juan" = 5, "pedro" = 3)

a = c(3, 5, 6)
b = c(7, 8)
c(a, b)

lista1 <- list(5, "hola", 3)
lista2 <- list(6, 9, "asdfasd")
lista <- c(lista1, lista2)
unlist(lista)

d <- c("juan", "antonio", "perez", "Diana")
e <- c(15, 20, 40)
paste(d, collapse = "|")
paste(d, collapse = " ")
paste(d, e)
