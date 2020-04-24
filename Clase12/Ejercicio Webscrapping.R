library(tidyverse)
library(rvest)
library(rlist)
library(stringi)
library(htmltab)

# Webscrapping de wikipedia
url = 'https://en.wikipedia.org/wiki/List_of_people_on_banknotes'

sample = url %>%
  read_html() %>%
  html_node('body #content #bodyContent #mw-content-text .mw-parser-output table') %>%
  html_table(fill = TRUE)

prueba = url %>%
  read_html() %>%
  html_node('body #content #bodyContent #mw-content-text .mw-parser-output table tbody') %>%
#  html_table(fill = TRUE)

# numeral cuando hay ids, cuando hay clases se usa punto (en un div)
# si la clase no va sola se le precede por punto a.

  
ls_tablasPaises = url %>%
  read_html() %>%
  html_nodes('body #content #bodyContent #mw-content-text .mw-parser-output table') 
# %>%   html_table(fill = TRUE)
  
Colombia <- ls_tablasPaises[[25]]  %>% html_table(fill = TRUE)
  

# //*[@id="mw-content-text"]/div/table[25]

# Pegar todas las tablas
paises = url %>% read_html() %>% 
         html_nodes("body #content #bodyContent #mw-content-text .mw-parser-output h3 .mw-headline") %>% 
         html_text()

lista_tablas <- vector(mode = "list", length = 25)
names(lista_tablas) <- paises[1:25]


ls_tablasPaises[[10]]  %>% html_table(fill = TRUE) 
ls_tablasPaises[[11]]  %>% html_table(fill = TRUE) 

for(i in 1:10){
  lista_tablas[[i]] <-  ls_tablasPaises[[i]]  %>% html_table(fill = TRUE)  
  lista_tablas[[i]]$Pais <- paises[i] 
}

##################### Otra forma de hacerlo (tomando xpath)
# Return a data frame
df_colombia = url %>%
  read_html() %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div/table[25]') %>%
  html_table(fill = TRUE)

# Webscrapping de amazon
library(rvest)
url <- "https://www.amazon.com.mx/b/ref=s9_acsd_hfnv_hd_bw_bAcAgpX_ct_x_ct00_w?_encoding=UTF8&node=9725407011&pf_rd_m=AVDBXBAVVSXLQ&pf_rd_s=merchandised-search-4&pf_rd_r=Q47SQG6GBGGECT1SXNZY&pf_rd_t=101&pf_rd_p=8cc61471-874f-5f7f-96d7-e2b634466523&pf_rd_i=9725377011"
pagina_web <- read_html(url)

#Asignamos la clase
css_producto <- "a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal"

#Obtenemos el c?digo html que contiene el nombre del producto
producto_texto <- html_nodes(pagina_web, css_producto) %>% html_text()


# mostramos los datos, al final presionar enter
precio_css <- "span.a-size-base.a-color-price.a-text-bold"

precio_texto <- html_nodes(pagina_web, precio_css) %>% html_text()

#limpiar el tecto para obtener los precios

#Eliminamos el signo de peso
precio_limpio <- gsub("\\$","",precio_texto)
#Eliminamos la coma
precio_limpio <- gsub(",","",precio_limpio)
#Transformamos a num?rico 
precio_numerico <- as.numeric(precio_limpio)

#Unimos los datos
productos <- data.frame(Producto = producto_texto, Precio = precio_numerico)
#Para mostrar la gr?fica por precio
barplot(precio_numerico)




############################## Leyendo pdf's ######################################

setwd("C:/Users/Home/Documents/Laboral2020/Konrad Lorenz/Datos Estructurados y No estructurados/Clase12")
dir()
library(tabulizer)

censo <-  extract_tables("censo.pdf", pages = 32) 
locate_areas("censo.pdf", pages = 32)

tabla <- extract_tables("censo.pdf", pages = 32, 
                        area = list(c(69.93684, 245.23917,  387.20871, 473.56529)))

tabla <- tabla[[1]]
colnames(tabla) <- tabla[-11,]
tabla <- tabla[-1,]
tabla <- as.data.frame(tabla)
tabla$V1 <- as.character(tabla$V1)
Encoding(tabla$V1) <- "UTF-8"

result <- list()
for (i in 15:21){
  out <- as.data.frame(extract_tables("doc-202-1.pdf" , page = i, method = 'stream'), stringsAsFactors = FALSE)
  result[[i]] <- out
}
result <- result[-(1:14)]

# 
# out <- extract_tables("universidades.pdf", pages = 6, method = "stream")
# # locate_areas("universidades.pdf", pages = 6)
# tabla <- extract_tables("universidades.pdf", pages = 6, 
#                         area = list(c(284.7208  ,    34.57321,  630.7431  , 544.7147  )))
