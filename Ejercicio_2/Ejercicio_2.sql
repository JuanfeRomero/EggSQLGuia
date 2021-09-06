# Realizar las siguientes consultas sobre la base de datos personal: 
USE personal;

# 1. Obtener los datos completos de los empleados.
SELECT * FROM empleados;

# 2. Obtener los datos completos de los departamentos.
SELECT * FROM departamentos;

# 3. Listar el nombre de los departamentos. 
SELECT DISTINCT nombre_depto AS Departamentos FROM departamentos;

# 4. Obtener el nombre y salario de todos los empleados. 
SELECT Nombre, sal_emp AS Salario FROM empleados;

# 5. Listar todas las comisiones.
SELECT comision_emp AS Comisiones FROM empleados;

# 6. Obtener los datos de los empleados cuyo cargo sea 'Secretaria'.
SELECT * FROM empleados
WHERE cargo_emp = 'Secretaria';

# 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente
SELECT * FROM empleados
WHERE cargo_emp = 'Vendedor'
ORDER BY nombre ASC;

# 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT Nombre, cargo_emp AS Cargo, sal_emp as Salario FROM empleados
ORDER BY sal_emp ASC;

# 9. Elabore un listado donde para cada fila, figure el alias 'Nombre' y 'Cargo' para las respectivas tablas de empleados.
SELECT id_emp AS ID, Nombre, cargo_emp AS Cargo FROM empleados;

# 10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT sal_emp AS Salario, comision_emp AS Comision FROM empleados
WHERE id_depto = 2000
ORDER BY comision_emp ASC;

# 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado
SELECT *, sal_emp + comision_emp + 500 AS 'Valor Total' FROM empleados
WHERE id_depto = 3000
ORDER BY nombre ASC;

# 12. Muestra los empleados cuyo nombre empiece con la letra J
SELECT * FROM empleados
WHERE nombre LIKE 'J%';

# 13. Listar el salario, la comisión, el salario total (salario + comision) y nombre, de aquellos empleados que tienen comisión superior a 1000.
SELECT sal_emp AS Salario, comision_emp AS Comision, sal_emp + comision_emp AS 'Salario Total', Nombre FROM empleados
WHERE comision_emp > 1000;

# 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT sal_emp AS Salario, comision_emp AS Comision, sal_emp + comision_emp AS 'Salario Total', Nombre FROM empleados
WHERE comision_emp = 0;

# 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT Nombre, sal_emp AS Salario, comision_emp AS Comision, sal_emp + comision_emp AS 'Salario Total' FROM empleados
WHERE comision_emp > sal_emp;

# 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT Nombre, sal_emp AS Salario, comision_emp AS Comision, sal_emp * 0.3 AS '30% del sueldo' FROM empleados
WHERE comision_emp <= sal_emp*0.3;

# 17. Hallar los empleados cuyo nombre no contiene la cadena MA.
SELECT * FROM empleados
WHERE nombre NOT LIKE '%MA%';

# 18. Obtener los nombres de los departamentos que sean "Ventas", "Investigación" y "Mantenimiento".
SELECT * FROM departamentos
WHERE nombre_depto LIKE "Ventas" OR nombre_depto LIKE "Investigación" OR nombre_depto LIKE "Mantenimiento";

# 19. Ahora obtener los nombres de los departamentos que no sean "Ventas" ni "Investigación" ni "Mantenimiento".
SELECT * FROM departamentos
WHERE nombre_depto NOT LIKE "Ventas" AND nombre_depto NOT LIKE "Investigación" AND nombre_depto NOT LIKE "Mantenimiento";

# 20. Mostrar el salario más alto de la empresa.
SELECT * FROM Empleados
WHERE sal_emp = (SELECT MAX(sal_emp) from empleados);

# 21. Mostrar el nombre del último empleado de la lista por orden alfabetico
SELECT * FROM empleados
ORDER BY nombre DESC
LIMIT 1;

# 22. Hallar el salario más alto, el más bajo y la diferencia entre ellos
SELECT MAX(sal_emp) AS "Salario Mas Alto", MIN(sal_emp) AS "Salario Mas Bajo", MAX(sal_emp)-MIN(sal_emp) AS Diferencia FROM Empleados;

# 23. Hallar el salario promedio por departamento
SELECT d.nombre_depto AS Departamento, AVG(e.sal_emp) AS "Salario Promedio" FROM empleados e
JOIN departamentos d
ON e.id_depto = d.id_depto
GROUP BY d.nombre_depto;

# 24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT * FROM departamentos;
SELECT COUNT(e.id_emp) AS "Cantidad Empleados", d.nombre_depto AS "Departamento" FROM empleados e
JOIN departamentos d
ON e.id_depto = d.id_depto
GROUP BY d.nombre_depto
HAVING COUNT(e.id_emp) > 3;
/* VERSION USANDO HAVING SIN JOIN, SEPARANDO POR CODIGO DE DEPARTAMENTO Y NO POR NOMBRE*/
SELECT COUNT(id_emp) AS "Cantidad Empleados", id_depto AS "Codigo Departamento" FROM empleados
GROUP BY id_depto
HAVING COUNT(id_emp) > 3;

# 25. Mostrar el código y nombre de cada Jefe, junto al número de empleados que dirige. Solo los que tengan más de dos empleados (2 incluido)
SELECT * FROM EMPLEADOS;
SELECT * FROM DEPARTAMENTOS;

SELECT Substring(cod_jefe, -3) AS "Codigo Jefe", COUNT(Substring(cod_jefe, -3)) AS "Empleados a Cargo" from empleados
Group by Substring(cod_jefe, -3);

# 26. Hallar los departamentos que no tienen empleados
# Agregue un area nueva para verificar que este correcto
# INSERT INTO `departamentos` VALUES (4400, 'AREA NUEVA', 'LUNA', '38.700.144');
SELECT d.id_depto, nombre_depto FROM Departamentos d
LEFT JOIN Empleados e
ON d.id_depto = e.id_depto
GROUP BY e.id_depto
HAVING d.id_depto NOT IN (SELECT id_depto FROM empleados);

# DELETE FROM departamentos WHERE id_depto = 4400;

# 27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
/* por alguna razon hice esto, agarra la media de salario por departamento, ni idea era re tarde.
SELECT e.id_depto as "ID DEPARTAMENTO", d.nombre_depto as "Nombre", AVG(sal_emp) AS "Promedio de salario" FROM empleados e
JOIN Departamentos d
ON e.id_depto = d.id_depto
GROUP BY e.id_depto
ORDER BY e.id_depto;
*/

SELECT id_emp, nombre, sal_emp salario FROM empleados
WHERE sal_emp > (SELECT AVG(sal_emp) FROM empleados)
GROUP BY id_depto;

SELECT * FROM empleados;
SELECT * FROM departamentos;

# DROPEO LA TABLA POR LAS DUDAS
DROP TABLE empleados;
DROP TABLE departamentos;
DROP DATABASE personal;