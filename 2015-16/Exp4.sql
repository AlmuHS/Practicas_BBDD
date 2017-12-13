EI 18. Listado de los despachos donde hay profesores que no son responsables de ninguna asignatura 

SELECT DISTINCT P.despacho
FROM EI.PROFESOR P
WHERE NOT EXISTS (SELECT *
		  FROM EI.ASIGNATURA A
		  WHERE P.nPr = A.prof)

EI 19. Listado de los alumnos que se han matriculado de alguna asignatura en el año 2000 o 2002, y de ninguna asignatura en el año 2001

SELECT A.nombre
FROM EI.ALUMNO A
WHERE EXISTS (SELECT *
	      FROM E.MATRICULA M
	      WHERE (año = 2000 OR año = 2002) AND A.nAl = M.alum)

AND NOT EXISTS (SELECT *
		FROM EI.MATRICULA M
		WHERE año =2001 AND A.nAl = M.alum)


EI 20. Obtener el nombre de los profesores y los números de sus despachos de aquellos profesores que no comparten despacho

SELECT nombre, despacho
FROM EI.PROFESOR P1
WHERE despacho NOT IN (SELECT despacho
			FROM EI.PROFESOR P2
			WHERE P2.nPr <> P1.nPr)


SELECT nombre, despacho
FROM EI.PROFESOR P1
WHERE NOT EXISTS (SELECT *
		  FROM EI.PROFESOR P2
		  WHERE P2.despacho = P1.despacho AND P2.nPr <> P1.nPr)


EI 21. Obtener los nombres de todos los profesores junto con las asignaturas de las que son responsables

SELECT P.nombre, A.nombre
FROM EI.PROFESOR LEFT OUTER JOIN EI.ASIGNATURA A ON P.nPr = A.prof


EI 22. Se desea saber cuántos despachos ocupan los profesores de la escuela 

SELECT COUNT(DISTINCT despacho)
FROM EI.PROFESOR

EI 23.  Obtener el número de matriculados, la nota máxima, la mínima y la nota media de la asignatura ‘Bases de Datos I’ en la convocatoria de septiembre de 2002

SELECT COUNT(*), MAX(sep) AS maxima, MIN(sep) AS minima, AVG(sep) AS media
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING(idAsig)
WHERE A.nombre = 'Bases de Datos I' AND M.año = 2002

EI 24. Obtener, mediante una consulta correlacionada, los nombres de las asignaturas que tienen recomendadas 2 o más asignaturas.

SELECT A.nombre
FROM EI.ASIGNATURA A
WHERE (SELECT COUNT(*)
	FROM EI.RECOMENDACIONES R
	WHERE A.idAsig = R.idAsig1) >=2



EI 25. Obtener, mediante una consulta correlacionada, los nombres de los profesores que tienen más antigüedad que, al menos, otros cinco profesores 

SELECT P1.nombre
FROM EI.PROFESOR P1
WHERE (SELECT COUNT(*)
	FROM EI.PROFESOR P2
	WHERE P1.ant < P2.ant) >=5


EI 26. Para cada asignatura y año académico, mostrar el nombre de la asignatura, el año, el número de alumnos que se han presentado y la nota media obtenida en la convocatoria de febrero_junio

SELECT A.nombre, M.año, COUNT(feb_jun) AS Presentados, AVG(feb_jun) AS Media
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (idAsig)
GROUP BY A.nombre, M.año


EI 27. Obtener un listado con el nombre del alumno, el nombre de la asignatura y el número de veces que se ha matriculado en esa asignatura, pero sólo cuando se haya matriculado 3 o más años

SELECT A.nombre, ASIG.nombre, COUNT(*)
FROM (EI.ALUMNO A INNER JOIN EI.MATRICULA M ON A.nAl = M.alum INNER JOIN EI.ASIGNATURA
GROUP BY A.nombre, ASIG.nombre
HAVING COUNT(*) > 3

EI 28. Nombre de los alumnos que hayan sacado más de un 5 de nota media en junio del 2002

SELECT A.nombre
FROM EI.ALUMNO A INNER JOIN EI.MATRICULA ON A.nAl=M.alum
GROUP BY A.nombre
HAVING AVG(feb_jun) > 5


EI 29. Nombre de las asignaturas y número de alumnos matriculados de las asignaturas donde se hayan matriculado más alumnos en el año 2002

SELECT A.nombre, COUNT(*)
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING(idAsig)
WHERE año=2002
GROUP BY A.nombre
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
			FROM EI.MATRICULA
			WHERE año=2002
			GROUP BY idAsig) 


EI 30. Obtener el número total de alumnos que han suspendido en cada asignatura en junio de 2002, pero sólo de aquellas asignaturas en las que se hayan matriculado más de 50 alumnos 

SELECT A.nombre, COUNT(*)
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING(idAsig)
WHERE M.año = 2002 AND M.feb_jun < 5 AND idAsig IN (SELECT M.idAsig
						    FROM MATRICULA M
						    GROUP BY idAsig 
						    HAVING COUNT(*) > 50)
