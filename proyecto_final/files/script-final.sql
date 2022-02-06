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
