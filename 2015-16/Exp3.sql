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




