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
SELECT COUNT(codigo) FROM jugadores j
JOIN equipos e ON j.Nombre_equipo = e.Nombre
WHERE procedencia LIKE "%Michigan%" AND e.conferencia LIKE "West";

# Clave C: Para obtener el siguiente codigo deberas redondear hacia abajo el resultado que se devuelve de sumar: 
# el promedio de puntos por partido, el conteo de asistencias por partido y la suma de tapones por partido. 
# Ademas este resultado debe ser, donde la division central.


SELECT * FROM equipos;
SELECT * FROM estadisticas ORDER BY Asistencias_por_partido DESC;
SELECT * FROM jugadores;
SELECT * FROM partidos;