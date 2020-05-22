# Capítulo 1: Fundamentos y redes no dirigidas (undirected)

# Load igraph
library(igraph)

friends <- data.frame(name1 = c("Jessie", "Jessie", "Sidney", "Sidney",
                                "Karl", "Sidney", "Britt", "Shayne", "Sidney", "Sidney", "Jessie",
                                "Donnie", "Sidney", "Rene", "Shayne", "Jessie", "Rene", "Elisha",
                                "Eugene", "Berry", "Odell", "Odell", "Britt", "Elisha", "Lacy",
                                "Britt", "Karl"),
                      name2 = c("Sidney", "Britt", "Britt", "Donnie",
                                "Berry", "Rene", "Rene", "Sidney", "Elisha", "Whitney", "Whitney",
                                "Odell", "Odell", "Whitney", "Donnie", "Lacy", "Lacy", "Eugene",
                                "Jude", "Odell", "Rickie", "Karl", "Lacy", "Jude", "Whitney",
                                "Whitney", "Tommy"), stringsAsFactors = F)

# Inspect the first few rows of the dataframe 'friends'
head(friends)

# Convert friends dataframe to a matrix
friends.mat <- as.matrix(friends)

# Convert friends matrix to an igraph object
g <- graph.edgelist(friends.mat, directed = FALSE)


# Make a very basic plot of the network
plot(g)


# Conteo de vertices (nodos)
V(g)
gorder(g)

# Conteo de Edges (aristas)
E(g)
gsize(g)


# # COlocarle atributos a los nodos
# #?set_vertex_attr(graph = , name = "edad", index = V(g), value = c(20, 34,.. )
#  
# # set_edge_attr(graph = g, name = "Tipo_relacion", index = E(g), value = c("Novios", "Amigos",.. )
#              
# # Segunda Alternativa:
#
#
# vertices.df <- data.frame(name = c("A", "B", "C", "D", "E", "F", "G"),
#                           age = c(20, 25, 21, 23, 24, 23, 22), stringsAsFactors = F)
#
# edges.df <- data.frame(from = c(rep("A", 5), "E", "F"),
#                        to = c("B", "C", "D", "E", "F", "F", "G"),
#                        frequency = c(2, 1, 1, 1, 3, 2, 4), stringsAsFactors = F)
#
#
# red = graph_from_data_frame(d = edges.df, vertices = vertices.df, directed = FALSE)
# plot(red)
#
# E(red)[[inc("A")]]
#
# E(red)[[frequency >= 2]]



genders <- c("M", "F", "F", "M", "M", "M", "F", "M", "M", "F", "M", "F",
             "M", "F", "M", "M")

ages <- c(18, 19, 21, 20, 22, 18, 23, 21, 22, 20, 20, 22, 21, 18, 19,
          20)

g <- set_vertex_attr(g, "gender", value = genders)
g <- set_vertex_attr(g, "age", value = ages)
vertex_attr(g)
V(g)[[1:5]]


# Edge attributes
# Cuantas horas pasan los amigos
hours <- c(1, 2, 2, 1, 2, 5, 5, 1, 1, 3, 2, 1, 1, 5, 1, 2, 4, 1, 3, 1,
           1, 1, 4, 1, 3, 3, 4) # horas que pasan los amigos

g <- set_edge_attr(g,"hours", value = hours)

# View edge attributes of graph object
edge_attr(g)

# Find all edges that include "Britt"
E(g)[[inc("Britt")]]

# Find all pairs that spend 4 or more hours together per week
E(g)[[hours>=4]]  

# Visualizar atributos de una red

friends1_edges <- data.frame(name1 = c("Joe", "Joe", "Joe", "Erin", "Kelley",
                                       "Ronald", "Ronald", "Ronald", "Michael", "Michael", "Michael",
                                       "Valentine", "Troy", "Troy", "Jasmine", "Jasmine", "Juan", "Carey",
                                       "Frankie", "Frankie", "Micheal", "Micheal", "Keith", "Keith",
                                       "Gregory"),
                             name2 = c("Ronald", "Michael", "Troy", "Kelley", "Valentine", "Troy", "Perry",
                                       "Jasmine", "Troy", "Jasmine", "Juan", "Perry", "Jasmine", "Juan",
                                       "Juan", "Carey", "Demetrius", "Frankie", "Micheal", "Merle", "Merle",
                                       "Alex", "Gregory", "Marion", "Marion"),
                             hours = c(1L, 3L, 2L, 3L, 5L, 1L, 3L, 5L, 2L, 1L, 3L, 5L,
                                       3L, 2L, 6L, 1L, 2L, 2L, 1L, 1L, 2L, 1L, 1L, 3L, 2L),
                             stringsAsFactors = F)

friends1_nodes <- data.frame(name = c("Joe", "Erin", "Kelley", "Ronald", "Michael",
                                      "Valentine", "Troy", "Jasmine", "Juan", "Carey", "Frankie", "Micheal",
                                      "Keith", "Gregory", "Perry", "Demetrius", "Merle", "Alex", "Marion"),
                             gender = c("M", "F", "F", "M", "M", "F", "M", "F", "M", "F",
                                        "F", "M", "M", "M", "M", "M", "M", "F", "F"),
                             stringsAsFactors = F)

library(igraph)

# Create an igraph object with attributes directly from dataframes
g1 <- graph_from_data_frame(d = friends1_edges, vertices = friends1_nodes, directed = FALSE)


# Subset edges greater than or equal to 5 hours
E(g1)[[hours >= 5]]  

# Set vertex color by gender
V(g1)$color <- ifelse(V(g1)$gender == "F", "orange", "dodgerblue")

# Plot the graph
plot(g1, vertex.label.color = "black")


# Visualización de grafos

library(igraph)

# Plot the graph object g1 in a circle layout
plot(g1, vertex.label.color = "black", layout = layout_in_circle(g1))

# Plot the graph object g1 in a Fruchterman-Reingold layout
plot(g1, vertex.label.color = "black", layout = layout_with_fr(g1))

# Plot the graph object g1 in a Tree layout
m <- layout_as_tree(g1)
plot(g1, vertex.label.color = "black", layout = m)

# Plot the graph object g1 using igraph's chosen layout
m1 <- layout_nicely(g1)
plot(g1, vertex.label.color = "black", layout = m1)


library(igraph)

# Create a vector of weights based on the number of hours each pair spend together
w1 <- E(g1)$hours

# Plot the network varying edges by weights
m1 <- layout_nicely(g1)
plot(g1,
     vertex.label.color = "black",
     edge.color = 'black',
     edge.width = w1,
     layout = m1)

# Create a new igraph object by deleting edges that are less than 2 hours long
g2 <- delete_edges(g1, E(g1)[hours < 2])


# Plot the new graph
w2 <- E(g2)$hours
m2 <- layout_nicely(g2)

plot(g2,
     vertex.label.color = "black",
     edge.color = 'black',
     edge.width = w2,
     layout = m2)


# Quiz
# Cuantos edges tiene Jazmin
plot(g1)

E(g1)[[inc('Jasmine')]]



########## Capítulo 2 de redes (Redes dirigidas - directed network ) ####################
# Ejemplo envío de emails, ingoing and outgoing (sale de una dirección a otro)
# Los grafos señalados por U son no dirigidos (undirected), los que comienzan por D son
# grafos dirigidos (directed)

# Grafico dirigido: is.directed(g)
# Gráfico ponderado: is.weight(g)


# Grado de un nodo (vertex):
# En un gráfico no dirigido: cuantos enlaces (edges) tiene el grafo.
# En un gráfico  dirigido: cuantos enlaces (edges) tiene el grafo.
# Grafos dirigidos: out-degree, in-degree
# Out-degree de la red: cuantos enlaces (edge) salientes tiene un nodo (vertex)
# In-degree: cuanos enlaces ingresan al nodo.

# A -> B -> C : A tiene un out-degree de uno, C tiene un in-degree de uno  

# Determinar si existe un enlace (edge) entre A y E;
# g['A', 'E'], devuelve uno si hay relación presente.


# Determinar todos los enlaces de los nodos:
#incident(g, "A", mode = c("all"))


# Encontrar los vertices de origen de todos los enlaces:
# head_of(g, E(g))


# Get the graph object
# g <- network(measles, directed = T)


measles <- data.frame(from = c(45L, 45L, 172L, 180L, 45L, 180L, 42L, 45L, 182L, 45L, 182L,
                               45L, 12L, 181L, 45L, 181L, 181L, 175L, 181L, 181L, 181L, 45L,
                               45L, 22L, 22L, 45L, 10L, 180L, 31L, 45L, 45L, 45L, 45L, 181L,
                               182L, 34L, 182L, 17L, 45L, 93L, 180L, 178L, 42L, 45L, 184L, 45L,
                               45L, 10L, 17L, 8L, 31L, 17L, 17L, 17L, 17L, 45L, 56L, 45L, 58L,
                               58L, 186L, 11L, 19L, 45L, 64L, 64L, 11L, 179L, 54L, 180L, 10L,
                               12L, 180L, 45L, 74L, 5L, 180L, 181L, 179L, 78L, 39L, 45L, 82L,
                               82L, 44L, 1L, 47L, 47L, 12L, 93L, 93L, 93L, 45L, 183L, 10L, 97L,
                               45L, 64L, 11L, 47L, 7L, 21L, 37L, 58L, 74L, 42L, 19L, 106L, 12L,
                               18L, 34L, 21L, 31L, 78L, 16L, 45L, 116L, 116L, 116L, 7L, 11L,
                               188L, 7L, 7L, 7L, 37L, 106L, 7L, 7L, 56L, 56L, 14L, 18L, 78L,
                               79L, 17L, 16L, 34L, 4L, 6L, 145L, 145L, 145L, 45L, 172L, 18L,
                               14L, 39L, 148L, 153L, 153L, 45L, 153L, 73L, 45L, 156L, 156L,
                               37L, 68L, 148L, 123L, 123L, 102L, 102L, 153L, 110L, 98L, 153L,
                               153L, 169L, 174L, 173L, 146L, 184L, 184L, 177L, 177L, 184L, 184L,
                               184L, 82L, 45L, 82L, 175L),
                      to =  c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 14L,
                              15L, 16L, 17L, 18L, 19L, 20L, 21L, 22L, 23L, 24L, 25L, 26L, 27L,
                              28L, 29L, 30L, 31L, 32L, 33L, 34L, 35L, 36L, 37L, 38L, 39L, 40L,
                              41L, 42L, 43L, 44L, 45L, 46L, 47L, 48L, 49L, 50L, 51L, 52L, 53L,
                              54L, 55L, 56L, 57L, 58L, 59L, 60L, 61L, 62L, 63L, 64L, 65L, 66L,
                              67L, 68L, 69L, 70L, 71L, 72L, 73L, 74L, 75L, 76L, 77L, 78L, 79L,
                              80L, 81L, 82L, 83L, 84L, 85L, 86L, 87L, 88L, 89L, 90L, 91L, 92L,
                              93L, 94L, 95L, 96L, 97L, 98L, 99L, 100L, 101L, 102L, 103L, 104L,
                              105L, 106L, 107L, 108L, 109L, 110L, 111L, 112L, 113L, 114L, 115L,
                              116L, 117L, 118L, 119L, 120L, 121L, 122L, 123L, 124L, 125L, 126L,
                              127L, 128L, 129L, 130L, 131L, 132L, 133L, 134L, 135L, 136L, 137L,
                              138L, 139L, 140L, 142L, 143L, 144L, 145L, 146L, 147L, 148L, 149L,
                              150L, 151L, 152L, 153L, 154L, 155L, 156L, 157L, 158L, 159L, 160L,
                              161L, 162L, 163L, 164L, 165L, 166L, 167L, 168L, 169L, 170L, 171L,
                              172L, 175L, 176L, 177L, 178L, 179L, 180L, 181L, 182L, 183L, 185L,
                              186L, 187L, 188L), stringsAsFactors = T)

library(igraph)
# Get the graph object
g <- graph_from_data_frame(measles, directed = T)
plot(g)

# Where does each edge originate from?
table(head_of(g, E(g)))


# Make a basic plot
plot(g,
     vertex.label.color = "black",
     edge.color = 'gray77',
     vertex.size = 0,
     edge.arrow.size = 0.1,
     layout = layout_nicely(g))

# Is there an edge going from vertex 184 to vertex 178?
g['184', '178']

# Is there an edge going from vertex 178 to vertex 184?
g['178', '184']

incident(g, "184", mode = c("all"))

# Show all edges going out from vertex 184
incident(g, '184', mode = c("out"))

# Show all edges going out from vertex 184
incident(g, '184', mode = c("in"))

# Identify all neighbors of vertex 12 regardless of direction
neighbors(g, '12', mode = c('all'))

neighbors(g, '12', mode = c('in')) # Llega al 12.



# Identify any vertices that receive an edge from vertex 42 and direct an edge to vertex 124
n1 <- neighbors(g, '42', mode = c('out'))
n2 <- neighbors(g, '124', mode = c('in'))
intersection(n1, n2)


# Interconectividad de una red

# La interconectividad de una red peude ser evaluada examinando el número y la longitud 
# de caminos entres los vertices

# Un camino es simplemente la cadena de conexiones entre los vertices
# El número de nodos entre dos vertices representa la distancia geodésica entre dos vertices.


# Los nodos que están conectados uno con otro tienen una distancia geodésica de 1.
# Aquellos nodos que están conectados unos con otros, que comparten un vecino en común pero no 
# están conectados unos con otros tienen una distancia geodésica de dos, etc.

# En las redes dirigidas, la dirección de los enlaces puede ser tenida en cuenta. Si dos nodos no pueden ser
#alcancazado por medio de enlaces dirigidos, entonces estos dos nodos tienen una distancia infinita.

# Ejercicio:  encontrar los caminos más largos entre vertices en una red y diferenciar los nodos
# que están dentro de n conexiones de un nodo específico.

# Diámetro: la distancia más lartga entre dos nodos.
# Which two vertices are the furthest apart in the graph ?
farthest_vertices(g) 

# Shows the path sequence between two furthest apart vertices.
get_diameter(g)  


# Identify vertices that are reachable within two connections from vertex 42
ego(graph = g, order = 2, nodes = '42', mode = c('out'))

# Identify vertices that can reach vertex 42 within two connections
ego(graph = g, order = 2, nodes = '42', mode = c('in'))



# Nodos importantes y de alta influencia

# Medidas de importancia de nodos
# Grado 
# Betweenness
# Centralidad eigenvector
# Centralidad Closeness
# Centralidad Pagerank


# Motivación: imagine un nodo con un alto número de conexiones (alto grado), 
# Un nodo es altamente influenciable si está conectado con otros nodos
# altamente conectados en la red (nodos con un alto eigenvector de centralidad)
# Otras formas de calcular influencia 

# Degree: Out-degree and in-degree


# Identificar los vertices claves
# La medida más directa de la importancia de un nodo es el grado.
#El out-degree de un nodo es el número de otros nodos al cual un nodo tiene enlaces dirigidos a él.
# El in-degree  es el número de enlaces que recibe de otros individuos.
#En la red de sarampión, los individuos que infectan a muchos individuos tienen un alto out-degree.
        

# Calculate the out-degree of each vertex
g.outd <- degree(g, mode = c("out"))
sort(g.outd)
# El individuo 45 es el que más infecta individuos

# View a summary of out-degree
table(g.outd)

# Make a histogram of out-degrees
hist(g.outd, breaks = 30)

# Find the vertex that has the maximum out-degree
which.max(g.outd)



# Betweenness
# Otra medida de la importancia de un nodo es el betweenness.
# Este es un índice de que tan frecuentemente un nodo yace en el camino más corto entre dos nodos 
# cualesquiera de la red.
# Puede ser pensado como que tan crítico es el nodo en el flujo de información de la red.
# Los individuos con un un valor alto de betweenness son puentes claves entre diferentes partes de una red.
# En el ejemplo de red de transmisión de la viruela los nodos con más altos betweenness son 
# aquellos niños que son centrales pasando la enfermedad a otras partes de la red. 
# En este ejercicio, se identificará el puntaje betweenness para cada nodo y hacer un gráfico de la red 
# ajustando los tamaños de los nodos por su puntaje de betweenness para enfatizar los nodos claves.

# Es una medida de que tanto es un nodo puente con los otros nodos de la red
# Nodos con una alto betweeness son importantes controlando la información.
# Betweeness para el nodo v (vertex)
# Numerador: Total de caminos cortos entre el nodo s y t
# DEnominador: Total de caminos cortos entre el nodo s y t que contienen a v
# Puede ser escalada entre cero y uno


# Calculate betweenness of each vertex
g.b <- betweenness(g, directed = TRUE)
summary(g.b)

# Show histogram of vertex betweenness
hist(g.b, breaks = 80)

# Create plot with vertex size determined by betweenness score
plot(g, 
     vertex.label = NA,
     edge.color = 'black',
     vertex.size = sqrt(g.b)+1,
     edge.arrow.size = 0.05,
     layout = layout_nicely(g))


# La estadística betweedness falla si el nodo de interés no se le conoce el origen. El nodo 84 aunque 
# infectó bastantes no aparece relevante según esta estadística.
# Análisis de la red 184
incident(g, "184", mode = c("all"))



# Make an ego graph
g184 <- make_ego_graph(g, diameter(g), nodes = '184', mode = c("all"))[[1]]

# Get a vector of geodesic distances of all vertices from vertex 184 
dists <- distances(g184, "184")

# Create a color palette of length equal to the maximal geodesic distance plus one.
colors <- c("black", "red", "orange", "blue", "dodgerblue", "cyan") # Arrance desde el cero

# Set color attribute to vertices of network g184.
V(g184)$color <- colors[dists+1]

# Visualize the network based on geodesic distance from vertex 184 (patient zero).
plot(g184, 
     vertex.label = dists, 
     vertex.label.color = "white",
     vertex.label.cex = .6,
     edge.color = 'black',
     vertex.size = 7,
     edge.arrow.size = .05,
     main = "Geodesic Distances from Patient Zero"
)

# Eigenvector centralidad: que también conectada está conectada un nodo.
# Los nodos con el eigenvector más grande son aquellos que están conectados a otros 
# nodos pero también a otros nodos que están altamente conectados a otros.
#eigen_centrality(g)$vector


#################### Medidas de estructuras de la red ##########################

# Densidad: medida de que tan conecatada está una red. 
# proporción de enlaces que realmente existen de todos los enlaces que 
# podrían existir. Por ejemplo en una red de 13 nodos, puede haber 13 combinado dos enlaces (78)
# si hay 15 enlaces, la densidad es 15 / 78 = 19%.
#edge_density()

# Promedio de la longitud de camino (Average Path Length): medida de interconectividad
# de la red, promedio de las longitudes los caminos más cortos de todos los pares
# de vertices de la red.
        
#mean_distance(g, directed = T)


library(igraph)

# Inspect Forrest Gump Movie dataset

gump <- data.frame(V1 = c("ABBIE HOFFMAN", "ABBIE HOFFMAN", "ANCHORMAN", "ANCHORMAN", 
        "ANCHORMAN", "ANCHORMAN", "ANCHORMAN", "ANNOUNCER", "ANNOUNCER", 
        "ANNOUNCER", "ANOTHER DAY", "ANOTHER DAY", "ANOTHER DAY", "ASSISTANT COACH", 
        "ASSISTANT COACH", "BERT", "BERT", "BILLY", "BLACK WOMAN", "BLACK WOMAN", 
        "BOB HOPE", "BOY", "BOY #1", "BOY #1", "BOY #1", "BOY #1", "BOY #1", 
        "BOY #2", "BOY #2", "BOY #2", "BOY #2", "BOY #3", "BOY #3", "BOY #3", 
        "BUBBA", "BUBBA", "BUBBA", "BUBBA", "BUBBA", "BUBBA", "BUS STOP - PRESENT - DAY", 
        "BUS STOP - PRESENT - DAY", "CAB DRIVER", "CARLA", "CARLA", "ASSISTANT COACH", 
        "CHET HUNTLEY", "CHET HUNTLEY", "CHET HUNTLEY", "DALLAS", "DALLAS", 
        "DEAN", "DEAN", "DICK CAVETT", "CARLA", "DICK CLARK", "DICK CLARK", 
        "DICK CLARK", "DOCTOR", "ANOTHER DAY", "BUBBA", "DRILL SERGEANT", 
        "DRILL SERGEANT", "DRILL SERGEANT", "ELVIS", "EMCEE", "EMCEE", 
        "EMCEE", "EMCEE", "EMCEE", "EMCEE", "EMCEE", "ERNIE", "FOOTBALL COACH", 
        "ABBIE HOFFMAN", "AGING HIPPIE", "ANOTHER DAY", "BERT", "BILLY", 
        "BLACK PANTHER", "BLACK WOMAN", "BOB HOPE", "BUBBA", "BUS DRIVER", 
        "BUS STOP - PRESENT - DAY", "DALLAS", "DICK CAVETT", "DJ", "DRIVER", 
        "EARL", "ELDERLY WOMAN", "ELVIS", "EMCEE", "ERNIE", "FORREST", 
        "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
        "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
        "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
        "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
        "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
        "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "GIRL", 
        "ABBIE HOFFMAN", "HILARY", "HILARY", "HILARY", "ABBIE HOFFMAN", 
        "HILARY", "ISABEL", "ISABEL", "ISABEL", "BERT", "BILLY", "BLACK PANTHER", 
        "DJ", "DRIVER", "ERNIE", "FORREST", "FORREST JR", "JENNY", "JENNY", 
        "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", 
        "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", 
        "EARL", "FORREST", "CARLA", "FORREST", "LENORE", "BERT", "ERNIE", 
        "FORREST JR", "FORREST", "JENNY", "LOUISE", "LOUISE", "BUBBA", 
        "DALLAS", "FORREST", "LT DAN", "LT DAN", "LT DAN", "LT DAN", 
        "BERT", "ERNIE", "FORREST JR", "LITTLE BOY", "MALE NURSE", "ELDERLY WOMAN", 
        "MAN #", "MAN #", "MAN #", "MAN #1", "MAN #1", "MAN #1", "MAN #1", 
        "MAN #", "MAN #2", "MAN #2", "MAN #2", "MAN #", "MAN #3", "MAN #3", 
        "LT DAN", "BLACK PANTHER", "MASAI", "MAN #5", "FORREST", "JENNY", 
        "LOUISE", "LT DAN", "MINISTER", "BUS DRIVER", "DOCTOR", "FORREST", 
        "LOUISE", "JENNY", "LOUISE", "NEWSCASTER", "FORREST", "GOVERNOR WALLACE", 
        "JENNY", "NEWSMAN", "NIGHT", "FORREST", "FOOTBALL COACH", "FORREST", 
        "BOY", "JENNY", "OLDER BOY #1", "FORREST", "JENNY", "FORREST", 
        "FORREST", "OFFICER", "MRS GUMP", "FORREST", "FORREST", "BLACK PANTHER", 
        "JENNY", "MASAI", "RUBEN", "FORREST", "DALLAS", "FORREST", "MAN", 
        "SGT SIMS", "SGT SIMS", "FORREST", "ANNOUNCER", "DALLAS", "FORREST", 
        "LT DAN", "MAN", "SOLDIER", "BUBBA", "DALLAS", "FORREST", "LT DAN", 
        "MAN", "SGT SIMS", "SOLDIER", "SONG", "MAN", "ABBIE HOFFMAN", 
        "JENNY", "POLICEMAN", "BLACK PANTHER", "BILLY", "JENNY", "NEWSCASTER"),
V2 = c("JENNY", "POLICEMAN", "FORREST", "LT DAN", "MARGO", "MRS GUMP", 
       "PRESIDENT JOHNSON", "FORREST", "JENNY", "LT DAN", "BUBBA", "NIGHT", 
       "SONG", "FOOTBALL COACH", "FORREST", "ERNIE", "FORREST JR", "BLACK WOMAN", 
       "JENNY", "WHITE WOMAN", "LT DAN", "JENNY", "BOY #2", "BOY #3", 
       "FORREST", "JENNY", "SLOW MOTION", "BOY #3", "FORREST", "JENNY", 
       "SLOW MOTION", "FORREST", "JENNY", "SLOW MOTION", "DALLAS", "MAN", 
       "NIGHT", "SGT SIMS", "SOLDIER", "STRONGARM", "DICK CAVETT", "JOHN LENNON", 
       "JENNY", "FORREST", "LT DAN", "CHET HUNTLEY", "FOOTBALL COACH", 
       "FORREST", "GOVERNOR WALLACE", "MAN", "STRONGARM", "FORREST", 
       "MRS GUMP", "JOHN LENNON", "DICK CLARK", "FORREST", "LENORE", 
       "LT DAN", "FORREST", "DRILL SERGEANT", "DRILL SERGEANT", "FORREST", 
       "NIGHT", "SONG", "MRS GUMP", "JENNY", "MAN #", "MAN #1", "MAN #2", 
       "MAN #3", "MAN #5", "MEN", "FORREST JR", "FORREST", "FORREST", 
       "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
       "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
       "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", "FORREST", 
       "FORREST", "HILARY", "ISABEL", "JENNY'S DAD", "JOHN LENNON", 
       "LITTLE BOY", "LYNN MARIE", "MALE NURSE", "MAN", "MAN #", "MAN #1", 
       "MAN #2", "MAN #3", "MAN #5", "MASAI", "MEN", "MRS BLUE", "NEWSCASTER", 
       "NIGHT", "NURSE", "OLD SHRIMPER", "OLDER BOY #1", "OLDER BOY #2", 
       "POLICEMAN", "PRESIDENT KENNEDY", "PRINCIPAL", "RUBEN", "STRONGARM", 
       "SUSAN", "VET", "WESLEY", "WHITE WOMAN", "WILD-EYED MAN", "YOUNG HIPPIE", 
       "YOUNG MAN", "FORREST JR", "GIRL", "JENNY", "HILARY", "JENNY", 
       "POLICEMAN", "VET", "ISABEL", "ISABEL", "JENNY", "POLICEMAN", 
       "VET", "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", "JENNY", 
       "JENNY", "JENNY", "JENNY'S DAD", "LITTLE BOY", "LT DAN", "LYNN MARIE", 
       "MAN #", "MAN #1", "MAN #2", "MAN #3", "MAN #5", "MASAI", "MEN", 
       "OLDER BOY #2", "SLOW MOTION", "SUSAN", "WESLEY", "YOUNG HIPPIE", 
       "KATZENBACH", "KATZENBACH", "LENORE", "LENORE", "LT DAN", "LITTLE BOY", 
       "LITTLE BOY", "LITTLE BOY", "LOUISE", "LOUISE", "LT DAN", "SUSAN", 
       "LT DAN", "LT DAN", "LT DAN", "MAN", "SGT SIMS", "STRONGARM", 
       "SUSAN", "LYNN MARIE", "LYNN MARIE", "LYNN MARIE", "LYNN MARIE", 
       "SOLDIER", "MAN", "MAN #5", "MEN", "MAN #1", "MAN #2", "MAN #3", 
       "MAN #5", "MEN", "MAN #2", "MAN #3", "MAN #5", "MEN", "MAN #3", 
       "MAN #5", "MEN", "MARGO", "MASAI", "WESLEY", "MEN", "MINISTER", 
       "MINISTER", "MINISTER", "MINISTER", "SUSAN", "MRS GUMP", "MRS GUMP", 
       "MRS GUMP", "MRS GUMP", "NEWSCASTER", "NEWSCASTER", "NEWSMAN", 
       "NEWSMAN", "NEWSMAN", "NEWSMAN", "REPORTER", "SONG", "OFFICER", 
       "OLDER BOY", "OLDER BOY", "OLDER BOY #1", "OLDER BOY #1", "OLDER BOY #2", 
       "PATRONS", "POLICEMAN", "PRESIDENT JOHNSON", "PRESIDENT NIXON", 
       "PRESIDENT NIXON", "PRINCIPAL", "REPORTER", "REVEREND", "RUBEN", 
       "RUBEN", "RUBEN", "WESLEY", "SECURITY GUARD", "SGT SIMS", "SGT SIMS", 
       "SGT SIMS", "SOLDIER", "STRONGARM", "SLOW MOTION", "SOLDIER", 
       "SOLDIER", "SOLDIER", "SOLDIER", "SOLDIER", "STRONGARM", "SONG", 
       "SONG", "SONG", "SONG", "SONG", "SONG", "SONG", "STRONGARM", 
       "STRONGARM", "VET", "VET", "VET", "WESLEY", "WHITE WOMAN", "WHITE WOMAN", 
       "YOUNG MAN")
,
stringsAsFactors = F )

        
# Make an undirected network
g <- graph_from_data_frame(gump, directed = FALSE)
#plot(g)
# Identify key nodes using eigenvector centrality
g.ec <- eigen_centrality(g)
which.max((g.ec$vector))
sort(g.ec$vector)


# Plot Forrest Gump Network
plot(g,
     vertex.label.color = "black", 
     vertex.label.cex = 0.6,
     vertex.size = 25*(g.ec$vector),
     edge.color = 'gray88',
     main = "Forrest Gump Network"
)



#Network density and average path length
#Densidad: la proporción de los enlaces que existen sobre los enlaces potenciales. Es un indicador
#de que también la red está conectada

#Diámetro de la red: The longest path length between any pair of vertices is 
#called the diameter of the network graph


# Get density of a graph
gd <- edge_density(g)

# Get the diameter of the graph g
diameter(g, directed = FALSE)

# Get the average path length of the graph g
g.apl <- mean_distance(g, directed = FALSE)


# Random Networks 
# Generar grafos con el mismo número de nodos como el grafo original y 
# aproximadamente la misma densidad del original

# Create one random graph with the same number of nodes and edges as g
g.random <- erdos.renyi.game(n = gorder(g), p.or.m = gd, type = "gnp")

plot(g.random)

# Get density of new random graph `g.random`
edge_density(g.random)

#Get the average path length of the random graph g.random
mean_distance(g.random, directed = FALSE) #average.path.length()


# Generate 1000 random graphs
gl <- vector('list', 1000)

for(i in 1:1000){
        gl[[i]] <- erdos.renyi.game(n = gorder(g), p.or.m = gd, type = "gnp")
}

# Calculate average path length of 1000 random graphs
gl.apls <- unlist(lapply(gl, average.path.length, directed = FALSE))
mean(gl.apls)
summary(gl.apls)


# Plot the distribution of average path lengths
hist(gl.apls, xlim = range(c(1.5, 6)))
abline(v = g.apl, col = "red", lty = 3, lwd = 2)


# Calculate the proportion of graphs with an average path length lower than our observed
mean(gl.apls < g.apl)
# the Forrest Gump network is far more interconnected than we would expect by chance as zero random networks have an average path length smaller than the Forrest Gump network's average path length


# Triadas transitividad (Triadas triangulos)
# Por cada tres nodos de vertices que existe en una red existe tres posibles enlaces.
# Triangulos cerrados: hay tres enlaces en los tres nodos, pueden existir triangulos con un enlace o con dos enlaces.
# Pueden haber trinagulos son enlaces
# triangles(g): triangulos cerrados.

#Transitividad: mide la probabilidad de que todos los vertices adyacentes de un 
#nodo dado esté conectado.
# transitivity(g)
# clustering coefficients

# Transitividad local: calcula la proporción de de triangulos cerrados del cual un nodo 
# es parte, sobre el número teórico de trinagulos del cual puede ser parte el nodo.
# Se puede contar el número de triangulos cerrados para cada vértice usando 
#count_triangles().

# La transitividad local puede ser calculada usando transitivity(g, vids = "A", 
#                                                               type = "local")
# Proporción de conexiones de F que generan triangulos

# Cliques: en un clique cada nodo está conectado a todos los otros nodos.
#largest_cliques()
# max_cliques()

 
# Show all triangles (closed) in the network.
triangles(g)
triangulos <- matrix(triangles(g), nrow = 3)
ncol(triangulos)

# Count the number of triangles that vertex "BUBBA" is in.
count_triangles(g, vids = "BUBBA") # Bubba es parte de 38 triangulos

# Calculate  the global transitivity of the network.
g.tr <- transitivity(g)
g.tr

# Calculate the local transitivity for vertex BUBBA.
transitivity(g, vids='BUBBA', type = "local")


# Transitivity randomizations
#As you did for the average path length, let's investigate if the global transitivity of the Forrest Gump network is significantly higher than we would expect by chance for random networks of the same size and density. You can compare Forrest Gump's global transitivity to 1000 other random networks.


library(igraph)

# Calculate average transitivity of 1000 random graphs
gl.tr <- lapply(gl, transitivity)
gl.trs <- unlist(gl.tr)

# Get summary statistics of transitivity scores
summary(gl.trs)

# Calculate the proportion of graphs with a transitivity
# score higher than Forrest Gump's network


library(igraph)

# Calculate average transitivity of 1000 random graphs
gl.tr <- lapply(gl, transitivity)
gl.trs <- unlist(gl.tr)

# Get summary statistics of transitivity scores
summary(gl.trs)

# Calculate the proportion of graphs with a transitivity score higher than Forrest Gump's network
mean(gl.trs > g.tr)


# Cliques

# Identify the largest cliques in the network
largest_cliques(g)

# Determine all maximal cliques in the network and assign to object 'clq'
clq <- max_cliques(g)

# Calculate the size of each maximal clique.
table(unlist(lapply(clq, length)))




# Visualize largest cliques
# En ocasiones las visualizaciones necesitarán filtrar parte de 
# una red para inspeccionar las interconexiones de un nodo particular.
# Aquí usted creará una visualización de los cliques más largos.
# en la red de Forrest Gump.


# Assign largest cliques output to object 'lc'
lc <- largest_cliques(g)

# Create two new undirected subgraphs, each containing only the vertices of each largest clique.
gs1 <- as.undirected(subgraph(g, lc[[1]]))
gs2 <- as.undirected(subgraph(g, lc[[2]]))


# Plot the two largest cliques side-by-side

par(mfrow=c(1,2)) # To plot two plots side-by-side

plot(gs1,
     vertex.label.color = "black", 
     vertex.label.cex = 0.9,
     vertex.size = 0,
     edge.color = 'gray28',
     main = "Largest Clique 1",
     layout = layout.circle(gs1)
)

plot(gs2,
     vertex.label.color = "black", 
     vertex.label.cex = 0.9,
     vertex.size = 0,
     edge.color = 'gray28',
     main = "Largest Clique 2",
     layout = layout.circle(gs2)
)



# Close Relationships 

# ¿Los nodos se asocian aleatoriamente con otros nodos, o ellos 
# prefieren asociarse con vertices similares? Niños son más
# procensos a ser amigos por el mismo sexo?
# Personas con la misma posición política son más procensas a 
# responder tweets.

# Asortatividad
# La asortatividad es la preferencia de los nodos de una red por 
# unirse a otros que le son similares en alguna característica.
# A pesar de que la medida específica de similitud puede variar, 
# los teóricos de redes frecuentemente estudian la asortatividad 
# en función del grado de los nodos.
       
# El vínculo prefencial de vértices a otros vertices 
# que son similares en atributos numéricos o categóricos.
# Edad, sexo.
# assortativity(g, values) # values: atributo de cada vertice.
# 0 indica que no existe patrón de apego preferencial.
# 1, individuos se apegan a individuos similares
# individuos se apegan a indovoduos diferentes


# Degree assortativity 
# Nodos con un alto grado se conectan preferiblemente a otros
# nodos con un alto grado. 
# assortativity.degree(g, directed = F)

# Reciprocidad
# La proporción de relaciones que es simétrica, la porporción de outgoing edges que tiene
# un ingoing edges
# reciprocity()



######################### Ejercicios ############################

friends1_edges <- data.frame(name1 = c("Joe", "Joe", "Joe", "Erin", "Kelley",
                                       "Ronald", "Ronald", "Ronald", "Michael", "Michael", "Michael",
                                       "Valentine", "Troy", "Troy", "Jasmine", "Jasmine", "Juan", "Carey",
                                       "Frankie", "Frankie", "Micheal", "Micheal", "Keith", "Keith",
                                       "Gregory"),
                             name2 = c("Ronald", "Michael", "Troy", "Kelley", "Valentine", "Troy", "Perry",
                                       "Jasmine", "Troy", "Jasmine", "Juan", "Perry", "Jasmine", "Juan",
                                       "Juan", "Carey", "Demetrius", "Frankie", "Micheal", "Merle", "Merle",
                                       "Alex", "Gregory", "Marion", "Marion"),
                             hours = c(1L, 3L, 2L, 3L, 5L, 1L, 3L, 5L, 2L, 1L, 3L, 5L,
                                       3L, 2L, 6L, 1L, 2L, 2L, 1L, 1L, 2L, 1L, 1L, 3L, 2L),
                             stringsAsFactors = F)

friends1_nodes <- data.frame(name = c("Joe", "Erin", "Kelley", "Ronald", "Michael",
                                      "Valentine", "Troy", "Jasmine", "Juan", "Carey", "Frankie", "Micheal",
                                      "Keith", "Gregory", "Perry", "Demetrius", "Merle", "Alex", "Marion"),
                             gender = c("M", "F", "F", "M", "M", "F", "M", "F", "M", "F",
                                        "F", "M", "M", "M", "M", "M", "M", "F", "F"),
                             stringsAsFactors = F)

library(igraph)

# Create an igraph object with attributes directly from dataframes
g1 <- graph_from_data_frame(d = friends1_edges, vertices = friends1_nodes, directed = FALSE)


##### Ejercicios #######################################
plot(g1)

# Convert the gender attribute into a numeric value
values <- as.numeric(factor(V(g1)$gender))

# Calculate the assortativity of the network based on gender
assortativity(g1, values)

# Calculate the assortativity degree of the network
assortativity.degree(g1, directed = FALSE)

# Utilizar aleatorización para evaluar ascertividad
# En este ejercicio se determina que tan probable la asortatividad
# en la red de amigos está dada por el genero haciendo un 
# procedimiento de aleatorización.

# Calculate the observed assortativity
observed.assortativity <- assortativity(g1, values)

results <- vector('list', 1000)
for(i in 1:1000){
        results[[i]] <- assortativity(g1, sample(values))
}

# Plot the distribution of assortativity values and add a red vertical line at the original observed value
hist(unlist(results))
abline(v = observed.assortativity, col = "red", lty = 3, lwd=2)
summary(unlist(results))

# Reciprocidad
# La reciprocidad de una red dirigida 

library(igraph)

# Make a plot of the chimp grooming network

g <- structure(list(15, TRUE, c(0, 5, 7, 8, 10, 11, 2, 4, 6, 11, 1, 
                           3, 4, 9, 12, 13, 2, 5, 8, 9, 12, 2, 7, 14, 0, 2, 8, 7, 8, 12, 
                           4, 11, 12, 13, 0, 1, 2, 3, 6, 10, 11, 13, 2, 5, 13, 14, 3, 5, 
                           8, 11, 2, 6, 7, 11, 13, 2, 3, 9, 10), c(14, 0, 0, 0, 0, 0, 1, 
                                                                   1, 1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6, 14, 
                                                                   7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 11, 
                                                                   11, 11, 14, 12, 12, 12, 12, 12, 13, 13, 13, 13), c(24, 34, 0, 
                                                                                                                      10, 35, 6, 16, 21, 25, 36, 42, 50, 55, 11, 37, 46, 56, 7, 12, 
                                                                                                                      30, 1, 17, 43, 47, 8, 38, 51, 2, 22, 52, 27, 3, 18, 26, 28, 48, 
                                                                                                                      13, 19, 57, 4, 39, 58, 5, 9, 31, 40, 53, 49, 14, 20, 29, 32, 
                                                                                                                      15, 33, 41, 44, 54, 23, 45), c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 
                                                                                                                                                     11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 
                                                                                                                                                     28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 
                                                                                                                                                     44, 45, 46, 47, 48, 50, 51, 52, 53, 54, 55, 56, 57, 58, 0, 27, 
                                                                                                                                                     49), c(0, 3, 5, 13, 17, 20, 24, 27, 31, 36, 39, 42, 48, 52, 57, 
                                                                                                                                                            59), c(0, 5, 9, 11, 15, 20, 23, 26, 28, 32, 40, 44, 47, 52, 56, 
                                                                                                                                                                   59), list(c(1, 0, 1), structure(list(name = "Erdos renyi (gnp) graph", 
                                                                                                                                                                                                        type = "gnp", loops = FALSE, p = 0.3), .Names = c("name", 
                                                                                                                                                                                                                                                          "type", "loops", "p")), list(), list())), class = "igraph")
plot(g,
     edge.color = "black",
     edge.arrow.size = 0.3,
     edge.arrow.width = 0.5)

# Calculate the reciprocity of the graph
reciprocity(g)



# Detección de comunidades (modulos, grupos, clusters)
# Si una red tiene una estructura de comunidad, entonces es posible
# asignar nodos a unos conjuntos únicos.

# Las conexiones entre miembros serán más densas en esos grupos
# fast greedy method: método, trata de construir comunidades cada vez más grandes
# agregando nodos a cada comunidad uno por uno y evaluando 
# un puntaje de modularidad en cada paso.

# El score de modularidad es un índice que como los nodos están interconectados al inerior versus
# las otras comunidades

# fastgreedy.community()
# length(x) # Tamaño de las comunidades
# sizes(x) # tamaño de cada comunidad
# membership() # miembros de cada comunidad
# betweeness de nodos (edge - betweeness)
# edge betweness method.

# plot(x, g)

# Fast-greedy community detection


# Fast degree 
# Karate club 
library(igraphdata)
data(karate)
g <- karate 
# Perform fast-greedy community detection on network graph
kc <- fastgreedy.community(g)

# Determine sizes of each community
sizes(kc)

# Determine which individuals belong to which community
membership(kc)

# Plot the community structure of the network
plot(kc, g)


# Edge-betweenness community detection
# Una alternativa para detectección comunidades es edge-betweenness

# Perform edge-betweenness community detection on network graph
gc = edge.betweenness.community(g)

# Determine sizes of each community
igraph::sizes(gc)

# Plot community networks determined by fast-greedy and edge-betweenness methods side-by-side
par(mfrow = c(1, 2)) 
plot(kc, g)
plot(gc, g)


leading.eigenvector.community(g)


# One very useful one is threejs which allows you to make interactive network visualizations. This package also integrates seamlessly with igraph. In this exercise you will make a basic interactive network plot of the karate club network using the threejs package
