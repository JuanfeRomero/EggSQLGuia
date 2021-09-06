# Ejercicio 3
USE tienda;
SELECT * FROM fabricante;
SELECT * FROM producto;

# 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT Nombre FROM producto;

# 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT Nombre, Precio FROM producto;

# 3. Lista todas la columnas de la tabla producto.
# asumo que quiere lo primero, pero ya que está busque como se hace para conseguir el nombre de las columnas
SELECT * FROM PRODUCTO;
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'tienda' AND TABLE_NAME = 'producto';

# 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio;
SELECT Nombre, ROUND(Precio) as "Precio redondeado" FROM producto;

# 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo AS "Fabricantes con productos" FROM fabricante
HAVING codigo IN (SELECT codigo_fabricante FROM producto);
# forma mas facil
SELECT codigo_fabricante FROM producto;

# no salte de la nada al 10, así está mal escrito en la guia
# 10.  Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT DISTINCT codigo_fabricante FROM producto;

# 11. Lista los nombres de los fabricantes ordenados de forma ascendente
SELECT Nombre FROM fabricante
ORDER BY Nombre ASC;

# 12. Lista  los  nombres  de  los  productos  ordenados  en  primer  lugar  por  el  nombre  de forma ascendente y en segundo lugar por el precio de forma descendente. 
SELECT Nombre, precio FROM producto
ORDER BY Nombre ASC, Precio DESC;

# 13. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante
LIMIT 5;

# 14. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT Nombre, Precio FROM producto
ORDER BY Precio ASC LIMIT 1;

# 15. Lista el nombre y el precio del producto más caro. (Utilice solamente la cláusulas ORDER BY y LIMIT)
SELECT Nombre, Precio FROM producto
ORDER BY Precio DESC LIMIT 1;

# 16. Lista el nombre de los productos que tienen un precio menor o igual a $120
SELECT Nombre, Precio FROM producto
WHERE Precio  <= 120;

# 17. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN
SELECT * FROM producto
WHERE precio BETWEEN 60 AND 200;

# 18. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utlizando el operador IN.
SELECT * FROM producto
WHERE codigo_fabricante IN (1, 3, 5);

# Otra vez salta solo.
# 23. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT Nombre FROM producto
WHERE Nombre LIKE "%portatil%";

# Consultas Multitabla
# 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante de todos los productos de la base de datos.
SELECT p.codigo AS "Codigo", p.nombre AS "Nombre", f.codigo AS "Codigo Fabricante", f.nombre AS "Fabricante" FROM producto p
JOIN fabricante f
ON p.codigo_fabricante = f.codigo;

# 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre AS "Producto", p.precio AS Precio, f.nombre AS "Fabricante" FROM producto p
JOIN fabricante f
ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;

# 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre AS "Producto", p.precio AS "Precio", f.nombre as "Fabricante" FROM producto p
JOIN fabricante F ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC LIMIT 1;

# 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.*, f.nombre AS "Fabricante" FROM producto p
JOIN fabricante F ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Lenovo";

# 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT p.*, f.nombre AS "Fabricante" FROM producto p
JOIN fabricante F ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Crucial" and p.precio > 200;

# 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT p.*, f.nombre AS "Fabricante" FROM producto p
JOIN fabricante F ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN("Asus", "Hewlett-Packard");

# 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. 
# Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre "Producto", p.precio AS "Precio", f.nombre AS "Fabricante" FROM producto p
JOIN fabricante F ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

# Consultas Multitabla
# Resuelva todas la consultas utilizando las clausulas LEFT JOIN y RIGHT JOIN.
# 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos.
# El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT f.nombre, p.nombre FROM fabricante f
LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante;

# 2. Devuelve un listado donde solo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT f.nombre FROM fabricante f
LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE p.codigo_fabricante IS NULL;

# Subconsultas (En la clausula WHERE)
# Con operadores básicos de comparación.
# 1. Devuelve todos los productos del fabricante LENOVO (SIN INNER JOIN)
SELECT * FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "Lenovo");

# 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo (SIN INNER JOIN)
# Version con una subconsulta
SELECT * FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "Lenovo")
ORDER BY precio DESC LIMIT 1;

# Version con 2 subconsultas
SELECT * FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "Lenovo"));

# Version sin subconsulta con JOIN
SELECT p.* FROM producto p 
JOIN fabricante f
ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE "Lenovo"
ORDER BY precio DESC LIMIT 1;

# 3. Lista el nombre del producto más caro del fabricante Lenovo.
# Version sin MAX
SELECT nombre FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "Lenovo")
ORDER BY precio DESC LIMIT 1;

# Version con MAX
SELECT nombre FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE "Lenovo"));

# 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos
SELECT * FROM producto
WHERE precio > 
	(SELECT AVG(precio) FROM producto 
    WHERE codigo_fabricante = 
		(SELECT codigo FROM fabricante 
        WHERE nombre LIKE "Asus")
	);

SELECT * FROM producto
WHERE precio > (SELECT AVG(precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "Asus");

# Subconsultas con IN y NOT IN
# 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante
WHERE codigo IN (SELECT codigo_fabricante FROM producto);

# 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante
WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);

# Subconsultas (En la cláusula HAVING)
# 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo
SELECT f.nombre FROM fabricante f
JOIN producto p
ON f.codigo = p.codigo_fabricante
GROUP BY codigo_fabricante
HAVING COUNT(codigo_fabricante) = 
	(SELECT COUNT(codigo_fabricante) FROM producto WHERE codigo_fabricante = 
		(SELECT codigo FROM fabricante WHERE nombre LIKE "Lenovo")
	)
;


SELECT * FROM fabricante;
SELECT * FROM producto;