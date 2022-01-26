-- TIPOS DE DATOS COMPUESTOS --

-- Tipo de dato: Punto --
-- Se compone de dos coordenadas (X, Y).

DROP TYPE IF EXISTS Punto_type CASCADE;

CREATE TYPE Punto_type AS (
    Coord_X         INTEGER,
    Coord_Y         INTEGER
);


-- Tipo de dato: Dirección
-- Dirección de una edificación.

DROP TYPE IF EXISTS Direccion_type CASCADE;

CREATE TYPE Direccion_type AS (
    Tipo_Via        TEXT,
    Nombre_Via      TEXT,
    Numero          INTEGER,
    Poblacion       TEXT,
    Codigo_Postal   INTEGER,
    Provincia       TEXT
);


-- TABLAS --

-- Tabla: Proyecto --
-- Almacena los datos relativos a un proyecto
-- arquitectónico.

DROP TABLE IF EXISTS Proyecto CASCADE;

CREATE TABLE Proyecto (
    Codigo          SERIAL,
--  Dirigido_por    INTEGER 
--                  REFERENCES Jefe_proyecto,
    Nombre          TEXT,

    PRIMARY KEY (Codigo)
);

--Tabla: Jefe_Proyecto --
-- Almacena los datos del arquitecto jefe de un proyecto.

DROP TABLE IF EXISTS Jefe_Proyecto CASCADE;

CREATE TABLE Jefe_Proyecto (
    Codigo          SERIAL,
    Nombre          TEXT UNIQUE,
    Telefono        TEXT,
    Direccion       Direccion_type,

    Dirige          INTEGER REFERENCES Proyecto (Codigo),

    PRIMARY KEY (Codigo)
);

-- Añadir Clave ajena de Proyecto que referencia a Jefe_Proyecto.

ALTER TABLE Proyecto
ADD COLUMN Dirigido_por INTEGER REFERENCES Jefe_Proyecto (Codigo);

-- Tabla: Plano
-- Almacena los datos de los planos que componen un proyecto.
-- Se almacenan como entidades separadas para que no se
-- pierdan si se elimina un Proyecto.

DROP TABLE IF EXISTS Plano CASCADE;

CREATE TABLE Plano (
    NIF             SERIAL,
    Arquitectos     TEXT[10],
    Fecha_entrega   DATE,
    Dibujo          BYTEA,
    Num_figuras     INTEGER,

    PRIMARY KEY (NIF)
);


-- Tabla: Figura
-- Almacena los datos relativos a las figuras que componen
-- los planos.

DROP TABLE IF EXISTS Figura CASCADE;

CREATE TABLE Figura (
    ID              SERIAL,
    Nombre          TEXT,
    Color           TEXT,
    Area            INTEGER,

    PRIMARY KEY (ID)
);

-- Tabla: Plano_Tiene_Figura --
-- Relación N:N entre Plano y Figura.

DROP TABLE IF EXISTS Plano_Tiene_Figura CASCADE;

CREATE TABLE Plano_Tiene_Figura (
    NIF_Plano       SERIAL REFERENCES Plano (NIF),
    ID_Figura       SERIAL REFERENCES Figura (ID),

    PRIMARY KEY (NIF_Plano, ID_Figura)
);

-- Tabla: Polígono --
-- Tabla que hereda de Figura.

DROP TABLE IF EXISTS Poligono CASCADE;

CREATE TABLE Poligono (
    -- Un polígono tiene varias líneas
    Num_Lineas      INTEGER,
    Perimetro       INTEGER,

    PRIMARY KEY (ID)
) INHERITS(Figura);

-- Tabla: Linea --
-- Cada elemento es una línea definida por dos puntos.
DROP TABLE IF EXISTS Linea CASCADE;

CREATE TABLE Linea (
    -- Una línea sólo puede pertenecer a un polígono
    ID              SERIAL,
    P_inicio        Punto_type,
    P_final         Punto_type,

    Pertenece       SERIAL REFERENCES Poligono (ID),

    PRIMARY KEY (ID)
);

-- INSERCIONES --

-- Tabla Poryecto
INSERT INTO Proyecto (Codigo, Nombre, Dirigido_por)
VALUES (1, 'Hospital', NULL);

INSERT INTO Proyecto (Codigo, Nombre, Dirigido_por)
VALUES (2, 'Aeropuerto', NULL);

INSERT INTO Proyecto (Codigo, Nombre, Dirigido_por)
VALUES (3, 'Puente', NULL);

-- Tabla Jefe_Proyecto
INSERT INTO Jefe_Proyecto (Codigo, Nombre, Telefono, Direccion, Dirige)
VALUES (1, 'Pepe González', '000000000', ROW('Avenida', 'Avenida 1', 10, 'San Cristóbal de La Laguna', 0000, 'Santa Cruz de Tenerife'), 1);

INSERT INTO Jefe_Proyecto (Codigo, Nombre, Telefono, Direccion, Dirige)
VALUES (2, 'Ana Ramírez', '111111111', ROW('Calle', 'Calle 1', 20, 'Telde', 1111, 'Las Palmas de Gran Canaria'), 2);

INSERT INTO Jefe_Proyecto (Codigo, Nombre, Telefono, Direccion, Dirige)
VALUES (3, 'Ramón Ramos', '222222222', ROW('Calle', 'Calle 2', 15, 'Las Arenas', 2222, 'Las Palmas de Gran Canaria'), 3);

-- Arreglos en Tabla Proyecto
-- Antes de insertar Jefes de Proyecto, no había valores válidos que darle a la columna Dirigido_por
UPDATE Proyecto
SET Dirigido_por = 1
WHERE Codigo = 1;

UPDATE Proyecto
SET Dirigido_por = 2
WHERE Codigo = 2;

UPDATE Proyecto
SET Dirigido_por = 3
WHERE Codigo = 3;

-- Ahora la columna no puede ser nula.
ALTER TABLE Proyecto
ALTER COLUMN Dirigido_por SET NOT NULL;

-- Tabla Plano
INSERT INTO Plano (NIF, Arquitectos, Fecha_entrega, Dibujo, Num_Figuras)
VALUES (1, ARRAY['Pepe', 'Ana', 'Ramón'], 'Jan-01-2022', NULL, NULL);

INSERT INTO Plano (NIF, Arquitectos, Fecha_entrega, Dibujo, Num_Figuras)
VALUES (2, ARRAY['Pepe', 'Ana', 'Ramón'], 'Jan-15-2022', NULL, NULL);

INSERT INTO Plano (NIF, Arquitectos, Fecha_entrega, Dibujo, Num_Figuras)
VALUES (3, ARRAY['Pepe', 'Ana', 'Ramón'], 'Feb-01-2022', NULL, NULL);

-- Tabla Figura
INSERT INTO Figura (ID, Nombre, Color, Area)
VALUES (1, 'Cubo', 'Amarillo', NULL);

INSERT INTO Figura (ID, Nombre, Color, Area)
VALUES (2, 'Pirámide Isósceles', 'Verde', NULL);

INSERT INTO Figura (ID, Nombre, Color, Area)
VALUES (3, 'Cilindro', 'Azul', NULL);

-- Tabla Plano_Tiene_Figura
INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (1, 1);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (1, 2);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (1, 3);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (2, 1);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (2, 2);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (2, 3);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (3, 1);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (3, 2);

INSERT INTO Plano_Tiene_Figura (NIF_Plano, ID_Figura)
VALUES (3, 3);

-- Tabla Polígono
INSERT INTO Poligono (ID, Nombre, Color, Area, Num_Lineas, Perimetro)
VALUES (4, 'Cuadrado', 'Rojo', NULL, NULL, NULL);

INSERT INTO Poligono (ID, Nombre, Color, Area, Num_Lineas, Perimetro)
VALUES (5, 'Triángulo Isósceles', 'Violeta', NULL, NULL, NULL);

INSERT INTO Poligono (ID, Nombre, Color, Area, Num_Lineas, Perimetro)
VALUES (6, 'Círculo', 'Marrón', NULL, NULL, NULL);

-- Tabla Linea
INSERT INTO Linea (ID, P_inicio, P_final, Pertenece)
VALUES (1, ROW(0, 0), ROW(0, 2), 4);

INSERT INTO Linea (ID, P_inicio, P_final, Pertenece)
VALUES (2, ROW(0, 2), ROW(2, 2), 4);

INSERT INTO Linea (ID, P_inicio, P_final, Pertenece)
VALUES (3, ROW(2, 2), ROW(2, 0), 4);

INSERT INTO Linea (ID, P_inicio, P_final, Pertenece)
VALUES (4, ROW(2, 0), ROW(0, 0), 4);


-- PROCEDIMIENTOS --

-- Procedimiento: Calcula_Perimetro
-- Calcula el perímetro de un polígono cuando se hace la inserción.

DROP FUNCTION IF EXISTS Longitud(Punto_type, Punto_type);

CREATE FUNCTION Longitud(P_inicio Punto_type, P_final Punto_type) RETURNS INTEGER AS $calcLong$
	BEGIN
		RETURN |/((((P_inicio).Coord_X - (P_inicio).Coord_Y) ^ 2) + (((P_final).Coord_Y - (P_final).Coord_Y) ^ 2));
	END;
$calcLong$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS Calcula_Perimetro();

CREATE FUNCTION Calcula_Perimetro() RETURNS TRIGGER AS $$
	DECLARE
        sum int;

        fila Linea%rowtype;
    BEGIN
        sum = 0;

		IF (new.Pertenece IN (SELECT ID FROM Poligono)) THEN
            FOR fila IN 
                SELECT * FROM Linea WHERE Pertenece = new.Pertenece
            LOOP
                sum = sum + Longitud((fila).P_inicio, (fila).P_final);

                RAISE NOTICE 'SUM = %', sum;
            END LOOP;

            UPDATE Poligono
            SET Perimetro = sum
            WHERE ID = new.Pertenece;

            RETURN NULL;
        END IF;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Trigger_ActualizaPerimetro 
AFTER INSERT ON Linea FOR EACH ROW EXECUTE PROCEDURE Calcula_Perimetro();


-- Operaciones para comprobar el funcionamiento de los procedimientos

INSERT INTO Linea (ID, P_inicio, P_final, Pertenece)
VALUES (5, ROW(0, 0), ROW(0, 5), 4);
