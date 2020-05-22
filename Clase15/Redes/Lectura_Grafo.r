# Comparar 1992 (A?o cero) vs 2018
# 4 redes bogota sin bogtoa (por vuelos y por pasajeros)
# Evolución de redes: 


rm(list = ls())

library(readxl)
library(dplyr)
library(lubridate)
library(igraph)
setwd("C:/Users/Home/Documents/Laboral2019/USTA_AIRTRANSPORT/ArticuloRedColombiana/Proyecto")

setwd("data")
########################## Generación de red de 2004 ###############################
df_flights2004 <- read_excel("Trafico Equipo Mes 2004.xlsx", range = "A4:Y37117", sheet = "Trafico Equipo Mes 2004")
df_flights2004 <- df_flights2004 %>% filter(Trafico == "N" & `Tipo Vuelo` %in% c("A", "R") &
                                              `Pais Origen` == "COLOMBIA" &
                                              `Pais Destino` == "COLOMBIA" &
                                              Origen != Destino) %>% 
                  group_by(Origen, Destino) %>%
  summarise(num_vuelos = sum(`Vuelos`), num_pasajeros = sum(`Pasajeros A Bordo`)) %>% ungroup() %>%
  filter(num_pasajeros >= 1)

df_routes2004 <- data.frame(routes = sort(unique(c(df_flights2004$Origen, 
                                                    df_flights2004$Destino))), 
                            stringsAsFactors = F)

# Convertir a grafo la base de datos
g_2004 <- graph_from_data_frame(d = df_flights2004, 
                                vertices = df_routes2004, directed = T) 

################################### Undirected networks ###############

df_flights2004_undirected <- df_flights2004 %>%
  rowwise() %>%      # for each row
  mutate(Origen_destino = paste(sort(c(Origen, Destino)), collapse = " - ")) %>%
  # sort the teams alphabetically and then combine them separating with -
  ungroup() %>%
  group_by(Origen_destino) %>%
  summarise(num_vuelos = sum(num_vuelos)) %>%
  separate(Origen_destino, c("Origen", "Destino"))

df_routes2004_undirected <- data.frame(routes = sort(unique(c(df_flights2004_undirected$Origen, 
                                                              df_flights2004_undirected$Destino))), 
                                       stringsAsFactors = F)


# Convertir a grafo la base de datos
g_2004_undirected <- graph_from_data_frame(d = df_flights2004_undirected, 
                                           vertices = df_routes2004_undirected, directed = F) # 79 rutas




########################## Generación de red de 2018 ###############################
df_flights2018 <- read_excel("Trafico Equipo Mes 2018.xlsx", range = "A5:X42188", sheet = "Datos")
df_flights2018 <- df_flights2018 %>% filter(Trafico == "N" & `Tipo de Vuelo` %in% c("A", "R") &
                                            `Pais Origen` == "COLOMBIA" &
                                             `Pais Destino` == "COLOMBIA"
                                            & Origen != Destino) %>% 
                   group_by(Origen, Destino) %>%
                   summarise(num_vuelos = sum(`Número de Vuelos`), 
                             num_pasajeros = sum(`Pasajeros A Bordo`)) %>% 
                   ungroup() %>%  filter(num_pasajeros >= 1)

df_routes2018 <- data.frame(routes = sort(unique(c(df_flights2018$Origen, 
                            df_flights2018$Destino))), 
                            stringsAsFactors = F)

# Aeropuertos seleccionados
vctr_reducedAirports <- c("AUC", "AXM", "BSC", "EJA", "BAQ", "BOG", "BGA", "BUN", "CLO", 
                          "APO", "CTG", "CZU", "CUC", "EBG", "EYP", "FLA", "GPI", "IBE", 
                          "IPI", "LET", "LMA", "MZL", "EOH", "MVP", "MTR", "NVA", "PSO", 
                          "PEI", "PPN", "PVA", "PUU", "PCR", "PGT", "LQM", "UIB", "NQU", 
                          "RCH", "MDE", "ADZ", "SJE", "SMR", "RVE", "TLU", "TCO", "VUP", 
                          "VVC")


dim(df_routes2018)
length(vctr_reducedAirports)
b <- sum(df_flights2018$num_pasajeros)
a <- sum(df_flights2018[df_flights2018$Origen %in% vctr_reducedAirports & df_flights2018$Destino %in% vctr_reducedAirports,]$num_pasajeros)
a / b
# Convertir a grafo la base de datos
g_2018 <- graph_from_data_frame(d = df_flights2018, 
                                vertices = df_routes2018, directed = T) # 79 rutas


################################### Undirected networks ###############
df_flights2018_undirected <- df_flights2018 %>%
  rowwise() %>%      # for each row
  mutate(Origen_destino = paste(sort(c(Origen, Destino)), collapse = " - ")) %>%
  # sort the teams alphabetically and then combine them separating with -
  ungroup() %>%
  group_by(Origen_destino) %>%
  summarise(num_vuelos = sum(num_vuelos)) %>%
  separate(Origen_destino, c("Origen", "Destino"))

df_routes2018_undirected <- data.frame(routes = sort(unique(c(df_flights2018_undirected$Origen, 
                                                   df_flights2018_undirected$Destino))), 
                            stringsAsFactors = F)


  
setwd("..")
setwd("output")


# Convertir a grafo la base de datos
g_2018 <- graph_from_data_frame(d = df_flights2018, 
                                vertices = df_routes2018, directed = T) # 79 rutas

# Convertir a grafo la base de datos
g_2018_undirected <- graph_from_data_frame(d = df_flights2018_undirected, 
                                vertices = df_routes2018_undirected, directed = F) # 79 rutas


################################### Bases para establecer correlaciones ###############

dfOrigenesDestinos_2004 <- df_flights2004 %>%
  rowwise() %>%      # for each row
  mutate(Origen_destino = paste(sort(c(Origen, Destino)), collapse = " - ")) %>%
  # sort the teams alphabetically and then combine them separating with -
  ungroup() %>% arrange(Origen_destino) %>% group_by(Origen_destino) %>% 
  mutate(secuencia = 1:n()) %>% arrange(Origen_destino) %>% 
  select(Origen_destino, num_pasajeros, secuencia) %>%
  pivot_wider(names_from =  secuencia, values_from = num_pasajeros)

cor(dfOrigenesDestinos_2004$`1`, dfOrigenesDestinos_2004$`2`,
    use = "pairwise.complete.obs")



dfOrigenesDestinos_2018 <- df_flights2018 %>%
  rowwise() %>%      # for each row
  mutate(Origen_destino = paste(sort(c(Origen, Destino)), collapse = " - ")) %>%
  # sort the teams alphabetically and then combine them separating with -
  ungroup() %>% arrange(Origen_destino) %>% group_by(Origen_destino) %>% 
  mutate(secuencia = 1:n()) %>% arrange(Origen_destino) %>% 
  select(Origen_destino, num_pasajeros, secuencia) %>%
  pivot_wider(names_from =  secuencia, values_from = num_pasajeros)

cor(dfOrigenesDestinos_2018$`1`, dfOrigenesDestinos_2018$`2`,
    use = "pairwise.complete.obs")




save(df_flights2004, dfOrigenesDestinos_2004, g_2004, g_2004_undirected,
     df_flights2004_undirected, 
     df_flights2018, dfOrigenesDestinos_2018, g_2018, g_2018_undirected,
     df_flights2018_undirected,
     file = "RedesTransporteAereo.Rdata")



# df_Inernflights <- df_flights %>% filter(Trafico == "I" & `Tipo de Vuelo` %in% c("A", "R"),
#                                          `Pais Origen` == "COLOMBIA")
# 
# 
# library(statnet)
# library(UserNetR)
# data(Moreno)
# 
# edges <- df_flights %>% select(from = Origen, to = Destino, weight = num_vuelos)
# edges_exporta <- edges
# edges_exporta$from <- ifelse(edges_exporta$from == "9DI", "A9DI", edges_exporta$from )
# edges_exporta$to <- ifelse(edges_exporta$to == "9DI", "A9DI", edges_exporta$to)
# write.csv2(edges_exporta, "edges.csv", row.names = F)
# 
# 
# 
# write.csv2(edges, "edges.csv")
# 
# sources <- df_flights %>% 
#   distinct(Origen) %>%
#   rename(label = Origen)
# 
# destinations <- df_flights %>% 
#   distinct(Destino) %>%
#   rename(label = Destino)
# 
# nodes <- full_join(sources, destinations, by = "label")
# nodes <- nodes %>% tibble::rowid_to_column("id")
# 
# routes_network <- network(edges, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)
# plot(routes_network, vertex.cex = 3, mode = "circle", )
# 
# detach(package:network)
# rm(routes_network)
# library(igraph)
# nodes$id <- NULL
# routes_igraph <- graph_from_data_frame(d = edges, vertices = nodes, directed = TRUE)
# plot(routes_igraph, edge.arrow.size = 0.2)
# plot(routes_igraph, layout = layout_nicely, edge.arrow.size = 0.2)
# 
# edges2 <- edges
# edges2$weight <- NULL
# routes_network2 <- network(edges2, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)
# plot(routes_network2, vertex.cex = 1, mode = "circle", )
# 
# network.size(routes_network2)
# gden(routes_network2) # DEnsidad, que tan conectada est? la red
# components(routes_network2) # error)
# 
# 
# # A
# lgc <- component.largest(routes_network2,result="graph")
# gd <- geodist(lgc)
# max(gd$gdist)
# 
# gtrans(routes_network2,mode="graph") # suggesting a moderate level of clustering in the classroom network.
