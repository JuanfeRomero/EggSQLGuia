# Ejercicio 4
USE nba;

# 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT Nombre FROM jugadores
ORDER BY Nombre;

# 2. Mostrar el nombre de los jugadores que sean pivots('C') y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
SELECT Nombre FROM jugadores
WHERE Posicion LIKE 'C' AND Peso > 200
ORDER BY nombre ASC;

# 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT Nombre FROM equipos
ORDER BY nombre ASC;

# 4. Mostrar el nombre de los equipos del este (East).
SELECT Nombre FROM equipos
WHERE conferencia LIKE "East";

# 5. Mostrar los equipos donde su ciudad empieza con la letra 'c', ordenados por nombre.
SELECT * FROM equipos
WHERE ciudad LIKE "C%"
ORDER BY nombre;

# 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT nombre AS "Jugador", Nombre_equipo AS "Equipo" FROM jugadores
ORDER BY nombre_equipo;

# 7. Mostrar todos los jugares del equipo "Raptors" ordenados por nombre.
SELECT * FROM jugadores
WHERE nombre_equipo LIKE "Raptors"
ORDER BY nombre;

# 8. Mostrar los puntos por partido del jugador "Pau Gasol".
SELECT Puntos_por_partido AS "Puntos por partido" FROM estadisticas
WHERE jugador = (SELECT codigo FROM jugadores WHERE nombre LIKE "Pau Gasol");

# 9. Mostrar los puntos por partido del jugador "Pau Gasol" en la temporada "04/05".
SELECT Puntos_por_partido AS "Puntos por partido" FROM estadisticas
WHERE jugador = (SELECT codigo FROM jugadores WHERE nombre LIKE "Pau Gasol") AND temporada LIKE "04/05";

# 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT jugador, ROUND(SUM(Puntos_por_partido)) AS "Puntos en carrera" FROM estadisticas
GROUP BY jugador;

# 11. Mostrar el número de jugadores de cada equipo
SELECT nombre_equipo AS Equipo, COUNT(codigo) AS "Cant. Jugadores" FROM jugadores
GROUP BY nombre_equipo;

# 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
# solo el jugador
SELECT * FROM jugadores
WHERE codigo = (SELECT jugador FROM estadisticas ORDER BY puntos_por_partido DESC LIMIT 1);

# este chequea lo mismo, pero no tiene en cuenta que puede haber mas de un jugador con esos puntos.
SELECT j.*, e.puntos_por_partido FROM jugadores j
INNER JOIN estadisticas e ON j.codigo = e.jugador
ORDER BY e.puntos_por_partido DESC LIMIT 1;

# jugador con sus puntos al final
SELECT *, (SELECT puntos_por_partido FROM estadisticas ORDER BY puntos_por_partido DESC LIMIT 1) AS Puntos FROM jugadores
WHERE codigo = (SELECT jugador FROM estadisticas ORDER BY puntos_por_partido DESC LIMIT 1);

# 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT Nombre, Conferencia, Division FROM equipos
WHERE Nombre = (SELECT nombre_equipo FROM jugadores ORDER BY altura DESC LIMIT 1);

# 14. Mostrar la media de puntos en partidos de los equipos de la division Pacific.
SELECT eq.division, AVG(puntos_por_partido) FROM estadisticas e
JOIN jugadores j ON e.jugador = j.codigo
JOIN equipos eq ON j.nombre_equipo = eq.nombre
GROUP BY eq.division
HAVING division LIKE "Pacific";

# Version de Agus Riveros MODIFICAMOS Y NOS QUEDAMOS CON ESTA
SELECT AVG(Puntos) FROM (SELECT puntos_local AS Puntos FROM partidos WHERE equipo_local IN ( SELECT Nombre from equipos WHERE Division='pacific') 
UNION SELECT puntos_visitante AS Puntos FROM partidos WHERE equipo_local IN ( SELECT Nombre from equipos WHERE Division='pacific')) t ;

# 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT equipo_local AS "Local", puntos_local AS "Puntos", equipo_visitante AS "Visitante", puntos_visitante AS "Puntos", ABS(puntos_local - puntos_visitante) AS "Diferencia" FROM partidos
WHERE ABS(puntos_local - puntos_visitante)  = (SELECT MAX(ABS(puntos_local - puntos_visitante)) FROM partidos);

# 16. Mostrar la media de puntos en partidos de los equipos de la división pacific
# ES EXACTAMENTE IGUAL QUE LA 14

# 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante
SELECT codigo, equipo_local AS "Local", puntos_local AS "Puntos", equipo_visitante AS "Visitante", puntos_visitante AS "Puntos" FROM partidos;

# 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
SELECT codigo, equipo_local, puntos_local, equipo_visitante, puntos_visitante, IF(puntos_local = puntos_visitante, NULL, IF( puntos_local > puntos_visitante, equipo_local, equipo_visitante))  AS "Equipo_ganador" FROM partidos;

SELECT count(codigo) FROM jugadores
ORDER BY Jugador, temporada;

SELECT * FROM partidos