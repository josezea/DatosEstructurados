# -*- coding: utf-8 -*-
"""
Created on Fri Mar 13 13:34:50 2020

@author: Home
"""

import pandas as pd
import os

os.chdir(r'C:\Users\Home\Documents\Laboral2020\Konrad Lorenz\Datos Estructurados y No estructurados\Clase8')
os.listdir()
emb=pd.read_csv('variables_adicionales_hogar_v3.txt', sep = ";")

# mean sum std

# Calcular el promedio del ingreso del hogar sin usar factor de expansión
emb.columns
emb.INGRESOS_HOG.median()
emb.INGRESOS_HOG.mean()

# Promedio: sum(w_i * y_i) / sum(w_i)

def prom_est(df, y_i, w_i):
    d = df[y_i]
    w = df[w_i]
    return(sum(d * w) / sum(w))
# Puedes generalizar a toda la población
emb.groupby("HOGAR_LP").apply(prom_est,"INGRESOS_HOG",  "FEX_C")

# Usual: sin expandir, estaría MAL!!!!!!!!!!!
emb.groupby("HOGAR_LP").aggregate({'INGRESOS_HOG':'mean'})

# Total de cuanto ganan todos los Bogotanos
# Leer la tabla de viviendas
viv=pd.read_table('viviendas_2017_v2_03092018.txt', sep = ",",
                  encoding='latin1')
viv=viv[['DIRECTORIO', 'DPTOMPIO', 'LOCALIDAD_TEX',
               'COD_UPZ', 'ESTRATO_TEX']]

emb=emb.merge(viv, on='DIRECTORIO', how='left')
emb.DPTOMPIO.value_counts()
emb=emb.query("DPTOMPIO == 11001") # DIVIPOLA

sum(emb.INGRESOS_HOG * emb.FEX_C) 

# N estimado de Bogotanos (hogares bogotanos)
sum(emb.FEX_C) 



# Ejercicio: Proporción de pobreza (monetaria (Pobre LP)
# desagregado por localidad (Bogotá)


emb.groupby("LOCALIDAD_TEX").apply(prom_est,"HOGAR_LP",  "FEX_C")

















con = mysql.connector.connect(user='root', password='jfzeac',
                              host='localhost',
                              database='prueba')



cur = con.cursor()
cur.execute("SELECT * FROM tbl_estudiantes")
table_rows = cur.fetchall()

df = pd.DataFrame(table_rows)

con.close()