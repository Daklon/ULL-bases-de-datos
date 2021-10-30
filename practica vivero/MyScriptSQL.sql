CREATE SCHEMA IF NOT EXISTS mydb ;
DROP TABLE IF EXISTS mydb.Vivero CASCADE ;
CREATE TABLE IF NOT EXISTS mydb.Vivero (
  nombre VARCHAR(45) NOT NULL,
  localidad VARCHAR(45) NOT NULL,
  Latitud FLOAT NULL,
  Longuitud FLOAT NULL,
  PRIMARY KEY (nombre, localidad))
;
DROP TABLE IF EXISTS mydb.Zona CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Zona (
  Nombre VARCHAR(45) NULL,
  Vivero_nombre VARCHAR(45) NOT NULL,
  Vivero_localidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (Nombre, Vivero_nombre, Vivero_localidad),
  CONSTRAINT fk_Zona_Vivero
    FOREIGN KEY (Vivero_nombre , Vivero_localidad)
    REFERENCES mydb.Vivero (nombre , localidad)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
DROP TABLE IF EXISTS mydb.Producto CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Producto (
  precio FLOAT NULL,
  Código VARCHAR(45) NULL,
  stock INT NULL,
  PRIMARY KEY (Código))
;
DROP TABLE IF EXISTS mydb.Cliente CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Cliente (
  dni VARCHAR(45) NOT NULL,
  bonificacion VARCHAR(45) NULL,
  total_mensual VARCHAR(45) NULL,
  PRIMARY KEY (dni))
;
DROP TABLE IF EXISTS mydb.Empleado CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Empleado (
  Dni VARCHAR(45) NOT NULL,
  css INT NULL,
  sueldo FLOAT NULL,
  antiguedad INT NULL,
  PRIMARY KEY (Dni))
;
DROP TABLE IF EXISTS mydb.Compra CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Compra (
  Cliente_dni VARCHAR(45) NULL,
  Producto_Código VARCHAR(45) NULL,
  Fecha timestamp NOT NULL,
  Cantidad INT NULL,
  Empleado_Dni VARCHAR(45) NOT NULL,
  PRIMARY KEY (Cliente_dni, Producto_Código, Fecha, Empleado_Dni),
  CONSTRAINT fk_Cliente_has_Producto_Cliente1
    FOREIGN KEY (Cliente_dni)
    REFERENCES mydb.Cliente (dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Cliente_has_Producto_Producto1
    FOREIGN KEY (Producto_Código)
    REFERENCES mydb.Producto (Código)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Compra_Empleado1
    FOREIGN KEY (Empleado_Dni)
    REFERENCES mydb.Empleado (Dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
DROP TABLE IF EXISTS mydb.Trabaja CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Trabaja (
  Fecha_ini timestamp NOT NULL,
  Fecha_fin timestamp NULL,
  Ventas INT NULL,
  Empleado_Dni VARCHAR(45) NULL,
  Zona_nombre VARCHAR(45) NOT NULL,
  Zona_Vivero_nombre VARCHAR(45) NOT NULL,
  Zona_Vivero_localidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (Fecha_ini, Empleado_Dni, Zona_Vivero_nombre, Zona_Vivero_localidad),
  CONSTRAINT fk_Trabaja_Empleado1
    FOREIGN KEY (Empleado_Dni)
    REFERENCES mydb.Empleado (Dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Trabaja_Zona1
    FOREIGN KEY (Zona_nombre, Zona_Vivero_nombre , Zona_Vivero_localidad)
    REFERENCES mydb.Zona (Nombre, Vivero_nombre , Vivero_localidad)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
DROP TABLE IF EXISTS mydb.Zona_has_Producto CASCADE;
CREATE TABLE IF NOT EXISTS mydb.Zona_has_Producto (
  Zona_nombre VARCHAR(45) NOT NULL,
  Zona_Vivero_nombre VARCHAR(45) NULL,
  Zona_Vivero_localidad VARCHAR(45) NULL,
  Producto_Código VARCHAR(45) NULL,
  PRIMARY KEY (Zona_Vivero_nombre, Zona_Vivero_localidad, Producto_Código),
  CONSTRAINT fk_Zona_has_Producto_Zona1
    FOREIGN KEY (Zona_nombre, Zona_Vivero_nombre , Zona_Vivero_localidad)
    REFERENCES mydb.Zona (Nombre, Vivero_nombre , Vivero_localidad)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Zona_has_Producto_Producto1
    FOREIGN KEY (Producto_Código)
    REFERENCES mydb.Producto (Código)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
START TRANSACTION;
INSERT INTO mydb.Vivero (nombre, localidad, Latitud, Longuitud) VALUES ('Vivers', 'Adeje', 1989.99, 9898.92);
INSERT INTO mydb.Vivero (nombre, localidad, Latitud, Longuitud) VALUES ('Vivero', 'Icod', 1748.90, 9898.82);
INSERT INTO mydb.Vivero (nombre, localidad, Latitud, Longuitud) VALUES ('viverillo', 'Guia de Isora', 1234.77, 90989.78);
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Zona (Nombre, Vivero_nombre, Vivero_localidad) VALUES ('Zona A', 'Vivers', 'Adeje');
INSERT INTO mydb.Zona (Nombre, Vivero_nombre, Vivero_localidad) VALUES ('Zona B', 'Vivers', 'Adeje');
INSERT INTO mydb.Zona (Nombre, Vivero_nombre, Vivero_localidad) VALUES ('Zona C', 'Vivers', 'Adeje');
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Producto (precio, Código, stock) VALUES ('10', '1111', '10');
INSERT INTO mydb.Producto (precio, Código, stock) VALUES ('20', '1112', '11');
INSERT INTO mydb.Producto (precio, Código, stock) VALUES ('30', '1113', '15');
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Cliente (dni, bonificacion, total_mensual) VALUES ('11345678L', 'Premium', '100');
INSERT INTO mydb.Cliente (dni, bonificacion, total_mensual) VALUES ('12645678L', 'Premium', '140');
INSERT INTO mydb.Cliente (dni, bonificacion, total_mensual) VALUES ('13345678L', 'Standard', '300');
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Empleado (Dni, css, sueldo, antiguedad) VALUES ('14345678L',10,1000.98,10);
INSERT INTO mydb.Empleado (Dni, css, sueldo, antiguedad) VALUES ('15345678L',10,1001.98,11);
INSERT INTO mydb.Empleado (Dni, css, sueldo, antiguedad) VALUES ('16345678L',10,1002.98,12);
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Compra (Cliente_dni, Producto_código, Fecha, Cantidad, Empleado_Dni) VALUES ('11345678L','1111',to_timestamp('02 May 2021', 'DD Mon YYYY'),1,'14345678L');
INSERT INTO mydb.Compra (Cliente_dni, Producto_código, Fecha, Cantidad, Empleado_Dni) VALUES ('12645678L','1111',to_timestamp('03 May 2021', 'DD Mon YYYY'),1,'14345678L');
INSERT INTO mydb.Compra (Cliente_dni, Producto_código, Fecha, Cantidad, Empleado_Dni) VALUES ('11345678L','1111',to_timestamp('04 May 2021', 'DD Mon YYYY'),1,'14345678L');
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Trabaja (Fecha_ini, Fecha_fin, Ventas, Empleado_Dni,Zona_Vivero_nombre,Zona_Vivero_localidad,Zona_nombre) VALUES (to_timestamp('02 May 2011', 'DD Mon YYYY'),NULL,3,'14345678L','Vivers','Adeje','Zona A');
INSERT INTO mydb.Trabaja (Fecha_ini, Fecha_fin, Ventas, Empleado_Dni,Zona_Vivero_nombre,Zona_Vivero_localidad,Zona_nombre) VALUES (to_timestamp('02 May 2010', 'DD Mon YYYY'),NULL,0,'15345678L','Vivers','Adeje','Zona A');
INSERT INTO mydb.Trabaja (Fecha_ini, Fecha_fin, Ventas, Empleado_Dni,Zona_Vivero_nombre,Zona_Vivero_localidad,Zona_nombre) VALUES (to_timestamp('02 May 2009', 'DD Mon YYYY'),NULL,0,'16345678L','Vivers','Adeje','Zona A');
COMMIT;
START TRANSACTION;
INSERT INTO mydb.Zona_has_producto (Zona_Vivero_nombre, Zona_Vivero_localidad, Zona_nombre, Producto_Código) VALUES ('Vivers','Adeje','Zona A','1111');
INSERT INTO mydb.Zona_has_producto (Zona_Vivero_nombre, Zona_Vivero_localidad, Zona_nombre, Producto_Código) VALUES ('Vivers','Adeje','Zona A','1112');
INSERT INTO mydb.Zona_has_producto (Zona_Vivero_nombre, Zona_Vivero_localidad, Zona_nombre, Producto_Código) VALUES ('Vivers','Adeje','Zona A','1113');
COMMIT;