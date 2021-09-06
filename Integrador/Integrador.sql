# Examen Integrador
USE nba;
# CANDADO A
# Posicion A: Muestre cuantas veces los jugadores lograron tener la misma cantidad de asistencias por partido, que el máximo de asistencias por partido.
SELECT COUNT(asistencias_por_partido) FROM estadisticas
WHERE asistencias_por_partido = (SELECT MAX(asistencias_por_partido) FROM estadisticas); 
# 2

# Clave A: Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posicion sea centro o esté comprendida en otras posiciones.
SELECT SUM(Peso) FROM jugadores j
JOIN equipos e ON j.Nombre_equipo  = e.Nombre
WHERE e.conferencia LIKE "East" AND j.posicion LIKE "%C%";
# 14043

# CANDADO B
# Posicion B: Muestre la cantidad de jugadores que poseen mas asistencias por partidos, que el numero de jugadores que tiene el equipo Heat
SELECT COUNT(codigo) FROM jugadores j
JOIN estadisticas e ON j.codigo = e.jugador
WHERE e.asistencias_por_partido > (SELECT COUNT(codigo) FROM jugadores WHERE nombre_equipo LIKE "Heat");

# 3

# Clave B: La clave será igual al conteo de partidos jugados durante las temporadas del año 1999
SELECT COUNT(codigo) FROM partidos
WHERE temporada LIKE "%99%";
# 3480

# CANDADO C
# Posicion C: La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman parte de equipos de la conferencia oeste.
# Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a 195, y a eso le vamos a sumar 0.9945;
SELECT 
	(SELECT COUNT(codigo) FROM jugadores j
	JOIN equipos e ON j.Nombre_equipo = e.Nombre
	WHERE procedencia LIKE "Michigan" AND e.conferencia LIKE "West")
/ 
	(SELECT COUNT(codigo) FROM jugadores
	WHERE peso >= 195) + 0.9945;
# 1

# Clave C: Para obtener el siguiente codigo deberas redondear hacia abajo el resultado que se devuelve de sumar: 
# el promedio de puntos por partido, el conteo de asistencias por partido y la suma de tapones por partido. 
# Ademas este resultado debe ser, donde la division central.
SELECT FLOOR(AVG(puntos_por_partido)+ COUNT(Asistencias_por_partido) + SUM(tapones_por_partido)) FROM estadisticas e
JOIN jugadores j ON e.jugador = j.codigo
JOIN equipos eq ON j.nombre_equipo = eq.nombre
WHERE eq.division LIKE "Central";
# 631

# CANDADO D
# Posicion D: Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01.
# Este resultado debe ser redondeado. 
SELECT ROUND(tapones_por_partido) FROM estadisticas
WHERE jugador = (SELECT codigo FROM jugadores WHERE nombre LIKE "Corey Maggette") AND temporada LIKE "00/01";
# 4

# Clave D: redondear hacia abajo la suma de puntos por partido de todos los jugadores de procendencia argentina.
SELECT FLOOR(SUM(puntos_por_partido)) FROM estadisticas e
JOIN jugadores j ON e.jugador = j.codigo
WHERE j.procedencia LIKE "Argentina";
# 191


# 1:C 631 #2:A 14043 #3:B 3480 #4:D 191

SELECT * FROM equipos;
SELECT * FROM estadisticas ORDER BY Asistencias_por_partido DESC;
SELECT * FROM jugadores;
SELECT * FROM partidos;