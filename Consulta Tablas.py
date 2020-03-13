# -*- coding: utf-8 -*-
"""
Created on Fri Mar 13 13:34:50 2020

@author: Home
"""

import mysql.connector
import pandas as pd

con = mysql.connector.connect(user='root', password='jfzeac',
                              host='localhost',
                              database='prueba')



cur = con.cursor()
cur.execute("SELECT * FROM tbl_estudiantes")
table_rows = cur.fetchall()

df = pd.DataFrame(table_rows)

con.close()