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

EI 14.

SELECT nombre
FROM EI.ALUMNO
WHERE lugar = (SELECT lugar
		FROM EI.ALUMNO
		WHERE nombre = 'Samuel Toscano Villegas')
	AND nH = (SELECT nH
		  FROM EI.ALUMNO
		  WHERE nombre = 'Beatriz Rico Vazquez');



EI 15.

SELECT nombre
FROM EI.ALUMNO
WHERE nAl IN (SELECT M.alum
		FROM EI.ASIGNATURA A INNER JOIN EI.MATRICULA M USING (idAsig)
		WHERE A.nombre = 'Bases de Datos II')
	AND nAl NOT IN (SELECT M.alum
			FROM EI.ASIGNATURA A INNER JOIN MATRICULA M USING (idAsig)
			WHERE A.nombre = 'Bases de Datos I')


EI 16. 

SELECT nombre
FROM EI.PROFESOR
WHERE despacho <> 'FC-7366' AND
	ant < ANY (SELECT anl
		   FROM EI.PROFESOR
		   WHERE despacho = 'FC-7366')



EI 17.

SELECT AL.nombre
FROM (EI.MATRICULA M INNER JOIN EI.ASIGNATURA A USING (idAsig))
			INNER JOIN EI.ALUMNO AL ON AL.nAl = alum
WHERE A.nombre = 'BDD1' and año=2002




