DROP TYPE IF EXISTS Direccion CASCADE;
CREATE TYPE Direccion AS (
Nombre_via	VarChar(100),
Poblacion	VarChar(50),
Provincia	VarChar(50));

DROP TYPE IF EXISTS Nombre_completo CASCADE;
CREATE TYPE Nombre_completo AS (
Nombre		VarChar(30),
Apellidos	VarChar(80));

DROP TABLE IF EXISTS Empleado CASCADE;
CREATE TABLE Empleado (
DNI		VarChar(20) PRIMARY KEY,
Edad		INT,
Estado_civil	VarChar(20),
Direccion	Direccion,
Nombre_completo Nombre_completo);

DROP TABLE IF EXISTS Cliente CASCADE;
CREATE TABLE Cliente (
DNI		VarChar(45) PRIMARY KEY,
Edad		INT,
Direccion	Direccion,
Nombre_completo Nombre_completo);

DROP TABLE IF EXISTS Concesionario CASCADE;
CREATE TABLE Concesionario (
Credenciales			VarChar(20) PRIMARY KEY,
Nombre				VarChar(30),
Direccion			Direccion,
DNI_empleado_responsable	VarChar(20) REFERENCES Empleado(DNI));

DROP TABLE IF EXISTS Coche CASCADE;
CREATE TABLE Coche (
Numero_de_bastidor		VarChar(30) PRIMARY KEY,
Matricula			VarChar(10),
Tipo				VarChar(10),
Color				VarChar(10),
Modelo				VarChar(15),
Marca				VarChar(15),
Consumo				DOUBLE PRECISION,
Indice_de_contaminacion 	DOUBLE PRECISION,
Capacidad_baterias		DOUBLE PRECISION,
Rango_estimado			DOUBLE PRECISION,
Credenciales_concesionario	VarChar(20) REFERENCES Concesionario(Credenciales));

DROP TABLE IF EXISTS Reparaciones CASCADE;
CREATE TABLE Reparaciones (
Codigo				INT PRIMARY KEY,
Fecha				DATE,
Descripcion			VarChar(200),
Numero_de_bastidor		VarChar(30) REFERENCES Coche(Numero_de_bastidor));

DROP TABLE IF EXISTS Piezas CASCADE;
CREATE TABLE Piezas (
Codigo			INT PRIMARY KEY,
Nombre			VarChar(20),
Codigo_reparacion 	INT REFERENCES Reparaciones(Codigo));

DROP TABLE IF EXISTS Trabaja CASCADE;
CREATE TABLE Trabaja (
Codigo			INT PRIMARY KEY,	
DNI			VarChar(45) REFERENCES Empleado(DNI),
Credenciales		VarChar(20) REFERENCES Concesionario(Credenciales));

DROP TABLE IF EXISTS Venta CASCADE;
CREATE TABLE Venta (
Codigo			INT PRIMARY KEY,
Numero_de_bastidor	VARCHAR(30) REFERENCES Coche(Numero_de_bastidor),
DNI_cliente		VARCHAR(45) REFERENCES Cliente(DNI),
DNI_empleado		VARCHAR(45) REFERENCES Empleado(DNI),
Precio			INT,
Fecha			DATE);

DROP TABLE IF EXISTS Punto_de_recarga CASCADE;
CREATE TABLE Punto_de_recarga (
Numero_de_serie		VARCHAR(20) PRIMARY KEY,
Direccion		Direccion);

DROP TABLE IF EXISTS Provee CASCADE;
CREATE TABLE Provee (
Codigo			INT PRIMARY KEY,
Codigo_coche_electrico  VARCHAR(45) REFERENCES Coche(Numero_de_bastidor),
Numero_de_serie		VARCHAR(45) REFERENCES Punto_de_recarga(Numero_de_serie));

CREATE OR REPLACE FUNCTION solo_coche_electrico() RETURNS TRIGGER AS $solo_coche_electrico$
	DECLARE
		cap 	double precision;
		rang	double precision;
		ind	double precision;
		con	double precision;

	BEGIN
		SELECT Capacidad_baterias,Rango_estimado,Indice_de_contaminacion,Consumo INTO cap,rang,ind,con FROM Coche WHERE Numero_de_bastidor = NEW.Codigo_coche_electrico;
		IF cap IS NOT NULL AND rang IS NOT NULL AND ind IS NULL AND con IS NULL THEN
			RETURN NEW;
		ELSE
			RAISE WARNING 'El coche no es electrico';
			RETURN NULL;
		END IF;
	END;
$solo_coche_electrico$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trigger_solo_coche_electrico ON Provee;
CREATE TRIGGER trigger_solo_coche_electrico BEFORE INSERT ON Provee
FOR EACH ROW EXECUTE PROCEDURE solo_coche_electrico();

CREATE OR REPLACE FUNCTION coche_solo_un_tipo() RETURNS TRIGGER AS $coche_solo_un_tipo$
	BEGIN
		IF NEW.Capacidad_baterias IS NOT NULL AND NEW.Rango_estimado IS NOT NULL AND NEW.Indice_de_contaminacion IS NULL AND NEW.Consumo IS NULL THEN
			RETURN NEW;
		ELSIF NEW.Capacidad_baterias IS NOT NULL AND NEW.Rango_estimado IS NULL AND NEW.Indice_de_contaminacion IS NULL AND NEW.Consumo IS NOT NULL THEN
			RETURN NEW;
		ELSIF NEW.Capacidad_baterias IS NULL AND NEW.Rango_estimado IS NULL AND NEW.Indice_de_contaminacion IS NOT NULL AND NEW.Consumo IS NOT NULL THEN
			RETURN NEW;
		ELSE
			RAISE WARNING 'El tipo de coche no es correcto';
			RETURN NULL;
		END IF;
	END;
$coche_solo_un_tipo$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trigger_coche_solo_un_tipo ON Coche;
CREATE TRIGGER trigger_coche_solo_un_tipo BEFORE INSERT ON Coche
FOR EACH ROW EXECUTE PROCEDURE coche_solo_un_tipo();

CREATE OR REPLACE FUNCTION trabaja_comprobar_pk() RETURNS TRIGGER AS $trabaja_comprobar_pk$
	DECLARE
		result INT;
	BEGIN
		SELECT Codigo INTO result FROM Trabaja WHERE DNI = NEW.DNI AND Credenciales = NEW.Credenciales;
		IF result IS NULL THEN
			RETURN NEW;
		ELSE
			RAISE WARNING 'El empleado ya trabaja en ese concesionario';
			RETURN NULL;
		END IF;
	END;
$trabaja_comprobar_pk$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trigger_trabaja_comprobar_pk ON Trabaja;
CREATE TRIGGER trigger_trabaja_comprobar_pk BEFORE INSERT ON Trabaja
FOR EACH ROW EXECUTE PROCEDURE trabaja_comprobar_pk();

CREATE OR REPLACE FUNCTION provee_comprobar_pk() RETURNS TRIGGER AS $provee_comprobar_pk$
	DECLARE
		result INT;
	BEGIN
		SELECT Codigo INTO result FROM Provee WHERE Codigo_coche_electrico = NEW.Codigo_coche_electrico AND Numero_de_serie = NEW.Numero_de_serie;
		IF result IS NULL THEN
			RETURN NEW;
		ELSE
			RAISE WARNING 'Esa entrada ya existe';
			RETURN NULL;
		END IF;
	END;
$provee_comprobar_pk$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trigger_provee_comprobar_pk ON Provee;
CREATE TRIGGER trigger_provee_comprobar_pk BEFORE INSERT ON Provee
FOR EACH ROW EXECUTE PROCEDURE provee_comprobar_pk();

CREATE OR REPLACE FUNCTION venta_comprobar_pk() RETURNS TRIGGER AS $venta_comprobar_pk$
	DECLARE
		result INT;
	BEGIN
		SELECT Codigo INTO result FROM Venta WHERE Numero_de_bastidor = NEW.Numero_de_bastidor;
		IF result IS NULL THEN
			RETURN NEW;
		ELSE
			RAISE WARNING 'Este coche ya ha sido vendido';
			RETURN NULL;
		END IF;
	END;
$venta_comprobar_pk$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS trigger_venta_comprobar_pk ON Venta;
CREATE TRIGGER trigger_venta_comprobar_pk BEFORE INSERT ON Venta
FOR EACH ROW EXECUTE PROCEDURE venta_comprobar_pk();

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
