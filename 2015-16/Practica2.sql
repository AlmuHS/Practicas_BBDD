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

﻿WRC 1. Muestra todos los datos de los rallies que se celebren antes del 1 de octubre de 2009, en un país que tenga más de 6 caracteres de longitud

SELECT *
FROM WRC.RALLY
WHERE fecha < TO_DATE('1/10/2009', 'dd/mm/yyyy')
	and pais LIKE '_______%';


WRC 2. Muestra el nombre de todos los pilotos y sus copilotos, ordenados alfabéticamente por el nombre de piloto, pero sólo de aquellos pilotos cuyo nombre no comience por M

SELECT nombreP, nombreCop
FROM WRC.PILOTO
WHERE nombreP NOT LIKE 'M%'
ORDER BY nombreP ASC;


WRC 3. Muestra el nombre de los pilotos y su grupo sanguíneo, pero sólo de aquellos cuyo nombre empiece por M y su grupo sanguíneo tenga 2 caracteres

SELECT nombreP, grupoS
FROM WRC.PILOTO
WHERE nombreP LIKE 'M%' and grupoS LIKE '__';


WRC 4. Muestra los nombres y fechas de celebración de los rallies que se corran en la segunda mitad del mes de Agosto

SELECT nombre, fecha
FROM WRC.RALLY
WHERE EXTRACT(day FROM fecha) > 15 AND EXTRACT(month FROM fecha) = 8;

WRC 5. Muestra los numeros de tramo con dificultad B del Rally de Montecarlo

SELECT numeroTramo
FROM WRC.TRAMO T INNER JOIN WRC.RALLY R
WHERE T.dificultad = 'B' AND nombre ='Rally de Montecarlo';

WRC 6. Muestra el nombre de los pilotos con RH negativo junto con la marca y modelo de su coche, siempre que la cilindrada de este supere los 2500cc

SELECT P.nombreP, P.rh, C.marca, C.modelo
FROM WRC.PILOTO P INNER JOIN WRC.COCHE C ON P.coche = C.codCoche
WHERE rh = '-' AND cilindrada > 2500;


WRC 7. Muestra el nombre de todos los copilotos que participan en el Rally de Cataluña y que sufran una penalizacion de mas de 10 segundos

SELECT nombreCop
FROM WRC.PARTICIPA P INNER JOIN WRC.RALLY R ON P.codRally = R.codRally 
	INNER JOIN WRC.PILOTO PI ON PI.codPiloto = P.codPiloto 
WHERE R.nombre = 'Rally de Cataluña' AND P.penalizacion > 10;
	

WRC 8. Muestra un listado con el nombre de los pilotos, el nombre de los rallies en que han participado y la fecha de los mismos, pero solo de aquellos rallies en que el piloto haya tenido una penalizacion < 20s y se celebrasen en Agosto o Noviembre

SELECT P.nombreP, R.nombre, R.fecha
FROM WRC.PARTICIPA P INNER JOIN WRC.RALLY R ON P.codRally = R.codRally
	INNER JOIN WRC.PILOTO PI ON PI.codPiloto = P.codPiloto
WHERE P.penalizacion < 20 AND EXTRACT(month FROM R.fecha) = 8 OR EXTRACT(month FROM R.fecha) = 11;  


WRC 9. Muesta el nombre y fecha de celebracion de aquellos rallies en los que haya participado algun piloto de la marca Citroen

SELECT DISTINCT R.nombre, R.fecha
FROM WRC.RALLY R INNER JOIN WRC.PARTICIPA P ON P.codRally = R.codRally
	INNER JOIN WRC.PILOTO PI ON P.codPiloto = PI.codPiloto
	INNER JOIN WRC.COCHE C ON PI.coche = C.codCoche
WHERE C.marca = 'Citroen'


WRC 10. Muestra el nombre de los rallies en los que haya corrido algun vehiculo en que los copilotos no fuesen ni Marc Martí ni Timo Rautiainen

SELECT nombre
FROM RALLY R INNER JOIN PARTICIPA P USING (codRally)
WHERE P.codPiloto NOT IN (SELECT P.codPiloto
			FROM PILOTO P
			WHERE nombreCop LIKE 'Marc%' OR nombreCop LIKE 'Timo%')


WRC 11. Muestra el nombre de los pilotos que hayan participado en el Rally de Cataluña pilotando un Subaru
y tenga penalizacion < 10

SELECT nombreP
FROM PILOTO
WHERE coche IN (SELECT codCoche
		   FROM COCHE 
		   WHERE marca = 'Subaru')
	  AND codPiloto IN (SELECT codPiloto
			    FROM PARTICIPA P INNER JOIN RALLY R ON (R.codRally = P.codRally)
			    WHERE nombre = 'Rally de Cataluña' AND penalizacion < 10)

WRC 12. Muestra el nombre de los rallies en que corra algun piloto con grupo sanguineo A y rh+

SELECT DISTINCT R.nombre
FROM RALLY R INNER JOIN PARTICIPA P USING(codRally)
WHERE P.codPiloto IN (SELECT codPiloto
			FROM PILOTO
			WHERE rH = '+' AND grupoS = 'A')


WRC 13. Muestra el nombre de los pilotos que hayan participado en alguno de los rallies que tengan
algunos de sus tramos etiquetado como de dificultad C

SELECT P.nombreP
FROM PILOTO P INNER JOIN PARTICIPA PA USING(codPiloto)
WHERE PA.codRally IN (SELECT codRally
			FROM TRAMO T
			WHERE T.dificultad = 'C')

WRC 14. Usando subconsultas, devuelve el nombre de los pilotos que tengan más puntos que todos los
pilotos que corren con un Subaru.

SELECT PI.nombreP
FROM PILOTO PI
WHERE puntos > (SELECT puntos
		FROM PILOTO P INNER JOIN COCHE C ON (P.coche = C.codCoche)
		WHERE C.marca = 'Subaru')


WRC 15. Usando subconsultas, devuelve el modelo de coche, el nombre rally y el nombre del piloto para
aquellos pilotos que hayan participado en un rally que tenga algún tramo de menos de 30 kms
 
SELECT DISTINCT C.modelo, R.nombre, P.nombreP
FROM PILOTO P INNER JOIN COCHE C ON(P.coche = C.codCoche) INNER JOIN CORRE COR USING(codPiloto) INNER JOIN RALLY R USING(codRally)
WHERE R.codRally IN(SELECT codRally
			FROM TRAMO T
			WHERE T.totalKms < 30)


WRC 16. Utilizando consultas correlacionadas, muestra el nombre de los pilotos que no han corrido el rally de Cataluña

SELECT P.nombreP
FROM WRC.PILOTO P
WHERE NOT EXISTS (SELECT *
                  FROM WRC.RALLY R INNER JOIN WRC.CORRE C USING(codRally)
                  WHERE R.nombre LIKE '%Cataluña' AND C.codPiloto=P.codPiloto)

WRC 17. Muestra el nombre de los pilotos que tengan mas puntos que algun otro piloto que conduzca un coche con igual o menor cilindrada

SELECT P.nombreP
FROM PILOTO P INNER JOIN COCHE CO ON (P.coche = CO.codCoche)
WHERE EXISTS (SELECT *
	FROM PILOTO PI INNER JOIN COCHE C ON (P.coche = C.codCoche)
	WHERE P.puntos > PI.puntos AND C.cilindrada <= CO.cilindrada)
	

WRC 18. Muestra el nombre de los pilotos que hayan corrido el Rally de Cataluña pero no el de Gran Bretaña

SELECT P.nombreP
FROM PILOTO P
WHERE EXISTS (SELECT *
		FROM PILOTO PI INNER JOIN PARTICIPA PA USING(codPiloto) INNER JOIN RALLY R USING(codRally)
		WHERE PA.codPiloto = P.codPiloto AND R.nombre = 'Rally de Cataluña')

AND NOT EXISTS (SELECT *
		FROM PILOTO PI INNER JOIN PARTICIPA PA USING(codPiloto) INNER JOIN RALLY R USING(codRally)
		WHERE PA.codPiloto = P.codPiloto AND R.nombre LIKE '%Gran Bretaña')


WRC 19. Muestra el nombre de los pilotos que hayan corrido algún tramo de dificultad A, pero no hayan conseguido finalizar algún tramo de menos de 30 kms

SELECT P.nombreP
FROM WRC.PILOTO P
WHERE EXISTS (SELECT *
            FROM WRC.CORRE C  INNER JOIN WRC.TRAMO T USING(codRally, numeroTramo)
            WHERE T.dificultad = 'A' AND C.codPiloto = P.codPiloto)
            
      AND NOT EXISTS (SELECT *
                      FROM WRC.CORRE CO INNER JOIN WRC.TRAMO TR USING(codRally, numeroTramo)
                      WHERE TR.totalKms < 30 AND CO.codPiloto = P.codPiloto)
                      
WRC 20. Muestra la marca y el modelo de los coches que tienen una cilindrada mayor que, al menos, otros dos coches                       

SELECT C.marca, C.modelo
FROM WRC.COCHE C
WHERE (SELECT COUNT(*)
		FROM WRC.COCHE CO
		WHERE C.cilindrada > CO.cilindrada) >= 2


WRC 22. Muestra el nombre de los rallies junto con el número de tramos de cada uno de ellos

SELECT R.nombre, COUNT(*) AS NumeroTramos
FROM RALLY R INNER JOIN TRAMO T USING(codRally)
GROUP BY R.codRally

WRC 23. Para cada rally, muestra el nombre del rally junto con el número del tramo y los tiempos máximo y mínimo invertidos en dicho tramo, ordenados, dentro de cada rally, desde el menor al mayor tiempo mínimo invertido

SELECT R.nombre , C.numeroTramo, MAX(C.tiempo) AS MAX_TIEMPO, MIN(C.tiempo) AS MIN_TIEMPO
FROM RALLY R INNER JOIN CORRE C USING(codRally)
GROUP BY R.codRally, C.numeroTramo
ORDER BY MIN(C.tiempo) ASC, R.codRally ASC


WRC 24. Para cada rally, muestra el nombre del rally junto con el nombre de los pilotos que hayan corrido algún tramo de dicho rally y el tiempo total invertido por cada piloto en cada rally (sin restar la penalización) 

SELECT R.nombre, P.nombreP, SUM(C.tiempo)
FROM WRC.RALLY R INNER JOIN WRC.CORRE C USING(codRally) INNER JOIN WRC.PILOTO P USING(codPiloto)
GROUP BY R.nombre, P.nombreP
ORDER BY R.nombre

WRC 25. Muestra el nombre del piloto, el número de tramos completados y el total de kilómetros de cada piloto que ha corrido en el Rally de Montecarlo ordenados de mayor a menor kilometraje recorrido

SELECT P.nombreP, COUNT(numeroTramo) AS TramosCompleto, SUM(T.totalKms) AS KmsTotal
FROM RALLY R INNER JOIN CORRE C USING(codRally) INNER JOIN TRAMO T USING(codRally, numeroTramo) INNER JOIN PILOTO P USING(codPiloto)
WHERE R.nombre LIKE '%Montecarlo'
GROUP BY P.nombreP
ORDER BY KmsTotal DESC


WRC 26. Para cada rally cuyo total de kilómetros de recorrido sea mayor que 100, mostrar su código y su media de kilómetros

SELECT R.codRally, AVG(totalKms)
FROM WRC.RALLY R INNER JOIN WRC.TRAMO T ON(R.codRally = T.codRally)
GROUP BY R.codRally
HAVING SUM(totalKms) > 100


WRC 27. Muestra el nombre de los rallies junto con el número de tramos de cada uno de ellos, pero sólo aquellos rallies que tengan más de 2 tramos

SELECT R.nombre, COUNT(numeroTramo) AS NumTramos
FROM WRC.RALLY R INNER JOIN WRC.TRAMO T USING(codRally)
GROUP BY R.nombre
HAVING COUNT(numeroTramo) > 2

WRC 28. Muestra el nombre, grupo sanguíneo, rh y número de puntos del piloto que ha realizado más tramos de dificultad A 

SELECT P.nombreP, P.grupoS, P.rh, P.puntos
FROM WRC.PILOTO P INNER JOIN CORRE C USING(codPiloto) INNER JOIN TRAMO T USING(codRally)
WHERE T.dificultad='A'
GROUP BY P.nombreP
HAVING COUNT(numeroTramo) > (SELECT COUNT(numeroTramo)
                            FROM WRC.PILOTO PI INNER JOIN CORRE CO USING(codPiloto) INNER JOIN TRAMO TR USING(codRally)
                            WHERE P.codPiloto <> PI.codPiloto)

