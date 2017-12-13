WRC1. Muestra todos los datos de los rallies que se celebren antes del 1 de octubre de 2009, en un país que tenga más de 6 caracteres de longitud

SELECT *
FROM WRC.RALLY
WHERE fecha < TO_DATE('1/10/2009', 'dd/mm/yyyy')
	and pais LIKE '_______%';


WRC2. Muestra el nombre de todos los pilotos y sus copilotos, ordenados alfabéticamente por el nombre de piloto, pero sólo de aquellos pilotos cuyo nombre no comience por M

SELECT nombreP, nombreCop
FROM WRC.PILOTO
WHERE nombreP NOT LIKE 'M%'
ORDER BY nombreP ASC;


WRC3. Muestra el nombre de los pilotos y su grupo sanguíneo, pero sólo de aquellos cuyo nombre empiece por M y su grupo sanguíneo tenga 2 caracteres

SELECT nombreP, grupoS
FROM WRC.PILOTO
WHERE nombreP LIKE 'M%' and grupoS LIKE '__';


WRC4. Muestra los nombres y fechas de celebración de los rallies que se corran en la segunda mitad del mes de Agosto

SELECT nombre, fecha
FROM WRC.RALLY
WHERE EXTRACT(day FROM fecha) > 15 AND EXTRACT(month FROM fecha) = 8;