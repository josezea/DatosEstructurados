
# libreria
library(rvest)

# asiganción de la url

url <- "https://www.amazon.com.mx/b/ref=s9_acsd_hfnv_hd_bw_bAcAgpX_ct_x_ct00_w?_encoding=UTF8&node=9725407011&pf_rd_m=AVDBXBAVVSXLQ&pf_rd_s=merchandised-search-4&pf_rd_r=Q47SQG6GBGGECT1SXNZY&pf_rd_t=101&pf_rd_p=8cc61471-874f-5f7f-96d7-e2b634466523&pf_rd_i=9725377011"

#Obtenemos código html de la página web

pagina_web <- read_html(url)

#nos interesa saber el producto y el precio

#1. identificar las clases css para scrapear
#para esto seleccionar el titulo e inspeccionar para obtener a clase


 css_producto <-  "a.a-link-normal.s-access-detail-page.s-color-twister-title-link.a-text-normal"

 css_precio <- "span.a-size-base.a-color-price.s-price.a-text-bold"

#obtener el código html que contiene  el nombre del cd

producto_texto <- pagina_web %>% html_nodes(css_producto) %>%  html_text()

precio_texto <- pagina_web %>% html_nodes(css_precio) %>%  html_text()


#limpiar los datos del precio

#Eliminamos el signo de peso
precio_limpio <- gsub("\\$","",precio_texto)
#Eliminamos la coma
precio_limpio <- gsub(",","",precio_limpio)
#Transformamos a numérico 
precio_numerico <- as.numeric(precio_limpio)



#Para mostrar la gráfica por precio
barplot(precio_numerico)
