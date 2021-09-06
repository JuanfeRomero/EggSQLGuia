# Creación de base de datos
CREATE DATABASE superheroes;

# Uso de base de datos
USE superheroes;

# Creación de tabla
CREATE TABLE creador (
	id_creador INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_creador)
);

# Creación de tabla
CREATE TABLE personajes (
	id_personaje INT NOT NULL,
    nombre_real VARCHAR(20) NOT NULL,
    personaje VARCHAR(20) NOT NULL,
    inteligencia INT NOT NULL,
    fuerza VARCHAR(10) NOT NULL,
    velocidad INT NOT NULL,
    poder INT NOT NULL,
    aparicion INT NOT NULL,
    ocupacion VARCHAR(30),
    id_creador INT NOT NULL,
    PRIMARY KEY (id_personaje),
    FOREIGN KEY (id_creador) REFERENCES creador (id_creador)
);

# Inserción de valores a la tabla
INSERT INTO creador VALUES (1, 'Marvel');
INSERT INTO creador VALUES (2, 'DC Comics');

# Inserción de valores a la tabla
INSERT INTO personajes VALUES (1, 'Bruce Banner', 'Hulk', 160, '600 mil', 75, 98, 1962, 'Físico Nuclear', 1);
INSERT INTO personajes VALUES (2, 'Tony Stark', 'Iron Man', 170, '200 mil', 70, 123, 1963, 'Inventor Industrial', 1);
INSERT INTO personajes VALUES (3, 'Thor Odinson', 'Thor', 145, 'infinita', 100, 235, 1962, 'Rey Asgard', 1);
INSERT INTO personajes VALUES (4, 'Wanda Maximoff', 'Bruja Escarlata', 170, '100 mil', 90, 345, 1964, 'Bruja', 1);
INSERT INTO personajes VALUES (5, 'Carol Danvers', 'Capitana Marvel', 157, '250 mil', 85, 128, 1968, 'Oficial de inteligencia', 1);
INSERT INTO personajes VALUES (6, 'Thanos', 'Thanos', 170, 'infinita', 40, 306, 1973, 'Adorador de la muerte', 1);
INSERT INTO personajes VALUES (7, 'Peter Parker', 'Spiderman', 165, '25 mil', 80, 74, 1962, 'Fotógrafo', 1);
INSERT INTO personajes VALUES (8, 'Steve Rogers', 'Capitán América', 145, '600', 45, 60, 1941, 'Oficial Federal', 1);
INSERT INTO personajes VALUES (9, 'Bobby Drake', 'Ice Man', 140, '2 mil', 64, 122, 1963, 'Contador', 1);
INSERT INTO personajes VALUES (10, 'Barry Allen', 'Flash', 160, '10 mil', 120, 168, 1956, 'Científico forense', 2);
INSERT INTO personajes VALUES (11, 'Bruce Wayne', 'Batman', 170, '500', 32, 47, 1939, 'Hombre de negocios', 2);
INSERT INTO personajes VALUES (12, 'Clarck Kent', 'Superman', 165, 'infinita', 120, 182, 1948, 'Reportero', 2);
INSERT INTO personajes VALUES (13, 'Diana Prince', 'Mujer Maravilla', 160, 'infinita', 95, 127, 1949, 'Princesa guerrera', 2);
INSERT INTO personajes VALUES (14, 'Wally West', 'Flash', 160, '10 mil', 120, 168, 1956, 'Científico forense', 2);
INSERT INTO personajes VALUES (15, 'Jay Garrick', 'Flash', 160, '10 mil', 120, 168, 1956, 'Científico forense', 2);

# Consultas a la tabla
SELECT * FROM creador;
SELECT * FROM personajes;

# Modificación de registro
UPDATE personajes     # Que tabla estamos cambiando
SET aparicion = 1938  # Que columna le queremos cambiar por que dato nuevo
WHERE id_personaje = 12; # Que criterio vamos a usar para saber que cambiar
    
# Eliminación de registro
DELETE
FROM personajes
WHERE id_personaje = 10;

# Eliminación de tablas y de base de datos
DROP TABLE personajes;
DROP TABLE creador;
DROP DATABASE superheroes;