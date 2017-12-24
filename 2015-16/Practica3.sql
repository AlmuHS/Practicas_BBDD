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

﻿create or replace procedure penalizar(p_piloto IN PILOTO.nombreP%TYPE, p_rally IN RALLY.nombre%TYPE, p_penalizacion IN PARTICIPA.penalizacion%TYPE) IS

  existe_piloto INTEGER;
  no_existe_piloto EXCEPTION;
  existe_rally INTEGER;
  no_existe_rally EXCEPTION;
  
  CURSOR c_piloto IS
    SELECT P.nombreP, PA.penalizacion
    FROM RALLY R INNER JOIN PARTICIPA PA USING(codRally) INNER JOIN PILOTO P USING(codPiloto)
    WHERE R.nombre=p_rally;
      
  BEGIN

  SELECT COUNT(*) INTO existe_piloto
  FROM PILOTO P
  WHERE nombreP=p_piloto;
  
  IF existe_piloto = 0 THEN
    RAISE no_existe_piloto;
  END IF;
  
  SELECT COUNT(*) INTO existe_rally
  FROM RALLY R
  WHERE nombre=p_rally;
  
  IF existe_rally = 0 THEN
    RAISE no_existe_rally;
  END IF;
  
  dbms_output.put_line(' ' || p_rally || '  (Original)');
  dbms_output.put_line('------------------------------------');
  
  FOR r_piloto IN c_piloto LOOP
     dbms_output.put_line(r_piloto.nombreP || ' ' || c_piloto.penalizacion);
  END LOOP;
  
  
  EXCEPTION
    
    WHEN no_existe_rally then
      dbms_output.put_line('No existe el rally ' || p_rally);
      
    WHEN no_existe_piloto then
      dbms_output.put_line('No existe el piloto ' || p_piloto);            
END;
  
  
  
  
  
