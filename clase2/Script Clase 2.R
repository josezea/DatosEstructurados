dir()
#tidyverse
library(readr)
library(dplyr)
?read_delim
datos = readr::read_delim( "variables_adicionales_hogar_v3.txt",
                     delim = ";") #read_csv2 también
#datos = read_csv2( "variables_adicionales_hogar_v3.txt") 

# select, filter, arrange(): organizar por una o más variables
# mutate: crear o derivar nuevas variables
# summarise: sacar estadísticas resumenes
# group_by: agrupar por una o más variables de tipo categórico
# paquete dplyr
# Delimitar a el estrato, ing, ing perc (no olvidar id)
df <- select(datos, DIRECTORIO_HOG, ESTRATO_VIV,
             INGRESOS_HOG, INGRESOS_PER_CAPITA)
#df$ESTRATO_VIV
cortes <- quantile(df$INGRESOS_HOG)
df$CLASEHOG <- cut(df$INGRESOS_HOG, cortes, 
                   labels =  1:4,
                   include.lowest = T, right = F)  
table(df$CLASEHOG)

# Filtro: hogares de la clase 4 de estratos 3, 4, 5 y 6
df1 = filter(df, CLASEHOG == 4 & (ESTRATO_VIV == 3  |
                  ESTRATO_VIV == 4 | ESTRATO_VIV == 5
                  ESTRATO_VIV == 6))
df1 = filter(df, CLASEHOG == 4 & ESTRATO_VIV %in% 3:6)
# Otros ejemplos: quiero el complemento del anterior
# filter(df, !(CLASEHOG == 4 & ESTRATO_VIV %in% 3:6))

# Calcular el promedio del ingreso percapita 
df1_grouped <- group_by(df1, ESTRATO_VIV) 
summarise(df1_grouped, prom_ingpc = mean(INGRESOS_PER_CAPITA))
summarise(df1, prom_ingpc = mean(INGRESOS_PER_CAPITA))

summarise(df1_grouped, prom_ingpc = mean(INGRESOS_PER_CAPITA),
          mediana_ingpc = median(INGRESOS_PER_CAPITA),
cv_ingpc = 100 * sd(INGRESOS_PER_CAPITA) / prom_ingpc )


# COnstruir el logaritmo del ingreso
hist(df1$INGRESOS_HOG)
hist(log(df1$INGRESOS_HOG))
df1 <- mutate(df1, log_ing = log(INGRESOS_HOG),
              Nper = INGRESOS_HOG / INGRESOS_PER_CAPITA)
summary(df1$Nper)

df1$log_ing <- log(df1$INGRESOS_HOG)
#df$Ahorro <- df$ingr - df$gasto
#df <- mutate(df, ahorro = ing - gasto)


# Reconstruir el número de hogares y eliminar el ingreso
#percapita de la tabla datos (df_ejerc)

df_ejerc <- datos
df_ejerc$num_personas <- df_ejerc$INGRESOS_HOG /
  df_ejerc$INGRESOS_PER_CAPITA
df_ejerc <- df_ejerc %>% select(-INGRESOS_PER_CAPITA)
#df_ejerc <- select(df_ejerc, -INGRESOS_PER_CAPITA)

#Ejericio: Calcular el promedio del ingreso percapita 
#por estrato y Ordenar los resultados de mayor a menor.

df_ejerc %>% select(ESTRATO_VIV, INGRESOS_HOG, 
                    num_personas ) %>%
  mutate(ing_pc = INGRESOS_HOG / num_personas) %>%
  group_by(ESTRATO_VIV) %>%
  summarise(prom_ingpc = mean(ing_pc, na.rm = T)) %>%
  arrange(prom_ingpc)
# Ejercicio: calcule la proporción de pobres IPM
# por estrato