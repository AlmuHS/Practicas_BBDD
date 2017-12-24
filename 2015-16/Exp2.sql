/*
 * Copyright (C) 2015 Almudena García Jurado-Centurión
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

EI 8. Obtener los nombres de las asignaturas junto al nombre del profesor responsable

	SELECT A.nombre as NomAsig P.nombre as NomProf
	FROM EI.ASIGNATURA A INNER JOIN EI.PROFESOR P ON A.prof = P.nPr;

EI 9. Obtener los numeros de los alumnos que se han matriculado en BDD1 en el curso 2002-03

	SELECT alum
	FROM EI.MATRICULA M INNER JOIN EI.ASIGNATURA A USING(idAsig)
	WHERE A.nombre = 'Bases de Datos I' AND año = 2002;

EI 10. Obtener los nombres de los alumnos que han aprobado la asignatura Algoritmos y Estructuras de Datos I en la convocatoria de febrero_junio de 2001

	SELECT A.nombre
	FROM (EI.ASIGNATURA ASIG INNER JOIN EI.MATRICULA M USING(idAsig))
		INNER JOIN EI.ALUMNO A ON M.alum = A.nal
	WHERE ASIG.nombre = 'Algoritmos y Estructuras de Datos I'
		AND año = 2001 AND feb_jun >= 5;  

EI 11. Obtener un listado con el numero de despacho, pero solo de aquellos donde haya al menos 2 profesores

	SELECT DISTINCT despacho
	FROM EI.PROFESOR P1 INNER JOIN EI.PROFESOR P2 USING(despacho)
	WHERE P1.nombre <> P2.nombre;



EI 12. Obtener una lista con todas las asignaturas de las que es responsable o docente la profesora Dolores Toscano Barriga


(SELECT A.nombre
FROM EI.ASIGNATURA A INNER JOIN EI.PROFESOR P ON P.nPr = A.prof
WHERE P.nombre = 'Dolores Toscano Barriga')

UNION

(SELECT A.nombre
FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (idAsig)
	INNER JOIN EI.PROFESOR A ON M.prof = P.nPr
WHERE P.nombre = 'Dolores Toscano Barriga');


EI 13. Obtener los nombres de los alumnos que no se han presentado a BBDDI en diciembre de 2002 por haberla aprobado en una convocatoria anterior del mismo año


SELECT A.nombre
FROM EI.ALUMNO A INNER JOIN MATRICULA M ON A.nAl = M.alum
	INNER JOIN ASIGNATURA USING(idAsig)





