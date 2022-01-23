DROP TYPE IF EXISTS Tipo_direccion CASCADE;
DROP TABLE IF EXISTS T_Linea CASCADE;
DROP TYPE Plano CASCADE;
DROP TYPE IF EXISTS Proyecto CASCADE;
DROP TYPE IF EXISTS JefeProyecto CASCADE;
DROP TABLE IF EXISTS T_Jefe_Proyecto CASCADE;
DROP TABLE IF EXISTS T_Proyecto CASCADE;
DROP TABLE IF EXISTS T_Plano CASCADE;
DROP TABLE IF EXISTS T_Figura CASCADE;
DROP TYPE IF EXISTS Poligono CASCADE;
DROP TABLE IF EXISTS T_Poligono CASCADE;
DROP TYPE IF EXISTS Punto CASCADE;
DROP TYPE IF EXISTS Linea CASCADE;
DROP TYPE IF EXISTS Figura CASCADE;
DROP FUNCTION IF EXISTS Longitud;
DROP TRIGGER IF EXISTS ActualizarNumFigurasmas ON T_Figura;
DROP TRIGGER IF EXISTS ActualizarNumFigurasmenos ON T_Figura;


CREATE TYPE Tipo_Direccion AS
( Tipo_via		VarChar(4),
Nombre_via		VarChar(100),
Población		VarChar(50),
CP			VarChar(4),
Provincia		Varchar(50));

CREATE TYPE Plano AS
( CodPlano		Integer,
F_entrega		Date,
Arquitectos		VarChar(15)Array[10],
DibujoPlano		Bit(83886080),
Num_Figuras		Integer);

CREATE TYPE Proyecto AS
( Cod_Proyecto		Integer,
Nombre			VarChar(50),
Tiene_Planos		Plano);

CREATE TYPE JefeProyecto AS
( Cod_JefeProyecto	Integer,
Nombre			VarChar(50),
Direccion		Tipo_Direccion,
Telefono		VarChar(10),
Dirige			Proyecto);

CREATE TABLE T_Jefe_Proyecto OF JefeProyecto(
Cod_JefeProyecto	PRIMARY KEY,
Nombre			Unique);

CREATE TABLE T_Proyecto OF Proyecto(
Cod_Proyecto		PRIMARY KEY);

CREATE TABLE T_Plano OF Plano(
CodPlano		PRIMARY KEY);


CREATE TYPE Figura AS (
Cod_Figura		Integer,
Nombre			VarChar(30),
Color			VarChar(30),
Plano_Pert		Plano);


CREATE TABLE T_Figura OF Figura (
Cod_Figura		PRIMARY KEY,
Plano_Pert		NOT NULL);

CREATE TYPE Punto AS (
Coord_X			Integer,
Coord_Y			Integer);

CREATE TYPE Linea AS (
Id_Linea		Integer,
Puntos			Punto ARRAY[2],
Longitud		Integer);

CREATE TYPE Poligono As (
Num_Lineas 		Integer,
Tiene_Lineas		Linea,
Super			Figura);

CREATE TABLE T_Poligono OF Poligono;

CREATE FUNCTION Longitud(orig Punto, dest Punto) RETURNS Integer AS $calcLong$
	BEGIN
		RETURN sqrt(pow(dest.Coord_X - orig.Coord_çX) + pow(dest.Coord_Y - dest.Coord_Y));
	END;
$calcLong$ LANGUAGE plpgsql;


CREATE TABLE T_Linea OF Linea(
id_Linea 		PRIMARY KEY);

CREATE OR REPLACE FUNCTION actualizar_figuras_mas() RETURNS TRIGGER AS $actFigMas$
	DECLARE
		old_value int;
		new_value int;
	BEGIN
		SELECT Num_Figuras INTO old_value FROM T_Plano WHERE CodPlano = NEW.Plano_Pert;
		new_value = old_value + 1;
		UPDATE T_Plano SET Num_Figuras = new_value WHERE CodPlano = NEW.Plano_pert;
	END;
$actFigMas$ LANGUAGE plpgsql;

CREATE TRIGGER ActualizarNumFigurasmas AFTER INSERT ON T_Figura
FOR EACH ROW EXECUTE PROCEDURE actualizar_figuras_mas();	

CREATE OR REPLACE FUNCTION actualizar_figuras_menos() RETURNS TRIGGER AS $actFigMenos$
	DECLARE
		old_value int;
		new_value int;
	BEGIN
		SELECT Num_Figuras INTO old_value FROM T_Plano WHERE CodPlano = NEW.Plano_Pert;
		new_value = old_value - 1;
		UPDATE T_Plano SET Num_Figuras = new_value WHERE CodPlano = NEW.Plano_pert;
	END;
$actFigMenos$ LANGUAGE plpgsql;

CREATE TRIGGER ActualizarNumFigurasmenos AFTER INSERT ON T_Figura
FOR EACH ROW EXECUTE PROCEDURE actualizar_figuras_menos();
