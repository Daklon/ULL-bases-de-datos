START TRANSACTION;
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('1111111A', 25, 'Soltero', ROW('calle1','poblacion1','provincia1'),ROW('Nombre1','apellido1 apellido1.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('2222222A', 26, 'Casado', ROW('calle2','poblacion2','provincia1'),ROW('Nombre2','apellido2 apellido2.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('3333333A', 27, 'Viudo', ROW('calle3','poblacion1','provincia2'),ROW('Nombre3','apellido3 apellido3.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('4444444A', 27, 'Casado', ROW('calle4','poblacion3','provincia1'),ROW('Nombre4','apellido4 apellido4.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('5555555A', 21, 'Casado', ROW('calle5','poblacion1','provincia1'),ROW('Nombre5','apellido5 apellido5.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('6666666A', 30, 'Soltero', ROW('calle6','poblacion4','provincia2'),ROW('Nombre6','apellido6 apellido6.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('7777777A', 27, 'Soltero', ROW('calle7','poblacion5','provincia1'),ROW('Nombre7','apellido7 apellido7.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('8888888A', 34, 'Soltero', ROW('calle8','poblacion6','provincia1'),ROW('Nombre8','apellido8 apellido8.2'));
INSERT INTO Empleado (DNI,Edad,Estado_civil,Direccion,Nombre_completo) VALUES ('9999999A', 45, 'Soltero', ROW('calle9','poblacion7','provincia1'),ROW('Nombre9','apellido9 apellido9.2'));
COMMIT;

START TRANSACTION;
INSERT INTO Cliente (DNI,Edad,Direccion,Nombre_completo) VALUES ('1111111B', 34, ROW('calle1.2','poblacion1.2','provincia1.2'),ROW('Nombre1.2','apellido1.2 apellido1.2.2'));
INSERT INTO Cliente (DNI,Edad,Direccion,Nombre_completo) VALUES ('2222222B', 24, ROW('calle2.2','poblacion2.2','provincia2.2'),ROW('Nombre2.2','apellido2.2 apellido2.2.2'));
INSERT INTO Cliente (DNI,Edad,Direccion,Nombre_completo) VALUES ('3333333B', 35, ROW('calle3.2','poblacion3.2','provincia3.2'),ROW('Nombre3.2','apellido3.2 apellido3.2.2'));
INSERT INTO Cliente (DNI,Edad,Direccion,Nombre_completo) VALUES ('4444444B', 47, ROW('calle4.2','poblacion4.2','provincia4.2'),ROW('Nombre4.2','apellido4.2 apellido4.2.2'));
COMMIT;

START TRANSACTION;
INSERT INTO Concesionario (Credenciales,Nombre,Direccion,DNI_empleado_responsable) VALUES ('Credenciales1','Nombre1',ROW('calle1.3','población1.3','provincia1.3'),'1111111A');
INSERT INTO Concesionario (Credenciales,Nombre,Direccion,DNI_empleado_responsable) VALUES ('Credenciales2','Nombre2',ROW('calle2.3','población2.3','provincia2.3'),'2222222A');
COMMIT;

START TRANSACTION;
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (1,'1111111A','Credenciales1');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (2,'2222222A','Credenciales2');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (3,'3333333A','Credenciales1');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (4,'4444444A','Credenciales2');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (5,'5555555A','Credenciales2');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (6,'6666666A','Credenciales2');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (7,'7777777A','Credenciales1');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (8,'8888888A','Credenciales1');
INSERT INTO Trabaja (Codigo,DNI,Credenciales) VALUES (9,'9999999A','Credenciales1');
COMMIT;

START TRANSACTION;
INSERT INTO Coche (Numero_de_bastidor,Matricula,Tipo,Marca,Modelo,Color,Consumo,Indice_de_contaminacion,Capacidad_baterias,Rango_estimado,Credenciales_concesionario) VALUES 
('1v','111aaa','Tipo1','Marca1','Modelo1.1','Color1',4.5,2.3,NULL,NULL,'Credenciales1');
INSERT INTO Coche (Numero_de_bastidor,Matricula,Tipo,Marca,Modelo,Color,Consumo,Indice_de_contaminacion,Capacidad_baterias,Rango_estimado,Credenciales_concesionario) VALUES 
('2v','222aaa','Tipo2','Marca1','Modelo1.2','Color2',NULL,NULL,200,200,'Credenciales1');
INSERT INTO Coche (Numero_de_bastidor,Matricula,Tipo,Marca,Modelo,Color,Consumo,Indice_de_contaminacion,Capacidad_baterias,Rango_estimado,Credenciales_concesionario) VALUES 
('3v','333aaa','Tipo2','Marca1','Modelo1.3','Color3',4.5,NULL,20,NULL,'Credenciales1');
INSERT INTO Coche (Numero_de_bastidor,Matricula,Tipo,Marca,Modelo,Color,Consumo,Indice_de_contaminacion,Capacidad_baterias,Rango_estimado,Credenciales_concesionario) VALUES 
('4v','444aaa','Tipo1','Marca2','Modelo1.1','Color1',4.5,2.3,NULL,NULL,'Credenciales2');
COMMIT;

START TRANSACTION;
INSERT INTO Venta (Codigo,Numero_de_bastidor,DNI_cliente,DNI_empleado,Precio,Fecha) VALUES (1,'1v','1111111B','1111111A',10000,'2022-02-05');
COMMIT;

START TRANSACTION;
INSERT INTO Punto_de_recarga (Numero_de_serie,Direccion) VALUES ('1',ROW('calle1.4','poblacion1.4','provincia1.4'));
INSERT INTO Punto_de_recarga (Numero_de_serie,Direccion) VALUES ('2',ROW('calle2.4','poblacion2.4','provincia2.4'));
COMMIT;

START TRANSACTION;
INSERT INTO Provee (Codigo,Codigo_coche_electrico,Numero_de_serie) VALUES (1,'2v','1');
INSERT INTO Provee (Codigo,Codigo_coche_electrico,Numero_de_serie) VALUES (2,'2v','2');
COMMIT;

START TRANSACTION;
INSERT INTO Reparaciones (Descripcion,Fecha,Numero_de_bastidor,Codigo) VALUES ('Descripcion1','2022-02-06','1v',1);
COMMIT;

START TRANSACTION;
INSERT INTO Piezas (Codigo,Nombre,Codigo_reparacion) VALUES(1,'Nombre1',NULL);
INSERT INTO Piezas (Codigo,Nombre,Codigo_reparacion) VALUES(2,'Nombre2',1);
COMMIT;
