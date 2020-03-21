rm(list = ls())

library(haven)
library(dplyr)


setwd("D:/Gdrive/Laboral 2018/Universidad del Rosario/EMB2017/Identificacion ( Capitulo A)")
capA <- read_dta("Identificacion ( Capitulo A).dta")

setwd("D:/Gdrive/Laboral 2018/Universidad del Rosario/EMB2017/Datos de la vivenda y su entorno  ( Capitulo B)")
capB <- read_dta("Datos de la vivenda y su entorno  ( Capitulo B).dta")
capB <- capB %>% select(DIRECTORIO, SECUENCIA_P, NVCBP11AA)


setwd("D:/Gdrive/Laboral 2018/Universidad del Rosario/EMB2017/Composicion del hogar y demografia ( Capitulo E)")
capE <- read_dta("Composicion del hogar y demografia ( Capitulo E).dta")
capE <- select(capE, DIRECTORIO, DIRECTORIO_HOG, DIRECTORIO, NPCEP4  )
capE <- left_join(capE, capA[c("DIRECTORIO", "CLASE")], by = "DIRECTORIO")

setwd("D:/Gdrive/Laboral 2018/Universidad del Rosario/EMB2017/Fuerza de trabajo  (capitulo K)")
capK <- read_dta("Fuerza de trabajo  (cap�tulo K).dta")

# Ni�os

# Integrar la base de datos, al m�dulo de caracter�sticas de personas

table((capE$NPCEP4 >= 10 & capE$CLASE == 2) |
        (capE$NPCEP4 >= 12 & capE$CLASE == 1))
dim(capE)

# Otros ingresos (10 a�os y m�s en rural, 12 a�os y m�s en rural)
table((capE$NPCEP4 >= 10 & capE$CLASE == 2) |
        (capE$NPCEP4 >= 12 & capE$CLASE == 1))
dim(capE)


table((capE$NPCEP4 <= 10 & capE$CLASE == 2) |
        (capE$NPCEP4 <= 12 & capE$CLASE == 1))
dim(capE)
capE$Indica_ninos <- as.numeric((capE$NPCEP4 <= 10 & capE$CLASE == 2) |
                                  (capE$NPCEP4 <= 12 & capE$CLASE == 1))
table(capE$Indica_ninos)



# Ocupados

# Cap�tulo K
# Pregunta 1 - NPCKP1 (opci�n 1) 
# �En qu� actividad ocup� ... la mayor parte del tiempo la semana pasada? (Trabajando)

# Pregunta 2 - NPCKP2 (opci�n 1)
# Adem�s de lo anterior, �� realiz� la semana pasada alguna actividad paga por una hora o m�s? (S�)

# Pregunta 3 - NPCKP3 (opci�n 1) 
# Aunque ... no trabaj� la semana pasada, por una hora o m�s en forma remunerada,
# �ten�a durante esa semana alg�n trabajo o negocio por el que recibe ingresos? (S�)

# Pregunta 4 - NPCKP4 (opci�n 1)
# �� trabaj� la semana pasada en un negocio por UNA HORA O M�S sin que le pagaran? (S�)

table(capK$NPCKP1 == 1 | capK$NPCKP2 == 1 | capK$NPCKP3 == 1 |   capK$NPCKP4 == 1) 
dim(capK)

capK$Indica_ocupados <- as.numeric(capK$NPCKP1 == 1 | capK$NPCKP2 == 1 | capK$NPCKP3 == 1 |   capK$NPCKP4 == 1) 



########################## Desocupados ##########################
# Cap�tulo K, pregunta 13 - P6351  (opci�n 1)
# Si le hubiera resultado alg�n trabajo a ..., �estaba disponible la
# semana  pasada para empezar a trabajar?: S�

table(capK$NPCKP13 == 1, useNA = "always")
dim(capK)
capK$Indica_desocupados <- as.numeric(capK$NPCKP13 == 1) 

#####################################################################



########################## Inactivos ############################
# Cap�tulo H: 
# Pregunta 2 - NPCKP1 (opci�n 5): �En qu� actividad ocup� ... la mayor parte del tiempo la semana pasada? (Incapacitado permanente para trabajar )
table(capK$NPCKP1)

# Pregunta 7 - NPCKP7 (opci�n 2): �... desea conseguir un trabajo remunerado o instalar un negocio? (No)
table(capK$NPCKP7)


# Pregunta 8 - NPCKP8 (opcione 9 a 13):
# Aunque ... desea trabajar, �por qu� motivo principal no hizo diligencias 
# para buscar un trabajo o instalar un negocio en las �LTIMAS 4 SEMANAS?
# (Usted se considera muy joven o muy viejo, Responsabilidades familiares , 
#  Problemas de salud,  Est� estudiando, Otro)
table(capK$NPCKP8)


# Pregunta 10 - NPCKP10 (Opci�n 2),
# Despu�s de su �ltimo empleo, �... ha hecho alguna diligencia para
# conseguir trabajo o instalar un negocio? (No)
table(capK$NPCKP10)

# Pregunta 11 - NPCKP11 (opci�n 2)
# Durante los �ltimos 12 meses, �� ha hecho alguna diligencia para
# conseguir trabajo o instalar un negocio? (No)
table(capK$NPCKP11)


# Pregunta 13 - NPCKP13 (opci�n 2)
# Si le hubiera resultado alg�n trabajo a ..., �estaba disponible la semana
# pasada para empezar a trabajar? (No)
table(capK$NPCKP13)

table(capK$NPCKP1 == 5 |
        capK$NPCKP7 == 2 |
        capK$NPCKP8 %in% 9:13 |
        capK$NPCKP10 == 2 |
        capK$NPCKP11 == 2 |
        capK$NPCKP13 == 2, useNA = "always")
dim(capK)



capK$Indica_inactivos <- as.numeric(capK$NPCKP1 == 5 |
                                      capK$NPCKP7 == 2 |
                                      capK$NPCKP8 %in% 9:13 |
                                      capK$NPCKP10 == 2 |
                                      capK$NPCKP11 == 2 |
                                      capK$NPCKP13 == 2) 





# Ingreso
library(sjlabelled)
attr(capK$NPCKP23,"label")

attr(capK$NPCKP24,"label")
attr(capK$NPCKP24A,"label")

attr(capK$NPCKP25,"label")
attr(capK$NPCKP25A,"label")

attr(capK$NPCKP26,"label")
attr(capK$NPCKP26A,"label")

attr(capK$NPCKP27,"label")
attr(capK$NPCKP27A,"label")

attr(capK$NPCKP28,"label")
attr(capK$NPCKP28A,"label")

attr(capK$NPCKP29,"label")
attr(capK$NPCKP29A,"label")


attr(capK$NPCKP30,"label")
attr(capK$NPCKP30A,"label")


attr(capK$NPCKP31,"label")
attr(capK$NPCKP31A,"label")


attr(capK$NPCKP32,"label")
attr(capK$NPCKP32A,"label")

attr(capK$NPCKP33,"label")
attr(capK$NPCKP33A,"label")
capK$NPCKP33A

attr(capK$NPCKP34A,"label")
capK$NPCKP34AA /12

attr(capK$NPCKP34B,"label")
capK$NPCKP34BA / 12

attr(capK$NPCKP34C,"label")
capK$NPCKP34CA / 12

attr(capK$NPCKP34D,"label")
capK$NPCKP34DA / 12

attr(capK$NPCKP34E,"label")
capK$NPCKP34EA / 12


attr(capK$NPCKP36,"label")
attr(capK$NPCKP37,"label")

NPCKP36 / NPCKP37


attr(capK$NPCKP47,"label")
attr(capK$NPCKP47A,"label")

attr(capK$NPCKP48,"label")
attr(capK$NPCKP48A,"label")


attr(capK$NPCKP52,"label")
attr(capK$NPCKP52A,"label")



attr(capK$NPCKP53,"label")
attr(capK$NPCKP53A,"label")
capK$NPCKP53A 


attr(capK$NPCKP54,"label")
attr(capK$NPCKP54A,"label")
capK$NPCKP54A 

attr(capK$NPCKP55,"label")
attr(capK$NPCKP55A,"label")
capK$NPCKP55A / 12

attr(capK$NPCKP56,"label")
attr(capK$NPCKP56B,"label")
capK$NPCKP56B/12


attr(capK$NPCKP57,"label")
attr(capK$NPCKP57A,"label")

capK$NPCKP57A/12




Ingresos <- data.frame(Salario = capK$NPCKP23, HorasExtras = capK$NPCKP24A, Ganancia_alim =  capK$NPCKP25A,
                       Ganancia_Viv = capK$NPCKP26A, Ganancia_OtrosEspecies = capK$NPCKP27A, 
                       EstimadoTransporte = capK$NPCKP28A, SubisdioAlim = capK$NPCKP29A,
                       Auxilio_Transporte = capK$NPCKP30A,  SubisdioDinero = capK$NPCKP31A,
                       SubisdioEduc = capK$NPCKP32A, Prima = capK$NPCKP33A, 
                       PrimaServicio = capK$NPCKP34AA / 12, PrimaNavidad = capK$NPCKP34BA / 12,
                       PrimaVacaciones = capK$NPCKP34CA / 12, Bonificaciones = capK$NPCKP34DA / 12,
                       Indeminizaciones = capK$NPCKP34EA / 12,
                       Ganancia_neta = capK$NPCKP36 / capK$NPCKP37,OtroNegocios = capK$NPCKP47A,
                       IngresoTrabajo = capK$NPCKP48A, Pension = capK$NPCKP52A,
                       SostenimMenores = capK$NPCKP53A, Arriendo = capK$NPCKP54A,
                       PrimasPension = capK$NPCKP55A / 12,
                       Ayudas = capK$NPCKP56B/12, VentasPropiedades = capK$NPCKP57A/12)

dim(Ingresos)
Ingresos$TotalIngresoPersona <- rowSums(Ingresos, na.rm = T)


# Integraci�n de la base a la base de personas

