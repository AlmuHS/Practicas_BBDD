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
 








