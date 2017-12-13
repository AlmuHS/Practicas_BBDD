EI1. Obtener el código, nombre y especialidad de las asignaturas de tercero que tengan más de 4,5 créditos 

SELECT A.idAsig AS codigo, A.nombre, A.esp AS especialidad 
FROM EI.ASIGNATURA A 
WHERE A.Curso = 3 AND creditos > 4.5;


EI2. Obtener toda la información disponible de todos los profesores 

SELECT *
FROM EI.PROFESOR

EI3.Obtener los distintos tipos de ordenadores que existen en la Escuela 

SELECT DISTINCT tipo
FROM EI.ORDENADOR

EI4. Mostrar el nombre de los alumnos, el número de hermanos y el descuento que le corresponde (el descuento es de 300 € por hermano), ordenados de mayor a menor según el descuento, y en caso de igualdad, ordenados alfabéticamente por nombre 


SELECT nombre, nH * 300 AS descuento
FROM EI.ALUMNO
ORDER BY descuento DESC, nombre ASC;


EI5. Obtener el dni y nombre de los alumnos nacidos entre 1970 y 1974, y cuya localidad de nacimiento sea Huelva o Cádiz

SELECT nombre, dni
FROM EI.ALUMNO
WHERE fechaNac BETWEEN '1/1/70' AND '21/12/74'
	AND lugar IN ('Huelva', 'Cadiz');



EI6. Obtener el nombre de todos los alumnos cuyo nombre empiece por la letra M y hayan nacido en una ciudad cuyo nombre tenga, al menos, 6 caracteres pero no comience por la letra P

SELECT nombre
FROM EI.ALUMNO
WHERE nombre LIKE 'M%' AND lugar LIKE '_ _ _ _ _ _%'
	AND lugar NOT LIKE 'P%'


EI7. Obtener un listado de los años de nacimiento de los alumnos, ordenados crecientemente



