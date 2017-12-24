/*
 * Copyright (C) 2014 Almudena García Jurado-Centurión
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

set serveroutput on;

create or replace
procedure hola(nombre varchar) is
begin
	dbms_output.put_line('Hola' || nombre);
end;


1.

	set serveroutput on;
	
	create
	function facturacion(telefono TELEFONO.numero%type, año INTEGER)
		return NUMBER;	
		numero_no_existe EXCEPTION;
		facturacion_minima EXCEPTION;		
		
		begin
			
		EXCEPTION
			WHEN numero_no_existe then 
				dbms_output.put_line('El numero ' || telefono || ' no existe en la base de datos');
				return -1;
			WHEN facturacion_minima then
				dbms_output.put_line('La facturacion de ' || telefono || ' es menor a 1 euro');
				return -1;
	end;


	select sum()
	from Telefono Tlf INNER JOIN Llamada L INNER JOIN Tarifa T
	where extract(year from fecha_hora)=año and numero=telefono
