

CREATE DATABASE prueba; 
USE prueba;

CREATE TABLE tbl_estudiantes (
 id_estud int,
 nombre varchar(50),
 `materias vistas` varchar(50),
  email varchar(50),
  fecha varchar(10), 
  puntaje decimal(3,1),
  PRIMARY KEY (id_estud));

# En la linea de comandos, previamente colocar las variables de entorno.tbl_estudiantestbl_estudiantestbl_estudiantestbl_estudiantes
  # mysql -u root -p --local-infile=1 prueba
  
  LOAD DATA LOCAL INFILE 'C:\\Users\\Home\\Documents\\Laboral2020\\Konrad Lorenz\\Datos Estructurados y No estructurados\\Clase7\\estudiantes.csv' 
  INTO TABLE tbl_estudiantes FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
  IGNORE 1 LINES;
  